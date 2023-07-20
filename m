Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70275B6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjGTSjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGTSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CBE47;
        Thu, 20 Jul 2023 11:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA40261BF4;
        Thu, 20 Jul 2023 18:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F989C433C8;
        Thu, 20 Jul 2023 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878336;
        bh=yttvyoy4pGho7uFMrVWukdfpMuIr8m8/eZM4VTHyMBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kCXKTuyfPYDCg8nw3tZ4zlawqfKhnunLcdtSp0BaiV2t1Hc/RaYyBc9ey619kMkNy
         es65TMBp1vMy4WheHdU/1a6rgBzaXUMiuPbDJeTuBSBJVBsdikaeLHsjGodcx7VRDE
         bywMjFK6JtwaDlxxN0kLq3LDtJDY0ID6cVt45WidSphZEkL83hWIodlGTzkWYCu9s6
         WSL5FH1YICUW9fznGWyxYnoQh8QGL2/cbIRdSXP0UUrvn+WYmfL4Kb5ZUpHGr0afHW
         0yQlczjG9+EoEN0kbGWJN8b6D5M8fwxUEiOhyF7DJHOaDTqPULQj7FAxdsbSeFDIgp
         w9585eXK7hbNA==
Date:   Thu, 20 Jul 2023 19:38:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Marius.Cristea@microchip.com>
Cc:     <conor@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230720193848.5b9c3b59@jic23-huawei>
In-Reply-To: <0cd0a08c38bd261664b6a0dafe85c32bdc68249a.camel@microchip.com>
References: <20230714150051.637952-1-marius.cristea@microchip.com>
        <20230714150051.637952-2-marius.cristea@microchip.com>
        <20230715-violate-suburb-ba9ae0a46674@spud>
        <0cd0a08c38bd261664b6a0dafe85c32bdc68249a.camel@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 09:24:58 +0000
<Marius.Cristea@microchip.com> wrote:

> Hey Conor,
>=20
>=20
> On Sat, 2023-07-15 at 11:28 +0100, Conor Dooley wrote:
> > Hey,
> >=20
> > On Fri, Jul 14, 2023 at 06:00:50PM +0300,
> > marius.cristea@microchip.com=C2=A0wrote: =20
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > >=20
> > > This is the device tree schema for iio driver for
> > > Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> > > Delta-Sigma ADCs with an SPI interface (Microchip's
> > > MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> > > MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> > > MCP3562R and MCP3564R analog to digital converters).
> > >=20
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com> =20
> >=20
> > This looks good to me, other than the custom property, for which I
> > can't
> > tell if a consensus was reached on last time around.
> >  =20
>=20
>   I don't think a consensus related to "custom property" was reached
> last time around. I was aiming to fix all other review comments first
> and leave the "details" at the end.

That's fair enough as a way to move things forward - just make sure to
mention open questions in your cover letter / patch descriptions or
under the ---

>=20
>  I still think is a good idea to have some custom properties that will
> impact only a certain range of devices and leave the user to
> decide/choose how to use that configuration setting (to better suite
> his needs). If the application doesn't recognize the property it will
> be configured with the default value and it should not broke anything.
>=20
> If we decide that we need to take out the custom properties, then I
> could move some of them into the Device Tree.
>=20
> > > +=C2=A0 microchip,hw-device-address:
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > +=C2=A0=C2=A0=C2=A0 minimum: 0
> > > +=C2=A0=C2=A0=C2=A0 maximum: 3
> > > +=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The address is set on a per-device ba=
sis by fuses in the
> > > factory,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configured on request. If not request=
ed, the fuses are set
> > > for 0x1.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The device address is part of the dev=
ice markings to avoid
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 potential confusion. This address is =
coded on two bits, so
> > > four possible
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addresses are available when multiple=
 devices are present on
> > > the same
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI bus with only one Chip Select lin=
e for all devices.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Each device communication starts by a=
 CS falling edge,
> > > followed by the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocking of the device address (BITS[=
7:6] - top two bits of
> > > COMMAND BYTE
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 which is first one on the wire). =20
> >=20
> > On the last version, the last comment I could find on lore was
> > https://lore.kernel.org/all/20230609184149.00002766@Huawei.com/
> > where Jonathan and Rob were discussing whether or not a spi-mux type
> > of
> > thing could work, but it does not seem to have ended conclusively.
> >=20
> > Rob or Jonathan, would you mind commenting on that?
> >  =20
>=20
> I think in case of a single device on bus, we could avoid using the
> spi-mux.
>=20

That's a fair point.  I think key here is how common this is, and
I have no idea.

> > > If this is required for some devices, I'd expect to see the binding
> > > enforce
> > > that with some required entries conditioned on the compatibles
> > > rather than as
> > > documentation. If there are devices where it isn't even optional
> > > then the binding
> > > should enforce that as well. =20
> >=20
> > The binding does now enforce the vref supply where relevant, but it
> > sounds like you were looking more supplies to be documented Jonathan?
> > (AVdd, DVdd etc)
> >  =20
>=20
>  All other supply (like AVdd, DVdd etc) for this particular chip
> doesn't have any direct impact (way of working, resolution, any
> configuration setup), so I'm not sure if we need to add anything more
> here.
>=20

Pretty big impact if they aren't turned on ;)  Expectation is the driver
will just ensure they are and it can only do that if it knows they exist.

Jonathan


