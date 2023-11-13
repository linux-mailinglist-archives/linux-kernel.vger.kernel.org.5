Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD30D7EA416
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjKMT4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjKMT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:56:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A73D79
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:56:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3FDC433CC;
        Mon, 13 Nov 2023 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699905393;
        bh=yde/qdKugx9gQf/W91aBCIWHKPf5bm58iOD5mdDW9jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdbpDHeL4g1o9FyOoaYTb3BZIYNDcg5nSiUUvC+LV06VKppvMnmwks4AUGHh8eIes
         UPnuhsYTzMviG3bTOQNgwFtn+Wey2zwMUAjYmnpIlt6J9w8F8XNcKAT6y2VWmouqGv
         ePL05IIjMJanvMFL8jEFS85GkvBnEbtnCnpw9oY0tb665JQ02U+4xaX0whU3yYkn0b
         1q2tZC/KjlhPUq9oS4in2LkdJrJ4X9JGMvLqvSDnYxm+X+ymS4gSann2acbQxhl3gP
         cKBBIHNneNt2QUCB2HVMRhEGHenRkLUg8+Xzln30r1VbwRBr4+UhwT9/PDVSeUZ+6e
         0BQPg+5BKIWKg==
Date:   Mon, 13 Nov 2023 19:56:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
Message-ID: <31772cdd-24e4-432f-b8ef-7ecf9c9861ad@sirena.org.uk>
References: <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk>
 <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
 <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk>
 <CABqG17h0OnMD-L1vYkJobji+Z=QPuYrd=ra1d7DncAN0_TO23A@mail.gmail.com>
 <f5829ebc-b3ab-409b-9271-e066c08aec6e@sirena.org.uk>
 <CABqG17iBsEO-NnRvgFJ9e5PvT7q+HgLyiDDfO5GcvXh4ueySsA@mail.gmail.com>
 <ZUzDBCaqR9Ui4j71@finisterre.sirena.org.uk>
 <CABqG17gc40_z4FWSwnqUwnXGKZzGAHs6zD7br03chcT_+bGWLw@mail.gmail.com>
 <CABqG17gXKGSSqjxYKomJKnYAZ6Q3P7+OXMo3=HD=QySuaqU=4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUMRaE+c2LDJt9oa"
Content-Disposition: inline
In-Reply-To: <CABqG17gXKGSSqjxYKomJKnYAZ6Q3P7+OXMo3=HD=QySuaqU=4Q@mail.gmail.com>
X-Cookie: Orders subject to approval.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUMRaE+c2LDJt9oa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 09, 2023 at 08:51:40PM +0530, Naresh Solanki wrote:
> On Thu, 9 Nov 2023 at 20:41, Naresh Solanki

> > May be in that case should we consider adding a kernel parameter or
> > some property in sysfs attribute to allow getting events ?

> Or may be even Kconfig option ?

It's not great but a sysfs attribute *might* work, possibly sysfs files
per event like for tracing.  However it really does feel like a fit for
netlink - is there an issue you see with using that?

--SUMRaE+c2LDJt9oa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVSf2wACgkQJNaLcl1U
h9AW3Qf/fboi+Er/Hv/eNnmzWMmlR7HN75HmWUpLN7jjPdaGVq1NpK0v1na+o1d9
ujIHqM9fbDcLVOtyWcJaMWWY2Plc0+uO6Id027BEwWK42S0DdQL+HhHasWLU1g2c
XHb2lsUZ/0w6tPdrgqQBZ8g3Pxr2zzJ2Y8fHtmAHTX0nmZ4EnrgTifBZ5rIW0ujn
nLxVbX/ZE0LnwazGOFA58b3M7pPdFp+UCj15jtz7WEsIdvMjKnns53yRTuih3Kjs
smC0uDF9zz0EJktQDH3i9XQlxi7OD9L9qAp+qgpnQijdRokirT0mOIXcg/kYdesp
HakSE7za4M5Wvh0cAAkSm/m2jAb43A==
=dTPB
-----END PGP SIGNATURE-----

--SUMRaE+c2LDJt9oa--
