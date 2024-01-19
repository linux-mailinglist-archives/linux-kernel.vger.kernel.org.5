Return-Path: <linux-kernel+bounces-31489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E2832EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D62E28817C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB055E76;
	Fri, 19 Jan 2024 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="LnZS/RlA"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDD56479
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688802; cv=none; b=SagCLcTVsa08quQVHmk0yj983YjgKY2h0yzRO2BfVopGvWOahwY1DgPeDR7dDLRML8XPRtFUAnwsLen1Em73+gdYxUvBpsa9CndIh/tYyF+VtxKAbUSq/52ZAxK8qmlqNNXwOykfqZZKkOOBmAIdaizXJ+Ans4dwimA9LAPAzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688802; c=relaxed/simple;
	bh=Bsn0CtciQRUDtrRkW9gSG+XBJcqYbERCr4RziQIuVjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ostfdCuAcdFhJyM04l/KJpZe0+fw1PE2ntIVW3c6KIFqinrNcYY2OAtPYxvfaT3AnZbXWugI2evpnLh+V12MwC9nUKUNVxsu1EiwJgujdwmTnVpeTV0MonFhgQPLH6mPC7h9T5aJm8HT7fm2so1gQR3mcDPIrJ7EvIy4yd6NDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=LnZS/RlA; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id QsvirIt9fCF6GQtZgr0a6y; Fri, 19 Jan 2024 18:26:40 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id QtZer2qjutzh2QtZfrsxOO; Fri, 19 Jan 2024 18:26:39 +0000
X-Authority-Analysis: v=2.4 cv=Ra6Dtnhv c=1 sm=1 tr=0 ts=65aabedf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=6BFke60KTf7VZbaxHQkA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/mlPQHtQDJOovVjTKZhCPypwsLYuORg1138Lx/Umta0=; b=LnZS/RlAcA+J8mY3mUW9L5oRqi
	d25JGSC3u5UcrBJi/qJrTNBVwC73rGRNtpvKaaO36thHEM1Vois2sqwaV9sZDelqYqOVhqWt8OFPr
	f/ZvfJYE52lomb7TK6CH/lAH5WWYGA+9km3b0z9OJB90wH+rh0MO8TGgFsCiyKkYopJnw5IYCYStv
	LAbppX3xvU0s2YUejxGbhwShBKFTpG+0tmglfB4jJizxu/orZucU45TCR+DGZayAAt2SI99+2ogca
	iagcMsZhO2gzUkxMSM0rrKtCC3atn4aYLM7ovFLK1rJ7e59SAKyXGgF67krexe2XeItj3fvEJA38L
	OsXntoHw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48556 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rQtZe-001yC5-0h;
	Fri, 19 Jan 2024 12:26:38 -0600
Message-ID: <b75129be-04fc-4818-a9f9-eb35dca4b689@embeddedor.com>
Date: Fri, 19 Jan 2024 12:26:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: pinctrl-zynqmp: Use devm_kcalloc() instead of
 devm_kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Linus Walleij <linus.walleij@linaro.org>, Michal Simek
 <michal.simek@amd.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240119181909.7079-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240119181909.7079-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rQtZe-001yC5-0h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48556
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOFcxrZte660ZNfZwNIjJPzo4rCzL9FGTTQU3Swpa+2g6MBsUQqXcfUEilLj9WxbYuXzs8azylcZxq/fXLPHazPcNZmZfY9F5BxuFO2T5N9IgrZyK7/z
 K+sqjmifWELmLEa6POnfAx0fCnS0iUo7fSAvXrOyo+j73GSYvaQXUw3Em22TZ6rOJR1Ugj4Pg7rk7G2rk+0gMUBO4dRylsK1isog2i00i45UoptriFQeIm69



On 1/19/24 12:19, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific devm_kcalloc() function instead of the
> argument size * count in the devm_kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/pinctrl/pinctrl-zynqmp.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
> index f2be341f73e1..5c46b7d7ebcb 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -562,7 +562,7 @@ static int zynqmp_pinctrl_prepare_func_groups(struct device *dev, u32 fid,
>   	const char **fgroups;
>   	int ret, index, i;
> 
> -	fgroups = devm_kzalloc(dev, sizeof(*fgroups) * func->ngroups, GFP_KERNEL);
> +	fgroups = devm_kcalloc(dev, func->ngroups, sizeof(*fgroups), GFP_KERNEL);
>   	if (!fgroups)
>   		return -ENOMEM;
> 
> @@ -754,7 +754,7 @@ static int zynqmp_pinctrl_prepare_function_info(struct device *dev,
>   	if (ret)
>   		return ret;
> 
> -	funcs = devm_kzalloc(dev, sizeof(*funcs) * pctrl->nfuncs, GFP_KERNEL);
> +	funcs = devm_kcalloc(dev, pctrl->nfuncs, sizeof(*funcs), GFP_KERNEL);
>   	if (!funcs)
>   		return -ENOMEM;
> 
> @@ -768,7 +768,7 @@ static int zynqmp_pinctrl_prepare_function_info(struct device *dev,
>   		pctrl->ngroups += funcs[i].ngroups;
>   	}
> 
> -	groups = devm_kzalloc(dev, sizeof(*groups) * pctrl->ngroups, GFP_KERNEL);
> +	groups = devm_kcalloc(dev, pctrl->ngroups, sizeof(*groups), GFP_KERNEL);
>   	if (!groups)
>   		return -ENOMEM;
> 
> @@ -830,7 +830,7 @@ static int zynqmp_pinctrl_prepare_pin_desc(struct device *dev,
>   	if (ret)
>   		return ret;
> 
> -	pins = devm_kzalloc(dev, sizeof(*pins) * *npins, GFP_KERNEL);
> +	pins = devm_kcalloc(dev, *npins, sizeof(*pins), GFP_KERNEL);
>   	if (!pins)
>   		return -ENOMEM;
> 
> --
> 2.25.1
> 
> 

