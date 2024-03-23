Return-Path: <linux-kernel+bounces-112178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51209887699
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B103B22659
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6C11362;
	Sat, 23 Mar 2024 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWm5Cv5A"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC6A55
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159885; cv=none; b=Gm9YHua0GfycMxNaUlJfmSL0mPjj2I4EGOBq4BxSrUOYwHezOs9Gh3yuuG/iE8mrq5KKX08dcNFz5Em16CoUtkPpubTAc1hXsi/uU5lWquiFLQDNIRDEeKvVEwK3K2MlA3tejyd+gMhpdSccDbPBgQDSKS0hVJsIpQ1nD3XD5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159885; c=relaxed/simple;
	bh=Htqw8GSL4y8T14PX861x5cQ+UMbzyBgGFwv2eWHm6Cs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=t8l4IsKonLbLiOh3FFYBarhudP07NHRj9TO49PybN/Xm0h0lSx/kzbuaowqlZGB3tmbXp0xorm+9ZLxKSul366OX2s2vKW4ay0MTBSXgj1ZW+oLsdWwxgdemFcR2vfiqNDTZFfpcmCoXFy/xTDBqykqsQaNP8I9WhydiW+F/sJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWm5Cv5A; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1660485a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711159884; x=1711764684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytYwAkh4AZyvnFMvyg0Zf5hpxuIrcf2upm5pBUrao8c=;
        b=JWm5Cv5AwGGGin2Y6icjQGXqurkAxfjv0g6oOLm2Wg/L9ig7sLWWH1Kqh/bl6/flJq
         Opqjply0rOVfzl1TrXEerLdwTHETjQZZZUqkLHfx7QMIozOe4XO2Xir1PedxoBzvWT6n
         W2bDbNZaoZMfdrbsLrwGrXKehnn6+Z8YhDuxj96mRp8nrR4NrltjEpxIdjAdP7zMp7pA
         8Yb0k2xRXGRQDXAM2eABCvaRm3WHBVd6Tsw5SVnPqgYKxFq4YSMnSFOyswsxs7rEyeHx
         hOqydVZ1v+w4zIcpjmpbSqQGlwKZ31NBAJh04GtvYUoX77UPwBJNfn1dvvHf6xGWyYD2
         ALsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711159884; x=1711764684;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytYwAkh4AZyvnFMvyg0Zf5hpxuIrcf2upm5pBUrao8c=;
        b=YHo8xysdq2LXIpwQWf0gYNrdaYHUrOL/ubgBdgCgpp/hXUSVOlNcA6GZCrINUVgWrH
         dTY57Etnx7bdEqTuvfM4nsY1JPLdSSJWIaDbEXVe32ehYz1mauH464naXXssNrk38nQO
         0yx8OampDrv/WbF70Alo6TGJAJmPkkOq8dLuTfjFBAjoMUOxdBpHhz+gcXXvqN3wnx6E
         58Ga+0yx6AQ1DX/frF6RT0R5LHHEyMei+srcG+M/A7nRWEnKrrqLcInwdRHTNTOIjr1/
         ExCQ03CyNLAqn2X9trao5Tv3rw4xxIvonsPiUMo8SJyba6sluzn25lKIiehGsvMa8LB2
         XyiA==
X-Gm-Message-State: AOJu0YxFK7OuCcDRtZEV24hyO+dTP1ynBnyWNw5RpdOeNe1QvOEKIibM
	/RGZCuQKvcxUCTxa/KF7wD65AXm38ZmA2bbP+JK4NBxX/18dTuiy
X-Google-Smtp-Source: AGHT+IFk5+cCcipKpU/T74eH7Gg0+R66IsfBKo81modkv34Bn3w33lURjWrD3uBnnCA0OwiRFUpXaw==
X-Received: by 2002:a05:6a20:3ca2:b0:1a3:a669:747e with SMTP id b34-20020a056a203ca200b001a3a669747emr1806032pzj.12.1711159883651;
        Fri, 22 Mar 2024 19:11:23 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id rs12-20020a17090b2b8c00b00298e11b600dsm2594669pjb.27.2024.03.22.19.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 19:11:11 -0700 (PDT)
Message-ID: <c56eae89-9559-4b1d-8249-d23281e466b4@gmail.com>
Date: Sat, 23 Mar 2024 11:11:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ying.huang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "Paul E. McKenney" <paulmck@kernel.org>, ryan.roberts@arm.com,
 chrisl@kernel.org
References: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
Subject: Re: Can you help us on memory barrier usage? (was Re: [PATCH v4 4/6]
 mm: swap: Allow storage of all mTHP orders)
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[Use Paul's reachable address in CC;
 trimmed CC list, keeping only those who have responded so far.]

Hello Huang,
Let me chime in.

On Fri, 22 Mar 2024 06:19:52 -0700, Huang, Ying wrote:
> Hi, Paul,
> 
> Can you help us on WRITE_ONCE()/READ_ONCE()/barrier() usage as follows?
> For some example kernel code as follows,
> 
> "
> unsigned char x[16];
> 
> void writer(void)
> {
>         memset(x, 1, sizeof(x));
>         /* To make memset() take effect ASAP */
>         barrier();
> }
> 
> unsigned char reader(int n)
> {
>         return READ_ONCE(x[n]);
> }
> "
> 
> where, writer() and reader() may be called on 2 CPUs without any lock.
> It's acceptable for reader() to read the written value a little later.
> Our questions are,
> 
> 1. because it's impossible for accessing "unsigned char" to cause
> tearing.  So, WRITE_ONCE()/READ_ONCE()/barrier() isn't necessary for
> correctness, right?
> 
> 2. we use barrier() and READ_ONCE() in writer() and reader(), because we
> want to make writing take effect ASAP.  Is it a good practice?  Or it's
> a micro-optimization that should be avoided?

Why don't you consult Documentation/memory-barriers.txt, especially
the section titled "COMPILER BARRIER"?

TL;DR:

barrier(), WRITE_ONCE(), and READ_ONCE() are compiler barriers, not
memory barriers.  They just restrict compiler optimizations and don't
have any effect with regard to "make writing take effect ASAP".

If you have further questions, please don't hesitate to ask.

Regards,
Akira (a LKMM Reveiwer).

> 
> --
> Best Regards,
> Huang, Ying


