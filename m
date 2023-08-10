Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A14777DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjHJQPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjHJQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD972132;
        Thu, 10 Aug 2023 09:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E0C866251;
        Thu, 10 Aug 2023 16:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE50AC433C7;
        Thu, 10 Aug 2023 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691684131;
        bh=oMjPUxnHzw7Y/ZVcSNAMA2Yb6XEW9AEaBsjHpyVClnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLbCIjRVM5XowrAAC37ahiQeCY1xtCpZbpKxrqj41WcFNFzq0Ic5Q1TY6oilTbZ1R
         PQIOhtKuReAG8wdByO1PqpAmc4nttcTiNURs17YZ27cjd/c1YeDK9dBVwNlXIi2Hvj
         Kr5NWD3aX1xGVTk/RLUSgMiSViSYMV1Fb+tN083/4JebgSYBPiblkcIfHxrjQ/0YyC
         dlRVVF6fd1YJAfjzQmB/7H2UW3noEpMZafTgF535z1uCEBO4xlppgGdnWg7E9urCnT
         dJBgMyHn8FfvRoiZp4DDUEFwAg+VU5FPtSj3idfanK0xsxNIoMcihxL8Xf5nfzvyM6
         CEp2Ej421VCjg==
Date:   Thu, 10 Aug 2023 17:15:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <20230810-opossum-constable-719273142ce3@spud>
References: <20230807164151.1130-1-jszhang@kernel.org>
 <20230807164151.1130-10-jszhang@kernel.org>
 <20230808-clapper-corncob-0af7afa65752@spud>
 <ZNUJSvJi+9QsWhAf@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6gBy529METjDWfNu"
Content-Disposition: inline
In-Reply-To: <ZNUJSvJi+9QsWhAf@xhacker>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6gBy529METjDWfNu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 11:59:06PM +0800, Jisheng Zhang wrote:
> On Tue, Aug 08, 2023 at 08:39:58AM +0100, Conor Dooley wrote:
> > On Tue, Aug 08, 2023 at 12:41:50AM +0800, Jisheng Zhang wrote:
> > > The IP supports per channel interrupt, add support for this usage cas=
e.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  .../devicetree/bindings/net/snps,dwmac.yaml   | 33 +++++++++++++++++=
++
> > >  1 file changed, 33 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/=
Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > index 5d81042f5634..5a63302ad200 100644
> > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > @@ -109,6 +109,7 @@ properties:
> > >        - description: The interrupt that occurs when Rx exits the LPI=
 state
> > >        - description: The interrupt that occurs when Safety Feature C=
orrectible Errors happen
> > >        - description: The interrupt that occurs when Safety Feature U=
ncorrectible Errors happen
> > > +      - description: All of the rx/tx per-channel interrupts
> > > =20
> > >    interrupt-names:
> > >      minItems: 1
> > > @@ -118,6 +119,38 @@ properties:
> > >        - const: eth_lpi
> > >        - const: sfty_ce
> > >        - const: sfty_ue
> > > +      - const: rx0
> > > +      - const: rx1
> > > +      - const: rx2
> > > +      - const: rx3
> > > +      - const: rx4
> > > +      - const: rx5
> > > +      - const: rx6
> > > +      - const: rx7
> > > +      - const: rx8
> > > +      - const: rx9
> > > +      - const: rx10
> > > +      - const: rx11
> > > +      - const: rx12
> > > +      - const: rx13
> > > +      - const: rx14
> > > +      - const: rx15
> > > +      - const: tx0
> > > +      - const: tx1
> > > +      - const: tx2
> > > +      - const: tx3
> > > +      - const: tx4
> > > +      - const: tx5
> > > +      - const: tx6
> > > +      - const: tx7
> > > +      - const: tx8
> > > +      - const: tx9
> > > +      - const: tx10
> > > +      - const: tx11
> > > +      - const: tx12
> > > +      - const: tx13
> > > +      - const: tx14
> > > +      - const: tx15
> >=20
> > I don't think Rob's comment about having added 2 interrupts but 32
> > interrupt names has been resolved.
>=20
> I misunderstood Rob's comment. Now I'm not sure whether dt-binding
> can support regex or something or not, or let ask for advice in the
> following way: how could I write the dt-binding in this case? I didn't
> find similar examples so far. I'm not sure listing possible
> description and const properties for all channel interrupts is suitable.

I'm not sure that there is a better way. Rob maybe has a suggestion.

> > Did you actually test putting this many interrupts into a node?
> > AFAICT, any more than 6 will cause complaints.
>=20
> I tried 12rx and 12tx interrupts in a node, didn't see dtc warning.
> so I guess the complaints are from dtb check? I will try to reproduce
> them.

I triggered some by putting more entries into the example in this
binding & doing dt binding check.

--6gBy529METjDWfNu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNUNHgAKCRB4tDGHoIJi
0tqNAQCOX/1r2yJ3Pi1gHBE8DaO5VFE9xioaBCcs1I7gZX4RgwD8CtZ2Cw7+BjeK
lMXgOhmwNRHgebIqUPtvRnzFD7azTQk=
=zcVj
-----END PGP SIGNATURE-----

--6gBy529METjDWfNu--
