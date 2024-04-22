Return-Path: <linux-kernel+bounces-153334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9E8ACCC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43803281D80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9E51031;
	Mon, 22 Apr 2024 12:34:11 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA644317B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789250; cv=none; b=h52SGCpduJ5VXJtjirBtN4/Nv8oFEuVGTPt0tntfJlJfJ4pyjHS3mGkKknrtpLp6zSbak5HQihnjdO0yblMIlJCDhmLtvsRDu9PKH6RLa/o08Tw+1mWn8kY5xNA/lzzGSkYJnG/s/cZGt0AwR5EguqQxIaEJzK37XTunw5Wj7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789250; c=relaxed/simple;
	bh=f3H5pxvDmuQF0CSFx5U8tadrVoOxawUoApqqklC8Um8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2kRM0UVml4taE0RVMMWwdswsNUx0MXuvkieUfQ2ajeMA8UnlA9GKAs2Uhx1j0gqHJN91RG4QFsCYMPdHZUiDTRc6Xb20ciNMF/NhGiDNSrDK22TJnQ1y21fBiBdF2o4PN/IlCjbE3DrCJkHrq8JBbJf5kSZal4+sK3VXva8dks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp78t1713789213twu623c6
X-QQ-Originating-IP: SgAL1Fy0MsgGKP0Q72PwOFeCfZvjOSyZkPnWSd2RTOc=
Received: from john-PC ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Apr 2024 20:33:31 +0800 (CST)
X-QQ-SSF: 01400000000000E0L000000A0000000
X-QQ-FEAT: qO3Ke1AXI6FiX0mGox2a5JZ77O06KnVfxkdt7WtRNjoT1WRzGh5l1fnB0ZwWu
	CdROfDylGJoUzIMN80a1mSt3qhH4vbxVy8ODa3oAv79JlhAhl8aROUnVD47efmI2SLS1Lua
	3yAquli3UAvvvQvTlZ+/XfNZwK5cbQfZErFg3LXaD4oVu035s5PhflGhnhJP3yJKjSP0Hvu
	fHdv+9OnNJIt9B2YAoWxO/JbtzLR2FsLgIde47bINZO0UkIwpjvVs+lepIdXLmTjnpqSU5j
	y+tdONxLDd38Dv3OfFGenyYvjQAzPSlt7Rf2ijMIctPuXxzAKGh7cP380S0I5iRryoadHgi
	WL9UvsQ/w5tf7OJJv+0OKfdoYkyqkUSfKPQhDXUIPcFTjyw4Fqh/9N8ovpwzuZOeic4XqyY
	bYAyUFOm7rZjNCxga892TYmsBl/gAz3S
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13358882969841256668
Date: Mon, 22 Apr 2024 20:33:29 +0800
From: Qiang Ma <maqianga@uniontech.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, srinivasan.shanmugam@amd.com,
 Arunpravin.PaneerSelvam@amd.com, le.ma@amd.com, Felix.Kuehling@amd.com,
 mukul.joshi@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Fixup bad vram size on gmc v6 and v7
Message-ID: <D94775003178862D+20240422203329.49844e71@john-PC>
In-Reply-To: <68f02c5c-5591-4d6f-9926-b0fc6f9f6287@amd.com>
References: <20240422052608.5297-1-maqianga@uniontech.com>
	<68f02c5c-5591-4d6f-9926-b0fc6f9f6287@amd.com>
Organization: UOS
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

On Mon, 22 Apr 2024 11:40:26 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Am 22.04.24 um 07:26 schrieb Qiang Ma:
> > Some boards(like Oland PRO: 0x1002:0x6613) seem to have
> > garbage in the upper 16 bits of the vram size register,
> > kern log as follows:
> >
> > [    6.000000] [drm] Detected VRAM RAM=3D2256537600M, BAR=3D256M
> > [    6.007812] [drm] RAM width 64bits GDDR5
> > [    6.031250] [drm] amdgpu: 2256537600M of VRAM memory ready
> >
> > This is obviously not true, check for this and clamp the size
> > properly. Fixes boards reporting bogus amounts of vram,
> > kern log as follows:
> >
> > [    2.789062] [drm] Probable bad vram size: 0x86800800
> > [    2.789062] [drm] Detected VRAM RAM=3D2048M, BAR=3D256M
> > [    2.789062] [drm] RAM width 64bits GDDR5
> > [    2.789062] [drm] amdgpu: 2048M of VRAM memory ready =20
>=20
> Well we had patches like this one here before and so far we always=20
> rejected them.
>=20
> When the mmCONFIG_MEMSIZE register isn't properly initialized then
> there is something wrong with your hardware.
>=20
> Working around that in the software driver is not going to fly.
>=20
> Regards,
> Christian.
>=20
Hi Christian:
I see that two patches for this issue have been merged, and the
patches are as follows:

11544d77e397 drm/amdgpu: fixup bad vram size on gmc v8
0ca223b029a2 drm/radeon: fixup bad vram size on SI

Qiang Ma

> > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++--
> >   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 13 ++++++++++---
> >   2 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c index
> > 23b478639921..3703695f7789 100644 ---
> > a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c +++
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c @@ -309,8 +309,15 @@ static
> > int gmc_v6_0_mc_init(struct amdgpu_device *adev) }
> >   	adev->gmc.vram_width =3D numchan * chansize;
> >   	/* size in MB on si */
> > -	adev->gmc.mc_vram_size =3D RREG32(mmCONFIG_MEMSIZE) *
> > 1024ULL * 1024ULL;
> > -	adev->gmc.real_vram_size =3D RREG32(mmCONFIG_MEMSIZE) *
> > 1024ULL * 1024ULL;
> > +	tmp =3D RREG32(mmCONFIG_MEMSIZE);
> > +	/* some boards may have garbage in the upper 16 bits */
> > +	if (tmp & 0xffff0000) {
> > +		DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
> > +		if (tmp & 0xffff)
> > +			tmp &=3D 0xffff;
> > +	}
> > +	adev->gmc.mc_vram_size =3D tmp * 1024ULL * 1024ULL;
> > +	adev->gmc.real_vram_size =3D adev->gmc.mc_vram_size;
> >  =20
> >   	if (!(adev->flags & AMD_IS_APU)) {
> >   		r =3D amdgpu_device_resize_fb_bar(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c index
> > 3da7b6a2b00d..1df1fc578ff6 100644 ---
> > a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c +++
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c @@ -316,10 +316,10 @@
> > static void gmc_v7_0_mc_program(struct amdgpu_device *adev) static
> > int gmc_v7_0_mc_init(struct amdgpu_device *adev) {
> >   	int r;
> > +	u32 tmp;
> >  =20
> >   	adev->gmc.vram_width =3D
> > amdgpu_atombios_get_vram_width(adev); if (!adev->gmc.vram_width) {
> > -		u32 tmp;
> >   		int chansize, numchan;
> >  =20
> >   		/* Get VRAM informations */
> > @@ -363,8 +363,15 @@ static int gmc_v7_0_mc_init(struct
> > amdgpu_device *adev) adev->gmc.vram_width =3D numchan * chansize;
> >   	}
> >   	/* size in MB on si */
> > -	adev->gmc.mc_vram_size =3D RREG32(mmCONFIG_MEMSIZE) *
> > 1024ULL * 1024ULL;
> > -	adev->gmc.real_vram_size =3D RREG32(mmCONFIG_MEMSIZE) *
> > 1024ULL * 1024ULL;
> > +	tmp =3D RREG32(mmCONFIG_MEMSIZE);
> > +	/* some boards may have garbage in the upper 16 bits */
> > +	if (tmp & 0xffff0000) {
> > +		DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
> > +		if (tmp & 0xffff)
> > +			tmp &=3D 0xffff;
> > +	}
> > +	adev->gmc.mc_vram_size =3D tmp * 1024ULL * 1024ULL;
> > +	adev->gmc.real_vram_size =3D adev->gmc.mc_vram_size;
> >  =20
> >   	if (!(adev->flags & AMD_IS_APU)) {
> >   		r =3D amdgpu_device_resize_fb_bar(adev); =20
>=20
>=20


