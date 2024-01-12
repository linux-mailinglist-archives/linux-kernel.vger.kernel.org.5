Return-Path: <linux-kernel+bounces-24391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDCA82BBE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37F61C24FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FAB5D730;
	Fri, 12 Jan 2024 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FKRjjSpE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA125C8E1;
	Fri, 12 Jan 2024 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705045401; x=1736581401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1T3tgkH4iijZDYGTTzAf0IpYzhHY6enp+pqFzjuGwdw=;
  b=FKRjjSpEBTRyEYz9JO+JgDbEv99IjV8mJAfYCoW2wXuFLU8v2kOmLXaX
   XywKJZFaR8/fAxyKCfBzl8iXK8vb9BUEPEG42NJfiaBiuhE+634qVZsJD
   CJk/g/oEZsik4SfhJNgJjFL0m3AMnfFQS9vQ5mgvx73NIhBGTmFaRLBR/
   hqat4wU0NJNq4KdRAmihW27JUfXC40QgdYVEHA5Q09Cfwv+o78YYCDhma
   /JigGYNaXRQyD853lAQB8ti5DBeOq6AF3pryIVX4ckQUgBjR0ZaVpZt1H
   gdgthgZdlwXDaxRsgExtmRuifdNRCvyt6hWK0MRrruYAOK/6ca7HhCCv3
   w==;
X-CSE-ConnectionGUID: tOc90VrxTfqk6wus7ohuMw==
X-CSE-MsgGUID: sHvIQsA7RM2ZtlC6VGTG9w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="asc'?scan'208";a="15111438"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jan 2024 00:43:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 00:42:53 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Jan 2024 00:42:49 -0700
Date: Fri, 12 Jan 2024 07:42:14 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Chen Wang <unicorn_wang@outlook.com>
CC: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Chen Wang <unicornxw@gmail.com>,
	<aou@eecs.berkeley.edu>, <chao.wei@sophgo.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
	<palmer@dabbelt.com>, <paul.walmsley@sifive.com>, <richardcochran@gmail.com>,
	<robh+dt@kernel.org>, <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <haijiao.liu@sophgo.com>,
	<xiaoguang.xing@sophgo.com>, <guoren@kernel.org>, <jszhang@kernel.org>,
	<inochiama@outlook.com>, <samuel.holland@sifive.com>
Subject: Re: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
Message-ID: <20240112-overhead-disallow-8c2a4b97c36c@wendy>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <925d99d5b4ece01337cb3389aaea4b631894dd1d.1704694903.git.unicorn_wang@outlook.com>
 <f88b79c3-e44b-4136-ae56-10e1f2502e2d@linaro.org>
 <MA0P287MB2822C7A3C1DC7786708E860BFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240110-untoasted-underfed-fe81479506f6@spud>
 <MA0P287MB282224A6097B4FCCF721C89AFE682@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240111-jolly-prize-930931cc648a@spud>
 <MA0P287MB28229BCC9EA83507B99A9F3BFE6F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJiafrCvNW1u7xS0"
Content-Disposition: inline
In-Reply-To: <MA0P287MB28229BCC9EA83507B99A9F3BFE6F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

--IJiafrCvNW1u7xS0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 08:08:15AM +0800, Chen Wang wrote:
> On 2024/1/12 0:58, Conor Dooley wrote:
> > On Thu, Jan 11, 2024 at 04:00:04PM +0800, Chen Wang wrote:

> > > There are four types of clocks for SG2042 and following are where the=
ir
> > > control registers are defined in:
> > >=20
> > > PLL=EF=BC=9Aall in SYS_CTRL
> > > DIV: all in CLOCK
> > > GATE: some are in SYS_CTRL, some others are in CLOCK
> > When you say "some", do you meant some entire clocks are in SYS_CTRL and
> > some entire clocks are in the CLOCKS? Or do you meant that for a given
> > clock, some registers are in SYS_CTRL and some are in CLOCK? It's the
> > first option, right?
>=20
> It's the first option.

Then the gate clocks that are fully contained within SYS_CTRL are
outputs of SYS_CTRL and gate clocks fully contained within CLOCK are
outputs of CLOCK. You should not use a phandle to SYS_CTRL from the
CLOCKS node so that you can pretend they are part of CLOCKS just because
that makes writing your driver easier. That said, obviously you can
share the routines for turning the gates on and off etc.

Cheers,
Conor.

--IJiafrCvNW1u7xS0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaDtUAAKCRB4tDGHoIJi
0nxTAP9CrpCZwpKaT/G47Q3VE/Iop0YxDp0B26eM0tRrfqHaLwD/cs6kxe63wPej
jDHoKl/useqwla8QveRde8FpitXfYwE=
=y7/T
-----END PGP SIGNATURE-----

--IJiafrCvNW1u7xS0--

