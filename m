Return-Path: <linux-kernel+bounces-146902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1728A6CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6689285996
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D00812D1F6;
	Tue, 16 Apr 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OalHhhcO"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0FA12C49C;
	Tue, 16 Apr 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274905; cv=none; b=JA/+8IZlLDp3N5nO4IzT8vzYvXLwiEphObuS41kiAr19qfNUtC9irB6kkuMEX4l9Fwk0qhJ3SWbOfGd9/75mYNiLH/IOPxy6EGm9H9hMsrloFWCT2tucJ5qYmS/03F1B6e7Ds5y83QJDwcUQ/7R/scW88YRBw77jd2ZhcZtqp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274905; c=relaxed/simple;
	bh=mlHs6QzBIrebN5ZtLrtM3o05naLgvR/CY21bo4bIndQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEB0DGiSsJS3yKhzyRbI5uc2s51shMluc/qlyEJAy2X7g74uQHt9Pvbj6+aPcs3BYYXKGNVk4shrZpJWNgngqPGYnvLgKCrQJi7zSWWS8GiS2bOGVa+PPVX8rzTSfcBzLTzGn+YcwrQEANgj8VNyZwhN+89jdCVvssZB5e9X8Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OalHhhcO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-570441bc23bso849827a12.0;
        Tue, 16 Apr 2024 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713274902; x=1713879702; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wMSwIbSW3/LmnCJZAsPzybV/yi2Pk1y2NoQeMM1hTA=;
        b=OalHhhcOoo12J9rmHQce8jdGpoOsxmovWkOjnXEU9NoT7LxMGOIfdSYFWUWjZW1+cq
         kdsPaqB+qWtWmn89XJ0yaC5u0lppbyZLAg7uvqU6drfN8u5vv5s2f2nCcjzRuJFKSWAb
         CcCHsgP212+fal6v3cLzpmCzD+gzgIJv3PrJNzHYtjRLc7snAlJrnvDPdQLrJEohoz4S
         9nk6otof/vhhWxXj1ruMTIrSn8Wq03wLGyEAalOZqDr4bDzLVlS0VA8ImTnh9AT0Borr
         vu9WN4gRR9OTPo1EaVZvuAHNO1RXkm1vSb8qCKe+3ojrH0NVDrPTAzYWSDhRNO9Mi5hK
         3a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274902; x=1713879702;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wMSwIbSW3/LmnCJZAsPzybV/yi2Pk1y2NoQeMM1hTA=;
        b=PksC/n2RqgRNMrTbXEPmOOetfkDHv5mTu+RuAaCS9mNy170cz2saT3Mz4j9FPOzFlj
         ioih4sefU0eWb25F1CHtHO0izd4MgdSK5kT9N4BO4ut11sE6JqKakW0L2lf3vtzHt4Et
         v3gLmjTkHhVE8djMaqAj+vUOJDGB2XweuDoKzITjeHMxDxxqgs7cF9COfdDFycTOIot9
         7AQyIV4N3Od2VMIqFrDLbAqcxukAkRA199NMgE1gCDf2pK35LCylI8miNIdcdiSxg1KD
         MbWYaIek9Hkemfm4DbVk/lfkD2QXeRTeAiJ3xEvEe5hwhiHn40NzUGbWeQ28Y+BEZrof
         mwqg==
X-Forwarded-Encrypted: i=1; AJvYcCX8vxvnfzE9MjWUb7mpGvpxhS3o0OGu68xQlIA8sNW/1R9WA/jktnIFia9/yg8HYupTNza2Ck9Csn9S5gdLTQ7xRUCp5cs8LcvgfTjFcT4KCH0ecpaykMwt8jikUPDk1zh1o38FUdTJDg==
X-Gm-Message-State: AOJu0YzLvORHNangf3v4Gt6GPvutYIwWrBZ0vbAXWhH4R+N1KZLELyKH
	Qkk3MoNDHJqd50nm/j794W1NyJ18INW9vATqKcT86wPBhYBLLZsx
X-Google-Smtp-Source: AGHT+IH55Cj6jpywIj2+Z8nl0guBr3BgBcMbTvEldRSOojc2nQ/kvumL0NhllI05uFLNwb2pnN57DQ==
X-Received: by 2002:a50:9544:0:b0:566:777:af4f with SMTP id v4-20020a509544000000b005660777af4fmr8670914eda.1.1713274901962;
        Tue, 16 Apr 2024 06:41:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k20-20020aa7c054000000b0056ff82e54a0sm5421225edo.31.2024.04.16.06.41.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2024 06:41:41 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:41:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: skseofh@gmail.com
Cc: robh@kernel.org, saravanak@google.com, rppt@kernel.org,
	akpm@linux-foundation.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH] memblock: add no-map alloc functions
Message-ID: <20240416134141.gnkjj223qlxk6dhr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240415142448.333271-1-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415142448.333271-1-skseofh@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Apr 15, 2024 at 11:24:48PM +0900, skseofh@gmail.com wrote:
>From: Daero Lee <daero_le.lee@samsung.com>
>
>Like reserved-memory with the no-map property, there are memory regions
>need to be allocated in memblock.memory marked with the
>MEMBLOCK_NOMAP flag, but sholud not be allocated in memblock.reserved.
>
>So, functions were added that find the required memory area in
>memblock.memory, but do not allocate it to memblock.reserved.
>
>The early_init_dt_alloc_reserved_memory_arch function was modified
>using the no-map alloc function.
>
>Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
>---
> drivers/of/of_reserved_mem.c |  9 +++--
> mm/memblock.c                | 78 ++++++++++++++++++++++++++++++++++++
> 2 files changed, 84 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>index 8236ecae2953..504f2f60689c 100644
>--- a/drivers/of/of_reserved_mem.c
>+++ b/drivers/of/of_reserved_mem.c
>@@ -40,15 +40,18 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
> 
> 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
> 	align = !align ? SMP_CACHE_BYTES : align;
>-	base = memblock_phys_alloc_range(size, align, start, end);
>+	if (nomap) {
>+		base = memblock_phys_alloc_range_nomap(size, align, start, end);
>+	} else {
>+		base = memblock_phys_alloc_range(size, align, start, end);
>+	}
>+	
> 	if (!base)
> 		return -ENOMEM;
> 
> 	*res_base = base;
> 	if (nomap) {
> 		err = memblock_mark_nomap(base, size);
>-		if (err)
>-			memblock_phys_free(base, size);
> 	}
> 
> 	kmemleak_ignore_phys(base);
>diff --git a/mm/memblock.c b/mm/memblock.c
>index d09136e040d3..f103f1ecbfad 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -1506,6 +1506,72 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> 	return found;
> }
> 
>+phys_addr_t __init memblock_alloc_range_nid_nomap(phys_addr_t size,
>+                                        phys_addr_t align, phys_addr_t start,
>+                                        phys_addr_t end, int nid,
>+                                        bool exact_nid)
>+{
>+        enum memblock_flags flags = choose_memblock_flags();
>+        phys_addr_t found;
>+
>+        if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
>+                nid = NUMA_NO_NODE;
>+
>+        if (!align) {
>+                /* Can't use WARNs this early in boot on powerpc */
>+                dump_stack();
>+                align = SMP_CACHE_BYTES;
>+        }
>+
>+again:
>+        found = memblock_find_in_range_node(size, align, start, end, nid,
>+                                            flags);
>+        if (found)
>+                goto done;

Only find without reserve has no effect on memblock meta data. It seems run
but nothing happens.

What you want to achieve for this function?

-- 
Wei Yang
Help you, Help me

