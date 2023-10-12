Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0C7C6BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378175AbjJLLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjJLLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:14:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633DA90;
        Thu, 12 Oct 2023 04:14:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435CAC433C8;
        Thu, 12 Oct 2023 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697109243;
        bh=sIXVGxC92IW43eCqb+Te4zLMtmp1Zaw6/BPv7tZn5dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mi+IKRHUxEP41a8bN16IMH2f7Xabr6BsAfA1Cg4FfDHWKam87nQOHUbzsrH7Zm0HJ
         U9ARbb1Zn3ndMt8dGap4C5tu4+gYMwTGnSF3YaiWAEg80qYrzIEbvZAacRp2NUm7kZ
         CoDjj+a/WRwUYxe2+FscRQ6GzgUHAy1gf5P9eKHOik0RqYQog3tBoE9FdYbiY/5xoS
         01bsBrVNwF3m2tjrxvlqqNu/Cy7pU4ttBA6ghyfUqQB+MXt658T3aCXHaRya+5tIHT
         t5cTl8s0MIo7KBydn5cP87PCWXtg7M6K9390Xkhb63MdP5OT8HTX8VyrPRgD6M83Fm
         vhx2Vd8hF4HtA==
Date:   Thu, 12 Oct 2023 12:13:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        zev@bewilderbeest.net, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] regulator: fixed: forward under-voltage events
Message-ID: <77de152a-c637-40a2-846f-e79f52ddbee1@sirena.org.uk>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
 <20231010085906.3440452-3-o.rempel@pengutronix.de>
 <5e51792a-cc93-4364-a51b-c2b116d89369@sirena.org.uk>
 <20231010125531.GA3268051@pengutronix.de>
 <c2ee404d-d07f-42c6-b5ba-41659773e8eb@sirena.org.uk>
 <20231011075931.GA3305420@pengutronix.de>
 <2d14fd22-c37b-4c15-a2ea-a2fd2c201adb@sirena.org.uk>
 <ZSebeJKa0sEzNzP4@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yPgIy+98SeAibYLd"
Content-Disposition: inline
In-Reply-To: <ZSebeJKa0sEzNzP4@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
X-Cookie: I just had a NOSE JOB!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yPgIy+98SeAibYLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 12, 2023 at 10:08:40AM +0300, Matti Vaittinen wrote:

> In my eyes the device-tree is correct place for this information
> because whether an "anomaly" in regulator output compromises the system
> is a property of hardware.

Yes, it's mainly the handling that has a policy element.

--yPgIy+98SeAibYLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUn1PQACgkQJNaLcl1U
h9CZowf/fAd9uF9zNJtl9V+wuJJIrq5Qh/d0B1IVIv+A5dDA1BCZop8AeeMb9yWM
bahyii/LZyHKqo8x9mY57z4l7+Ucjx9KBDppvIg0E2ZwD8NpiXJ24OCC35GScUZ9
ymQCZp7SuCzui/+6O5E9Om3PeZ54yZ/tZ1RiGIKUkWk/HVAKNn5UD2mR7qeI77cF
ulE72VpQeg1SIhKkNEM1ZbElyuv2nCp/hCnYPbN0X4HDv8C/mO/+IGoLln0Trg8A
qq3nX5IeUKa9cg0zrw0SlQXIKydsO6cqW48YM1Q9THc2xqnXceA0u2rQes6fz4fh
yMP2qT0khgiWyqXr8Pl7W8LFW4w84w==
=9kBd
-----END PGP SIGNATURE-----

--yPgIy+98SeAibYLd--
