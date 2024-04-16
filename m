Return-Path: <linux-kernel+bounces-147227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FF78A7145
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBF9282EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41307131E2A;
	Tue, 16 Apr 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POfCQfX6"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF312F387;
	Tue, 16 Apr 2024 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284538; cv=none; b=RWizx8qEd1Yqn5kHDTTE3ohdp25Qq0nzwtFvhfgvTGJXxeTeOgCH0yHCI1sDH9sQ2hDVvWl6j7OEpDjOG5K/QgrVUgECNDGqclJPLk+h6CTTk6WaDbU/AVhwG8n9GV+dLJq0zxWDqpVFK2yvt7EIevqqXkKHem6ADi2XfJapQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284538; c=relaxed/simple;
	bh=3tsLNEVapDlNuxJKNo8Pn4fLWw0VPKuZhgZOo6sHkA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wbk30wU35XDH/Dk9gKqjMvHjp7T/pPO26sTeUImLQD0G3tSa4p3zihfeynQLNJgwrzQeD2TAB41qxr/PwvBKgfWwNPaZNty2b31/K0PlPByMMoojyx2p6gsMYbdXA8tduxyaBONiAeQXc6c++Gqbr3F16ybzfpriCFvNy3pLmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POfCQfX6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecec796323so4777164b3a.3;
        Tue, 16 Apr 2024 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284536; x=1713889336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZ4By8kx0gFset4vqlanrt2cwjHe/0P230mvGWNMhPQ=;
        b=POfCQfX6/VKult/yrnXTW4MueKmp2LN2tnUkG3CcRvVjFIXxYqjGjz2K/Ablou+M1W
         9xYvRkKuFuUsgQZrRhFG9j5dFRcN/zrzEboyaNYtSnM5KAHux3eriZDHO+qDwLNNCa1Z
         lcDHIYgjPvRnRs11YS93SzjqF9ji+eMsOShyTdO/Ssi+x310mUB3jZl3fPvuhMhyEnTw
         N3Bun2YeOHX2uL43Eo0RgyWTsf9Yh8EHO3Syfx3tIpBE3WyVi6e4uZPOs8h/LqY2Kedc
         vvzTkxNfvgG99rm0hdJgCTWpBNvUAqm6SjZZo21BHb7+ti7YaP9aDOIrFOodm1rYAly/
         AbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284536; x=1713889336;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZ4By8kx0gFset4vqlanrt2cwjHe/0P230mvGWNMhPQ=;
        b=XxDm+yaJ/XdaYnPoGdjn79SSMl5SNMIIgF7TU4tXXXo5HH/ASlkd50yZPJyX6nuFPG
         rM1+C7IZlbPFVmrHYYXMONyqbOI5d/j+yiwgEJDG5DmXmx+CLoI5fWHYK9dp7nsenp5p
         iZe/aD5JORpFYmkZO+nMxcwaCoNFoi3dhIWl6wl6pSceOiV7klhzXQfRtVtLJDPv2qjD
         esR1blWDf+19fjLoCDRIGD6Cui5+w8wAxUjRn7E0zYCdOS7aGLepqdfbjbCVzyhlKnx9
         YAvq2L7c+2ChWtNVWTTqRUTuVVn+TBTNwv+rRXX4UBI0b8fAORTi+74etR8CKVYg/BtR
         ZkUA==
X-Forwarded-Encrypted: i=1; AJvYcCXkHRGBrOWHBi6jeGehHkHFbsEFAxi3gy1BblxNHAja4wtgV59UBrXnfqTRmY4h9NfuisiQeIuJPx5Oy6ySDds4KTXB/UeileM0j3GS
X-Gm-Message-State: AOJu0YzcQTaXpG1CFC7Gxx5Tu21Zv4N/slvTs1lDib5rb0TujEogriHL
	t2pcPd+Y9dVHKAGcGJkqFKvto4JgZ+jLBTSPm17tofjwE7hECLIK
X-Google-Smtp-Source: AGHT+IEUcecI89KJcxO4bdyAEaKuPOEWjzAq92Tsddkmk7lM8Dxh6sxfWs7GUP8/jFDeTzbXdw94fg==
X-Received: by 2002:a05:6a20:1a91:b0:1a7:802d:f67c with SMTP id ci17-20020a056a201a9100b001a7802df67cmr13606350pzb.53.1713284536293;
        Tue, 16 Apr 2024 09:22:16 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id q23-20020a631f57000000b005eb4d24e809sm9151661pgm.34.2024.04.16.09.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:22:15 -0700 (PDT)
Message-ID: <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Tue, 16 Apr 2024 09:22:14 -0700
In-Reply-To: <20240415131941.51153-10-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
	 <20240415131941.51153-10-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
> The '(PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)' case is for the
> system with page size less than 32KB, which is 0x8000 bytes
> requiring 16 bits space, change 'size' to 'size_mask' to avoid
> using the MSB, and change 'pfmemalloc' field to reuse the that
> MSB, so that we remove the orginal space needed by 'pfmemalloc'.
>=20
> For another case, the MSB of 'offset' is reused for 'pfmemalloc'.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/page_frag_cache.h | 13 ++++++++-----
>  mm/page_frag_cache.c            |  5 +++--
>  2 files changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index fe5faa80b6c3..40a7d6da9ef0 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -12,15 +12,16 @@ struct page_frag_cache {
>  	void *va;
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  	__u16 offset;
> -	__u16 size;
> +	__u16 size_mask:15;
> +	__u16 pfmemalloc:1;
>  #else
> -	__u32 offset;
> +	__u32 offset:31;
> +	__u32 pfmemalloc:1;
>  #endif

This seems like a really bad idea. Using a bit-field like this seems
like a waste as it means that all the accesses now have to add
additional operations to access either offset or size. It wasn't as if
this is an oversized struct, or one that we are allocating a ton of. As
such I am not sure why we need to optmize for size like this.

>  	/* we maintain a pagecount bias, so that we dont dirty cache line
>  	 * containing page->_refcount every time we allocate a fragment.
>  	 */
>  	unsigned int		pagecnt_bias;
> -	bool pfmemalloc;
>  };
> =20
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
> @@ -43,7 +44,9 @@ static inline void *__page_frag_alloc_va_align(struct p=
age_frag_cache *nc,
>  					       gfp_t gfp_mask,
>  					       unsigned int align)
>  {
> -	nc->offset =3D ALIGN(nc->offset, align);
> +	unsigned int offset =3D nc->offset;
> +
> +	nc->offset =3D ALIGN(offset, align);
> =20
>  	return page_frag_alloc_va(nc, fragsz, gfp_mask);
>  }
> @@ -53,7 +56,7 @@ static inline void *page_frag_alloc_va_align(struct pag=
e_frag_cache *nc,
>  					     gfp_t gfp_mask,
>  					     unsigned int align)
>  {
> -	WARN_ON_ONCE(!is_power_of_2(align));
> +	WARN_ON_ONCE(!is_power_of_2(align) || align >=3D PAGE_SIZE);

The "align >=3D PAGE_SIZE" fix should probably go with your change that
reversed the direction.

> =20
>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);
>  }
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 50511d8522d0..8d93029116e1 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -32,7 +32,8 @@ static struct page *__page_frag_cache_refill(struct pag=
e_frag_cache *nc,
>  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>  	page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>  				PAGE_FRAG_CACHE_MAX_ORDER);
> -	nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
> +	nc->size_mask =3D page ? PAGE_FRAG_CACHE_MAX_SIZE - 1 : PAGE_SIZE - 1;
> +	VM_BUG_ON(page && nc->size_mask !=3D PAGE_FRAG_CACHE_MAX_SIZE - 1);
>  #endif
>  	if (unlikely(!page))
>  		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> @@ -86,7 +87,7 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, un=
signed int fragsz,
> =20
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  	/* if size can vary use size else just use PAGE_SIZE */
> -	size =3D nc->size;
> +	size =3D nc->size_mask + 1;
>  #else
>  	size =3D PAGE_SIZE;
>  #endif

So now we are having to add arithmetic operations to the size in
addition having to mask in order to read the values. That just seems
like that much more overhead.


