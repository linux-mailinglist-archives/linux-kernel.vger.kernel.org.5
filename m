Return-Path: <linux-kernel+bounces-81371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68328674F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F90E28A5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5688160880;
	Mon, 26 Feb 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nO7o1mql"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A0604BB;
	Mon, 26 Feb 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950602; cv=none; b=Pr16979YzLzQs14JY4PAUX0LhKeANMF2pDfRhZXgPKcwK+cvZHzaNkSHYIdQilgZJnRoA6zr6jaeUiufFrtPVhs0TTJKhBFixvKSNtTURDbkNvs1Fm5nZyzXOWaEFX86MLMu8L2ZZVhKq5taUPkHTHoexbMNRnUoQxJ1QH//CKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950602; c=relaxed/simple;
	bh=2UzpBftGfONTgJsYO9jo3Eiv5eHfoMEaol+tbd/SXHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKWPyTvgeW2vqxUBOSUuLHIqLgMUid9jCXPSUo4wTdo9RJ+G1ZMU9J4vFwu+9eMiiEZcLqyO4ogPXM2es+vAAOVztYCoQfcTjwgA0J+u6qZC8/zUj/JuYqossibt4rDd9CO2wU+KBVpom/ZHudGp5quYnNen9ynX9bB0SGSSRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nO7o1mql; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6uiBS+Qi7asaIxy6/7a5MSyWBWL8eWW6sZvNhsKqAP4=; b=nO7o1mql1l5uhE1TZDI6i2tAQ0
	wyfpn30zdIhLWSm7LAnvxgSFa2K1lK+j8MYcjGXa3TeWtoyonvn57BTBA9m+ETkCt6ZIvqsghfzW4
	QAkfqgbBwiJk6xewHIkjbf5mFTN6T3aHAdhW3Y83KUgbhQtVNSRTgrXyQWMm9kq+mNSD53P++KVhj
	ZNMqKZl7GrmXWMRIT6+EryKM0uK4yq1WzsKmahmk+zfy22KNPxpv9a7uSSI4bexip7spal8O/YBHm
	eVHrLna8RfH0FyG5WHfJ8TqABMatDf2YBgl8JDX89I05n3kSdljjUpE3jYhLzD+JTP31KV9ZKYzqQ
	4yOKJ0pQ==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rea72-003YnI-Sh; Mon, 26 Feb 2024 13:29:41 +0100
Message-ID: <244fe6b9-f295-4c85-908a-014ada0033fa@igalia.com>
Date: Mon, 26 Feb 2024 09:29:32 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 29/36] drm/vc4: tests: Remove vc4_dummy_plane structure
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
 <20240222-kms-hdmi-connector-state-v7-29-8f4af575fce2@kernel.org>
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
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-29-8f4af575fce2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 15:14, Maxime Ripard wrote:
> The vc4_dummy_plane structure is an exact equivalent to vc4_plane, so we

Maybe I understood incorrectly, but isn't the vc4_dummy_plane structure 
equivalent to drm_plane?

Best Regards,
- Maíra

> don't need it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/vc4/tests/vc4_mock.c       |  6 ++----
>   drivers/gpu/drm/vc4/tests/vc4_mock.h       |  9 ++-------
>   drivers/gpu/drm/vc4/tests/vc4_mock_plane.c | 14 +++++---------
>   3 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tests/vc4_mock.c
> index becb3dbaa548..0731a7d85d7a 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
> +++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
> @@ -109,16 +109,14 @@ static const struct vc4_mock_desc vc5_mock =
>   static int __build_one_pipe(struct kunit *test, struct drm_device *drm,
>   			    const struct vc4_mock_pipe_desc *pipe)
>   {
> -	struct vc4_dummy_plane *dummy_plane;
>   	struct drm_plane *plane;
>   	struct vc4_dummy_crtc *dummy_crtc;
>   	struct drm_crtc *crtc;
>   	unsigned int i;
>   
> -	dummy_plane = vc4_dummy_plane(test, drm, DRM_PLANE_TYPE_PRIMARY);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_plane);
> +	plane = vc4_dummy_plane(test, drm, DRM_PLANE_TYPE_PRIMARY);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
>   
> -	plane = &dummy_plane->plane.base;
>   	dummy_crtc = vc4_mock_pv(test, drm, plane, pipe->data);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_crtc);
>   
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.h b/drivers/gpu/drm/vc4/tests/vc4_mock.h
> index 2d0b339bd9f3..002b6218960c 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_mock.h
> +++ b/drivers/gpu/drm/vc4/tests/vc4_mock.h
> @@ -21,13 +21,8 @@ struct drm_crtc *vc4_find_crtc_for_encoder(struct kunit *test,
>   	return NULL;
>   }
>   
> -struct vc4_dummy_plane {
> -	struct vc4_plane plane;
> -};
> -
> -struct vc4_dummy_plane *vc4_dummy_plane(struct kunit *test,
> -					struct drm_device *drm,
> -					enum drm_plane_type type);
> +struct drm_plane *vc4_dummy_plane(struct kunit *test, struct drm_device *drm,
> +				  enum drm_plane_type type);
>   
>   struct vc4_dummy_crtc {
>   	struct vc4_crtc crtc;
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
> index 62b18f5f41db..973f5f929097 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
> +++ b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
> @@ -22,15 +22,12 @@ static const uint32_t vc4_dummy_plane_formats[] = {
>   	DRM_FORMAT_XRGB8888,
>   };
>   
> -struct vc4_dummy_plane *vc4_dummy_plane(struct kunit *test,
> -					struct drm_device *drm,
> -					enum drm_plane_type type)
> +struct drm_plane *vc4_dummy_plane(struct kunit *test, struct drm_device *drm,
> +				  enum drm_plane_type type)
>   {
> -	struct vc4_dummy_plane *dummy_plane;
>   	struct drm_plane *plane;
>   
> -	dummy_plane = drmm_universal_plane_alloc(drm,
> -						 struct vc4_dummy_plane, plane.base,
> +	plane = __drmm_universal_plane_alloc(drm, sizeof(struct drm_plane), 0,
>   						 0,
>   						 &vc4_dummy_plane_funcs,
>   						 vc4_dummy_plane_formats,
> @@ -38,10 +35,9 @@ struct vc4_dummy_plane *vc4_dummy_plane(struct kunit *test,
>   						 NULL,
>   						 DRM_PLANE_TYPE_PRIMARY,
>   						 NULL);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_plane);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
>   
> -	plane = &dummy_plane->plane.base;
>   	drm_plane_helper_add(plane, &vc4_dummy_plane_helper_funcs);
>   
> -	return dummy_plane;
> +	return plane;
>   }
> 

