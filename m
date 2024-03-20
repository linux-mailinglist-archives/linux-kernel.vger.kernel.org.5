Return-Path: <linux-kernel+bounces-108595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA6880CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A2FB21C32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5292A2C85A;
	Wed, 20 Mar 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m0WSIvTe"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD12BD1F;
	Wed, 20 Mar 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922205; cv=none; b=KAp/2oiFzbMxoYMcFFNEhf45X43ia0E4Y63wg7xEK5B2BqGG0mE0yCfwVARnZVQWRitM81fJyJFew+mMvYxu1rmj3UB9Hwr01QaZ1MDue050OQIE5p5gbi2Y61kjo8bnjicLjmzZoL79MW9+6mnMaQwDDUc76McxnlagZbAs4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922205; c=relaxed/simple;
	bh=AfCnug0umUcdT2gosXp103HrYU4EPJM44slnpZb1jv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuBMF78dpHwYqE2V1r49tOpA7hkyMX0Hv6MITuoaPke5im9CEz+8Zpfh4VAfR1+PrnC8HsFd+FlMfRmIXXlRMo38b3JHh5JrtU2GIuCdVvLr7ztxdgk9Yy6kDAaw6RskS3pnd/OKw97WH944gkxX1LOwkwNV8IrnJYurWLMLVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m0WSIvTe; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710922203; x=1742458203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AfCnug0umUcdT2gosXp103HrYU4EPJM44slnpZb1jv0=;
  b=m0WSIvTedQOPaYURL9S8f8A2saKfjS5IC1TvRP2OIJvN0xpQFxrC5gJU
   5OWdkYvcIK6P113s4B1QeoDpHJnkXF1WAv9GrCICahMGprgvKaE9EgFPR
   HdmZnkcOFC0tfUmIFcmIEm9eIn1OI1BxJYDp27LSfKJI1YJOlaHgyxWou
   crVLf2LmPMRaWuiCFtVln/L0Ns1AeAlzAUmmqth5uWzmuMoMCpDDMbcml
   I+LT7d+BhTI5k1m6/Xks6P6Jwxb50dJ5iPJGy11ioWdXz5FtmbSmpMper
   2pImnr/x2hH0TluwIUzg98q60IO8b1vDDU8VE977rF1/GkG/d3huelDhh
   g==;
X-CSE-ConnectionGUID: eZhPXw6WRumqhkMBxQG74g==
X-CSE-MsgGUID: a6qsqpTMSjOeZ0F7tAolvA==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="asc'?scan'208";a="18421063"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2024 01:10:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 01:09:31 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:09:27 -0700
Date: Wed, 20 Mar 2024 08:08:41 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Joshua Yeong <joshua.yeong@starfivetech.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <geert+renesas@glider.be>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, <alexghiti@rivosinc.com>,
	<evan@rivosinc.com>, <ajones@ventanamicro.com>, <heiko@sntech.de>,
	<guoren@kernel.org>, <uwu@icenowy.me>, <jszhang@kernel.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <leyfoon.tan@starfivetech.com>,
	<jeeheng.sia@starfivetech.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add StarFive's StarLink-500 Cache Controller
Message-ID: <20240320-implement-finishing-136eae51d659@wendy>
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
 <20240317-viral-handcraft-12b2519ff1be@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iOmun+xjPn985xOw"
Content-Disposition: inline
In-Reply-To: <20240317-viral-handcraft-12b2519ff1be@spud>

--iOmun+xjPn985xOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 03:01:05PM +0000, Conor Dooley wrote:
> On Thu, Mar 14, 2024 at 02:12:01PM +0800, Joshua Yeong wrote:
> > StarFive's StarLink-500 Cache Controller flush/invalidates cache using =
non-
> > conventional CMO method. This driver provides the cache handling on Sta=
rFive
> > RISC-V SoC.
>=20
> Unlike the other "non-conventional" CMO methods, the jh8100 does not
> pre-date the Zicbom extension. Why has that not been implemented?

Stefan pointed out on IRC yesterday that one of the main selling points
is the ease of operating on large ranges.

> How many peripherals on the jh8100 rely on non-coherent DMA?
>=20
> Cheers,
> Conor.



--iOmun+xjPn985xOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfqZiQAKCRB4tDGHoIJi
0qMDAP9sOBXZWhcjt6+UQcqMAdgYDyQ/d+HtGVH8VPq7D6wuPwEAuJxliBsHfezS
RtGYM/iDUAlOd2eP7RPVi3PWvojxogk=
=Su/2
-----END PGP SIGNATURE-----

--iOmun+xjPn985xOw--

