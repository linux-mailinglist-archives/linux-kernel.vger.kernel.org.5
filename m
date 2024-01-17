Return-Path: <linux-kernel+bounces-28737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676D83026B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4821C2116C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822CB14016;
	Wed, 17 Jan 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRqpWm8E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D751400A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484150; cv=none; b=a/P0FzJRshiLR5GIVU7GXlfmRn0p2T9/mJbPLx2G/UWWsofgLR+UWoAxdW13nwfowrBAp6QG+EJFv0tO7GIVSeOqf5XNPBD/3ocGVLf8F9pvt7E9vxb3GonOsolZ1QRyWXqbi1+tXO9Yq/EqCfyORmRSDUZ6B32T8u62U6RebDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484150; c=relaxed/simple;
	bh=znmTNnnON1xAmvIdkiTAtEl/30Rg5OxKTetGP2gbTiQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=anjeCHR1rLro6QubF/cgrS7t3SrZMi+yki5XIhRUYyHv3xWyHEZw5a4HiWEHOUr2wHf1hy/8cMF3N6JDFoSjMx9Q8nMonOe2czZoOMdu6HRb2mR+fH8DU/is//+fxDCcmaO54Of8dEGuaHLNIxb+EKZjhsHr2B+sQ1wQPCuEACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRqpWm8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6FDC433C7;
	Wed, 17 Jan 2024 09:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484150;
	bh=znmTNnnON1xAmvIdkiTAtEl/30Rg5OxKTetGP2gbTiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRqpWm8EYw+VIG3YTD4htbP4pGw4w17GXw4tJMYQjbYo0+1vtuZgGCSbQXb3x61fR
	 khkosklsPRQA5w+5hqQJ4RunTLGNza2t2McdEJsgoMDyeTBzKuH9BpT0EoWwOeZw41
	 gTDTsVgJyp89SPnlANu3nj9FElynHHM+Oz73X9hCD6rmx/ht54iub1PVyNPffNAakq
	 ZFrMVPNW3ZvWJyRrXz5VfXHUy0ypJdH85kyJYjnnFNccF3MVd36S+le1VP17EUF5O9
	 Y6Nzhfc84FXT9ZBlbjReVM6KviyzLW1OPTOQT/3hvBdQtSoKAB/mOl62JJNRk0+E6L
	 HfmLSH9LvpqMQ==
Date: Wed, 17 Jan 2024 10:35:47 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dipam Turkar <dipamt1729@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, mairacanal@riseup.net, javierm@redhat.com, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] drm/tests: Add KUnit tests for
 drm_mode_create_dvi_i_properties()
Message-ID: <mk34n3vslyf6srydefxubwfst6bgymu27fabtdhopv3fi2hc7y@vpm6naewdorw>
References: <20240114105337.480807-1-dipamt1729@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7a4kvqwq7nylyz27"
Content-Disposition: inline
In-Reply-To: <20240114105337.480807-1-dipamt1729@gmail.com>


--7a4kvqwq7nylyz27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 14, 2024 at 04:23:38PM +0530, Dipam Turkar wrote:
> Introduce unit tests for the drm_mode_create_dvi_i_properties() function =
to ensure
> the proper creation of DVI-I specific connector properties and success if=
 called=20
> multiple times.
>=20
> Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> ---
>  drivers/gpu/drm/tests/drm_connector_test.c | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm=
/tests/drm_connector_test.c
> index c66aa2dc8d9d..217c0988171e 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
> @@ -4,6 +4,9 @@
>   */
> =20
>  #include <drm/drm_connector.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_kunit_helpers.h>
> =20
>  #include <kunit/test.h>
> =20
> @@ -70,7 +73,62 @@ static struct kunit_suite drm_get_tv_mode_from_name_te=
st_suite =3D {
>  	.test_cases =3D drm_get_tv_mode_from_name_tests,
>  };
> =20
> +/*
> + * Test that drm_mode_create_dvi_i_properties() succeeds and
> + * DVI-I subconnector and select subconectors properties have
> + * been created.
> + */
> +static void drm_test_mode_create_dvi_i_properties(struct kunit *test)
> +{
> +	struct drm_device *drm;
> +	struct device *dev;
> +
> +	dev =3D drm_kunit_helper_alloc_device(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	drm =3D __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0,=
 DRIVER_MODESET);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
> +
> +	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_select_subcon=
nector_property);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_subconnector_=
property);
> +}
> +
> +/*
> + * Test that drm_mode_create_dvi_i_properties() doesn't fail if called t=
wice.
> + */
> +static void drm_test_mode_create_dvi_i_properties_repeated(struct kunit =
*test)
> +{
> +	struct drm_device *drm;
> +	struct device *dev;
> +
> +	dev =3D drm_kunit_helper_alloc_device(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	drm =3D __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0,=
 DRIVER_MODESET);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
> +
> +	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_select_subcon=
nector_property);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_subconnector_=
property);
> +
> +	/* Expect the function to return 0 if called twice. */
> +	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);
> +}
> +
> +static struct kunit_case drm_mode_create_dvi_i_properties_tests[] =3D {
> +	KUNIT_CASE(drm_test_mode_create_dvi_i_properties),
> +	KUNIT_CASE(drm_test_mode_create_dvi_i_properties_repeated),
> +	{ }
> +};
> +
> +static struct kunit_suite drm_mode_create_dvi_i_properties_test_suite =
=3D {
> +	.name =3D "drm_mode_create_dvi_i_properties",
> +	.test_cases =3D drm_mode_create_dvi_i_properties_tests,
> +};
> +
>  kunit_test_suite(drm_get_tv_mode_from_name_test_suite);
> +kunit_test_suite(drm_mode_create_dvi_i_properties_test_suite);

You should use kunit_test_suites here

Maxime

--7a4kvqwq7nylyz27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZaefcgAKCRDj7w1vZxhR
xboWAQCphb6s5xjeFPpUgmXj/Xhz4QvE4u/AEpVQ3B5C4PKABAD9GOVRjkZDxTsf
yKBJJ1wi4YkmZlhNTZjd/nx45LN36A4=
=MDzt
-----END PGP SIGNATURE-----

--7a4kvqwq7nylyz27--

