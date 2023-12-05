Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973AC804C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjLEIhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjLEIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:37:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928D9C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:37:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E7EC433C7;
        Tue,  5 Dec 2023 08:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701765428;
        bh=Gx0Gid6CgNqEt1nJzs1qtZqNtgefBQINfqVpJBkwASY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMkY/aU4jWPbPqybwAqA+E6Cw/6E//QdRtkIJuI1KiaUk5E3XBpZYxYrOOzDvSAms
         mVzVRQYxa7YJIq3bgct69MgP9NvG81FiYy+m3pUvGv0VXOqJ9SMMPh/b6cPDO8cGI5
         b89f2mod3hvF60FqdRKO8iCMKV5B3jmNxAaTP8Lv4STdORnf0C6/VSz6+vEpZtaHgO
         pzSV1M/kcR0ReeKX9p6s+i0UYtgsmIm0xPUKRmHhBppiQphOxvpcbsfyk9wodlH4RW
         4Kkc/a7CXQsSZ8vFVUPGTf4vXMpDN7IULVmEfdLRBMjaQsuJe+2VBvpc1dGLfUcShL
         k8jcDiJ2UPMSg==
Date:   Tue, 5 Dec 2023 09:37:05 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev, davidgow@google.com,
        dan.carpenter@linaro.org, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: Kunit drm_test_check_plane_state: EXPECTATION FAILED at
 drivers/gpu/drm/tests/drm_plane_helper_test.c:123
Message-ID: <rxv7jlfuwjib443pzdepbtgu454gdzemd3ojmmhbnhr4syneve@6me3bduyx2ee>
References: <20231204173536.51003-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="avjzm6fep5gbbakc"
Content-Disposition: inline
In-Reply-To: <20231204173536.51003-1-naresh.kamboju@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--avjzm6fep5gbbakc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

Thanks for the report

On Mon, Dec 04, 2023 at 11:05:36PM +0530, Naresh Kamboju wrote:
> The Kunit drm_plane_helper failed on all devices running Linux next-20231=
204
>=20
> ## Test Regressions (compared to next-20231201)
> * qemu-armv7, kunit and
> * x86, kunit
>   - drm_test_check_invalid_plane_state_downscaling_invalid
>   - drm_test_check_invalid_plane_state_drm_plane_helper
>   - drm_test_check_invalid_plane_state_drm_test_check_invalid_plane_state
>   - drm_test_check_invalid_plane_state_positioning_invalid
>   - drm_test_check_invalid_plane_state_upscaling_invalid
>   - drm_test_check_plane_state_clipping_rotate_reflect
>   - drm_test_check_plane_state_clipping_simple
>   - drm_test_check_plane_state_downscaling
>   - drm_test_check_plane_state_drm_test_check_plane_state
>   - drm_test_check_plane_state_positioning_simple
>   - drm_test_check_plane_state_rounding1
>   - drm_test_check_plane_state_rounding2
>   - drm_test_check_plane_state_rounding3
>   - drm_test_check_plane_state_rounding4
>   - drm_test_check_plane_state_upscaling

I found the source of failure to be f1e75da5364e ("drm/atomic: Loosen FB
atomic checks").

Fortunately for us, it's already been reverted yesterday for some
unrelated reason, so it should be fixed in next-20231205 onward.

Maxime

--avjzm6fep5gbbakc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW7hKAAKCRDj7w1vZxhR
xdLHAQCBq1TbsVGexMuiakZrs0ljSHEFqv6BDxICWNEamhhfPwEAnZl6aajng8Dm
yG/mkv/gJ4qnjDD0+M21kXMNe6WCkQc=
=ckFT
-----END PGP SIGNATURE-----

--avjzm6fep5gbbakc--
