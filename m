Return-Path: <linux-kernel+bounces-11909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACA81ED66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861B41C215A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642B363AB;
	Wed, 27 Dec 2023 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oO4cZV8v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6563AA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231227084254epoutp037d5c7bed4b3b86f0897183a357e41e47~ko7kfq_-10919109191epoutp03O
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 08:42:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231227084254epoutp037d5c7bed4b3b86f0897183a357e41e47~ko7kfq_-10919109191epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703666574;
	bh=+Kz/Z3fMfb1cx6g4LUoRDFlMDohNAWjBOumy3g83zQM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=oO4cZV8v/F6swxRbgLe4SMGny2MwlBDlxwNbcDucX9JXTWhk7dMq7g9NDamheAWX8
	 xDbnecBxzPXwWNA/P5Iyf6svKRDMfEjf7zjsw6bZumAP8M0YEMKaHOZ02+0Ua22Blw
	 O3hh9iZQe8AdBTpfXlm20lyz0BMMvHv9lyz//7qk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231227084254epcas2p4342ca3223955fb46c1739d78a09fc5a6~ko7kKCkyW1635216352epcas2p4C;
	Wed, 27 Dec 2023 08:42:54 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T0QBj1ydMz4x9Q2; Wed, 27 Dec
	2023 08:42:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	0A.F4.09607.D83EB856; Wed, 27 Dec 2023 17:42:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4~ko7i7su3G1038510385epcas2p3h;
	Wed, 27 Dec 2023 08:42:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231227084252epsmtrp1de7f2112b33f11d0c3df6b542d51797b~ko7i65ER-0164401644epsmtrp1T;
	Wed, 27 Dec 2023 08:42:52 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-3d-658be38d81a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CC.82.07368.C83EB856; Wed, 27 Dec 2023 17:42:52 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231227084252epsmtip2878d2e3e8c86286f024c2c64a130c077~ko7ipu2T-0762607626epsmtip2Z;
	Wed, 27 Dec 2023 08:42:52 +0000 (GMT)
Date: Wed, 27 Dec 2023 17:42:50 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
	gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	d7271.choe@samsung.com, janghyuck.kim@samsung.com, hyesoo.yu@samsung.com,
	youngmin.nam@samsung.com
Subject: [BUG] mutex deadlock of dpm_resume() in low memory situation
Message-ID: <ZYvjiqX6EsL15moe@perf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmuW7v4+5Ug587eSyu7Z3IbtG8eD2b
	xd/OC6wWm+cUW8yaspfJ4vKuOWwWn3uPMFrcPXWUzWLul6nMFosPfGJ34PJYvOclk8emVZ1s
	HvvnrmH36NuyitFjxerv7B6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
	WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv
	0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7YOOcac0GLccWUWW1sDYzd6l2MnBwSAiYSm+Y3sHcx
	cnEICexglFi04DczhPOJUeL0tt1QmW+MEg96XjLDtByf3cMIkdjLKLF+zSqoloeMEkvWv2ED
	qWIRUJXofzSFHcRmE9CV2HbiHyOILSIQJnH9xQ4WkAZmgUWMEk2//oI1CAu4SvzcfAdsBa+A
	skTjv152CFtQ4uTMJ2ANEgJf2SX+XrvGDnGHi8SzBR9ZIWxhiVfHt0DFpSRe9rdB2cUSDfdv
	MUM0tzBKnLr+AuoJY4lZz9rBTmIWyJS42LcJaBAHUFxZ4sgtFogwn0TH4b/sEGFeiY42IYhO
	NYlfUzYwQtgyErsXr4Ca6CGx980HJhBbSCBWYsHuq8wTGGVnIXlhFpJlELYOUNkntllAG5gF
	pCWW/+OAMDUl1u/SX8DIuopRLLWgODc9tdiowAQercn5uZsYwclTy2MH4+y3H/QOMTJxMB5i
	lOBgVhLhlVXsSBXiTUmsrEotyo8vKs1JLT7EaAqMkInMUqLJ+cD0nVcSb2hiaWBiZmZobmRq
	YK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA1Nmyfsrv85trt9+bN1GNobZmxzk5hydr/PE
	0y82ROzjC8N0iWtNMRtSM5c8ZruyqntXf9aT0tlultySl10fr96RtLD1/8egmqK/nw0/TXUX
	V+qudVxtGNeW/lDOme+BUFu8St2v2ee0vp7Ydvn4KTNPva1TkiM/PfMRbckJsT3oZyEopvzR
	s53/5zJuk0VuExRXHirr3No+7c68dVZTmFmmv+7WWtDPIayX/GDmKp7HvL9nCT9m3jJHoUDF
	gNn6jc5imy9zuS5/KZ4tpDv7s7VXXMjDR0ffpD/s3Hmy5/WZgtbtu50VehU/Hzlkv8YiaIlE
	1bbHs9sbwxMXy6S0p99TOfJIiLs58vvdtdrO/E+VWIozEg21mIuKEwGgkQIcJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvG7P4+5Ug/arWhbX9k5kt2hevJ7N
	4m/nBVaLzXOKLWZN2ctkcXnXHDaLz71HGC3unjrKZjH3y1Rmi8UHPrE7cHks3vOSyWPTqk42
	j/1z17B79G1ZxeixYvV3do/Pm+QC2KK4bFJSczLLUov07RK4MtrnHmQsOGhQsWHGQ/YGxocq
	XYycHBICJhLHZ/cwdjFycQgJ7GaUOHfmIDtEQkbi9srLrBC2sMT9liOsEEX3GSW2vl3LDJJg
	EVCV6H80BayBTUBXYtuJf4wgtohAmMT1FztYQBqYBRYxShzd+p0FJCEs4Crxc/MdsGZeAWWJ
	xn+97BC2oMTJmU/AapgFtCRu/HvJ1MXIAWRLSyz/xzGBkW8WkqpZSKpmIVQtYGRexSiZWlCc
	m56bbFhgmJdarlecmFtcmpeul5yfu4kRHOJaGjsY783/p3eIkYmD8RCjBAezkgivrGJHqhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFewxmzU4QE0hNLUrNTUwtSi2CyTBycUg1Mx1gDr3gtLFkf
	u039sKPRnlM39+8o3iqzxTCicCvr/Wjp8u1PfeLFJarM/FY+4t63ZX3Bq2yGGxeLxPZl3juw
	vpTPdnlBo2q728835c4xm5k7hVevf7N+x7OWHxZNtk9Lkupqi1IC3cIquHLnczKej/jW6LJB
	v9GKveY47/aFhtd2/vtjyOUb6lpwRlHAR0LT3UY2u/1/59L0bVHb/97uNyz8tWRly+m935K2
	GbUYKfC/OPvqntD1FO2zx5w/+X27ceamj3fAzqOt1kGXPpbmtIXwH8r6eV/0VKff5unrkk81
	F8/eeK4nTcci/9Sjm3XhfHH9T/9HX0x4H367c75sZEM/U++8z5xLtz8tmP9AiaU4I9FQi7mo
	OBEANwNbNeACAAA=
X-CMS-MailID: 20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_147472_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>

------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_147472_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi all.

I'm reporting a issue which looks like a upstream kernel bug.
We are using 6.1 but I think all of version can cause this issue.

A mutex deadlock issue occured on low mem situation when the device runs dpm_resume().
Here's the problematic situation.

#1. Currently, the device is on low mem situation as below.
[4: binder:569_5:27109] SLUB: Unable to allocate memory on node -1, gfp=0xb20(GFP_ATOMIC|__GFP_ZERO)
[4: binder:569_5:27109] cache: kmalloc-128, object size: 128, buffer size: 128, default order: 0, min order: 0
[4: binder:569_5:27109] node 0: slabs: 1865, objs: 59680, free: 0
[4: binder:569_5:27109] binder:569_5: page allocation failure: order:0, mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0
[4: binder:569_5:27109] CPU: 4 PID: 27109 Comm: binder:569_5 Tainted: G S C E 6.1.43-android14-11-abS921BXXU1AWLB #1
[4: binder:569_5:27109] Hardware name: Samsung E1S EUR OPENX board based on S5E9945 (DT)
[4: binder:569_5:27109] Call trace:
[4: binder:569_5:27109] dump_backtrace+0xf4/0x118
[4: binder:569_5:27109] show_stack+0x18/0x24
[4: binder:569_5:27109] dump_stack_lvl+0x60/0x7c
[4: binder:569_5:27109] dump_stack+0x18/0x38
[4: binder:569_5:27109] warn_alloc+0xf4/0x190
[4: binder:569_5:27109] __alloc_pages_slowpath+0x10ec/0x12ac
[4: binder:569_5:27109] __alloc_pages+0x27c/0x2fc
[4: binder:569_5:27109] new_slab+0x17c/0x4e0
[4: binder:569_5:27109] ___slab_alloc+0x4e4/0x8a8
[4: binder:569_5:27109] __slab_alloc+0x34/0x6c
[4: binder:569_5:27109] __kmem_cache_alloc_node+0x1f4/0x260
[4: binder:569_5:27109] kmalloc_trace+0x4c/0x144
[4: binder:569_5:27109] async_schedule_node_domain+0x40/0x1ec
[4: binder:569_5:27109] async_schedule_node+0x18/0x28
[4: binder:569_5:27109] dpm_suspend+0xfc/0x48c

#2. The process A runs dpm_resume() and acquired "dpm_list_mtx" lock as below.
1000 void dpm_resume(pm_message_t state)
1001 {
1002         struct device *dev;
1003         ktime_t starttime = ktime_get();
1004
1005         trace_suspend_resume(TPS("dpm_resume"), state.event, true);
1006         might_sleep();
1007
1008         mutex_lock(&dpm_list_mtx);  <-------- process A acquired the lock
1009         pm_transition = state;
1010         async_error = 0;
1011
1012         list_for_each_entry(dev, &dpm_suspended_list, power.entry)
1013                 dpm_async_fn(dev, async_resume);

#3. The process A continues to run below functions as below.
dpm_async_fn()
      --> async_schedule_dev()
          --> async_schedule_node()
              --> async_schedule_node_domain()

#4. The kzalloc() will be failed because of lowmen situation.
165 async_cookie_t async_schedule_node_domain(async_func_t func, void *data,
166                                           int node, struct async_domain *domain)
167 {
168         struct async_entry *entry;
169         unsigned long flags;
170         async_cookie_t newcookie;
171
172         /* allow irq-off callers */
173         entry = kzalloc(sizeof(struct async_entry), GFP_ATOMIC); <--- Will be failied
174
175         /*
176          * If we're out of memory or if there's too much work
177          * pending already, we execute synchronously.
178          */
179         if (!entry || atomic_read(&entry_count) > MAX_WORK) {
180                 kfree(entry);
181                 spin_lock_irqsave(&async_lock, flags);
182                 newcookie = next_cookie++;
183                 spin_unlock_irqrestore(&async_lock, flags);
184
185                 /* low on memory.. run synchronously */
186                 func(data, newcookie); <--- the process A will run func() that is async_resume()
187                 return newcookie;

5. The process A continues to run below functions as below.
async_resume()
    --> device_resume()
        --> dpm_wait_for_superior()

6. The process A is trying to get the lock which was acquired by A.
278 static bool dpm_wait_for_superior(struct device *dev, bool async)
279 {
280         struct device *parent;
281
282         /*
283          * If the device is resumed asynchronously and the parent's callback
284          * deletes both the device and the parent itself, the parent object may
285          * be freed while this function is running, so avoid that by reference
286          * counting the parent once more unless the device has been deleted
287          * already (in which case return right away).
288          */
289         mutex_lock(&dpm_list_mtx);

So we think this situation can make mutex dead lock issue in suspend/resume sequence.

Here's the process A's callstack in kernel log. (binder:569:5)
I[4:      swapper/4:    0]      pid            uTime            sTime     last_arrival      last_queued   stat   cpu  task_struct           comm [wait channel]
I[4:      swapper/4:    0]    27109                0         1758074533    2396019774802             0    D(  2)  5   ffffff8044bc92c0      binder:569_5 [dpm_wait_for_superior]
I[4:      swapper/4:    0] Mutex: dpm_list_mtx+0x0/0x30: owner[0xffffff8044bc92c0 binder:569_5 :27109]
I[4:      swapper/4:    0] Call trace:
I[4:      swapper/4:    0]  __switch_to+0x174/0x338
I[4:      swapper/4:    0]  __schedule+0x5ec/0x9cc
I[4:      swapper/4:    0]  schedule+0x7c/0xe8
I[4:      swapper/4:    0]  schedule_preempt_disabled+0x24/0x40
I[4:      swapper/4:    0]  __mutex_lock+0x408/0xdac
I[4:      swapper/4:    0]  __mutex_lock_slowpath+0x14/0x24
I[4:      swapper/4:    0]  mutex_lock+0x40/0xec  <-------- trying to acquire dpm_list_mtx again
I[4:      swapper/4:    0]  dpm_wait_for_superior+0x30/0x148
I[4:      swapper/4:    0]  device_resume+0x38/0x1e4
I[4:      swapper/4:    0]  async_resume+0x24/0xf4
I[4:      swapper/4:    0]  async_schedule_node_domain+0xb0/0x1ec
I[4:      swapper/4:    0]  async_schedule_node+0x18/0x28
I[4:      swapper/4:    0]  dpm_resume+0xbc/0x578  <------- acquired dpm_list_mtx
I[4:      swapper/4:    0]  dpm_resume_end+0x1c/0x38
I[4:      swapper/4:    0]  suspend_devices_and_enter+0x83c/0xb2c
I[4:      swapper/4:    0]  pm_suspend+0x34c/0x618
I[4:      swapper/4:    0]  state_store+0x104/0x144

Could you look into this issue ?

------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_147472_
Content-Type: text/plain; charset="utf-8"


------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_147472_--

