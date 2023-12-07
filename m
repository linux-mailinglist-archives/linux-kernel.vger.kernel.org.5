Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57D808FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443733AbjLGSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443688AbjLGSYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:24:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6610E7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:24:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50be3611794so1229028e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701973445; x=1702578245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1+mw4SiyS10BP2umvAUCHz7TwGmpLRvebGSA3Xe9k4=;
        b=XZ941p/SjFOaO3lVGgue/7S7nJW2yvszgpI3FslSQwOaJ08VrcCg/RCx3vElplbrp3
         I3uh/cnP3FA2BHLFJz2LoOO2RAo0FIEohCEPqrpkuuaP8TH/3CbdDIl4s4mwMuDd8+Ai
         UhA5k32WnC5EtGe92KHP+dQjfBlyMHZI+zmxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973445; x=1702578245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1+mw4SiyS10BP2umvAUCHz7TwGmpLRvebGSA3Xe9k4=;
        b=RnlCMW7r2yzeQNk8ge2ALTqOxm5Lzv9Xbmo2LiXvnWS79Oq+C0aFlLzop8b+RKU5xE
         HslSKXvB4AmMTSa3rSxgNcpnGUpA687Wl60pO9i5wqFKAMGymQEyDNXKa0r58yt+s9Nn
         peDfdw3YblX+PWtUjwu8Y+imutdPqQVZPGwy6lXtt3hLS9LqQYKbsp5SPqZLZ6MR5HYi
         G8poJyo/V8AWEobxHHhpInJsrfJ5rGHt3ddW7Z899Z0zrJTSif4hWM1Jp2CyWPs6yO9C
         CuQoJTEaMhjraW26OUSJAm0vVBr+mRlcm/+oSc/X68QAe9yxbMEsYl+1S3dBWd2LTKJN
         OvAQ==
X-Gm-Message-State: AOJu0YwDjJfrpkHOPBf7+H2QG+8IoOEJ4mU9tdGV8eYQ9QnS8qSnpcTF
        BcMaWnR290nd2/4v5rIcyfAfT357YxZ5P2OyCDVU/PwQ
X-Google-Smtp-Source: AGHT+IGHD6mDCDQtqzs4UdKi8sNQgBuqwlMUj8toy6bY8SIJsj3GPqlAyy3IQGgkg3fssYNhrcURvQ==
X-Received: by 2002:a05:6512:6cb:b0:50b:f71f:2cd4 with SMTP id u11-20020a05651206cb00b0050bf71f2cd4mr1893128lff.108.1701973445046;
        Thu, 07 Dec 2023 10:24:05 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id hw17-20020a170907a0d100b00a1e4892c8d5sm58223ejc.6.2023.12.07.10.24.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:24:04 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b422a274dso4815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:24:04 -0800 (PST)
X-Received: by 2002:a7b:c8d3:0:b0:3f7:3e85:36a with SMTP id
 f19-20020a7bc8d3000000b003f73e85036amr226433wml.7.1701973444086; Thu, 07 Dec
 2023 10:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20231207081801.4049075-1-treapking@chromium.org> <20231207081801.4049075-4-treapking@chromium.org>
In-Reply-To: <20231207081801.4049075-4-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Dec 2023 10:23:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U8hN=vfXRggRZgL7dPtv1ptn_vxgTChvzBJGx+mbFaVQ@mail.gmail.com>
Message-ID: <CAD=FV=U8hN=vfXRggRZgL7dPtv1ptn_vxgTChvzBJGx+mbFaVQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/edp-panel: Add panels delay entries
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 7, 2023 at 12:18=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Add panels used by Mediatek MT8173 Chromebooks.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/panel/panel-edp.c | 39 +++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
