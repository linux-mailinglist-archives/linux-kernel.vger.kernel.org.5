Return-Path: <linux-kernel+bounces-61191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68F850EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1D281E94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96440CA50;
	Mon, 12 Feb 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QVj9j8Y9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375248C1D;
	Mon, 12 Feb 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725609; cv=none; b=uuAnBIkAKLreDgjjS8tBsRL/BPcutu1J6rmHNNCffdpHSvNHTlvwalKGOyVizeCltNtpn3sVJbeJZG68KGepybRbPjzqYmVS9Og29nddfviH6ncgpQSB02QTDf/CwVkD2uMIAu7IGk0609Ca3wpbt6x/CSu06H9hB8jdNOaCBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725609; c=relaxed/simple;
	bh=UCSj1ZEGLD9eCgnsZic6xGWJaBob8bewMfF1q0KeXLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIo73Sw/0d4QUfFxQhmeKrqQFrLC2gpMIAbYfhGXBwWGwb8XDiz0TXhHe6QoDZLI+YSPW4TcMiPw0wwuibpwlCpJnDOGqw6MgQVtWZqP4zpIKM1FvExFitPIlGk8eNldgHEN+EFN60GAXxy8at1nBRgz7VkGT3/m/PWY1RWppkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QVj9j8Y9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707725608; x=1739261608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UCSj1ZEGLD9eCgnsZic6xGWJaBob8bewMfF1q0KeXLU=;
  b=QVj9j8Y9KSbeLhmGN/Ffoxr939HKArEbSh88JZ14d1NO5B57BtOfaAiv
   fwvYMfX2Q0hUOINF8HRMZouEPedhU45q8J9bkzW4ye1zTFJqLFtr8U0Rb
   Zxs+27xxIS91f2DChj0lvu3qmz+1z5Ugq3MN6TdnDhVptCeNJltlrhiFk
   o0+P1C51r8k4KGmtMCzODpNT3fsJ6YT0L7zY1KoXFGkj5kcz/n5VKTBRw
   lcwsbLFJB2d8LDWr8L431D9uSsxHd4CP7aKx7GB60J/OF9em5pto2QoCX
   8lzrkUU5ZfsDiP5O/Q1adJnXU2rlcSDKF8x5G7O6/lhIuWdAX9u2aK2Xb
   w==;
X-CSE-ConnectionGUID: SPzSOg2CQl+AOMlhbWcqbA==
X-CSE-MsgGUID: oaTEeq14QP2PPao9cFSn5w==
X-IronPort-AV: E=Sophos;i="6.05,262,1701154800"; 
   d="asc'?scan'208";a="183365843"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 01:13:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 01:13:16 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 12 Feb 2024 01:13:13 -0700
Date: Mon, 12 Feb 2024 08:12:33 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Inochi Amaoto <inochiama@outlook.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen
 Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, Jingbao
 Qiu <qiujingbao.dlmu@gmail.com>, <dlan@gentoo.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 4/8] clk: sophgo: Add clock support for CV1800 SoC
Message-ID: <20240212-explicit-wrecking-f158f0c28f0d@wendy>
References: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49538E900A21F373A1171B2BBB442@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dvFkdGZI6Ityus2U"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49538E900A21F373A1171B2BBB442@IA1PR20MB4953.namprd20.prod.outlook.com>

--dvFkdGZI6Ityus2U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 04:48:52PM +0800, Inochi Amaoto wrote:
> Add clock definition and init code for CV1800 SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8=
df248a19ca70837a3/duo/datasheet/CV180X-Clock-v1.xlsx

And on this one there's a gcc complaint too:
drivers/clk/sophgo/clk-cv1800.c:634:37: warning: 'clk_disp_vip_parents' def=
ined but not used [-Wunused-const-variable=3D]

Cheers,
Conor.

--dvFkdGZI6Ityus2U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcnS8QAKCRB4tDGHoIJi
0syHAQD+X8u58YILVwXnuv/2aD2GJ/8Q6x2gEhvtWKxRtepANAEAtV2v+waW9yzK
W7onJ9rSw1Jr6B4+gjOSjb49MiESgwE=
=leOw
-----END PGP SIGNATURE-----

--dvFkdGZI6Ityus2U--

