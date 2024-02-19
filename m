Return-Path: <linux-kernel+bounces-71840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7085AB62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69661C21D54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326DF482FA;
	Mon, 19 Feb 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UuCzQEkK"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A741C78
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368476; cv=none; b=G8/+IjhwpptC2R7QBMLHTAC6CmnV+hsbMWD02PAp933VFEmnE/Z/MUTrz/+TMr6RFQ3MRNwu/UtIB0+7TNj2oOzuCM1wX8jURLCIp3Y134xEm6fYGWSRCW/+r6a+MFE0t+FbGQ0siRk9ghtWut8thx++RuwY6O+dWANSNAW+3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368476; c=relaxed/simple;
	bh=gg32L9SW51TCVEIcz5TJ3+5Ik5TcvDzFXrh6AEcBGn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmyEigW7Gmok3S10HQ7ill3E3y+0d2fIde8US1j+CY/Qp26HqdY5VhNIBQOjEII098fcgkWZDm4xPrv5LmNep9KJWsJWvMTXrpIJIGXkNSmfb30Wxx5t0dEvoYnqh5dGNaniszgW+U+D9uCtCz7YxKXScmb+KPcGj43hrpBJ5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=UuCzQEkK; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id c3hnr9wzu9gG6c8g7rObtI; Mon, 19 Feb 2024 18:47:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id c8g6rH8gBcr2pc8g6r7D1x; Mon, 19 Feb 2024 18:47:46 +0000
X-Authority-Analysis: v=2.4 cv=W56bVgWk c=1 sm=1 tr=0 ts=65d3a252
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=VSjF23E3Ok2ZiNtq:21 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10
 a=VwQbUJbxAAAA:8 a=hpmp6n0Fncvi9LRvqokA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PsUWlBLUfZeSjk+Yv21JCfUUB/vLVf1BaKRuAmYHUeo=; b=UuCzQEkK7vHOFykbSc9v990Ogl
	NAB8YOvszb6OOJidZ4Yp43lBZgqAoSUSYiLUnc5d3IMdxbWsGrR+bL4gmPSQ+dVgJyh8wD43KouWm
	TpFRBhC7CmnaaW3u7rGihpPgM+gIxbJG60M21G81RHJqA8zb3Azvp9GmNgpYSkX+X9Ymz5eM0Eo7I
	vCInVKdGqPPKyOKoL88Xm1F6w+ROJPDY6wq0nhNePvWxBthCnzSsQgH2184A6PsGwM0cJixX9y75N
	ZWOTW1gUtkMr+uJvIdd3rQtxiY/iKnI67TDWBJAqtfC9POiBgzWT5+e98bmPcVhTQeQCtgwGgTcti
	cHw5qIYQ==;
Received: from [201.172.172.225] (port=57308 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rc8g5-002Aa2-1q;
	Mon, 19 Feb 2024 12:47:45 -0600
Message-ID: <292b9fb0-5661-488b-a52a-d5e7dbb3dc45@embeddedor.com>
Date: Mon, 19 Feb 2024 12:47:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] udmabuf: Fix a potential (and unlikely) access to
 unallocated memory
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 keescook@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <f75d0426a17b57dbddacd7da345c1c62a3dbb7ce.1708278363.git.christophe.jaillet@wanadoo.fr>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <f75d0426a17b57dbddacd7da345c1c62a3dbb7ce.1708278363.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rc8g5-002Aa2-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:57308
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB1dc0kfdRAir02c/WvigyTTumhdfMB3wEOsjxdgeqR5PBk8baiKYMSArTc1Fcs/EV164rtcu1qCvV8Ckdghoq5MpAdgFLKbunjg2mkpwMUbz2rZfDCT
 uVWe1GWo8edNmFdioYzrWxPn2Ix7s4Z+eq9gT+9Yw1yvLDFTCHFtqWmZaew1RX09NUR9H2GGqOtLFNqteJ+UZduk/M4Y5a+h+fdAAU49BYGgWhIbrMCudjpx



On 2/18/24 11:46, Christophe JAILLET wrote:
> If 'list_limit' is set to a very high value, 'lsize' computation could
> overflow if 'head.count' is big enough.
> 
> In such a case, udmabuf_create() would access to memory beyond 'list'.
> 
> Use memdup_array_user() which checks for overflow.
> 
> While at it, include <linux/string.h>.
> 
> Fixes: fbb0de795078 ("Add udmabuf misc device")'

I don't think this tag is needed in this case.

Also, please, CC linux-hardening next time.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

In any case, LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> v2: - Use memdup_array_user()   [Kees Cook]
>      - Use sizeof(*list)   [Gustavo A. R. Silva]
>      - Add include <linux/string.h>
> 
> v1: https://lore.kernel.org/all/3e37f05c7593f1016f0a46de188b3357cbbd0c0b.1695060389.git.christophe.jaillet@wanadoo.fr/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/dma-buf/udmabuf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index c40645999648..5728948ea6f2 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -11,6 +11,7 @@
>   #include <linux/module.h>
>   #include <linux/shmem_fs.h>
>   #include <linux/slab.h>
> +#include <linux/string.h>
>   #include <linux/udmabuf.h>
>   #include <linux/vmalloc.h>
>   #include <linux/iosys-map.h>
> @@ -314,14 +315,13 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
>   	struct udmabuf_create_list head;
>   	struct udmabuf_create_item *list;
>   	int ret = -EINVAL;
> -	u32 lsize;
>   
>   	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
>   		return -EFAULT;
>   	if (head.count > list_limit)
>   		return -EINVAL;
> -	lsize = sizeof(struct udmabuf_create_item) * head.count;
> -	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
> +	list = memdup_array_user((void __user *)(arg + sizeof(head)),
> +				 sizeof(*list), head.count);
>   	if (IS_ERR(list))
>   		return PTR_ERR(list);
>   

