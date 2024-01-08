Return-Path: <linux-kernel+bounces-19356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46C826BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586971F212B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE413FEE;
	Mon,  8 Jan 2024 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUQ1OZgu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0013FFF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22372C433C8;
	Mon,  8 Jan 2024 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704711047;
	bh=45mRzzG6A0BR5+EXJpFhsTcZ8StNS2HuftbI7wCsVVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUQ1OZguKetLtE9/Q4mMNBuIDPGp0BsYULDlyJhRv9brlnE6UTjsPcIYQL9Z5d05D
	 YMH5R06JgKIU5soaIs1yVqEAYLfPrqx7O9+Od3EMN8qvZ08yI4DW6in645fuNJAlTb
	 wT9vV+mQ1JwJ2Cx77/+kgiSQY1fWjjZxFUzW0RHbcYsPmKcSWXl9d+0xsJhy630oMo
	 Y1D4+Xs5xGcm/jq1rtQqmRrBGD715/yc+tSCUXm/gvHVSSy6W8th+y4f9o7HiVK/4K
	 J6wvHYPe9XKbcnHM4s78BDsxSKtx6dlV8ZpXLw4E3uJbg5ghqN2Ze3DuXhBY66QMFf
	 z5A+HaENLiOuw==
Date: Mon, 8 Jan 2024 11:50:45 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dipam Turkar <dipamt1729@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm/tests: Add KUnit tests for
 drm_mode_create_dvi_i_properties()
Message-ID: <nwykizdm23hspewgmby6nrxu72wzdpsslr6b6puvn6jfrzwp6v@phfdkbgxnvzj>
References: <CALHmwspWRT=pj+mPDhf8YTwSpTz6LiNjq18wbUk7wCW3ijKU4A@mail.gmail.com>
 <20240106140117.9777-1-dipamt1729@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f6i67lwd5ztnttpq"
Content-Disposition: inline
In-Reply-To: <20240106140117.9777-1-dipamt1729@gmail.com>


--f6i67lwd5ztnttpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 06, 2024 at 07:31:18PM +0530, Dipam Turkar wrote:
> ---
>  drivers/gpu/drm/tests/drm_connector_test.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

You're missing your commit message, Signed-off-by and version changes here.

> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm=
/tests/drm_connector_test.c
> index c66aa2dc8d9d..aad63839b5e5 100644
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
> @@ -58,10 +61,27 @@ static void drm_test_get_tv_mode_from_name_truncated(=
struct kunit *test)
>  	KUNIT_EXPECT_LT(test, ret, 0);
>  };
> =20
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
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_select_subcon=
nector_property);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_subconnector_=
property);
> +}
> +
>  static struct kunit_case drm_get_tv_mode_from_name_tests[] =3D {
>  	KUNIT_CASE_PARAM(drm_test_get_tv_mode_from_name_valid,
>  			 drm_get_tv_mode_from_name_valid_gen_params),
>  	KUNIT_CASE(drm_test_get_tv_mode_from_name_truncated),
> +	KUNIT_CASE(drm_test_mode_create_dvi_i_properties),

And you still don't have the other test we talked about

Maxime

--f6i67lwd5ztnttpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZZvThAAKCRDj7w1vZxhR
xebbAP4zeeb/FcUWrmijKVL/s/8TH0vQNqBlFLdGHm6HVYyqDAD/Ty0poxMO78/b
nDUSErIzyXQ9Jbo4ETQb/x6MAa05awc=
=dFoD
-----END PGP SIGNATURE-----

--f6i67lwd5ztnttpq--

