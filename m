Return-Path: <linux-kernel+bounces-58539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A5484E7CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288371C23CCE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB61DFE3;
	Thu,  8 Feb 2024 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="BGxokrw4"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06817C65
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417593; cv=none; b=JVzJQ7K0HQmG9SYZybJHRGukoPd5rQ/m1CIje0Rela9ZCDAU6JXqjpOs6SCaBN4HeVE78H7W5x5Glaxs8C/CAYEosO5EYaBJ5ogm9KUBHrlJ1TmN4DrvVasyk1oFj7zs5fv96+++hrHFVfKBu+KRlsuIViB95aIAn2kR3zMkyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417593; c=relaxed/simple;
	bh=cExa9pFGsIvshdV/Cw2q3IgMDvj8o9AxMzJ5sxbUNi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxFyf8LGUhQlkR2/Rxxkj1s3HgMOL7tX7k6g+QKqhqYXZ3fY+1AwGz+6efBNnh2HMrjluMWrYfVrCkN7u1id9eTaZcrjNU5GaMlPuNsQ2f6PVo67sDAf5LXNGxWUxV6hI6jfOjLlmKZMI12B0He1F1NPGAenMTzphmVuIhXgfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=BGxokrw4; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id Y6o0r8VVS8uLRY9JJrAaBB; Thu, 08 Feb 2024 18:39:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Y9JIrio7IYqClY9JJrmZTV; Thu, 08 Feb 2024 18:39:45 +0000
X-Authority-Analysis: v=2.4 cv=YPk8ygGx c=1 sm=1 tr=0 ts=65c51ff1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=7YfXLusrAAAA:8 a=T15muJCMmG92BHH_wWsA:9 a=QEXdDO2ut3YA:10 a=9cHFzqQdt-sA:10
 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5xlR+PchHqlP/opq6mXiFMNRonuQZr3pt2zbgzQpycs=; b=BGxokrw4FW8DcMHK4jGi7CMrdL
	J8+Qy8SmgTyBsDsIiFqT2RNVrmqOVPE6ovpC/3s9S0dOq52p4MFSXU9cvy3nhqcVNZhebJURVylwc
	LhwcpL23/WedIYeMqT1g+S8lPRtOQ2dawlrMDKwIFG02sDRJfYQrI4KBDMUlVzJtk2J4+LUtZ1yZl
	1WtkZaT6LEkD2MWikvIQNkbc/3pkxuNkP/J1bLdgaYv+nsupDznhTZ1mZHh8CxDKB6Hm9FDk8Fs3V
	AktZpXttMw3E7NlajwisQoiW3HfzW+cPHAPwMERYxWGw0S7/puyujrR2L4UeIRvSrqhH8RPw+Lf11
	VDmbW0ow==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56476 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rY9JH-003Uke-1E;
	Thu, 08 Feb 2024 12:39:43 -0600
Message-ID: <cd710b96-d295-4b2e-8af7-58b5d3f3c1f1@embeddedor.com>
Date: Thu, 8 Feb 2024 12:39:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: Add flex arrays to struct i915_syncmap
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240208181318.4259-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240208181318.4259-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rY9JH-003Uke-1E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:56476
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDkoT8qrOTYJc8uR1nMlU76inBxT0SgH1NIuUN10rDbWK6TBri5TBI+c4Ix6S9AkxUtDm3EVNyz8SMxJLQL2iKVGHz5HVt7eu1HD/ub7XwGYtAun5RJf
 yFJUMQsKg1JK1eLWhwNWlfPMqzGb7oz+CQVbP4pGNodupU2rDTPqjluszRIkTG88etlgdKoekIVun5JOnmGs1tZ42YR/a4sU3OkNzH1BTWNG4Ivz/1wJzKwH



On 2/8/24 12:13, Erick Archer wrote:
> The "struct i915_syncmap" uses a dynamically sized set of trailing
> elements. It can use an "u32" array or a "struct i915_syncmap *"
> array.
> 
> So, use the preferred way in the kernel declaring flexible arrays [1].
> Because there are two possibilities for the trailing arrays, it is
> necessary to declare a union and use the DECLARE_FLEX_ARRAY macro.
> 
> The comment can be removed as the union is now clear enough.
> 
> Also, avoid the open-coded arithmetic in the memory allocator functions
> [2] using the "struct_size" macro.
> 
> Moreover, refactor the "__sync_seqno" and "__sync_child" functions due
> to now it is possible to use the union members added to the structure.
> This way, it is also possible to avoid the open-coded arithmetic in
> pointers.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Nice transformation!

LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/gpu/drm/i915/i915_syncmap.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_syncmap.c b/drivers/gpu/drm/i915/i915_syncmap.c
> index 60404dbb2e9f..df6437c37373 100644
> --- a/drivers/gpu/drm/i915/i915_syncmap.c
> +++ b/drivers/gpu/drm/i915/i915_syncmap.c
> @@ -75,13 +75,10 @@ struct i915_syncmap {
>   	unsigned int height;
>   	unsigned int bitmap;
>   	struct i915_syncmap *parent;
> -	/*
> -	 * Following this header is an array of either seqno or child pointers:
> -	 * union {
> -	 *	u32 seqno[KSYNCMAP];
> -	 *	struct i915_syncmap *child[KSYNCMAP];
> -	 * };
> -	 */
> +	union {
> +		DECLARE_FLEX_ARRAY(u32, seqno);
> +		DECLARE_FLEX_ARRAY(struct i915_syncmap *, child);
> +	};
>   };
> 
>   /**
> @@ -99,13 +96,13 @@ void i915_syncmap_init(struct i915_syncmap **root)
>   static inline u32 *__sync_seqno(struct i915_syncmap *p)
>   {
>   	GEM_BUG_ON(p->height);
> -	return (u32 *)(p + 1);
> +	return p->seqno;
>   }
> 
>   static inline struct i915_syncmap **__sync_child(struct i915_syncmap *p)
>   {
>   	GEM_BUG_ON(!p->height);
> -	return (struct i915_syncmap **)(p + 1);
> +	return p->child;
>   }
> 
>   static inline unsigned int
> @@ -200,7 +197,7 @@ __sync_alloc_leaf(struct i915_syncmap *parent, u64 id)
>   {
>   	struct i915_syncmap *p;
> 
> -	p = kmalloc(sizeof(*p) + KSYNCMAP * sizeof(u32), GFP_KERNEL);
> +	p = kmalloc(struct_size(p, seqno, KSYNCMAP), GFP_KERNEL);
>   	if (unlikely(!p))
>   		return NULL;
> 
> @@ -282,7 +279,7 @@ static noinline int __sync_set(struct i915_syncmap **root, u64 id, u32 seqno)
>   			unsigned int above;
> 
>   			/* Insert a join above the current layer */
> -			next = kzalloc(sizeof(*next) + KSYNCMAP * sizeof(next),
> +			next = kzalloc(struct_size(next, child, KSYNCMAP),
>   				       GFP_KERNEL);
>   			if (unlikely(!next))
>   				return -ENOMEM;
> --
> 2.25.1
> 
> 

