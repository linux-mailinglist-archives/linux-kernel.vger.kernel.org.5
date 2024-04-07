Return-Path: <linux-kernel+bounces-134582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAC989B339
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2AB2832DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ECC3B2A6;
	Sun,  7 Apr 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rFdEJm1w"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C081208B4
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712509875; cv=none; b=Wbybl9y+GNIKMNX+Yy/hlrSehsBq7pMS4xyHAwusRqxbvaOI8fv8vV8LKQGR4HOFvTwdwMg3lsoZ+6kBQhbP06RtczQeNXycnYYy0tfCgwG47tRSkc96i84fBUSLX2fHT84BAAoK3ehb9E4UiXRKZdFMbAgNQQ2t7niMS2T0acY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712509875; c=relaxed/simple;
	bh=7auurrEVO3NcC686AT/y/JIKI4dm+kNZcoj2fIrj0j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvSNDe9torEIgGxI2zptE7E1waGKWh/gPt1dW4dvQ8pxDYXGlzuXgeiewhwvCdbxMPTYBNQfLv70ked3s5KKQuU3JYdKMtIoMMabHNlFd1JWvmkPewqGA+BT1FbYaxRqbwlf6YtWsbxtOpr99VDXtSoHMPDTKyLsOmoxKuJx8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rFdEJm1w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kg2S3x2yOJGis3rtc5Z5MAarSwFcmW75wBMPuHRwNRU=; b=rFdEJm1w7fEqh962Bb5YCtbpYQ
	7EZX3w0V6D/8wIkzUXe0VjWbhOcBi4xACUsn1BDEO0S220fsvHf0SmP8muNEEVbwHFRcoSQi1Ttcj
	s1zVYyJubBuXiyIg6uTrzpr5Lh3OU1UriRcxnews21M/54XzmK88lUR6ToWYQfQD/wB0vKoHjTFDg
	TdtP8n7aHQk+ce33PGZ4xe1jTa655xdbo3KjRcq2GkeLXA3AzftPu2hFMFfh/jWeU9neERej81Dzl
	8LSS0rqByp9EcDX18Q+m3rl+rj8P9VEP2SWzL5SaH0BE0MQ5PJicRFFInxUVf3v7LHKzG3lM1HdH0
	AWhOaj9Q==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtW2w-0000000D7D3-01EW;
	Sun, 07 Apr 2024 17:11:10 +0000
Message-ID: <3c5ca52f-8144-4214-a6e3-35d9139fa6a7@infradead.org>
Date: Sun, 7 Apr 2024 10:11:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/3] powerpc/rtas: Add kernel-doc comments to
 smp_startup_cpu()
To: Yang Li <yang.lee@linux.alibaba.com>, arnd@arndb.de, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
 <20240407063952.36270-3-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240407063952.36270-3-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/6/24 11:39 PM, Yang Li wrote:
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function smp_startup_cpu().
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/powerpc/platforms/cell/smp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
> index 30394c6f8894..bdb7adde798d 100644
> --- a/arch/powerpc/platforms/cell/smp.c
> +++ b/arch/powerpc/platforms/cell/smp.c
> @@ -55,6 +55,8 @@ static cpumask_t of_spin_map;
>  /**
>   * smp_startup_cpu() - start the given cpu
>   *
> + * @lcpu: Logical CPU ID of the CPU to be started.

Does this work with the blank line between the function and parameter?
(i.e., no kernel-doc warnings?)

Usually it's done without the extra line.
Otherwise the additional line for @lcpu: looks good to me.

Thanks.

> + *
>   * At boot time, there is nothing to do for primary threads which were
>   * started from Open Firmware.  For anything else, call RTAS with the
>   * appropriate start location.

-- 
#Randy

