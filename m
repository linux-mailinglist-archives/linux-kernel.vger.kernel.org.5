Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41007772CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjHGRXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjHGRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:22:52 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111C19BC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:22:34 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a412653335so3313617b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428951; x=1692033751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdiT4VDFwEWB7gXAPktsqljyYxoKDZsI+pliCIWNBKQ=;
        b=sq0kRQ+cYhoTN4ibTazfI3lKdSnU5a9uzGkj1ndxEhIbDKbavoAD0G1dE5zZ+F0X3J
         x7DXk4NLGQyj+ps3xDE6TdwL2TeeVjHXGpV6DIOagKlPNfNiqK5yso4W7d7w/TDjCqeD
         v96FwIeBKk8g6MaAhbEQ1B16PTDrabTq+doldAUbRQRcewkL4fYYQ1a2E9f/w+li3NvE
         nLTMhI0iSvdayvRthG10b+nl/ZKYIU7dhurR8pOnliiy9YS0UJhoVFbFLTs5vE1nvaBV
         fc6YSG/J16ANEEE+V2nKQD0vA0zbCeElVNcG1Q0R7Wk0O4Yca/gzGLo1J2DK9j05eTO1
         F2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428951; x=1692033751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdiT4VDFwEWB7gXAPktsqljyYxoKDZsI+pliCIWNBKQ=;
        b=C4WhT2U6nptSzGWUgiLRDgUASC/OeRghUP/YnjyMywyxsJ778k8BIf36WBN/R7hT95
         YTNsTawE1Bzq+aGvm9p35fGd+TDFY41yOI95avvbo/4znuTCN8KtnNOuoFrw3XD7GNjz
         A357rNcfjDNrYh2SewutkmnY23+B9/ciCxt74czE3RjMO4ZcypY2jR8+1VtuRP5ht+Tw
         IVE8lMVlO0tfcW+cPBrYx0yVdwA1eu+A/zpyYr8SKhkNxidiayY1SlRQDt7bpSPQRdIv
         bxPxpzLR9v2adUIZd0d7BxdkaH6eX0FJ8Ojlqab4cfdXGcfO/Jy1fOrOZ8ZDzRnLEcaD
         T7Og==
X-Gm-Message-State: AOJu0Yx2Jrls9KmRD7+32BW/1PTMkysSl7AB8I4tcwjxiKfOFgCOYm64
        5TsXc1Zow4rJIjTjKO/kcR1QA7ZZ77HcU++Z+FI=
X-Google-Smtp-Source: AGHT+IF9DSieLDJ6wkuhVPEfT0WAsY+ArX+WPqVB+kikaHFxvekHPQvooC1UarJCEEPloluOY2IppngCAPeUPb1xJlo=
X-Received: by 2002:a05:6808:189b:b0:3a7:2a94:73f6 with SMTP id
 bi27-20020a056808189b00b003a72a9473f6mr13171907oib.49.1691428950972; Mon, 07
 Aug 2023 10:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230802065804.12360-1-sunran001@208suo.com>
In-Reply-To: <20230802065804.12360-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:22:20 -0400
Message-ID: <CADnq5_Ntw2+Ett+JVPtye1RH4yi8WBD3si7_CqfErvC9keUi1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in uvd_v7_0.c
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

On Wed, Aug 2, 2023 at 2:58=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that ':' (ctx:VxE)
> that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index abaa4463e906..86d1d46e1e5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -679,11 +679,11 @@ static void uvd_v7_0_mc_resume(struct amdgpu_device=
 *adev)
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>                         WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_B=
AR_LOW,
>                                 i =3D=3D 0 ?
> -                               adev->firmware.ucode[AMDGPU_UCODE_ID_UVD]=
.tmr_mc_addr_lo:
> +                               adev->firmware.ucode[AMDGPU_UCODE_ID_UVD]=
.tmr_mc_addr_lo :
>                                 adev->firmware.ucode[AMDGPU_UCODE_ID_UVD1=
].tmr_mc_addr_lo);
>                         WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_B=
AR_HIGH,
>                                 i =3D=3D 0 ?
> -                               adev->firmware.ucode[AMDGPU_UCODE_ID_UVD]=
.tmr_mc_addr_hi:
> +                               adev->firmware.ucode[AMDGPU_UCODE_ID_UVD]=
.tmr_mc_addr_hi :
>                                 adev->firmware.ucode[AMDGPU_UCODE_ID_UVD1=
].tmr_mc_addr_hi);
>                         WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET0, 0)=
;
>                         offset =3D 0;
> @@ -1908,8 +1908,7 @@ static void uvd_v7_0_set_irq_funcs(struct amdgpu_de=
vice *adev)
>         }
>  }
>
> -const struct amdgpu_ip_block_version uvd_v7_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version uvd_v7_0_ip_block =3D {
>                 .type =3D AMD_IP_BLOCK_TYPE_UVD,
>                 .major =3D 7,
>                 .minor =3D 0,
> --
> 2.17.1
>
