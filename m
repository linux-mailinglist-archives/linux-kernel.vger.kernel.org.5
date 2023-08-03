Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE076E6B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjHCLUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjHCLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:20:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A31126;
        Thu,  3 Aug 2023 04:20:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373BJv8Y096622;
        Thu, 3 Aug 2023 06:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691061597;
        bh=hoGqFp8CkBz3knU4UYjFztgLrGPuNWUe37EXbYiLNzU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SOWT2Ma4OxxcfThiX3DrNVR0CaR5AzQ6/73OC7PeWX1uaB48sQQCN3g2rFPPTpolb
         rFgnARE7wascC+H5Jmqt4Si7XFDu515jalgyWTCA9NVtPm6/Ze+Reptkl4eQq6bwFN
         yea+NtbAKzR/ETrASnbd28syjh/79/gc4Z8T/rFE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373BJvBf039614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 06:19:57 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 06:19:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 06:19:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373BJr80035270;
        Thu, 3 Aug 2023 06:19:53 -0500
Date:   Thu, 3 Aug 2023 16:49:57 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>
Subject: Re: [PATCH v8 09/16] media: cadence: csi2rx: Soft reset the streams
 before starting capture
Message-ID: <colvp5wmyedwoxchnifpaqipa7bv7g7hooxev3j5agvnuekfve@3cpxre6uoqbm>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-9-fb7d3661c2c9@ti.com>
 <d84852d8-1ade-94fc-bbc2-c3a4d30fdbe1@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sj63dybvm4x7x4z4"
Content-Disposition: inline
In-Reply-To: <d84852d8-1ade-94fc-bbc2-c3a4d30fdbe1@ideasonboard.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--sj63dybvm4x7x4z4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 01, 2023 at 17:16:41 +0300, Tomi Valkeinen wrote:
> On 31/07/2023 11:29, Jai Luthra wrote:
> > From: Pratyush Yadav <p.yadav@ti.com>
> >=20
> > This resets the stream state machines and FIFOs, giving them a clean
> > slate. On J721E if the streams are not reset before starting the
> > capture, the captured frame gets wrapped around vertically on every run
> > after the first.
> >=20
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > v7->v8: No change
> >=20
> >   drivers/media/platform/cadence/cdns-csi2rx.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/med=
ia/platform/cadence/cdns-csi2rx.c
> > index 2a80c66fb547..30cdc260b46a 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -40,6 +40,7 @@
> >   #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
> >   #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
> > +#define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
> >   #define CSI2RX_STREAM_CTRL_START			BIT(0)
> >   #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
> > @@ -138,12 +139,22 @@ struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct =
v4l2_subdev *subdev)
> >   static void csi2rx_reset(struct csi2rx_priv *csi2rx)
> >   {
> > +	unsigned int i;
> > +
> >   	writel(CSI2RX_SOFT_RESET_PROTOCOL | CSI2RX_SOFT_RESET_FRONT,
> >   	       csi2rx->base + CSI2RX_SOFT_RESET_REG);
> >   	udelay(10);
> >   	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
> > +
> > +	/* Reset individual streams. */
> > +	for (i =3D 0; i < csi2rx->max_streams; i++) {
> > +		writel(CSI2RX_STREAM_CTRL_SOFT_RST,
> > +		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
> > +		usleep_range(10, 20);
> > +		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
> > +	}
>=20
> Do you have to do it like this? Or would it be fine to set the reset bit =
for
> all stream regs, then sleep, then clear the reset bit from all stream reg=
s?
> Or going even further, can you set the CSI2RX_SOFT_RESET_REG and all
> CSI2RX_STREAM_CTRL_REG regs, then sleep, and then clear them all?

You're right I think that should work, and would be much cleaner. Will=20
fix.

>=20
>  Tomi
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--sj63dybvm4x7x4z4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTLjVwACgkQQ96R+SSa
cUUEXhAAv8HzJ4dZ4Cm1uBFXii5KFFi6YxfKFS27jM4P1ZOMQlIubVqDO9NksI4i
KbWqyWc5cnRk8kmllyE8foxsf2QIlqo4wTJiK4lz4g2DTIX8c57wtAWZVpwU3sbV
f7qWrguooSXJIfqN49EmMsvDTledycK+w6Hh3C8zJqZQx83ckekkrxlCOfYzTR1b
MfmQiu4pkIrsXrNIpYE6UXXl65T51ry+AorEeha+KRHI1PihFF1Zh8RoadznrThT
KQRpvAN4eLCro57YBiR4/1zvnYoMfjaxqySsjsFgvsm03Uh0HFYqHBMH9fR1ESmD
QDmgo2bjh9J1sd2cz7GuFL66eDZObv2/jsOyFN5WYMJ1j5+anHYFfM47jFeddRpA
fOYpcDhImAOnFVL+SCMczMb1oQjzppzcpHgXICzg6vsvjoQPh4klpP7h47xzECmG
5zrXIGTmRYOFYGTS4hi1cQ8cU/pqVJhgVHw6xXpVn7tD71y/jG/bHdbUtpoYOpOx
QqkbDPYvG4iwh6N3rcFyJXmhL/m7dzSgUlQhmPRuq+103XyNe2eIjwJKdMQlBBM1
H6Le/YnptekR3LrzeBTNVuXQjIX6ZMikW4Ts6ES3lIdoyd+DFvUiO8y0ORTNi9tw
QEy0heknMbAlLl8Acm97tlvs9IS05KaLWPDmxe66TLG3XLT3p2Y=
=PUnK
-----END PGP SIGNATURE-----

--sj63dybvm4x7x4z4--
