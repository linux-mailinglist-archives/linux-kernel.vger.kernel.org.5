Return-Path: <linux-kernel+bounces-81360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B848C8674D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA921C22094
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD4E605AD;
	Mon, 26 Feb 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bT79gdFi"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D55FDB5;
	Mon, 26 Feb 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950424; cv=none; b=MF9yMi65adRr8nsAgYuaG6TvknMfIjBe7O3R9nSmftagIJokhDZ7yaKmnko+btHZxSD94Ju3cn2OlB2l9555pQXg1XvbaQCz7xfMUC/yMz5uOLf64AN9DvFthZce3z26Q4CnbqWe3j/p7LQrlbx9fJ0T1wUTGMTDhkWGOK1DEXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950424; c=relaxed/simple;
	bh=1atNF5q0PHutcAVd63k0m5zQJdUvHeKBxneBLA4KQ7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ackOomUJ32+ih/XUuf6mHAigPw0pq1XfyheLRpi2UllVOQmuKt2ymayTDelJtDPtz9hlPs6CqWN+INGTNGb6GfcAabtpKhitM5mlOrV01odm2tCqJPlTWtMcPLCJRaewiD+XBi8OptNo5Vpp9YNoLObJBjxDtSBcy+a3cvLvvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bT79gdFi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X62s8SRMke89gytb6JZNVCmlCtS3wHwCrunVCrHXdQU=; b=bT79gdFiTA/GcUxLwiLuVnAKkS
	4suDRCbzG0TI2IIJrxWoSNa0uwTQSbr7g17hrLHmp+++T27M3L5eStMvgjuj2Z3ZVforoIckjMu1z
	Y85eDnAIuWraGwOK+lfAbXBxNWI6/lRudFc7pKokW/MAVxz0+5Tqw/6BGZcsvCWFpnjZxvVo0ROI4
	qWwcI2B9CCF0AOEAk/exr0iguotC58IaHwJUfJhBk0LHVptBpDZ5LDx2+cJWXvD101/GABj2HQHaC
	uOsTZ99yM4wPkmHGiGN8O6cXlbFpdU6kmP1eFkY+jeMJnkkTXbzYcNDA8UAhNy1BN+50yYoB+xF0/
	jTwfKE0A==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rea4A-003Yij-2B; Mon, 26 Feb 2024 13:26:42 +0100
Message-ID: <4aab64fe-18ab-425b-9dc1-e4e9dc6b0087@igalia.com>
Date: Mon, 26 Feb 2024 09:26:33 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/36] drm/tests: Add helper to create mock crtc
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
 <20240222-kms-hdmi-connector-state-v7-4-8f4af575fce2@kernel.org>
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
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-4-8f4af575fce2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 15:13, Maxime Ripard wrote:
> We're going to need a full-blown, functional, KMS device to test more
> components of the atomic modesetting infrastructure.
> 
> Let's add a new helper to create a dumb, mocked, CRTC. By default it
> will create a CRTC relying only on the default helpers, but drivers are
> free to deviate from that.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/tests/drm_kunit_helpers.c | 62 +++++++++++++++++++++++++++++++
>   include/drm/drm_kunit_helpers.h           | 10 +++++
>   2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 32dc8354641a..d5317d13d3fc 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -249,5 +249,67 @@ drm_kunit_helper_create_primary_plane(struct kunit *test,
>   }
>   EXPORT_SYMBOL_GPL(drm_kunit_helper_create_primary_plane);
>   
> +static const struct drm_crtc_helper_funcs default_crtc_helper_funcs = {
> +};
> +
> +static const struct drm_crtc_funcs default_crtc_funcs = {
> +	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> +	.reset                  = drm_atomic_helper_crtc_reset,
> +};
> +
> +/**
> + * drm_kunit_helper_create_crtc - Creates a mock CRTC for a KUnit test
> + * @test: The test context object
> + * @drm: The device to alloc the plane for
> + * @primary: Primary plane for CRTC
> + * @cursor: Cursor plane for CRTC. Optional.
> + * @funcs: Callbacks for the new plane. Optional.
> + * @helper_funcs: Helpers callbacks for the new plane. Optional.
> + *
> + * This allocates and initializes a mock struct &drm_crtc meant to be
> + * part of a mock device for a KUnit test.
> + *
> + * Resources will be cleaned up automatically.
> + *
> + * @funcs will default to the default helpers implementations.
> + * @helper_funcs will default to an empty implementation.
> + *
> + * Returns:
> + * A pointer to the new CRTC, or an ERR_PTR() otherwise.
> + */
> +struct drm_crtc *
> +drm_kunit_helper_create_crtc(struct kunit *test,
> +			     struct drm_device *drm,
> +			     struct drm_plane *primary,
> +			     struct drm_plane *cursor,
> +			     const struct drm_crtc_funcs *funcs,
> +			     const struct drm_crtc_helper_funcs *helper_funcs)
> +{
> +	struct drm_crtc *crtc;
> +	int ret;
> +
> +	if (!funcs)
> +		funcs = &default_crtc_funcs;
> +
> +	if (!helper_funcs)
> +		helper_funcs = &default_crtc_helper_funcs;
> +
> +	crtc = drmm_kzalloc(drm, sizeof(*crtc), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, crtc);
> +
> +	ret = drmm_crtc_init_with_planes(drm, crtc,
> +					 primary,
> +					 cursor,
> +					 funcs,
> +					 NULL);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	drm_crtc_helper_add(crtc, helper_funcs);
> +
> +	return crtc;
> +}
> +EXPORT_SYMBOL_GPL(drm_kunit_helper_create_crtc);
> +
>   MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>   MODULE_LICENSE("GPL");
> diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
> index 38667d624aa8..6e99627edf45 100644
> --- a/include/drm/drm_kunit_helpers.h
> +++ b/include/drm/drm_kunit_helpers.h
> @@ -9,6 +9,8 @@
>   
>   #include <kunit/test.h>
>   
> +struct drm_crtc_funcs;
> +struct drm_crtc_helper_funcs;
>   struct drm_device;
>   struct drm_plane_funcs;
>   struct drm_plane_helper_funcs;
> @@ -110,4 +112,12 @@ drm_kunit_helper_create_primary_plane(struct kunit *test,
>   				      unsigned int num_formats,
>   				      const uint64_t *modifiers);
>   
> +struct drm_crtc *
> +drm_kunit_helper_create_crtc(struct kunit *test,
> +			     struct drm_device *drm,
> +			     struct drm_plane *primary,
> +			     struct drm_plane *cursor,
> +			     const struct drm_crtc_funcs *funcs,
> +			     const struct drm_crtc_helper_funcs *helper_funcs);
> +
>   #endif // DRM_KUNIT_HELPERS_H_
> 

