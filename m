Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB28379BF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjIKUq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbjIKMve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:51:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1234E40;
        Mon, 11 Sep 2023 05:51:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D13C433C7;
        Mon, 11 Sep 2023 12:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694436689;
        bh=9DJeaj3B139313EIsW2RLAfPQHEz2WLHa8uXitypr/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAr1OVlxK3PK3lgFjYkEFyAMnXJtexo8o2qubI2+kyk/WaVpal4z6T51Lq/q07Vm9
         CRciu4DEBqykxIj29fOzrGP2ezcZCuL0qKaiUZM7XUWqWk4qZzwJVPzN99+zrpRhKZ
         GjIXkoec18XEpFUKlkkTgbPsyICHBj3I8ndB65TzJ5hz74Kk87RG8+CaBu49nnxomD
         g+UsNIahsB2TsRons4G5PefjXM5rWE2ERYPYOIiIQ72vf+YkKfKgv83y/h5VTpv/U5
         z7904mm8BI1xnahWWiMHvrYWRxBhpBTuPvgciMTeL7AW5r8utuyzilNz8rmbMgldQM
         LenC8lkXUuHaQ==
Date:   Mon, 11 Sep 2023 14:51:26 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc:     Daniel Stone <daniels@collabora.com>, emma@anholt.net,
        linux-doc@vger.kernel.org, vignesh.raman@collabora.com,
        dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        jbrunet@baylibre.com, robdclark@google.com, corbet@lwn.net,
        khilman@baylibre.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, linux-rockchip@lists.infradead.org,
        tzimmermann@suse.de, martin.blumenstingl@googlemail.com,
        robclark@freedesktop.org, Helen Koike <helen.koike@collabora.com>,
        anholt@google.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org,
        gustavo.padovan@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11] drm: Add initial ci/ subdirectory
Message-ID: <5ejq3hjpoy3gxft2jbmoa5m656usetuxcs7g3ezyyiitj67rav@r5jhdz27foat>
References: <zorvxwffshrsqx5cy76pe3gn52qrqav7qusz5acav2un2ydvwr@fwjd56qg2xve>
 <87bkeo23vs.fsf@intel.com>
 <4rpsqk4tgrdcxtxtfoum6o4oyglwkirmkh3jj4y5tays2ivb5p@uwqdf3snshkv>
 <25df6189-7b0a-b13d-e93d-c2a388fd45e3@collabora.com>
 <zmq7pz7rtz6h765azg5kl2qgjd264yafctx4q474t5tqai57og@cajbcub4yuwr>
 <5fdf9d29-3f8d-0ee0-027f-57ff3a5cecb8@collabora.com>
 <CAKMK7uGg6n322UugJwErqF_Dvsbqceqae6SVWV3ZWEOR7x36rQ@mail.gmail.com>
 <9a2b1ad8-4359-4f12-b4f9-c1de477bc440@collabora.com>
 <mnjcsiqjqdnvbbkaaz5r4n42e56qsax667r7radzyagnmmfkip@dfi64z5deqzj>
 <b7d96985-8489-efe2-db67-1f3108e26822@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ilbap4gkrsqltiz"
Content-Disposition: inline
In-Reply-To: <b7d96985-8489-efe2-db67-1f3108e26822@mailbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ilbap4gkrsqltiz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 02:13:43PM +0200, Michel D=E4nzer wrote:
> On 9/11/23 11:34, Maxime Ripard wrote:
> > On Thu, Sep 07, 2023 at 01:40:02PM +0200, Daniel Stone wrote:
> >> Yeah, this is what our experience with Mesa (in particular) has taught=
 us.
> >>
> >> Having 100% of the tests pass 100% of the time on 100% of the platform=
s is a
> >> great goal that everyone should aim for. But it will also never happen.
> >>
> >> Firstly, we're just not there yet today. Every single GPU-side DRM dri=
ver
> >> has userspace-triggerable faults which cause occasional errors in GL/V=
ulkan
> >> tests. Every single one. We deal with these in Mesa by retrying; if we
> >> didn't retry, across the breadth of hardware we test, I'd expect 99% of
> >> should-succeed merges to fail because of these intermittent bugs in th=
e DRM
> >> drivers.
> >=20
> > So the plan is only to ever test rendering devices? It should have been
> > made clearer then.
> >=20
> >> We don't have the same figure for KMS - because we don't test it - but
> >> I'd be willing to bet no driver is 100% if you run tests often enough.
> >=20
> > And I would still consider that a bug that we ought to fix, and
> > certainly not something we should sweep under the rug. If half the tests
> > are not running on a driver, then fine, they aren't. I'm not really
> > against having failing tests, I'm against not flagging unreliable tests
> > on a given hardware as failing tests.
>=20
> A flaky test will by definition give a "pass" result at least some of the=
 time, which would be considered a failure by the CI if the test is marked =
as failing.
>=20
>=20
> >> Secondly, we will never be there. If we could pause for five years and=
 sit
> >> down making all the current usecases for all the current hardware on t=
he
> >> current kernel run perfectly, we'd probably get there. But we can't: t=
here's
> >> new hardware, new userspace, and hundreds of new kernel trees.
> >=20
> > Not with that attitude :)
>=20
> Attitude is not the issue, the complexity of the multiple systems
> involved is.

FTR, that was a meme/joke.

> > I'm not sure it's actually an argument, really. 10 years ago, we would
> > never have been at "every GPU on the market has an open-source driver"
> > here. 5 years ago, we would never have been at this-series-here. That
> > didn't stop anyone making progress, everyone involved in that thread
> > included.
>=20
> Even assuming perfection is achievable at all (which is very doubtful,
> given the experience from the last few years of CI in Mesa and other
> projects), if you demand perfection before even taking the first step,
> it will never get off the ground.

Perfection and scale from the get-go isn't reasonable, yes. Building a
small, "perfect" (your words, not mine) system that you can later expand
is doable. And that's very much a design choice.

> > How are we even supposed to detect those failures in the first
> > place if tests are flagged as unreliable?
>=20
> Based on experience with Mesa, only a relatively small minority of
> tests should need to be marked as flaky / not run at all. The majority
> of tests are reliable and can catch regressions even while some tests
> are not yet.

I understand and acknowledge that it worked with Mesa. That's great for
Mesa. That still doesn't mean that it's the panacea and is for every
project.

> > No matter what we do here, what you describe will always happen. Like,
> > if we do flag those tests as unreliable, what exactly prevents another
> > issue to come on top undetected, and what will happen when we re-enable
> > testing?
>=20
> Any issues affecting a test will need to be fixed before (re-)enabling
> the test for CI.

If that underlying issue is never fixed, at which point do we consider
that it's a failure and should never be re-enabled? Who has that role?

> > On top of that, you kind of hinted at that yourself, but what set of
> > tests will pass is a property linked to a single commit. Having that
> > list within the kernel already alters that: you'll need to merge a new
> > branch, add a bunch of fixes and then change the test list state. You
> > won't have the same tree you originally tested (and defined the test
> > state list for).
>=20
> Ideally, the test state lists should be changed in the same commits
> which affect the test results. It'll probably take a while yet to get
> there for the kernel.
>=20
> > It might or might not be an issue for Linus' release, but I can
> > definitely see the trouble already for stable releases where fixes will
> > be backported, but the test state list certainly won't be updated.
>=20
> If the stable branch maintainers want to take advantage of CI for the
> stable branches, they may need to hunt for corresponding state list
> commits sometimes. They'll need to take that into account for their
> decision.

So we just expect the stable maintainers to track each and every patches
involved in a test run, make sure that they are in a stable tree, and
then update the test list? Without having consulted them at all?

> >> By keeping those sets of expectations, we've been able to keep Mesa pr=
etty
> >> clear of regressions, whilst having a very clear set of things that sh=
ould
> >> be fixed to point to. It would be great if those set of things were ze=
ro,
> >> but it just isn't. Having that is far better than the two alternatives:
> >> either not testing at all (obviously bad), or having the test always b=
e red
> >> so it's always ignored (might as well just not test).
> >=20
> > Isn't that what happens with flaky tests anyway?
>=20
> For a small minority of tests. Daniel was referring to whole test suites.
>=20
> > Even more so since we have 0 context when updating that list.
>=20
> The commit log can provide whatever context is needed.

Sure, I've yet to see that though.

There's in 6.6-rc1 around 240 reported flaky tests. None of them have
any context. That new series hads a few dozens too, without any context
either. And there's no mention about that being a plan, or a patch
adding a new policy for all tests going forward.

So I'm still fairly doubtful it will ever happen.

> > I've asked a couple of times, I'll ask again. In that other series, on
> > the MT8173, kms_hdmi_inject@inject-4k is setup as flaky (which is a KMS
> > test btw).
> >=20
> > I'm a maintainer for that part of the kernel, I'd like to look into it,
> > because it's seriously something that shouldn't fail, ever, the hardware
> > isn't involved.
> >=20
> > How can I figure out now (or worse, let's say in a year) how to
> > reproduce it? What kernel version was affected? With what board? After
> > how many occurences?
> >=20
> > Basically, how can I see that the bug is indeed there (or got fixed
> > since), and how to start fixing it?
>=20
> Many of those things should be documented in the commit log of the
> state list change.
>=20
> How the CI works in general should be documented in some appropriate
> place in tree.

I think I'll stop the discussion there. It was merged anyway so I'm not
quite sure why I was asked to give my feedback on this. Any concern I
raised were met with a giant "it worked on Mesa" handwave or "someone
will probably work on it at some point".

And fine, guess I'm wrong.

Thanks
Maxime

--5ilbap4gkrsqltiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZP8NTgAKCRDj7w1vZxhR
xUbwAP9xYajr1SxGqefYgkw1nJmhEpNrjvSqTUadaIowcFfU3QEAgaTNSIYR6g6D
U5DBLLVerPzwDKnQS9sCtYt9xh2WWQ8=
=4ACD
-----END PGP SIGNATURE-----

--5ilbap4gkrsqltiz--
