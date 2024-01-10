Return-Path: <linux-kernel+bounces-22890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554D82A4FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A508E1F25CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797A74F8A3;
	Wed, 10 Jan 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNiLLEb8"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E133F9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ed10316e22so44149687b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704929946; x=1705534746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv5xXL6A+2J+1KA1k07jEHKx6VrItsmSJjrNVSwQV2Q=;
        b=MNiLLEb89MjDv+SlIesiLEhemSSr2QymW4D/gBkE5J66QjseJehWY8jZUYhqhT8CJf
         t2R7OSMAowPqkks8Se4mw8pA8h6Y35urXpznNw5WsYfVxaDmP4Ch/9OumbAxbtGUgCoX
         96YUe04MaMjUyrizhMG8XZW1CcpWpEv4/fddTmBJT7oqdGvOLlyYVkR258lytQLnFFuy
         FAHnkaVaspkUyAI7IerojQXJe/EhlBVRlv4MZjrbY/LB3K132B3lxtdmhQYxTVt6xWZa
         tMca2hqabrdUFnKO4SrXmzy3LmTRUeCMj82jmC8q7/M+GEpK9j0fZPRKTlCyvqT+ehnJ
         8m5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704929946; x=1705534746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qv5xXL6A+2J+1KA1k07jEHKx6VrItsmSJjrNVSwQV2Q=;
        b=Np9KfNXQyNSM6ePWVXWMmQOkBI2a6ry7oGnRAWh6XEUSaqV1mJaSEt0JQlQ9PieGYI
         L/wYHmMy/OWH+0vRv7DrZ1z8XlwoOwe9jEz+U6QLJi7esWMZat2Uq5i0Kg3SWHCBmw27
         XrivOK3tug+Wdj0ynE565W+uuNBIvpcsozJ/XnODiz9JypX0iUoD7fV9Y92KeAFfjJIG
         MQFZpbkYz6KD/Na0/z/orPrJbmjM0I8ggKlA1PpLmMV7l10U3vq0JT14o3aLt10cZWd9
         Bbw5fOdxqwjajyEUnKfevTWTHiyfhmnL+0SGxVH7l91MoMO112R1T7zOvuNnyi1MAXbB
         OtrA==
X-Gm-Message-State: AOJu0Yz7kURyTXZ7TWsOnHcU4szjLT0m0IYAkBhHZY8wbUk5LZEFcDV7
	RvouSgbIy9XZN0/996rjGMS+DlZX5903T5YAZmMg7jANLZEbsQ==
X-Google-Smtp-Source: AGHT+IELbhs6J/vYJKH6p9upru1FLiSNRZUYT+IjljI5i3mV9Lgk53N2Nt8oekCONRvnRPwD07Z7MNCLhbwBqWQFrCE=
X-Received: by 2002:a81:ee04:0:b0:5f8:f50e:bd36 with SMTP id
 l4-20020a81ee04000000b005f8f50ebd36mr347845ywm.96.1704929945816; Wed, 10 Jan
 2024 15:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704917888-30039-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1704917888-30039-1-git-send-email-quic_khsieh@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Jan 2024 01:38:54 +0200
Message-ID: <CAA8EJprkotYgo8je2+N=aZGxEReHgLR_rooKQBOWqRn+dgKtSQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm/dp: correct configure Colorimetry Indicator
 Field at MISC0
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	swboyd@chromium.org, dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch, 
	airlied@gmail.com, agross@kernel.org, andersson@kernel.org, 
	quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, 
	quic_sbillaka@quicinc.com, marijn.suijten@somainline.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 22:18, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> MSA MISC0 bit 1 to 7 contains Colorimetry Indicator Field. At current
> implementation, Colorimetry Indicator Field of MISC0 is not configured
> correctly. This patch add support of RGB formats Colorimetry.

https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

Also the commit message doesn't provide any details or what was incorrect.

>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c  |  5 ++--
>  drivers/gpu/drm/msm/dp/dp_link.c  | 26 ++++++++++++++++-----
>  drivers/gpu/drm/msm/dp/dp_panel.c | 48 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
>  4 files changed, 73 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 77a8d93..2ef89fb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2012-2023, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved
>   */
>
>  #define pr_fmt(fmt)    "[drm-dp] %s: " fmt, __func__
> @@ -172,7 +173,7 @@ static void dp_ctrl_configure_source_params(struct dp_ctrl_private *ctrl)
>
>         tb = dp_link_get_test_bits_depth(ctrl->link,
>                 ctrl->panel->dp_mode.bpp);
> -       cc = dp_link_get_colorimetry_config(ctrl->link);
> +       cc = dp_panel_get_misc_colorimetry_val(ctrl->panel);
>         dp_catalog_ctrl_config_misc(ctrl->catalog, cc, tb);
>         dp_panel_timing_cfg(ctrl->panel);
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> index 98427d4..21fa1a2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved
>   */
>
>  #define pr_fmt(fmt)    "[drm-dp] %s: " fmt, __func__
> @@ -12,6 +13,11 @@
>
>  #define DP_TEST_REQUEST_MASK           0x7F
>
> +enum dynamic_range {
> +       DP_DYNAMIC_RANGE_RGB_VESA,
> +       DP_DYNAMIC_RANGE_RGB_CEA,
> +};
> +
>  enum audio_sample_rate {
>         AUDIO_SAMPLE_RATE_32_KHZ        = 0x00,
>         AUDIO_SAMPLE_RATE_44_1_KHZ      = 0x01,
> @@ -1083,6 +1089,7 @@ int dp_link_process_request(struct dp_link *dp_link)
>  int dp_link_get_colorimetry_config(struct dp_link *dp_link)
>  {
>         u32 cc;
> +       enum dynamic_range dr;
>         struct dp_link_private *link;
>
>         if (!dp_link) {
> @@ -1092,14 +1099,21 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
>
>         link = container_of(dp_link, struct dp_link_private, dp_link);
>
> -       /*
> -        * Unless a video pattern CTS test is ongoing, use RGB_VESA
> -        * Only RGB_VESA and RGB_CEA supported for now
> -        */
> +       /* unless a video pattern CTS test is ongoing, use CEA_VESA */
>         if (dp_link_is_video_pattern_requested(link))
> -               cc = link->dp_link.test_video.test_dyn_range;
> +               dr = link->dp_link.test_video.test_dyn_range;

test_dyn_range has the value of (dpcd[DP_TEST_MISC0] &
DP_TEST_DYNAMIC_RANGE_CEA), so it can not be assigned to dr.

I don't feel like this has been tested.

>         else
> -               cc = DP_TEST_DYNAMIC_RANGE_VESA;
> +               dr = DP_DYNAMIC_RANGE_RGB_VESA;
> +
> +       /* Only RGB_VESA and RGB_CEA supported for now */
> +       switch (dr) {
> +       case DP_DYNAMIC_RANGE_RGB_CEA:
> +               cc = BIT(2);

No undefined magic, please.

> +               break;
> +       case DP_DYNAMIC_RANGE_RGB_VESA:
> +       default:
> +               cc = 0;
> +       }
>
>         return cc;
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 127f6af..785bb59 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved
>   */
>
>  #include "dp_panel.h"
> @@ -386,6 +387,53 @@ int dp_panel_init_panel_info(struct dp_panel *dp_panel)
>         return 0;
>  }
>
> +/*
> + * Mapper function which outputs colorimetry to be used for a
> + * given colorspace value when misc field of MSA is used to
> + * change the colorimetry. Currently only RGB formats have been
> + * added. This API will be extended to YUV once it's supported on DP.
> + */
> +u8 dp_panel_get_misc_colorimetry_val(struct dp_panel *dp_panel)
> +{
> +       u8 colorimetry;
> +       u32 colorspace;
> +       u32 cc;
> +       struct dp_panel_private *panel;
> +
> +       panel = container_of(dp_panel, struct dp_panel_private, dp_panel);
> +
> +       cc = dp_link_get_colorimetry_config(panel->link);
> +       /*
> +        * If there is a non-zero value then compliance test-case
> +        * is going on, otherwise we can honor the colorspace setting
> +        */
> +       if (cc)
> +               return cc;
> +
> +       colorspace = dp_panel->connector->state->colorspace;

The driver doesn't attach the colorspace property, so this part is
useless. Anyway, I think adding colorimetry support will require more
changes than just setting the register in the DisplayPort controller.

> +       drm_dbg_dp(panel->drm_dev, "colorspace=%d\n", colorspace);
> +
> +       switch (colorspace) {
> +       case DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
> +       case DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
> +               colorimetry = 0x7;
> +               break;
> +       case DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED:
> +               colorimetry = 0x3;
> +               break;
> +       case DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT:
> +               colorimetry = 0xb;
> +               break;
> +       case DRM_MODE_COLORIMETRY_OPRGB:
> +               colorimetry = 0xc;

Please define these magic values.

> +               break;
> +       default:
> +               colorimetry = 0;        /* legacy RGB mode */
> +       }
> +
> +       return colorimetry;
> +}
> +
>  struct dp_panel *dp_panel_get(struct dp_panel_in *in)
>  {
>         struct dp_panel_private *panel;
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> index a0dfc57..c34a51d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved
>   */
>
>  #ifndef _DP_PANEL_H_
> @@ -65,6 +66,7 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
>                 struct drm_connector *connector);
>  void dp_panel_handle_sink_request(struct dp_panel *dp_panel);
>  void dp_panel_tpg_config(struct dp_panel *dp_panel, bool enable);
> +u8 dp_panel_get_misc_colorimetry_val(struct dp_panel *dp_panel);
>
>  /**
>   * is_link_rate_valid() - validates the link rate
> --
> 2.7.4
>


-- 
With best wishes
Dmitry

