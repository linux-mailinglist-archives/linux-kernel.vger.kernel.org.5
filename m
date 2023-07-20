Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3B75AC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGTLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGTLG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC32268F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBC4061A22
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A048DC433C7;
        Thu, 20 Jul 2023 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851215;
        bh=nW6GXJXezOzmxKL/mUK7YWV/NMfVem88eLoJC7XaP08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPXZJYsWPRAvaTWcfYGqmiW3vs3x0iPKKEk0GYNEYkOK9UkiAx7PPXWpWTOcy/s1A
         VXQ83P7k1kHTDazNqO/cqTcpQsFZ5WUScA4oWzS+8BxC24/9btrTtVrdHlVKZkkCDw
         30A2Lc98eVOYbxzfYhGr0e1y9UrNQ+kvWc4tsaFQTGL/M9BYXKswJiqyHHbRGPv85N
         Tcr+qMlV8MGewzEAcxaQhdidO0xzio7+V+FCqc1nFPmrXUj6arfGHufFQlmI+F/LFs
         ynBTcXbBL5tcoUA1Y5hXqg2MmmPzi8yAyKB4EOZTyTzuUUzONhNDTOB7jdZNhE2UWd
         G402Q/7XNRXZw==
Date:   Thu, 20 Jul 2023 13:06:51 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [09/11] drm/vc4: tests: pv-muxing: Switch to managed locking init
Message-ID: <ofn74ygkyt7ms4rfe47rebf6anqnkeorytedtvctavpqwepaqy@gct4abic4wpq>
References: <20230710-kms-kunit-actions-rework-v1-9-722c58d72c72@kernel.org>
 <c1184f26-ac80-8138-6501-de0609d16004@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6yioejuufk34fo2"
Content-Disposition: inline
In-Reply-To: <c1184f26-ac80-8138-6501-de0609d16004@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i6yioejuufk34fo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 01:24:29AM +0800, suijingfeng wrote:
> On 2023/7/10 15:47, Maxime Ripard wrote:
> > The new helper to init the locking context allows to remove some
> > boilerplate.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 42 ++++++++++++-----=
---------
> >   1 file changed, 19 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/g=
pu/drm/vc4/tests/vc4_test_pv_muxing.c
> > index 776a7b01608f..ff1deaed0cab 100644
> > --- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> > +++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> > @@ -20,7 +20,6 @@
> >   struct pv_muxing_priv {
> >   	struct vc4_dev *vc4;
> > -	struct drm_modeset_acquire_ctx ctx;
> >   	struct drm_atomic_state *state;
> >   };
> > @@ -725,6 +724,7 @@ static void drm_vc4_test_pv_muxing_invalid(struct k=
unit *test)
> >   static int vc4_pv_muxing_test_init(struct kunit *test)
> >   {
> >   	const struct pv_muxing_param *params =3D test->param_value;
> > +	struct drm_modeset_acquire_ctx *ctx;
> >   	struct drm_atomic_state *state;
> >   	struct pv_muxing_priv *priv;
> >   	struct drm_device *drm;
> > @@ -738,13 +738,14 @@ static int vc4_pv_muxing_test_init(struct kunit *=
test)
> >   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
> >   	priv->vc4 =3D vc4;
> > -	drm_modeset_acquire_init(&priv->ctx, 0);
> > +	ctx =3D drm_kunit_helper_acquire_ctx_alloc(test);
>=20
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>=20
> The pointer returned by drm_kunit_helper_acquire_ctx_alloc() function can=
't
> be NULL,
>=20
> if ctx is NULL, the current kthread will be terminated by the
> KUNIT_ASSERT_NOT_NULL() in the drm_kunit_helper_acquire_ctx_alloc().
>=20
> so only a PTR_ERR is possible, right?
>=20
> If so, probably invent a KUNIT_ASSERT_NOT_ERR() function to call is enoug=
h.
>=20
> I'm fine with this patch, but I feel the checking if the ctx is NULL is
> redundant.

I guess, but we're still reference that pointer later on, so making sure
that it's a valid pointer still makes sense.

Maxime

--i6yioejuufk34fo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLkVSwAKCRDj7w1vZxhR
xa9aAQDZyXaMtBF9l/m6WbuHQ7xXPN4u13bFG6gaQKEYJBXObQEAvvZ9chBq2mOw
+gey9Qa8fNru+HXpI0eQL4SLh5feZQo=
=AI02
-----END PGP SIGNATURE-----

--i6yioejuufk34fo2--
