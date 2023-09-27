Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7E7B07A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjI0PHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjI0PHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:07:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6CDF5;
        Wed, 27 Sep 2023 08:07:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B636DC433C9;
        Wed, 27 Sep 2023 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827221;
        bh=Ny/gCvfKBPdMKiIev+iUrhO5AMlDUJHmTAYehDxlXrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ls/nysvPG9FN8fMDGsrnQm9puuGbTJuhoX7VWW3ioIdtrUNtaMF2OoZ/hdqdD8sxF
         CaLww1i4BwTuj3I3XeeIPw44DRpE4DhwQFfig9qWO2IGXST9HHe3Lc17FDKX92urG4
         zRHn94gbnfus/6PEelHXExAhD5fpRe3a3cmmME5G7HGsXEXOuijI8aVdJKFGyPmBMg
         gx9pjBZ9z/24bTrXoBwUfWHHFCcoBF+ofHgYGy/dDNB12CDHEbFQ34puTlWNAScm5U
         R6EfMGyTCqwFjeOEI4afRAB1TioHcfk8qZn2p3EW/+nH0f6aZg9raVasKScV6Sl7XA
         h4g2EUPCv9QEQ==
Date:   Wed, 27 Sep 2023 17:06:58 +0200
From:   Mark Brown <broonie@kernel.org>
To:     charles.kearney@hpe.com
Cc:     verdun@hpe.com, nick.hawkins@hpe.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] spi: spi-gxp: BUG: Correct spi write return value
Message-ID: <ZRRFEqfpbzU5H2uV@finisterre.sirena.org.uk>
References: <20230920215339.4125856-1-charles.kearney@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0xpmS17rT4yr99XO"
Content-Disposition: inline
In-Reply-To: <20230920215339.4125856-1-charles.kearney@hpe.com>
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


--0xpmS17rT4yr99XO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 09:53:38PM +0000, charles.kearney@hpe.com wrote:
> From: Charles Kearney <charles.kearney@hpe.com>
>=20
> Bug fix to correct return value of gxp_spi_write function to zero.
> Completion of succesful operation should return zero.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--0xpmS17rT4yr99XO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUURREACgkQJNaLcl1U
h9DmpQf+LWYwI0HuTAnZrJCddZqRPiMyMZeNbiFZpyEEIJYkE77oNoZqH4JnB6Uo
S7mp5AxA9s0uoMdkcCtund85teKODnUVeTlnc4H1uoT9cbEBPQzVTqDUMwDMAsrS
hPViyW2Qf2a7hkVgFznbJ0pcCJ6wB9FVcXmtlBbS2EocE9adXhC05BzafIQVioIy
taMI1g5d1KE8OTmv3uhu9HLNB8+6iIfwRrkZJoDVWZMSuLUMZQm8C0IbBJaLHAV+
FxAzbsLQIjr4ORU6setDmquJQ39Y2ZsOiXfnRWSqaNBPejUEowLKToL/0LnpMMM0
xgGoxls/PUtRgSBnRSZkeDwm/DaUvg==
=h13j
-----END PGP SIGNATURE-----

--0xpmS17rT4yr99XO--
