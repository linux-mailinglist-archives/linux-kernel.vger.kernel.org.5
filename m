Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC87F778D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbjKXPVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbjKXPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:21:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2622C1723
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:21:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EE6C433C9;
        Fri, 24 Nov 2023 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700839307;
        bh=SaOIsxsJcmKcTPVRIWwhizQdS7FaIYV1Cugn/gxXAro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQPWWZJnxbOeBekGLTi6XkWlQf/vCdwXpsr03ltrCLXAKMVrn2r0AkcMbz9s4CCZS
         6fdKiVeIR2/UlEOwl3A2yVyE7EP7tg292eho3jTZ1YSc9MW0tsdsuuVr/QP6d8WhlO
         YW8i6u6IIVQKUEwo/bECsYwWY0rcoChoc+QwpgRDOn72hrWhlrg04Xd9LpiRZ88JXs
         +pS32sUxIPGiEE68DvLrQYvytvaqmzzSqHj0okn3qvMokjXZw0ncvHo6Gma8CLy/JF
         W2XmeALe5oPkb+uXLYhbyZvJLt3EyVriKsxUJYmxysqGJg9bLpJR8G6kukeEkB2YQI
         ONDflUYGxaUMA==
Date:   Fri, 24 Nov 2023 15:21:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9TNEDLTCLPD8iDwO"
Content-Disposition: inline
In-Reply-To: <2023112403-laxative-lustiness-6a7f@gregkh>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9TNEDLTCLPD8iDwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 03:05:47PM +0000, Greg Kroah-Hartman wrote:

> Anyway, this is ripe for problems and issues in the long-run, what is so
> special about this hardware that it can not just shutdown in the
> existing order that it has to be "first" over everyone else?  What
> exactly does this prevent and what devices are requiring this?

> And most importantly, what has changed in the past 20+ years to
> suddenly require this new functionality and how does any other operating
> system handle it?

This came out of some discussions about trying to handle emergency power
failure notifications.

--9TNEDLTCLPD8iDwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVgv4QACgkQJNaLcl1U
h9C+ywf/QUDyaKfqEG5Uhu4wENzwHqAeD17M6852+Re27F2yC/ZnL+bnN+mqpj5R
y6FvYWyi2erYzViooNf0QplHyjOiNIjR/K5/HaffGN0/YxGcIMuvfCLmn9kK2LcM
Yav14SFDXohSvc6I1VKqEQLIJSL7YhS01SXUWdWNQQKcwQ2gHbYFQj1Rok0a1YCY
OmHkvGDRYJE03Cyli5pRD7kljZqLKlcGNv0WypxNqwrydW4c0ZbteN8pXA93JYi1
zznNzh0Z8RgqpBfH3JV7xbPjgaD0+N4Niej7F/UQugSTKPLx+zjzkEaZ8TM4ndPX
6KxNw7s+dLJcwXcfgV3s5m/KTq8Dvw==
=tn5a
-----END PGP SIGNATURE-----

--9TNEDLTCLPD8iDwO--
