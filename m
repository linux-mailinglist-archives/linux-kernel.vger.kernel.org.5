Return-Path: <linux-kernel+bounces-26012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A982D9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC541F22604
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC1168D8;
	Mon, 15 Jan 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NQiRHca2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAB17BA8;
	Mon, 15 Jan 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705324462; x=1736860462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jFA3loSz7KBaa/Y2oZSte/KcReqaqC7L01dAxlTOXyY=;
  b=NQiRHca2sMbJTmX3Ttk8fMMjAK4lCJpEP78G6PSMznlcLtYRDAhwNEw4
   kUUjPCmYnZ9jwWgbMKcIi2+Q5jMtpXfwU+O+6LUC8SaIAgFj8yxIGKny8
   u56dKLmilrB98XW/yJ/RsnjSeN/EExHw/93Wt97nEM0xiMsF0ZPeYoFAG
   TkV/ISz8W4yD/MbIqrl04ykSSfY1NC/3bzg9HjHp1KtIWDAA40V+UhJ3I
   zFzjcQo+6paAb8b9nLSxj6eTh2FvS19JO6+uB3QDzT3elYA6AlgTlXKRb
   COySSbuZstY50nf9x7EB6utw597/rXzcwyOJ3U95svPzS4rW0kdhzYP+w
   Q==;
X-CSE-ConnectionGUID: lKQerpMqQvmPFpiQXHFOyA==
X-CSE-MsgGUID: +966s/esQnO+EyrA43oQ3g==
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="asc'?scan'208";a="14745244"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2024 06:14:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 06:14:07 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jan 2024 06:14:04 -0700
Date: Mon, 15 Jan 2024 13:13:28 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Drew Fustini <dfustini@tenstorrent.com>
CC: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Han Gao <gaohan@iscas.ac.cn>, Xi Ruoyao
	<xry111@xry111.site>, Robert Nelson <robertcnelson@beagleboard.org>, Jason
 Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH RFC 2/3] dt-bindings: clock: Document T-Head TH1520 AP
 clock controller
Message-ID: <20240115-canteen-erupt-6634a1deece4@wendy>
References: <20240110-clk-th1520-v1-0-8b0682567984@tenstorrent.com>
 <20240110-clk-th1520-v1-2-8b0682567984@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMErKyKoeRnUvEeF"
Content-Disposition: inline
In-Reply-To: <20240110-clk-th1520-v1-2-8b0682567984@tenstorrent.com>

--rMErKyKoeRnUvEeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 08:35:16AM -0800, Drew Fustini wrote:
> From: Yangtao Li <frank.li@vivo.com>
>=20
> Document devicetree bindings for the T-HEAD TH1520 AP sub-system
> clock controller.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

> [add link to reference manual]
> [fixed dt_binding_check warnings]
> [revised commit description]

btw, can you remove this sort of thing from the commit message and put
it in the changelog instead?

Cheers,
Conor.

> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>

--rMErKyKoeRnUvEeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaUveAAKCRB4tDGHoIJi
0o71AQC7nn7S9wVZcBWfek1L479XEOdH1Z5hOxIxFhTm1tvM5wD9FzT/nkA5j93k
DdcuMppH6E9l1Sx1mO8fXbTXey55jwY=
=DAbR
-----END PGP SIGNATURE-----

--rMErKyKoeRnUvEeF--

