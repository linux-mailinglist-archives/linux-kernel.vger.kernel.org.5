Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2E7F7202
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjKXKso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjKXKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:48:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546FED44
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:48:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D963C433C8;
        Fri, 24 Nov 2023 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822927;
        bh=zysSZGvXrCbjCkNU5T+HVpgGk/opMa6u/fjLGWPdamA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTGLHLRkeWT7p2NtFKIaJPtU0xmJtdVXzOJTjqJ24XPyj6Az8c9s6/XRvnCB5fUr3
         X6RVHahwnCGE5cIoe1l+aVNJMxGdDT8TXfWopsFBtpeEbRkM79Mh+JZUaboJwnnUi6
         CTrlLz1+sRoQdzHiGAKBIQcUVnsTL0vDX28TOmfL5XRYWJDBfO1ZfyNsctD9iDVrUv
         rHXj0jarstAfAHeLJV2KBmOLCDKs5vpqgtTUfb0gfJ+0HwRIYBWnAbIL+Fu+ZIcVXs
         QBUDBU12X/eHss4YmdyUqhil//rSPydelKJ3UdcNj1ZwTpuFfuljf8USFKN+fOneoB
         plgyAnkRdNZgQ==
Date:   Fri, 24 Nov 2023 11:48:44 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 09/26] drm/shmem-helper: Switch
 drm_gem_shmem_vmap/vunmap to use pin/unpin
Message-ID: <mvcfua6pzigfuaziynxmrzwkxpc3qphil7b6bbim43m63iajw7@zhizwn4pqgmi>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-10-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4lop2eds5vd4c6em"
Content-Disposition: inline
In-Reply-To: <20231029230205.93277-10-dmitry.osipenko@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4lop2eds5vd4c6em
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 02:01:48AM +0300, Dmitry Osipenko wrote:
> The vmapped pages shall be pinned in memory and previously get/put_pages()
> were implicitly hard-pinning/unpinning the pages. This will no longer be
> the case with addition of memory shrinker because pages_use_count > 0 won=
't
> determine anymore whether pages are hard-pinned (they will be soft-pinned=
),
> while the new pages_pin_count will do the hard-pinning. Switch the
> vmap/vunmap() to use pin/unpin() functions in a preparation of addition
> of the memory shrinker support to drm-shmem.
>=20
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

The naming convention discussion aside, and once it's settled and fixed:
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--4lop2eds5vd4c6em
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWB/jAAKCRDj7w1vZxhR
xa3pAP9hrcOY656LtJ0jepRAz3Rd+bj52uTM2ZvzdbEGSMjhwQEAj7bIm9/CTTzB
VnDL++pXP/ULo/+hXA7txBt3hwH+Awk=
=aWnC
-----END PGP SIGNATURE-----

--4lop2eds5vd4c6em--
