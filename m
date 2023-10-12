Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB617C750C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379631AbjJLRsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjJLRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:48:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED3BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:48:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E443C433C8;
        Thu, 12 Oct 2023 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697132883;
        bh=yr0ufzcsvfQuq22v+BYliMzM5MSunWwcpKeu5yTB69g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hA1q19eAy1gEyZ6xG5SJUtcFbMouZpLuMPKo3+X7g4rWg/iJAXQtQNfjh/SILG0SH
         fxqq2R6nbnb1au1QJ+lv1ffuiU9xr4ilZTUBUzr1QeA3X7ya9HXUKqWHAaliWgJpv3
         JFURdHj/OBeidz/YHswc2cVUlhkSvhENWFkFK+WDCN2NynEVoJ0THSajxaQ8AIV02b
         Xt+IfeeWh3JDfGXyGVdwhkF8B49cNz8zbhcYfnC2vMfSK9PDMpf35EUL4UUrFBXzp/
         FrF5B3UeLLeLIPUHWG+4/X/X09GA6xNaMbE84TMGJ7hQ3mICf25ZPBaf6f65ecRg8H
         yqXziV3ypPgLQ==
Date:   Thu, 12 Oct 2023 18:47:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ninad Palsule <ninad@linux.ibm.com>
Cc:     joel@jms.id.au, eajames@linux.ibm.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, lakshmiy@us.ibm.com
Subject: Re: [PATCH v1] regulator: core: Convert warning to debug print
Message-ID: <aa596890-d98a-41c2-bc10-8c1db58ea23a@sirena.org.uk>
References: <20231012174235.2424670-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oBIgRrYKyWds8CAc"
Content-Disposition: inline
In-Reply-To: <20231012174235.2424670-1-ninad@linux.ibm.com>
X-Cookie: I just had a NOSE JOB!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oBIgRrYKyWds8CAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 12, 2023 at 12:42:35PM -0500, Ninad Palsule wrote:
> There are some boards without the vcc regulators for eeprom or other
> devices. In such cases, we should not see the following warning and
> this confuses the user. We want to see this only when it is compiled
> with CONFIG_REGULATOR_DEBUG option.

> [0.747347] at24 6-0055: supply vcc not found, using dummy regulator
> [0.752877] pca953x 6-0074: supply vcc not found, using dummy regulator

This is a warning saying that the firmware description for the system is
incomplete in case things go wrong later - it is vanishingly unlikely
that these devices actually do not require supplies, we'd probably have
heard about it if they did.  If a supply is not described properly we
may for example decide to power off what we think is an unused supply
with bad results.

--oBIgRrYKyWds8CAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUoMU0ACgkQJNaLcl1U
h9AI9gf+OP0IcasU4upwQcgYM20y9OLsJGoGTRcfSReAosYxV6nhpz0M9qlQpP1d
yba03jso6X76yza4xTK4unPOf5y3Wfmwzc8bkXa/kkrZ0KA31RIZyom9yJkIQ7YY
M092C0L8ErgqFIP9kzL27IgghkVCJEBm/ZYsE1JcZaUOs277mTVmdAn7Yi5BVKT/
SvIVZ7VaS3o0722dVdlSBtIWhv1VXzZ3k0Z+q1uh+Uuorhx87tmjXMAEMn0d0K84
g1BszjOkBnUUL3WmkpVrFZrCuUcBHUNdW0FSoH1+/wCL2T9aP8CL5d3WzwBWO2WF
/CmHxRD/h1fSfrzngMimx8MIJw7aaw==
=9PiJ
-----END PGP SIGNATURE-----

--oBIgRrYKyWds8CAc--
