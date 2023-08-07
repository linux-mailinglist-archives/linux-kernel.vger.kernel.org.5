Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038CE772ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjHGQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjHGQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:28:20 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE6100
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:28:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bc9811558cso3927081a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425691; x=1692030491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBBuDI+9splS1pnBc+KXC2tvqjZTNnwYYin+vd+ZusA=;
        b=TyEXAOeXsOHZJSdCLFjJOts0i1CUzU4U2kZa0bd6SlgoVASnjLfib6uCG8HcFHlC1V
         py44hX/0m8a/l7Q0tNPyvoDnrYqlfZnBBcrOWF241VffmiVTF9lz8i4jtuhHFJIu9yAX
         OnwvGoERLcUVfhfbIuvqUbDF0OXAADJSK0ncHzZtlQbDAZ2+0UJFTLDzcRdCW8uB2xHK
         7G0IOSkR0ADMeXY6j+1SdEqEPfLOHSX1CBsQWcGNLgAgXKXSUbyMGrZCjdFP6XivvVXX
         x4kP/9Nl7lWQ9vVL9UTI/aGEB4uulCIAqFUpvZkyoMiDRJkjGPYFQyRqpEbCguMYwg5r
         F/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425691; x=1692030491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBBuDI+9splS1pnBc+KXC2tvqjZTNnwYYin+vd+ZusA=;
        b=Tp03uwDDETJJulkMJinQMVuaWe4tk0/IBlUMNbd4ABwtr+LhmE4h5S6G3g3YvuCAgX
         Ba5KWM8nufcT45DWJxE9G0XWGTpZ9Rx2Rc7RA8vTIl90zrgkxwHfcCS5fnARroD4Uamc
         3ycf8m9SK0auR3gHVAZsQiILpBialhEjCdzoZ5EwwD0OSYRGA+LMIjaTuirJn2z+472U
         SiIMtJCJCRvcfI0iNWfRUTewXYwYgXVBBDVl4a3nGlo8coq+lr8TtrwRIpbJ79BTq9Sc
         gmzwTgcpiJdWmAiNn1wHn7FySbYNM/mljcEdmcq1cTmYBT+MIigeyq4EMVHLdsGZ1GYl
         xm7w==
X-Gm-Message-State: AOJu0Yx9A0CkSbyiFVhqYyi4oLOf24V/ioapx6yB/FmRdtHooOhEC0Ah
        s1JOG8JSk5De9rDLd1RzUo9mo9pcqalLXV8LpeWVsv7U
X-Google-Smtp-Source: AGHT+IFwaosLDH0Ba5G6pXQk30jVkppAo725i0nFFwHkn7bEe8zkkOgguoqmJ8vCc7Xakh5eRP/drsdqlfvUc0qWsFg=
X-Received: by 2002:a05:6871:521e:b0:1bf:607:e0ed with SMTP id
 ht30-20020a056871521e00b001bf0607e0edmr13625803oac.39.1691425691082; Mon, 07
 Aug 2023 09:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230801031603.5283-1-sunran001@208suo.com>
In-Reply-To: <20230801031603.5283-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:28:00 -0400
Message-ID: <CADnq5_MuE1-K100y0GzBrycuG5as90bfxewZG+2_U_2-yw1gGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in fiji_baco.c
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

On Mon, Jul 31, 2023 at 11:16=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/fiji_baco.c    | 24 +++++++------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/fiji_baco.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/fiji_baco.c
> index c0368f2dfb21..b3e768fa79f2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/fiji_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/fiji_baco.c
> @@ -36,8 +36,7 @@
>  #include "smu/smu_7_1_3_sh_mask.h"
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
> @@ -78,8 +75,7 @@ static const struct baco_cmd_entry use_bclk_tbl[] =3D
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, MPLL_BYPASSCLK_SEL__MP=
LL_CLKOUT_SEL_MASK, MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL__SHIFT, 0, 0x2 }
>  };
>
> -static const struct baco_cmd_entry turn_off_plls_tbl[] =3D
> -{
> +static const struct baco_cmd_entry turn_off_plls_tbl[] =3D {
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixCG_SPLL_FUNC_CNTL },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_SPLL_FUNC_CNTL__SPL=
L_RESET_MASK, CG_SPLL_FUNC_CNTL__SPLL_RESET__SHIFT, 0,     0x1 },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_SPLL_FUNC_CNTL__SPL=
L_PWRON_MASK, CG_SPLL_FUNC_CNTL__SPLL_PWRON__SHIFT, 0,     0x0 },
> @@ -88,8 +84,7 @@ static const struct baco_cmd_entry turn_off_plls_tbl[] =
=3D
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, 0x8000000, 0x1b, 0, 0x=
0 }
>  };
>
> -static const struct baco_cmd_entry clk_req_b_tbl[] =3D
> -{
> +static const struct baco_cmd_entry clk_req_b_tbl[] =3D {
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixCG_CLKPIN_CNTL_2 },
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_CLKPIN_CNTL_2__FORC=
E_BIF_REFCLK_EN_MASK, CG_CLKPIN_CNTL_2__FORCE_BIF_REFCLK_EN__SHIFT, 0, 0x0 =
},
>         { CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixMPLL_BYPASSCLK_SEL }=
,
> @@ -104,8 +99,7 @@ static const struct baco_cmd_entry clk_req_b_tbl[] =3D
>         { CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, THM_CLK_CNTL__TMON_CLK=
_SEL_MASK, THM_CLK_CNTL__TMON_CLK_SEL__SHIFT, 0, 0x1 }
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
> @@ -122,8 +116,7 @@ static const struct baco_cmd_entry enter_baco_tbl[] =
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
> @@ -138,8 +131,7 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
=3D
>         { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xfffff=
fff, 0x00 }
>  };
>
> -static const struct baco_cmd_entry clean_baco_tbl[] =3D
> -{
> +static const struct baco_cmd_entry clean_baco_tbl[] =3D {
>         { CMD_WRITE, mmBIOS_SCRATCH_0, 0, 0, 0, 0 },
>         { CMD_WRITE, mmBIOS_SCRATCH_1, 0, 0, 0, 0 },
>         { CMD_WRITE, mmBIOS_SCRATCH_2, 0, 0, 0, 0 },
> --
> 2.17.1
>
