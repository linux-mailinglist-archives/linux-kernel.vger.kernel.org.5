Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97AA7A509E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjIRRKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjIRRJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:09:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF81A6;
        Mon, 18 Sep 2023 10:09:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14FCC433C8;
        Mon, 18 Sep 2023 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695056990;
        bh=ie0dC3735TiHhNHywyLZGNNJXTNALR8fq5hX9ARI43M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRl8ot8Ru8cylWwmvUFsC8/QAQNlyPWbLQhkGQilrOqy854VlLcloQduphYb9MHC2
         3HCe61+jkh1M/lMJDiC3PBW/Ns73uVWyeUz+q8W3CMGW1Gjgno7tz73rdtIV4SLjLa
         5AN+SgTBbhUmWHxcZcDSw5r3aClyXXPfT3QFzH/TR02CVAjnqm7qDwlkxEj2OLS8AX
         DjcsOOlSBvr7YJ65DwkVixKUIttWLzS3buBYqRI2NJx0JDJUB4seW3FTOTcns9LZ/J
         H/5ezvoK5RHeNZRE+N7H4PTGjvxxrb+gZ5/xMBcjLvHJiFBmVvxLIh0lfJsh6eZedy
         g9veMrkFyCBhQ==
Date:   Mon, 18 Sep 2023 18:09:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nik Bune <n3q5u8@yahoo.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert txt
 to yaml
Message-ID: <20230918-929fd60eab94754c28ce5cd4@fedora>
References: <20230916154826.84925-1-n3q5u8@yahoo.com>
 <20230917193556.10783-1-n3q5u8@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="73rtgbxXCV6DBhLK"
Content-Disposition: inline
In-Reply-To: <20230917193556.10783-1-n3q5u8@yahoo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--73rtgbxXCV6DBhLK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 09:35:56PM +0200, Nik Bune wrote:
> Hello, thank you for your review!=20
>=20
> On Sat, Sep 16, 2023 at 10:37:23PM +0200, Krzysztof Kozlowski wrote:
>=20
> >On 16/09/2023 17:48, Nik Bune wrote:
> >> Convert txt file to yaml.
> >> Add reg to the list of required properties.
> >> Add mainteiners from ./scripts/get_maintainer.pl output.
> >>
> >> Signed-off-by: Nik Bune <n3q5u8@yahoo.com>
> >> ---
> >>  .../watchdog/atmel,at91rm9200-wdt.yaml        | 31 +++++++++++++++++++
> >>  .../watchdog/atmel-at91rm9200-wdt.txt        |  9 ------
> >>  2 files changed, 31 insertions(+), 9 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,a=
t91rm9200-wdt.yaml
> >>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-a=
t91rm9200-wdt.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91rm92=
00-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-w=
dt.yaml
> >> new file mode 100644
> >> index 000000000000..e9706b9c1e6b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.=
yaml
> >> @@ -0,0 +1,31 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> >
> >How this copyright appeared here? Why are you adding some 2022
> >copyrights of someone else?
>=20
> I copied it from the neighbour file atmel,at91sam9-wdt.yaml.
> I assume I should leave only "SPDX-License-Identifier: (GPL-2.0-only OR B=
SD-2-Clause)" here.

The original file does not contain a license, which means (AFAIU) to
GPL-2.0-only, unless the original author ACKs a relicensing.

>=20
> Thank you!

--73rtgbxXCV6DBhLK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQiEVAAKCRB4tDGHoIJi
0ot9AP9gc12jMqf92DMjVEqIb7XtEMn6oIkJS8wSL0SfQVFYhQEAiBYvCYLNFJKd
NXAz7wDn0QEFAHtv54asRO5qYtO0wQI=
=Df90
-----END PGP SIGNATURE-----

--73rtgbxXCV6DBhLK--
