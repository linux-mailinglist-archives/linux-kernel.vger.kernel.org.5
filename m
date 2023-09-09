Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D58799809
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345668AbjIIMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjIIMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:37:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CD10DF;
        Sat,  9 Sep 2023 05:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BE3C433C8;
        Sat,  9 Sep 2023 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694263047;
        bh=qGZjDTBgBkzg/ggNLT5gnojZC24JKQmDu52+T7uLJug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmwX/oQEqUe5wXL1aO3V1NKYQ0A/ck4flFqaNEuakd4hntYqN+K0kgt+MsHZ/YZh0
         1l07NP0HQIkBMKPepR1lfhHoJlWGtKA8HFnBXSUJVvtfRWVec+Cna5PrnNmkFebvzR
         VxHWez0pt0z6g2oGMAb45G0A2ehJGjYDn1yPIZOKejXhNhHGo48KjnoDo3JZvZ58Gp
         q6/6bAPydt2gQHkcmX7LS2ly6vvOeZG17043B+KCX/40bJjEDNnqSVxqivz6u0lN1H
         mRIKuGbnPFWxmiuQ4C3hVlAPoK27GvgVCnbZNvfdZ9qoeHetNyhh3CWU0APeO+Nicc
         51SpTkwAgy03g==
Date:   Sat, 9 Sep 2023 13:37:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, anarsoul@gmail.com,
        tiny.windzz@gmail.com, rafael@kernel.org, wens@csie.org,
        samuel@sholland.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 6.5 6/6] thermal/drivers/sun8i: Free calibration
 nvmem after reading it
Message-ID: <ZPxm/xjvsI24JWkB@finisterre.sirena.org.uk>
References: <20230909011254.3581788-1-sashal@kernel.org>
 <20230909011254.3581788-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7PlWSsds2SMqCNWn"
Content-Disposition: inline
In-Reply-To: <20230909011254.3581788-6-sashal@kernel.org>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7PlWSsds2SMqCNWn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 09:12:54PM -0400, Sasha Levin wrote:
> From: Mark Brown <broonie@kernel.org>
>=20
> [ Upstream commit c51592a95f360aabf2b8a5691c550e1749dc41eb ]
>=20
> The sun8i thermal driver reads calibration data via the nvmem API at
> startup, updating the device configuration and not referencing the data
> again.  Rather than explicitly freeing the nvmem data the driver relies
> on devm_ to release it, even though the data is never referenced again.
> The allocation is still tracked so it's not leaked but this is notable
> when looking at the code and is a little wasteful so let's instead
> explicitly free the nvmem after we're done with it.

This is a minor cleanup which as with so much of what's come in today's
backports seems very questionable for stable.

--7PlWSsds2SMqCNWn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT8ZvwACgkQJNaLcl1U
h9DO1wf6AregOqyWwrojgKItcPaiepe27owCB09CFviVb1yo/L6fFLAgzvLxfsjq
odUxAh2b6MBpXM8FS4OsKpMu13Q74S9OIKDJSsYSc2tJGMRnGE7tWObGzBpk1LOV
F9xDN1HQkNEVHONjAcbPptTXnn8Uir0HlcOWOS4X3+ESbR+B+QYlQBjTvDBrXt0K
XM7Ivd/dsbOoJGs225VpG36d2m9NSVWvgrGw6LqMW7JeBibw4MFgb885JQqZDfrZ
lVvEW6tcG2GJr9RgXN6h0nuKVoHNXqw/vJ/TigQtDLwWq5yU7lkBTT7O6aT0Y8b/
8Jlx7VlX6PCSrW++oD8oR4zeVvbMgA==
=iFpi
-----END PGP SIGNATURE-----

--7PlWSsds2SMqCNWn--
