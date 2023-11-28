Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50167FC27E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbjK1OlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345741AbjK1OlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:41:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA211B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:41:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210BAC433C8;
        Tue, 28 Nov 2023 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701182474;
        bh=U2H+GaDgE1dc4siI/syiwRHS98L9I2baF5G5hcg3p/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6TNTicPVl5nDAiXtQpSjzw2y84+MOfRlm6UC9/qN7eRwrjnuN2a19WAxn+wjIcf7
         7iq/UQgsK5YE6QI8tBvpEJ1NnnAo7sZo7T5/g3CsHzZWP1TLHQ3bOGyvBbTdL0f+Lh
         FxWq+10RM8IKbgIwNGU8Z4cagslUoY/dUrFeQcKtcM7eCR1ftEYXP2gDRfsGvK2pWS
         2MtslNlOaWBkWIEkgyGwAqGkafxaPh+px9YFtpCjEAqGQqTB5rHVkdKZXjWrRg1akB
         kM06/0FWFkd2rDyFKtH9UZS4No8lm5rQo62Y6uG4aQym5TLE1sNWG3k5BOzXK+YQzl
         oyxyn2KBV1q3A==
Date:   Tue, 28 Nov 2023 14:41:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/5] Add support for framer infrastructure and PEF2256
 framer
Message-ID: <511c83d1-d77f-4ac0-927e-91070787bc34@sirena.org.uk>
References: <20231128132534.258459-1-herve.codina@bootlin.com>
 <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk>
 <CACRpkda5VMuXccwSBd-DBkM4W7A1E+UfZwBxWqtqxZzKjrqY4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S3M3tGRsMZ5+00g1"
Content-Disposition: inline
In-Reply-To: <CACRpkda5VMuXccwSBd-DBkM4W7A1E+UfZwBxWqtqxZzKjrqY4A@mail.gmail.com>
X-Cookie: Must be over 21.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S3M3tGRsMZ5+00g1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 03:26:56PM +0100, Linus Walleij wrote:
> On Tue, Nov 28, 2023 at 3:03=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > If this gets applied it'd be good to get a signed tag based off Linus'
> > tree so things that depend on it can be pulled into other trees (eg, the
> > ASoC mapping for the framer).

> Do you mean my pin control tree or the big penguins tree? :D
> (I'm guessing mine.)

I actually meant mainline there.

> I thought this thing would be merged primarily into the networking
> tree, and I don't know if they do signed tags, I usually create an
> immutable branch but that should work just as fine I guess.

Right, I'd expect a signed tag on the immutable branch - it's generally
helpful to avoid confusion about the branch actually being immutable.

--S3M3tGRsMZ5+00g1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVl/AMACgkQJNaLcl1U
h9C9eQf/R1llySAg9H/iM2wmZyiHeAxLfrwmt4OWBoTpGBRwWcNPKExSnleKXm5l
czCL9LeGlT5a11xDPjoV4DRh3ehaYuj1FN3Pq5JS0VoG0c9orw1oqLQuU7RJlGqd
ajTjDRie+pJ+pOEVsLF3pS+h8KwbPhaoJEorU1acAZTXrsYlAQKJNQTcTzYg8KAi
9LSrm+69xcNmsvM2zIFXzDsbYnzDiwqdT3VPYyqtUA7JAlkFpqk8cCO//b3fhdmo
hG0x321MSxK4T7K2v5FVRISIznHqZjCLnyE1kknSYR3T8ki84tMtMFf3GgOr7Nyp
bN2bP8drVCn3NNx1eU+MPKhNrKMfLA==
=mwLw
-----END PGP SIGNATURE-----

--S3M3tGRsMZ5+00g1--
