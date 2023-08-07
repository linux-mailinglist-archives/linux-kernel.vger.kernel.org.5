Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E6772B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjHGQwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:52:20 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7C99
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:52:19 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso3600288fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427138; x=1692031938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zr5bzEAJ4u0jG+0pMtfI/Oc4OFWdg2dWRl6/DHgxTs=;
        b=pJSy8y2sNQTIav/8/1US++ovx3EBG/babM+jC9VSwH89YPxl/9l32061+nQxW9EMWI
         QWlkrZQ4KKLTf+RmB45uhJqZW6NrUpS+dNFJ+4+8epIfUH+YMao7jkNBcNfYeOCukpYV
         m5HtCxp9KNdLxCPm4yO9Sjqvx2gLN+dFUOzoj5J608N8TBbfpo7gLJbmykemeXXgQcAp
         jUzg98RKSoFx6nOjDZS+nCA+UrRJLoPMWDcGFXUqCQLMopI7zeWwS2NTepvlYGXd1v07
         4UzIAVAJLJBYw6VXtbtktd3jAZHOty0o8wg/kXympToTH20QNTRBw83wRUasuHO3uIN6
         TUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427138; x=1692031938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zr5bzEAJ4u0jG+0pMtfI/Oc4OFWdg2dWRl6/DHgxTs=;
        b=W7e1OQLMpsHudAw38JUN16SwiPOdbpDeQqgVz8P+H22jQRzb4akQnqQ2oIni3mA7jd
         FsF9rN3smOitEvDLC1XR24VkfuE3ubKFikkDAYS1uhL+9pjK6sGNq4V4ybqeCKB0Vw8a
         j0r5nudy0MIG5Ift+smIn7nA/jFmj+T9gcqdeIoqz04mDFXWSr3+A/h2Wi1X+O3Ez76C
         OMbJwPe3yl5p1cGubHmokR8+bZlEOoPDXwaXQvBkUGlTvOSev82E0dwY9KQF8Q10ARrl
         ssBjPGySdjG1tgu+XEYMYLfB6FBNDFvu+Am91Sj6wdfkS8J9VTbOfROU5DyDIqi85QuL
         mPBQ==
X-Gm-Message-State: AOJu0Yz11kXW05oiiDgEg8oTRf//LzLb5D6+FHMC7cSrRaPMdpCpUth8
        DNqp3wFDcNUIpgWxUWKegfwAreiCrk02PBg9QXldUWQW
X-Google-Smtp-Source: AGHT+IGOylr6WBFk/yfrsvOLNljNjtq4DOhPqdkeGj2n7GfTSiG1+C4wb1gY88HX3UzRmxq6kEie15ZwuW5xRY6gCUo=
X-Received: by 2002:a05:6870:e6d4:b0:1b7:4655:2ac3 with SMTP id
 s20-20020a056870e6d400b001b746552ac3mr11502882oak.13.1691427138338; Mon, 07
 Aug 2023 09:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230801094742.8032-1-sunran001@208suo.com>
In-Reply-To: <20230801094742.8032-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:52:07 -0400
Message-ID: <CADnq5_N_EQgTBLsJ_PFtEBi_0TD+8=Zp3=2D7NcsmJH1MEEJpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in polaris_baco.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:47=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/polaris_baco.c | 30 +++++++------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c
> index 8f8e296f2fe9..a6a6d43b09f8 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c
> @@ -35,8 +35,7 @@
>  #include "smu/smu_7_1_3_d.h"
>  #include "smu/smu_7_1_3_sh_mask.h"
>
> -static const struct baco_cmd_entry gpio_tbl[] =3D
> -{
> +static const struct baco_cmd_entry gpio_tbl[] =3D {
>         { CMD_WRITE, mmGPIOPAD_EN, 0, 0, 0, 0x0 },
>         { CMD_WRITE, mmGPIOPAD_PD_EN, 0, 0, 0, 0x0 },
>         { CMD_WRITE, mmGPIOPAD_PU_EN, 0, 0, 0, 0x0 },
> @@ -49,15 +48,13 @@ static const struct baco_cmd_entry gpio_tbl[] =3D
>         { CMD_READMODIFYWRITE, mmDC_GPIO_SYNCA_MASK, 0, 0, 0, 0x00001111 =
}
>  };
>
> -static const struct baco_cmd_entry enable_fb_req_rej_tbl[] =3D
> -{
> +static const struct baco_cmd_entry enable_fb_req_rej_tbl[] =3D {
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, 0xC0300024 },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, 0x1, 0x0, 0, 0x1 },
>         { CMD_WRITE, mmBIF_FB_EN, 0, 0, 0, 0x0 }
>  };
>
> -static const struct baco_cmd_entry use_bclk_tbl[] =3D
> -{
> +static const struct baco_cmd_entry use_bclk_tbl[] =3D {
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixCG_SPLL_FUNC_CNTL },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_SPLL_FUNC_CNTL__SPL=
L_BYPASS_EN_MASK, CG_SPLL_FUNC_CNTL__SPLL_BYPASS_EN__SHIFT, 0, 0x1 },
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, 0xC0500170 },
> @@ -70,8 +67,7 @@ static const struct baco_cmd_entry use_bclk_tbl[] =3D
>         { CMD_READMODIFYWRITE, mmMPLL_CNTL_MODE, MPLL_CNTL_MODE__MPLL_MCL=
K_SEL_MASK, MPLL_CNTL_MODE__MPLL_MCLK_SEL__SHIFT, 0, 0x0 }
>  };
>
> -static const struct baco_cmd_entry turn_off_plls_tbl[] =3D
> -{
> +static const struct baco_cmd_entry turn_off_plls_tbl[] =3D {
>         { CMD_READMODIFYWRITE, mmDC_GPIO_PAD_STRENGTH_1, DC_GPIO_PAD_STRE=
NGTH_1__GENLK_STRENGTH_SP_MASK, DC_GPIO_PAD_STRENGTH_1__GENLK_STRENGTH_SP__=
SHIFT, 0, 0x1 },
>         { CMD_DELAY_US, 0, 0, 0, 1, 0x0 },
>         { CMD_READMODIFYWRITE, mmMC_SEQ_DRAM, MC_SEQ_DRAM__RST_CTL_MASK, =
MC_SEQ_DRAM__RST_CTL__SHIFT, 0, 0x1 },
> @@ -92,8 +88,7 @@ static const struct baco_cmd_entry turn_off_plls_tbl[] =
=3D
>         { CMD_DELAY_US, 0, 0, 0, 5, 0x0 }
>  };
>
> -static const struct baco_cmd_entry clk_req_b_tbl[] =3D
> -{
> +static const struct baco_cmd_entry clk_req_b_tbl[] =3D {
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixTHM_CLK_CNTL },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, THM_CLK_CNTL__CMON_CLK=
_SEL_MASK, THM_CLK_CNTL__CMON_CLK_SEL__SHIFT, 0, 0x1 },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, THM_CLK_CNTL__TMON_CLK=
_SEL_MASK, THM_CLK_CNTL__TMON_CLK_SEL__SHIFT, 0, 0x1 },
> @@ -108,8 +103,7 @@ static const struct baco_cmd_entry clk_req_b_tbl[] =
=3D
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, MPLL_BYPASSCLK_SEL__MP=
LL_CLKOUT_SEL_MASK, MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL__SHIFT, 0,     0x4 =
}
>  };
>
> -static const struct baco_cmd_entry enter_baco_tbl[] =3D
> -{
> +static const struct baco_cmd_entry enter_baco_tbl[] =3D {
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO=
_CNTL__BACO_EN__SHIFT, 0, 0x01 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BIF_SCLK_SWIT=
CH_MASK, BACO_CNTL__BACO_BIF_SCLK_SWITCH__SHIFT, 0, 0x01 },
>         { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_BIF_SCLK_SWITCH_MASK,=
 0, 5, 0x40000 },
> @@ -126,8 +120,7 @@ static const struct baco_cmd_entry enter_baco_tbl[] =
=3D
>
>  #define BACO_CNTL__PWRGOOD_MASK  BACO_CNTL__PWRGOOD_GPIO_MASK+BACO_CNTL_=
_PWRGOOD_MEM_MASK+BACO_CNTL__PWRGOOD_DVO_MASK
>
> -static const struct baco_cmd_entry exit_baco_tbl[] =3D
> -{
> +static const struct baco_cmd_entry exit_baco_tbl[] =3D {
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK=
, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x01 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BCLK_OFF_MASK=
, BACO_CNTL__BACO_BCLK_OFF__SHIFT, 0, 0x00 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MAS=
K, BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0x00 },
> @@ -142,14 +135,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
=3D
>         { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xfffff=
fff, 0x00 }
>  };
>
> -static const struct baco_cmd_entry clean_baco_tbl[] =3D
> -{
> +static const struct baco_cmd_entry clean_baco_tbl[] =3D {
>         { CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
>         { CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 }
>  };
>
> -static const struct baco_cmd_entry use_bclk_tbl_vg[] =3D
> -{
> +static const struct baco_cmd_entry use_bclk_tbl_vg[] =3D {
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixCG_SPLL_FUNC_CNTL },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_SPLL_FUNC_CNTL__SPL=
L_BYPASS_EN_MASK, CG_SPLL_FUNC_CNTL__SPLL_BYPASS_EN__SHIFT, 0, 0x1 },
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, 0xC0500170 },
> @@ -160,8 +151,7 @@ static const struct baco_cmd_entry use_bclk_tbl_vg[] =
=3D
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, MPLL_BYPASSCLK_SEL__MP=
LL_CLKOUT_SEL_MASK, MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL__SHIFT, 0, 0x2 }
>  };
>
> -static const struct baco_cmd_entry turn_off_plls_tbl_vg[] =3D
> -{
> +static const struct baco_cmd_entry turn_off_plls_tbl_vg[] =3D {
>         { CMD_READMODIFYWRITE, mmDC_GPIO_PAD_STRENGTH_1, DC_GPIO_PAD_STRE=
NGTH_1__GENLK_STRENGTH_SP_MASK, DC_GPIO_PAD_STRENGTH_1__GENLK_STRENGTH_SP__=
SHIFT, 0, 0x1 },
>         { CMD_DELAY_US, 0, 0, 0, 1, 0x0 },
>         { CMD_READMODIFYWRITE, mmMC_SEQ_DRAM, MC_SEQ_DRAM__RST_CTL_MASK, =
MC_SEQ_DRAM__RST_CTL__SHIFT, 0, 0x1 },
> --
> 2.17.1
>
