Return-Path: <linux-kernel+bounces-107647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C6987FF95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF341F21D22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAE81AAE;
	Tue, 19 Mar 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEjA3Uou"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8781755
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858421; cv=none; b=DPaXjBjfl3g4COpx5ALAjTMGJMgsYcfpD55gbcYRdN6gDLIWmV3m0gtsyDlVOsPtF8lSFbouw/wTUXX4ks2hfrdf7TEcYyuf6Bj0J+hghkytQrN3FG0Izwax8CMbGzWIGHepGETAAu3ZSb3oFSf0Uh7gu16CnnZ3wy0PnJSvVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858421; c=relaxed/simple;
	bh=VeaetP2XxCnVRYxrEIiW3nPd5Ij7776V8Ap6szVDsrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug2p61bBaAyBG4eHWbu849UWQMdr/y6yf8VON4tmarvsgtBbQUHjBl1ZLjynKZrR6KxO5Txuk85xyOcno3gaHBcvHj31k7+YElG6UUVaSFSSdxKWidFzWd+5YYxZ8IPfa7z1zkAaf4gKGbNBrN/T3JJcvzc195tjc9y3izFHeQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEjA3Uou; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso3793161a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710858418; x=1711463218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AloOvY8qeLaJ6ocNA5/uAuJ7ApTuwCgfLFcWMnO76M=;
        b=XEjA3Uou+ufqAnuUt0BtFb2F/QZgqTUhsDHaY6poMGjUfX348nM4bH/UMyGp8UGUuy
         6g8jpR+zHza471jsWuvGyTzWTHkwVmKF7nS24jP9K18w522DUC5G4YAjBu7l+nVrji0a
         uChvvAVGIlxq3Wk+8Mo6HqCEelBGx69xcDvCi7S0iNVDHmnbm1XLWw4/FWAcWbSvA7Nm
         BSq1tPWCKxyrxIWrd3EwJ3LFYGRbV9uiqKUMzTc4pljNbgT+fZ9JuhXjqEFYRq8v1+yI
         XEt0DJcsMl/CwC6ev7WHZ/UNlnzTVd5ajjIAxnETlA0SumNtePyKF+eW9YI7hZ9ftIP4
         TOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710858418; x=1711463218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AloOvY8qeLaJ6ocNA5/uAuJ7ApTuwCgfLFcWMnO76M=;
        b=rVvLRCAMML5pLt5yJW8QkKQwkfcqGUzkRIFUiYoEa4nEJ2/BKJrYsDywigTMUaHGMP
         q3A8Jd8X7QUTPmQFyMVBtiM7Qp8hrCXxv/Sd+2ICog5kgZ0Vz6zSsbmfbMur3yuHIjd3
         qXHD8tumPYM09bpxU6i7+XKazJ28KJoQ4LblnUHSCZ0DiiJjT4if73HkPZS3vkP8/4d+
         kKwv26Q5XUnyxlluXeJihZr5UClVnL2CEsql8+6IiPo1t4J4IRQmkLRl9gCzWo0SxEN8
         LQ4mGHFLke+myxAmgDY7I6t4B3q8LNJU7T6YHHVjKeShFc+bPyiNRpBDnOCsRFaJ4Tcg
         KpFg==
X-Forwarded-Encrypted: i=1; AJvYcCU18fEVxu8BKh0Dj1XJKcV9T6ex4cFgICXXyvPFDQGl9yt2sjCijPGsuCDx36eCvhh/rktlk3cvxjApkrF+dNcXJbOV1j5zLN031EYW
X-Gm-Message-State: AOJu0Yw142V7ZOb55EJe53S7TE4sBAmXFaoEZxbuJwB8VIKX85d7PmNd
	fzRb7tXqPvrB+S3yI518fh20Rub+EOlcZS43jlXupN4AgwHYZ8jTPKRN/550Too9K/1hNQhKytg
	3R7GtODQG/Yvre45UjycULHn9BBs=
X-Google-Smtp-Source: AGHT+IEURGmaJiX+7Q5A7mD6P7SpkoZyPGHuTc8RTiMgbysl7zN6Q/ktxRaQpui5iOqNiB03yix+FrTzaUjaYkJmEfY=
X-Received: by 2002:a17:90a:3d0d:b0:29d:dd50:afe with SMTP id
 h13-20020a17090a3d0d00b0029ddd500afemr2419735pjc.30.1710858418159; Tue, 19
 Mar 2024 07:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319123208.851901-1-sunil.khatri@amd.com>
In-Reply-To: <20240319123208.851901-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Mar 2024 10:26:46 -0400
Message-ID: <CADnq5_PW2ZQ8sP9NcX=f5QhHM-Ne=EQA7k9BKwwwZbgsRyV4-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: refactor code to reuse system information
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 8:32=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Refactor the code so debugfs and devcoredump can reuse
> the common information and avoid unnecessary copy of it.
>
> created a new file which would be the right place to
> hold functions which will be used between sysfs, debugfs
> and devcoredump.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c | 151 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 118 +--------------
>  4 files changed, 157 insertions(+), 115 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 4536c8ad0e11..05d34f4b18f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -80,7 +80,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amd=
gpu_kms.o \
>         amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>         amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>         amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> -       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o
> +       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu=
_devinfo.o
>
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 9c62552bec34..0267870aa9b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1609,4 +1609,5 @@ extern const struct attribute_group amdgpu_vram_mgr=
_attr_group;
>  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>  extern const struct attribute_group amdgpu_flash_attr_group;
>
> +int amdgpu_device_info(struct amdgpu_device *adev, struct drm_amdgpu_inf=
o_device *dev_info);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_devinfo.c
> new file mode 100644
> index 000000000000..d2c15a1dcb0d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +#include "amd_pcie.h"
> +
> +#include <drm/amdgpu_drm.h>
> +
> +int amdgpu_device_info(struct amdgpu_device *adev, struct drm_amdgpu_inf=
o_device *dev_info)

We can probably keep this in amdgpu_kms.c unless that file is getting
too big.  I don't think it warrants a new file at this point.  If you
do keep it in amdgpu_kms.c, I'd recommend renaming it to something
like amdgpu_kms_device_info() to keep the naming conventions.

> +{
> +       int ret;
> +       uint64_t vm_size;
> +       uint32_t pcie_gen_mask;
> +
> +       if (dev_info =3D=3D NULL)
> +               return -EINVAL;
> +
> +       dev_info->device_id =3D adev->pdev->device;
> +       dev_info->chip_rev =3D adev->rev_id;
> +       dev_info->external_rev =3D adev->external_rev_id;
> +       dev_info->pci_rev =3D adev->pdev->revision;
> +       dev_info->family =3D adev->family;
> +       dev_info->num_shader_engines =3D adev->gfx.config.max_shader_engi=
nes;
> +       dev_info->num_shader_arrays_per_engine =3D adev->gfx.config.max_s=
h_per_se;
> +       /* return all clocks in KHz */
> +       dev_info->gpu_counter_freq =3D amdgpu_asic_get_xclk(adev) * 10;
> +       if (adev->pm.dpm_enabled) {
> +               dev_info->max_engine_clock =3D amdgpu_dpm_get_sclk(adev, =
false) * 10;
> +               dev_info->max_memory_clock =3D amdgpu_dpm_get_mclk(adev, =
false) * 10;
> +               dev_info->min_engine_clock =3D amdgpu_dpm_get_sclk(adev, =
true) * 10;
> +               dev_info->min_memory_clock =3D amdgpu_dpm_get_mclk(adev, =
true) * 10;
> +       } else {
> +               dev_info->max_engine_clock =3D
> +                       dev_info->min_engine_clock =3D
> +                               adev->clock.default_sclk * 10;
> +               dev_info->max_memory_clock =3D
> +                       dev_info->min_memory_clock =3D
> +                               adev->clock.default_mclk * 10;
> +               }
> +       dev_info->enabled_rb_pipes_mask =3D adev->gfx.config.backend_enab=
le_mask;
> +       dev_info->num_rb_pipes =3D adev->gfx.config.max_backends_per_se *
> +               adev->gfx.config.max_shader_engines;
> +       dev_info->num_hw_gfx_contexts =3D adev->gfx.config.max_hw_context=
s;
> +       dev_info->ids_flags =3D 0;
> +       if (adev->flags & AMD_IS_APU)
> +               dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;
> +       if (adev->gfx.mcbp)
> +               dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPTION;
> +       if (amdgpu_is_tmz(adev))
> +               dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ;
> +       if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
> +               dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_CONFORMANT_TRUN=
C_COORD;
> +
> +       vm_size =3D adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
> +       vm_size -=3D AMDGPU_VA_RESERVED_TOP;
> +
> +       /* Older VCE FW versions are buggy and can handle only 40bits */
> +       if (adev->vce.fw_version && adev->vce.fw_version < AMDGPU_VCE_FW_=
53_45)
> +               vm_size =3D min(vm_size, 1ULL << 40);
> +
> +       dev_info->virtual_address_offset =3D AMDGPU_VA_RESERVED_BOTTOM;
> +       dev_info->virtual_address_max =3D min(vm_size, AMDGPU_GMC_HOLE_ST=
ART);
> +
> +       if (vm_size > AMDGPU_GMC_HOLE_START) {
> +               dev_info->high_va_offset =3D AMDGPU_GMC_HOLE_END;
> +               dev_info->high_va_max =3D AMDGPU_GMC_HOLE_END | vm_size;
> +       }
> +       dev_info->virtual_address_alignment =3D max_t(u32, PAGE_SIZE, AMD=
GPU_GPU_PAGE_SIZE);
> +       dev_info->pte_fragment_size =3D (1 << adev->vm_manager.fragment_s=
ize) * AMDGPU_GPU_PAGE_SIZE;
> +       dev_info->gart_page_size =3D max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAG=
E_SIZE);
> +       dev_info->cu_active_number =3D adev->gfx.cu_info.number;
> +       dev_info->cu_ao_mask =3D adev->gfx.cu_info.ao_cu_mask;
> +       dev_info->ce_ram_size =3D adev->gfx.ce_ram_size;
> +       memcpy(&dev_info->cu_ao_bitmap[0], &adev->gfx.cu_info.ao_cu_bitma=
p[0],
> +              sizeof(adev->gfx.cu_info.ao_cu_bitmap));
> +       memcpy(&dev_info->cu_bitmap[0], &adev->gfx.cu_info.bitmap[0],
> +              sizeof(dev_info->cu_bitmap));
> +       dev_info->vram_type =3D adev->gmc.vram_type;
> +       dev_info->vram_bit_width =3D adev->gmc.vram_width;
> +       dev_info->vce_harvest_config =3D adev->vce.harvest_config;
> +       dev_info->gc_double_offchip_lds_buf =3D
> +               adev->gfx.config.double_offchip_lds_buf;
> +       dev_info->wave_front_size =3D adev->gfx.cu_info.wave_front_size;
> +       dev_info->num_shader_visible_vgprs =3D adev->gfx.config.max_gprs;
> +       dev_info->num_cu_per_sh =3D adev->gfx.config.max_cu_per_sh;
> +       dev_info->num_tcc_blocks =3D adev->gfx.config.max_texture_channel=
_caches;
> +       dev_info->gs_vgt_table_depth =3D adev->gfx.config.gs_vgt_table_de=
pth;
> +       dev_info->gs_prim_buffer_depth =3D adev->gfx.config.gs_prim_buffe=
r_depth;
> +       dev_info->max_gs_waves_per_vgt =3D adev->gfx.config.max_gs_thread=
s;
> +
> +       if (adev->family >=3D AMDGPU_FAMILY_NV)
> +               dev_info->pa_sc_tile_steering_override =3D
> +                       adev->gfx.config.pa_sc_tile_steering_override;
> +
> +       dev_info->tcc_disabled_mask =3D adev->gfx.config.tcc_disabled_mas=
k;
> +
> +       /* Combine the chip gen mask with the platform (CPU/mobo) mask. *=
/
> +       pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mas=
k >> 16);
> +       dev_info->pcie_gen =3D fls(pcie_gen_mask);
> +       dev_info->pcie_num_lanes =3D
> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32=
 ? 32 :
> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16=
 ? 16 :
> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12=
 ? 12 :
> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 =
? 8 :
> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 =
? 4 :
> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 =
? 2 : 1;
> +
> +       dev_info->tcp_cache_size =3D adev->gfx.config.gc_tcp_l1_size;
> +       dev_info->num_sqc_per_wgp =3D adev->gfx.config.gc_num_sqc_per_wgp=
;
> +       dev_info->sqc_data_cache_size =3D adev->gfx.config.gc_l1_data_cac=
he_size_per_sqc;
> +       dev_info->sqc_inst_cache_size =3D adev->gfx.config.gc_l1_instruct=
ion_cache_size_per_sqc;
> +       dev_info->gl1c_cache_size =3D adev->gfx.config.gc_gl1c_size_per_i=
nstance *
> +                                   adev->gfx.config.gc_gl1c_per_sa;
> +       dev_info->gl2c_cache_size =3D adev->gfx.config.gc_gl2c_per_gpu;
> +       dev_info->mall_size =3D adev->gmc.mall_size;
> +
> +
> +       if (adev->gfx.funcs->get_gfx_shadow_info) {
> +               struct amdgpu_gfx_shadow_info shadow_info;
> +
> +               ret =3D amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info=
);
> +               if (!ret) {
> +                       dev_info->shadow_size =3D shadow_info.shadow_size=
;
> +                       dev_info->shadow_alignment =3D shadow_info.shadow=
_alignment;
> +                       dev_info->csa_size =3D shadow_info.csa_size;
> +                       dev_info->csa_alignment =3D shadow_info.csa_align=
ment;
> +               }
> +       }
> +       return ret;
> +}

As noted by Lijo, this should probably be a void function since we
want to populate as much information as we can and we can't break the
IOCTL interface.

Alex

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index a66d47865e3b..24f775c68a51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -850,125 +850,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>         }
>         case AMDGPU_INFO_DEV_INFO: {
>                 struct drm_amdgpu_info_device *dev_info;
> -               uint64_t vm_size;
> -               uint32_t pcie_gen_mask;
>
>                 dev_info =3D kzalloc(sizeof(*dev_info), GFP_KERNEL);
>                 if (!dev_info)
>                         return -ENOMEM;
>
> -               dev_info->device_id =3D adev->pdev->device;
> -               dev_info->chip_rev =3D adev->rev_id;
> -               dev_info->external_rev =3D adev->external_rev_id;
> -               dev_info->pci_rev =3D adev->pdev->revision;
> -               dev_info->family =3D adev->family;
> -               dev_info->num_shader_engines =3D adev->gfx.config.max_sha=
der_engines;
> -               dev_info->num_shader_arrays_per_engine =3D adev->gfx.conf=
ig.max_sh_per_se;
> -               /* return all clocks in KHz */
> -               dev_info->gpu_counter_freq =3D amdgpu_asic_get_xclk(adev)=
 * 10;
> -               if (adev->pm.dpm_enabled) {
> -                       dev_info->max_engine_clock =3D amdgpu_dpm_get_scl=
k(adev, false) * 10;
> -                       dev_info->max_memory_clock =3D amdgpu_dpm_get_mcl=
k(adev, false) * 10;
> -                       dev_info->min_engine_clock =3D amdgpu_dpm_get_scl=
k(adev, true) * 10;
> -                       dev_info->min_memory_clock =3D amdgpu_dpm_get_mcl=
k(adev, true) * 10;
> -               } else {
> -                       dev_info->max_engine_clock =3D
> -                               dev_info->min_engine_clock =3D
> -                                       adev->clock.default_sclk * 10;
> -                       dev_info->max_memory_clock =3D
> -                               dev_info->min_memory_clock =3D
> -                                       adev->clock.default_mclk * 10;
> -               }
> -               dev_info->enabled_rb_pipes_mask =3D adev->gfx.config.back=
end_enable_mask;
> -               dev_info->num_rb_pipes =3D adev->gfx.config.max_backends_=
per_se *
> -                       adev->gfx.config.max_shader_engines;
> -               dev_info->num_hw_gfx_contexts =3D adev->gfx.config.max_hw=
_contexts;
> -               dev_info->ids_flags =3D 0;
> -               if (adev->flags & AMD_IS_APU)
> -                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;
> -               if (adev->gfx.mcbp)
> -                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPT=
ION;
> -               if (amdgpu_is_tmz(adev))
> -                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ;
> -               if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
> -                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_CONFORM=
ANT_TRUNC_COORD;
> -
> -               vm_size =3D adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SI=
ZE;
> -               vm_size -=3D AMDGPU_VA_RESERVED_TOP;
> -
> -               /* Older VCE FW versions are buggy and can handle only 40=
bits */
> -               if (adev->vce.fw_version &&
> -                   adev->vce.fw_version < AMDGPU_VCE_FW_53_45)
> -                       vm_size =3D min(vm_size, 1ULL << 40);
> -
> -               dev_info->virtual_address_offset =3D AMDGPU_VA_RESERVED_B=
OTTOM;
> -               dev_info->virtual_address_max =3D
> -                       min(vm_size, AMDGPU_GMC_HOLE_START);
> -
> -               if (vm_size > AMDGPU_GMC_HOLE_START) {
> -                       dev_info->high_va_offset =3D AMDGPU_GMC_HOLE_END;
> -                       dev_info->high_va_max =3D AMDGPU_GMC_HOLE_END | v=
m_size;
> -               }
> -               dev_info->virtual_address_alignment =3D max_t(u32, PAGE_S=
IZE, AMDGPU_GPU_PAGE_SIZE);
> -               dev_info->pte_fragment_size =3D (1 << adev->vm_manager.fr=
agment_size) * AMDGPU_GPU_PAGE_SIZE;
> -               dev_info->gart_page_size =3D max_t(u32, PAGE_SIZE, AMDGPU=
_GPU_PAGE_SIZE);
> -               dev_info->cu_active_number =3D adev->gfx.cu_info.number;
> -               dev_info->cu_ao_mask =3D adev->gfx.cu_info.ao_cu_mask;
> -               dev_info->ce_ram_size =3D adev->gfx.ce_ram_size;
> -               memcpy(&dev_info->cu_ao_bitmap[0], &adev->gfx.cu_info.ao_=
cu_bitmap[0],
> -                      sizeof(adev->gfx.cu_info.ao_cu_bitmap));
> -               memcpy(&dev_info->cu_bitmap[0], &adev->gfx.cu_info.bitmap=
[0],
> -                      sizeof(dev_info->cu_bitmap));
> -               dev_info->vram_type =3D adev->gmc.vram_type;
> -               dev_info->vram_bit_width =3D adev->gmc.vram_width;
> -               dev_info->vce_harvest_config =3D adev->vce.harvest_config=
;
> -               dev_info->gc_double_offchip_lds_buf =3D
> -                       adev->gfx.config.double_offchip_lds_buf;
> -               dev_info->wave_front_size =3D adev->gfx.cu_info.wave_fron=
t_size;
> -               dev_info->num_shader_visible_vgprs =3D adev->gfx.config.m=
ax_gprs;
> -               dev_info->num_cu_per_sh =3D adev->gfx.config.max_cu_per_s=
h;
> -               dev_info->num_tcc_blocks =3D adev->gfx.config.max_texture=
_channel_caches;
> -               dev_info->gs_vgt_table_depth =3D adev->gfx.config.gs_vgt_=
table_depth;
> -               dev_info->gs_prim_buffer_depth =3D adev->gfx.config.gs_pr=
im_buffer_depth;
> -               dev_info->max_gs_waves_per_vgt =3D adev->gfx.config.max_g=
s_threads;
> -
> -               if (adev->family >=3D AMDGPU_FAMILY_NV)
> -                       dev_info->pa_sc_tile_steering_override =3D
> -                               adev->gfx.config.pa_sc_tile_steering_over=
ride;
> -
> -               dev_info->tcc_disabled_mask =3D adev->gfx.config.tcc_disa=
bled_mask;
> -
> -               /* Combine the chip gen mask with the platform (CPU/mobo)=
 mask. */
> -               pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie=
_gen_mask >> 16);
> -               dev_info->pcie_gen =3D fls(pcie_gen_mask);
> -               dev_info->pcie_num_lanes =3D
> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUP=
PORT_X32 ? 32 :
> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUP=
PORT_X16 ? 16 :
> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUP=
PORT_X12 ? 12 :
> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUP=
PORT_X8 ? 8 :
> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUP=
PORT_X4 ? 4 :
> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUP=
PORT_X2 ? 2 : 1;
> -
> -               dev_info->tcp_cache_size =3D adev->gfx.config.gc_tcp_l1_s=
ize;
> -               dev_info->num_sqc_per_wgp =3D adev->gfx.config.gc_num_sqc=
_per_wgp;
> -               dev_info->sqc_data_cache_size =3D adev->gfx.config.gc_l1_=
data_cache_size_per_sqc;
> -               dev_info->sqc_inst_cache_size =3D adev->gfx.config.gc_l1_=
instruction_cache_size_per_sqc;
> -               dev_info->gl1c_cache_size =3D adev->gfx.config.gc_gl1c_si=
ze_per_instance *
> -                                           adev->gfx.config.gc_gl1c_per_=
sa;
> -               dev_info->gl2c_cache_size =3D adev->gfx.config.gc_gl2c_pe=
r_gpu;
> -               dev_info->mall_size =3D adev->gmc.mall_size;
> -
> -
> -               if (adev->gfx.funcs->get_gfx_shadow_info) {
> -                       struct amdgpu_gfx_shadow_info shadow_info;
> -
> -                       ret =3D amdgpu_gfx_get_gfx_shadow_info(adev, &sha=
dow_info);
> -                       if (!ret) {
> -                               dev_info->shadow_size =3D shadow_info.sha=
dow_size;
> -                               dev_info->shadow_alignment =3D shadow_inf=
o.shadow_alignment;
> -                               dev_info->csa_size =3D shadow_info.csa_si=
ze;
> -                               dev_info->csa_alignment =3D shadow_info.c=
sa_alignment;
> -                       }
> +               ret =3D amdgpu_device_info(adev, dev_info);
> +               if (!ret) {
> +                       kfree(dev_info);
> +                       return ret;
>                 }
>
>                 ret =3D copy_to_user(out, dev_info,
> --
> 2.34.1
>

