Return-Path: <linux-kernel+bounces-27087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FC82EA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5800BB2327C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7DC1118F;
	Tue, 16 Jan 2024 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gH7MHFK3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C812B7B;
	Tue, 16 Jan 2024 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705390662; x=1736926662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2Z5WovOkoDhRrX3oZ/2SAj8+B2nb1yllR5MhnzNHik=;
  b=gH7MHFK3Qvhg+39qCyI0l9EQynOo2OfkTZWU4XIvZSeuOsh1ZR3us1R3
   /YGIJ3UOwnxRFGpCJrFQd6TU8LhA7NMQ/OQ8RiObTOn97ZuRmGvAF+/w/
   P6slbE3Pfmz740oGOuzF5SnhL+46qVaUhnK8aQ9Ur6rA+OgUJI9TMvrjZ
   kNxVWdJBkk0B/ldkoaivyY6a0Ta5Lrn67Hd5yaK3YJNlPS1daarc4phS9
   gTTLXhfrcxE5N2LpOqqEZARt3YN5cBDA1FdnplCs4piNRtEnocDukQPOr
   2u1xTJIfk7z+u9jPHkwA6AJeSiJ7AZ8J+L3N5fqNIFrbsyXd/6IyEemIl
   A==;
X-CSE-ConnectionGUID: IsWRT3HCQVmB2vjRJZ30Vg==
X-CSE-MsgGUID: fn1riB1hQsScBhpbjzpgYw==
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="asc'?scan'208";a="14788093"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 00:37:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 00:37:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jan 2024 00:37:34 -0700
Date: Tue, 16 Jan 2024 07:36:58 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Inochi Amaoto <inochiama@outlook.com>
CC: Conor Dooley <conor@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chao
 Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, Liu
 Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	<dlan@gentoo.org>, <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: clock: sophgo: Add clock controller
 of SG2000 series SoC
Message-ID: <20240116-doubling-fanning-2a46405942ae@wendy>
References: <20240115-spendable-achiness-cff7918fe810@spud>
 <IA1PR20MB4953C0E6DCC3C4CC0A398529BB732@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eB8X+Pg8BaNk7w+A"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953C0E6DCC3C4CC0A398529BB732@IA1PR20MB4953.namprd20.prod.outlook.com>

--eB8X+Pg8BaNk7w+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 08:27:59AM +0800, Inochi Amaoto wrote:
> >On Sun, Jan 14, 2024 at 12:16:58PM +0800, Inochi Amaoto wrote:
> >> SG2000 series SoC has the same clock as CV1810 series, but the clock
> >> related to A53 is functional in SG2000 series. So a new compatible
> >> string is needed for the new SoC.
> >>
> >> Add definition for the clock controller of the SG2000 series SoC.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >> Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datashe=
et-v1.0-alpha
> >> ---
> >>  Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk=
=2Eyaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> >> index c1dc24673c0d..59ef41adb539 100644
> >> --- a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> >> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> >> @@ -4,7 +4,7 @@
> >>  $id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
> >>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>
> >> -title: Sophgo CV1800 Series Clock Controller
> >> +title: Sophgo CV1800/SG2000 Series Clock Controller
> >>
> >>  maintainers:
> >>    - Inochi Amaoto <inochiama@outlook.com>
> >> @@ -14,6 +14,7 @@ properties:
> >>      enum:
> >>        - sophgo,cv1800-clk
> >>        - sophgo,cv1810-clk
> >> +      - sophgo,sg2000-clk
> >
> >I recall before you mentioned that the Sophgo folks were considering
> >renaming one of their devices. Is the sg2000 the renamed one, or a
> >different chip?

> The sg2000/sg2002 SoCs have one A53 core which cv1812/cv1813 SoCs
> don't have. I prefer sg2000/sg2002 are different chips, or at least
> an enhanced version of existed cv1812/cv1813. It is not a simple
> rename.
>=20
> For this patch, the sg2000 doesn't need to disable A53 related clocks
> like cv18xx series. So this compatible is needed to bind to this new
> logic.

I'm not disputing the unique compatible - you previously mentioned that
Sophgo were considering rebranding the cvXXXX series of chips going
forward and that one particular chip might undergo a name change.
I was wondering if this was that chip or just another device in the
series.

Thanks,
Conor.

--eB8X+Pg8BaNk7w+A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaYyFgAKCRB4tDGHoIJi
0ny6AQD8jsSGjB9PRHJIURaIii46XV0kYNTdn/N7cJvxFm0LXQEApESH0dzNDVT/
TL70OnJGXzymk7n0pSlvQzK/NlNa2gY=
=HiGa
-----END PGP SIGNATURE-----

--eB8X+Pg8BaNk7w+A--

