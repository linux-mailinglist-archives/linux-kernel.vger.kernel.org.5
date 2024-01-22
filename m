Return-Path: <linux-kernel+bounces-33715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81221836D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68991C27BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC55823B;
	Mon, 22 Jan 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="CpdmXFW1"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C333FB3B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941962; cv=none; b=UN79r5CRc88y7+1cEq3ru92Xb5Sri6Tf4oxWX/cB4BLSUsHOl69F3IdhUH2peAdT0JnzGMPbMUU0eTR25c4mn1dCRgnEHAOesvZefGtaVDsBKg57Dd+vvBzdBtoWOD6DcVrxpwDcYK5w01upmdj6xD/ERUoyv7qkyRnfZQeD2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941962; c=relaxed/simple;
	bh=bOmyxojR3+oXa6teSWZQqPnpcVJXl6gQ3beLTvYaNNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4kUsbExu4IjHVouMXOXM6igsm2RX+TJVDRsHYB9BUqbBSI6bffqh0lXk07mPX9S3jgRGbH6jYUAe9mcJCG63q4tjEqBtbqg3UDZ+y1w/FdGKR4nDTKU+rGQZJVaHVZBK2uemAN1o7AebuuYjwvZiSnz3ha+ZknMfX6k1aLPYuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=CpdmXFW1; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id Rvn5rVXc4CF6GRxQprKVzZ; Mon, 22 Jan 2024 16:45:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RxQnrlFQ2WRcnRxQorUfT8; Mon, 22 Jan 2024 16:45:54 +0000
X-Authority-Analysis: v=2.4 cv=OPo0YAWB c=1 sm=1 tr=0 ts=65ae9bc2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=ps32sclX-u3JLzBWafQA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xUmqrSRHbxv53MrhsbK61lfGw0UBXJAtEIXR6/E0CJU=; b=CpdmXFW14Ut65dA/d7TajA+NjN
	er+uzY2rdtSFEn/ege72uebuTI1K4TtaeCE+EjzE6QR7HDsTUNJIz2zfdNAkb2cPCOtToqekVQBen
	C/LIZLfjnWTKu5c3745w8D6zdWTWAu+3Ep/fLdxBIkneE1b+wNHs439HZKydo/5qnYQnKKvpLpkWF
	q9njQKFarI31OvYq+S4H31FFF+1eoglpskI/FYjupjdJg4ZhWC91MhFB9QpNRsGQfoKN4815Wn+Pr
	B1OKXWD5dNWaoPbo+7jKOjNq8KfhrfRb8nh0IazN2PaOeCLYbvko7W8pip3xxqnnf85UKRaJDGAWW
	eZL7322Q==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56808 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rRxQn-004JlJ-0e;
	Mon, 22 Jan 2024 10:45:53 -0600
Message-ID: <91e87233-3a10-43d6-b850-9cac083913e0@embeddedor.com>
Date: Mon, 22 Jan 2024 10:45:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/habanalabs: use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, Oded Gabbay <ogabbay@kernel.org>,
 Marco Pagani <marpagan@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240120151028.11092-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240120151028.11092-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rRxQn-004JlJ-0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:56808
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCrQyQz/dcPplon9VM583oWXpem3Kj18GYyY/toKtSYLCdRAmBT0AZV6zvA+16MVt0C/Kw9Y48u1ywMV02qaABX3hUBWk/SqmvqU21Mc4M0KQG6su5qJ
 4HUx4KRpSzHnD7sLB/HOYFxBo+y+rXXipMHGSstCJyCAwINp2M0U62xlbIBffFMaWhdLQIKcOSNi9dJH5wlwXj4jS8gWQrrbWRw9GoybbdFT9Ef/ucWzGOJK



On 1/20/24 09:10, Erick Archer wrote:
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
> 
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/accel/habanalabs/common/mmu/mmu_v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/habanalabs/common/mmu/mmu_v1.c b/drivers/accel/habanalabs/common/mmu/mmu_v1.c
> index d925dc4dd097..e3d42cfead27 100644
> --- a/drivers/accel/habanalabs/common/mmu/mmu_v1.c
> +++ b/drivers/accel/habanalabs/common/mmu/mmu_v1.c
> @@ -232,7 +232,7 @@ static int dram_default_mapping_init(struct hl_ctx *ctx)
>   	/* add hop1 and hop2 */
>   	total_hops = num_of_hop3 + 2;
> 
> -	ctx->dram_default_hops = kzalloc(HL_PTE_SIZE * total_hops,  GFP_KERNEL);
> +	ctx->dram_default_hops = kcalloc(total_hops, HL_PTE_SIZE,  GFP_KERNEL);
>   	if (!ctx->dram_default_hops)
>   		return -ENOMEM;
> 
> --
> 2.25.1
> 
> 

