Return-Path: <linux-kernel+bounces-99771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD8878D05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D31B21BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9E79C0;
	Tue, 12 Mar 2024 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="wBZU+ozW"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998520E3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211003; cv=none; b=EXJnZGzeseG38f5B84PawHB102BgSeqQHvI2BAUCgnc+jbS5Zfakc6eV7+7LMzrfJXi/FeismnLNdRrzESIpgo/0Fl2HbZikncQ/TXSqbvy7seB8w/eYYCMmIp168NCTgWwPZFKPAqIfzhaftZ5vzq2cSLZiyLYZujndkHH98es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211003; c=relaxed/simple;
	bh=Gdd+zajJulG0ORxaVzYBG0oetiP7BkALJrNr7JAZjN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNQT0V+UI9p8OXhPaMjDcjWijfgnVsLv+V6Nf6958IyyRj3GaQnuCjpuTiDiP5t/94MHB3yHdJBhid95MjKXgBGqxYjYJ7mhFXpMXNDMyuYEeWJcWCMtvWhRWVd72dZKK9n7JiGDqyRGsS7flK9DlCkBlbGM0xFNNvCXwS/cDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=wBZU+ozW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42ee23c64e3so20938261cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710210999; x=1710815799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K01nQ8DIaiGmIiyDCqQC8SVy7y5ZZ+8vaXt2Ag8RG2Y=;
        b=wBZU+ozWGuzS67dEU/9g3kzG7Tk89OKPz+3Oq6J4TtOfNg6NJAbZaRbVEjiDQ6jKL8
         wJEcaYrkt9kQCnIQhO+Z/Q9qdr4H4ksTBaZbliCqs8SdgWHf9zkePBvsIhoMd9a5Mi4g
         OKvZx7dAw433A6KV6COx4uaQxfTsmx3ppkK98X98vd40S+SQaXiaRo7rAKWPu+hr6rWN
         E5290QLIymOMF8lIYYb1SLvYaUKSpYxTz/7w1DbIXbIIu7IstbM/w1gKdZimnMYuwpia
         JO5s0cPlOBIlE8riKbwqBjOfDHILFDM2Az+g+VMPFbsRo817xq3B207h1I+6QImVvln6
         wvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710210999; x=1710815799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K01nQ8DIaiGmIiyDCqQC8SVy7y5ZZ+8vaXt2Ag8RG2Y=;
        b=lslRlFCPhYkYd6GapGLIl5+dV021nG2QBxDfI+Xf8mSItqnpkpZwrOQkNh+2hlZAMt
         nwH+HESvnb7hHKvf2ldHOOblErJb6q5kwFMglgLtTHgGpR6VQU8E2wcpS5A2N/uKKbNL
         fVcEZYTCRMFCSuY1ruZ3Y+ftZwU/g2ijDafRuL1oRsRwJpMfs0A88/p8w9/hZg39B1aw
         kSqUEir7Eh427AvxdpdXJCI8blO+7hoQlTAi9rrkQijjaUwY/dx8ZxW0kYUCpEWPoy5q
         7Y+Qli6nrLSeG2w4EDrpPFE0yFGCFnuy/K6+Ri/tzuWpbObnjSb87fUd9y6L8Kr7GwZi
         O50Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYKoAwhSeNHrJSx49yctT+FkmDbVuGJ5P9X5AATpiDWH5vUkdyTOeltPQOaeRhZr4ZEG0fHvdpmDkyWH84XFZ9D1iEHcu6MIyhVSC1
X-Gm-Message-State: AOJu0YwmXE5iTD0I6Zy1C8Q8kRTmXNfuUWUY9qX7eBa3vqRnO8aCpbyz
	zriVYNcpe2foLLBzcP1g6NvG6rs5mUOd5lvjnPMa9HP1+0BmNwnDLNcyw/1Z7ig=
X-Google-Smtp-Source: AGHT+IEpsc3fV9NXOfuMsUXLPJ2BERGjxUodmtZHiuVJtpKYsGq1lBjaWLpfsfpPJ0y1Cqv4EKfsiw==
X-Received: by 2002:ac8:5f0b:0:b0:42e:8cc9:84de with SMTP id x11-20020ac85f0b000000b0042e8cc984demr10885874qta.62.1710210998891;
        Mon, 11 Mar 2024 19:36:38 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id jr18-20020a05622a801200b0042f01e612bbsm3294324qtb.37.2024.03.11.19.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 19:36:38 -0700 (PDT)
Date: Mon, 11 Mar 2024 22:36:37 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: zpool: return pool size in pages
Message-ID: <20240312023637.GB22705@cmpxchg.org>
References: <20240311161214.1145168-1-hannes@cmpxchg.org>
 <20240311161214.1145168-2-hannes@cmpxchg.org>
 <Ze-Bsr8lfC1lm1u7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze-Bsr8lfC1lm1u7@google.com>

On Mon, Mar 11, 2024 at 10:12:02PM +0000, Yosry Ahmed wrote:
> On Mon, Mar 11, 2024 at 12:12:14PM -0400, Johannes Weiner wrote:
> > All zswap backends track their pool sizes in pages. Currently they
> > multiply by PAGE_SIZE for zswap, only for zswap to divide again in
> > order to do limit math. Report pages directly.
> 
> Nice. Although I would prefer renaming the zpool interface to
> total_pages and renaming the zpool backends functions as well to use
> pages rather than size.

Ha, I was on the fence, since it's kind of churny. But if you don't
mind, then it works for me as well.

> Either way:
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks.

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 3296438eec06..a67d62b79698 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -53,7 +53,7 @@ void *zpool_map_handle(struct zpool *pool, unsigned long handle,
 
 void zpool_unmap_handle(struct zpool *pool, unsigned long handle);
 
-u64 zpool_get_total_size(struct zpool *pool);
+u64 zpool_get_total_pages(struct zpool *pool);
 
 
 /**
@@ -91,7 +91,7 @@ struct zpool_driver {
 				enum zpool_mapmode mm);
 	void (*unmap)(void *pool, unsigned long handle);
 
-	u64 (*total_size)(void *pool);
+	u64 (*total_pages)(void *pool);
 };
 
 void zpool_register_driver(struct zpool_driver *driver);
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 9bacacd4168c..2ebfed32871b 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1237,12 +1237,12 @@ static void z3fold_unmap(struct z3fold_pool *pool, unsigned long handle)
 }
 
 /**
- * z3fold_get_pool_size() - gets the z3fold pool size in pages
+ * z3fold_get_pool_pages() - gets the z3fold pool size in pages
  * @pool:	pool whose size is being queried
  *
  * Returns: size in pages of the given pool.
  */
-static u64 z3fold_get_pool_size(struct z3fold_pool *pool)
+static u64 z3fold_get_pool_pages(struct z3fold_pool *pool)
 {
 	return atomic64_read(&pool->pages_nr);
 }
@@ -1402,9 +1402,9 @@ static void z3fold_zpool_unmap(void *pool, unsigned long handle)
 	z3fold_unmap(pool, handle);
 }
 
-static u64 z3fold_zpool_total_size(void *pool)
+static u64 z3fold_zpool_total_pages(void *pool)
 {
-	return z3fold_get_pool_size(pool);
+	return z3fold_get_pool_pages(pool);
 }
 
 static struct zpool_driver z3fold_zpool_driver = {
@@ -1417,7 +1417,7 @@ static struct zpool_driver z3fold_zpool_driver = {
 	.free =		z3fold_zpool_free,
 	.map =		z3fold_zpool_map,
 	.unmap =	z3fold_zpool_unmap,
-	.total_size =	z3fold_zpool_total_size,
+	.total_pages =	z3fold_zpool_total_pages,
 };
 
 MODULE_ALIAS("zpool-z3fold");
diff --git a/mm/zbud.c b/mm/zbud.c
index b7d8a22bbf5f..e9836fff9438 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -365,13 +365,13 @@ static void zbud_unmap(struct zbud_pool *pool, unsigned long handle)
 }
 
 /**
- * zbud_get_pool_size() - gets the zbud pool size in pages
+ * zbud_get_pool_pages() - gets the zbud pool size in pages
  * @pool:	pool whose size is being queried
  *
  * Returns: size in pages of the given pool.  The pool lock need not be
  * taken to access pages_nr.
  */
-static u64 zbud_get_pool_size(struct zbud_pool *pool)
+static u64 zbud_get_pool_pages(struct zbud_pool *pool)
 {
 	return pool->pages_nr;
 }
@@ -410,9 +410,9 @@ static void zbud_zpool_unmap(void *pool, unsigned long handle)
 	zbud_unmap(pool, handle);
 }
 
-static u64 zbud_zpool_total_size(void *pool)
+static u64 zbud_zpool_total_pages(void *pool)
 {
-	return zbud_get_pool_size(pool);
+	return zbud_get_pool_pages(pool);
 }
 
 static struct zpool_driver zbud_zpool_driver = {
@@ -425,7 +425,7 @@ static struct zpool_driver zbud_zpool_driver = {
 	.free =		zbud_zpool_free,
 	.map =		zbud_zpool_map,
 	.unmap =	zbud_zpool_unmap,
-	.total_size =	zbud_zpool_total_size,
+	.total_pages =	zbud_zpool_total_pages,
 };
 
 MODULE_ALIAS("zpool-zbud");
diff --git a/mm/zpool.c b/mm/zpool.c
index 410808aee7fe..b9fda1fa857d 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -321,16 +321,16 @@ void zpool_unmap_handle(struct zpool *zpool, unsigned long handle)
 }
 
 /**
- * zpool_get_total_size() - The total size of the pool
+ * zpool_get_total_pages() - The total size of the pool
  * @zpool:	The zpool to check
  *
  * This returns the total size in pages of the pool.
  *
  * Returns: Total size of the zpool in pages.
  */
-u64 zpool_get_total_size(struct zpool *zpool)
+u64 zpool_get_total_pages(struct zpool *zpool)
 {
-	return zpool->driver->total_size(zpool->pool);
+	return zpool->driver->total_pages(zpool->pool);
 }
 
 /**
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 398f3856817f..b42d3545ca85 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -399,7 +399,7 @@ static void zs_zpool_unmap(void *pool, unsigned long handle)
 	zs_unmap_object(pool, handle);
 }
 
-static u64 zs_zpool_total_size(void *pool)
+static u64 zs_zpool_total_pages(void *pool)
 {
 	return zs_get_total_pages(pool);
 }
@@ -414,7 +414,7 @@ static struct zpool_driver zs_zpool_driver = {
 	.free =			  zs_zpool_free,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
-	.total_size =		  zs_zpool_total_size,
+	.total_pages =		  zs_zpool_total_pages,
 };
 
 MODULE_ALIAS("zpool-zsmalloc");
diff --git a/mm/zswap.c b/mm/zswap.c
index 7ed79caf1e1e..9fdf4c76d5ea 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -519,7 +519,7 @@ unsigned long zswap_total_pages(void)
 		int i;
 
 		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
-			total += zpool_get_total_size(pool->zpools[i]);
+			total += zpool_get_total_pages(pool->zpools[i]);
 	}
 	rcu_read_unlock();
 

