Return-Path: <linux-kernel+bounces-68232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507808577A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749C71C20B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423FE1BC31;
	Fri, 16 Feb 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEYb7qdo"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CCD1BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071826; cv=none; b=jRApEb+FOi4AsGkhUzj00HVQVxfDKHgIHfUI+YM2VGOYntRe9ZDl2zAwxZNzCXvkJXQ89vvOEQ48zLzsn7garc+J3hDRsHyL2eqoeZfunQEjQa7ooo/DGtezJAhA8MetOreZwGxKPCnT591Y1lxU2BRXgGFIaf6e+XQ5dhzH6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071826; c=relaxed/simple;
	bh=/YU8wPy6htQXhtEo0ZOksTeDFzsfjlucj2sGQl8fOec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K3mih4xwihXD3HioOTAbClqPcYHhVEjMU3W+qBxJlwCnAHac7tnALjGk6MMenalCDPp8AeetJjX7+87g0/ZswAGv/XZzp/M5itmiUW4e/9Z0JJbzgXujMygL1mN8aR0EDfgrOUGtxbvGdH/5cym0LEDPcCt7yaXOR8qyEO4Puqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEYb7qdo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so2556847276.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708071823; x=1708676623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cpboLvwYV1ox8Ee0Bm43oOxioTzCNQFdquzOlljEVBo=;
        b=jEYb7qdovMHLfLDlCMjBtfEMXvhUMBWxuLGYsOuRTvbVMthQRKYF86Xy4YDJQbR+B8
         GuFNcz9kPOGZASqTC4hhnqXtVtGZGtlO8FiY9fRZQ+7HyaztWYArfGY4X5pTDpUN+sce
         X3F1IoYk0yMKzMNgPPUYh4zDZYLEfr9/8SvjkVUgzsI51gP6yXjgumYdxa7acNBf0up0
         MtSpHweELgs84TkbBO0qhnh1BxFZ8iIzUyxEPBrBT4XBiiLTww5+EkDNV52F63657qTk
         XZZ4RZ9/Qyq0vVHDoJeek0BsFyqN95K2xlrab4LJOYSW4ntwxxekibn3C/B995shp5Ww
         +eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071823; x=1708676623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpboLvwYV1ox8Ee0Bm43oOxioTzCNQFdquzOlljEVBo=;
        b=LrEgYYBeJSRyBg9M9tb3nbo6sVeyiRZjw2Z0EbrhmSDWL9+XwrCxRu1y/Nl5GQpVgO
         syjcvp1yyX0tPuvO0KRLaD+0d2xBeJmvSx2e3X4lrHgzb6rjqMzB142kBeKwaLOkVmuR
         zKJAtIjSN1loITBfG6ubJ91p8EizfSHg/AIw6ZLmEJg36F7p+nZpbS/cAC0YuVDKDJJ9
         +kMEtPv2naTL+QyJKS4xudbpI7EmVq0Hdsq99Il1WfRmnDuvIViHfJb3snDRdVF9uI32
         szx+riye5dC2pHOjF+hrVmrfCRLOWb1GqYSvJXdfGOiFOSYRfG5rkXaw+lp+nyAUOvNP
         FRqw==
X-Forwarded-Encrypted: i=1; AJvYcCVwh8hgV2tT9+bVtNaRWWYWLguR6ZEixhfRoozXcqzLFp0U2yt2F58bYAsFHzkNMaLsYz171pvrWsME1DjPz6zkbRt5AApZJxzNwyF1
X-Gm-Message-State: AOJu0YxRCntBxHwYXf7Lu6bh/nCnrB59JTLx07Kcfid7uN8shxo8Q5YX
	kEh47NhHjQJWjf7xVD+YLFh8w0O6vz3zhLPlMTUdtkJKZa+OMNA85xnwSPxqJFRHxdZsCM79k4L
	GSedfsRzVi9Skeo+7aQ==
X-Google-Smtp-Source: AGHT+IE4tgX/rUS+/TwE2zBSAdB+ueElmLAdUjIOr92xa74Jtl7sq2Hhmui1AbwR6jxjAIq6SYE+53ma7H94HCqh
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:f0d:b0:dc6:deca:8122 with SMTP
 id et13-20020a0569020f0d00b00dc6deca8122mr1355861ybb.5.1708071823798; Fri, 16
 Feb 2024 00:23:43 -0800 (PST)
Date: Fri, 16 Feb 2024 08:23:41 +0000
In-Reply-To: <20240216030539.110404-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216030539.110404-1-21cnbao@gmail.com>
Message-ID: <Zc8bjZFZAZneObQG@google.com>
Subject: Re: [PATCH] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
From: Yosry Ahmed <yosryahmed@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 16, 2024 at 04:05:39PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> My commit fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINVAL
> in zs_malloc while size is too large") wanted to depend on zs_malloc's
> returned ENOSPC to distinguish the case that compressed data is larger
> than the original data from normal compression cases. The commit, for
> sure, was correct and worked as expected but the code wouldn't run to
> there after commit 744e1885922a ("crypto: scomp - fix req->dst buffer
> overflow") as Chengming's this patch makes zswap_store() goto out
> immediately after the special compression case happens. So there is
> no chance to execute zs_malloc() now. We need to fix the count right
> after compressions return ENOSPC.
> 
> Fixes: fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINVAL in zs_malloc while size is too large")

I don't see how this is a fix for that commit. Commit fc8580edbaa6 made
sure zsmalloc returns a correct errno when the compressed size is too
large. The fact that zswap stores were failing before calling into
zsmalloc and not reporting the error correctly in debug counters is not
that commits fault.

I think the proper fixes should be 744e1885922a if it introduced the
first scenario where -ENOSPC can be returned from scomp without handling
it properly in zswap. If -ENOSPC was a possible return value before
that, then it should be cb61dad80fdc ("zswap: export compression failure
stats"), where the counter was introduced.

> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/zswap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6319d2281020..9a21dbe8c056 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1627,7 +1627,10 @@ bool zswap_store(struct folio *folio)
>  	dlen = acomp_ctx->req->dlen;
>  
>  	if (ret) {
> -		zswap_reject_compress_fail++;
> +		if (ret == -ENOSPC)
> +			zswap_reject_compress_poor++;
> +		else
> +			zswap_reject_compress_fail++;

With this diff, we have four locations in zswap_store() where we
increment zswap_reject_compress_{poor/fail}.

How about the following instead?A

diff --git a/mm/zswap.c b/mm/zswap.c
index 62fe307521c93..3a7e8ba7f6116 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1059,24 +1059,16 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	 */
 	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
-	if (ret) {
-		zswap_reject_compress_fail++;
+	if (ret)
 		goto unlock;
-	}

 	zpool = zswap_find_zpool(entry);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
 	ret = zpool_malloc(zpool, dlen, gfp, &handle);
-	if (ret == -ENOSPC) {
-		zswap_reject_compress_poor++;
-		goto unlock;
-	}
-	if (ret) {
-		zswap_reject_alloc_fail++;
+	if (ret)
 		goto unlock;
-	}

 	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, dst, dlen);
@@ -1086,6 +1078,10 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	entry->length = dlen;

 unlock:
+	if (ret == -ENOSPC)
+		zswap_reject_compress_poor++;
+	else if (ret)
+		zswap_reject_alloc_fail++;
 	mutex_unlock(&acomp_ctx->mutex);
 	return ret == 0;
 }

>  		goto put_dstmem;
>  	}
>  
> -- 
> 2.34.1
> 

