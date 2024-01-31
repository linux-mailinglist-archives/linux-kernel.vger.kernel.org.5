Return-Path: <linux-kernel+bounces-45943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FAE843830
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0611F26469
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208355C10;
	Wed, 31 Jan 2024 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WX9DdyDc"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598B5577C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687130; cv=none; b=GzU9eBoR6lRZVSs3ng1a6fkkk6AoWV9cD5Dv1gsHkEeIbsE2OWUKWDx3L9fEhodNSbr3Rg2M5IFKCi3ouEzZhTfvK43+vz9z7gYW99Qwi6JTq2PTSldVmpT2rAJgR+NAShyiiOs7EWaQlO/yntswck4Zg86y2BECI21CkuUSc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687130; c=relaxed/simple;
	bh=r72jR+ohmF08fx34PK4uPYzGYiSjmalKc4/TBzaO2l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mNWPqfIIYngJ6ghKKpR42gZZyWZxt7UyLBAYDIiEHR89osqiUMzlbD5dvlBtQNOmouWV9lPr1pGL8n6bwjcDPJLXn71e3uuU5W9OnWQsbTq/UXsKQL53hN24sxRuJ7Zx02uwHN4U/dys8Mo9aINlcLQGpeRhz9DIWjIBZnblrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WX9DdyDc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240131074525euoutp02254734cb023cc31708c4b23630b354a9~vXuX3Avm40742707427euoutp02F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:45:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240131074525euoutp02254734cb023cc31708c4b23630b354a9~vXuX3Avm40742707427euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706687125;
	bh=S9pCICTqN1F3e5Nuf2qjgG414cF5+i5Fu3bz/IKz3go=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WX9DdyDcZMMTxij5BdbUmH/lpU/+BLavOHz4fOTYB82DLs5HifomcgEjDb/Frp/rD
	 VS1g9uAaNVdKOHAbjX2YcT0fPfoxQ693D1Vld9S0v0Xf0KPgYHlH45TzHL/2D/VY0u
	 Bs/FgPKFUgiaRooNLyZgPs8tpfMeJ+q/BljP4dQk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240131074525eucas1p1373c4835c0aa3050e8315f874b9ca546~vXuXj6Cgo2760927609eucas1p1C;
	Wed, 31 Jan 2024 07:45:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F6.44.09552.59AF9B56; Wed, 31
	Jan 2024 07:45:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240131074524eucas1p135ce025e8d4ebec1c957b21f124a45ae~vXuW_KfON1875218752eucas1p1g;
	Wed, 31 Jan 2024 07:45:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240131074524eusmtrp2d04cb51eeb6703dcfc4aa71a004d5475~vXuW8Rbn62737027370eusmtrp2R;
	Wed, 31 Jan 2024 07:45:24 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-a4-65b9fa9515fd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CF.4A.09146.49AF9B56; Wed, 31
	Jan 2024 07:45:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240131074524eusmtip1694ad0b825fc3a72818d1342d54a0df0~vXuWeP_tN2658426584eusmtip1X;
	Wed, 31 Jan 2024 07:45:24 +0000 (GMT)
Message-ID: <41f8fab0-f88e-43a5-aa36-d071027c4e0c@samsung.com>
Date: Wed, 31 Jan 2024 08:45:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZbnULGnVOtA5Zdl9@slm.duckdns.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1zUyn02rrWECuqGDqkri1IkQbVzQu9YO4G6JGrfYFUArYyqLR
	BHEBUbColVpJKiasajXFVArBpSoNimirEK0Y+cACGjQKBIGIUgeUv3POPTfn3JfHkBIjL4iJ
	jT+EtfGqOCktpGw1vS/nGvrseF5lN6Mw3KoiFPddN2nF68p8WpHrLOcpMko/0Yq+4qcoglba
	TR/4SmvZGVpZ70pVdlqDlRkPzxIbeNuFS9Q4LjYZa+XL9ghj8t1GlPheknquf1caMo/NQgIG
	2HBwny/gZyEhI2FLELSZa2mOdCH40vyY4EgnggpHLjW80vqjgMcNihE8d/waIt8RNDbkkj6X
	iF0GOQNVyIcpdvqgqZfi9HFQe6XlLw5gQ+Cjx8j3YT9WAwa7nufDJBsInhYz4cP+7Coo1BcN
	6cnwpPzr312aDYWsjizahwWsHAprfiHOEwL3OvJJXyFgXzFg7G8mudqroLq0YOgEP/jsvMvn
	8CT4bTcT3EIGgmv9H4eIHkFaqwdxrsXQVN83GMcMRsyE25VyTl4BF2++4PlkYMXwtmMcV0IM
	F2x5JCeLIPO0hHPPAJPT8i/20Ss3qUdS04hnMY043zTiHNP/3GuIKkOBOEmnica6sHicItOp
	NLqk+GjZvgSNFQ1+nucDzu4KVPL5u8yBCAY5EDCk1F9UGmzHEpFadfgI1ibs1ibFYZ0DTWQo
	aaBoujoES9ho1SF8AONErB2eEowgKI2whH9wPXIWuTPLQz85wi7HXNISc9zWphM3Fpu3Hj7Y
	/iRiW3K759vPgGJRKfkjqnD0ysigRZOn2K54uvYGtK/WJPacjMpT1+V5Tp+j6HslsXG7ZAua
	AzL9Pe37r1s2Y7VrIMcPLaViIgVKq3d2vamhOeJqhVzLbpSJcYKdkHtH7VjvnZowc+ra6jvH
	xMZ3NcFvRMLg0cfT76ROPNqxqWHWtDMv546pFu01UFtKHE3X65awsmdnDaZTQbfGey/OG2OV
	7WuaP5DetiZKmqLOntH2rMjy4JuKtfXu9OZF1jGNlgmNVV38st+u7Pqedb1T9PuLZ7dscoaJ
	b9QuTxEs7LQdkVK6GFXoLFKrU/0BP3u8NKsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xu7pTfu1MNdj3W95i6trdTBb7Lq5h
	s7i8aw6bxcTjm1kt2lc+ZbP4tfwoowObx85Zd9k9Nq3qZPM4d7HC4/MmOY/2A91MAaxRejZF
	+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlzLs1gLLgt
	VNHzO66BcT5/FyMnh4SAicTzTwtZuxi5OIQEljJKbN/cxQyRkJE4Oa2BFcIWlvhzrYsNoug9
	o8TXBbtZQBK8AnYSff92M4LYLAKqEqcP/YSKC0qcnPkEzBYVkJe4f2sGO4gtLJArMXXnBLCh
	zALiEreezGcCsUUEXCSWTlgGFS+TaJm6kAli2SoWib8Hd4MVsQkYSnS9BbmCk4NTQF9i6bG/
	jBANZhJdW7ugbHmJ7W/nME9gFJqF5I5ZSPbNQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV5
	6XrJ+bmbGIGRtu3Yz807GOe9+qh3iJGJg/EQowQHs5II70q5nalCvCmJlVWpRfnxRaU5qcWH
	GE2BgTGRWUo0OR8Y63kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxS
	DUz+3ROfZqq4MjxsvxOjkrNfUqP9ZmWW8t7cjd8KpB5H2oh3aVo8nGjxYu2vYxHTimbos2y5
	v6nUUknG58O0fb/XnvExW3ElXuN+H8+Dr/pdL246exfLp0TcmdhxbPWTz9xG2fypNS6Zydyv
	Dk83sF9UJTfP/dFX73VfEoNvrA5/fPuiLcsirs4pC7T3JOfN+HmnbcWU/k/mL0SP/nu52O3g
	gQp/WQ+lO5s7XG7yCxiyPN/1OY3p9Y3VzUplW2QXTE037w5SYbOQC3COtmw4X9ZWvXGX1Pnz
	C69rrOPWZJrEb1Oy4uFs7W1XggJVXP+uWxm6OerksRv614wdZsaeEJvgs7GrI/m+7mdViVjr
	iceUWIozEg21mIuKEwF18FmxPQMAAA==
X-CMS-MailID: 20240131074524eucas1p135ce025e8d4ebec1c957b21f124a45ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240130223021eucas1p1172b060d53847b8b77f6455d6257528e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240130223021eucas1p1172b060d53847b8b77f6455d6257528e
References: <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
	<ZbfrEx9nnkr0FnZE@slm.duckdns.org>
	<CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
	<91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
	<ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
	<20240131041205.GA3517117@dev-arch.thelio-3990X>
	<ZbnIzqmClhAvPxKC@slm.duckdns.org>
	<20240131042031.GA3946229@dev-arch.thelio-3990X>
	<ZbnLk7pZbcODRNER@slm.duckdns.org>
	<20240131044254.GA802495@dev-arch.thelio-3990X>
	<ZbnULGnVOtA5Zdl9@slm.duckdns.org>

On 31.01.2024 06:01, Tejun Heo wrote:
> From: Tejun Heo <tj@kernel.org>
> Date: Tue, 30 Jan 2024 18:55:55 -1000
> Subject: [PATCH] workqueue: Don't call cpumask_test_cpu() with -1 CPU in
>   wq_update_node_max_active()
>
> For wq_update_node_max_active(), @off_cpu of -1 indicates that no CPU is
> going down. The function was incorrectly calling cpumask_test_cpu() with -1
> CPU leading to oopses like the following on some archs:
>
>    Unable to handle kernel paging request at virtual address ffff0002100296e0
>    ..
>    pc : wq_update_node_max_active+0x50/0x1fc
>    lr : wq_update_node_max_active+0x1f0/0x1fc
>    ...
>    Call trace:
>      wq_update_node_max_active+0x50/0x1fc
>      apply_wqattrs_commit+0xf0/0x114
>      apply_workqueue_attrs_locked+0x58/0xa0
>      alloc_workqueue+0x5ac/0x774
>      workqueue_init_early+0x460/0x540
>      start_kernel+0x258/0x684
>      __primary_switched+0xb8/0xc0
>    Code: 9100a273 35000d01 53067f00 d0016dc1 (f8607a60)
>    ---[ end trace 0000000000000000 ]---
>    Kernel panic - not syncing: Attempted to kill the idle task!
>    ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>
> Fix it.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Link: http://lkml.kernel.org/r/91eacde0-df99-4d5c-a980-91046f66e612@samsung.com
> Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")


Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
> Applied to wq/for-6.9.
>
> Thanks.
>
>   kernel/workqueue.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9221a4c57ae1..31c1373505d8 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1510,7 +1510,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
>   
>   	lockdep_assert_held(&wq->mutex);
>   
> -	if (!cpumask_test_cpu(off_cpu, effective))
> +	if (off_cpu >= 0 && !cpumask_test_cpu(off_cpu, effective))
>   		off_cpu = -1;
>   
>   	total_cpus = cpumask_weight_and(effective, cpu_online_mask);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


