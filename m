Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6317F71B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjKXKkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXKkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:40:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E292
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:40:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E9DC433C7;
        Fri, 24 Nov 2023 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822409;
        bh=yu7kFMpXZmzKeVcx8MNPyXndf7doerpWDtKSOSA/+yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYUDEixvbCkuFEtniyLG4wpWJGtV57ZcM9K7ZM+W8Wps7Mrh4ukiBQO0BUX2Q9A3n
         6bUM/lXjT+8fV/DeDo5qtJpFbJ7lb593VUIjH8YA8rYHpeROAf8+UFa9KVVInfIJM5
         3i1CXL7Fx0TOGyoMBGAiAZ3xYvFP1ME30jFdFO4IrTakDrdxHcFl5L9ndkYg0PwxTy
         sdi5H5U0H3jN0PEq9GZaVq+Q/7rRQ5IhYNSFBfg4FNeKCe/SY1kOaIBosdtp5FkkDZ
         I5VCweb49kNQ7LCtVnMA4RckmL7Y7NmBDi7jJSszP/wVpPiX9y2M6j2weYdVvV3Tz4
         DFE39EpbOur6g==
Date:   Fri, 24 Nov 2023 11:40:06 +0100
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
Subject: Re: [PATCH v18 04/26] drm/shmem-helper: Refactor locked/unlocked
 functions
Message-ID: <wboljiwogeus7pwgaqzxaltt3xdavy2dzisygn6pdpoiwlnwgc@mwaiukjguzat>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-5-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eft4e43k6jxpkr7h"
Content-Disposition: inline
In-Reply-To: <20231029230205.93277-5-dmitry.osipenko@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eft4e43k6jxpkr7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 02:01:43AM +0300, Dmitry Osipenko wrote:
> Add locked and remove unlocked postfixes from drm-shmem function names,
> making names consistent with the drm/gem core code.
>=20
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

This contradicts my earlier ack on a patch but...

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c        | 64 +++++++++----------
>  drivers/gpu/drm/lima/lima_gem.c               |  8 +--
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_gem.c       |  6 +-
>  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c       |  2 +-
>  drivers/gpu/drm/v3d/v3d_bo.c                  |  4 +-
>  drivers/gpu/drm/virtio/virtgpu_object.c       |  4 +-
>  include/drm/drm_gem_shmem_helper.h            | 36 +++++------
>  9 files changed, 64 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index 0d61f2b3e213..154585ddae08 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -43,8 +43,8 @@ static const struct drm_gem_object_funcs drm_gem_shmem_=
funcs =3D {
>  	.pin =3D drm_gem_shmem_object_pin,
>  	.unpin =3D drm_gem_shmem_object_unpin,
>  	.get_sg_table =3D drm_gem_shmem_object_get_sg_table,
> -	.vmap =3D drm_gem_shmem_object_vmap,
> -	.vunmap =3D drm_gem_shmem_object_vunmap,
> +	.vmap =3D drm_gem_shmem_object_vmap_locked,
> +	.vunmap =3D drm_gem_shmem_object_vunmap_locked,

While I think we should indeed be consistent with the names, I would
also expect helpers to get the locking right by default.

I'm not sure how reasonable it is, but I think I'd prefer to turn this
around and keep the drm_gem_shmem_object_vmap/unmap helpers name, and
convert whatever function needs to be converted to the unlock suffix so
we get a consistent naming.

Does that make sense?
Maxime

--eft4e43k6jxpkr7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWB9hgAKCRDj7w1vZxhR
xfb+AP43cb0axphjEQGBiPC4yhmd8hfPntevtBeCrKSQnUqj0gEAgok48TXqg35o
lxqE3r2I5svK+XrhBmYyPiUeWN48jw0=
=flek
-----END PGP SIGNATURE-----

--eft4e43k6jxpkr7h--
