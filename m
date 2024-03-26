Return-Path: <linux-kernel+bounces-119165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5A88C504
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84571F25195
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3312D769;
	Tue, 26 Mar 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="l9P00FDl"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839916CDD4;
	Tue, 26 Mar 2024 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462845; cv=none; b=dFjEll2Zl3Dnm3k+/5i4BJW4QYRd4ss/Ll9f6f0FyYI1pfsr8kT7MmOafzq/x3ZtyLceKu0DONs6sTQpJee0Zdhauh8CenA4gnGu4WwA29lxv+5sB0LLIc5wz0daZLvJuY1xY0vNbfTrwBPa0gndEzFV4o5jDWxyGc/bsdLwDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462845; c=relaxed/simple;
	bh=if5DUb4DP6NnvHHBGuS7LuwnpVjsUWsLGW/0tqrirNA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alpvVVvNj9poMegINuljvhfAb0FeqRiH6wHt3snckhTK14V7ZcfZgUfiNDCCroKoopW7Votp3qYOqXpFVhvrUCkzktLb2+9xL5hMzZMpGZNevJw7J3clFBDKG6yY0bz5uXB0ysTq3XPwDV8hhatcpGr0YMgGJN7/YFUwQ6inAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=l9P00FDl; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711462840; x=1711722040;
	bh=if5DUb4DP6NnvHHBGuS7LuwnpVjsUWsLGW/0tqrirNA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=l9P00FDlX4P2CKWaah6rjobZGW9iIpYYoXe+Nw4TnTa+Wx3K5PVWfJNYLnbmWLSha
	 7QiT1pzfrVkd9GHuXCeJxoU4/uaoObnBQQzWJHPsa3OjwESMYk0fEUTYbju/DspBcM
	 I+SJcXTFyPKv9SYOoj/nOhochfLhfgAZF80cYyTmkngKLnLwCPd1n0s4sS9y12jnAz
	 FD29SKsuW2WnKhPq14+ZMlJ8nG33mkwjl5NNg9eGpU1LpYaGqf52nE/0J825I5Er45
	 rZWm8I8yhHo5qG54WkPoYeJoiOF2e6qx+M4i5LsIEVgDX5C2iehHtsLdVcblrc4xxM
	 nJ5Xg4YDrG8yg==
Date: Tue, 26 Mar 2024 14:20:34 +0000
To: Yazen Ghannam <yazen.ghannam@amd.com>, "bp@alien8.de" <bp@alien8.de>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
From: A <akira.2020@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/AMD/FMPM: Fix build when debugfs is not enabled
Message-ID: <i2PhAcMufioQc2nhVgO9T23CcF8UsgJo8CWPOl_7lV3iF00GdywfpQa2Hu-yPX3bD4o5wpfUtIsRBIhFH1j3k9aNoUJfgGALNWUUjMokpFc=@protonmail.com>
In-Reply-To: <eede2586-f143-4107-a065-2860ed413d0a@amd.com>
References: <20240325183755.776-1-bp@alien8.de> <eede2586-f143-4107-a065-2860ed413d0a@amd.com>
Feedback-ID: 7267082:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Tuesday, March 26th, 2024 at 13:41, Yazen Ghannam <yazen.ghannam@amd.com=
> wrote:

>=20
>=20
>=20
> On 3/25/24 14:37, Borislav Petkov wrote:
>=20
> > From: "Borislav Petkov (AMD)" bp@alien8.de
> >=20
> > Have the driver depend on DEBUG_FS as it is useless without it.
>=20
>=20
> This isn't true which is why the module doesn't fail to load if debugfs
> is not available.
>=20
> > Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218640
> > Reported-by: anthony s.k. akira.2020@protonmail.com
> > Signed-off-by: Borislav Petkov (AMD) bp@alien8.de
> > Cc: Yazen Ghannam yazen.ghannam@amd.com
> > ---
> > drivers/ras/Kconfig | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> > index fc4f4bb94a4c..41697e326fa6 100644
> > --- a/drivers/ras/Kconfig
> > +++ b/drivers/ras/Kconfig
> > @@ -37,7 +37,7 @@ source "drivers/ras/amd/atl/Kconfig"
> > config RAS_FMPM
> > tristate "FRU Memory Poison Manager"
> > default m
> > - depends on AMD_ATL && ACPI_APEI
> > + depends on AMD_ATL && ACPI_APEI && DEBUG_FS
>=20
>=20
> This was my first thought too. However, besides not true as stated
> above, this also leaves the issue open for others to hit.
>=20
> I think the fix below (not tested) would be more appropriate.
>=20
> What do you think?
>=20
> Thanks,
> Yazen
>=20
> diff --git a/drivers/ras/debugfs.h b/drivers/ras/debugfs.h
> index 4749ccdeeba1..ab95831e7710 100644
> --- a/drivers/ras/debugfs.h
> +++ b/drivers/ras/debugfs.h
> @@ -4,6 +4,10 @@
>=20
> #include <linux/debugfs.h>
>=20
>=20
> +#if IS_ENABLED(DEBUG_FS)
> struct dentry *ras_get_debugfs_root(void);
> +#else
> +static inline struct dentry ras_get_debugfs_root(void) { return NULL; }
> +#endif / DEBUG_FS /
>=20
> #endif / RAS_DEBUGFS_H */

this also works, just tested

this time round, `make oldconfig` asks if i want to build RAS_FMPM, i built=
 it as module, compilation succeeds.

thanks

kind regards,
anthony s.k.

