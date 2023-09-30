Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B97B435E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjI3Tpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3Tpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 15:45:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D22B3;
        Sat, 30 Sep 2023 12:45:46 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DD606607258;
        Sat, 30 Sep 2023 20:45:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696103144;
        bh=Q+1jxZysTPtWBx/WufxCB1nhy7BZR+3ZnP/hTN5+Ins=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eaw2WmCr3JXGqV9sSO7jOow1L9iu+roPm3nuZAbYI/9n3H7tVMiFcBvHtWiN4Y0BI
         Eoz2r6zzMK/g1uPgzv1AcADVtP1ak+oz2GP+U+Za3Us5vGTTDOK10LkKrW+aU+Uoq+
         3tF1dFOd9t5dIduSAb256Yv8ejiyLiReAjRqwoP2GA0OJN/ROuaGgEH0VXcjvT2LCr
         P3XTPeBogBWberaelp34yxlfWwpSkb/qJVPfRUhSpwytmbY5uljzLYkaMcmR24y6eZ
         8VahK++eELa00fa9fa080KY/YIanp/1aNCQrhGiuz+D9EdNTBKZ1CGzvQZcJ9HZfdV
         uJU9tRYyLKypg==
Received: by mercury (Postfix, from userid 1000)
        id 3716D10603F9; Sat, 30 Sep 2023 21:45:40 +0200 (CEST)
Date:   Sat, 30 Sep 2023 21:45:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/5] power: supply: rt5033_charger: fix missing unlock
Message-ID: <20230930194540.szci6qlut5ecodpa@mercury.elektranox.org>
References: <cover.1695844349.git.jahau@rocketmail.com>
 <e437e728317b6a2a860f7812f64a98146a27965e.1695844349.git.jahau@rocketmail.com>
 <89351ef6-ab81-c679-4432-cc44de9a91f1@wanadoo.fr>
 <24162857-6863-d9eb-7fdf-e6c119e252d1@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i2mxvavpm3tig5z5"
Content-Disposition: inline
In-Reply-To: <24162857-6863-d9eb-7fdf-e6c119e252d1@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i2mxvavpm3tig5z5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 09:46:33PM +0200, Jakob Hauser wrote:
> On 28.09.23 07:23, Marion & Christophe JAILLET wrote:
> > Ok, but why not already in patch #1?
>=20
> Thanks for your hints about the missing "unlock"s. And sorry for causing =
you
> extra work by having the fix in a separate patch.
>=20
> The patch you refer to ("power: supply: rt5033_charger: Add cable detecti=
on
> and USB OTG supply") has its own history. It was already applied once,
> showed up in linux-next, caused some issues, was therefore removed again.=
 In
> the meantime, some fixes were provided by different contributors.

Since the commit has been dropped, please merge the fixes into the
patch. E.g. patch #1 does not make any sense on its own.

> This series actually tries to apply that patch again, accompanied by two
> fixes =E2=80=93 and two additional clean-up patches. I added the fixes pa=
tches
> as-is, also to credit the contributors.

You can use Co-developed-by tag for that.

> Possibly the cover sheet of the series was a bit too thin about that
> history.
>=20
> Kind regards,
> Jakob

Patches 4-5 look fine to me, but do not apply without 1-3. For 1-3 I
did not check them in detail. Please merge them first, since it's
quite hard to read in the current state.

Thanks,

-- Sebastian

--i2mxvavpm3tig5z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUYetoACgkQ2O7X88g7
+ppjzRAAqQYV7WWR3ahCHvFo8pWEWJ4xetIyHA9FUQ3UArpMJYI2/3WlrymChj97
caDn7XDA5wvt18FLVkZMmLW9mPGhxDBUcmJHFyrKfkkQYjtXCgdeKSUNWA9lKqZa
cRmPVLmAARAlB6nK5P22cTnIXBvpHSJvP5wA4BS3kt7CIeqbYqZBUSwTeB3GhJLJ
nu46CoAfYxIN0aZMqK2KJLjI4/qWltnnl1gegCtyI7/f+42ELQ+9OzdCCNVHJjdW
vRN07zFeuqoVt/9XS1mo9fkOsITIgAKmtFdeGrzv0jqRt00x/GfWsn1xH0i4JZnJ
ef5jO5DCyxVbDCjs50NcpdGuIn5ujIjFs/qY48uFIhfL6lI/NNpkr57hLwrAhCi2
BZSIQa0UU1DxEeszc3K4Alrhu4He+xU+xQB2Ieogr5IP/1wAaGgfWbnVlmXsj6IZ
mGNQPvtNWDEQOSD0zg9YirZEWi9ZsVNrIJkY8q8YUVsjR5aScqk7rKtZIp+eHxKx
0coHkta6vaqL8tuJZYdKwOazHckLO1Mhu9K2on3hkduRt1VYTCH17pv0rJB2rtT0
4RHnmvLmAIBqrlxw01wjkHYnqPmLLo5Xk1q0/0R5yGwKprCSSnOAxTD1NQcMpU1x
V+anAa1F74A/7qL77+SIrvDNS4oOtMWy0hCivsRRqdFS6N/O94U=
=tYmM
-----END PGP SIGNATURE-----

--i2mxvavpm3tig5z5--
