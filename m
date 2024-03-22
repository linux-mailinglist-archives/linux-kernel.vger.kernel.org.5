Return-Path: <linux-kernel+bounces-110899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A83888656A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970C71C23630
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DAA6FA7;
	Fri, 22 Mar 2024 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="CHKYfBQ9"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29227539A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077691; cv=none; b=UkvAm4FuVsuyMUb4an+UZm9gpOLomyvtwIhRNz1+x/SnppXbXcwSF4SD0xhpDm1JJQ7SxotIRn7X2c+RBH8xCxTWe2p9FQ8RxMuBKmFrBKEpasydfkthh4v+AxzGEuc9M5nSzNGYb05J3V/attVxpTqztnmEINHpCCoevJAwoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077691; c=relaxed/simple;
	bh=tSBphr0xJtrX/LttuD4f/OrNSHZ9qYCmCb2vv1X1h20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klk+wWmkEjkVhr7XBpALBBrp448Os+JKwos7fZuM0RYmhleI8nwWoPOVNEiL48XJ2SocjeZBp5OrTeovEwZ8f+HTPrKGAqTLa6r/3CKM2c+0i7rzgiD8D0lx6GRJi9CxVBaslBmA67jlm2mdtJ8XZHA1cPiY+Q7HVciNWsGVQs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=CHKYfBQ9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690de619293so11033796d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711077688; x=1711682488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qK5RPUIDEOrZPbW4+iO0DfmSBKeGfcgd9g52YFXjRo=;
        b=CHKYfBQ9L1hmGI7ktJ0Bi917HsvqKADEnvZzWRKfDaQAqedYy/6bMyE8rcbUQ7MkeT
         Rs/H+zuRzoW7mSQPUIcZkUVSEjJpBQ1vYcfUwIe/0EAsW3nmsJ+Z6OCx9qHLMo64bKx2
         tkwi9zypFczrywkXBf8fuTCGaV3DUz8bAAHukB6r6SXnXwkmzXFNz4xnB4rlIPWEf+Pm
         /m0ufWt5+IQwH9NZUV1I5lyiNsI2fmCNe4CBwAInQ92XOj1SUFrlnm5Z3mAuuFHbp3yI
         SK98sPFrmK3cwnUzazl40szBKo/YfA7xVPjdVcn4vi8xNPOuNKMJt767ax+Y1qw9jgsm
         NfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711077688; x=1711682488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qK5RPUIDEOrZPbW4+iO0DfmSBKeGfcgd9g52YFXjRo=;
        b=aG4nhzdi4ah6U1ulNIzSV7W7SMm0Bj7wnUIOE3/Ka2OQXwhQWl40iJIv/1Js02+nJu
         T30KwkuXWt2gKuYzJYntvbde5QfeeCqDxcQyhAPsyKnshdcWChXYnHuTusJcZ+pwA6/J
         KjJGnFHDoFoS0+doenXdRye5AAaLa19cjM+3yJuc/zY7H5TszDDnZvR8PJH7lCGtN8l2
         HWbjwSV9yfDM5eNCI4eSugFQv8aKVbUXElhrE2S27xT4dIQlaGK/oFi3N1Tf2VSx9zL2
         KeEnuTyhjBBTx4fd7EEfm4NkLRMOY+robVIMIEYel4GxK4KcCJSOSGzgHTRXRyR2MD5n
         G8aw==
X-Forwarded-Encrypted: i=1; AJvYcCVr34jE/r5XbSoXmz5pfRCwE1w2XJw74DR8wr7EVtvuv7d+Fl0Tmcltf7hptLWj7ffvTc/HsJOZnRGrX2ixYy1rUOfHuD/TN1JpN+R2
X-Gm-Message-State: AOJu0YzxY3qz7F3zhCn2o8Cx2q4KqrLcBCQncf9ceYU6HVHkyaj+v9Rk
	SbarNYC8lXugh0gA23aVwkacRvSVTVHhLKnRxAN4Vky1wkfso2zN/xMuxNfeQmI=
X-Google-Smtp-Source: AGHT+IH7QYn/l822uz8oO4e/U6++L6Y9qq/qc4KZBmTPJBPyFugkvvMFNGcGHXIMwad3F4HiVQ4HqA==
X-Received: by 2002:a05:6214:2aab:b0:690:9629:da5c with SMTP id js11-20020a0562142aab00b006909629da5cmr1022104qvb.24.1711077687834;
        Thu, 21 Mar 2024 20:21:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
        by smtp.gmail.com with ESMTPSA id kc1-20020a056214410100b00695e602d356sm637127qvb.46.2024.03.21.20.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:21:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 23:21:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: zswap: remove nr_zswap_stored atomic
Message-ID: <20240322032126.GB237176@cmpxchg.org>
References: <20240322001001.1562517-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322001001.1562517-1-yosryahmed@google.com>

On Fri, Mar 22, 2024 at 12:10:01AM +0000, Yosry Ahmed wrote:
> nr_stored was introduced by commit b5ba474f3f51 ("zswap: shrink zswap
> pool based on memory pressure") as a per zswap_pool counter of the
> number of stored pages that are not same-filled pages. It is used in
> zswap_shrinker_count() to scale the number of freeable compressed pages
> by the compression ratio.  That is, to reduce the amount of writeback
> from zswap with higher compression ratios as the ROI from IO diminishes.
> 
> Later on, commit bf9b7df23cb3 ("mm/zswap: global lru and shrinker shared
> by all zswap_pools") made the shrinker global (not per zswap_pool), and
> replaced nr_stored with nr_zswap_stored (initially introduced as
> zswap.nr_stored), which is now a global counter.
> 
> The counter is now awfully close to zswap_stored_pages. The only
> difference is that the latter also includes same-filled pages. Also,
> when memcgs are enabled, we use memcg_page_state(memcg, MEMCG_ZSWAPPED),
> which includes same-filled pages anyway (i.e.  equivalent to
> zswap_stored_pages).
> 
> Use zswap_stored_pages instead in zswap_shrinker_count() to keep things
> consistent whether memcgs are enabled or not, and add a comment about
> the number of freeable pages possibly being scaled down more than it
> should if we have lots of same-filled pages (i.e. inflated compression
> ratio).
> 
> Remove nr_zswap_stored and one atomic operation in the store and free
> paths.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

