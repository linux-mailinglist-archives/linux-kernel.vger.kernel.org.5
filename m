Return-Path: <linux-kernel+bounces-69764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D08858E31
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60852B21977
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213A1D535;
	Sat, 17 Feb 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUE1pL90"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458B1D524
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708160276; cv=none; b=JssSDp/YghBxWWEJyiHBgZDiF+dKNQf5hccRYrBoOf3FU1vVfz9i6f9vuVTr6EuUqE6SYjYP1QRhc/ZaqovGKtvqoGBJ9GWeuUcO12cYL/UGhozAyoB5f3cpYLTviIGn5pgqcMNpCs+5qKKRK7fQgR/ozBn7s/8Hiom179c35lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708160276; c=relaxed/simple;
	bh=q/FOU/1+7GJ/VnC+BD8fVANVVdilO8IGUAU0pPNd4p0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mqQYrO4aliM/Cpya+x3E+94KEfi8QGnjno9zH85rbMYyBvUvjWLmEZo71W1BH3YZSeE7Zzwq5jCaXCWCOPApti6xPrbUbpz4ikAmdnxv00pFzo5cy4rbrJygN7qIkLZxiIui63uI3alaJ4ZlDTkPQ9HFd1fre0LJshJY/D+6CVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUE1pL90; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1db28b1b2b2so39228725ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708160270; x=1708765070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8cN5Ao/Va6tTEguzjCrGVvZrh4wckSSwaDJTd7QE8E=;
        b=VUE1pL90GwxBid2s1bX53gWbmfFV3S7BkO6caNHLo3027dGsonQMNjLBL4EEo6Hq2u
         JuBo01tcWXRSThx1ERe0ay7W9siN+Pi8lfEmXZD7HT7yU6PvuZQQidkxaDi+mR6kdcWO
         S9vruoJWApiCn/2s4eIBS0GRNGkDJD4Yn9s1r61+ysWpkx24/6yn9Khumm7IxlGGUrqi
         0gAbbd8IXztaNaLkpMyGtJpLJHXsK2i+mNpmivG9avXtnZBGuyqjGh2uZb/luZ3RsOcC
         LC/d4HBeO6heJLfvIYmmyN0Ie2Xz5Bcm1iTE7GqAUBJTy5GB5NiwI66eGh7dKgoNm36u
         G02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708160270; x=1708765070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8cN5Ao/Va6tTEguzjCrGVvZrh4wckSSwaDJTd7QE8E=;
        b=Pdky1PUz0/y6/NeVYWqZfaghOdjty25YvuibIJMaWDRKHuISQ3psQaNVz/QWYAoSxY
         Qg0MGZ8ZcS0yY2sredCmpXWwlzqQQDau3hp+a5+J7+k9JoT6cpnDnlyPIzkC/aRCCCWa
         lOrB9PPqNhfcpSwST2nvI4L5w/2wN3blybBobijwVQSZ84UDALf1mS47y8gn58JHn5z6
         n0/sGm+R9C7BKyrNkIlE3mY55/wJZkHMXgWZRojjbuCryhVNLuGAWUjxZ3DXGKQpwQzn
         Xh8f6znEkQncbBwJBn0Sjb3ZooSnJuSUSp5HuJP8TiJt1HMZbuSWrrsQrqIJpRabuZsa
         qYQA==
X-Forwarded-Encrypted: i=1; AJvYcCVGpIEjcmm1JMuuXEocJvsWXMdNlvsYVRhKpDfIkWiMjFdQBi0GEsPdQr87rBcnvqkjv2uE+Jp6QIAilc1igLFcPz9pKvZtrMKLFOKq
X-Gm-Message-State: AOJu0Yz8kBKqZDYbzUb0AtWG4KeKz9jaLb0NoAGHIjUHxiRVf3SdkJC0
	GX8DMdyekQ7n+bFFYBnFidGeO/IrGHfU+S8jfrz1vKWIl+NaCHoMF5FjRTPTSjBWYUbfuh8QKBs
	KQekqEf0bGLLcvj6UsA==
X-Google-Smtp-Source: AGHT+IEAAsrCHHSYH+FWB1DTFFZRQ147uLGFkQxg/t6LkTT5Z8beOk+u1/7w1Y1yUyt3zCryhzsAjrxBtgciXbJZ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:ec90:b0:1db:c1f7:3590 with SMTP
 id x16-20020a170902ec9000b001dbc1f73590mr161997plg.8.1708160270011; Sat, 17
 Feb 2024 00:57:50 -0800 (PST)
Date: Sat, 17 Feb 2024 08:57:47 +0000
In-Reply-To: <20240217053642.79558-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240217053642.79558-1-21cnbao@gmail.com>
Message-ID: <ZdB0-fnlSyGgH2cQ@google.com>
Subject: Re: [PATCH v2] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
From: Yosry Ahmed <yosryahmed@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, zhouchengming@bytedance.com, senozhatsky@chromium.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 17, 2024 at 06:36:42PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> We used to rely on the returned -ENOSPC of zpool_malloc() to increase
> reject_compress_poor. But the code wouldn't get to there after commit
> 744e1885922a ("crypto: scomp - fix req->dst buffer overflow") as the
> new code will goto out immediately after the special compression case
> happens. So there might be no longer a chance to execute zpool_malloc
> now. We are incorrectly increasing zswap_reject_compress_fail instead.
> Thus, we need to fix the counters handling right after compressions
> return ENOSPC. This patch also centralizes the counters handling for
> all of compress_poor, compress_fail and alloc_fail.
> 
> Fixes: 744e1885922a ("crypto: scomp - fix req->dst buffer overflow")
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  -v2: 
>  * correct the fixes target according to Yosry, Chengming, Nhat's
>    comments;
>  * centralize the counters handling according to Yosry's comment

Yet Yosry is not CC'd :P

The patch LGTM, but it won't apply on top of mm-unstable given the
amount of zswap refactoring there. I would rebase on top of mm-unstable
if I were you (and if you did, add mm-unstable in the subject prefix).

Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

