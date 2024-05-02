Return-Path: <linux-kernel+bounces-166380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162748B99DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5692A286D01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B760EC4;
	Thu,  2 May 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UYqRyDsw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qu143nYj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UYqRyDsw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qu143nYj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C918B1CD39;
	Thu,  2 May 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648465; cv=none; b=n+0docJnUIcycA9gm3WRWZ59IADP4P1ynNCFcWxwm7qFJKbkP7j8IRLsUDS7rR+mhqMah1Haa1nOopRZgyPe6NB4y/dAq1r7KJBq44hkh/zKFlauDgt6202lzKD+ges34xH0tmOKcSGzWMfh4jafWK8+hS8GaKE7+FMCDLSYu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648465; c=relaxed/simple;
	bh=dNO0ufNAtJgMbnCjbuZCiwXtrJxYB0/g8PcyMuquhxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IO1C1VZ+nHJp+Llni73LYbTde33Hqe/9snWOxZj6/Br2v7kPfpj5My0oSZDVp3fvY3DSuBfIivD/NLFdz+HnBEIiDaMUCDL8chAxWgSnIULDhgoUg8c6t0a1mSH+LZ+x4AaAm5NNUdiEg8nfXscPKP0/y/hZrACTtOsmjUumHkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UYqRyDsw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qu143nYj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UYqRyDsw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qu143nYj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB7721FBA0;
	Thu,  2 May 2024 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714648460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AFoivokVevbslefJbFKkp1k4T1s78Pk+5RSvCxa63ZE=;
	b=UYqRyDswRJKSRNZPwV/gp0aTlhMsCEit/RtyFG1lDGsMcIXvCou9oNvgKrAXr0NVxsVGJx
	TXEIhlUkYRkJ+DCIDLaZVE83aHCdXUd3OhWzykfyxzsAYjIX9FDitxJWUnw6j3vuEWUYo6
	YB0+7z3KCymBMFq06U9ze3sM8tJ0ASU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714648460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AFoivokVevbslefJbFKkp1k4T1s78Pk+5RSvCxa63ZE=;
	b=Qu143nYjL+mHzWZ8nw6tnFahqj3o5XyootwuX+0cy+xiI1BPL68vP8ywBz7foDEgW7awn6
	gWkszUz9rIpuCKBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714648460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AFoivokVevbslefJbFKkp1k4T1s78Pk+5RSvCxa63ZE=;
	b=UYqRyDswRJKSRNZPwV/gp0aTlhMsCEit/RtyFG1lDGsMcIXvCou9oNvgKrAXr0NVxsVGJx
	TXEIhlUkYRkJ+DCIDLaZVE83aHCdXUd3OhWzykfyxzsAYjIX9FDitxJWUnw6j3vuEWUYo6
	YB0+7z3KCymBMFq06U9ze3sM8tJ0ASU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714648460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AFoivokVevbslefJbFKkp1k4T1s78Pk+5RSvCxa63ZE=;
	b=Qu143nYjL+mHzWZ8nw6tnFahqj3o5XyootwuX+0cy+xiI1BPL68vP8ywBz7foDEgW7awn6
	gWkszUz9rIpuCKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DDA41386E;
	Thu,  2 May 2024 11:14:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kdDnEYx1M2YXIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 May 2024 11:14:20 +0000
Message-ID: <31d22165-f7d7-4aaa-802c-fd8c9d67b287@suse.de>
Date: Thu, 2 May 2024 13:14:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/panfrost: Fix dma_resv deadlock at drm object
 pin time
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Qiang Yu <yuq825@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig= <christian.koenig@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
 <20240501065650.2809530-2-adrian.larumbe@collabora.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20240501065650.2809530-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[collabora.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,arm.com,linaro.org,amd.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-Spam-Score: -4.29
X-Spam-Flag: NO

Hi

Am 01.05.24 um 08:55 schrieb Adrián Larumbe:
> When Panfrost must pin an object that is being prepared a dma-buf
> attachment for on behalf of another driver, the core drm gem object pinning
> code already takes a lock on the object's dma reservation.
>
> However, Panfrost GEM object's pinning callback would eventually try taking
> the lock on the same dma reservation when delegating pinning of the object
> onto the shmem subsystem, which led to a deadlock.
>
> This can be shown by enabling CONFIG_DEBUG_WW_MUTEX_SLOWPATH, which throws
> the following recursive locking situation:
>
> weston/3440 is trying to acquire lock:
> ffff000000e235a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_shmem_pin+0x34/0xb8 [drm_shmem_helper]
> but task is already holding lock:
> ffff000000e235a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_pin+0x2c/0x80 [drm]
>
> Fix it by assuming the object's reservation had already been locked by the
> time we reach panfrost_gem_pin.

Maybe say that the reservation lock has been taken in drm_gem_pin()

>
> Do the same thing for the Lima driver, as it most likely suffers from the
> same issue.

Please split this patch into one for panfrost and one for lima. To each 
patch, you can add

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Fixes: a78027847226 ("drm/gem: Acquire reservation lock in drm_gem_{pin/unpin}()")
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>   drivers/gpu/drm/lima/lima_gem.c         | 2 +-
>   drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
> index 7ea244d876ca..c4e0f9faaa47 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -185,7 +185,7 @@ static int lima_gem_pin(struct drm_gem_object *obj)
>   	if (bo->heap_size)
>   		return -EINVAL;
>   
> -	return drm_gem_shmem_pin(&bo->base);
> +	return drm_gem_shmem_object_pin(obj);
>   }
>   
>   static int lima_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index d47b40b82b0b..f268bd5c2884 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -192,7 +192,7 @@ static int panfrost_gem_pin(struct drm_gem_object *obj)
>   	if (bo->is_heap)
>   		return -EINVAL;
>   
> -	return drm_gem_shmem_pin(&bo->base);
> +	return drm_gem_shmem_object_pin(obj);
>   }
>   
>   static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


