Return-Path: <linux-kernel+bounces-69647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C6A858CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B13B211F7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A3171A4;
	Sat, 17 Feb 2024 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXfdGNXK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73350149E06
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133481; cv=none; b=bf27Cnhy24ATZgF/rSRjSmVJ+OqRNiuXXo02qXnauPKGnPVmj4Vq2C+yplylnwWKhEemE1B8XG7pmL3QT5DDKpEVK9+ULF0PwdWdvvVYK4f1NBvj4nywMpwMRb7ZtOdhfPJjz34z8m0LDm3Tzq1rMVhuGQ4XAQvLZGhaEydMQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133481; c=relaxed/simple;
	bh=FxZTiOnH28ta9w4qyeQlCyVM9g7hAjeN2oBcrxtUBCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVIcHLuuq56xEsHCstE6ombnazyxAJ0FPKYbHbEMMcxv34LMPje4eqN8GCmKC7CJ70aflm5k1sFuc+6PWY2jkVlv7jTG7Zt45mM5IB+UpqYxK0LFLPp+Cba29INXv/HUWZLfmQADOcAtBn8omXKeJ5+WlJH24B53JVI4XjSRiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aXfdGNXK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NVv3jtwrIr3uSH0TL3zX4hdOSOGZmVK7PYBdingjYrw=; b=aXfdGNXKG9dBi+YSFnau8+kxeZ
	pWjB04/AIlIJuH1vgHrQiuIF0ptiyg9HYMTQnktakyIMRR7eMOsOlpP3ClweoDmzY9MVAduKVcjS+
	QlOhK+7J1svCzQ86p4C9rz2L9PIcc7cFOTy1WUTMJDA5aQG7kfNxv8meLZCQk5u6oqC/tl1CSnW9G
	GEdDP8+OebsSHv6n8h7VEC1SmakH5N/iCL9SlDReZ7qSZR3fGeonOmeogyjtk47K7eYM6Zwa1HZPH
	7czHGcfpc09dfl5OpBQufNOEsMWNH9Ifwm1XsYWr1IGKGD2dUwVM2uk0Bfq0CsFXO2/5Cu0w+Genj
	N4kN1IrA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb9Xl-00000004Pfk-0nYR;
	Sat, 17 Feb 2024 01:31:06 +0000
Message-ID: <745e156e-c3ec-427f-98ad-bfc7d3cfd846@infradead.org>
Date: Fri, 16 Feb 2024 17:31:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tests/drm_buddy: avoid 64-bit calculation
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Gow <davidgow@google.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Matthew Auld <matthew.auld@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240216202442.2493031-1-arnd@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240216202442.2493031-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/16/24 12:24, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added drm_test_buddy_alloc_contiguous() test fails to link on
> 32-bit targets because of inadvertent 64-bit calculations:
> 
> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
> ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
> 
>>From what I can tell, the numbers cannot possibly overflow a 32-bit size,
> so use different types for these.
> 
> I noticed that the function has another possible flaw in that is mixes
> what it calls pages with 4KB units. This is a big confusing at best,
> or possibly broken when built on machines with larger pages.
> 
> Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/tests/drm_buddy_test.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
> index fee6bec757d1..50a5f98cd5bd 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -21,7 +21,8 @@ static inline u64 get_size(int order, u64 chunk_size)
>  
>  static void drm_test_buddy_alloc_contiguous(struct kunit *test)
>  {
> -	u64 mm_size, ps = SZ_4K, i, n_pages, total;
> +	u64 mm_size, total;
> +	u32 i, ps = SZ_4K, n_pages;
>  	struct drm_buddy_block *block;
>  	struct drm_buddy mm;
>  	LIST_HEAD(left);
> @@ -29,7 +30,8 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
>  	LIST_HEAD(right);
>  	LIST_HEAD(allocated);
>  
> -	mm_size = 16 * 3 * SZ_4K;
> +	n_pages = 16 * 3;
> +	mm_size = n_pages * SZ_4K;
>  
>  	KUNIT_EXPECT_FALSE(test, drm_buddy_init(&mm, mm_size, ps));
>  
> @@ -42,7 +44,6 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
>  	 */
>  
>  	i = 0;
> -	n_pages = mm_size / ps;
>  	do {
>  		struct list_head *list;
>  		int slot = i % 3;

-- 
#Randy

