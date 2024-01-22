Return-Path: <linux-kernel+bounces-33712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE5836D95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D7828BBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203E35810F;
	Mon, 22 Jan 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hUP/WqOh"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF355810A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941820; cv=none; b=qwFcPeDF4cGI8+8039TeMfnWjmWr6KFNOk13rYTcSgNbGnqRYXDYBjC3NUjg9/Pns87x1wyy/4tXF9BY6Sjx5h1PW+wo7y9ZfBoOiNoR1UWsB1aY5TG3KTtYHbLTaTe++1cCyrQyq4DwmjMC8sheY/qko/sk7n4rQ5sBR51H/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941820; c=relaxed/simple;
	bh=Vly196UhsVRVHnect6C0Xh11xo13HlEWg2JGCDEvl98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPln2saE50Os3aIJ3WIWlaWHMHZK/2UTXgtkCil1woFGJsK4HsSUZsbsEh1xcwexpGYKDzAlg6E9+8YOY4r5ytSnu1fW44Z0keUwBLv4HdFb6wCNCdhdDLujppxKXxIuPGjkNNyMWvJNGarQFMpyNLJJa1A25+PIHa9/ithg150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hUP/WqOh; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id RqM7rZKTa8uLRRxOVrOvhI; Mon, 22 Jan 2024 16:43:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RxOUrLkqA55BJRxOUrDdKn; Mon, 22 Jan 2024 16:43:30 +0000
X-Authority-Analysis: v=2.4 cv=QcR1A+Xv c=1 sm=1 tr=0 ts=65ae9b32
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=vV_sq8f-s_cmdRgoXsIA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8eK4UgyjgAIcp9iZh2b8rsDRWa9eRtermdIw9vvRpzg=; b=hUP/WqOh9xXpEYBwz1faohARZJ
	qnASJGbif1LfKDUgdstOQEV+n73h4uThWuGaAIlCuZdIBK6qGH5Rnk2fkxZA2NmaIBUUnjleWcS5j
	9PcoR3pybOhKQP1uAcuPnKkR2EW2w9es0ArPG6wEiT0nllCSo6Nig+je7c7A8AFlJPasI4RrogmA6
	e4+aMfk9kB17blhq13Oj5pyS7OLKK0hVKdoKRFcClo/7zzyptXYjek/8tiVMppYu+GPrfdKCKfo/J
	zfslLyyrOzPQZXFd7NiJBtIOEc8ktq+tOIT/3B6sfLJOWP9iwoTU8hcT/1lhMSAyRXMVci1/wwW6A
	dmkzntbA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:34946 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rRxOT-004HNn-34;
	Mon, 22 Jan 2024 10:43:29 -0600
Message-ID: <60e429bf-b5b5-49d6-980f-41d5b6f87f1f@embeddedor.com>
Date: Mon, 22 Jan 2024 10:43:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: Alchemy: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240120133443.4237-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240120133443.4237-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rRxOT-004HNn-34
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:34946
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOdHRvzq3oiP4uoFptvihvn6islRY7u9t8KuulGecv7r/Uu78/MKnyqzqVKWlNBizuPhbEnxjmILB3jUOA3NQJuBI/JZh2wGSXbWT8ZCPcZpMjbUbS7+
 euNHCG51xGF8jtwUozmBWksatShgZZWlWgdPEikvQCgTthzFKDjL76nibTFmVddQj+Wqg/6aH9chMqT+Pun60IAR9CbxsEGrCtt+NwDx7O0S3hzYOYNHGhmU



On 1/20/24 07:34, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   arch/mips/alchemy/common/clock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
> index c01be8c45271..6c8996e20a7d 100644
> --- a/arch/mips/alchemy/common/clock.c
> +++ b/arch/mips/alchemy/common/clock.c
> @@ -771,7 +771,7 @@ static int __init alchemy_clk_init_fgens(int ctype)
>   	}
>   	id.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE;
> 
> -	a = kzalloc((sizeof(*a)) * 6, GFP_KERNEL);
> +	a = kcalloc(6, sizeof(*a), GFP_KERNEL);
>   	if (!a)
>   		return -ENOMEM;
> 
> --
> 2.25.1
> 
> 

