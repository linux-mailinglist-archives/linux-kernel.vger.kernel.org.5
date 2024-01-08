Return-Path: <linux-kernel+bounces-20120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E28279FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391231C21F56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24155E64;
	Mon,  8 Jan 2024 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBAZIb4N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65755E52
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6XBAJgvMkrZ7HQ+t44A/6f0D9JkYwuRQIHKb8oS271w=; b=JBAZIb4Np0UES5FkxyCz4fKFwP
	F7SiVzE0iTtlJhuz/FHuRvUXLdCZG82+1QWGNfpFwEfGACZjpB4O1OnFs7d3axqPECjWi8EQ5gAdo
	5H1mIFY9q3a3AR5JfLjl0GkenEWGS6zY11p9B0O2rDfCz43diDdqTxTi3BggyiFH67KDv3Vb56zNv
	ZcSZguqx617Y9D/ZA+ztBVpxu0bm9/WbsIHiL6pn61G/T0hX6z3nsdsyj5iDctEA1iVXYUpu01LvH
	yzcY2pFAbMGkiUAZQWQ1XmPOcvJROt4zasflpgX9ZSUM9+5E5+KCzZ1kNZj/ksUG1ZRv9cGxpItZO
	lOVwxjTg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rMwsv-006FM1-1g;
	Mon, 08 Jan 2024 21:10:13 +0000
Message-ID: <dd917333-9ae8-4e76-991d-39b6229ba8ce@infradead.org>
Date: Mon, 8 Jan 2024 13:10:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vram-helper: fix kernel-doc warnings
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
References: <20240106032957.1195-1-rdunlap@infradead.org>
 <944ca2e6-23d9-44a2-a58c-4380e9ee575f@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <944ca2e6-23d9-44a2-a58c-4380e9ee575f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 1/8/24 00:57, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for the fix.
> 
> Am 06.01.24 um 04:29 schrieb Randy Dunlap:
>> Remove the @funcs entry from struct drm_vram_mm to quieten the kernel-doc
>> warning.
>>
>> Use the "define" kernel-doc keyword and an '\' line continuation
>> to fix another kernel-doc warning.
>>
>> drm_gem_vram_helper.h:129: warning: missing initial short description on line:
>>   * DRM_GEM_VRAM_PLANE_HELPER_FUNCS -
>> drm_gem_vram_helper.h:185: warning: Excess struct member 'funcs' description in 'drm_vram_mm'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>> v2: Add commit description
>>
>> base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
>>
>>   include/drm/drm_gem_vram_helper.h |    3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff -- a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
>> --- a/include/drm/drm_gem_vram_helper.h
>> +++ b/include/drm/drm_gem_vram_helper.h
>> @@ -126,7 +126,7 @@ drm_gem_vram_plane_helper_cleanup_fb(str
>>                        struct drm_plane_state *old_state);
>>     /**
>> - * DRM_GEM_VRAM_PLANE_HELPER_FUNCS -
>> + * define DRM_GEM_VRAM_PLANE_HELPER_FUNCS - \
> 
> Did something change wrt. doc syntax? I think this used to work without warnings. About this 'define': we don't use is in another docs. Can we leave it out here or is this the new syntax?
> 

There are no doc syntax changes that I know of. This is not
new syntax. It has been around since 2014:
  cbb4d3e6510b ("scripts/kernel-doc: handle object-like macros")


"define OBJ_LIKE_MACRO" is used 2 other times in include/drm/:

drm_fb_helper.h:

/**
 * define DRM_FB_HELPER_DEFAULT_OPS - helper define for drm drivers
 *
 * Helper define to register default implementations of drm_fb_helper
 * functions. To be used in struct fb_ops of drm drivers.
 */

drm_gem_vram_helper.h: (the file being patched here)

/**
 * define DRM_GEM_VRAM_DRIVER - default callback functions for \
	&struct drm_driver
 *
 * Drivers that use VRAM MM and GEM VRAM can use this macro to initialize
 * &struct drm_driver with default functions.
 */


> 
>>    *    Initializes struct drm_plane_helper_funcs for VRAM handling
>>    *
>>    * Drivers may use GEM BOs as VRAM helpers for the framebuffer memory. This
>> @@ -170,7 +170,6 @@ void drm_gem_vram_simple_display_pipe_cl
>>    * @vram_base:    Base address of the managed video memory
>>    * @vram_size:    Size of the managed video memory in bytes
>>    * @bdev:    The TTM BO device.
>> - * @funcs:    TTM BO functions
>>    *
>>    * The fields &struct drm_vram_mm.vram_base and
>>    * &struct drm_vram_mm.vrm_size are managed by VRAM MM, but are
> 

-- 
#Randy

