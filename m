Return-Path: <linux-kernel+bounces-48612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63903845ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D87289B18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB1D7C6D4;
	Thu,  1 Feb 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nUyIhUQM"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5747C6C9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809553; cv=none; b=Lcgdyb87gFVrTwyC/O9ncWha3oyYvimOEksh1vjVSZusd5I8SZmQCljbvajKhfVAm2FDJZz1OBS2YBhHJPnmSrDnZ5StddGwDEUbYcJtcN9XVtpCSZXeP3/JOAliYxy7xU1hJ9oxL2xojGhoD6IiHDgjLAoS9O1H7S7Lijr1bIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809553; c=relaxed/simple;
	bh=C1REu5UNedHoBCwnPspADgWkekbk/hgC5mSXhvhul7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RotkC5BvmTkLozJynxS4jdyVY5DxNBmiMsGltIUWM9VXXDmqI9JZolI76kvcUQreG1nYtmGFWz3yd/5i1X/bKLclZ1W9WdsODjLVLJCbvZE+rsIv5/7yDvfMAiHpcDPjdPX2C53OnRSxBS5wFoYGRnrDztr+KaEfk00ZOrkn65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nUyIhUQM; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bfd5570ed0so40934039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706809549; x=1707414349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i45ArjC1PKxIYAaiKhBBikWuA/veVaN7EGO1k6Zgioc=;
        b=nUyIhUQM7GgKuTPIn0ZuEHm95nzbSumbBJEnmsroj7sH8t/Yw554cKYbSNkmFy5jix
         KO4diQyxCwzoPiBiV2ZkBuzylKefsL1Em+ox7XO0NbYMU8MtUOTsG/uU2mYz7Rm18BaY
         OXcY51im+EpXRhSzZ5mJ4aC1o4CPthiBUqB1e8OFpvuQ/Zkte3FMJ6n+jHHTR1FDT1Bv
         Ike/1XpAkcL1evR4Yt/+auUMQh1qRZBmgV/0eCd0/R/yHjrq3zZ/695vKsLqQXIfPtWZ
         dm1X5/z95tTmhWaGoN1FWQliRuXqLBSTZcQNekjUtigOq3bhOmfNH+2KlmaKrhSIGxJ6
         RDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809549; x=1707414349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i45ArjC1PKxIYAaiKhBBikWuA/veVaN7EGO1k6Zgioc=;
        b=bixxtgcMwOuD/2hEMocAHRCNrT3PLP0CdFK1lgnJqFLNJWdGnX0REPlAxzW2NA6S5d
         hp+0Y3Cid/IFiTqqgyyBbxBqID8NGTjYN4ijW5iBzeE93/XrW2h4WS/d4FHN1PKM8mes
         O7WFOYjRkoN0tsRahH3z76rlRvBOdYAVcDgVCj9Upo9KE5JQC7rMY1oWn0L3Td7A7CT3
         3sAI51AQxkltGDHZVECsGDecPgTdGrexi/a0lKsClXjqPCKv8Q0jkaFNkfWBOZXing8q
         ycGcKCDnA4G/s9QhR6hYoD4WRyAbrYnbHw2EvzZ8w69aEwCMp2QKAy5/S9mimu/YwURq
         Of3w==
X-Gm-Message-State: AOJu0Yy1ckLriDM5WQ5R5GzGhf/UJhUEK1+JsqJ9jKYECgwvIWrTkypv
	HN6pBFgqqbWPnrCLfVlofjp8rFq751W0/d7wIdpw0iCyiwRRD+XnQO4j/lxzuiM=
X-Google-Smtp-Source: AGHT+IGGGL6ZtB7jSJbZakSuZPVzJA92Ce0HPUfmQlCchsAcoZXke6koPQ3Fwrw3hjDcPeXgtRls7g==
X-Received: by 2002:a5d:8181:0:b0:7c0:5da:f708 with SMTP id u1-20020a5d8181000000b007c005daf708mr6126795ion.16.1706809549174;
        Thu, 01 Feb 2024 09:45:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPsSKARN4RZ90mFryfsgX84i5hyIwU/y0xHjfivVWEEGbp8P4f1RRrGdUPSYWYOzBeBa9pswEzpUUxLjV12C4Vboz4myoK9Rh0gTnASuF6f0sL/eGtT/+F8z7wuieJ9/WCb4/uXDUuzrv3Z6rv/K67uDA4txrgeWhLbVYNHncYBRkQfTohVllSNDd0haGJUv1LhQ==
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id t23-20020a6b0917000000b007bfea3c536esm23386ioi.28.2024.02.01.09.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:45:48 -0800 (PST)
Date: Thu, 1 Feb 2024 12:45:47 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/6] mm/zswap: add more comments in shrink_memcg_cb()
Message-ID: <20240201174547.GA321148@cmpxchg.org>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-1-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-1-56ed496b6e55@bytedance.com>

On Thu, Feb 01, 2024 at 03:49:01PM +0000, Chengming Zhou wrote:
> Add more comments in shrink_memcg_cb() to describe the deref dance
> which is implemented to fix race problem between lru writeback and
> swapoff, and the reason why we rotate the entry at the beginning.
> 
> Also fix the stale comments in zswap_writeback_entry(), and add
> more comments to state that we only deref the tree after we get
> the swapcache reference.
> 
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

