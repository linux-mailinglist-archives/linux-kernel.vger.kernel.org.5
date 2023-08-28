Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7878AF94
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjH1MGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjH1MF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C37123;
        Mon, 28 Aug 2023 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693224352; x=1724760352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O6MRAyoEtfQ9DRy06G8t5QMNAD8AO1fOCtzMUgHmNmw=;
  b=0WOT4hUuRU/jT4aVEBEMPTZgpt7VDTg3jaQ4U5QN2SsWFr0RG/92j3xy
   FCuBHrl6GDjXMrD5NBoP5Ni3+kaOfSmaOJuaG0dCjYsZqsnSivAaU9zp6
   vBcOfDO8f8k+lDwaGvAmhlixwHU/AAmz2ppX5M6TIdZqZX51ytYWGcQDE
   x2hBS3feUfvOJRI4VNilsbT3KoqGP5aXEZtmifDARusRd0mMq87ByjDEZ
   XJyFU6hA6qh7SQJ67OYvvC249mZAOQQK7TJveKMFN9wcbvoQNPsYWPvC0
   OAKfRyghnaY/leaZACLQVSgywHF+YKmAg7Ydo3uP/uDqjKFwii1TkKcDb
   A==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="asc'?scan'208";a="1589705"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2023 05:05:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 28 Aug 2023 05:05:50 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 28 Aug 2023 05:05:48 -0700
Date:   Mon, 28 Aug 2023 13:05:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [-next v1] riscv: dts: starfive: visionfive 2: Enable usb0 and
 fix tdm pins sort order
Message-ID: <20230828-hence-unguarded-2020c68246e8@wendy>
References: <20230828115239.16012-1-hal.feng@starfivetech.com>
 <3a5e343c-a0cc-8d1b-eadc-82c3d038aaa1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MhLadpHa6s8sAqHw"
Content-Disposition: inline
In-Reply-To: <3a5e343c-a0cc-8d1b-eadc-82c3d038aaa1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MhLadpHa6s8sAqHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 01:54:53PM +0200, Krzysztof Kozlowski wrote:
> On 28/08/2023 13:52, Hal Feng wrote:
> > usb0 was disabled by mistake when merging, so enable it.
> > tdm_pins node should be sorted alphabetically.
> >=20
> > Fixes: e7c304c0346d ("riscv: dts: starfive: jh7110: add the node and pi=
ns configuration for tdm")
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  .../jh7110-starfive-visionfive-2.dtsi         | 49 ++++++++++---------
> >  1 file changed, 25 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.=
dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > index d79f94432b27..382dfb5e64e4 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > @@ -440,30 +440,6 @@ GPOEN_ENABLE,
> >  		};
> >  	};
> > =20
> > -	uart0_pins: uart0-0 {
> > -		tx-pins {
> > -			pinmux =3D <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> > -					     GPOEN_ENABLE,
> > -					     GPI_NONE)>;
> > -			bias-disable;
> > -			drive-strength =3D <12>;
> > -			input-disable;
> > -			input-schmitt-disable;
> > -			slew-rate =3D <0>;
> > -		};
> > -
> > -		rx-pins {
> > -			pinmux =3D <GPIOMUX(6, GPOUT_LOW,
> > -					     GPOEN_DISABLE,
> > -					     GPI_SYS_UART0_RX)>;
> > -			bias-disable; /* external pull-up */
> > -			drive-strength =3D <2>;
> > -			input-enable;
> > -			input-schmitt-enable;
> > -			slew-rate =3D <0>;
> > -		};
> > -	};
> > -
> >  	tdm_pins: tdm-0 {
> >  		tx-pins {
> >  			pinmux =3D <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
> > @@ -497,6 +473,30 @@ GPOEN_DISABLE,
> >  			input-enable;
> >  		};
> >  	};
> > +
> > +	uart0_pins: uart0-0 {
> > +		tx-pins {
> > +			pinmux =3D <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> > +					     GPOEN_ENABLE,
> > +					     GPI_NONE)>;
> > +			bias-disable;
> > +			drive-strength =3D <12>;
> > +			input-disable;
> > +			input-schmitt-disable;
> > +			slew-rate =3D <0>;
> > +		};
> > +
> > +		rx-pins {
> > +			pinmux =3D <GPIOMUX(6, GPOUT_LOW,
> > +					     GPOEN_DISABLE,
> > +					     GPI_SYS_UART0_RX)>;
> > +			bias-disable; /* external pull-up */
> > +			drive-strength =3D <2>;
> > +			input-enable;
> > +			input-schmitt-enable;
> > +			slew-rate =3D <0>;
> > +		};
>=20
>=20
> What is fixed in this hunk? Order of nodes is just a style, not a bug
> needing backports.

Please split this in two parts, with one for my screwed up conflict
resolution & one for the node ordering.

Thanks,
Conor.

--MhLadpHa6s8sAqHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOyNcgAKCRB4tDGHoIJi
0uqlAP4sF6J64UT/Pd03FqT46P6r0Od0LOWesJCEDCV4129ZIQEAqq0rQy6enR9p
UV3JE+uFdxZlRCqpcfw5cCHNW+7uFwQ=
=+HXt
-----END PGP SIGNATURE-----

--MhLadpHa6s8sAqHw--
