Return-Path: <linux-kernel+bounces-81374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B74E8674FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CFD2868C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245EF633F1;
	Mon, 26 Feb 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EPkqIIez"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C563113;
	Mon, 26 Feb 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950650; cv=none; b=cjg07qzRoULv804MX3O1j58+20PnOgkFa4Kn8JVRhEStSg9u8/j+V1w3FMrRDALTXHMps//Hj/m1ES5arcVgZ/iMs5p/Ot+n2NgSAyBzbksEZerxJAzFhxlfafB/FMf1YQSuqbPl2o4OCQD8cmVJWzAJFTA+b/V0g/eqWohNIn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950650; c=relaxed/simple;
	bh=367nRfM+AwkILElpi2M/PUviC5yCBObZdPSIGUNMP8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFTOtLbshvuMX1HKI2oOqR2OFpEcyoLF4IvcGT6u6ewkdznlK79g/TuDxAFD1zrKAAai3So6WLEyivTT5pQDwvFFbOD8RaZwS3GHdKdpNOqhF+YecKF1kj5OHIdE2JWa4Q7VmUnSzvPUbpQBhEsZl0wSYTiS1NHCvxQNUSoGmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EPkqIIez; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9E9uFo1ZA4/GNHoSVHywi3ucQYA9wjLjy4y7D2QRVoQ=; b=EPkqIIez4XfxwdTWX1fAQshniD
	FJKNTXjlGpDIVV5cx73AbQbU7Azp2+otOzvEDrCbsB1QB+UOdRraNjeC+SLcngtv5x07m/8qNxxEk
	RFGK6TdhGxMHDTlogi9HFkwbumaJaAmi1/JIOxPj4WUSyekNPJzY70rmgEsMuxH/ga1KXbKOfLMGH
	M4DCO2/SXb6kiAQzcWXAQL0Q0WNp1RqilelPemAmio440xzS6+9rI4r3ps1c/E4irVejK+hTBIedD
	SFPxx2OLYHPYoYfP8T2JqQAV016Ngc6nrUsDZuyH4Nx3wzURyDeEYrR+RmUrkTBkKYVCfmB0OA9rX
	BUDcgD0w==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rea7q-003YnI-Ph; Mon, 26 Feb 2024 13:30:31 +0100
Message-ID: <1c91ff55-e6c6-4543-bbf5-c7543cc03979@igalia.com>
Date: Mon, 26 Feb 2024 09:30:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 30/36] drm/vc4: tests: Convert to plane creation helper
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-30-8f4af575fce2@kernel.org>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-30-8f4af575fce2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 15:14, Maxime Ripard wrote:
> Now that we have a plane create helper for kunit mocked drivers, let's
> convert to it in vc4.

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/vc4/tests/vc4_mock_plane.c | 34 +++++++-----------------------
>   1 file changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
> index 973f5f929097..14357db82238 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
> +++ b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
> @@ -1,43 +1,25 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <drm/drm_atomic_state_helper.h>
> -#include <drm/drm_fourcc.h>
> -#include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_kunit_helpers.h>
>   #include <drm/drm_plane.h>
>   
>   #include <kunit/test.h>
>   
>   #include "vc4_mock.h"
>   
> -static const struct drm_plane_helper_funcs vc4_dummy_plane_helper_funcs = {
> -};
> -
> -static const struct drm_plane_funcs vc4_dummy_plane_funcs = {
> -	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> -	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
> -	.reset			= drm_atomic_helper_plane_reset,
> -};
> -
> -static const uint32_t vc4_dummy_plane_formats[] = {
> -	DRM_FORMAT_XRGB8888,
> -};
> -
>   struct drm_plane *vc4_dummy_plane(struct kunit *test, struct drm_device *drm,
>   				  enum drm_plane_type type)
>   {
>   	struct drm_plane *plane;
>   
> -	plane = __drmm_universal_plane_alloc(drm, sizeof(struct drm_plane), 0,
> -						 0,
> -						 &vc4_dummy_plane_funcs,
> -						 vc4_dummy_plane_formats,
> -						 ARRAY_SIZE(vc4_dummy_plane_formats),
> -						 NULL,
> -						 DRM_PLANE_TYPE_PRIMARY,
> -						 NULL);
> +	KUNIT_ASSERT_EQ(test, type, DRM_PLANE_TYPE_PRIMARY);
> +
> +	plane = drm_kunit_helper_create_primary_plane(test, drm,
> +						      NULL,
> +						      NULL,
> +						      NULL, 0,
> +						      NULL);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
>   
> -	drm_plane_helper_add(plane, &vc4_dummy_plane_helper_funcs);
> -
>   	return plane;
>   }
> 

