Return-Path: <linux-kernel+bounces-117137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FEC88A7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1271C6174F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8753B14D45F;
	Mon, 25 Mar 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r4Vpbein"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EC13BACC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372827; cv=none; b=WzJqNRgONd8hza71f68vGgqaVIkxHCq4IqdXKPwbhQo9g70NpvmDCNQ+GwVQoQWPkXUg7j7yZnunYZwSyaS8tguzwBwpyduKhiCmpGUmw6X4mJmepE9YXIdFElDrdpvhfoemUw9XOV1aiawn1T9Z9Lx2ONgno/wVezlKWz/e2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372827; c=relaxed/simple;
	bh=rOPUZgSaBBcCHJ+2lXm2gct6krqlLyRAgLa9zf5RrFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdz+77nFVCFaE+SXVp7Me1DIrurBtSHIZeb4uvpmm/JoytRlfK82VIHd/nhmFB1unypnAjO+waI8O2wNt3kiSKxJJP6b5+4cal8jp8re7TobgFShygrl3RgQdqBGDJZ9Dp/1eaJ6L7hg/C5wQSxRD6Z5gBSSckeiag4Y8h8MCeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r4Vpbein; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xUK65ABO5JIGVfyGhzrrtYRdlqu3DNIId6jsPmQspIs=; b=r4VpbeinWaV3SwuuhIVUZWECrM
	hwa7uBSe9dqOhvKZwmhmUnyNo0OkfRus2b9JexMcuLFm7Qoe9WmR3D5tPJj45IyWwElXboBu/Htd+
	9HY0+6OtilTclzMbwTcoEAiuDwhTWlUNmNSgtZC9UJMy5YeDkvmgOv6uWUZIaJjgYC3kX2zSCsyja
	5iaFJJ+7QWetTSzOGYYEEn8i90OUUhEiXVKX4RPyyy9u4u3r21TVfgezzAFXGqhzc+1dwu1th46fS
	GFbTZzBOsV1UqzkLbt1PAGOjHdf0W1JtwzdXfx5/5AcpHq6OhXIoV+sZgL9UwjQu3Y7MKDQ3JgMUo
	YjCeJRXg==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rokFF-00F4gm-Rv; Mon, 25 Mar 2024 14:20:10 +0100
Message-ID: <3f577a73-3daa-44e4-ab3c-ead1df422cfd@igalia.com>
Date: Mon, 25 Mar 2024 10:20:02 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/16] drm/vkms: Use drm_frame directly
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
 <20240313-yuv-v5-2-e610cbd03f52@bootlin.com>
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
In-Reply-To: <20240313-yuv-v5-2-e610cbd03f52@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/13/24 14:44, Louis Chauvet wrote:
> From: Arthur Grillo <arthurgrillo@riseup.net>
> 
> Remove intermidiary variables and access the variables directly from
> drm_frame. These changes should be noop.
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_drv.h       |  3 ---
>   drivers/gpu/drm/vkms/vkms_formats.c   | 12 +++++++-----
>   drivers/gpu/drm/vkms/vkms_plane.c     |  3 ---
>   drivers/gpu/drm/vkms/vkms_writeback.c |  5 -----
>   4 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 8f5710debb1e..b4b357447292 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -31,9 +31,6 @@ struct vkms_frame_info {
>   	struct drm_rect rotated;
>   	struct iosys_map map[DRM_FORMAT_MAX_PLANES];
>   	unsigned int rotation;
> -	unsigned int offset;
> -	unsigned int pitch;
> -	unsigned int cpp;
>   };
>   
>   struct pixel_argb_u16 {
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 36046b12f296..172830a3936a 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -11,8 +11,10 @@
>   
>   static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
>   {
> -	return frame_info->offset + (y * frame_info->pitch)
> -				  + (x * frame_info->cpp);
> +	struct drm_framebuffer *fb = frame_info->fb;
> +
> +	return fb->offsets[0] + (y * fb->pitches[0])
> +			      + (x * fb->format->cpp[0]);

Nitpicking: Could this be packed into a single line?

Anyway,

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

>   }
>   
>   /*
> @@ -131,12 +133,12 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
>   	u8 *src_pixels = get_packed_src_addr(frame_info, y);
>   	int limit = min_t(size_t, drm_rect_width(&frame_info->dst), stage_buffer->n_pixels);
>   
> -	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->cpp) {
> +	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->fb->format->cpp[0]) {
>   		int x_pos = get_x_position(frame_info, limit, x);
>   
>   		if (drm_rotation_90_or_270(frame_info->rotation))
>   			src_pixels = get_packed_src_addr(frame_info, x + frame_info->rotated.y1)
> -				+ frame_info->cpp * y;
> +				+ frame_info->fb->format->cpp[0] * y;
>   
>   		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
>   	}
> @@ -223,7 +225,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
>   	struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
>   	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst), src_buffer->n_pixels);
>   
> -	for (size_t x = 0; x < x_limit; x++, dst_pixels += frame_info->cpp)
> +	for (size_t x = 0; x < x_limit; x++, dst_pixels += frame_info->fb->format->cpp[0])
>   		wb->pixel_write(dst_pixels, &in_pixels[x]);
>   }
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 5a8d295e65f2..21b5adfb44aa 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -125,9 +125,6 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>   	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
>   			drm_rect_height(&frame_info->rotated), frame_info->rotation);
>   
> -	frame_info->offset = fb->offsets[0];
> -	frame_info->pitch = fb->pitches[0];
> -	frame_info->cpp = fb->format->cpp[0];
>   	vkms_plane_state->pixel_read = get_pixel_conversion_function(fmt);
>   }
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index bc724cbd5e3a..c8582df1f739 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -149,11 +149,6 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>   	crtc_state->active_writeback = active_wb;
>   	crtc_state->wb_pending = true;
>   	spin_unlock_irq(&output->composer_lock);
> -
> -	wb_frame_info->offset = fb->offsets[0];
> -	wb_frame_info->pitch = fb->pitches[0];
> -	wb_frame_info->cpp = fb->format->cpp[0];
> -
>   	drm_writeback_queue_job(wb_conn, connector_state);
>   	active_wb->pixel_write = get_pixel_write_function(wb_format);
>   	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
> 

