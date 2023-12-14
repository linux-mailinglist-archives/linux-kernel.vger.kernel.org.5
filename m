Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C173813128
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjLNNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjLNNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:16:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CA610E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:17:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EFFC433C8;
        Thu, 14 Dec 2023 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702559821;
        bh=JHyomd0Q9NPn9A6jdZewEr+8uII5CmAyP0V6PrfA4bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cs7sirs9h0XVwnqWYZLR/SKUFu2N9cpp0Yiz0d+uM6Gx48N7jql/U1q1F0Baw8AK0
         KAsMhLeqa+jA25Lv7z282d9rx/9Bx3RtE/7rtOpsLo2hAMJVn/cb8uNlOCUh9G1tRa
         Q4BlAFF9y8gqm4V1uwSrFjju+NkuQAPifpstroy8LPfPit/KVjSN39cF+u1fdTDuFr
         wxH9zOBWW1Jj+JAaA2/6ttNAWNB3DcevrU39jZyxIV3queyCIejv1lioZzsj2CMqI5
         YpAEj54TSUVWnVHEfGb4FtOIqjOnmePv+hf2aM31ld4yumAISfJy8yxIVIZjHqK8C8
         P5OilGkQLL67g==
Date:   Thu, 14 Dec 2023 13:16:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing
 required clock
Message-ID: <20231214-tinderbox-paver-d1ff0fc5c428@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
 <20231212-unreeling-depose-8b6b2e032555-mkl@pengutronix.de>
 <20231213-waffle-grueling-3a5c3879395b@spud>
 <20231214-tinderbox-glitzy-60d1936ab85f-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8sbtDukOq8t99rKn"
Content-Disposition: inline
In-Reply-To: <20231214-tinderbox-glitzy-60d1936ab85f-mkl@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8sbtDukOq8t99rKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:31:04PM +0100, Marc Kleine-Budde wrote:
> On 13.12.2023 13:02:49, Conor Dooley wrote:
> > On Tue, Dec 12, 2023 at 09:49:41PM +0100, Marc Kleine-Budde wrote:
> > > On 08.12.2023 17:12:24, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > >=20
> > > > The CAN controller on PolarFire SoC has an AHB peripheral clock _an=
d_ a
> > > > CAN bus clock. The bus clock was omitted when the binding was writt=
en,
> > > > but is required for operation. Make up for lost time and add it.
> > > >=20
> > > > Cautionary tale in adding bindings without having implemented a real
> > > > user for them perhaps.
> > > >=20
> > > > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN=
 controller")
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++=
++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/net/can/microchip,mp=
fs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > index 45aa3de7cf01..05f680f15b17 100644
> > > > --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > @@ -24,7 +24,10 @@ properties:
> > > >      maxItems: 1
> > > > =20
> > > >    clocks:
> > > > -    maxItems: 1
> > > > +    maxItems: 2
> > > > +    items:
> > > > +      - description: AHB peripheral clock
> > > > +      - description: CAN bus clock
> > >=20
> > > Do we we want to have a "clock-names" property, as we need the clock
> > > rate of the CAN bus clock.
> >=20
> > We should not need the clock-names property to be able to get both of
> > the clocks. clk_bulk_get_all() for example should be usable here.
>=20
> ACK, but we need the clock rate of CAN clock. Does this binding check
> that the CAN clock rate is the 2nd one?

The items list requires that the can clock be the second one, so drivers
etc can rely on that ordering.

--8sbtDukOq8t99rKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsARwAKCRB4tDGHoIJi
0h9wAP903owgON0b07MdLtwGROU5QzSNFLxoBOqorLvQyAIqpAD+NUlz2g5CmXeF
4jrpFftFyQNgWbQ8mC2atxX5XKUNvA4=
=LB6e
-----END PGP SIGNATURE-----

--8sbtDukOq8t99rKn--
