Return-Path: <linux-kernel+bounces-33852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F59836F83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E318F1F26FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03547F74;
	Mon, 22 Jan 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="n3+7wiRP"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CA47F6D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945537; cv=none; b=HjVoW7wPrtdaNFnwmreLumRx4hYVMW+sKs4GQj7TXAh5mjkmE9Q9BcLzRf5dy18EbDfKA3JszX8/iljIyVl5gf+12iZZK6UVnNx1okwUe1Tz2u+qTtr7mQyrzlTLs+9cFxbFn4CGHE4V54OqQxr5nRkCjRkhVefik4Ik2aXnoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945537; c=relaxed/simple;
	bh=abkKMctWm+0H/J5RM4zZHydX48MCx7/fwQLGgVanmtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7uv3Ac81dV5/I7x6+GgaWHOG730LfNZMoAq7ryeDvDrk8pnXF4pEKXxbowkkNnfdLqIRTwgFI1s+kW5mPyijV5goEWT4eKDTZNU09vjyJ7Nz+5xJowP1G+WF5kU2HQBhtpNyhGDY4IF6e4hg1XcQLwZAikI0gMRjvdPupPolPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=n3+7wiRP; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id Rr63rl05vTHHuRyMTrd3Xx; Mon, 22 Jan 2024 17:45:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RyMRroodFyxR5RyMSrG4iT; Mon, 22 Jan 2024 17:45:28 +0000
X-Authority-Analysis: v=2.4 cv=JYOvEGGV c=1 sm=1 tr=0 ts=65aea9b8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=lWKqt4ZwYMmOSQLAUVkA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nzXgY+4E9/m1cHPFb6LChwOFY++sdTtbwz4YGbTrgRc=; b=n3+7wiRP+JuxvMMGo4qhp0XaKk
	ntYdQmu1vPL0HRLzb0Xjgsu5gVfpRgPAGCi3iU7g3a6+4XzF7KY0H8WEyi7NVc5ZUK/6ODe+JJL03
	gtl7koEXVSWVIxh9BrwWRdPNYICBEOgSEObEJZlMzWGTOJ6IaFoKW9NboFe+oloOUicVrmpSYhjOb
	3jZzqCJBY622cN9gleh/XZFh/AA723zNBf0XJ3XKDB/GCecp/YKxFp6teZmmLNwinrAit76vPFEIJ
	bowEh1zBADupQW7qH+6hWqsJONUbtRHWyLVuYFSE928EK5739PtY9OgrFeSAV2zBYRDzeDaoUgvA+
	2U6fAAMA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:41722 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rRyMP-0019jE-22;
	Mon, 22 Jan 2024 11:45:25 -0600
Message-ID: <fd635112-c960-49a9-807f-692f47be46ed@embeddedor.com>
Date: Mon, 22 Jan 2024 11:45:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>, Evan Green <evan@rivosinc.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Jisheng Zhang <jszhang@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240120135400.4710-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240120135400.4710-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rRyMP-0019jE-22
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:41722
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN8/pIlWIKBW4ux84Ow4ukmeD9/F19s8ExlF4OFTXP/pj3UJjWv3HBmWJOQ4xNV9k+GUDgkb1ZRY6uP8OFCZ6vb+4YHtP8KVGdOQKfrgi/vN6arqGzst
 NJdjSV6ZhX1H16qcXTReh/PNYjNcOom7j/8XXbanIUuL7coxhV14yMfZqemt/Oi9fyjx68g6iUiEuppvuiGzFCt5AR25GLpaa+5yzd4GpfLn6hQjZ7XiiceZ



On 1/20/24 07:54, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> count * size in the kzalloc() function.
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
>   arch/riscv/kernel/cpufeature.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 89920f84d0a3..549a76e34c4e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -901,8 +901,7 @@ static int check_unaligned_access_all_cpus(void)
>   {
>   	unsigned int cpu;
>   	unsigned int cpu_count = num_possible_cpus();
> -	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
> -				     GFP_KERNEL);
> +	struct page **bufs = kcalloc(cpu_count, sizeof(*bufs), GFP_KERNEL);
> 
>   	if (!bufs) {
>   		pr_warn("Allocation failure, not measuring misaligned performance\n");
> --
> 2.25.1
> 
> 

