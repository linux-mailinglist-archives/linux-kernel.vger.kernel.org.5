Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D88772B69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjHGQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjHGQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:47:34 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786419D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:47:33 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56c87f89178so3226001eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426853; x=1692031653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3ILY1Xc3ixm+CYC3BThxO0I9niViD5h2B8iBeASacA=;
        b=ae/t/y8TnbdKKDl1qLhChYi/Z2W0FRt3NVn07NkuIIFwvYKNgZ830Hc5MoeCaE2dAE
         yLDT2VOIdpthU7lOlHESqYTMW/eMvJ6Qr8hcetlsb12ZdTjDPeYND3HV9MurSeiaB9CG
         7WnRBnd3r6fpXlMc8vIEmrX5l8DRDjBM7tD7iS5ug/235ryibMV3jbsA+M0HMcyMdX9f
         dfsCf9JWY7tsYWTEJBE2hdGoE/IdaV5c/hvJXv8IL9uM/DyrEYKIqRL114wUa2RkukQZ
         g+P31D+ibeeINPdfcRiDUpd63PzkNiPvUCyUfdbzN1H2V03o+o3lONLsZ7DdDle2QBzL
         hENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426853; x=1692031653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3ILY1Xc3ixm+CYC3BThxO0I9niViD5h2B8iBeASacA=;
        b=hwl0sYtdmeKrjwH0WGYYlalUr9HFlQon8/ITBOD+IJw25qbdFw946YHiwNKFQZ785h
         BeHMUb5LhN2E9rXYs921IFZWGIljumNqjBpE8vNXKw94cW6suvFP7NYN8/PwCuTWFyUe
         OwxY5iwMTp82FjbbQekk9+49nnzzdl+y7QmMVLTEvDtVNG50EbfDRrMqV6rda3n4liKd
         uzpQA1BQlMPqdP+1+ASFqdFPAeeJ5MLFgtj/gjzBxiG+oO4vNiQy7or1/DfegEPc/bSR
         gF7/ngAVoOzTgoGkKR0VdatJhM8kocRIZHyOUwkNvt999+o5/uqfauBtkQ6nSqo+g6+k
         Bx/Q==
X-Gm-Message-State: AOJu0YxfqWrAGHeHPU5+8qWUWTh/iQ2fijwPyt4J8KP73PWmFvVeD2N0
        cZvmAArY/pD9LbUQKO4kB0OPQXw1L4MILtgRW3BA8/qk
X-Google-Smtp-Source: AGHT+IHduCsMJ2/SXA/WPpbSn3DxjnhLMV8iqTXXVRj3sXL/nB2Lw18TjjmoVqx6RUEGVP+ORSSpcRZq5+vdBapAPj8=
X-Received: by 2002:a4a:3045:0:b0:566:b483:ee00 with SMTP id
 z5-20020a4a3045000000b00566b483ee00mr8954274ooz.5.1691426852705; Mon, 07 Aug
 2023 09:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230801093414.7673-1-sunran001@208suo.com>
In-Reply-To: <20230801093414.7673-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:47:21 -0400
Message-ID: <CADnq5_P-iaxR2uF2QbZLp6B2hKFGAjhBW4=qpxD2iJ=FztVKjA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in tonga_baco.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 5:34=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/tonga_baco.c   | 30 +++++++------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/tonga_baco.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/tonga_baco.c
> index ea743bea8e29..432d4fd2a0ba 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/tonga_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/tonga_baco.c
> @@ -36,8 +36,7 @@
>  #include "smu/smu_7_1_2_sh_mask.h"
>
>
> -static const struct baco_cmd_entry gpio_tbl[] =3D
> -{
> +static const struct baco_cmd_entry gpio_tbl[] =3D {
>         { CMD_WRITE, mmGPIOPAD_EN, 0, 0, 0, 0x0 },
>         { CMD_WRITE, mmGPIOPAD_PD_EN, 0, 0, 0, 0x0 },
>         { CMD_WRITE, mmGPIOPAD_PU_EN, 0, 0, 0, 0x0 },
> @@ -50,15 +49,13 @@ static const struct baco_cmd_entry gpio_tbl[] =3D
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
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixCG_SPLL_FUNC_CNTL_2 =
},
> @@ -80,8 +77,7 @@ static const struct baco_cmd_entry use_bclk_tbl[] =3D
>         { CMD_READMODIFYWRITE, mmMPLL_CNTL_MODE, MPLL_CNTL_MODE__MPLL_MCL=
K_SEL_MASK, MPLL_CNTL_MODE__MPLL_MCLK_SEL__SHIFT, 0, 0x0 }
>  };
>
> -static const struct baco_cmd_entry turn_off_plls_tbl[] =3D
> -{
> +static const struct baco_cmd_entry turn_off_plls_tbl[] =3D {
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixCG_SPLL_FUNC_CNTL },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_SPLL_FUNC_CNTL__SPL=
L_RESET_MASK, CG_SPLL_FUNC_CNTL__SPLL_RESET__SHIFT, 0, 0x1 },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_SPLL_FUNC_CNTL__SPL=
L_PWRON_MASK, CG_SPLL_FUNC_CNTL__SPLL_PWRON__SHIFT, 0, 0x0 },
> @@ -112,8 +108,7 @@ static const struct baco_cmd_entry turn_off_plls_tbl[=
] =3D
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, THM_CLK_CNTL__TMON_CLK=
_SEL_MASK,  THM_CLK_CNTL__TMON_CLK_SEL__SHIFT, 0, 0x1 }
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
> @@ -130,8 +125,7 @@ static const struct baco_cmd_entry enter_baco_tbl[] =
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
> @@ -146,22 +140,19 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
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
> -static const struct baco_cmd_entry gpio_tbl_iceland[] =3D
> -{
> +static const struct baco_cmd_entry gpio_tbl_iceland[] =3D {
>         { CMD_WRITE, mmGPIOPAD_EN, 0, 0, 0, 0x0 },
>         { CMD_WRITE, mmGPIOPAD_PD_EN, 0, 0, 0, 0x0 },
>         { CMD_WRITE, mmGPIOPAD_PU_EN, 0, 0, 0, 0x0 },
>         { CMD_WRITE, mmGPIOPAD_MASK, 0, 0, 0, 0xff77ffff }
>  };
>
> -static const struct baco_cmd_entry exit_baco_tbl_iceland[] =3D
> -{
> +static const struct baco_cmd_entry exit_baco_tbl_iceland[] =3D {
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK=
, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x01 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BCLK_OFF_MASK=
, BACO_CNTL__BACO_BCLK_OFF__SHIFT, 0, 0x00 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MAS=
K, BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0x00 },
> @@ -177,8 +168,7 @@ static const struct baco_cmd_entry exit_baco_tbl_icel=
and[] =3D
>         { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xfffff=
fff, 0x00 }
>  };
>
> -static const struct baco_cmd_entry clean_baco_tbl_iceland[] =3D
> -{
> +static const struct baco_cmd_entry clean_baco_tbl_iceland[] =3D {
>         { CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 }
>  };
>
> --
> 2.17.1
>
