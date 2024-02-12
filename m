Return-Path: <linux-kernel+bounces-61190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53777850EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11383281B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5AD516;
	Mon, 12 Feb 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VMich8G4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BFC8E1;
	Mon, 12 Feb 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725536; cv=none; b=FIlmK+zlEOy65xYTMFU8Tx60BM9KIVI+aTKOucXDxD0BD1xUe6a8YstBnyIQoIhberHUMNh2SrkCUY2iJUfPEB6Cc7reWDl13L6q3eVxwiIAGFAncMym9oYGelFYIpskwNXFN0fwyvBFdpqdjxpzARMnaa3cRb1C/5MyHng4I1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725536; c=relaxed/simple;
	bh=y4gOdXf2UvPIYFJOvfdCK9DIHHn8iBh20XjFWZcWNqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbIYF3eacG6cuq51QjJzCpq2bPKsPFTFMNPel+V3JGH7A6W8rCclKWLk2t6EZcygyq2ZcJIP/XxKX52qZwKr78T0hhjyExM6FtMyWtJjTdzp0OLNHaU1bP+jEDEQERWlmmaJ2Ntyzc+TM0N+J50qbiJY9rRGrZwdK7VWjy7KhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VMich8G4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707725535; x=1739261535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y4gOdXf2UvPIYFJOvfdCK9DIHHn8iBh20XjFWZcWNqI=;
  b=VMich8G4Pe2Z5Fxmdf7M0MvzRGXjUZE47UY4ujOKRl4wmPtdWLzK7XBU
   eRrWmIwsOJGItxqgbtVITiDFmOAen7L1/Dqt7Cgqvhte8tj5BQZ1iaRgU
   Syta1UHjMtacRez2My1iUtEBI6znWYNxF/whPEGayxeWp9hpJX5H8mVhM
   RXJROQNK8zfXKheUAdQC0xdYhMM7lp6mvRd9ezY05YYx2P/UyVEzL4wlw
   0K304zxY2HTh4W4shRHkjAqgQ0Cvcd99H2iWWk6c144fMLQdWE919cK0Z
   YYkcXNE1TwmcJ8B+x0tXs/kxSK3NfYUFMZ3Hybxf6lvXc3SjFn5TW0Hr7
   A==;
X-CSE-ConnectionGUID: kwS9suHxTnKkUfyu86XUvw==
X-CSE-MsgGUID: 9DzaZjwYSgO18GJ9Jxa/Ow==
X-IronPort-AV: E=Sophos;i="6.05,262,1701154800"; 
   d="asc'?scan'208";a="16618915"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 01:12:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 01:11:53 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 12 Feb 2024 01:11:50 -0700
Date: Mon, 12 Feb 2024 08:11:10 +0000
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
Subject: Re: [PATCH v7 3/8] clk: sophgo: implement clk_ops for CV1800 series
 clock controller driver
Message-ID: <20240212-list-grumble-819f7988aaad@wendy>
References: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49534558A17C332722AF5BC2BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g/NQAsoQx7SfAKyW"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49534558A17C332722AF5BC2BB442@IA1PR20MB4953.namprd20.prod.outlook.com>

--g/NQAsoQx7SfAKyW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 04:48:51PM +0800, Inochi Amaoto wrote:
> Add clk_ops implement of pll and ip clocks for the clock controller.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8=
df248a19ca70837a3/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-=
en.pdf

On 64-bit with clang:
drivers/clk/sophgo/clk-cv18xx-ip.c:745:6: warning: variable 'flags' is used=
 uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
drivers/clk/sophgo/clk-cv18xx-ip.c:745:6: warning: variable 'flags' is used=
 uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
on 32-bit there's also:
drivers/clk/sophgo/clk-cv18xx-pll.c:28:2: warning: comparison of distinct p=
ointer types ('typeof ((rate)) *' (aka 'unsigned long *') and 'uint64_t *' =
(aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
drivers/clk/sophgo/clk-cv18xx-pll.c:28:2: error: incompatible pointer types=
 passing 'unsigned long *' to parameter of type 'uint64_t *' (aka 'unsigned=
 long long *') [-Werror,-Wincompatible-pointer-types]

Cheers,
Conor.

--g/NQAsoQx7SfAKyW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcnSngAKCRB4tDGHoIJi
0opHAQC3h+Tx3CIi4UWF2q9YXffVkxcQyWOu5A5XV45+p/LBvAD9Ft5wyfLaV0oR
K9Bd0hf1eg8NOcyQIXKmbekTDXSUhQs=
=SAO8
-----END PGP SIGNATURE-----

--g/NQAsoQx7SfAKyW--

