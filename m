Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C921A772D08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjHGRcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjHGRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:32:33 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C2810C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:32:32 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bb75afeee3so3526824fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429551; x=1692034351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppiBBjYJG/XW1kAAXzQTC+/nWhNIEYjSapFb0lojsPM=;
        b=oHFC/ciAFq4RNMuFiAKJAQHIwKXCkfbl7thPWsUwm6ItTlyfmLkH+LsZLcGe1MpDsO
         goQWvV/Qx5hdyN2u0GKRmqUVdO448yZwS3kmw3aykmk2vc65aBclZOldjDifiQh2EByb
         V68B3u/P7uLY0LXZLUH1/w1JnM5w6uKSv+M/ro0Pqq2drB8Q1uOG3HaiAmj98QTMY/6b
         KygmFg48GRchZlBDe/Ck61W9hFnfl//x5WE9l7uc/oqC2StddE7tQgspXCJ4S0arjhIV
         EnqU0/viKMttdlp9OrwJoEJ0zdXKeS1GeEOaHjMUBZikeqTgT4vaYtKH9r3UGEUTpxuy
         rZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429551; x=1692034351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppiBBjYJG/XW1kAAXzQTC+/nWhNIEYjSapFb0lojsPM=;
        b=d8zHwYl5tX7NeEY2DvX+jR/+SEsz6I9slKnT/rFquJ3iSI6Ncvs92cdCAVyf1Cgj1r
         0tCC5B5iFCcARiapcw7vQabglzhcxEHRaekKZ7nGv7ie7wFqz5ER17HPa/tcmEMOTid4
         qvNMXEfjvmgMh5Prg1MpeZWcPitBhDd1z/GhDPic2mZUuN3GUnXJD1oYtztwe/J+tcDz
         IhBjEknxCKvHGE5JShQOhXkI0f4yYTmyTpQMaqX0kOfOybJOxElg0m7F5fDZyFKqqYcf
         qTpflJBvcEfjbxHzWss6UDyDhm+C5IYfiJ5J3A9xC0Qnmp/BdBuJOYHUMMRIpo4plBgP
         SDRg==
X-Gm-Message-State: AOJu0Yw8dNEOcVkEy42pzAPwg/ocM4Ipn7LweSUmiLNwWmUQMPkQwn7R
        +JgwFKhnuXcsL6VWeKdk8LvneETGHrCkWqy1Tik=
X-Google-Smtp-Source: AGHT+IFGfTUDhGDdBV33XG4hu9P4aAEmS7czwMpfrpRKuTz/A3zu2jsstMLqzpomseAVz+m9Kp+dn+yHx1/2VpoqUwA=
X-Received: by 2002:a05:6870:c20d:b0:1bf:1346:63e with SMTP id
 z13-20020a056870c20d00b001bf1346063emr9773323oae.49.1691429551577; Mon, 07
 Aug 2023 10:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230802074844.13773-1-sunran001@208suo.com>
In-Reply-To: <20230802074844.13773-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:32:20 -0400
Message-ID: <CADnq5_MtGmXSpDM4znwXbrT+CrzNO8HvFy6_tvS8NQ-PDR9SSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in gfx_v7_0.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 2, 2023 at 3:49=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: trailing statements should be on next line
> ERROR: open brace '{' following struct go on the same line
> ERROR: space prohibited before that '++' (ctx:WxB)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 28 +++++++++++----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 8c174c11eaee..90b034b173c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -90,8 +90,7 @@ MODULE_FIRMWARE("amdgpu/mullins_ce.bin");
>  MODULE_FIRMWARE("amdgpu/mullins_rlc.bin");
>  MODULE_FIRMWARE("amdgpu/mullins_mec.bin");
>
> -static const struct amdgpu_gds_reg_offset amdgpu_gds_reg_offset[] =3D
> -{
> +static const struct amdgpu_gds_reg_offset amdgpu_gds_reg_offset[] =3D {
>         {mmGDS_VMID0_BASE, mmGDS_VMID0_SIZE, mmGDS_GWS_VMID0, mmGDS_OA_VM=
ID0},
>         {mmGDS_VMID1_BASE, mmGDS_VMID1_SIZE, mmGDS_GWS_VMID1, mmGDS_OA_VM=
ID1},
>         {mmGDS_VMID2_BASE, mmGDS_VMID2_SIZE, mmGDS_GWS_VMID2, mmGDS_OA_VM=
ID2},
> @@ -110,8 +109,7 @@ static const struct amdgpu_gds_reg_offset amdgpu_gds_=
reg_offset[] =3D
>         {mmGDS_VMID15_BASE, mmGDS_VMID15_SIZE, mmGDS_GWS_VMID15, mmGDS_OA=
_VMID15}
>  };
>
> -static const u32 spectre_rlc_save_restore_register_list[] =3D
> -{
> +static const u32 spectre_rlc_save_restore_register_list[] =3D {
>         (0x0e00 << 16) | (0xc12c >> 2),
>         0x00000000,
>         (0x0e00 << 16) | (0xc140 >> 2),
> @@ -557,8 +555,7 @@ static const u32 spectre_rlc_save_restore_register_li=
st[] =3D
>         (0x0e00 << 16) | (0x9600 >> 2),
>  };
>
> -static const u32 kalindi_rlc_save_restore_register_list[] =3D
> -{
> +static const u32 kalindi_rlc_save_restore_register_list[] =3D {
>         (0x0e00 << 16) | (0xc12c >> 2),
>         0x00000000,
>         (0x0e00 << 16) | (0xc140 >> 2),
> @@ -933,7 +930,8 @@ static int gfx_v7_0_init_microcode(struct amdgpu_devi=
ce *adev)
>         case CHIP_MULLINS:
>                 chip_name =3D "mullins";
>                 break;
> -       default: BUG();
> +       default:
> +               BUG();
>         }
>
>         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name=
);
> @@ -2759,8 +2757,7 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *=
adev)
>         return 0;
>  }
>
> -struct hqd_registers
> -{
> +struct hqd_registers {
>         u32 cp_mqd_base_addr;
>         u32 cp_mqd_base_addr_hi;
>         u32 cp_hqd_active;
> @@ -5124,11 +5121,11 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_de=
vice *adev)
>                         bitmap =3D gfx_v7_0_get_cu_active_bitmap(adev);
>                         cu_info->bitmap[i][j] =3D bitmap;
>
> -                       for (k =3D 0; k < adev->gfx.config.max_cu_per_sh;=
 k ++) {
> +                       for (k =3D 0; k < adev->gfx.config.max_cu_per_sh;=
 k++) {
>                                 if (bitmap & mask) {
>                                         if (counter < ao_cu_num)
>                                                 ao_bitmap |=3D mask;
> -                                       counter ++;
> +                                       counter++;
>                                 }
>                                 mask <<=3D 1;
>                         }
> @@ -5150,8 +5147,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_devi=
ce *adev)
>         cu_info->lds_size =3D 64;
>  }
>
> -const struct amdgpu_ip_block_version gfx_v7_1_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version gfx_v7_1_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_GFX,
>         .major =3D 7,
>         .minor =3D 1,
> @@ -5159,8 +5155,7 @@ const struct amdgpu_ip_block_version gfx_v7_1_ip_bl=
ock =3D
>         .funcs =3D &gfx_v7_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version gfx_v7_2_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version gfx_v7_2_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_GFX,
>         .major =3D 7,
>         .minor =3D 2,
> @@ -5168,8 +5163,7 @@ const struct amdgpu_ip_block_version gfx_v7_2_ip_bl=
ock =3D
>         .funcs =3D &gfx_v7_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version gfx_v7_3_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version gfx_v7_3_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_GFX,
>         .major =3D 7,
>         .minor =3D 3,
> --
> 2.17.1
>
