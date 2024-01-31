Return-Path: <linux-kernel+bounces-45521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E98431F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293601C2518E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA81366;
	Wed, 31 Jan 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3KMncQp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA240A29;
	Wed, 31 Jan 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661170; cv=none; b=Guw0U7cxqsxXKaGER97Lc8ur5hECxgWP3WRD4UxOukfrjLB26T7lokQikyHSJDicHeNIqW1agwHbtzTsAKpHxHjyN/EBufCXJpeR6IhznLvDhnVRKkmoNa7JrB2V0knZAyRejDR0Vy2Crg+sbKZJwbJZlHeEWDGxn439SogK1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661170; c=relaxed/simple;
	bh=TbbCfL8IJfxgiIsFWKnXWPwHbFFZ4Te+lbkwAcKaEhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGbybNLH8IscyZKnjVi5xhBZeshmTNrcTHdaJN4Hq5FjdGdqfJCxhCRyjCteVMtrRmUY7tDBo1qCspmYR3hfll0KDSQuE5S9uhljn09kyI+0w2S5VWfC8Jk6Po3evcBP5GLA4/8QtN288cjcY01qT+TB6Zd0mJma6+nQab+Srzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3KMncQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FFFC433C7;
	Wed, 31 Jan 2024 00:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706661170;
	bh=TbbCfL8IJfxgiIsFWKnXWPwHbFFZ4Te+lbkwAcKaEhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3KMncQphv5pdrMNdBn56gAU1QjTtwVLGki7OgDIU+VK4dl7bi5jLL54lo3hcy95k
	 bAZLYI1imLFoDGg1x+YHGaJjYYU3YiZvf60c6T3W6Pg3HYkmgYP5rroXAj7ximGlBG
	 +UlaOpMaPHfBTLYwcd+ShnHL+dk1EGx07p3ytF0hFkRcoqMlqL5vwmqKjBSLPgKYE3
	 67JQZJXz2o6/6aWflWPgAyUoivH969ABA9qySqfKz80Vd+kQFs7Qo7QADGgpU9dFsA
	 Zd1fTu/pCVGNYsYIcHSwiQAAbmW/mkbncQ027jmNXyZS25MB4g9Ig56uaokw55iZ/D
	 OggQXOwCTGVCQ==
Date: Wed, 31 Jan 2024 00:32:42 +0000
From: Conor Dooley <conor@kernel.org>
To: "Corona, Ernesto" <ernesto.corona@intel.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"'oleksandrs@mellanox.com'" <oleksandrs@mellanox.com>,
	"'jiri@nvidia.com'" <jiri@nvidia.com>,
	"Castro, Omar Eduardo" <omar.eduardo.castro@intel.com>,
	"'omar.eduardo.castro@linux.intel.com'" <omar.eduardo.castro@linux.intel.com>,
	"'robh@kernel.org'" <robh@kernel.org>,
	"'corbet@lwn.net'" <corbet@lwn.net>,
	"'mchehab+samsung@kernel.org'" <mchehab+samsung@kernel.org>,
	"'alexandre.belloni@bootlin.com'" <alexandre.belloni@bootlin.com>,
	"'tytso@mit.edu'" <tytso@mit.edu>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'ebiggers@google.com'" <ebiggers@google.com>,
	"'mark.rutland@arm.com'" <mark.rutland@arm.com>,
	"'joel@jms.id.au'" <joel@jms.id.au>,
	"'andrew@aj.id.au'" <andrew@aj.id.au>,
	"Filary, Steven A" <steven.a.filary@intel.com>,
	"'vadimp@mellanox.com'" <vadimp@mellanox.com>,
	"'amithash@fb.com'" <amithash@fb.com>,
	"'patrickw3@fb.com'" <patrickw3@fb.com>,
	"Chen, Luke" <luke_chen@aspeedtech.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
	"'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: Re: [PATCH 30 2/7] Add binding for Aspeed SOC
Message-ID: <20240131-felt-tip-mountain-e29606b63acf@spud>
References: <LV8PR11MB8463D0017B82135324127DB98B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QWiiH/5RiPb5Te7D"
Content-Disposition: inline
In-Reply-To: <LV8PR11MB8463D0017B82135324127DB98B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>


--QWiiH/5RiPb5Te7D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Jan 30, 2024 at 11:30:10PM +0000, Corona, Ernesto wrote:
> Aspeed AST2400, AST2500 and AST2600 JTAG controller driver.
>=20
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
> Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
> Acked-by: Rob Herring <robh@kernel.org>

Where did this ack come from? The conversion to a yaml binding was in
v29 (according to your changelog) but I don't see the ack from Rob
there.
I think a conversion from (text?) to yaml would be sufficient of a
change to drop his tag.

> v28->v29
> - Change documentation to the new dt-bindings yaml format.

>  .../devicetree/bindings/jtag/aspeed-jtag.yaml | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml b/Do=
cumentation/devicetree/bindings/jtag/aspeed-jtag.yaml
> new file mode 100644
> index 000000000000..1a412e83b81b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml

Filename matching a compatible please.

> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/jtag/aspeed-jtag.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed JTAG driver for ast2400, ast2500 and ast2600 SoC
> +
> +description:
> +  Driver adds support of Aspeed 24/25/2600 series SOC JTAG controller.
> +  Driver implements the following jtag ops
> +    freq_get
> +    freq_set
> +    status_get
> +    status_set
> +    xfer
> +    mode_set
> +    bitbang
> +    enable
> +    disable

None of the driver stuff, nor where you tested this, is relevant to the
description in the binding nor the title of the binding. Just describe
the hardware.

> +
> +  It has been tested on Mellanox system with BMC equipped with
> +  Aspeed 2520 SoC for programming CPLD devices.
> +
> +  It has also been tested on Intel system using Aspeed 25xx SoC
> +  for JTAG communication.
> +
> +  Tested on Intel system using Aspeed 26xx SoC for JTAG communication.
> +
> +maintainers:
> +  - Oleksandr Shamray <oleksandrs@mellanox.com>
> +  - Jiri Pirko <jiri@nvidia.com>
> +  - Ernesto Corona<ernesto.corona@intel.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - aspeed,ast2400-jtag
> +              - aspeed,ast2500-jtag
> +              - aspeed,ast2600-jtag

You don't need the "oneOf" or "items" here, it's enough to do:
  compatible:
    enum:
      - allwinner,sun5i-a13-mbus
      - allwinner,sun8i-a33-mbus

> +
> +
> +  reg:
> +    items:
> +      - description: JTAG Master controller register range
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +      jtag: jtag@1e6e4000 {

The labels for both of these examples are also not needed
as they're not used anywhere.

Thanks,
Conor.

> +          compatible =3D "aspeed,ast2500-jtag";
> +          reg =3D <0x1e6e4000 0x1c>;
> +          clocks =3D <&syscon ASPEED_CLK_APB>;
> +          resets =3D <&syscon ASPEED_RESET_JTAG_MASTER>;
> +          interrupts =3D <43>;
> +      };
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +      jtag1: jtag@1e6e4100 {
> +          compatible =3D "aspeed,ast2600-jtag";
> +          reg =3D <0x1e6e4100 0x40>;
> +          clocks =3D <&syscon ASPEED_CLK_APB1>;
> +          resets =3D <&syscon ASPEED_RESET_JTAG_MASTER2>;
> +          interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +
> +...
> --=20
> 2.25.1

--QWiiH/5RiPb5Te7D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbmVKgAKCRB4tDGHoIJi
0rCjAQDYj1EFmAGScPlfZN5yZJTxnHl32pOtpDUx3mrrfxczLQEA2sbvYzMN1NN0
lsTxpN/rFe4/GnLJeDKbYtp82xbo1gA=
=L/R4
-----END PGP SIGNATURE-----

--QWiiH/5RiPb5Te7D--

