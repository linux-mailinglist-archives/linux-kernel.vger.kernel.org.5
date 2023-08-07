Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3FB772AF8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjHGQdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjHGQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:33:45 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823A1172B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:33:39 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1bfafe8a425so2265942fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426019; x=1692030819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS+s5QA+7fmn3p9NicYuopwCAnPqna71fQArihZ77Ho=;
        b=IlOvTRmvh6IFmi2KYgc6P7/WQhjjiI803ANoTJS/TMU5RE0REjCmC26D5/ucnqh/KV
         VYFo9cfL4bdnTXtAjtg4sbtOJbHLzJnKv3e/bAIuNYhqqlHVrd8PUPpohDfB/3KbHtuO
         GsCYAUrwdAyii6Q4bUqufJZek12biEoQJj7KQyGE5YeK/d9bHyAkQOM7tmxjyGxUF41s
         sC4h2ProWpEMXieZv3bOOujlt+eKSiolxbSpg5tV708kBGRVfoYQiWwXszDn+6RsMaey
         ftMtRAAZ/VZaUNgOWmvWfDNHDZ4Na9j9y1RkNsgDcyGXlzQFGqhO9o7T/FFHn1f3gA5E
         eMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426019; x=1692030819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GS+s5QA+7fmn3p9NicYuopwCAnPqna71fQArihZ77Ho=;
        b=ePECM0IH/kMQbfZXfiofTLoRSvbnLhWda1vVggeLbVu13BlSXEcYoup+UsmAfjPPzR
         IXoo03ixmc9cgfelM3SKzm0yeJu/ble829djxRLqoNFNV3uV2uiH3CpvSuPrQqcb/PVS
         bF6MFSnqU9jFuzEQ0t1N1KL90NbWoKFTPLx/ID4iaWyX4BzZu/ZzIhvtmQJVQ/dPTAds
         k7Wkw/KfmzlYHYjh6vzMMULpxFXiMECYRRiHDMU8wWQd/3fkuow36z4rkLE68NYuuH6J
         64iPcTROrCNHjdq2IK1b6gv3qZHxKGfqhWqiBgzkrR53RWEygr1isc7msuS0ZnwKs+IK
         azgg==
X-Gm-Message-State: AOJu0YyjB6cjCBqa86fhBeem+ArEw5QFZDntsjmhwgsVabEuHdbTOeP5
        HYtJm+cOjAa2uwXdUHSvKnfPcmVPuLPL7L9Wecw=
X-Google-Smtp-Source: AGHT+IEXPlOEjWezLgBbrAHmlydU64OP4b3QmZeeluV9R+nkqbnRn+LuWwHIFce6PmDPG8N6fuZTeoH0br82T7XlKZ4=
X-Received: by 2002:a05:6870:4153:b0:1bb:8162:dfcc with SMTP id
 r19-20020a056870415300b001bb8162dfccmr10564902oad.11.1691426017331; Mon, 07
 Aug 2023 09:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230801060937.6178-1-sunran001@208suo.com>
In-Reply-To: <20230801060937.6178-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:33:26 -0400
Message-ID: <CADnq5_MbgT64L+7ga8zzTrNJ1G0TvMFV4BPw5Lv9gDFfNCukMw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega12_baco.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 2:09=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c
> index bc53cce4f32d..32cc8de296e4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c
> @@ -29,16 +29,14 @@
>  #include "vega12_ppsmc.h"
>  #include "vega12_baco.h"
>
> -static const struct soc15_baco_cmd_entry  pre_baco_tbl[] =3D
> -{
> +static const struct soc15_baco_cmd_entry  pre_baco_tbl[] =3D {
>         { CMD_READMODIFYWRITE, NBIF_HWID, 0, mmBIF_DOORBELL_CNTL_BASE_IDX=
, mmBIF_DOORBELL_CNTL, BIF_DOORBELL_CNTL__DOORBELL_MONITOR_EN_MASK, BIF_DOO=
RBELL_CNTL__DOORBELL_MONITOR_EN__SHIFT, 0, 0 },
>         { CMD_WRITE, NBIF_HWID, 0, mmBIF_FB_EN_BASE_IDX, mmBIF_FB_EN, 0, =
0, 0, 0 },
>         { CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_ID=
X, mmBACO_CNTL, BACO_CNTL__BACO_DSTATE_BYPASS_MASK, BACO_CNTL__BACO_DSTATE_=
BYPASS__SHIFT, 0, 1 },
>         { CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_ID=
X, mmBACO_CNTL, BACO_CNTL__BACO_RST_INTR_MASK_MASK, BACO_CNTL__BACO_RST_INT=
R_MASK__SHIFT, 0, 1 }
>  };
>
> -static const struct soc15_baco_cmd_entry enter_baco_tbl[] =3D
> -{
> +static const struct soc15_baco_cmd_entry enter_baco_tbl[] =3D {
>         { CMD_WAITFOR, THM_HWID, 0, mmTHM_BACO_CNTL_BASE_IDX, mmTHM_BACO_=
CNTL, THM_BACO_CNTL__SOC_DOMAIN_IDLE_MASK, THM_BACO_CNTL__SOC_DOMAIN_IDLE__=
SHIFT, 0xffffffff, 0x80000000 },
>         { CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_ID=
X, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 1 },
>         { CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_ID=
X, mmBACO_CNTL, BACO_CNTL__BACO_BIF_LCLK_SWITCH_MASK, BACO_CNTL__BACO_BIF_L=
CLK_SWITCH__SHIFT, 0, 1 },
> @@ -56,8 +54,7 @@ static const struct soc15_baco_cmd_entry enter_baco_tbl=
[] =3D
>         { CMD_WAITFOR, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBAC=
O_CNTL, BACO_CNTL__BACO_MODE_MASK, BACO_CNTL__BACO_MODE__SHIFT, 0xffffffff,=
 0x100 }
>  };
>
> -static const struct soc15_baco_cmd_entry exit_baco_tbl[] =3D
> -{
> +static const struct soc15_baco_cmd_entry exit_baco_tbl[] =3D {
>         { CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_ID=
X, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MASK, BACO_CNTL__BACO_POWER_OFF__=
SHIFT, 0, 0 },
>         { CMD_DELAY_MS, 0, 0, 0, 0, 0, 0, 10, 0 },
>         { CMD_READMODIFYWRITE, THM_HWID, 0, mmTHM_BACO_CNTL_BASE_IDX, mmT=
HM_BACO_CNTL, THM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK, THM_BACO_CNTL__BACO_=
SOC_REFCLK_OFF__SHIFT, 0, 0 },
> @@ -77,8 +74,7 @@ static const struct soc15_baco_cmd_entry exit_baco_tbl[=
] =3D
>         { CMD_WAITFOR, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBAC=
O_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xffffffff, 0 }
>  };
>
> -static const struct soc15_baco_cmd_entry clean_baco_tbl[] =3D
> -{
> +static const struct soc15_baco_cmd_entry clean_baco_tbl[] =3D {
>         { CMD_WRITE, NBIF_HWID, 0, mmBIOS_SCRATCH_6_BASE_IDX, mmBIOS_SCRA=
TCH_6, 0, 0, 0, 0 },
>         { CMD_WRITE, NBIF_HWID, 0, mmBIOS_SCRATCH_7_BASE_IDX, mmBIOS_SCRA=
TCH_7, 0, 0, 0, 0 }
>  };
> --
> 2.17.1
>
