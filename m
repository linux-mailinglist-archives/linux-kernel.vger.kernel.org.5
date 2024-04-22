Return-Path: <linux-kernel+bounces-153104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35F8AC923
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E5D28241E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E927824AB;
	Mon, 22 Apr 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkEa19zz"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27595612D3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778863; cv=none; b=ffXmkDIKhtea3HXCjRQIQs0jg7M61O+me0rPWHnb/AwWU6Zcl8zHAzYTmMr4J577S5DR50eN5DwzoI5S6ZUi766ZN4KJ9kyBmCykHZMwq7NoUlYnYu246K5qSV/3QIrH2VzG/A7j6OsaWkLWJEHfqtT02B23eMyuyIfLtsYlhKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778863; c=relaxed/simple;
	bh=ddtOLkDGYkROwfzr3deW6HyOq/O64HrOBt5WTUp5fN4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dknXuTfOzLV930yHnen5Nk5uFulKhVLXeGqgAe3l7M9QWkIEWBPbvF4IszouQ7MaxNhlc7paK91La0svDSXI52DNy3BP3rFDnUzP+MHkmgSfWxHoc+xiwzgRrfmNvS1qGzSvkQhNaRLJi1Jo1OrAqzv0CHRN3Py7h7VBSL9Lmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkEa19zz; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so43178501fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713778860; x=1714383660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qu3aaUrm0Jv/Mj1RDfmZwAvfXrnxdjakorfJLCcENIM=;
        b=mkEa19zzcSiHrMnSxCZ/10mPVjIWMpz1jERyWvR6YK2/0JG9JfqQVj9A5xWSV9rVjO
         jFVDvKU+kHMd/ssHSSoU7Vfc3a/jXVlsyqNImdccTFesWvi2JgzqYdNhAaRY6Kg2b8Kj
         uCd2ySAZHBkLxtV7+Y1OAPPGvXyAUqOxlgKfZU8dob3OAMgOqsPHTR/yToka4OYka04L
         QjPI8eWIwp3yFZgyPWk/dRN4UjyjLIsEmO+lHM19/cXANziB8ap4CJXU7sUnTMYhHmxk
         Vswt0mskTJEyzQnmuirI548aNKDaSDTog1EigwDaKCpLdoFn+Hm6zszmXqJRy3j4li4N
         v3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778860; x=1714383660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu3aaUrm0Jv/Mj1RDfmZwAvfXrnxdjakorfJLCcENIM=;
        b=tB5yd7zXyVKVkIAQKzwpRs1GGHjFmt5K4sguFdHNAWCyHDICX5sfQ+bIAidlKF6AQ0
         I6E5M4Zj14Lx5ItV3yOli/fyyClUsXhjzFQYL1RJt8b+mRPIu+ZqYFODZ8GGkC56QioC
         coVjOkzwimn8BM1LedOHr03DP4+hH7sjiCYeXJtXAzhQswrx6TM2mUyE1O8RvKhEJIlA
         L1cowSy9OjWNPtiqVwH9kxWR26KCBcKRm8aJfXLu99e4WM2ZhqrdtVchlfLS3D080tGR
         xomPiGGMRB5A7V4ZdMJVCCbcClmY+T+RYUNyWwHiKgusXItSBs6RKhCGE7mA2JvRCoI4
         yCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgS7y00WwGrsj8YRmPBBOlAB+DK2PsWQmr/bbtrMMSdKiL4Sn+OEgU3eDRWHfxtEQKhRcf4MKJ6az39L5TjhH4UzUIlCywcTHV9Rxq
X-Gm-Message-State: AOJu0YyKnXrWIW+U+6w7hTF6udZzP1/mBvr4fOXJPOeBfClvzHR7ZcWZ
	I3KgYxDope9rAN/26k3alHsG4SkhUPm25R7OfwlP+uwB3TkamIdD
X-Google-Smtp-Source: AGHT+IG1yzNMf6hm2/AYE3KaStcTYJzAoxPNHYX9L1xrtTQIdqBdTIJkDR6wqd+t8ltoHZdf8sv+JQ==
X-Received: by 2002:a2e:22c2:0:b0:2dd:d3a0:e096 with SMTP id i185-20020a2e22c2000000b002ddd3a0e096mr176187lji.31.1713778860112;
        Mon, 22 Apr 2024 02:41:00 -0700 (PDT)
Received: from pc636 (host-90-235-2-22.mobileonline.telia.com. [90.235.2.22])
        by smtp.gmail.com with ESMTPSA id l3-20020a2e9083000000b002da6fb7ce36sm1425059ljg.135.2024.04.22.02.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:40:59 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 22 Apr 2024 11:40:56 +0200
To: hailong.liu@oppo.com
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, 21cnbao@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix return value of vb_alloc if size
 is 0.
Message-ID: <ZiYwqBQCi-udlfLz@pc636>
References: <20240419101643.11534-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419101643.11534-1-hailong.liu@oppo.com>

On Fri, Apr 19, 2024 at 06:16:43PM +0800, hailong.liu@oppo.com wrote:
> From: "Hailong.Liu" <hailong.liu@oppo.com>
> 
> vm_map_ram check return value of vb_alloc by IS_ERR. if
> vm_map_ram(page, 0, 0) , vb_alloc(0, GFP_KERNEL) would return NULL
> which cause kernel panic by vmap_pages_range_noflush。fix this by
> return ERR_PTR(-EINVAL) if size is 0.
> 
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> ---
> Changes since v1 [1]:
> - Return ERR_PTR(-EINVAL) or not check IS_ERR_OR_NULL
> 
> BTW,  Barry suggests me that if count is 0, return directly, in my
> opinion, change return value is more resonable.
> 
> [1] https://lore.kernel.org/all/84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com/
> 
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a3fedb3ee0db..c430a999805b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2173,7 +2173,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
>  		 * get_order(0) returns funny result. Just warn and terminate
>  		 * early.
>  		 */
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  	order = get_order(size);
> 
> --
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

