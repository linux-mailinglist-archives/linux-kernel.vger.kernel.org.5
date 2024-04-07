Return-Path: <linux-kernel+bounces-134581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538489B337
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D771F22CF4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705F3B799;
	Sun,  7 Apr 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zeopEdwY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282B107A6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712509750; cv=none; b=axK5ciLpW/NIWJ8rFKvkGen5vIgFZL5otIJMv29k6fsrl8RPLvZ6ioUT//dEnFAQcNcj8VTlxSBA7v1cRSknuFY5E+KRGByzH0sSGIyiWNg73+FPv0buFx+tjWzqNLfP8cOV9VRZmHbhrO1a3JEB+mNJZWfAu37Y+ZJFuqatxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712509750; c=relaxed/simple;
	bh=S9/3JO9TeaSCAj/8BaE5Jp++Lqmn+jXiyt91rBvv5JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiRcnnq/ITTq1TP5W59MMjL7ZggNYV1kSyvuo4W3WFRGi14wgno/gXe0mBXYzYiokkgVjMHZAxppTNnY1bYT7xN+MpcVUZNYoDE2lfJ1ys4kJTmnXIM6LlX37oc7ZUCpT1Rpn7E9isk6YFV4gF+6hhdcIYmoQZu0hqc8k7SEwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zeopEdwY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+fxnBVhanUSoVIeyzpQeK27okAoyT0oHwXLPuW0J+sI=; b=zeopEdwYPtTXjsU6dTEoVTCB0j
	sF1dnlC1A4bHIZtRRTwyNwwGlO1AawXs3nJz6E0inBC4GRNKURR4RKdxvQcdLR3ccG7HH6r45HEVX
	MzaYTvd8OIO+soGjAwH8s3kO+Tuj5aQUKyqdfI0vfGwHNfhAZPvO66TWDHCCrVIQNgQgDw63MHaP/
	Yqd2WKWT1ajPBcExTdhy+dxjr4AFTlmi4YI8VzRhHz38aK2FUgZc0D639g2LDKMN6UyVrUOa1gCiR
	XHsNRtVoh4oQ6uyy6fe/wicRcVC5A6lavpyZRDE2JHUE+cD6IXCHTnR5JsFPcEk8muiijB2YI7Mzy
	lX4FLKrA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtW0u-0000000D6z8-2cT9;
	Sun, 07 Apr 2024 17:09:04 +0000
Message-ID: <adbb10d5-fa43-4d58-9395-0c574e3c3d7e@infradead.org>
Date: Sun, 7 Apr 2024 10:09:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/3] powerpc: Fix kernel-doc comments in fsl_gtm.c
To: Yang Li <yang.lee@linux.alibaba.com>, arnd@arndb.de, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
 <20240407063952.36270-2-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240407063952.36270-2-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/6/24 11:39 PM, Yang Li wrote:
> Fix some function names in kernel-doc comments.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/powerpc/sysdev/fsl_gtm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
> index 39186ad6b3c3..71e07883eb48 100644
> --- a/arch/powerpc/sysdev/fsl_gtm.c
> +++ b/arch/powerpc/sysdev/fsl_gtm.c
> @@ -77,7 +77,7 @@ struct gtm {
>  static LIST_HEAD(gtms);
>  
>  /**
> - * gtm_get_timer - request GTM timer to use it with the rest of GTM API
> + * gtm_get_timer16 - request GTM timer to use it with the rest of GTM API

ack

>   * Context:	non-IRQ
>   *
>   * This function reserves GTM timer for later use. It returns gtm_timer
> @@ -110,7 +110,7 @@ struct gtm_timer *gtm_get_timer16(void)
>  EXPORT_SYMBOL(gtm_get_timer16);
>  
>  /**
> - * gtm_get_specific_timer - request specific GTM timer
> + * gtm_get_specific_timer16 - request specific GTM timer

ack

>   * @gtm:	specific GTM, pass here GTM's device_node->data
>   * @timer:	specific timer number, Timer1 is 0.
>   * Context:	non-IRQ
> @@ -276,7 +276,7 @@ EXPORT_SYMBOL(gtm_set_timer16);
>   * crop precision of the "usec" argument, thus usec is limited to 16 bits
>   * (single timer width).
>   */
> -int gtm_set_exact_timer16(struct gtm_timer *tmr, u16 usec, bool reload)
> +int gtm_set_exact_utimer16(struct gtm_timer *tmr, u16 usec, bool reload)

No, change the kernel-doc comment instead. Otherwise the caller will fail to link.

>  {
>  	/* quite obvious, frequency which is enough for µSec precision */
>  	const int freq = 1000000;

thanks.
-- 
#Randy

