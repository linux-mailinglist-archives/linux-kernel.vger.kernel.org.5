Return-Path: <linux-kernel+bounces-31434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AA6832E51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5D8288421
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C1C55E7D;
	Fri, 19 Jan 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ip6EW7jQ"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE155C27
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686274; cv=none; b=k40Ch17xGwt5S12MkUXg9+lG3eusOgPS5FJf96nW12Oz44/sXf3aE2EH3Bn1jxwaSHEQft8jvNv0ZxxEpNgRhC/u97oxxcroqVV2dxlqExuC7PA0aCUg4UA3vupn3d/zB40IVFmABslgEM6gRr7EF4rHtBDT06wsldCk7LOlRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686274; c=relaxed/simple;
	bh=zooS2opXWEn98q8GsmPdsk0l9I1ao/MeLC4cGyQuAZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PExcvnp9Ka1+ot942At3pYbkawwvy4JDOHe4HYg/f1yYEVn2z+9y8NcUXskZa8zv3T01D4P2IRaOAHK306CEtDaw9ShhoD4Q1i1fGC/4bSdNB5SzEXA56duc7kyY4e3n8MnmCBvjxqq0SXLmkcyxoveQVgaX6jIg6vtHkroNEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ip6EW7jQ; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id QqM1rCAbGAxAkQsv8rZdED; Fri, 19 Jan 2024 17:44:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Qsurr4LQ3fPByQsurr01KX; Fri, 19 Jan 2024 17:44:29 +0000
X-Authority-Analysis: v=2.4 cv=T+af8tGQ c=1 sm=1 tr=0 ts=65aab4fd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=EIiQeHuflohXdkK9GqgA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2PP2Bc7kZyIT7D76puyC5J8empfAZst1KA6YPM0TFhA=; b=ip6EW7jQoVWo1JVahbPug93giA
	oXDj0+2Xcrws/g2DsqoURyJcjpm7hceD9W5NxSxXXE7aw4l2LYBAcyBpR5e2ZiIhQDIUITL1WVo5l
	PEH9XK2YJMlAhdxsEZsgf/M2m8Ey7PWlSdh6md1RU920rt4uOOnCPrBfDNZiMXVF/UOmkQxhcIAr5
	wVonvmISl/mmqB1c/Fp+LFi+fn0GQBUvtCIkKry9QygRt+HgKA2HGMYjCYQd+5eUVHHmIvi7N4zqG
	QwK8f/5+Kn5tznLpJn/Vu7V8DFsHEfsMZvzOj+Zgv8xF3Fm+X7jti5Gvuh7vpKs24yaM2SkdZhUQg
	c0S9Jq9A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:53848 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rQsuq-001CoF-2A;
	Fri, 19 Jan 2024 11:44:28 -0600
Message-ID: <9294bb03-8c80-47d3-a2d7-8108392ec5d9@embeddedor.com>
Date: Fri, 19 Jan 2024 11:44:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlegacy: Use kcalloc() instead of kzalloc()
To: Erick Archer <erick.archer@gmx.com>, Stanislaw Gruszka <stf_xl@wp.pl>,
 Kalle Valo <kvalo@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240119171655.7740-1-erick.archer@gmx.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240119171655.7740-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rQsuq-001CoF-2A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:53848
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOykcDdac5yS1neNHycA/9q6X43EAw0wL9177Y9bXO9FCLJPbnaKGffufQ4YvRBl3oxjWfa5upeXvXgWAIVeFVoUBZ/1n4ZBB+2NcXD8z5kBAetEyu2w
 SGF8gUO6w0AJBoVHCHg8CCwXNxjaKky66EHWbpZUfmQOC4GN2R7vd0DDEFDm+wAOf+N8mikIUnMRIaH9g4/lyKQH5hiWX1LMjESBpfWY85H1QNg8DRS31sl2



On 1/19/24 11:16, Erick Archer wrote:
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
> Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not change the
> former (unlike the latter).
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/net/wireless/intel/iwlegacy/common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
> index 17570d62c896..9d33a66a49b5 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -3438,9 +3438,7 @@ il_init_geos(struct il_priv *il)
>   	if (!channels)
>   		return -ENOMEM;
> 
> -	rates =
> -	    kzalloc((sizeof(struct ieee80211_rate) * RATE_COUNT_LEGACY),
> -		    GFP_KERNEL);
> +	rates = kcalloc(RATE_COUNT_LEGACY, sizeof(*rates), GFP_KERNEL);
>   	if (!rates) {
>   		kfree(channels);
>   		return -ENOMEM;
> --
> 2.25.1
> 
> 

