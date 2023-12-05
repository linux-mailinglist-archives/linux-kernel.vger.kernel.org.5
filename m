Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDDF805C51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346440AbjLEP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjLEP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:57:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD10ABA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:57:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137CC433C8;
        Tue,  5 Dec 2023 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701791855;
        bh=WgrVkII6Qt1b4rQxQZ7m71wjsB2HLj5ZsjzJ5yzkPuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTvBMMg8ecKR5ZF561HEQW/VK65TRDd+a3xGYtju8FHcPe/8cMjHfKM4OYNqz0D6b
         Kc6XI+UgRd7zeyhKPc44yEmAQ7pPxwcrN205q2PRXktR4G1UvJ7oTnMHPl8XGrkvTq
         h3LkYTQCyhwvz4Irb5h8AQCASxcBuUMWz6uSTmQaI39tib7uHCjh8t9dBPxoRSPWAD
         b0rYqcM7H7Dr/d2HTR/hxHRrIxMW5PVlwb9w1ldpp51LQZ0yCoVSVZAkQWc+ahrXCa
         TiXcJWlE/lYDH5/hgVpNZoK68XayvsJfW4zu4BCZse2Laqoep+CofdUzChw4V6CfCr
         XiF1idyVJKOFA==
Date:   Tue, 5 Dec 2023 15:57:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <20231204225956.GG981228@pengutronix.de>
 <20231205064527.GJ981228@pengutronix.de>
 <4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
 <20231205140203.GK981228@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1jzDBs4dDTXFfKTt"
Content-Disposition: inline
In-Reply-To: <20231205140203.GK981228@pengutronix.de>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1jzDBs4dDTXFfKTt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 03:02:03PM +0100, Oleksij Rempel wrote:
> On Tue, Dec 05, 2023 at 12:55:18PM +0000, Mark Brown wrote:
> > On Tue, Dec 05, 2023 at 07:45:27AM +0100, Oleksij Rempel wrote:

> > > CC regulator devs here too.

> > Again, I'm not sure what if any question there is?

> PSE is kind of PMIC for Ethernet ports. I assume, it is good to let you
> know at least about existence drivers.

OK...  I mean, if they're not using the regulator framework I'm not sure
it has much impact - there are plenty of internal regulators in devices
already so it wouldn't be *too* unusual other than the fact that AFAICT
this is somewhat split between devices within the subsystem?  Neither of
the messages was super clear.

--1jzDBs4dDTXFfKTt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvSGcACgkQJNaLcl1U
h9CZ9wf9HEE6iEOCJJpkzG8SBnMctFeBTnq/N662MsvQUGH/qkPPK4oVmr897esm
HvW9VOSP95JsOrrQrjMEPwm8n4ZDJARuPmCJbh8uHnC3IQAzNYcxKdalN57NAZh+
1rWfnT6i9rXV68+HB+UQPxhmdYxVAD4u7TfnY9O63FbgZgi8KocKSq61mECuIDf+
8b51YRkK6SLebysFki+gFZU+e2dCjit9nt1c3o4CBERlAxhghRl2WrJD/HCaUwPC
TiAsMFSalALFK1mzNjHp/7PW3HGYrhAU1R1EYgjy7FS4+x52of9utSuDoBrNTB60
YiUS3lNVeG6kJiVJ5Ffw8B9JZOK1HQ==
=0JPO
-----END PGP SIGNATURE-----

--1jzDBs4dDTXFfKTt--
