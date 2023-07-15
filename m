Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D0175482D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGOK2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4697F35AA;
        Sat, 15 Jul 2023 03:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B457B60B86;
        Sat, 15 Jul 2023 10:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAB8C433C8;
        Sat, 15 Jul 2023 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689416888;
        bh=RBrOtzZRaro0n/lq0fDKpGTItuE9rHeJZ9F21hfPGDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORylvkw9rluvnznK2Rcp/xETYdF8E460CkIvf4ecYDgf1US/hURFY+6Hs3ZHwWGG+
         6gX1khIspZYRniuNAqR+8QIMnnCssJtOB0uIdSFoD+ojB550KLkcymfmXvpGYSqGft
         7q9pGSotrsjXeepxGaFWcU+mgJKQ+GWyj09hU0p1z3phIeetTRtf+ygWSC3wPlY5ct
         /htn7nyuwOJo56s/wsdKZkTAk/uSXfEzrpEqCh6x7y2nUqFe2ceMxwLzGq+8/Hk/1O
         Q+JGYYXaiGbBUVEljJEJWrJtPiNYrWQjCRETYvDd0CEGdTZrBkQLpYyCcsqiHnMoad
         ly8w9lzBl+yeQ==
Date:   Sat, 15 Jul 2023 11:28:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     marius.cristea@microchip.com
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230715-violate-suburb-ba9ae0a46674@spud>
References: <20230714150051.637952-1-marius.cristea@microchip.com>
 <20230714150051.637952-2-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Oh3cr62XzJVDrboW"
Content-Disposition: inline
In-Reply-To: <20230714150051.637952-2-marius.cristea@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oh3cr62XzJVDrboW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Jul 14, 2023 at 06:00:50PM +0300, marius.cristea@microchip.com wrot=
e:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the device tree schema for iio driver for
> Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface (Microchip's
> MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> MCP3562R and MCP3564R analog to digital converters).
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

This looks good to me, other than the custom property, for which I can't
tell if a consensus was reached on last time around.

> +  microchip,hw-device-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    description:
> +      The address is set on a per-device basis by fuses in the factory,
> +      configured on request. If not requested, the fuses are set for 0x1.
> +      The device address is part of the device markings to avoid
> +      potential confusion. This address is coded on two bits, so four po=
ssible
> +      addresses are available when multiple devices are present on the s=
ame
> +      SPI bus with only one Chip Select line for all devices.
> +      Each device communication starts by a CS falling edge, followed by=
 the
> +      clocking of the device address (BITS[7:6] - top two bits of COMMAN=
D BYTE
> +      which is first one on the wire).

On the last version, the last comment I could find on lore was
https://lore.kernel.org/all/20230609184149.00002766@Huawei.com/
where Jonathan and Rob were discussing whether or not a spi-mux type of
thing could work, but it does not seem to have ended conclusively.

Rob or Jonathan, would you mind commenting on that?

There was also a comment from Jonathan:
> > +  vref-supply:
> > +    description:
> > +      Some devices have a specific reference voltage supplied on a dif=
ferent
> > +      pin to the other supplies. Needed to be able to establish channe=
l scaling
> > +      unless there is also an internal reference available (e.g. mcp35=
64r)
> > +
>=20
> From a quick glance at a random datasheet, looks like there additional po=
wer supplies
> that should be required.
>=20
> If this is required for some devices, I'd expect to see the binding enfor=
ce
> that with some required entries conditioned on the compatibles rather tha=
n as
> documentation. If there are devices where it isn't even optional then the=
 binding
> should enforce that as well.

The binding does now enforce the vref supply where relevant, but it
sounds like you were looking more supplies to be documented Jonathan?
(AVdd, DVdd etc)

Thanks,
Conor.

--Oh3cr62XzJVDrboW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLJ0rwAKCRB4tDGHoIJi
0isjAQD8UKTFLjhVVZNOKG3SxHZ2MSbjJTicurz/lGEhX0YZ+AEAyRtXyPVr+4oN
UAukwJ6YwGk8zpf7ck0aQps5Y++sfwc=
=BpcV
-----END PGP SIGNATURE-----

--Oh3cr62XzJVDrboW--
