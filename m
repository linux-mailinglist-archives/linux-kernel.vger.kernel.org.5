Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B97772CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjHGRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjHGRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:23:50 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23EE67
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:23:48 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bf08ca187cso3532258fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429027; x=1692033827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnSUl1DSZr5Fls6ZOpvWGsqmImbGUDT7mTUl9oquTSs=;
        b=cC64se7BOTXW8iN4bttq/0ZioKeGOfYwXCHPFF4BDg0bC1qSuGMzUIlfe1iDbiED9e
         k2ycA/RfdVCWN7ljdaaDN2ecFOF1jf0jXxB4df8BcmNPMqIV2EOp7wyW5T+NJ6vlkNKi
         G1XwTfr32I0mUnzoregb6SpbkIgtuHr6l595IAEtDySDIbjkvOHyREuT8rykA1VyXQgw
         dZv8mNwtX/Z284T5mTH18PSbjqjLkRK5eqB9aGPf0wlXzFnOhdRxRrHZD2JEW/aTYe91
         SOyYcXBWD1AkbuBMHtNgZR5KDmqv1UOI1YKqag1hCV6j7uIs8mXqLff1Olsj/6Ai0ztM
         gnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429027; x=1692033827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnSUl1DSZr5Fls6ZOpvWGsqmImbGUDT7mTUl9oquTSs=;
        b=O55qLpxO1VyEU347vCSOVgRpr52TioH6kX6e2ZX/73vGo6Citf0tZBrm+sDUtmUqFJ
         zP0O0ZqxO7d5tgKfAf3A7mt2XQrsZmT1PifVl2pzZ5tyWJtGm+ykSilF93lhBjidLbol
         N/CUIkR0qLmydDhCYNtI6Sw2o4H6T+1k4Nx6DJ8k7q5P72LPttmb0Ag3ymYvz80dnUpm
         dS2CNKcH/1yT3L9D99QcJxi9fpWMviI8WNsxcDgD15eikCPiFnXGxVJOrnauskHNClL9
         Xw+0ZNzs8gzc8KXJD74X/t5yf8ZsO4TyY9nHtbJTkkliyCFSs5eYYL1C+jeQQfSU5GRW
         9N6Q==
X-Gm-Message-State: AOJu0YzbyZA9f+eePCeSLrUvZY8eCP2OAeos5dYoJ3VUNqYW1B8sVbWk
        vZhnyYn4/jXziZKQJO5dOPhNNLcOkUHFYtMPUUI=
X-Google-Smtp-Source: AGHT+IGJBJkTtqCZ7hXNDy1AMmlhV69JSCio42nXPS+htexa0SnMKdOfQzoS5i8rtwe18oVXCg5JwhMw/9HpV+CRZOY=
X-Received: by 2002:a05:6870:e387:b0:1bf:8033:69a0 with SMTP id
 x7-20020a056870e38700b001bf803369a0mr12176484oad.30.1691429027572; Mon, 07
 Aug 2023 10:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230802070348.12538-1-sunran001@208suo.com>
In-Reply-To: <20230802070348.12538-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:23:36 -0400
Message-ID: <CADnq5_PaOovxLpa+8XZO1-AMFXyqNAg_VBNNGjvaVhRe=di0cQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in dce_v10_0.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Aug 2, 2023 at 3:04=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 30 +++++++++-----------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index 9a24ed463abd..584cd5277f92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -52,8 +52,7 @@
>  static void dce_v10_0_set_display_funcs(struct amdgpu_device *adev);
>  static void dce_v10_0_set_irq_funcs(struct amdgpu_device *adev);
>
> -static const u32 crtc_offsets[] =3D
> -{
> +static const u32 crtc_offsets[] =3D {
>         CRTC0_REGISTER_OFFSET,
>         CRTC1_REGISTER_OFFSET,
>         CRTC2_REGISTER_OFFSET,
> @@ -63,8 +62,7 @@ static const u32 crtc_offsets[] =3D
>         CRTC6_REGISTER_OFFSET
>  };
>
> -static const u32 hpd_offsets[] =3D
> -{
> +static const u32 hpd_offsets[] =3D {
>         HPD0_REGISTER_OFFSET,
>         HPD1_REGISTER_OFFSET,
>         HPD2_REGISTER_OFFSET,
> @@ -121,30 +119,26 @@ static const struct {
>         .hpd =3D DISP_INTERRUPT_STATUS_CONTINUE5__DC_HPD6_INTERRUPT_MASK
>  } };
>
> -static const u32 golden_settings_tonga_a11[] =3D
> -{
> +static const u32 golden_settings_tonga_a11[] =3D {
>         mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
>         mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
>         mmFBC_MISC, 0x1f311fff, 0x12300000,
>         mmHDMI_CONTROL, 0x31000111, 0x00000011,
>  };
>
> -static const u32 tonga_mgcg_cgcg_init[] =3D
> -{
> +static const u32 tonga_mgcg_cgcg_init[] =3D {
>         mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
>         mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
>  };
>
> -static const u32 golden_settings_fiji_a10[] =3D
> -{
> +static const u32 golden_settings_fiji_a10[] =3D {
>         mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
>         mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
>         mmFBC_MISC, 0x1f311fff, 0x12300000,
>         mmHDMI_CONTROL, 0x31000111, 0x00000011,
>  };
>
> -static const u32 fiji_mgcg_cgcg_init[] =3D
> -{
> +static const u32 fiji_mgcg_cgcg_init[] =3D {
>         mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
>         mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
>  };
> @@ -1425,8 +1419,7 @@ static void dce_v10_0_audio_enable(struct amdgpu_de=
vice *adev,
>                            enable ? AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_=
CONTROL__AUDIO_ENABLED_MASK : 0);
>  }
>
> -static const u32 pin_offsets[] =3D
> -{
> +static const u32 pin_offsets[] =3D {
>         AUD0_REGISTER_OFFSET,
>         AUD1_REGISTER_OFFSET,
>         AUD2_REGISTER_OFFSET,
> @@ -1811,8 +1804,7 @@ static void dce_v10_0_afmt_fini(struct amdgpu_devic=
e *adev)
>         }
>  }
>
> -static const u32 vga_control_regs[6] =3D
> -{
> +static const u32 vga_control_regs[6] =3D {
>         mmD1VGA_CONTROL,
>         mmD2VGA_CONTROL,
>         mmD3VGA_CONTROL,
> @@ -3651,8 +3643,7 @@ static void dce_v10_0_set_irq_funcs(struct amdgpu_d=
evice *adev)
>         adev->hpd_irq.funcs =3D &dce_v10_0_hpd_irq_funcs;
>  }
>
> -const struct amdgpu_ip_block_version dce_v10_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version dce_v10_0_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_DCE,
>         .major =3D 10,
>         .minor =3D 0,
> @@ -3660,8 +3651,7 @@ const struct amdgpu_ip_block_version dce_v10_0_ip_b=
lock =3D
>         .funcs =3D &dce_v10_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version dce_v10_1_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version dce_v10_1_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_DCE,
>         .major =3D 10,
>         .minor =3D 1,
> --
> 2.17.1
>
