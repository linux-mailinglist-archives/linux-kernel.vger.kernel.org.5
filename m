Return-Path: <linux-kernel+bounces-155639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE058AF519
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE35B28C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9330E14387F;
	Tue, 23 Apr 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CKt+2a7q"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A11422A0;
	Tue, 23 Apr 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891995; cv=none; b=LvIX3mZemivSVBX6jLgLSv55RtbvoquFvWeLpf0Nwk02SUf7JOjX67YICQk+Qxu/E0n0TbpLvJiuVjQTux8mdqFaNTH40kc25s/vVTQ8JRtTnbcRAtFv536rQtghHd6tKOP95/jHBvHJu0y06oQoVVFWP8ZzBBeMtMJchy0dGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891995; c=relaxed/simple;
	bh=e6wR4BARVgMdhJ5VzQ62zkltutRMMG8sEmFGQKnr7+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV8vhQchGF7YEXeu+S6rMcpyp/++zMTWVIhjPkQ9Mx4okAbO1kfcTj/4WhQrRaIIdZrhD/EXMLPtnnx8C88Z+Xf2p0x16ee4UJfTCrV1HwMlOzfrRYDzpbitjakU/w0h+v0LqOMtqyJnpMfGzIuZgyYaZ+cEUPHfcXnH1+xtuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CKt+2a7q reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B827640E0249;
	Tue, 23 Apr 2024 17:06:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nGZKVV3J7b96; Tue, 23 Apr 2024 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713891981; bh=iQJOSIJL4Xjn6S3YiA6TxT0Lb+QTve77cH6mIMNE2E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKt+2a7qUJrRF4MnQ1wJQ//xnuXYIuFgFWNnJZBsGgAY0K8ueAp/3kV3SQaS3NRfR
	 qA6A8urIz/UF00UpM4EzcSCVkzb2PvxVOL4167ggPnt6gUcoXK5//wyTuYIoRSNOmd
	 AnHdtrwY4WCMvmwCV+KQ/SY9ckeu9PlyP1ulrRFmjE3Twm+bvzP+1NU9hg9VGTHjVK
	 ECWy1FTwghhdMVFCkaLypyrf0vXqs1aRIbC1WewEbnH71+NfW6rrfAJRSi5TR/ZigU
	 PlRs4QboA4K4w/3z86zJAsRH60SIrEQRq3MpQ/6C1fsosiglm32w3wM8ODYgB23RdW
	 DSJxlCnt7oB0iK5aLQIjCQ0mioR0WoO6BE7QPq9t+5v5aP4LpC3DO3EPa/an/WFRc9
	 dEjByUv70CevJsFsp39RaQdxTmR/xeVpBDbQd9OTcum3VPvWx91eB4jHVlZs7+s/Mr
	 ShggLJKzQPknaBTGL2pXhr9zDtXyKxHdZf8qgPy8DYXmqnjIbWLUqam9d//L3tP+Ag
	 r0fpz2Es+cFGwkQ0wcvX0Ll5Pzryhu7KoS4SLDlWdWMcUHnGRv2Xho2s3TrsXOpm7T
	 /B4iKZlu98+/2eIthBnsZGjvA/ZhB0bnWNP/j/hUjzwvcDmJdFBKXp2tL0bfWv6wRQ
	 5IDC6qBSkUnmarrM2juyuXNc=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C8DD40E00B2;
	Tue, 23 Apr 2024 17:06:14 +0000 (UTC)
Date: Tue, 23 Apr 2024 19:06:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 04/16] x86/mce/amd: Look up bank type by IPID
Message-ID: <20240423170608.GCZifqgD-N2B7vm6_D@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-5-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404151359.47970-5-yazen.ghannam@amd.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 10:13:47AM -0500, Yazen Ghannam wrote:
> Scalable MCA systems use values within the MCA_IPID register to describ=
e
> a bank's type. Other information is not needed.
>=20
> Currently, the bank types are cached during boot and this information i=
s
> used during boot and run time. The cached values are per-CPU and
> per-bank. The boot path needs the cached values, but this should be
> removed. The run time path does not need the cached values.
>=20
> Determine a Scalable MCA bank's type using only the MCA_IPID values.

Lemme get this straight: You want to switch it all to use this new array
smca_hwid_mcatypes[] to lookup HWIDs?

If so, where is the patch which removes the _old thing?

>  arch/x86/include/asm/mce.h              |  4 +-
>  arch/x86/kernel/cpu/mce/amd.c           | 99 ++++++++++++++++++++++---
>  drivers/edac/amd64_edac.c               |  2 +-
>  drivers/edac/mce_amd.c                  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-

$ ./scripts/get_maintainer.pl -f drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Alex Deucher <alexander.deucher@amd.com> (supporter:RADEON and AMDGPU DRM=
 DRIVERS,commit_signer:91/89=3D100%)
"Christian K=C3=B6nig" <christian.koenig@amd.com> (supporter:RADEON and A=
MDGPU DRM DRIVERS)
"Pan, Xinhui" <Xinhui.Pan@amd.com> (supporter:RADEON and AMDGPU DRM DRIVE=
RS)
David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS
..

You need to CC folks on changes touching their area...

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

