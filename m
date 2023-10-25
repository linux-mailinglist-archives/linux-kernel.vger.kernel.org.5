Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1657D67F2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjJYKMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJYKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:12:03 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C254DD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:11:58 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A37F20008;
        Wed, 25 Oct 2023 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698228716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jMgzyZYNsSoPrwlsfPulfu89a5fDVLfcw7ByX5WjeTo=;
        b=ddT6BDRR9O7epnBawoXXQ8dPgmHv24ToL0cgK8xuNm0EhnMN8LW8Evwdc9RCyNyIFyGZYL
        X/w7FYx5V3wCLGtxZSB0jtPtCapnSpYFVAEybX7yJrA39Mt0pcjoXOoRCy/nvCaAibSVYN
        /30pYO0xrmP1Ox5TwOawuSlun9zJm+0kZmJUHWM0jsmPGBkOdSuBppCyubzAAWiPt79I2V
        RTyw2eIGYeAq1xJcBdtdRt0LE/z9K7ZT/R4jwQH9f43QJp3bjRQIJolyY5rzLiPKIc1Vfj
        gR5UhTv3bQJdfS91Br+he1NDv4BT8lKm6yAz64QERZcqNhTWo8f4scGALGl5rw==
Date:   Wed, 25 Oct 2023 12:11:55 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO
Message-ID: <ZTjp65yjul76zKWm@aptenodytes>
References: <20230608024207.581401-1-suijingfeng@loongson.cn>
 <ZIGAEZTJvq1GqFVD@aptenodytes>
 <50fbc003-fd3c-c7c4-9c6b-76d14a0babfc@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XXhJRH2iPVVMBxvn"
Content-Disposition: inline
In-Reply-To: <50fbc003-fd3c-c7c4-9c6b-76d14a0babfc@loongson.cn>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XXhJRH2iPVVMBxvn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 20 Jun 23, 11:56, Sui Jingfeng wrote:
> Hi,
>=20
> On 2023/6/8 15:15, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > On Thu 08 Jun 23, 10:42, Sui Jingfeng wrote:
> > > drm/logicvc driver is depend on REGMAP and REGMAP_MMIO, should select=
 this
> > > two kconfig option, otherwise the driver failed to compile on platform
> > > without REGMAP_MMIO selected:
> > >=20
> > > ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/gpu/drm/logicv=
c/logicvc-drm.ko] undefined!
> > > make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> > > make: *** [Makefile:1978: modpost] Error 2
> > >=20
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > Thanks for the fix, looks good to me!
> >=20
> > Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> Thanks a lot,
>=20
> Please don't forget to push this to drm-misc or drm-tip if you has the ti=
me,
> as (even though trivial) it's precious for me.

So I totally forgot about this and only pushed it to drm-misc-fixes now.
Sincere apologies for this.

Thanks again for spotting this issue and submitting the fix.

Paul

>=20
>=20
> > Cheers,
> >=20
> > Paul
> >=20
> > > ---
> > >   drivers/gpu/drm/logicvc/Kconfig | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicv=
c/Kconfig
> > > index fa7a88368809..1df22a852a23 100644
> > > --- a/drivers/gpu/drm/logicvc/Kconfig
> > > +++ b/drivers/gpu/drm/logicvc/Kconfig
> > > @@ -5,5 +5,7 @@ config DRM_LOGICVC
> > >   	select DRM_KMS_HELPER
> > >   	select DRM_KMS_DMA_HELPER
> > >   	select DRM_GEM_DMA_HELPER
> > > +	select REGMAP
> > > +	select REGMAP_MMIO
> > >   	help
> > >   	  DRM display driver for the logiCVC programmable logic block from=
 Xylon
> > > --=20
> > > 2.25.1
> > >=20
> --=20
> Jingfeng
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--XXhJRH2iPVVMBxvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmU46esACgkQ3cLmz3+f
v9EH4gf/VK82kGc+gRu4ZBrSXUXxeldKDvts/KckGQ3xfUFQ76tKkHrR56m40o27
TxykXP+jx3dTssP2hl89LmWVGdpTml8xE7raVAsat3HoVoXz56hEffNIUVxwRjzJ
V9NuRUjaYK9VIuxC55XNAFVPTnKkYNFAdIc7I8YfjJIRQkNdbFW6IuA2rcmyp+ir
zgZJ7Kfw3tG2TGIKGCoVAIwlU7mfMSTSzNjAsl/sH82QRaVAGaIDo9FTpfv3z15/
c9DH6C97RPl6jh3cMulCbSuc6Q63kudr5SnDsQXyDpGw++QzaAl+r4OjwQCl7F5M
n6iaNFoVMEH085TZ4SPwba0I2ZqkDA==
=GJ09
-----END PGP SIGNATURE-----

--XXhJRH2iPVVMBxvn--
