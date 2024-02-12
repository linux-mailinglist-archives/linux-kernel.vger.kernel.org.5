Return-Path: <linux-kernel+bounces-62251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23E851D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1851F25FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229EC45BFD;
	Mon, 12 Feb 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y3aN71zO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42345BEF;
	Mon, 12 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764675; cv=none; b=pjjKeRT+IV/oogQq9WlF09xQmS7aNx/Riun856CNALVXYScdcfZsFzyNWF1Ee0mt/2FJlWyRwEe0zagmWLPSpwm8vJZYiicEqMs8rUk0TV21qIl/BifrO4glql7rQL4+QOJ6ujB4wgAHO/lKBl6ObQdtsY73U84YGdK/e3W9Mpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764675; c=relaxed/simple;
	bh=vI89LdebZecrlsHELjk1qJUqW5p9P9BrNUGhawfpPSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFtTIOGnWMTDdxYaiHR4eXfwWVNbWd5+7i0aQva8M7R/wp8a3cb3YRpZJPTM9efghlv5b8P99QaJ1lXGjgBq++GpDWddwHbjaXFKJi23gTykLvxtPw4qIBIJzltUUFkb38HwSo+aX+XexjWVVkN7aIVMl1atAEmkkLlnv2klUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y3aN71zO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=x5eMkKunWvdfI72+MG0lH8Jec7gbENd3muJV5uM1De0=; b=y3aN71zOtbdIcZhOcHgfVyfHuh
	kxAQlkrQKV5+2NliW8lMtGXMiwFAOMe9gjKTihd0XwqbGg0RMtfjH5qkM18zyJG7YdsNILmuQcLgU
	97HVkD0WhM8UocuhGgTMOZ9QIEMfzGcugF962N4X12BhkZUR3U74tVlTac4eL3Qke2ynOT7Z+Cr70
	uCJmv5wrTrKoNEWi7jKIURrfDQuO9llohhldBCaN/1+RjDcF3y3CIV4u95AgG/xvt9EUTeF/LGPYv
	9MS4v4m8XdfvUnhI4FYdEWdhuWE8KMH3W2j8/mrLd+Enlnra5r79bDyHD9EQIVcoQY2LhDNCjDVhs
	RZg/oH3A==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZbbO-00000006iYa-1OtD;
	Mon, 12 Feb 2024 19:04:26 +0000
Message-ID: <1d12e130-d3db-4eb5-a1d0-bc994c97a175@infradead.org>
Date: Mon, 12 Feb 2024 11:04:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: Support to select compression algorithm
Content-Language: en-US
To: Nikhil V <quic_nprakash@quicinc.com>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yan-Jie Wang <yanjiewtw@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_pkondeti@quicinc.com, quic_kprasan@quicinc.com,
 quic_mpilaniy@quicinc.com, quic_shrekk@quicinc.com,
 mpleshivenkov@google.com, ericyin@google.com
References: <3776355f920c1af44490e076072f93bafdf128cc.1707740870.git.quic_nprakash@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3776355f920c1af44490e076072f93bafdf128cc.1707740870.git.quic_nprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/24 04:32, Nikhil V wrote:
> Currently the default compression algorithm is selected based on
> compile time options. Introduce a module parameter "hibernate.compressor"
> to override this behaviour.
> 
> Different compression algorithms have different characteristics and
> hibernation may benefit when it uses any of these algorithms, especially
> when a secondary algorithm(LZ4) offers better decompression speeds over a
> default algorithm(LZO), which in turn reduces hibernation image restore
> time.
> 
> Users can override the default algorithm in two ways:
>  1) Passing "hibernate.compressor" as kernel command line parameter.
>     Usage:
>     	LZO: hibernate.compressor=lzo
>     	LZ4: hibernate.compressor=lz4
> 
>  2) Specifying the algorithm at runtime.
>     Usage:
> 	LZO: echo lzo > /sys/module/hibernate/parameters/compressor
> 	LZ4: echo lz4 > /sys/module/hibernate/parameters/compressor
> 
> Currently LZO and LZ4 are the supported algorithms. LZO is the default
> compression algorithm used with hibernation.
> 
> Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
> ---
> This patch is dependent on the patch series, [1] (patches 1/4 to 3/4).
> This is picked in linux-next, [2].
>  [1] https://lore.kernel.org/all/cover.1705927916.git.quic_nprakash@quicinc.com/
>  [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/kernel/power?h=next-20240212
> 
>  .../admin-guide/kernel-parameters.txt         | 10 ++++
>  kernel/power/hibernate.c                      | 57 ++++++++++++++++++-
>  2 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..522155056645 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1748,6 +1748,16 @@
>  				(that will set all pages holding image data
>  				during restoration read-only).
>  

Hi,
Please add something like:


> +	hibernate.compressor= 	[HIBERNATION] Compression algorithm to be
> +				used with hibernation.
> +				Format: { lzo | lz4 }
				Default: lzo
> +
> +				lzo: Select LZO compression algorithm to
> +				compress/decompress hibernation image.
> +
> +				lz4: Select LZ4 compression algorithm to
> +				compress/decompress hibernation image.
> +
>  	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
>  			size of <nn>. This works even on boxes that have no
>  			highmem otherwise. This also works to reduce highmem


thanks.
-- 
#Randy

