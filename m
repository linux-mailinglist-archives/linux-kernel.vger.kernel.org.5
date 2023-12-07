Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22027808638
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjLGJmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:42:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED025C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:42:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFC9C433C7;
        Thu,  7 Dec 2023 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701942172;
        bh=RQ/yT7UHQaMM19x3eCi4Xe6CooZCw22QbB03I9HiZME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eA62PaghxUAe/vbJzjN51mMQUy96RPgMz38pPfpGglvkkos+dAh4/om6cyp0J0tsd
         YaTSsBkbGiIoMpMDpcs0CR2RTZbkVXNFtGBQZYzNe2tG9wFc5zxAiQ0tn4XA2NGV8p
         atWkAPDUaXOjFJW5d5jJKIn+bvml/bzSSa7dC+3tyuwMJCWCLuiqRLFBuYJG95YMCk
         zQ5neZLHUTRnUvCCJ2UV2TZFijRx20nQzXQDIRjaf/ROUlYRLXigWBrX5UHmawH8ha
         MfxH917s+QQRxjaHx3rHwuUvwmfPv0+Idi2FM3w8Xk3ZqI/up3t78e3xwMiDTs+obR
         g25gct1EXbi8A==
Date:   Thu, 7 Dec 2023 10:42:49 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev, davidgow@google.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: Kunit drm_test_check_plane_state: EXPECTATION FAILED at
 drivers/gpu/drm/tests/drm_plane_helper_test.c:123
Message-ID: <xqydjcs4tnjcm7wn2dfah27xj7j2soggsc5se2inz2s4azxvvv@cf3wn4up5hg6>
References: <20231204173536.51003-1-naresh.kamboju@linaro.org>
 <rxv7jlfuwjib443pzdepbtgu454gdzemd3ojmmhbnhr4syneve@6me3bduyx2ee>
 <42d85b15-9ffd-4a08-b51e-a3367e57d128@suswa.mountain>
 <fgajgc7vp626nzeeqetkfbyadh53iti3mvoq4uck3zz3ysmvno@b3f7kxnwrwsd>
 <f59c5d45-a689-8a94-a2ae-d2ffa835eedf@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hnkt3fuafjt46lbw"
Content-Disposition: inline
In-Reply-To: <f59c5d45-a689-8a94-a2ae-d2ffa835eedf@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hnkt3fuafjt46lbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 09:33:28AM -0800, Abhinav Kumar wrote:
>=20
>=20
> On 12/5/2023 3:46 AM, Maxime Ripard wrote:
> > On Tue, Dec 05, 2023 at 12:05:02PM +0300, Dan Carpenter wrote:
> > > On Tue, Dec 05, 2023 at 09:37:05AM +0100, Maxime Ripard wrote:
> > > > Hi Naresh,
> > > >=20
> > > > Thanks for the report
> > > >=20
> > > > On Mon, Dec 04, 2023 at 11:05:36PM +0530, Naresh Kamboju wrote:
> > > > > The Kunit drm_plane_helper failed on all devices running Linux ne=
xt-20231204
> > > > >=20
> > > > > ## Test Regressions (compared to next-20231201)
> > > > > * qemu-armv7, kunit and
> > > > > * x86, kunit
> > > > >    - drm_test_check_invalid_plane_state_downscaling_invalid
> > > > >    - drm_test_check_invalid_plane_state_drm_plane_helper
> > > > >    - drm_test_check_invalid_plane_state_drm_test_check_invalid_pl=
ane_state
> > > > >    - drm_test_check_invalid_plane_state_positioning_invalid
> > > > >    - drm_test_check_invalid_plane_state_upscaling_invalid
> > > > >    - drm_test_check_plane_state_clipping_rotate_reflect
> > > > >    - drm_test_check_plane_state_clipping_simple
> > > > >    - drm_test_check_plane_state_downscaling
> > > > >    - drm_test_check_plane_state_drm_test_check_plane_state
> > > > >    - drm_test_check_plane_state_positioning_simple
> > > > >    - drm_test_check_plane_state_rounding1
> > > > >    - drm_test_check_plane_state_rounding2
> > > > >    - drm_test_check_plane_state_rounding3
> > > > >    - drm_test_check_plane_state_rounding4
> > > > >    - drm_test_check_plane_state_upscaling
> > > >=20
> > > > I found the source of failure to be f1e75da5364e ("drm/atomic: Loos=
en FB
> > > > atomic checks").
> > > >=20
> > > > Fortunately for us, it's already been reverted yesterday for some
> > > > unrelated reason, so it should be fixed in next-20231205 onward.
> > >=20
> > > Sorry, that's a bummer that these patches were reverted.  :(  The who=
le
> > > episode was a bit unfortunate...
> > >=20
> > > Qualcom has been working on those patches for a year.  They must not =
be
> > > using kunit testing as part of their QC...  It's some kind of
> > > communication failure on our part.
> >=20
> > That's definitely a communication failure, but that's mostly on us :)
> >=20
> > The reason these patches were reverted was completely unrelated to the
> > kunit failures here: it failed the basic requirement we have on
> > intel-gpu-tools tests and open-source userspace examples for new uAPIs.
> >=20
> > So whether or not kunit tests would have passed, these patches were
> > applied due to inattention and would have been reverted anyway
>
> The patches were reverted because the corresponding IGT/compositor changes
> were not posted yet. We will re-try applying once those are accepted.
>=20
> Regarding KUnit tests, no we did not run this test and yes you are right,=
 we
> were not running KUnit testing as the DRM CI mainly validates IGT.
>=20
> We will certainly help to fix this failure. Most likely the KUnit tests n=
eed
> to be fixed to allow for a NULL FB.
>=20
> If this is documented somewhere as a requirement, please share it and we
> should add KUnit testing to our DRM CI as well so that atleast this kind =
of
> failure will not repeat.

Yeah, the expectation is that all tests pass all the time. If some
change affects how tests should be written, then it should update the
tests as well.

Maxime

--hnkt3fuafjt46lbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXGTmQAKCRDj7w1vZxhR
xVrqAPICYw4use79tIO3c5T9xojmy55gENs9FntfRnmdJclxAP9yhtInNdWWnmWv
5MWm44qBvgog8AzSmnMIorkWlaNHCA==
=02hC
-----END PGP SIGNATURE-----

--hnkt3fuafjt46lbw--
