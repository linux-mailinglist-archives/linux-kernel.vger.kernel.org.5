Return-Path: <linux-kernel+bounces-59106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225CC84F142
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1426286E1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547D65BA9;
	Fri,  9 Feb 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U5lzR8mR"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49F657BD
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466513; cv=none; b=sqrmRGXov7xwZF6GVPaBnPVTl4jk/RJB5ItmrAX9WhUXVhB8SicGytNkJknaWxXHSsoGznk/WyaOlszC4lDh7BCC4LmuvphZLHROMWCe4p7c4ZT2nmRbw2Mhj5tO+/wstzoY3ohxE9utnRl2pyKqKY4lPa9uAyec3JPJi5oZzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466513; c=relaxed/simple;
	bh=V/RLsGt5IQ7HbBSCr94mETHaJnfRVgd3iBKPAAiLhu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UdgDE4hQEGoxQWtDsuWmOXC3seKVJbu/+E/0imYrtYRlOCeGI7XH3pRqKbhYXPbZoRuwNo7T3pHZLOokJR1IfdqnROPPIRVWHmovgJZeDzfVxjiqSDsemJ4atzwjaGxMDZJ79z86OUu82Ty6RXnY+PzbmjwIlIfqsq1UlGWPc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U5lzR8mR; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240209081503euoutp01b67839838e2c77ed2d1ec682d120346d~yI7z1lvLb0111101111euoutp01W
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:15:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240209081503euoutp01b67839838e2c77ed2d1ec682d120346d~yI7z1lvLb0111101111euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707466503;
	bh=k0g5mLY2RIWhe68RUX5KOltTa8H8LYx1cxbgQTitZt4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=U5lzR8mRZNzwAPR530U8VRGOD/ju0rwoc7KLKMfX+2S/0uqTIZPhZVsME3bkFsWaA
	 8cMJRxjrb7vJPgQ7Si7AW0VEN3YCACUoyA5YFEr/0doJdvp6iV4auf1hu1hlrNECOP
	 7uCNsBOrNMA+b6XLFnzVC0IKd6/lSgG+M/JQrOQg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209081503eucas1p2d779f48670b96ca1e19a200cf463fce8~yI7zrJytT0354903549eucas1p2G;
	Fri,  9 Feb 2024 08:15:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D7.5A.09552.60FD5C56; Fri,  9
	Feb 2024 08:15:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240209081502eucas1p1b4a29a1849cc2ecf69d8ec6680002433~yI7zNOGMF0137501375eucas1p1x;
	Fri,  9 Feb 2024 08:15:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240209081502eusmtrp2ecc630971347ddb2d0889df100f96399~yI7zMOrzZ0491704917eusmtrp2Q;
	Fri,  9 Feb 2024 08:15:02 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-2d-65c5df065cfb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F8.83.10702.60FD5C56; Fri,  9
	Feb 2024 08:15:02 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240209081502eusmtip2fc1895eacb2d3f11fb5fd1083a2d90e5~yI7y0ZKnE0958909589eusmtip2F;
	Fri,  9 Feb 2024 08:15:02 +0000 (GMT)
Message-ID: <e4945d3d-f5a4-46c6-ab1e-937e19721e1f@samsung.com>
Date: Fri, 9 Feb 2024 09:15:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 wq/for-6.9] async: Use a dedicated unbound workqueue
 with raised min_active
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZcVuWLKN8OHRQuRx@slm.duckdns.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOV22+0dTDbpbzC2mrt3NZHF51xw2
	izOnL7Fa/Fp+lNGBxWPnrLvsHptWdbJ5bLnazuLxeZNcAEsUl01Kak5mWWqRvl0CV8aBv4uY
	Cp5IVpz5+oWtgfGBSBcjJ4eEgInEmVcz2LoYuTiEBFYwSkybvY0ZwvnCKHF72msWCOczo8TR
	t9NYYVou7fjIBJFYzihx6+gaqKqPjBKzv55gAqniFbCTeDn5JCOIzSKgItH/cg8jRFxQ4uTM
	JywgtqiAvMT9WzPYQWxhgVSJnUsmgMWZBcQlbj2ZDzZHREBW4sq0h0C9HEDxYomVD4RAwmwC
	hhJdb7vYQMKcAvoS0/7EQXTKS2x/OwfsAwmBPRwS21tWs4PUSAi4SHTdDoW4X1ji1fEt7BC2
	jMT/nfOZIOrbGSUW/L4P5UxglGh4fosRospa4s65X2wQN2hKrN+lDxF2lNjzfzkTxHw+iRtv
	BSFu4JOYtG06M0SYV6KjTQiiWk1i1vF1cGsPXrjEPIFRaRZSmMxC8vssJN/MQti7gJFlFaN4
	amlxbnpqsXFearlecWJucWleul5yfu4mRmBiOf3v+NcdjCtefdQ7xMjEwXiIUYKDWUmEN2TJ
	kVQh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGpvyj9+/s
	MzideHyX6LrT6/TCKtzcdO5x/3u6wf7WpbXrvqtNEPGafW3HM6n1W1MWlXe5HjrLs9f7rSnL
	9v6VFsFNh5e0x/z91/PFMWIy8/d4FTdLkfVb97at/FL+ZmKbeI7NlJYAheubc1WFD148dHnb
	mvSYGsVn59MarVUs/aVLJM0nK3/+a/YvLX/ywj/TFE8r1/DNcMsW9lr+ZI3N/4NMnE9+SftX
	rZhgc6DloUL1xteMB86d7mO5KyM+I2JjmvZppgU9fjpu6w72ftww33+eqv1drqV9P3aVyp6t
	Up5x2D1/PZfzpvMuZ55aLbvkFT1fUfY8S5bWnqf38k2nN66ynNg0oVbTmvX04QiL2zJKLMUZ
	iYZazEXFiQAmum9+mwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7ps94+mGkxbKmExde1uJovLu+aw
	WZw5fYnV4tfyo4wOLB47Z91l99i0qpPNY8vVdhaPz5vkAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIO/F3EVPBEsuLM1y9sDYwPRLoYOTkk
	BEwkLu34yNTFyMUhJLCUUWLz07usEAkZiZPTGqBsYYk/17rYQGwhgfeMEm+OCYHYvAJ2Ei8n
	n2QEsVkEVCT6X+5hhIgLSpyc+YQFxBYVkJe4f2sGO4gtLJAqsXPJBLA4s4C4xK0n85lAbBEB
	WYkr0x4yQsSLJU7sbmOFOGg5o8SsddPAFrMJGEp0vQU5goODU0BfYtqfOIh6M4murV1QvfIS
	29/OYZ7AKDQLyRmzkKybhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjadux
	n1t2MK589VHvECMTB+MhRgkOZiUR3pAlR1KFeFMSK6tSi/Lji0pzUosPMZoCw2Iis5Rocj4w
	mvNK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphmc7GuZ9zKb77j
	/qP2k/MYbqyTuaj/MPOnS3zbKuO8NKbY/+tTNxhuzVjGH8YkZnv0WgfTvZpqm+tvIrZu91/x
	wyfgfhfbhQCLWrf8aRfPNsQrMshW6Adph5ee3qeV6Zl9at3vukMh3WbBy+/NkF0tLLZ17xR7
	1fJPH1+0Sqz/vLH9Xo9GYXbTi9WO94Xcfz96uKh2q//LQJXqc/dTguee6SnMS0t1dk2ok9SZ
	ecZ3vrZ66N8+noVVRVEhsYw6YRlV0lNy7z4+wvK1UaiFp09f++KOvxUfb13O7c8rs9+xeO+v
	Q6d+1l8u3OKrkLy450iviurUfslK7of222aLbvZO073+JKE32yndimVmkBJLcUaioRZzUXEi
	AA74FjsuAwAA
X-CMS-MailID: 20240209081502eucas1p1b4a29a1849cc2ecf69d8ec6680002433
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240209001422eucas1p252a0c403258d107c653c7f2bfbe49f4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209001422eucas1p252a0c403258d107c653c7f2bfbe49f4c
References: <ZcVtzJvJCRV5OLM-@slm.duckdns.org>
	<CGME20240209001422eucas1p252a0c403258d107c653c7f2bfbe49f4c@eucas1p2.samsung.com>
	<ZcVuWLKN8OHRQuRx@slm.duckdns.org>

On 09.02.2024 01:14, Tejun Heo wrote:
> Async can schedule a number of interdependent work items. However, since
> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for
> unbound workqueues"), unbound workqueues have separate min_active which sets
> the number of interdependent work items that can be handled. This default
> value is 8 which isn't sufficient for async and can lead to stalls during
> resume from suspend in some cases.
>
> Let's use a dedicated unbound workqueue with raised min_active.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Link: http://lkml.kernel.org/r/708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
> Hello,
>
> Marek, can you please see whether this solves the hang while resuming? If it
> does and Rafael is okay with it, I'll route this patch through wq/for-6.9.

Works fine here and fixes the suspend/resume issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> Thanks.
>
>   include/linux/async.h |    1 +
>   init/main.c           |    1 +
>   kernel/async.c        |   17 ++++++++++++++++-
>   3 files changed, 18 insertions(+), 1 deletion(-)
>
> --- a/include/linux/async.h
> +++ b/include/linux/async.h
> @@ -120,4 +120,5 @@ extern void async_synchronize_cookie(asy
>   extern void async_synchronize_cookie_domain(async_cookie_t cookie,
>   					    struct async_domain *domain);
>   extern bool current_is_async(void);
> +extern void async_init(void);
>   #endif
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1545,6 +1545,7 @@ static noinline void __init kernel_init_
>   	sched_init_smp();
>   
>   	workqueue_init_topology();
> +	async_init();
>   	padata_init();
>   	page_alloc_init_late();
>   
> --- a/kernel/async.c
> +++ b/kernel/async.c
> @@ -64,6 +64,7 @@ static async_cookie_t next_cookie = 1;
>   static LIST_HEAD(async_global_pending);	/* pending from all registered doms */
>   static ASYNC_DOMAIN(async_dfl_domain);
>   static DEFINE_SPINLOCK(async_lock);
> +static struct workqueue_struct *async_wq;
>   
>   struct async_entry {
>   	struct list_head	domain_list;
> @@ -174,7 +175,7 @@ static async_cookie_t __async_schedule_n
>   	spin_unlock_irqrestore(&async_lock, flags);
>   
>   	/* schedule for execution */
> -	queue_work_node(node, system_unbound_wq, &entry->work);
> +	queue_work_node(node, async_wq, &entry->work);
>   
>   	return newcookie;
>   }
> @@ -345,3 +346,17 @@ bool current_is_async(void)
>   	return worker && worker->current_func == async_run_entry_fn;
>   }
>   EXPORT_SYMBOL_GPL(current_is_async);
> +
> +void __init async_init(void)
> +{
> +	/*
> +	 * Async can schedule a number of interdependent work items. However,
> +	 * unbound workqueues can handle only upto min_active interdependent
> +	 * work items. The default min_active of 8 isn't sufficient for async
> +	 * and can lead to stalls. Let's use a dedicated workqueue with raised
> +	 * min_active.
> +	 */
> +	async_wq = alloc_workqueue("async", WQ_UNBOUND, 0);
> +	BUG_ON(!async_wq);
> +	workqueue_set_min_active(async_wq, WQ_DFL_ACTIVE);
> +}
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


