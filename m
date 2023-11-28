Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D777FC292
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbjK1ODi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345354AbjK1ODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:03:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEEFB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:03:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A82FC433C7;
        Tue, 28 Nov 2023 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701180223;
        bh=OCL77S9JES4lmUWGIM9GXQQEsjN7sL0ioEmMb189EjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UH/R7vhqGfBAfqpe60Y+KSqEINntkJP9Y3sPyeGVRcc5o8H7H22C6Cz+3z1ZJ6L+w
         RhI0R7noiCcm8RvHypeDlTU/bpABIX5699OxIt+2XKOIkWlwCZTWBJNkNjg72Bdik6
         o0j6CWZPLXFPAyoEwHfX9LnUvcu+sx0AK0eimbStKpQ7FFYHYkCKfH0NO19O9mWvVC
         9vPys5Ci/ACgsgSeKoNRRRtwTCdxrPMcpexp5uHFKQj7pZhrQt6E6PlsGEgN8NOMM2
         tPpSgjuhw7leyzl7LuGftjk76kROsmfI6vezFxs+CMQzjco3rHuuTxPHE7H8FKqTAV
         LZERXHUVnM3Hg==
Date:   Tue, 28 Nov 2023 14:03:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/5] Add support for framer infrastructure and PEF2256
 framer
Message-ID: <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk>
References: <20231128132534.258459-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5GNgz2yB04HlQ9Au"
Content-Disposition: inline
In-Reply-To: <20231128132534.258459-1-herve.codina@bootlin.com>
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


--5GNgz2yB04HlQ9Au
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:25:29PM +0100, Herve Codina wrote:
> Hi,
>=20
> This series introduces the framer infrastructure and adds the PEF2256
> framer provider.
>=20
> Patches were previously sent as part of a full feature series and were
> previously reviewed in that context:
> "Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]
>=20
> In order to ease the merge, the full feature series has been split and
> this series contains patches related to the framer part (infrastructure
> and provider).
>  - Introduce framer infrastructure (patch 1)
>  - Add PEF2256 framer provider (patches 2, 3, 4, 5)

If this gets applied it'd be good to get a signed tag based off Linus'
tree so things that depend on it can be pulled into other trees (eg, the
ASoC mapping for the framer).

--5GNgz2yB04HlQ9Au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVl8zcACgkQJNaLcl1U
h9B45wf8DqQLaggJbtU8xpDv+NJztPbUyIMo8nXzPFMLhFKjaj1cw3fhy1SemD1l
ZhOA1pnDjsPfIREeU5NDZDSq5shqSQQzhrKwG6hGCnU6JyHJCtr7n/kENLG5ajLt
KQhIGNm4mO/YPjtfxeJenMULKyV5vIHJiNjycJCvGs9kNLDvRerlloKSt+5KCY2u
bGLxTV87+HuV1XNMaOmzSWcnvaaox+EGPo0/rGmXtyfF8R22E4Q5Cic2PvxBGYB/
sYrpJCEizNpcygk1WhomNPH6o84uv2AdZxMiEdT6mFkQQBSe+uotm+Y9ASwWQpCi
UeUhfpwZV+4guwnxm/bwOIySx5Bgdg==
=Cmo+
-----END PGP SIGNATURE-----

--5GNgz2yB04HlQ9Au--
