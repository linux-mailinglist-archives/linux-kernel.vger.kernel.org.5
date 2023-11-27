Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52057FAD83
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjK0WeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjK0WeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:34:10 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14051A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:34:16 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cc69df1b9aso44911327b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701124455; x=1701729255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vGzcsQmOQggKxvH47Tmuwqz8+t2HhA4WbAiv2DPY8Y=;
        b=Tup13n66O9ybNB8tN3x5gGXIu7nvBtq3nAYgj9xR8bjjQJCxmG9Q38Tr5xqhaAZHQZ
         nVtCsPOVRd7TzceyX80w/H+riMTnXMk/PcE5Mgvvw8AXV1j6rwOvMjchP6sNvbc/OlaX
         lRdxu+KEYgg/EAqUwezXN7lk9QyxnEobDdGVzlYpAJhcpOvM3BtxwdPcDI5Oua7EPnkf
         j0GQWA7tXyLMfQKPukALS/6A9lUaRXfNHOPtt7fINpBBiGbX56XJvSzqCGuNler8pkzU
         OlEZAEM6IxP3th9koqTkifCoG0bh/Jc+cjqonm+k2Mu8vCSl7wyx1DCtMqdhMeZklh6b
         y5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701124455; x=1701729255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vGzcsQmOQggKxvH47Tmuwqz8+t2HhA4WbAiv2DPY8Y=;
        b=TlNtt4DvgF9nex468eOf2K/pNZ4L+qdKrMQ251KpIfM7t1xjh5lZs2qwROPZwGwoew
         xsXxDgtmLKcImnsQOesjb2vr/0bIZcS6qG3GIcRJYHhORI9iFivbizcpZTMcyENS6esu
         tlmMAF83nR3oz6wgoq2ebS1He6Nh4aBWi9OUlXfbxxqtgnoyfIZAoN6QmnbrcCi1lCcn
         KF16FSgoRVi1a2DqHaLEYtOZd/nksTe1HWCX9cBj7zVCe5Px5ymL8tTCGfnEw2RfMFBm
         vV43WMUqc2yWwVc336kTkYDAOU0fVxtijXGI4QlgAhGwb9irs8EIQ3Jd7t/DxFoX+7Dw
         2G9w==
X-Gm-Message-State: AOJu0YxwKKw7Z/cwNuCegEogdKa0ndThHdDtcu/68plchd9vyh1GcOTu
        5o+75RTsb7JKcjWWXV9hwR4JHDZRmQs6UnqjExUepw==
X-Google-Smtp-Source: AGHT+IEYWPEuZyZ69QjYMb0/vc3v6nEVmOOn24SzLtwWBbFeT4Ij5VfP4VJMQXY3IVaHPqBsT/A9Cy+DjHMdZR5nfa4=
X-Received: by 2002:a81:ac5b:0:b0:5d0:b0e7:929e with SMTP id
 z27-20020a81ac5b000000b005d0b0e7929emr3605101ywj.42.1701124455238; Mon, 27
 Nov 2023 14:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20231127051414.3783108-1-victor.liu@nxp.com> <20231127051414.3783108-2-victor.liu@nxp.com>
 <v6rthnruba5xaxazsn4jsptn6catso5qwuyf5xxbf4ml25b6eo@snttjo7oqlod> <2023112739-willing-sighing-6bdd@gregkh>
In-Reply-To: <2023112739-willing-sighing-6bdd@gregkh>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Nov 2023 23:34:00 +0100
Message-ID: <CACRpkdbZvUMy7PzqnPSsM+SmMv5Z0mnVq_GU9_9HbBWXkg21zA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: Export device_is_dependent() to modules
To:     Greg KH <gregkh@linuxfoundation.org>, Liu Ying <victor.liu@nxp.com>
Cc:     Maxime Ripard <mripard@kernel.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 7:20=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:

[Maxime]
> > So, a committer just applied this to drm-misc-fixes without your
> > approval.

That was me, mea culpa.
I learned a lesson. Or two.

> Wait, why exactly is this needed?  Nothing outside of the driver core
> should be needing this function, it shouldn't be public at all (I missed
> that before.)
>
> So please, revert it for now, let's figure out why DRM thinks this is
> needed for it's devices, and yet no other bus/subsystem does.

I'm preparing a revert series back to the original patch causing
the issue so we can clear the original bug out of the way, take
a step back and fix this properly.

Yours,
Linus Walleij
