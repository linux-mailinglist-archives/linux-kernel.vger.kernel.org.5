Return-Path: <linux-kernel+bounces-38746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E589E83C53C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6630F294DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0C6E2D7;
	Thu, 25 Jan 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zsNaadqF"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435A6E2BF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194197; cv=none; b=XGkapEev3pqx+KHVNDN5rSGD+OBwnF3KcIW0xuDuu+uBykBsMzc33VIScYd4UUym+r46DWqhhKdcwai0lB8oUDpHj+Mo7N+jLCMUnQgxhDtKZan6D6snrnefvEXt87Zjxmtzb09dLJVn4BvLNo2X6vVe+vhiTJBDLMuQmjY2Zes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194197; c=relaxed/simple;
	bh=5utcNi5EbwXGXKE6XBUr2p3B+QtNTPUv/WMImZ3KMxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krBXgIqxoj67nRXx0sFvPIcHxr6j9AAM2eYXloB9l+n9lXDGy+TjloAKODOsRIc4zRd+P88ZD9Tx+vqDTr18ZcmrE0YZ92ncbd3LowazjyfuCshfC6ROyKIqfHFW60KU5sgv5iikArsfDJoIvSe4Vua57YWPd5flDMiOLpt9sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zsNaadqF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4298b23abffso38718961cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706194194; x=1706798994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Jufmt29FN+BCLayi+KSCZM2a2FaZk0tkZi2gIXjUg=;
        b=zsNaadqF097doUCGMvDwAc4kbpCdddtucOLm97wr3wzsZwI8cAkIvcg8T2SSbpxiq7
         3jLnmw1BPUM5ha4zIIrBS5HxnO3F3nA5e1Fl41G0N4ScqMb3iDzwsPdcx5c+hZOl4RHZ
         FIGijc2nzjaOwGWjiSWvOYwuvQEjEn4E13OIl+7tg4TjdFOkYMceUiFMa8mj9LfvSZFc
         XHbBRhHoasA8eeCR0Z4V1XiH3/Ejp23zaFyeOtOd9pDZNyw1cKNeP7IPnEn9Cr1ONy8k
         eqdL5Suo/zJ+41NKIGILR9jkZWOLeQogGQaXb6H0dKwJfotrJbE8fTHjAxBkbZm79fzJ
         xdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194194; x=1706798994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1Jufmt29FN+BCLayi+KSCZM2a2FaZk0tkZi2gIXjUg=;
        b=Qat1BaUMxCrOOp2vLHBUmNOIK2XxSHL8PIffx9plqpNIDSzbGCvotY2sXCSG32m3EK
         L3boK5ssMkOexAEI3xnuUCOsQlEYiM5qiJRa9lQiPZx1QnQYJzRyigvU9MxwrJyt/8s9
         CMkE6auB3z1am5PTFC2Czlc7ZtHur8VcXb/+nDvKcZf/qsHi8MQzdg0XvKYJM3JcmMNU
         oDyvu+4URFOuPAsiJm7ZTNR90D64CpaZy6eFFDTGbTVK84YMIil2zodo5RGtb+cT61Cw
         uRLqZwrk4Zco9phsghqoSiwy4StZFQK2ksdMwdasxDqT12YU4ZiAtjlMr1q0eElsUI6n
         WVVQ==
X-Gm-Message-State: AOJu0YyYJZlgMWjwsm3gRv4IjStqptEO6JRwmqYh9wbPo0NcdFQIytmo
	iDyI7DbIswh9raextkc0aJIaWtyLEzAgTrcDjWkXheQdQ1eJ3YaSujmBF5oMd+c=
X-Google-Smtp-Source: AGHT+IFMyIXKi0ksURve7d4Kvfnuupv44sbMBvOfwALrt+vAce7BUIIrP25e6L2zwFgSedr4IQ6wGA==
X-Received: by 2002:a05:622a:10d:b0:42a:3195:e8be with SMTP id u13-20020a05622a010d00b0042a3195e8bemr1205799qtw.51.1706194194446;
        Thu, 25 Jan 2024 06:49:54 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id en11-20020a05622a540b00b003f6ac526568sm5420997qtb.39.2024.01.25.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:49:54 -0800 (PST)
Date: Thu, 25 Jan 2024 09:49:52 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: fix missing folio cleanup in writeback race
 path
Message-ID: <20240125144952.GE1567330@cmpxchg.org>
References: <20240125085127.1327013-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125085127.1327013-1-yosryahmed@google.com>

On Thu, Jan 25, 2024 at 08:51:27AM +0000, Yosry Ahmed wrote:
> In zswap_writeback_entry(), after we get a folio from
> __read_swap_cache_async(), we grab the tree lock again to check that the
> swap entry was not invalidated and recycled. If it was, we delete the
> folio we just added to the swap cache and exit.
> 
> However, __read_swap_cache_async() returns the folio locked when it is
> newly allocated, which is always true for this path, and the folio is
> ref'd. Make sure to unlock and put the folio before returning.
> 
> This was discovered by code inspection, probably because this path
> handles a race condition that should not happen often, and the bug would
> not crash the system, it will only strand the folio indefinitely.
> 
> Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Ouch, good catch.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

