Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB337FA253
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjK0ORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjK0OR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:17:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58BC131
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:09:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4281C433CC;
        Mon, 27 Nov 2023 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701094176;
        bh=Rzm1pffWSXspIZnYman5Fq3ZA6DmRbWYR/wrDSYJOAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B48zSKFvCfDTu1F6pwsZ2SDK5DH8Cd9q7yYg1pMzuqVQ9ycLZ/kL5GunnlGuWLvZg
         LkLwo6oEmtk8t+hImaDCKhVzLLttkkQjD5tYCGJsAxSu2Gtk1DXlKrioF09SdTc+Jx
         rlcRGYrBPtFa8M4iRVu1223CXUj4Qd7vj6mckhQSuRiKjpt+hDD6FLEanWigKEPA2H
         p9YSSW6pe471F28DrI1iYQhrOYdvAlpRsqJKmJxCKc/JMhFgKnWItIf8KPYjmqVYe/
         Cocqlv3gx+14BMCGx2b/pSPAY+piCErvLWUd7haF/kgPP8FLc/dUdEmCjf6aS/EjrN
         S94trnx9DxVog==
Date:   Mon, 27 Nov 2023 14:09:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWSjHdupI4KT/w4A@finisterre.sirena.org.uk>
References: <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
 <2023112541-uptown-tripping-05f3@gregkh>
 <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>
 <2023112504-cathedral-pulmonary-83ce@gregkh>
 <ZWMaMIGUo9DeyEH+@finisterre.sirena.org.uk>
 <56823ff4-69fa-4c92-8912-51fbfd71403a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WNnJnhr0Ry+xKVz2"
Content-Disposition: inline
In-Reply-To: <56823ff4-69fa-4c92-8912-51fbfd71403a@gmail.com>
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


--WNnJnhr0Ry+xKVz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 26, 2023 at 08:42:02PM +0100, Ferry Toth wrote:

> Funny discussion. As a hardware engineer (with no experience in automotive,
> but actual experience in industrial applications and debugging issues
> arising from bad shutdowns) let me add my 5ct at the end.

I suspect there's also a space here beyond systems that were designed
with these failure modes in mind where people run into issues once they
have the hardware and are trying to improve what they can after the fact.

> Now, we do need to keep in mind that storing J in a supercap, executing a
> CPU at GHz, storing GB data do not come free. So, after making sure things
> shutdown in time, it often pays off to shorten that deadline, and indeed
> make it faster.

Indeed.

--WNnJnhr0Ry+xKVz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVkoxwACgkQJNaLcl1U
h9Bcygf+L5hzSTavWgidr0hhi4465zqbw6YHoR2jz/DNlD7AC58rPR5FEWs0ruwB
dYLUl6i9VzuNAc9R7DXPwA1hlzqOMJSVLZdNKR8FN6oqaCQfkGAb2WEp8B+CVVhh
SUq1PlZIbWA47Rgj42qjHd7etTeUrNiLH90R1mnon4PiJCQbbba0trpOO1Mf/IbP
uQY0PMswnm+Vdq2FuNrDHjAmMYPn+5fpsfk60E9OZxONpxX8ElNZQ9bnluWbA0a2
rDafPPNO2BBrIiJqRNrsmsZjQ7nCwUpcqih7JLsmAG/RKoDG9b0GmgD+vOsRBCus
z2mNJo7Q5npN3R0aK/oDnOl/g/ymCw==
=1hbz
-----END PGP SIGNATURE-----

--WNnJnhr0Ry+xKVz2--
