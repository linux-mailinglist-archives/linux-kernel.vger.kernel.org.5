Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C67E84FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbjKJVKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKJVKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:10:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E2BBC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 13:10:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40837124e1cso14525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 13:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699650604; x=1700255404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE+/jbgSi664HD8BrCmT+2A639BdbZR0PFQ8SEUbr8E=;
        b=Vyq+5cJvhSEyd08pQn3CN5+m6OQtH+vqHBRso0kqBux+67Wo6j8AyPOSwsq6bVkKhu
         q5Dm5gMor/wiqn5TFv7aAfQbnIEV3qFqElRe6GRgnL2CPeLWC/T/L5JcQUveqki21h5P
         WB0xvP1+EHe8kQcdgbSgABNpCZYItr1rLmm0Ea7YuU2XgnwgfLTDwSSmfabUBbujvKOt
         3uztYidvXik3SjSGoZmHFdDTTiqnMCrs+mqh+yp/LMvZt/pKnDpNGJL8lpcLk6Zm41Vz
         DAHB4z+Ul2Kvnlj8atwY9T2ahbLW2eLF61+LgcmV465RZ4XA2tBc+uFAjLTf2rmiH49H
         ApGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699650604; x=1700255404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE+/jbgSi664HD8BrCmT+2A639BdbZR0PFQ8SEUbr8E=;
        b=jnMJVoLAdV+4CvjoS1zf5igKOMjYGb1rQuGksFDWvfenMs03TKr1U4OTQOjXREPOYa
         fQcpLXaFU8KKvQE4qVfUk28hbwXDoP+8inCPzmE/MqmYul4dcXBtkF8ZAl41gkfQNn9E
         rhNyJd3xl2TVXG+hYI4MDyd7H8uqk71FF6VRBbiNbLGR/188PYnZ/No8xE+E5ChcL36T
         T/yIvxsgamqYwso39qJEnf4gkx0gL3o/TZctYDvOUDP1VNr4mpdrz6mtnNDIXgTtnobe
         hNChw9Mw9YJxj/6DXChqDEBtQCQApGoVI7gfx+SdrXxXLhWFdv3rXT3EAlQaaVvJHoVg
         GlXg==
X-Gm-Message-State: AOJu0Yz8erKdOaISzjF5FYL7dJufijyP3aXwe5UoLNfak83xCqJQLhCO
        DNhHY/E9tqGqy5l9HGrMJ/7vqPfyFo8o/QpwB5W3Sg==
X-Google-Smtp-Source: AGHT+IEed6ru5XI2tGdQUHFtZARACGAfGFOcCru3M+E5sMSccnmdruAaJQRKVBsgXLem9FOe09lBfdh00h+15HeH9/0=
X-Received: by 2002:a05:600c:3b9b:b0:408:3725:b96a with SMTP id
 n27-20020a05600c3b9b00b004083725b96amr9766wms.0.1699650603630; Fri, 10 Nov
 2023 13:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20231110094553.2361842-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231110094553.2361842-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 10 Nov 2023 13:09:46 -0800
Message-ID: <CAD=FV=UvZ9U1SYjOOBB6o2CmquAevqJZ9Ukp_kx4zGXFbp_VBA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
 panel HFP and HBP
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, airlied@gmail.com, zhouruihai@huaqin.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 10, 2023 at 1:46=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The refresh reported by modotest is 60.46Hz, and the actual measurement

s/modotets/modetest/

> is 60.01Hz, which is outside the expected tolerance. Adjust hporch and
> pixel clock to fix it. After repair, modetest and actual measurement were
> all 60.01Hz.

Can you explain this more? Why was the rate that modetest reported
different from the actual measured rate? This feels like it's a
problem with your MIPI controller not being able to accurately make
the rate. Is that it?

If so then this is a bit of a hack. Someone else using the same panel
might have a MIPI controller that can make slightly different clock
rates. I think you're currently the only user of the panel, so maybe
this isn't too terrible (would love to hear other people's advice).

Assuming this is actually the problem there are probably at least
several different ways to solve this. One that comes to mind is the
solution we ended up with for eDP where we allowed specifying some of
this stuff in the device tree, though that might cause a whole pile of
debates...

In any case, as I said above this patch is probably OK if you're the
only user of this panel, but it might be at least good to add
something to the commit message?

-Doug
