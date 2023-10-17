Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A097CC4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjJQNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjJQNj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:39:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47290FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:39:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D906FC433C7;
        Tue, 17 Oct 2023 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697549965;
        bh=RoziKrsJD6E/nYyqj1Ebyaqd5eUcEo8AVJSKW+3q8Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLI/hFsoGvWGtDNMHNjVmk8Aif9SDW8uUk/Qs3QPPnJ/83dHmSlP3iLgBU/FgFJ/e
         ty3sOM8v6yaPaNEW5RJF3RD99KnzalPIePCpPmhSvN4aPcHN1dQD5ku6jQps9d3oh8
         sDWT16mUg/KvDIbhbmn3ACgaa55WeOr+pt03CvSGLIqCKN7m3Mrz1mniPnT/68N0xb
         71HfYdTfP0O7c1fP0LpnIA/QvMx3QSMnEVbMrvYQjWikpypkfa1Ulu3i67GflhP8zr
         F72lDm4g5eDOldNW7GdDXYlKTAG7CNza+jvfvQfg6pwcU7jV36yyfy5qSsUqy7YkGG
         OA6N6Q51RdAVg==
Date:   Tue, 17 Oct 2023 14:39:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Ante Knezic <ante.knezic@helmholz.de>, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <20231017-mocker-contort-5ea0d84e7e2d@spud>
References: <20231012-unicorn-rambling-55dc66b78f2f@spud>
 <20231016075349.18792-1-ante.knezic@helmholz.de>
 <20231017-generous-botanical-28436c5ba13a@spud>
 <8e1fb87d-b611-49f3-8091-a15b29e03659@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bEjA3mPhipjMVa1a"
Content-Disposition: inline
In-Reply-To: <8e1fb87d-b611-49f3-8091-a15b29e03659@lunn.ch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bEjA3mPhipjMVa1a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 02:59:46PM +0200, Andrew Lunn wrote:
> > The switch always provides it's own external reference, wut? Why would
> > anyone actually bother doing this instead of just using the internal
> > reference?
>=20
> I think you are getting provider and consumer mixed up.

The comment suggested that it was acting as both, via an external
loopback:
> > > In both cases (external and internal), the KSZ88X3 is actually provid=
ing the
> > > RMII reference clock. Difference is only will the clock be routed as =
external
> > > copper track (pin REFCLKO -> pin REFCLKI), or will it be routed inter=
nally.

If there's another interpretation for that, it's lost on me.
A later mail goes on to say:
> > > The KSZ88x3 does not have to provide the reference clock, it can be p=
rovided=20
> > > externally, by some other device, for example the uC.

So I think I was just picking up on a mistaken explanation.

> Lets simplify to just a MAC and a PHY. There needs to be a shared
> clock between these two. Sometimes the PHY is the provider and the MAC
> is the consumer, sometimes the MAC is the provider, and the PHY is the
> consumer. Sometimes the hardware gives you no choices, sometimes it
> does. Sometimes a third party provides the clock, and both are
> consumers.
>=20
> With the KSZ, we are talking about a switch, so there are multiple
> MACs and PHYs. They can all share the same clock, so long as you have
> one provider, and the rest are consumers. Or each pair can figure out
> its provider/consumer etc.

Thanks for the explanation. I'm still not really sure why someone would
want to employ external loopback, instead of the internal one though.

> How this is described in DT has evolved over time. We don't have clean
> clock provider/consumer relationships. The PHYs and MACs are generally
> not CCF consumers/providers. They just have a property to enable the
> to output a clock, or maybe a property to disable the clock output in
> order to save power. There are a few exceptions, but that tends to be
> where the clock provider is already CCF clock, e.g. a SoC clock.

Yeah, I did acknowledge that at the end of my mail (although I managed
to typo "that ship has sailed").
Doing ccf stuff doesn't seem viable given there's currently no required
clocks in the binding despite there likely being some in use.

I'm fine acking the binding with the change I suggested, I was just
looking to understand why a clocks property could not be used and I
think I have my answer to that now :)

Cheers,
Conor.

--bEjA3mPhipjMVa1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS6OiAAKCRB4tDGHoIJi
0lngAP0awQQcWcRDsKtuYoRW+xSLTyZWxTzBEKqGSpcMoFbF0QD8CHLj8FgKI1gO
ziNYtHwUuZkjpwMVzPO85p04nsb3vwU=
=J1bT
-----END PGP SIGNATURE-----

--bEjA3mPhipjMVa1a--
