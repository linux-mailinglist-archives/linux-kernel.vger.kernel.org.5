Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA03B7BB51D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjJFK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjJFK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:27:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AFCF4;
        Fri,  6 Oct 2023 03:27:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396AQUom051359;
        Fri, 6 Oct 2023 05:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696587990;
        bh=7uDHChuQq/jcdTtHkM6HxUZGeZgR/X+sPfZ/pEKZioM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=B86yaQq7XPuT1flwhDgQn2FYNBWx2C1d9C8LgZgaFg/++wgUq7mtocvMmvgWLLCof
         UGrsexvHKx25Sv8ID5j3vDk+V+UT0nXjmYeHCLfmG1bj1S1LPLoENQ0HD6ZSoeTci7
         u5/RIKURwrlUwZoN11wysFrVGEOb9cn5tVwFHPeI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396AQUMK113773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Oct 2023 05:26:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 05:26:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 05:26:30 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396AQSbx012160;
        Fri, 6 Oct 2023 05:26:28 -0500
Date:   Fri, 6 Oct 2023 15:56:25 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: Re: [PATCH v9 13/13] media: ti: Add CSI2RX support for J721E
Message-ID: <x7qd7h7jmadf563u2wbfsxwp7s4isvkyqqpmw7t5e6qhccrwkc@yq24sfgl75pe>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-13-8943f7a68a81@ti.com>
 <ad042065-33a2-d42e-ce2e-628464102fc3@ideasonboard.com>
 <wgkjek77bolf5wabki7uhm6cxjy5g5z2ncoc6urr7dv5y6wnaw@yfh7ccogxfea>
 <20230829155513.GG6477@pendragon.ideasonboard.com>
 <ZR1txMVk+4oHLEKU@matsya>
 <20231004200312.GE30342@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jzhpceyqp4shtsmp"
Content-Disposition: inline
In-Reply-To: <20231004200312.GE30342@pendragon.ideasonboard.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jzhpceyqp4shtsmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent, Vignesh, Vinod,

I have some good news, there is an upper bound on the amount of data=20
stored in the FIFOs (~32KB), so we don't need to allocate a buffer of=20
the full frame size.

On Oct 04, 2023 at 23:03:12 +0300, Laurent Pinchart wrote:
> On Wed, Oct 04, 2023 at 07:21:00PM +0530, Vinod Koul wrote:
> > On 29-08-23, 18:55, Laurent Pinchart wrote:
> > > Hi Jai,
> > >=20
> > > (CC'ing Vinod, the maintainer of the DMA engine subsystem, for a
> > > question below)
> >=20
> > Sorry this got lost
>=20
> No worries.
>=20
> > > On Fri, Aug 18, 2023 at 03:55:06PM +0530, Jai Luthra wrote:
> > > > On Aug 15, 2023 at 16:00:51 +0300, Tomi Valkeinen wrote:
> > > > > On 11/08/2023 13:47, Jai Luthra wrote:
> > > > > > From: Pratyush Yadav <p.yadav@ti.com>
> > >=20
> > > [snip]
> > >=20
> > > > > > +static int ti_csi2rx_start_streaming(struct vb2_queue *vq, uns=
igned int count)
> > > > > > +{
> > > > > > +	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(vq);
> > > > > > +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> > > > > > +	struct ti_csi2rx_buffer *buf;
> > > > > > +	unsigned long flags;
> > > > > > +	int ret =3D 0;
> > > > > > +
> > > > > > +	spin_lock_irqsave(&dma->lock, flags);
> > > > > > +	if (list_empty(&dma->queue))
> > > > > > +		ret =3D -EIO;
> > > > > > +	spin_unlock_irqrestore(&dma->lock, flags);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	dma->drain.len =3D csi->v_fmt.fmt.pix.sizeimage;
> > > > > > +	dma->drain.vaddr =3D dma_alloc_coherent(csi->dev, dma->drain.=
len,
> > > > > > +					      &dma->drain.paddr, GFP_KERNEL);
> > > > > > +	if (!dma->drain.vaddr)
> > > > > > +		return -ENOMEM;
> > > > >=20
> > > > > This is still allocating a large buffer every time streaming is s=
tarted (and
> > > > > with streams support, a separate buffer for each stream?).
> > > > >=20
> > > > > Did you check if the TI DMA can do writes to a constant address? =
That would
> > > > > be the best option, as then the whole buffer allocation problem g=
oes away.
> > > >=20
> > > > I checked with Vignesh, the hardware can support a scenario where w=
e=20
> > > > flush out all the data without allocating a buffer, but I couldn't =
find=20
> > > > a way to signal that via the current dmaengine framework APIs. Will=
 look=20
> > > > into it further as it will be important for multi-stream support.
> > >=20
> > > That would be the best option. It's not immediately apparent to me if
> > > the DMA engine API supports such a use case.
> > > dmaengine_prep_interleaved_dma() gives you finer grain control on the
> > > source and destination increments, but I haven't seen a way to instru=
ct
> > > the DMA engine to direct writes to /dev/null (so to speak). Vinod, is
> > > this something that is supported, or could be supported ?
> >=20
> > Write to a dummy buffer could have the same behaviour, no?
>=20
> Yes, but if the DMA engine can write to /dev/null, that avoids
> allocating a dummy buffer, which is nicer. For video use cases, dummy
> buffers are often large.
>=20
> > > > > Alternatively, can you flush the buffers with multiple one line t=
ransfers?
> > > > > The flushing shouldn't be performance critical, so even if that's=
 slower
> > > > > than a normal full-frame DMA, it shouldn't matter much. And if th=
at can be
> > > > > done, a single probe time line-buffer allocation should do the tr=
ick.
> > > >=20
> > > > There will be considerable overhead if we queue many DMA transactio=
ns=20
> > > > (in the order of 1000s or even 100s), which might not be okay for t=
he=20
> > > > scenarios where we have to drain mid-stream. Will have to run some=
=20
> > > > experiments to see if that is worth it.
> > > >=20
> > > > But one optimization we can for sure do is re-use a single drain bu=
ffer=20
> > > > for all the streams. We will need to ensure to re-allocate the buff=
er=20
> > > > for the "largest" framesize supported across the different streams =
at=20
> > > > stream-on time.
> > >=20
> > > If you implement .device_prep_interleaved_dma() in the DMA engine dri=
ver
> > > you could write to a single line buffer, assuming that the hardware w=
ould
> > > support so in a generic way.
> > >=20
> > > > My guess is the endpoint is not buffering a full-frame's worth of d=
ata,=20
> > > > I will also check if we can upper bound that size to something feas=
ible.

According to the spec the endpoint buffers a maximum of 2048 x (128-bit)=20
samples, which comes out to be 32KiB.

I ran some experiments after disabling the drain and looking at the=20
subsequent corrupt frames with stale data, and it was always in=20
multiples of (< 20x) 128-bit samples.

Given we have an upper bound, I think a practical solution for now is to=20
allocate a single re-usable 32KiB buffer at probe time (will send v10=20
with this fix).

Although it would be ideal if we can do this without *any* buffers at=20
all.

> > > >=20
> > > > > Other than this drain buffer topic, I think this looks fine. So, =
I'm going
> > > > > to give Rb, but I do encourage you to look more into optimizing t=
his drain
> > > > > buffer.
> > > >=20
> > > > Thank you!
> > > >=20
> > > > > Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--jzhpceyqp4shtsmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmUf4M4ACgkQQ96R+SSa
cUVzQxAAo+osmT3qMYJ2j5ZIle3NBcSnWBUVdCQQsdGFSZC7u1g60zVXXKFBo1En
/0xerHCo/QN5M0etfOQVXLtKRDKeLYq67irREf4lUy99dEw8QQd3Irw3yjvlafnz
38mYD1jdX36FDj4fcOVz+3uNK5nSFAeJQCrojbQWJmpqsVRibc8Bj8LlwDbwNupG
MEn4az55uJ3qMTyk8SH/uPcfQMK7ORMPYsdXPEQbbzisK6QH/R/2eF3RD/nQSwmA
6kOLHgnUbIHp/dWlytKk1PpoP/cYFxYpF3z7Qt/ytbVDVvOpUxhunpUU22ctP8rw
QJ1zW46aZVM5v+IaL+g3645LUMQ92lpFgct9mjO6OnB0Pzs0aFiDxOSdUY4qwEJb
c2YwJNLBGMPUvhOFlzzmEhU7QpedZVMEekI0TSC2lCHwG/WnFfrR0DeNPtJsjyyW
3alu03ezmnYFKvPM+JtRU5QJQMkFMkNaJKqVZaywjBDdCfsq8paOPjuIORtyq1MW
enpuvhmIP36fOkLGDKdFYVvEz9afx4UsyF397d450AWtrdsMT6gwJJS5IlQ08VGs
f8oBp8xtBKDxkcC6nBlLzjyPiDfdk5lZF8E0rYZUneb0olGfrxCkvir+ZPqKLkjk
yLCg6nZB+ANHUfD0ttmlBZusgp4ShiDu3V0EBS8jk2jEeLuxQAU=
=J+Ca
-----END PGP SIGNATURE-----

--jzhpceyqp4shtsmp--
