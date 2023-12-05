Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E523805347
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbjLELqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjLELqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:46:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266FCA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:46:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12E9C433C8;
        Tue,  5 Dec 2023 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701776775;
        bh=tI99Im86WnASOz4SHjHfEoqX8c1oRdAdwAQEPlCbyWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOBggSjgHJ4KfWdeTTRc5eZWVFWRZlJwdADbSrFu3/PQ0lddCs4iHUyb0uE1iPaRA
         o5yPJ8wnb3XA21G2wfJM/4HxBzfgh7/6Ju8iTwNV3RDIekOLLMjngZ2rJ970me5qFH
         KtiyR8IZDcR7Pe7YLUYF/4BzSxO8b4Jl9dpZQgSLA4hVWq4ivpgKjmBcbsNbfTO11H
         mgnLr4/Hy8lgSAnl0Vjw4gTOOMS+WHqAHffYlbesIwj5aj2XLo+dy5sA0HtHWDF2lR
         SF3OCFW9s0alikkmnAC/qzMW8RNuwjDEMVn8osVh0hIDgkG7BSjD4L/OxvtwwdV/93
         xRz7ZMLgusO5A==
Date:   Tue, 5 Dec 2023 12:46:12 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev, davidgow@google.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: Kunit drm_test_check_plane_state: EXPECTATION FAILED at
 drivers/gpu/drm/tests/drm_plane_helper_test.c:123
Message-ID: <fgajgc7vp626nzeeqetkfbyadh53iti3mvoq4uck3zz3ysmvno@b3f7kxnwrwsd>
References: <20231204173536.51003-1-naresh.kamboju@linaro.org>
 <rxv7jlfuwjib443pzdepbtgu454gdzemd3ojmmhbnhr4syneve@6me3bduyx2ee>
 <42d85b15-9ffd-4a08-b51e-a3367e57d128@suswa.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wuxjya7du2xfv7u4"
Content-Disposition: inline
In-Reply-To: <42d85b15-9ffd-4a08-b51e-a3367e57d128@suswa.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wuxjya7du2xfv7u4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 12:05:02PM +0300, Dan Carpenter wrote:
> On Tue, Dec 05, 2023 at 09:37:05AM +0100, Maxime Ripard wrote:
> > Hi Naresh,
> >=20
> > Thanks for the report
> >=20
> > On Mon, Dec 04, 2023 at 11:05:36PM +0530, Naresh Kamboju wrote:
> > > The Kunit drm_plane_helper failed on all devices running Linux next-2=
0231204
> > >=20
> > > ## Test Regressions (compared to next-20231201)
> > > * qemu-armv7, kunit and
> > > * x86, kunit
> > >   - drm_test_check_invalid_plane_state_downscaling_invalid
> > >   - drm_test_check_invalid_plane_state_drm_plane_helper
> > >   - drm_test_check_invalid_plane_state_drm_test_check_invalid_plane_s=
tate
> > >   - drm_test_check_invalid_plane_state_positioning_invalid
> > >   - drm_test_check_invalid_plane_state_upscaling_invalid
> > >   - drm_test_check_plane_state_clipping_rotate_reflect
> > >   - drm_test_check_plane_state_clipping_simple
> > >   - drm_test_check_plane_state_downscaling
> > >   - drm_test_check_plane_state_drm_test_check_plane_state
> > >   - drm_test_check_plane_state_positioning_simple
> > >   - drm_test_check_plane_state_rounding1
> > >   - drm_test_check_plane_state_rounding2
> > >   - drm_test_check_plane_state_rounding3
> > >   - drm_test_check_plane_state_rounding4
> > >   - drm_test_check_plane_state_upscaling
> >=20
> > I found the source of failure to be f1e75da5364e ("drm/atomic: Loosen FB
> > atomic checks").
> >=20
> > Fortunately for us, it's already been reverted yesterday for some
> > unrelated reason, so it should be fixed in next-20231205 onward.
>=20
> Sorry, that's a bummer that these patches were reverted.  :(  The whole
> episode was a bit unfortunate...
>=20
> Qualcom has been working on those patches for a year.  They must not be
> using kunit testing as part of their QC...  It's some kind of
> communication failure on our part.

That's definitely a communication failure, but that's mostly on us :)

The reason these patches were reverted was completely unrelated to the
kunit failures here: it failed the basic requirement we have on
intel-gpu-tools tests and open-source userspace examples for new uAPIs.

So whether or not kunit tests would have passed, these patches were
applied due to inattention and would have been reverted anyway

Maxime

--wuxjya7du2xfv7u4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW8NhAAKCRDj7w1vZxhR
xcWGAQDBxOux4QLD0euXH7Xp+Zu5/Zs2ypIGpLrB2r5TK3lb3gEAmdpM+yqNE4r0
7XgB+RHu1Vq7uBRLhaz6uZ0GSdcCyAI=
=x8h+
-----END PGP SIGNATURE-----

--wuxjya7du2xfv7u4--
