Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBD75ABA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGTKID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjGTKHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6C5136
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F26619FE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEE0C433C8;
        Thu, 20 Jul 2023 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689847659;
        bh=FfhZgQ+pQ/UDSPLyRjHsPzAtbC9LrIGVDPMAddOMUQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TtgG3RzrHCE4UsgIX10QOxdl4FsX3G8YGwzAMuZLNXLo5WRw80ZhzWl5cIeBLYZPx
         lVwaRLJQQO+AGnPhGUSRr8lHhMjRyFCVERmb20DfVgoFTfWMpnXElOJuRYPkUlXGJ5
         MV6TRixTPKIkfZJT+krnEQxw11O+Mxd6X/qlT/MdatEtDkclPddOVfURhOlErtXMcp
         NKyJJ21cKHiJqq63zOmxVU0O6/UX+eYsOOHH+D1ix3hdWiwhQ0TuBPF6ly3lqw/98H
         ioMd4bi90X0xuV+wZREAR1jzeUHefRIUii/WirAhnHTK6UZ9wcwTuxTOtp4xt2BCBo
         kxr3LeFs9T6zw==
Date:   Thu, 20 Jul 2023 12:07:36 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     suijingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [05/11] drm/tests: helpers: Create an helper to allocate a
 locking ctx
Message-ID: <5khgq6xy4ztci45qtxzo7fyvmdj3i6rrnl5yuny3gusgeeumdq@eobkes722rky>
References: <20230710-kms-kunit-actions-rework-v1-5-722c58d72c72@kernel.org>
 <970f4a65-25dc-1805-3776-6447a61f77c5@loongson.cn>
 <87o7k7hg1d.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p3xg2ps427f43xcp"
Content-Disposition: inline
In-Reply-To: <87o7k7hg1d.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p3xg2ps427f43xcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 09:12:14PM +0200, Javier Martinez Canillas wrote:
> suijingfeng <suijingfeng@loongson.cn> writes:
>=20
> > Hi,
> >
> > On 2023/7/10 15:47, Maxime Ripard wrote:
>=20
> [...]
>=20
> >> +
> >> +/**
> >> + * drm_kunit_helper_context_alloc - Allocates an acquire context
> >> + * @test: The test context object
> >> + *
> >> + * Allocates and initializes a modeset acquire context.
> >> + *
> >> + * The context is tied to the kunit test context, so we must not call
> >> + * drm_modeset_acquire_fini() on it, it will be done so automatically.
> >> + *
> >> + * Returns:
> >> + * An ERR_PTR on error, a pointer to the newly allocated context othe=
rwise
> >> + */
> >> +struct drm_modeset_acquire_ctx *
> >> +drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
> >> +{
> >> +	struct drm_modeset_acquire_ctx *ctx;
> >> +	int ret;
> >> +
> >> +	ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> >> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
> >> +
> >> +	drm_modeset_acquire_init(ctx, 0);
> >> +
> >> +	ret =3D kunit_add_action_or_reset(test,
> >> +					action_drm_release_context,
> >> +					ctx);
> >> +	if (ret)
> >> +		return ERR_PTR(ret);
> >> +
> >> +	return ctx;
> >> +}
> >> +EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
> >> +
> >
> > I think all of the patch inside this series are quite well.
> >
> > Personally, I can't find problems in it.
> >
> >
> > But I still want to ask a question:
> >
> > Should the managed functions you introduced be prefixed with drmm_=20
> > (instead of drm_) ?
> >
>=20
> That's a good question. But personally I think that the drmm_ prefix
> should be reserved for drm_device managed resources and helpers.

Yeah, to me drmm functions are meant for resources that are tied to the
DRM device lifetime. These resources are tied to the test lifetime, so
they shouldn't share the same prefix.

> > As mindless programmer may still want to call drm_modeset_acquire_fini(=
)=20
> > on the pointer returned by
> >
> > drm_kunit_helper_acquire_ctx_alloc()?
> >
>=20
> The function kernel-doc already mentions that there's no need to do that
> and that will be done automatically by kunit. So shouldn't be different of
> other functions helper where the programmer didn't read the documentation.

Right

Maxime

--p3xg2ps427f43xcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLkHaAAKCRDj7w1vZxhR
xToyAP4hkRI/8aKpOKams5XwxbGYROu5Qb2VT8DyZViYoQZlhAEAky8Oe4eJS3dM
4NDsW3WmKERxiFbfmvNxib5fvgiE9AU=
=7/bm
-----END PGP SIGNATURE-----

--p3xg2ps427f43xcp--
