Return-Path: <linux-kernel+bounces-102496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8694B87B2F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7734F1C25A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D48C4176C;
	Wed, 13 Mar 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxsRZXEA"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B722071
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710362185; cv=none; b=cdcR259XgsMKXfhbMmMmnsewsobTzM9cbmTGG2Bl3raJ3QrDDdGNCkkw9KZFbMaddbYRpOULhZ4Zr5yS07WP2k5MJ1kSXnH9gS0zHCr7AcJBfg3DALuKDeLHyPWINea/2//T9Td6erBC52iptEnVWrYQmUHsiyPKR3Wm6A8EVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710362185; c=relaxed/simple;
	bh=0mfDiAPrv7L6/61UPrOHWw2aguiUfXM8CK0/z5DHJIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1OgFyPDxfXyv50xqVS2VanS2Y2KVqHlCUDv1mJcx0onee6k/llFdSPHZdMjLKqY+XlBtIGZsVmsispwG2G6wpXMCxXy0j/0n5HDMf3D9olAncrjTfOrKKM8FAUXeqac5sXskSV+vxI3+nMLz8w2GAdbx3Of3sIpUPZTNB+XzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxsRZXEA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29bad5f4ae8so288429a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710362183; x=1710966983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0P1jMyCYtposYh4opD70xwEj0+xfXkkQO/G2AgEGYg=;
        b=SxsRZXEAnojJeodA3JracoEwdxsCVSo54ncORu/leB5supxraTd/+Dj21hg7X++50A
         /yaJhmzcV0BYdX1npXdp3uTHXynMTujrJRQiIcYoXemf7jThkd8NNebaveaUZdhqqNaU
         Cf5+oiNgS/tnhJ/36AcxZgz05Xnjaz/MvsCxUb92KblGVuekpa32xCXDcNLqTqhtVciS
         dxwnSRycNjvVdwSG3gucyDnNCPM72VBKc6kqKx06I2arpKSk20oeVoVVqeR6HZLptKWc
         hvjNnwxTHWAjNV/L0VhOiAELVqcNdD8+aWAjLUOhYpWyHPoSx1nJ2UfXGlWSj3TwYwan
         u2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710362183; x=1710966983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0P1jMyCYtposYh4opD70xwEj0+xfXkkQO/G2AgEGYg=;
        b=WyPHz9IjBpPUTYb/mEYvPuYafxFVzmC4vcrvsnIuT06OpA/Ces0ICm9egarucK84k2
         EQtyKE3PybTZtlFSbKtEdm7tx7R6V5pji53juaBoal+v1HU/t6Mu/PDPU4V+5+IFp9qo
         S33ag1LzZTucgrHmhmKAFuZbiuq3JGh6LepUx3NRrHXWm/34ExnNtpporAkkVt9lOZJf
         1mnsfvjPjAwzgLARihICdq/wcCPWIKezRG2vuWiOgcX/aGuCqmRB8YmVF5pDCl9+szdb
         b3Uzi5hQu77iTsyOpDdqHowIVgGZUMU80UTTrvc8liuf7jantFrvW9M7J1xqgwatwqXH
         1F1A==
X-Forwarded-Encrypted: i=1; AJvYcCXP9dycNz8WL2aWOYoy3tCwiG2I+Cq6MwkcG5017dLLfX/xeo2iLxq3iii79JS2oiK6NsJdtcXfcaJJXug48MK+s0MmPNG3vWULkeNo
X-Gm-Message-State: AOJu0YxQaDFbk2V4VqI+P9EUH1zwwUL54kDAYQI++qLm45aixkYnazAU
	uiYRx+yAug/JWT0h2Ra/riZ07HcqFG6aoKToEQ4/6wYOUZjR38ilJBQyBWm2ae5DrGrnOKtaFVb
	o3DfynVGtdQuJtf+tlepU6Mo38Ws=
X-Google-Smtp-Source: AGHT+IE8QOUe7k7X0QgjCkT37L75/xjPFxnl01fGGykO8p1LaCf9vr0q8ZdUbELBJFYpJW6yKCReepjlKYkkQPaEXmo=
X-Received: by 2002:a17:90a:488f:b0:29b:ce33:492d with SMTP id
 b15-20020a17090a488f00b0029bce33492dmr11380791pjh.22.1710362182844; Wed, 13
 Mar 2024 13:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312124148.257067-1-sunil.khatri@amd.com> <20240312124148.257067-2-sunil.khatri@amd.com>
In-Reply-To: <20240312124148.257067-2-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Mar 2024 16:36:11 -0400
Message-ID: <CADnq5_ON0NfcpmnHKjNYWgxfvfz-J3tgjX92DaaN63iKb+FOZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm:amdgpu: add firmware information of all IP's
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 8:42=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add firmware version information of each
> IP and each instance where applicable.
>

Is there a way we can share some common code with devcoredump,
debugfs, and the info IOCTL?  All three places need to query this
information and the same logic is repeated in each case.

Alex


> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 122 ++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index 611fdb90a1fc..78ddc58aef67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -168,6 +168,123 @@ void amdgpu_coredump(struct amdgpu_device *adev, bo=
ol vram_lost,
>  {
>  }
>  #else
> +static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev, struc=
t drm_printer *p)
> +{
> +       uint32_t version;
> +       uint32_t feature;
> +       uint8_t smu_program, smu_major, smu_minor, smu_debug;
> +
> +       drm_printf(p, "VCE feature version: %u, fw version: 0x%08x\n",
> +                  adev->vce.fb_version, adev->vce.fw_version);
> +       drm_printf(p, "UVD feature version: %u, fw version: 0x%08x\n",
> +                  0, adev->uvd.fw_version);
> +       drm_printf(p, "GMC feature version: %u, fw version: 0x%08x\n",
> +                  0, adev->gmc.fw_version);
> +       drm_printf(p, "ME feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.me_feature_version, adev->gfx.me_fw_version)=
;
> +       drm_printf(p, "PFP feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.pfp_feature_version, adev->gfx.pfp_fw_versio=
n);
> +       drm_printf(p, "CE feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.ce_feature_version, adev->gfx.ce_fw_version)=
;
> +       drm_printf(p, "RLC feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.rlc_feature_version, adev->gfx.rlc_fw_versio=
n);
> +
> +       drm_printf(p, "RLC SRLC feature version: %u, fw version: 0x%08x\n=
",
> +                  adev->gfx.rlc_srlc_feature_version,
> +                  adev->gfx.rlc_srlc_fw_version);
> +       drm_printf(p, "RLC SRLG feature version: %u, fw version: 0x%08x\n=
",
> +                  adev->gfx.rlc_srlg_feature_version,
> +                  adev->gfx.rlc_srlg_fw_version);
> +       drm_printf(p, "RLC SRLS feature version: %u, fw version: 0x%08x\n=
",
> +                  adev->gfx.rlc_srls_feature_version,
> +                  adev->gfx.rlc_srls_fw_version);
> +       drm_printf(p, "RLCP feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.rlcp_ucode_feature_version,
> +                  adev->gfx.rlcp_ucode_version);
> +       drm_printf(p, "RLCV feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.rlcv_ucode_feature_version,
> +                  adev->gfx.rlcv_ucode_version);
> +       drm_printf(p, "MEC feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.mec_feature_version,
> +                  adev->gfx.mec_fw_version);
> +
> +       if (adev->gfx.mec2_fw)
> +               drm_printf(p,
> +                          "MEC2 feature version: %u, fw version: 0x%08x\=
n",
> +                          adev->gfx.mec2_feature_version,
> +                          adev->gfx.mec2_fw_version);
> +
> +       drm_printf(p, "IMU feature version: %u, fw version: 0x%08x\n",
> +                  0, adev->gfx.imu_fw_version);
> +       drm_printf(p, "PSP SOS feature version: %u, fw version: 0x%08x\n"=
,
> +                  adev->psp.sos.feature_version,
> +                  adev->psp.sos.fw_version);
> +       drm_printf(p, "PSP ASD feature version: %u, fw version: 0x%08x\n"=
,
> +                  adev->psp.asd_context.bin_desc.feature_version,
> +                  adev->psp.asd_context.bin_desc.fw_version);
> +
> +       drm_printf(p, "TA XGMI feature version: 0x%08x, fw version: 0x%08=
x\n",
> +                  adev->psp.xgmi_context.context.bin_desc.feature_versio=
n,
> +                  adev->psp.xgmi_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA RAS feature version: 0x%08x, fw version: 0x%08x=
\n",
> +                  adev->psp.ras_context.context.bin_desc.feature_version=
,
> +                  adev->psp.ras_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA HDCP feature version: 0x%08x, fw version: 0x%08=
x\n",
> +                  adev->psp.hdcp_context.context.bin_desc.feature_versio=
n,
> +                  adev->psp.hdcp_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA DTM feature version: 0x%08x, fw version: 0x%08x=
\n",
> +                  adev->psp.dtm_context.context.bin_desc.feature_version=
,
> +                  adev->psp.dtm_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA RAP feature version: 0x%08x, fw version: 0x%08x=
\n",
> +                  adev->psp.rap_context.context.bin_desc.feature_version=
,
> +                  adev->psp.rap_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA SECURE DISPLAY feature version: 0x%08x, fw vers=
ion: 0x%08x\n",
> +               adev->psp.securedisplay_context.context.bin_desc.feature_=
version,
> +               adev->psp.securedisplay_context.context.bin_desc.fw_versi=
on);
> +
> +       /* SMC firmware */
> +       version =3D adev->pm.fw_version;
> +
> +       smu_program =3D (version >> 24) & 0xff;
> +       smu_major =3D (version >> 16) & 0xff;
> +       smu_minor =3D (version >> 8) & 0xff;
> +       smu_debug =3D (version >> 0) & 0xff;
> +       drm_printf(p, "SMC feature version: %u, program: %d, fw version: =
0x%08x (%d.%d.%d)\n",
> +                  0, smu_program, version, smu_major, smu_minor, smu_deb=
ug);
> +
> +       /* SDMA firmware */
> +       for (int i =3D 0; i < adev->sdma.num_instances; i++) {
> +               drm_printf(p, "SDMA%d feature version: %u, firmware versi=
on: 0x%08x\n",
> +                          i, adev->sdma.instance[i].feature_version,
> +                          adev->sdma.instance[i].fw_version);
> +       }
> +
> +       drm_printf(p, "VCN feature version: %u, fw version: 0x%08x\n",
> +                  0, adev->vcn.fw_version);
> +       drm_printf(p, "DMCU feature version: %u, fw version: 0x%08x\n",
> +                  0, adev->dm.dmcu_fw_version);
> +       drm_printf(p, "DMCUB feature version: %u, fw version: 0x%08x\n",
> +                  0, adev->dm.dmcub_fw_version);
> +       drm_printf(p, "PSP TOC feature version: %u, fw version: 0x%08x\n"=
,
> +                  adev->psp.toc.feature_version, adev->psp.toc.fw_versio=
n);
> +
> +       version =3D adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK;
> +       feature =3D (adev->mes.kiq_version & AMDGPU_MES_FEAT_VERSION_MASK=
)
> +                                       >> AMDGPU_MES_FEAT_VERSION_SHIFT;
> +       drm_printf(p, "MES_KIQ feature version: %u, fw version: 0x%08x\n"=
,
> +                  feature, version);
> +
> +       version =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
> +       feature =3D (adev->mes.sched_version & AMDGPU_MES_FEAT_VERSION_MA=
SK)
> +                                       >> AMDGPU_MES_FEAT_VERSION_SHIFT;
> +       drm_printf(p, "MES feature version: %u, fw version: 0x%08x\n",
> +                  feature, version);
> +
> +       drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
> +                  adev->vpe.feature_version, adev->vpe.fw_version);
> +
> +}
> +
>  static ssize_t
>  amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>                         void *data, size_t datalen)
> @@ -215,6 +332,11 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset,=
 size_t count,
>                 }
>         }
>
> +       if (coredump->adev) {
> +               drm_printf(&p, "IP Firmwares\n");
> +               amdgpu_devcoredump_fw_info(coredump->adev, &p);
> +       }
> +
>         if (coredump->ring) {
>                 drm_printf(&p, "\nRing timed out details\n");
>                 drm_printf(&p, "IP Type: %d Ring Name: %s\n",
> --
> 2.34.1
>

