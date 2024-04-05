Return-Path: <linux-kernel+bounces-132335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F90899345
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE88FB236E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD54171AD;
	Fri,  5 Apr 2024 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="h0UaRVHj"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA3BE4D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285105; cv=none; b=WoXNc4nDwVLtuNDRzFwkj9YPUTV6MwJpGfyWfpVZtzDlGfgdsVMfRsEEpjI7EWPOLpPePl518wDgCaa38V2DNbWHJ9J1iSc/RrSAXLImKL5rOqJcex15Fdpvy5Hy6lup83JsRnK9UFVM4gGaQy32CQDX26YB/7W3Q/BeAAr5HX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285105; c=relaxed/simple;
	bh=64W2UQQFPjouK1278dNE6r4EnUBen8IgVNpaRRS1OFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXaNOeTusOg8aLefGzzVtOEdcYfJeqMRiBnyIwjYsmtymkAvcqyn7GWcDuaUVkm87olnLA81aBencrPOei9z7xOXYuGwkftx7oduznm48ME3CUERzTC4f3o34xgiGQd+X09rLtrW61w4tWW6qpS3D7mhftWrID7tAoyFCz8vYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=h0UaRVHj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43182c2457bso8665701cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 19:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712285101; x=1712889901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14/Jmqw/F513fEFD4zyhSbn6EUBGIv7v5bPF2RRkA6k=;
        b=h0UaRVHj7/9Eg834KAq7B1dZv+1F5kx9It9XiGOKZ29VQyyEf0dLogRWoFYExlV5DD
         Dgd2ATYIsShAej+PRqxjrY8sUWRr/19M+qf3b9KFMdsH1pKi+P/SeyXxE4A/LDo4+AY3
         CZf6fKw9wzseKDdM6ZDiTid4ofqPl0XvXyPH0Cm0UtKyGD/KHvbFsxRPhuo2pIr/EhnT
         QZSr/IsMlGIu81Ojotkoo7Dbr9DJZJqnHN8WEp1jhEsWXH8aSUUPhDg/Ga3wZcgYyB/d
         TmLlk2fukM0Zf9dLgiEYe5Ch9MbTQrFfYE85wKm+8CjlQ7WNqL1clu4kcwcB9Fk2LpJJ
         KyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712285101; x=1712889901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14/Jmqw/F513fEFD4zyhSbn6EUBGIv7v5bPF2RRkA6k=;
        b=HgK37wtwffIHCTh9d3LJtsRuW8B0n+TDvrjGrzL43UgYLb112kjGePqk8c/+xu6/+v
         dTsCDKnt8VX0qDUjWgFwJffqKl56RYHkyjmycy03U7NjxWqgVKzQlwiM4sCAN8SEfQnf
         S0BZm9YmC5xwFq2v3bicRonyYCddXJAGwMDt7CR5CA8hjKyJRHYYRF/lXdIiW1hmBJzb
         0ZFqPtRk9KQmNWKJCDAbDCx+7ij27xq00EVtnHX0l2YD/gIfRDgMLmFkk2mn6UjGqIWC
         ZOmzWjKrOAmOJmYJKqza7WItIW1vTdIWEy8zEu8TtaydRaxiAfat1aVeqS7ktdXHH8qW
         NKXg==
X-Forwarded-Encrypted: i=1; AJvYcCVHYjzL+RMXTVeLxRRkb6xGwxRB988SY/GGUZGbHMR9JOs75BcD5zNQYa6cNbuyh3K2FGH1fD9zywG61Z/gNeuynuSUN9RVhQjOnZRw
X-Gm-Message-State: AOJu0YzvWiWzIXeaE8Af1s/BgmyualYNwy+LgPusiFX5+JFPpUDDFKKv
	eKvPEf0dWyKqyFeizPIo9iN818XqbciK6fuIiaM23CJDlSczcM2zf2/WkBZt1qs=
X-Google-Smtp-Source: AGHT+IGavZtnoQPJhG1A86bHtiTFeAPWXXoTPEGfjOceSc3n9e3JOO+zdDrP6qQRqwZUkdkKfBNXnw==
X-Received: by 2002:ac8:5dd0:0:b0:434:515e:4120 with SMTP id e16-20020ac85dd0000000b00434515e4120mr110174qtx.42.1712285100819;
        Thu, 04 Apr 2024 19:45:00 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id c12-20020ac86e8c000000b00432cf894d57sm322016qtv.48.2024.04.04.19.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:45:00 -0700 (PDT)
Date: Thu, 4 Apr 2024 22:44:59 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] mm: zswap: refactor limit checking from
 zswap_store()
Message-ID: <20240405024459.GE641486@cmpxchg.org>
References: <20240405013547.1859126-1-yosryahmed@google.com>
 <20240405013547.1859126-3-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405013547.1859126-3-yosryahmed@google.com>

On Fri, Apr 05, 2024 at 01:35:44AM +0000, Yosry Ahmed wrote:
> Refactor limit and acceptance threshold checking outside of
> zswap_store(). This code will be moved around in a following patch, so
> it would be cleaner to move a function call around.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 1cf3ab4b22e64..fba8f3c3596ab 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1391,6 +1391,21 @@ static void zswap_fill_page(void *ptr, unsigned long value)
>  	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>  }
>  
> +static bool zswap_check_full(void)
> +{
> +	unsigned long cur_pages = zswap_total_pages();
> +	unsigned long thr = zswap_accept_thr_pages();

I know this looks neater, but it adds an extra division to the very
common path where the limit hasn't been reached yet. It should really
stay inside the branch.

Another option could be to precalculate the max and the accept
threshold in absolute pages whenever their respective module param
changes. That would eliminate both divisions from the hot path.

> +	unsigned long max_pages = zswap_max_pages();
> +
> +	if (cur_pages >= max_pages) {
> +		zswap_pool_limit_hit++;
> +		zswap_pool_reached_full = true;
> +	} else if (zswap_pool_reached_full && cur_pages <= thr) {
> +		zswap_pool_reached_full = false;
> +	}
> +	return zswap_pool_reached_full;
> +}
> +
>  bool zswap_store(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;

