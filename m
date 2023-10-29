Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15E7DB0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjJ2XWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJ2XVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:21:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F19A4DEC8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:14:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da30fd994fdso377096276.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698621262; x=1699226062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cfT7M+XFws6jegaIJENojPFMwrM4xsKs+9gQT0OetLY=;
        b=W8gQh3OTbn36Env2I1PeImYdVyPnHOVZ2JPIbVGEBE76ZcdIdDCNnoC9sTJL35ASII
         FEFYpoVSuGZWwXyUUC7oDKks60E0MW2Kx7BHY2BYFFREdTM/zxMOXNJISbwODV2YKeiO
         7trf3etl5QBrMndlNK1OK9CHpvLL9ZPVOAM66Gq4XqWqpR6quAH5578nO2N2RJbBOAk8
         V8PB32B21ki83BIbbM8z+bKZz6892DP8NZXYgN3OUbEo9NJL00rJVA0Af+hiDh9feTR1
         ggwEH++vH0lTkuOhqhx14iOIlrlWf2ngP+OA1OOg+6NaVEUcZ03WlAcO7IQDZF06LfSB
         anaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698621262; x=1699226062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfT7M+XFws6jegaIJENojPFMwrM4xsKs+9gQT0OetLY=;
        b=bhlVQWEaYnT3vKRe6pD95Xe6jYfO53TCo356BRASI0kTYXm4/5GT54IRighFPbOdVB
         /6Yx07/GbC+9xuGEErkuN8gwtPjojl7zDHpzfFD0lUOzyOwXe/rnt9UsdHmvES+KAGLj
         CMwfBSxjdpgH/Yq3+oEpvIBrQgYhju83SMZ2BwvSB9vAZ6XarN0NdLMjBkknWpyk6nYx
         J06LuGh+Iq2nthFDlGLtJbc1c99GEwScBVDeUy/8iydpxcj9WJ3bdpRF6IaG2PF/qXEy
         ioatM6WidJDaSRyfMM6LxDEr28p5bAGJ1rpQJ+W+ak+4VX2wMpTXHeyp+Zx/JqCdsYJP
         lUoA==
X-Gm-Message-State: AOJu0Yy1Q9xHZEg/gEJJEzfxHMkcL2huz312C+PoCBymWwvQZFdEaA0r
        SolIqk26kt52jnuBPMrgrrSS8tf6rFCNyyzjCWQqSw==
X-Google-Smtp-Source: AGHT+IGcLYRvM8RoCdUPa0wuAgHy6VCgMBpzw2o42FX9eKC49rbjusOn1BXMR2qidE8sVYIYLZ3DiLkCQDgee9VkuVg=
X-Received: by 2002:a25:f05:0:b0:d9b:c81a:ba7 with SMTP id 5-20020a250f05000000b00d9bc81a0ba7mr13981173ybp.20.1698621262071;
 Sun, 29 Oct 2023 16:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231029194607.379459-1-suijingfeng@loongson.cn> <20231029194607.379459-5-suijingfeng@loongson.cn>
In-Reply-To: <20231029194607.379459-5-suijingfeng@loongson.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 30 Oct 2023 01:14:11 +0200
Message-ID: <CAA8EJprjRWVTgq4gr8p7ksFkoeKt3CxfhjyMZVDx4aS9FqgbcA@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/loongson: Started to attach display bridge driver
 for LS7A1000
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 at 21:46, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>
> Loongson ML5B_MA board using ITE IT66121 HDMI transmitter to support HDMI
> display output, with the vbios provided the necessary information, we are
> able to create a minimal drm bridge driver for it. After apply this patch
> we are able to change mode freely.

Please see the Documentation/process/submitting-patches.rst:

Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

>
> Tested on LS3A5000+LS7A1000 ML5B_MA board.
>
> $ dmesg | grep drm
>
>  [drm] dc: 264MHz, gmc: 529MHz, gpu: 529MHz
>  [drm] Dedicated vram start: 0xe0030000000, size: 64MiB
>  [drm] Loongson VBIOS version: 0.3
>  [drm] Loongson VBIOS: has 8 DCBs
>  [drm] VRAM: 4096 pages ready
>  [drm] GTT: 32768 pages ready
>  [drm] lsdc-i2c0(sda pin mask=1, scl pin mask=2) created
>  [drm] lsdc-i2c1(sda pin mask=4, scl pin mask=8) created
>  [drm] DisplayPipe-0 has DVO-0
>  [drm] device address(0x4d) is not correct
>  [drm] i2c client IT66121@0x4c created
>  [drm] IT66121 attached, Vendor ID: 0x4954, Device ID: 0x612
>  [drm] Total 2 outputs
>  [drm] registered irq: 40
>  [drm] Initialized loongson 1.0.0 20220701 for 0000:00:06.1 on minor 0
>  loongson 0000:00:06.1: [drm] fb0: loongsondrmfb frame buffer device
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/loongson/lsdc_output_7a1000.c | 144 +++++++-----------
>  1 file changed, 55 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a1000.c b/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
> index 6fc8dd1c7d9a..e12f9a0157d0 100644
> --- a/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
> +++ b/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
> @@ -10,6 +10,7 @@
>  #include "lsdc_drv.h"
>  #include "lsdc_output.h"
>
> +#include "ite_it66121.h"
>  /*
>   * The display controller in the LS7A1000 exports two DVO interfaces, thus
>   * external encoder is required, except connected to the DPI panel directly.
> @@ -38,68 +39,6 @@
>   *  TODO: Add support for non-transparent encoders
>   */
>
> -static int ls7a1000_dpi_connector_get_modes(struct drm_connector *conn)
> -{
> -       unsigned int num = 0;
> -       struct edid *edid;
> -
> -       if (conn->ddc) {
> -               edid = drm_get_edid(conn, conn->ddc);
> -               if (edid) {
> -                       drm_connector_update_edid_property(conn, edid);
> -                       num = drm_add_edid_modes(conn, edid);
> -                       kfree(edid);
> -               }
> -
> -               return num;
> -       }
> -
> -       num = drm_add_modes_noedid(conn, 1920, 1200);
> -
> -       drm_set_preferred_mode(conn, 1024, 768);
> -
> -       return num;
> -}
> -
> -static struct drm_encoder *
> -ls7a1000_dpi_connector_get_best_encoder(struct drm_connector *connector,
> -                                       struct drm_atomic_state *state)
> -{
> -       struct lsdc_output *output = connector_to_lsdc_output(connector);
> -
> -       return &output->encoder;
> -}
> -
> -static const struct drm_connector_helper_funcs
> -ls7a1000_dpi_connector_helpers = {
> -       .atomic_best_encoder = ls7a1000_dpi_connector_get_best_encoder,
> -       .get_modes = ls7a1000_dpi_connector_get_modes,
> -};
> -
> -static enum drm_connector_status
> -ls7a1000_dpi_connector_detect(struct drm_connector *connector, bool force)
> -{
> -       struct i2c_adapter *ddc = connector->ddc;
> -
> -       if (ddc) {
> -               if (drm_probe_ddc(ddc))
> -                       return connector_status_connected;
> -
> -               return connector_status_disconnected;
> -       }
> -
> -       return connector_status_unknown;
> -}
> -
> -static const struct drm_connector_funcs ls7a1000_dpi_connector_funcs = {
> -       .detect = ls7a1000_dpi_connector_detect,
> -       .fill_modes = drm_helper_probe_single_connector_modes,
> -       .destroy = drm_connector_cleanup,
> -       .reset = drm_atomic_helper_connector_reset,
> -       .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state
> -};
> -
>  static void ls7a1000_pipe0_encoder_reset(struct drm_encoder *encoder)
>  {
>         struct drm_device *ddev = encoder->dev;
> @@ -139,40 +78,67 @@ static const struct drm_encoder_funcs ls7a1000_encoder_funcs[2] = {
>         },
>  };
>
> +/*
> + * This is a default output description for LS7A1000/LS2K1000, this is always
> + * true from the hardware perspective. It is just that when there are external
> + * display bridge connected, this description no longer complete. As it cannot
> + * describe the topology about the external encoders.
> + */
> +static const struct lsdc_output_desc ls7a1000_output_desc[2] = {
> +       {
> +               .pipe = 0,
> +               .encoder_type = DRM_MODE_ENCODER_DPI,
> +               .connector_type = DRM_MODE_CONNECTOR_DPI,
> +               .encoder_funcs = &ls7a1000_encoder_funcs[0],
> +               .encoder_helper_funcs = &lsdc_encoder_helper_funcs,
> +               .connector_funcs = &lsdc_connector_funcs,
> +               .connector_helper_funcs = &lsdc_connector_helper_funcs,
> +               .name = "DVO-0",
> +       },
> +       {
> +               .pipe = 1,
> +               .encoder_type = DRM_MODE_ENCODER_DPI,
> +               .connector_type = DRM_MODE_CONNECTOR_DPI,
> +               .encoder_funcs = &ls7a1000_encoder_funcs[1],
> +               .encoder_helper_funcs = &lsdc_encoder_helper_funcs,
> +               .connector_funcs = &lsdc_connector_funcs,
> +               .connector_helper_funcs = &lsdc_connector_helper_funcs,
> +               .name = "DVO-1",
> +       },
> +};
> +
>  int ls7a1000_output_init(struct drm_device *ddev,
>                          struct lsdc_display_pipe *dispipe,
>                          struct i2c_adapter *ddc,
>                          unsigned int index)
>  {
>         struct lsdc_output *output = &dispipe->output;
> -       struct drm_encoder *encoder = &output->encoder;
> -       struct drm_connector *connector = &output->connector;
> -       int ret;
> -
> -       ret = drm_encoder_init(ddev, encoder, &ls7a1000_encoder_funcs[index],
> -                              DRM_MODE_ENCODER_TMDS, "encoder-%u", index);
> -       if (ret)
> -               return ret;
> -
> -       encoder->possible_crtcs = BIT(index);
> -
> -       ret = drm_connector_init_with_ddc(ddev, connector,
> -                                         &ls7a1000_dpi_connector_funcs,
> -                                         DRM_MODE_CONNECTOR_DPI, ddc);
> -       if (ret)
> -               return ret;
> -
> -       drm_info(ddev, "display pipe-%u has a DVO\n", index);
> -
> -       drm_connector_helper_add(connector, &ls7a1000_dpi_connector_helpers);
> -
> -       drm_connector_attach_encoder(connector, encoder);
> +       enum loongson_vbios_encoder_name encoder_name = 0;
> +       struct drm_bridge *bridge = NULL;
> +       u8 slave_addr;
> +       bool ret;
> +
> +       output->descp = &ls7a1000_output_desc[index];
> +
> +       ret = loongson_vbios_query_encoder_info(ddev, index, NULL,
> +                                               &encoder_name, &slave_addr);
> +       if (!ret)
> +               goto skip;
> +
> +       switch (encoder_name) {
> +       case ENCODER_CHIP_IT66121:
> +               bridge = it66121_bridge_create(ddev, ddc, slave_addr, false,
> +                                              0, index);

No. You have a fancy interface describing connected devices. Could you
please use the infrastructure that already exists for you. For i2c
devices you have to create an i2c device on a corresponding i2c bus.
See drivers/i2c/i2c-core-of.c for inspiration.

> +               break;
> +       default:
> +               break;
> +       }
>
> -       connector->polled = DRM_CONNECTOR_POLL_CONNECT |
> -                           DRM_CONNECTOR_POLL_DISCONNECT;
> +       if (IS_ERR(bridge))
> +               goto skip;
>
> -       connector->interlace_allowed = 0;
> -       connector->doublescan_allowed = 0;
> +       output->bridge = bridge;
>
> -       return 0;
> +skip:
> +       return lsdc_output_init(ddev, dispipe, ddc, index);
>  }
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
