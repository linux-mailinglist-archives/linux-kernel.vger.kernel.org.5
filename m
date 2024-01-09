Return-Path: <linux-kernel+bounces-20883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFD8286EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EADB21479
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0929538F94;
	Tue,  9 Jan 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jU5PKP4X"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FD364B1;
	Tue,  9 Jan 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704806222; x=1736342222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ihxOcoZFqQuef3p7QpoEpM4S1os2BeySro+nkg4iCeQ=;
  b=jU5PKP4XYzIMryLQCNNfeeQVWFUN3rxUVpl6/PC6+ZEusu6p1m2tbQ4K
   KYaTFx3MqVLvyZfzLwXm47W7hzhwLMF4G6gAz+gnpjfQULFv1WUtmc+L4
   Vh1GqUNw+uAdVbZJ6HQeO3BmZW0zxKbTFmDRSEQoAz1OGjw/S3enHJBIV
   BjIkBgCN+uAPdSoLVuGjZ3aq+NucChKmtoQBhb7V3s6VQVoGjtrwhw1ws
   IZvVj1XTSCAA1idk79G6DJeT3hV9QZeFaN++DVi3uMZoeHoU+sjES2mSq
   DBByhv5QF2a1bTVdlklY81/4Jk23CGGbPQbUnumvWVpuUbhzt1NlX2D9J
   g==;
X-CSE-ConnectionGUID: 8DnlKZ+ZQwSkClDLSa6VCw==
X-CSE-MsgGUID: SdkBD+VwRueN9nz+AZ71CA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="asc'?scan'208";a="14447694"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 06:17:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 06:16:34 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 9 Jan 2024 06:16:31 -0700
Date: Tue, 9 Jan 2024 13:15:56 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.1 000/150] 6.1.72-rc1 review
Message-ID: <20240109-landed-unopposed-8fa740e75498@wendy>
References: <20240108153511.214254205@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yy8HAsFI/r8rc1mj"
Content-Disposition: inline
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>

--Yy8HAsFI/r8rc1mj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2024 at 04:34:11PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.72 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Yy8HAsFI/r8rc1mj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ1HDAAKCRB4tDGHoIJi
0oISAP92IR40UrZEt5nUrMCsiiahMFDWslFt2JorSF0Oy3jX+AEApNO75/Ymg/9/
puBnkvQWLP2XclOt/vzXDnDMRZhUTQ8=
=AkpW
-----END PGP SIGNATURE-----

--Yy8HAsFI/r8rc1mj--

