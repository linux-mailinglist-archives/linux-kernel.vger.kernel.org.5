Return-Path: <linux-kernel+bounces-43659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9228841752
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6266C285C35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E42F2D;
	Tue, 30 Jan 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="32ZVG0J4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589F12E61
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573349; cv=none; b=Gslw48pXq2Oq4iWdrjl/4xuVp3zlI8DCP4hjcX4K+FOLL/UXQ40EzLijWxQkAPYF0G0pmZ8tGTbuYlZWwfyQ7MWtvgMbF2oXEswE28pu0JOTXdrgtsWRkNVyvcZsZSfd7ybEvuSPAVFij6DV0ej6hTZHKz7PVs2A2gP32Q9MeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573349; c=relaxed/simple;
	bh=GCjwSaX/jGNFHySJPAPBg/Ic6mBx1ZCfuLepGY8RjNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZLE25S5/3Q1j8+7xlU5+dBIVW3JRlELQXfNt2zBkhLHk9j7CA+pu/wuE1K+L2/npdy1Oc9FMQ5LkL/AxJM2N7H+iPlE0ZssIarMahJm2+gmHNp34ggofuNZtkpCfTOEOYn5ooeroKqiCFLWRrCuKZUFJFaOK4Db+4YpjvsCKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=32ZVG0J4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffa2bb4810so38355977b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706573347; x=1707178147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/K0AeehED9h4ZP07MuJkt2AwZaPsYCE1PNqowSyLj4=;
        b=32ZVG0J4lr2Q5WbfT4AWVttoTEg8rOY33O45oGucY2oymZDUrU+yZiQl584voGGSse
         6K71l96YcSlXqIBzQsT3vlSo9V1mekPsU104UVkfGUdH4BdT6k+ABZlrcrXWh/GRRcED
         2dKbrJEHT2pyGbICeDfFFNy8sjUdczGbvnX4EwJ4ZbbvLlFT1OmdofgtW2TCbrUaIqYg
         OBzt/TnBOy9E9Iy1MwWSSwJ9VlmxC1ULYjSYrRV9NdDTGYambOdzykWSgjuyI40mmJmw
         x1Ur7WcGEOorodhWcxkGZZXsGAgWjvKhblDD6UPM3z/RKUBvi3h/K7+deRILp46w7tac
         UseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573347; x=1707178147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/K0AeehED9h4ZP07MuJkt2AwZaPsYCE1PNqowSyLj4=;
        b=aISHA2XocYoxspnpmM6HuRP4w0roSKAoqEp6PKdQD913ErXmwdMKKLIWbnMp9swKUL
         nCReSsYMOS9f4LZecpDPntJr5kAnyDC9S1tTrI8ZDvSHNnZwhPSA+ZmuScYz+0zB6nlY
         JVofTuRUSdNnvjExU/wPaSK1C2EWNEjfSPHo1hnBsV1ua7o/UVpkmRgM/TfILr4dZ77M
         1SeRmXIwbz69+vRXLgKCnN24yOi1heAfxjhJKSPnSl1Lm/0NKuvw1RrxxuVJl7Tf+fMM
         m4gtzcgvUFPZMjTOu2Y9mSNh25kaSV0J5IYP+2l9/4Iff5G5YjqhTAutV5oGqp1AkcjZ
         jbzg==
X-Gm-Message-State: AOJu0Yx2Z5c6t0uhd2Ygw+fNUB6GeOESORA8YaOfITxzyxV6uuJgCciY
	OavIKzo4WHyPTlzF5v5EDfWiW53cXb6STbTXLcPb/IiFi61L5oyWyT+WHvLZb/SVsQvY32IrnNx
	gjnxCkCEhYxq1nTF8CQ==
X-Google-Smtp-Source: AGHT+IFJk0fL87QqH7pvgfAqaOTWmPQfNLn0Uy2n7F+WoUSb9JysbK7zVrWLSjil26rSboqLqXvpAkjhf4WzsgTj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:ed4:b0:5fb:5605:494a with SMTP
 id cs20-20020a05690c0ed400b005fb5605494amr1619430ywb.7.1706573346971; Mon, 29
 Jan 2024 16:09:06 -0800 (PST)
Date: Tue, 30 Jan 2024 00:09:04 +0000
In-Reply-To: <20240126-zswap-writeback-race-v2-1-b10479847099@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com> <20240126-zswap-writeback-race-v2-1-b10479847099@bytedance.com>
Message-ID: <Zbg-INqi9oMUqJaW@google.com>
Subject: Re: [PATCH v2 1/3] mm/zswap: don't return LRU_SKIP if we have dropped
 lru lock
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Jan 28, 2024 at 01:28:49PM +0000, Chengming Zhou wrote:
> LRU_SKIP can only be returned if we don't ever dropped lru lock, or
> we need to return LRU_RETRY to restart from the head of lru list.
> 
> Otherwise, the iteration might continue from a cursor position that
> was freed while the locks were dropped.

Does this warrant a stable backport?

> 
> Actually we may need to introduce another LRU_STOP to really terminate
> the ongoing shrinking scan process, when we encounter a warm page
> already in the swap cache. The current list_lru implementation
> doesn't have this function to early break from __list_lru_walk_one.
> 
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

