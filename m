Return-Path: <linux-kernel+bounces-96811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F7A8761BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DC4281A9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63953E1A;
	Fri,  8 Mar 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aerF9VBM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFC2CCB3;
	Fri,  8 Mar 2024 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892980; cv=none; b=VUkjZsygmCwVcYde4wm9xWqVj82UFccQTsewiw70BmumG5WDDTLRtAOaor+GFGWe+z9rWKNrcUIBcxZhbwEgrzArBWKT1FH5IUkob2BPteXhThUuBg60gJDrTXpgaHI/nTT0IPvuF37BrIhjA8gda1pTUMgdFT4H122vHbhSzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892980; c=relaxed/simple;
	bh=Q8cQjBrAEx7ffkcBZwFyj+7ctJtXOoVmf2a9mz1sm6U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfmFmcTDFHkgCBEZ644f4Fuxf2kFV4aCsVLQe/JqAdH2tHQ9WX+3foTXPu8BK4xoeqa4hCMOjevgVUWH03W7Hi2AoZEV0omzcj3u2OfTIDHjTK3dfndl7xFxwUXH19Vs/wIYigw0Y41mE79myQLrhpPDAByGGC8r4DyS+Mj/eq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aerF9VBM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709892978; x=1741428978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q8cQjBrAEx7ffkcBZwFyj+7ctJtXOoVmf2a9mz1sm6U=;
  b=aerF9VBMCuHlcJnQ9yrfR1g3Y+jOh49mr9OF+O3HD19dAsrLOJS2lOBH
   Dw8N6NsO/JBdUvAuHP4AqivSNnCSHzuLA2pFtokuMof7HORWdestW/Qyj
   OwH42FZ0rJcBxpjd4ON0y78Pyl8LsdSCq1QHlh3C4DGGZ/2b+dDfxa/ve
   3VSaalp6wlroo84UbNTdE9uCnOWeg2icYSztDhDu5kENVQapxs1Pgm4Z8
   8fz4I3/vWFwpSinagIGIznLAhig+hW9M7UB8piVjsHABP9QvHc98aaR6f
   AEPJXlTeyvWTodYVbIEv1VQ8CI/TZDQWwHE1+K/2212YZUlCwYJRaQh1R
   A==;
X-CSE-ConnectionGUID: GYN+Phv8SneCqTAifiO+dQ==
X-CSE-MsgGUID: A8+JuFB9QEC81NKv8EN3gA==
X-IronPort-AV: E=Sophos;i="6.07,109,1708412400"; 
   d="asc'?scan'208";a="248162359"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 03:16:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 03:16:05 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Mar 2024 03:16:02 -0700
Date: Fri, 8 Mar 2024 10:15:18 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: <Varshini.Rajendran@microchip.com>
CC: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<tglx@linutronix.de>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <andre.przywara@arm.com>, <mani@kernel.org>,
	<shawnguo@kernel.org>, <Durai.ManickamKR@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 29/39] irqchip/atmel-aic5: Add support to get nirqs
 from DT for sam9x60 & sam9x7
Message-ID: <20240308-reissue-badass-9f8883b4e2e6@wendy>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172905.673053-1-varshini.rajendran@microchip.com>
 <f1f9c53f-b11a-4fe1-9541-356ea75e883c@tuxon.dev>
 <ba7a59ae-d377-4514-89e7-86991420507c@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/QFzMk5rsZSajjp0"
Content-Disposition: inline
In-Reply-To: <ba7a59ae-d377-4514-89e7-86991420507c@microchip.com>

--/QFzMk5rsZSajjp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 08:50:43AM +0000, Varshini.Rajendran@microchip.com =
wrote:
> On 03/03/24 5:51 pm, claudiu beznea wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > On 23.02.2024 19:29, Varshini Rajendran wrote:
> >> Add support to get number of IRQs from the respective DT node for sam9=
x60
> >> and sam9x7 devices. Since only this factor differs between the two SoC=
s,
> >> this patch adds support for the same. Adapt the sam9x60 dtsi
> >> accordingly.
> >>
> >> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> >> ---
> >> Changes in v4:
> >> - Changed the implementation to fetch the NIRQs from DT as per the
> >>    comment to avoid introducing a new compatible when this is the only
> >>    difference between the SoCs related to this IP.
> >> ---
> >>   arch/arm/boot/dts/microchip/sam9x60.dtsi |  1 +
> >>   drivers/irqchip/irq-atmel-aic5.c         | 11 ++++++++---

Driver and binding changes should be in different patches. Having them
in the same patch is usually a red flag for ABI breakage.

> >>   2 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/=
dts/microchip/sam9x60.dtsi
> >> index 73d570a17269..e405f68c9f54 100644
> >> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> >> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> >> @@ -1201,6 +1201,7 @@ aic: interrupt-controller@fffff100 {
> >>                                interrupt-controller;
> >>                                reg =3D <0xfffff100 0x100>;
> >>                                atmel,external-irqs =3D <31>;
> >> +                             microchip,nr-irqs =3D <50>;
> >>                        };
> >>
> >>                        dbgu: serial@fffff200 {
> >> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-at=
mel-aic5.c
> >> index 145535bd7560..5d96ad8860d3 100644
> >> --- a/drivers/irqchip/irq-atmel-aic5.c
> >> +++ b/drivers/irqchip/irq-atmel-aic5.c
> >> @@ -398,11 +398,16 @@ static int __init sama5d4_aic5_of_init(struct de=
vice_node *node,
> >>   }
> >>   IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_i=
nit);
> >>
> >> -#define NR_SAM9X60_IRQS              50
> >> -
> >>   static int __init sam9x60_aic5_of_init(struct device_node *node,
> >>                                       struct device_node *parent)
> >>   {
> >> -     return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
> >> +     int ret, nr_irqs;
> >> +
> >> +     ret =3D of_property_read_u32(node, "microchip,nr-irqs", &nr_irqs=
);
> >> +     if (ret) {
> >> +             pr_err("Not found microchip,nr-irqs property\n");
> >=20
> > This breaks the ABI. You should ensure old device trees are still worki=
ng
> > with this patch.
>=20
> The only older device that uses this API is sam9x60 and the newly added=
=20
> sam9x7. This change has been tested to be working fine in both the=20
> devices.

Does it still work for a sam9x60 that does not have "microchip,nr-irqs"?
I can't see how it would, because you remove the define and return an
error. That's a pretty clear ABI breakage to me and I don't think it is
justified.

> If you still want me to use the macros as a fallback in the=20
> failure case I can do it. But this change was proposed to avoid adding=20
> macros in the first place. I can remove the error check just like they=20
> do while getting other device tree properties. Or if this is just a=20
> concern of the old devices working with the new change, then sam9x60=20
> works. Please let me know how to proceed.

I just noticed that this property is not documented in a binding. The
first thing you would will be asked when trying to add that is "why can
this not be determined based on the compatible", which means back to
having a define in the driver.
That said, having specific $soc_aic5_of_init() functions for each SoC
seems silly when usually only the number of interrupts changes. The
number of IRQs could be in the match data and you could use
aic5_of_init in your IRQCHIP_DECLARE directly.

> >> +             return ret;
> >> +     }
> >> +     return aic5_of_init(node, parent, nr_irqs);
> >>   }
> >>   IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_=
of_init);
>=20
> --=20
> Thanks and Regards,
> Varshini Rajendran.
>=20

--/QFzMk5rsZSajjp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZerlKQAKCRB4tDGHoIJi
0pT9AQD3Y7yDIjab/erLnSk3oz54G8s2/Z1B0YCajxnyEsOP3wEApgIrOU1U1kkV
5w39xuPTAXOMj04cpNxFVJM+dJ9rowc=
=stem
-----END PGP SIGNATURE-----

--/QFzMk5rsZSajjp0--

