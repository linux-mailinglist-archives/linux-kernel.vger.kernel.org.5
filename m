Return-Path: <linux-kernel+bounces-142668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B65B8A2E95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C41C20DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE94659165;
	Fri, 12 Apr 2024 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XCGqCkBf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180864436C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926401; cv=none; b=gH69Z50jZMe4AZBu8H/kDQCEttfAliDIPGR/nHDaoVenRejv+mbtjDSv3wD/VBktwhn+qQmi3CQWXTfDDsa3XeH91SWshgm6b+GIJf4XH+R4Qey0JaS4jeMQYFQByjhKi/PFMlRR/rZk2vmiYV+7plINEKJzL/IayMNznXnn9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926401; c=relaxed/simple;
	bh=RCL3GDBIalzPPzrhwInTi0of4Qd4xYEJFXocUFu6jL8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8LOSPhMzFCUzJF4IXEgKlG6FEJ0mrQ+fdYydfKaQo3PSMMAtunf/y2TOAdjosmOfUhd60fQbCKKVQpKYcHOxBhA1qeR4LqWBjDNBj7d3z1w/UiGAmbo1jMT2wOgPybScyBqWMQEL446txjbOtoqx3DBtR9iSqP0ntDZeyGzlcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XCGqCkBf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712926399; x=1744462399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCL3GDBIalzPPzrhwInTi0of4Qd4xYEJFXocUFu6jL8=;
  b=XCGqCkBfCHKBv0G6fL1CqifJJ3dwHXkdtrvbtxX8zppE8ftckcwpKoSV
   aNLsuejVIVGDm5L8QfEGR346+ixbsUGxlTfAdYIiwLYhdWqgqRKxOklfn
   3RjSKB4gP7DLh033w9VJB3T6EF07oD2PU9uwzhnZXp06PvL/b5aIUxRfB
   yKxefIhhID2zN0HnOuAAOefHjQP5lTaWtof8XybLq0KWrtZZcwpLRR55b
   gj+Qh7FTzyN61E0pHSo14ye1hxHOJ6OSaBCE4YGVsAsu73AWNMBaCVUjm
   8TzWDgKTpDLjOMaY6TLSx46Oj7L7JbeLkoBxD48jMfQky+TXF2vg7mTxd
   w==;
X-CSE-ConnectionGUID: xvHXmpfzT7GCi3Fou8Incg==
X-CSE-MsgGUID: GwH4QwB0SG69V1ZPGXUWHA==
X-IronPort-AV: E=Sophos;i="6.07,196,1708412400"; 
   d="asc'?scan'208";a="251536449"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 05:53:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 05:52:37 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 05:52:36 -0700
Date: Fri, 12 Apr 2024 13:51:45 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] cache: sifive_ccache: Auxiliary device support
Message-ID: <20240412-antacid-pretzel-c25d707f02cf@wendy>
References: <20240410232211.438277-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KR2qWsXqqA2l3aGz"
Content-Disposition: inline
In-Reply-To: <20240410232211.438277-1-samuel.holland@sifive.com>

--KR2qWsXqqA2l3aGz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2024 at 04:22:02PM -0700, Samuel Holland wrote:
> As of commit c90847bcbfb6 ("cache: sifive_ccache: Partially convert to a
> platform driver"), the cache subsystem binds a platform driver to the
> Composable Cache's DT node. This prevents the perf subsystem from doing
> the same for the new PMU driver[1]. To allow using both drivers at the
> same time without conflicts or module linkage dependencies, attach the
> PMU driver to the auxiliary device bus. While at it, prepare to use the
> auxiliary device bus for the EDAC driver as well, which significantly
> simplifies that driver. The actual EDAC driver conversion has to wait
> another development cycle to avoid dependencies between git trees.


I'm not really keen on the partial conversion, I'd like to see a
complete conversion where the ccache driver calls
"sifive_register_ccache_pmu()" and "sifive_register_ccache_edac()"
and has no part in creating the aux device itself, like Philipp and
Stephen asked me to do here for the clock/reset drivers on PolarFire SoC:
https://lore.kernel.org/all/20240409-shallow-voice-c84ed791bc7d@spud/

Thanks,
Conor.

--KR2qWsXqqA2l3aGz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkuYQAKCRB4tDGHoIJi
0kVAAP9mbHOk0zEUzhsEt4WvIpaZeCF/FXZSFyZyWTiFCHFLzwD9GBDJql4D9mri
vjwiORtlGvkcH2+Idjuh0kEeqcGP3ws=
=KzTj
-----END PGP SIGNATURE-----

--KR2qWsXqqA2l3aGz--

