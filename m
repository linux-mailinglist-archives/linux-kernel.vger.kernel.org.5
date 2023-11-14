Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430467EAD09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjKNJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjKNJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:31:27 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB43130;
        Tue, 14 Nov 2023 01:31:22 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A170A1C0050; Tue, 14 Nov 2023 10:31:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699954281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CODz8NstgmK92moXl+UOkCNSWzwauPKSWbUcbQNR6vc=;
        b=czasQl0YeQ5W+RSIiEMH8+ShxacJhxOxWAjh6P/5BRH6rK2eZU4z3Ko9aLSDCMlQIreHfL
        vhBaiZANOPqhbezEb/rKXFn4lTxMZo7Gd4RtCKj+eLOgIV5tBuwy+sFascrkKUf66y4ZDz
        fTZmcHV5xjCnffI/qz1h7FpaVYj1074=
Date:   Tue, 14 Nov 2023 10:31:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH AUTOSEL 6.6 09/11] drm/amd: Fix UBSAN
 array-index-out-of-bounds for Powerplay headers
Message-ID: <ZVM+af4bbB/Hx5Pd@duo.ucw.cz>
References: <20231112132736.175494-1-sashal@kernel.org>
 <20231112132736.175494-9-sashal@kernel.org>
 <CADnq5_OyK=rDH38Q8Kiyq9BhWuihgd8wX7XKAffxwkO4w+ksog@mail.gmail.com>
 <ZVEewK-GAnRsrPA3@sashalap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="paJBZC1F9+gCvnp8"
Content-Disposition: inline
In-Reply-To: <ZVEewK-GAnRsrPA3@sashalap>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--paJBZC1F9+gCvnp8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > From: Alex Deucher <alexander.deucher@amd.com>
> > >=20
> > > [ Upstream commit 49afe91370b86566857a3c2c39612cf098110885 ]
> > >=20
> > > For pptable structs that use flexible array sizes, use flexible array=
s.
> > >=20
> > > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
> > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >=20
> > I don't think any of these UBSAN flexible array changes are stable mate=
rial.
>=20
> I'll drop it, but in general we've been taking kasan/ubsan/kcsan/...
> annotation fixes since it enables (easier) testing on the LTS trees, and
> for example finding issues specific to those LTS trees.

I believe they should not be in stable, either.

In any case, Documentation/process/stable-kernel-rules.rst should be
updated, because it contradicts current practice.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--paJBZC1F9+gCvnp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZVM+aQAKCRAw5/Bqldv6
8mtwAKCOdMnLlfmoCA/L8EwU7sO7zQZxOACfbkjh4IwjOXNImQ69u5j7dz7e4Bs=
=B0dk
-----END PGP SIGNATURE-----

--paJBZC1F9+gCvnp8--
