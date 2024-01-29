Return-Path: <linux-kernel+bounces-42409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D88400F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95621F23E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA454F8F;
	Mon, 29 Jan 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tMLn71OD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9E54BEC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519352; cv=none; b=RsLb/O467Ht8iE4S327YWRYZ5jJVMAhF+71XttzG7AEOXFqKDc1fF0NUEeoBydRlqeRSgmExYOWAQJij9soHy7wPyDoqK8cuA/K2lOykmi1sTAKMMj8l1bgw2bpqEOksyLQtIX4rmw8j42HxuUW9jvg08d3DFT7TJUkiaCbH+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519352; c=relaxed/simple;
	bh=3eVGnHQarUvvYEP93Efg52JEWCK+33R/xQvbNmpvJBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QitWS3qHwMiGjtHYVOBkP7ccjaz4nNVfxIMZOkvxkf7nbg6zs5ncEL4A74xaBACWiycgV6aEmWj9zrjxZGitCn8L9rE393jfP4ITsiP2TSp4YpVVJlqLIN4VMVD3C/FUAzE6y1HpYhG4XxpQRlxhvS7Mzx+48E8yxBepKETVlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tMLn71OD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706519349;
	bh=3eVGnHQarUvvYEP93Efg52JEWCK+33R/xQvbNmpvJBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMLn71ODKx6DF+vSa8/KkoIvMDRiO6FIg+NwQjJDxf4wBpUl+EchCZYCM4DeLemAq
	 xZ+yncKFM0IqFGN43pSSOGBQpz0DDzQJYdVwnv93RSgQISVR+cpvh/wLapwQ6zXDde
	 8DjxsK1mdT9CztY4apxWZugMfum2F1dPagdplBPYyPb6Ir1DdtDfsWIO9tlIuDlr99
	 B6zywy/V/MhPGItatLHPzi5/lbF86zr/PW4fuobLrebAv9HO0c8HZ+SgoLnOJn5LEf
	 DV+l5hZ7+0eS05Hxr3bNuELW043fqkei8ypbnzmr9R+b/mz4s41C8LO/iLyvdubSmN
	 O9mubjbsLTzHw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 97BA437814A4;
	Mon, 29 Jan 2024 09:09:08 +0000 (UTC)
Message-ID: <9eea9580-744a-4b04-97a1-11e86565b895@collabora.com>
Date: Mon, 29 Jan 2024 12:09:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/virtio: set segment size for virtio_gpu device
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <7258a4cc-da16-5c34-a042-2a23ee396d56@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <7258a4cc-da16-5c34-a042-2a23ee396d56@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/23/24 21:14, Sebastian Ott wrote:
> drm/virtio: set segment size for virtio_gpu device
> 
> Set the segment size of the virtio_gpu device to the value
> used by the drm helpers when allocating sg lists to fix the
> following complaint from DMA_API debug code:
> DMA-API: virtio-pci 0000:07:00.0: mapping sg segment longer than device
> claims to support [len=262144] [max=65536]
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c
> b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 4334c7608408..74b2cb3295af 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -94,6 +94,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
>               goto err_free;
>       }
> 
> +    dma_set_max_seg_size(dev->dev, dma_max_mapping_size(dev->dev) ? :
> UINT_MAX);
>       ret = virtio_gpu_init(vdev, dev);
>       if (ret)
>           goto err_free;

Added stable tag and applied to misc-fixes. Please use `git send-email`
next time. Thanks

-- 
Best regards,
Dmitry


