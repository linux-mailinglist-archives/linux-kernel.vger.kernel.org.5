Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45F7EFB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjKQWJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQWJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:09:38 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2850B8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:09:35 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d645cfd238so1389007a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700258975; x=1700863775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiSGNQiY58h0LQFsDu9CHE6/vvGSghMl0TnoDbQc6jc=;
        b=lUpyFb2eFKfNcDyKSyksdJYgQggr6ve5NcVw8HjtgL+ZIswqV4bshaDbF8FqOiMNJO
         YPndEpfdTWXkTzilUDmfiSAjpVOdEwqcAD5Xe3B0XONzxNW5+cRSWK1pN7aNgK+dskeT
         GiFrdoE5NhPJ2ZVOLQTYs/KPDzV0wLc9SUbCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700258975; x=1700863775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiSGNQiY58h0LQFsDu9CHE6/vvGSghMl0TnoDbQc6jc=;
        b=KM/ca+IzrjapuXor1naAw447+nGDrWj9ccmlZk2U7ip0uRni8/di5+QXKKcW5OCG2X
         0tkrOy83i1hsrJg+7nTjgDxoubdqGiUjt9/UWMperNsjjzR37srmCNaoeO7e3B12b/os
         h8k0MsOB/RXb2bknxzgR2ya+8Zb+5GFBfK/HVLTeft/PU+Yjh2a5MmGTIcG2lVVwfGFm
         /JE2iWMbRuLGX1J3PtjVa0Oc+KBo8aqZnW/6rJMaA0f05rg1QedkJhQtx8D/I7C0GxGJ
         qMUwN5S3JdQmQmqea868FuRuV/CeFcxkS9byir3/7NQyWIZKZg8pocS+ngM6D+33SrqZ
         y8eg==
X-Gm-Message-State: AOJu0Yxt7orBlL0upe/gbonONGARSDFla36u+Rl+BDczpDWxxK3sv9BC
        pV/e4i8baY9WXC1/ko/w2hSsbmfywYN9tsd2wlQIqg==
X-Google-Smtp-Source: AGHT+IE1WL0A4FB3z3NP8LQZs3oHN76xjcRc0rEag6q+PtdV49d7lmD+su3O8vYYEMA28Fc3JfJ/GoVZJsJHvK38vjs=
X-Received: by 2002:a05:6830:1d51:b0:6d6:4972:b7ae with SMTP id
 p17-20020a0568301d5100b006d64972b7aemr539643oth.13.1700258975059; Fri, 17 Nov
 2023 14:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20231117215056.1883314-1-hsinyi@chromium.org> <20231117215056.1883314-3-hsinyi@chromium.org>
In-Reply-To: <20231117215056.1883314-3-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 17 Nov 2023 14:09:09 -0800
Message-ID: <CAJMQK-iBtNOeLBBsdKOHxN-A3i2eAuc78SYtr91kOHijFHOFLw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] drm/panel-edp: Add auo_b116xa3_mode
To:     Douglas Anderson <dianders@chromium.org>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 1:51=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Add auo_b116xa3_mode to override the original modes parsed from edid
> of the panels 0x405c B116XAK01.0 and 0x615c B116XAN06.1 which result
> in glitches on panel.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v6->v7: split usecase to another patch.

 -cc: stable

> ---
>  drivers/gpu/drm/panel/panel-edp.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 33535f6de343..3e144145a6bd 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -983,6 +983,19 @@ static const struct panel_desc auo_b101ean01 =3D {
>         },
>  };
>
> +static const struct drm_display_mode auo_b116xa3_mode =3D {
> +       .clock =3D 70589,
> +       .hdisplay =3D 1366,
> +       .hsync_start =3D 1366 + 40,
> +       .hsync_end =3D 1366 + 40 + 40,
> +       .htotal =3D 1366 + 40 + 40 + 32,
> +       .vdisplay =3D 768,
> +       .vsync_start =3D 768 + 10,
> +       .vsync_end =3D 768 + 10 + 12,
> +       .vtotal =3D 768 + 10 + 12 + 6,
> +       .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +};
> +
>  static const struct drm_display_mode auo_b116xak01_mode =3D {
>         .clock =3D 69300,
>         .hdisplay =3D 1366,
> @@ -1908,9 +1921,11 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116X=
AN06.1"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116X=
TN02.5"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140H=
AN04.0"),
> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B11=
6XAK01.0"),
> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B1=
16XAK01.0",
> +                        &auo_b116xa3_mode),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133U=
AN01.0"),
> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116X=
AN06.1"),
> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116=
XAN06.1",
> +                        &auo_b116xa3_mode),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116X=
AN06.3"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140H=
AK02.7"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133U=
AN01.0"),
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
