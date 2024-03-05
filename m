Return-Path: <linux-kernel+bounces-91908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E9A87183F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0501F21A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50701EEE8;
	Tue,  5 Mar 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZxRPWhof"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801701DA27;
	Tue,  5 Mar 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627517; cv=none; b=NpiDgRgwG/4ISHlwc5NqllnTEYi2DE7pOLBcK49CJfGyLOqaSZVAPRVybK3GpxrAW/n/Rp+3x8iTdeQXYVzQUNr8LF3npQKW9KBihO+P6Ktk30HMf96ipir4CLci5aLrTEJHCSBSwHlPqqy9OXCe38h1Z71GLhv1ipdYNB2Zv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627517; c=relaxed/simple;
	bh=1ls+uy/JcT9Izmp8DLtQlz60vm6OJVdzHaoUaPD077U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tau39gHaPjP2nw84ftPTQk4SA0eO4H2xsy+s2d+nv3wh5j9vCAhRLb4WUu8gwjm1A/U4MCcHbLsj+dvmX1fHOHB5raMktCS2U/Ddgne9ttCBosM/ES+28ZI9R5xjG3ROiGdDjo4+mvCzFW7vcWiHxGuuoDji6caJZgm71MNW5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZxRPWhof; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709627516; x=1741163516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ls+uy/JcT9Izmp8DLtQlz60vm6OJVdzHaoUaPD077U=;
  b=ZxRPWhofi459kISVp/6N1dtmaxAx33eANyVoOFq2sn0GE2BITrQz3uCL
   jAM3H9cDz5v1sa7XGhC8bflV5/h47IerJjwwIiFIM1hvz5j5eo9nwWX/a
   SzEcV6X1H36IE/DaG9Q2OCqFYrPjS/TSpCyhaDsXA2SRsL2MOsbo3eMje
   AWM7ZOq/QzOHBqST4P609w6fHPV4Ja0XEguyXGWB1cdRNhxeiD0mCtiB/
   r9R4ozGnJMMKVuzASsNRVs43UXRKLUXo9m6I64t85A5SdQ96JlG6Qyd2H
   jOU0G6QBnb3ZwAWkKVTTekQc19AM4uSxoTi8/jlLcCEb2PT5XdGyEf2HO
   A==;
X-CSE-ConnectionGUID: 7FKKTPsjR2WAbsvvBivZpA==
X-CSE-MsgGUID: jVjGN+zkStWvTQpII6UeIA==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
   d="asc'?scan'208";a="247971682"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 01:31:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 01:31:48 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 01:31:45 -0700
Date: Tue, 5 Mar 2024 08:31:00 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
Message-ID: <20240305-arson-panhandle-afa453ccb0aa@wendy>
References: <20240305074649.580820283@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9YXNRHoKRDKSr8iO"
Content-Disposition: inline
In-Reply-To: <20240305074649.580820283@linuxfoundation.org>

--9YXNRHoKRDKSr8iO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> Anything received after that time might be too late.

> Samuel Holland <samuel.holland@sifive.com>
>     riscv: Save/restore envcfg CSR during CPU suspend
>=20
> Samuel Holland <samuel.holland@sifive.com>
>     riscv: Add a custom ISA extension for the [ms]envcfg CSR

I left a comment in response to the off-list email about this patch,
I don't think it's gonna work as the number this custom extension has
been given exceeds the max in 6.7/

Cheers,
Conor.

>=20
> Samuel Holland <samuel.holland@sifive.com>
>     riscv: Fix enabling cbo.zero when running in M-mode

--9YXNRHoKRDKSr8iO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZebYRAAKCRB4tDGHoIJi
0mFJAQDtS2vjwLxDjumw0GA73KurLViHOrB/jXXRxjsoGntZ1AEA2Ll5Ka2LMesH
hywdAGgz1JFjaY9uLkITb3CuQaSoqwE=
=4eM9
-----END PGP SIGNATURE-----

--9YXNRHoKRDKSr8iO--

