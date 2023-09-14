Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58397A02DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjINLmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjINLmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:42:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1938D1FC4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:42:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102EBC433C8;
        Thu, 14 Sep 2023 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694691736;
        bh=2uxrJxwYAB7KQpEcYwTSxbHEbSchGWMf1R2ISLP87Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BInpl9z9qTMufVz3uWoJichhjcN21keXh0QUv8oEyIcAAuY1iaRre/Cw/+fw4EggI
         JlugdkcCjOfTfmBx2m1JL8zyn0DI7iRJkplFpOhI7ekzpjsoZuiPzo7DuJtT6pwXup
         Y126sC25PEiW1+0BEasFAwi++PQKL/0QW50TMBKYtTTd4ar9paL02K8OYjSn7SjoxA
         Esaae7EjbfotcBGZPg2RzB9rxeSZvmHr4ZSOpkY04x4/xS5F2fFpiK3iYnCt85EcF+
         DBy50YYtquXGubPBRzGOEeRYTbgAgcK+D2g7DFq1w+bzDxCytB/gS1ySxPQWeK1Y4o
         orb6XFO5r8gLg==
Date:   Thu, 14 Sep 2023 12:42:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Myunguk Kim <mwkim@gaonchips.com>, alsa-devel@alsa-project.org,
        fido_max@inbox.ru, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, xingyu.wu@starfivetech.com
Subject: Re: [PATCH] [v2] ASoC: dwc: fix typo in comment
Message-ID: <5a74a371-c447-4fc6-abf1-08514de8fc00@sirena.org.uk>
References: <64683b6c-1e31-4037-a47d-b8a19ea77c72@sirena.org.uk>
 <20230914005633.2423696-1-mwkim@gaonchips.com>
 <20230914063248.rquitqthmddgm5oa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sJAlP+HmLks31y3M"
Content-Disposition: inline
In-Reply-To: <20230914063248.rquitqthmddgm5oa@pengutronix.de>
X-Cookie: Do clones have navels?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sJAlP+HmLks31y3M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 08:32:48AM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Sep 14, 2023 at 09:56:34AM +0900, Myunguk Kim wrote:
> > > The patch is obviously corrupted, the { there should be on the prior
> > > line and even fixing that by hand there appear to be some other issue=
s.

> > The patch file should have been attached as shown below.=20
> > Is there a problem with my git send-email?

> > +		/* Error Handling: RX */
> >  		if (isr[i] & ISR_RXFO)=20
> > { 			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=3D%d)\n", i);

> FTR: I get this mail directly (so no mailing list server involved), and
> the patch is mangled in the same way as broonie pointed out in his mail
> earlier in this thread.

Right, same here.  I don't know where the problem might be, it's not a
pattern I've seen before.

--sJAlP+HmLks31y3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUC8ZEACgkQJNaLcl1U
h9CjCQf/R7AX12nMWEuy7dcBdyq8lqjAH+lOvlwKwaNdkyTBfTTHfSot/QOLxRJn
SBHOAt/ojIWZU+voPcU6gunCJJAzaF7lKaSvm+s8of3RrcEdi3elvNjQfnKVYqNp
TK5d9rTfWIy9uwAh1qOTeq3wal5KzDFcUeqeshrh/RRG8Kgx8w9asECAcP9fblR1
qYgX3ZA86rjQdcDyyD+k8zhDgSDqh/mfO+62RnkWK43p/+ng1i1XcR2pQz00XGGW
3WhVWqmU3KrtDAW1jZHpecX8cbCgA+3btmYFqhSqOXtQXBgX5jLOHMVKv7c55x/S
gYikAxrevsOsfn/+ZlnEz4cNoKn2GQ==
=r6i2
-----END PGP SIGNATURE-----

--sJAlP+HmLks31y3M--
