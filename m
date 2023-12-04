Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A34804284
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjLDXX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjLDXX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:23:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF89C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:24:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DD2C433C7;
        Mon,  4 Dec 2023 23:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701732244;
        bh=00lqH4j1UzlBvWvJNj4m5IeDRSTUYgZU4c1EBZQgD2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IASzSSK5SBGPpMOy/kpqpWxPSxSc9gvR7iE5kDMLNeQCiFrgMcoYChRFHo3y9fHo2
         V62xBDHIxbR9BrR4Tqw0uUdYhZscW6/eBqCQheHGdRmlpVsH11EoYwtG1yAUrlZMeg
         Ula9NHjEmsZ3W6vcDUVPb13aNE/Zn7C3YbPZxvIthMbO1livNTuIILhNwWvPq445fe
         e3lEUbek6P5XPY4T8L9oFyzXUgr6GPDyAKmCwhPoQZLRJu8gULvCwSwqiAUQ2gHpB/
         ybd30DptJ4hnpEqXGvRJlcTK3eDgXDiBDa2he0bDbrvT6clk+X7NXJ23glVTeQvo72
         Op6wuhpRd+5YA==
Date:   Mon, 4 Dec 2023 23:23:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regulator: event: Add regulator netlink event support
Message-ID: <e0953578-1c61-4461-af07-8cf1e3d1837e@sirena.org.uk>
References: <20231128140718.3866978-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dLDDRDLeT7WFwlB+"
Content-Disposition: inline
In-Reply-To: <20231128140718.3866978-1-naresh.solanki@9elements.com>
X-Cookie: Sorry, no fortune this time.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dLDDRDLeT7WFwlB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:07:16PM +0000, Naresh Solanki wrote:
> This commit introduces netlink event support to the regulator subsystem.
>=20
> Changes:
> - Introduce event.c and regnl.h for netlink event handling.
> - Implement reg_generate_netlink_event to broadcast regulator events.
> - Update Makefile to include the new event.c file.

This looks good however it breaks an allmodconfig build:

   ERROR: modpost: missing MODULE_LICENSE() in drivers/regulator/event.o

> +config REGULATOR_NETLINK_EVENTS
> +	tristate "Enable support for receiving regulator events via netlink"
> +	depends on NET

I think this needs to be a bool (NET is a bool so there's no dependency
issues there hopefully).

Thanks for pushing this forwards.

--dLDDRDLeT7WFwlB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVuX44ACgkQJNaLcl1U
h9CDJQf8Dyd3T94FTchgvNZ6rHiwsm65xU3CDUg44uYXtizU6F9FmkgKDRUSLl66
R+Xo0FKTcgx6ktQ6GQreSAp6VGLfcySeBdaN/O73oDxbEaYW+h/pjwYe6GYJT02c
Fcwuj1tjS760B2IgCSOsecs3S/eH3J5x5oBEudrpgGZob6/ky61jyefJwWHwzJ6u
2zjnUO4UD112mpI6EW3z1GJxXHM/qPzGgeafAORvOGVKO9H9sMe4LXjy4gs7qQDZ
ns2Xx1oUkdLzf0UGVoX9I9+3BCx8r0PNvEJ+nmUKsZUlcMZiHp6FhR8NM1xj0p5b
vLcmV9k/IcIcJIfYkFregux2wJAtTQ==
=hx94
-----END PGP SIGNATURE-----

--dLDDRDLeT7WFwlB+--
