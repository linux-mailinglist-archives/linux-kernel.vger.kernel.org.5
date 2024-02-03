Return-Path: <linux-kernel+bounces-51215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73808487E1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BBB1F23235
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687A95F87E;
	Sat,  3 Feb 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GErC5szv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8505F878;
	Sat,  3 Feb 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706980757; cv=none; b=aN7kdVz0yH1XyCF2ykKMTrxXfifBhwfivXqxRvukwTohuRoRKCwziE356ZP4uxPR2sxMqSiz+dkm6jAn6o00QNpHM6KJ5+Muinbke7UZlQI5eUcsLG67WpEApmprU+IgGbi3JAqGcvJ1fQk48UX/H3g9dcKOf0Vvet/ntjPu074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706980757; c=relaxed/simple;
	bh=doXvoR+AfVpZ1PoO5PtzgkHFUyizgc3cYbzXcDFwz2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBcVUby8fP+2mM1oqV2flKc2qomX5Pt4oLzwLT+PD0kNHLG++PvpF5uNGlwkdOSLIZnNXRog3laPMhmdmUrpJbbFrDrrZfIVr4pqhHEDDeXxX3Ucqg/+LFUwnUPwrm4zLKbrGGbB0rxi7KcPGPwDOfp+YzH+3CuNBWnC4tFzB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GErC5szv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=p/ZlWZsr1R903M2R0mWOr7CE09pnODUX3Ka/76TZaYs=; b=GErC5szvxzA1JV5e4kYcgNu+S/
	G+903hrhR3ZXga1Drgdte0MHZd/mDobB5x5eGMUtmIM6zknQwGmmOn707CGMv9+S+RAAX9H0qolvA
	EZDGJy/bq5R+jC8zt7JArIIdIyH3cobu+d5wOn6lGaTdRDiJpAzetcQ1KS1md5oVhWf7eu4lLZC2f
	q6epqGDQH0dC6J5wKRfp3kRtDKmdo7qm4Vk0Cq1KXHZDshE9MtH8ZmvaxVGf1o212D4nFtcatQfHB
	mebW9bWnTuxwhNcQLDwG1ahEpJaDi8oZoAbWNa7u7OF2EJmkJFrVPImfPMYDBhXZiu/AXy3MFCz+G
	X1PJxbdg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWJfZ-0000000GuHc-03he;
	Sat, 03 Feb 2024 17:19:09 +0000
Message-ID: <f4bce256-d3c4-4d67-b4fb-69619fdbd2fe@infradead.org>
Date: Sat, 3 Feb 2024 09:19:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Document possible_cpus parameter
Content-Language: en-US
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org,
 corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, kernel@gpiccoli.net,
 kernel-dev@igalia.com, Changwoo Min <changwoo@igalia.com>
References: <20240203152208.1461293-1-gpiccoli@igalia.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240203152208.1461293-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/24 07:21, Guilherme G. Piccoli wrote:
> The number of possible CPUs is set be kernel in early boot time through
> some discovery mechanisms, like ACPI in x86. We have a parameter both
> in x86 and S390 to override that - there are some cases of BIOSes exposing
> more possible CPUs than the available ones, so this parameter is a good
> testing mechanism, but for some reason wasn't mentioned so far in the
> kernel parameters guide - let's fix that.
> 
> Cc: Changwoo Min <changwoo@igalia.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..e553740190ea 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4644,6 +4644,11 @@
>  			may be specified.
>  			Format: <port>,<port>....
>  
> +	possible_cpus=  [SMP,S390,X86]
> +			Format: <unsigned int>
> +			Set the number of possible CPUs, overriding the
> +			regular discovery mechanisms (such as ACPI/FW, etc).
> +
>  	powersave=off	[PPC] This option disables power saving features.
>  			It specifically disables cpuidle and sets the
>  			platform machine description specific power_save

-- 
#Randy

