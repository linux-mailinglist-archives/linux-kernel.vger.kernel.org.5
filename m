Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD88763E93
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGZSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGZSd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367CF19BA;
        Wed, 26 Jul 2023 11:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C615B61C4B;
        Wed, 26 Jul 2023 18:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21706C433C8;
        Wed, 26 Jul 2023 18:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690396405;
        bh=5JnWoqtEcU9DhfiUaTqr/C9Lssp/Jb9WeMs87Dlgghg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btaVPPeydLGO/4F3TsrRFLRMqKxaxw14UAFwVAMs0w7g5/2lJ+jz8jXgtzRSGrFMh
         OaHaX/VldxXY+We0ZXV/b0NzSKPhLvWoGlxptRBmy9FzXG9hqnrvNx18yWl5kil70l
         uUCCvHUdoXv/egJ4/+jlHQh1ZLsp6ZoWz/+ky6yBop6Hf3Rk9OKpq5HIwhk19bb6Vm
         NYVij4ig8Pa16VhFx4UCunmsvqjuQ7YwtnHcul6yt9LywK1ry0jX9GLqGptqklIgnr
         l8d9b7KD1lsfRrjG5H9IlqcAg2aSgGB8YGslZVD0etGrTb4wHP7qEK3TGygZj6dLZy
         cL//8xhoR0lbQ==
Date:   Wed, 26 Jul 2023 19:33:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: ksz9477_evb: Add missing timer nodes
Message-ID: <20230726-igloo-science-96e926f086f6@spud>
References: <20230712152111.3756211-1-lukma@denx.de>
 <20230726101902.769f6541@wsk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KlkmgP3458lT5iDu"
Content-Disposition: inline
In-Reply-To: <20230726101902.769f6541@wsk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlkmgP3458lT5iDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 10:19:02AM +0200, Lukasz Majewski wrote:
> Dear Community,
>=20
> > Without this change the KSZ9477-EVB board hangs just after passing
> > execution flow from u-boot to Linux kernel.
> >=20
> > This code has been copied from at91-sama5d3_xplained.dts.
> >=20
> > Test setup: Linux 6.5-rc1
> > Config:     arch/arm/configs/sama5_defconfig
> > Toolchain:  gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabi
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  .../boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts  | 12
> > ++++++++++++ 1 file changed, 12 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
> > b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts index
> > 14af1fd6d247..99cd6d15998b 100644 ---
> > a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts +++
> > b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts @@ -162,6
> > +162,18 @@ };
> >  };
> > =20
> > +&tcb0 {
> > +	timer0: timer@0 {
> > +		compatible =3D "atmel,tcb-timer";
> > +		reg =3D <0>;
> > +	};
> > +
> > +	timer1: timer@1 {
> > +		compatible =3D "atmel,tcb-timer";
> > +		reg =3D <1>;
> > +	};
> > +};
> > +
> >  &usb0 {
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&pinctrl_usba_vbus>;
>=20
> Gentle ping on this fix ...

Claudiu has left Microchip, so things might've got a bit lost on the
way. I've added his new address, Claudiu, will you take a look/pick this
up please? I can also do it if that is easier for you.

Thanks,
Conor.

--KlkmgP3458lT5iDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFm8AAKCRB4tDGHoIJi
0gdvAQCHl+tV1VwtWJVltrks+jslsgaAFUe1PVWq7wPxcoKszwD9HgCxBTUQoQ4x
p812g3F0VCWepjWrWf10m5VLnBnmbgE=
=Br94
-----END PGP SIGNATURE-----

--KlkmgP3458lT5iDu--
