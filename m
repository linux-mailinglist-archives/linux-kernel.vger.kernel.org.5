Return-Path: <linux-kernel+bounces-31124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA767832955
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFC01C23EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC14F1F3;
	Fri, 19 Jan 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OsvDJ6HB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAB4EB27;
	Fri, 19 Jan 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665896; cv=none; b=h+UzrfrGgAmuS3M0/GA0YooA801pobhrDulRp1Svs6Kv0sQsWCoAs+MkwKPc92zZAGdCGS1uRsozKlMeLHhaDYEIrLgjPKBZctI0hPv88HbIz6/0xT3zbaGxk2vHV0pGiVIYv8q1BcZCip5FA8IS0u2DSUUIvmRgr8TXi/RBXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665896; c=relaxed/simple;
	bh=j6iDGS0RH2zPYPqLFo5vTY1M1nOg2boEqT3Tjpt4eYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrPJQcqsEC2uy9PQXOtAkXZmWqdqiwIuh6+H6sN6Z9hyoHWqZ5R+szXSuFrV6QPSikHVT0XjWR/frIDe0u45sBTOihOq7W3JEJJcydsVI45vBHet2HYa/yNl3ecDcjfW1852oT4t5D4RbFizqNTolkiO5H/4YnZ8JQL+C4aL9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OsvDJ6HB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705665893; x=1737201893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j6iDGS0RH2zPYPqLFo5vTY1M1nOg2boEqT3Tjpt4eYs=;
  b=OsvDJ6HBNaFV7Fe4cRWy+Es8ve9VMExVo/CKWciLVLkVUsJJLC2G03LM
   4l0XKm88oJs07VGIPT/OzD3vdTLr+j5eM2iShRzHZTRd2yQa1qWG+dzlL
   TYj5SK2DRk8diNE476Juay3dlyHar/xV7ojjuSMN+lt8boOf/HkAiz857
   rOxLYE0fTwg7+qNr6PpPBDw9EWc8ZLF1i2S6gqTDTQWymI/THFHfbPfjj
   NzM5JE1lDesPpZabm3KjaDrbg1UFsHaAShKGveHFr+ZQ8Y55uNy2KDzFv
   2ck5Im72zEeK4ktbCPoUOr6SxI6BdaO0mcCAJxI8VBml5zgk52Ulu0idq
   g==;
X-CSE-ConnectionGUID: A5LlJf7nQL6xcXZAQ6I1bw==
X-CSE-MsgGUID: tkta2MrESBqXD4cPHCDwpQ==
X-IronPort-AV: E=Sophos;i="6.05,204,1701154800"; 
   d="asc'?scan'208";a="14994207"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2024 05:04:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 05:04:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Jan 2024 05:04:20 -0700
Date: Fri, 19 Jan 2024 12:03:43 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: <Dharma.B@microchip.com>
CC: <conor@kernel.org>, <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
	<Linux4Microchip@microchip.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT
 schema format
Message-ID: <20240119-character-mardi-43571d7fe7d5@wendy>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118092612.117491-4-dharma.b@microchip.com>
 <20240118-recent-glorified-fd35d72e006e@spud>
 <c33868c8-dc42-4800-885c-5e5f24c2044e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a0WqJfirCmr9EVhF"
Content-Disposition: inline
In-Reply-To: <c33868c8-dc42-4800-885c-5e5f24c2044e@microchip.com>

--a0WqJfirCmr9EVhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 03:32:49AM +0000, Dharma.B@microchip.com wrote:
> On 18/01/24 9:10 pm, Conor Dooley wrote:
> > On Thu, Jan 18, 2024 at 02:56:12PM +0530, Dharma Balasubiramani wrote:
> >> Convert the atmel,hlcdc binding to DT schema format.
> >>
> >> Adjust the clock-names property to clarify that the LCD controller exp=
ects
> >> one of these clocks (either sys_clk or lvds_pll_clk to be present but =
not
> >> both) along with the slow_clk and periph_clk. This alignment with the =
actual
> >> hardware requirements will enable accurate device tree configuration f=
or
> >> systems using the HLCDC IP.
> >>
> >> Signed-off-by: Dharma Balasubiramani<dharma.b@microchip.com>
> >> ---
> >> changelog
> >> v2 -> v3
> >> - Rename hlcdc-display-controller and hlcdc-pwm to generic names.
> >> - Modify the description by removing the unwanted comments and '|'.
> >> - Modify clock-names simpler.
> >> v1 -> v2
> >> - Remove the explicit copyrights.
> >> - Modify title (not include words like binding/driver).
> >> - Modify description actually describing the hardware and not the driv=
er.
> >> - Add details of lvds_pll addition in commit message.
> >> - Ref endpoint and not endpoint-base.
> >> - Fix coding style.
> >> ...
> >>   .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 97 +++++++++++++++++=
++
> >>   .../devicetree/bindings/mfd/atmel-hlcdc.txt   | 56 -----------
> >>   2 files changed, 97 insertions(+), 56 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc=
=2Eyaml
> >>   delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc=
=2Etxt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml b/=
Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
> >> new file mode 100644
> >> index 000000000000..eccc998ac42c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
> >> @@ -0,0 +1,97 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id:http://devicetree.org/schemas/mfd/atmel,hlcdc.yaml#
> >> +$schema:http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Atmel's HLCD Controller
> >> +
> >> +maintainers:
> >> +  - Nicolas Ferre<nicolas.ferre@microchip.com>
> >> +  - Alexandre Belloni<alexandre.belloni@bootlin.com>
> >> +  - Claudiu Beznea<claudiu.beznea@tuxon.dev>
> >> +
> >> +description:
> >> +  The Atmel HLCDC (HLCD Controller) IP available on Atmel SoCs expose=
s two
> >> +  subdevices, a PWM chip and a Display Controller.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - atmel,at91sam9n12-hlcdc
> >> +      - atmel,at91sam9x5-hlcdc
> >> +      - atmel,sama5d2-hlcdc
> >> +      - atmel,sama5d3-hlcdc
> >> +      - atmel,sama5d4-hlcdc
> >> +      - microchip,sam9x60-hlcdc
> >> +      - microchip,sam9x75-xlcdc
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 3
> > Hmm, one thing I probably should have said on the previous version, but
> > I missed somehow: It would be good to add an items list to the clocks
> > property here to explain what the 3 clocks are/are used for - especially
> > since there is additional complexity being added here to use either the
> > sys or lvds clocks.
> May I inquire if this approach is likely to be effective?
>=20
>    clocks:
>      items:
>        - description: peripheral clock
>        - description: generic clock or lvds pll clock
>            Once the LVDS PLL is enabled, the pixel clock is used as the
>            clock for LCDC, so its GCLK is no longer needed.
>        - description: slow clock
>      maxItems: 3

Hmm that sounds very suspect to me. "Once the lvdspll is enabled the
generic clock is no longer needed" sounds like both clocks can be provided
to the IP on different pins and their provision is not mutually
exclusive, just that the IP will only actually use one at a time. If
that is the case, then this patch is nott correct and the binding should
allow for 4 clocks, with both the generic clock and the lvds pll being
present in the DT at the same time.

I vaguely recall internal discussion about this problem some time back
but the details all escape me.

Thanks,
Conor.

--a0WqJfirCmr9EVhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaplHwAKCRB4tDGHoIJi
0lj2AP9K84iq37Rz1ulvFhMipsNqhqMxklWv5GvyAq1ZD/lqSwEAq0vY9saiWwW2
ah0UOybo+9cGrmPqOmpiVe3FFc6voAU=
=dla+
-----END PGP SIGNATURE-----

--a0WqJfirCmr9EVhF--

