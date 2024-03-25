Return-Path: <linux-kernel+bounces-117095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6388B157
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C98C41169
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DB1311A7;
	Mon, 25 Mar 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="i4Ze7Gi9"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0B4779D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372435; cv=none; b=VPJt+umiakwHKnU1sk96ZEp680K23pRbGM9KMsb6CWTzBqpEYELYo7gR/ejbVADJIooFzsdE2UrABDuoKXoPxlfp4hE+7D4vRhnfVMQrqV2raFSvbSaolhfVKX+pWfrIIbAPpVjgIQTiUnmAi9+BocCVtpQkpul8v+Af1yrPjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372435; c=relaxed/simple;
	bh=HHojtjcoZd6Q92y03PdxY4XWhtuABkdvaPBeZKDCoIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDRoYtFJOjQy/jZ+iddrwp/kRHSQ0M5Ui1k1aPodmwLjnHKyx0Uldwoy/JJ0HQ36X3tW2EHV+J8iU7P1JJn/srXwMCOt57zoB1ZzY6E1CM6DqaLVHkxkKF7ugCXxsEg0qPsJ931NTS3z5Tb1Nfx94Z6FvUGcTWXQSRk2nZ+Oxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=i4Ze7Gi9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GcBGVLj2NcFTwaJ3wGR3716q37F9N27/ERujNnx/sdk=; b=i4Ze7Gi9i97w6QoI5KITzD7bbf
	1BNC5gzeTHM7hUDOI/4sd5ungwm8OX6/I5VU5k0sff1cBRttPd1z+z3E1LIl3Zn7NhTscAQv5Tv9K
	vn3GZFzf2zud+QXY7lx9R45jJ4t/LgR9/M+lS3I7u9B55iYCdOlxrnRUn+F+s4PxWM3FGhyBoPn9y
	5vZ2x/I8pkWM+5LWUT5Nd1/N5zCBPsa6ql5SNsdFvjPRobUbcpINzNgDDlv+gydCBbcSANonctgTU
	LZF/nxZRL1oDSrqyg8PRKSFrnPWJMtRT1kG+KmQqDajupDI1kL6DqD1Uy4ZH1ExZxG+anRUTpC6w4
	5cay/iPQ==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rok8U-00F4Ot-3f; Mon, 25 Mar 2024 14:13:10 +0100
Message-ID: <780d7dfb-3a91-4cd7-95a7-528877c9ad33@igalia.com>
Date: Mon, 25 Mar 2024 10:13:01 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] drm/vkms: Code formatting
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net,
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
 <20240313-yuv-v5-1-e610cbd03f52@bootlin.com>
Content-Language: en-US
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
In-Reply-To: <20240313-yuv-v5-1-e610cbd03f52@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/13/24 14:44, Louis Chauvet wrote:
> Few no-op changes to remove double spaces and fix wrong alignments.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_composer.c | 10 +++++-----
>   drivers/gpu/drm/vkms/vkms_crtc.c     |  6 ++----
>   drivers/gpu/drm/vkms/vkms_drv.c      |  3 +--
>   drivers/gpu/drm/vkms/vkms_plane.c    |  8 ++++----
>   4 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index e7441b227b3c..c6d9b4a65809 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -96,7 +96,7 @@ static u16 lerp_u16(u16 a, u16 b, s64 t)
>   	s64 a_fp = drm_int2fixp(a);
>   	s64 b_fp = drm_int2fixp(b);
>   
> -	s64 delta = drm_fixp_mul(b_fp - a_fp,  t);
> +	s64 delta = drm_fixp_mul(b_fp - a_fp, t);
>   
>   	return drm_fixp2int(a_fp + delta);
>   }
> @@ -302,8 +302,8 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
>   void vkms_composer_worker(struct work_struct *work)
>   {
>   	struct vkms_crtc_state *crtc_state = container_of(work,
> -						struct vkms_crtc_state,
> -						composer_work);
> +							  struct vkms_crtc_state,
> +							  composer_work);
>   	struct drm_crtc *crtc = crtc_state->base.crtc;
>   	struct vkms_writeback_job *active_wb = crtc_state->active_writeback;
>   	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
> @@ -328,7 +328,7 @@ void vkms_composer_worker(struct work_struct *work)
>   		crtc_state->gamma_lut.base = (struct drm_color_lut *)crtc->state->gamma_lut->data;
>   		crtc_state->gamma_lut.lut_length =
>   			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
> -		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length  - 1);
> +		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length - 1);
>   		crtc_state->gamma_lut.channel_value2index_ratio = drm_fixp_div(max_lut_index_fp,
>   									       u16_max_fp);
>   
> @@ -367,7 +367,7 @@ void vkms_composer_worker(struct work_struct *work)
>   		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
>   }
>   
> -static const char * const pipe_crc_sources[] = {"auto"};
> +static const char *const pipe_crc_sources[] = { "auto" };
>   
>   const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
>   					size_t *count)
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 61e500b8c9da..7586ae2e1dd3 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -191,8 +191,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
>   		return ret;
>   
>   	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
> -		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state,
> -								  plane);
> +		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state, plane);
>   		WARN_ON(!plane_state);
>   
>   		if (!plane_state->visible)
> @@ -208,8 +207,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	i = 0;
>   	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
> -		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state,
> -								  plane);
> +		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state, plane);
>   
>   		if (!plane_state->visible)
>   			continue;
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index dd0af086e7fa..83e6c9b9ff46 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -81,8 +81,7 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
>   	drm_atomic_helper_wait_for_flip_done(dev, old_state);
>   
>   	for_each_old_crtc_in_state(old_state, crtc, old_crtc_state, i) {
> -		struct vkms_crtc_state *vkms_state =
> -			to_vkms_crtc_state(old_crtc_state);
> +		struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(old_crtc_state);
>   
>   		flush_work(&vkms_state->composer_work);
>   	}
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index e5c625ab8e3e..5a8d295e65f2 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -117,10 +117,10 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>   	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
>   	drm_framebuffer_get(frame_info->fb);
>   	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
> -						     DRM_MODE_ROTATE_90 |
> -						     DRM_MODE_ROTATE_270 |
> -						     DRM_MODE_REFLECT_X |
> -						     DRM_MODE_REFLECT_Y);
> +									  DRM_MODE_ROTATE_90 |
> +									  DRM_MODE_ROTATE_270 |
> +									  DRM_MODE_REFLECT_X |
> +									  DRM_MODE_REFLECT_Y);
>   
>   	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
>   			drm_rect_height(&frame_info->rotated), frame_info->rotation);
> 

