Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C1803AB0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjLDQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjLDQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:47:03 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E524182
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:47:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a19ce1404e1so445461466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701708421; x=1702313221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FveOruljDBZv6z+kbcKooVAiVbTn3vv2Y/JHOYB/pNg=;
        b=UMWrlhdYGSNF03IpWJYP3no39/8MWucHcIrUkKLOaZwlYZpc5nzGL2rlrxrTBplEaL
         zQGPGT0ZbKJyfDhAb/QW/V9kmyrfJBG/YcyzcefenWr5yS351dCge4MUOXsqSnPgBfGW
         6K+zRYLCG93YutSMl3CKiaLCmt9N5645ZlE5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708421; x=1702313221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FveOruljDBZv6z+kbcKooVAiVbTn3vv2Y/JHOYB/pNg=;
        b=HBM9D0YO4v3MfN4BU93UB7GXs0Ww07iE4GlJHaCaVgt3YDAxgSfV7n/fZ1gMhABF7a
         LM7jgsfia2kdlwCXEBmMWxR0lP+UtirLreaaws76kX/OJM3eQlhGsNxA70PZDmHz5X5o
         Efyol6jAOwAYO5MzsE1eR5Hzlzjy/xOhuYsgctGsGyFdnbBn2ezKBdU61WKOR+280cMK
         ZBKHslIXxNTg22pqsXdNtDUdDDhFaIWLlpJeFmzwkVMe0V5kMF9gn3Q6Xkzw0ZnPHbv9
         Cqba7FDyLBa4pYKvsAyy5tbxtI8xTiXnQsiCHZCWC0jKVdrus5G4grjLcgtekaP26xhN
         jiEA==
X-Gm-Message-State: AOJu0YxTf8G1w8bgeCFOXzVxyrZV2a6wJfJ0Sr/o41JJpW8up4cAMtBC
        rKxFUq0nT/NACgaVt2y7o1n/6QnzwMAviwZu7vNrtUVF
X-Google-Smtp-Source: AGHT+IFrWBu/WBm8vdFwVoIf0Q/PWEpOqDLyK29JMhL13qbCfqM0mgcBDqearNgdB8HPqmXj9cCThQ==
X-Received: by 2002:a17:906:3488:b0:a19:a1ba:da71 with SMTP id g8-20020a170906348800b00a19a1bada71mr3594063ejb.152.1701708421262;
        Mon, 04 Dec 2023 08:47:01 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709062b0700b009fc8f309183sm5479147ejg.51.2023.12.04.08.47.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:47:00 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so100655e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:47:00 -0800 (PST)
X-Received: by 2002:a05:600c:257:b0:40b:4228:ee9a with SMTP id
 23-20020a05600c025700b0040b4228ee9amr482510wmj.0.1701708419762; Mon, 04 Dec
 2023 08:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20231201-x1e80100-drm-panel-edp-v2-1-b0173484631a@linaro.org>
In-Reply-To: <20231201-x1e80100-drm-panel-edp-v2-1-b0173484631a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 Dec 2023 08:46:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wx_W-Jspx4S4k-Jze8eBm5zGanzqt0-fWjYZhHB_=1qQ@mail.gmail.com>
Message-ID: <CAD=FV=Wx_W-Jspx4S4k-Jze8eBm5zGanzqt0-fWjYZhHB_=1qQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add SDC ATNA45AF01
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 4, 2023 at 12:54=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> Add support for the SDC ATNA45AF01 panel.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - moved the panel entry in the proper place, as suggested by Doug
> - Link to v1: https://lore.kernel.org/r/20231201-x1e80100-drm-panel-edp-v=
1-1-ef9def711d8a@linaro.org
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 825fa2a0d8a5..78565c99b54d 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1983,6 +1983,8 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116=
N2930A15"),
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "1=
16N29-30NK-C007"),
>
> +       EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA=
45AF01"),
> +

Looks fine to me now. I will note that e200 is pretty long and I
wonder if you've got this because of a requirement of T3+T4+T5+T6+T8
being more than 200ms. If so, I wonder if Pin-yen's patch [1] would
help you optimize things?

In any case, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...I'll wait a day in case you say this would be better atop Pin-yen's
patch and want me to wait, but I also have no objections to landing
this now and later optimizing the delays.

[1] https://crrev.com/c/5052150
