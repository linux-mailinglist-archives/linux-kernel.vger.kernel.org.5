Return-Path: <linux-kernel+bounces-33874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33CF8371EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E30BB34447
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749E74F5FF;
	Mon, 22 Jan 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="c6iGIMVa"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711254F5E4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946031; cv=none; b=DgtXUFZjSgXM2dPvkqa9DWfInpBxskfSE1R8907HPTpL2WX8OnxdVJBQ+YpkPCvm7W1V4DbqZBWgiFaGNElZddpnJTDgbP0HSH7mhomtCvX2h9QMUIHKuT8rlIiLKGrtvuOBBLwbgySVYzc/wLM09iESAvIxNK2DSc1H7pAWjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946031; c=relaxed/simple;
	bh=qELrPQW+cBpnYsG2PAKmtPwimyiW6brT7BtW/BMBCtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK1L9drCl652l4ZqJOWQtQ5pYezajWmhBz2B8rripM5qfbWpZVWTBK5e/YbCQU8IPhz3tz/fWDXFWi/VmoOriS8/R1JREny8+iYcQ8NpsLeW35SM7lpMEdWdcArmU0pViqm8c9G4xgQZojy73AqFGMzKDFEoycTz35QDIUtvP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=c6iGIMVa; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id RvUnrtZv680oiRyUYrTzpr; Mon, 22 Jan 2024 17:53:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RyUXrovMRyxR5RyUXrGB9p; Mon, 22 Jan 2024 17:53:49 +0000
X-Authority-Analysis: v=2.4 cv=JYOvEGGV c=1 sm=1 tr=0 ts=65aeabad
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=CsOLvDfn09n0XjjTB6sA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HnBhTN2Qswqklqa5h1VDuRxzPmCKbJjTZLHYO8QIxWw=; b=c6iGIMVa+eG37rAI6qKtUzqRcp
	xGUl5ldFfByNWlilB8Oci0BltbK/89REty8IxwtOM53jwd8dt7qtz4HUZFwfFZz4TwGM8PRk7Nccr
	bTB1b1SDEVPpM0jaR70qY1yCd10aQwNwnUKD6krMawX3LRfB1RrnHPaXPOilmXqqsU8anGCKrMSce
	AEXt+dX2wNOkHRZvvc8NGKtF/gUWNQNWhhp9P5YUWEZyi2WgW3+4U//FTxWDbj+7XHPlBimHWxVPa
	rM1kmIwpaGgANpVwiNUXvoCNlZuKbL7Czw3PlRgFvums82syh0gKtA8N1oDJuFlCbx8lYzWXDSpfv
	ANG431Hw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:37538 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rRyUV-001MU8-17;
	Mon, 22 Jan 2024 11:53:47 -0600
Message-ID: <cb313841-4540-419a-bb89-5ae806df12b7@embeddedor.com>
Date: Mon, 22 Jan 2024 11:53:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: sun8i-ce - Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240121153407.8348-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240121153407.8348-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rRyUV-001MU8-17
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:37538
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 40
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGvK75E4f2xrmLhAnasG3twN9lEppEBlYTGi3llgrnrwvb9fn0uT6cd7NvF9v8Y+sX/g4wjLlxpuTk0u9SOYoI/bOkUA7jhVfOT7o7iwWc4B2mLMwv0A
 avCgSEXnLFIOYZi6PFI9ZdAnmXfZhYIoDtT/IAQfGPh1zcRmR8MlvuDON7oJXpiYgHxGOUdo2s26iLQjxIQYqGhdT7tUusQUYScVcCx/ORSlI+tAY/55k4Iq



On 1/21/24 09:34, Erick Archer wrote:
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
>   drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
> index d358334e5981..ee2a28c906ed 100644
> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
> @@ -362,7 +362,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
>   		digestsize = SHA512_DIGEST_SIZE;
> 
>   	/* the padding could be up to two block. */
> -	buf = kzalloc(bs * 2, GFP_KERNEL | GFP_DMA);
> +	buf = kcalloc(2, bs, GFP_KERNEL | GFP_DMA);
>   	if (!buf) {
>   		err = -ENOMEM;
>   		goto theend;
> --
> 2.25.1
> 

