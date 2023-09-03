Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01D790D39
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjICRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjICRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:20:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA57DD;
        Sun,  3 Sep 2023 10:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19EA60989;
        Sun,  3 Sep 2023 17:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D577C433C7;
        Sun,  3 Sep 2023 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693761605;
        bh=aFwMpJsQOtfOL4BviOw5xCCDbKtqj3RKzP4zm1qzzww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICDsKd4G5cqHnlOigs98nwbL5wtjO/l4Y0bVE9OKxqEEiq9A3krBVGi4JsHlsgz/o
         S2UmHucnoJK+OGKOVmTALNxjzXttVIZqxC703cCSTOMCkjP+Yxabq57pNzbc7Mu0Je
         095ma0pWb3F52eUQa0lhWyrCAp9bOgSshem7vtLiEXccjKpqJmhsw63Sea0q/mnicG
         qKvSEwKay6XKQ4bD9oHBrBMQOmeMJrPjVeGSV3JQcEtC9qFbkXsd+eojM1N1I3RYK4
         M25SqVRsZ/V1L0HwzFO/CBE01yPEmjZRZgALStEyGPPL4jxg/oibTioDbCX9dlhPRZ
         H4nQGkf0JZbgw==
Date:   Sun, 3 Sep 2023 18:20:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rajeshwar Shinde <coolrrsh@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that
 can never be negative
Message-ID: <ZPTAQWZ0XoL9zfW7@finisterre.sirena.org.uk>
References: <20230813141207.150336-1-coolrrsh@gmail.com>
 <CA+VNjV1=xVyRkvB6RAnLySAOzS=X1XiJihrtiMx3Jmifpdq9ng@mail.gmail.com>
 <df10d700-3f3f-4665-9197-534abc24523a@sirena.org.uk>
 <CA+VNjV1K6WoKPqP4zrax5SOF3UFCiJ5oYA=YamjZwfZ5fkEHWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k3VdGoWfWwkGY0zV"
Content-Disposition: inline
In-Reply-To: <CA+VNjV1K6WoKPqP4zrax5SOF3UFCiJ5oYA=YamjZwfZ5fkEHWg@mail.gmail.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k3VdGoWfWwkGY0zV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 03, 2023 at 08:12:25PM +0530, Rajeshwar Shinde wrote:

> Remainder

Please read the mail you are replying to...

> On Wed, 16 Aug, 2023, 5:02 pm Mark Brown, <broonie@kernel.org> wrote:
>=20
> > On Wed, Aug 16, 2023 at 11:38:48AM +0530, Rajeshwar Shinde wrote:
> > > Please verify this patch.
> > > Thanks & Regards
> >
> > Please don't send content free pings and please allow a reasonable time
> > for review.  People get busy, go on holiday, attend conferences and so
> > on so unless there is some reason for urgency (like critical bug fixes)
> > please allow at least a couple of weeks for review.  If there have been
> > review comments then people may be waiting for those to be addressed.
> >
> > Sending content free pings adds to the mail volume (if they are seen at
> > all) which is often the problem and since they can't be reviewed
> > directly if something has gone wrong you'll have to resend the patches
> > anyway, so sending again is generally a better approach though there are
> > some other maintainers who like them - if in doubt look at how patches
> > for the subsystem are normally handled.
> >
> > Please don't top post, reply in line with needed context.  This allows
> > readers to readily follow the flow of conversation and understand what
> > you are talking about and also helps ensure that everything in the
> > discussion is being addressed.
> >

--k3VdGoWfWwkGY0zV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT0wDsACgkQJNaLcl1U
h9B4Vwf+IheQSKPrAkq0gdrld/T0ObUrjfSjw5ssj6fRSnZuNB1Vdc2/4AdeTS5e
68W6QjOJJBbHNBDNSuYtOxd3fYmykEQHcES3Lqb0xITDwT1Z9Ffnt5H2kAfqBo90
Kud+cyoenb2ftSqsIr6yMb3Wi+ZDHWSkrYgPabgRKaFJySP5qka1ZKGJ4X9zaQ5Y
Dkmk3o6U3BUk/iBiKHlCrNUrWqiKygHBAiLuUzAWotC27wQhJChcnfCcu44mbIoT
8y1yx7jzpULvu8G2lV2LiGVkqzrk+AYE4+LPx2oN9Iol8Gtuc6q88eTESGvgT48v
Ogto1KLtvTrBUT6blWzfDXbSfTFZRw==
=4v21
-----END PGP SIGNATURE-----

--k3VdGoWfWwkGY0zV--
