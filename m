Return-Path: <linux-kernel+bounces-158346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4853E8B1EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF671C2188F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449328594A;
	Thu, 25 Apr 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W8DfLn07"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C685937
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039349; cv=none; b=hkOTAaO4tmP4ydh98Bf54TP1RIXUEh57csA/6CZbffrCdX2SKLBNiA5xCwak4N3veiN+VJwDq3TVfbJYnGL21xbx/oQUgnbjkZ7hBP270ITsBR7ZcN1xa8q+N5nrlqpWmjA5sBQkEkTjpHhjDlG41wvzDjmvNWYqa0MR8PDTM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039349; c=relaxed/simple;
	bh=D43HqWGhew4NIlfYNq2zcvYW4hjhv7WDJP0gbSppSjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=uwz0KPFD6U3B7NqLWy2LvoHmcfKDZQxnFxqSwXG40vgPoOTP7zfFYM/b1Fq3+gqPLPh9ECIFwoDGkg8YgLEESHtpmVib8nO7YpLyZC+Vs6XMIJvXRO8nV785/jDMXsJGvUM+JTSo7kehKS3FE8d8qk0CffwvtfqZVEfns8lhYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W8DfLn07; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240425100224euoutp0190086f67ecdb4303bea3c56f98bd2a01~JfbPfy2pk2968929689euoutp01P
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:02:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240425100224euoutp0190086f67ecdb4303bea3c56f98bd2a01~JfbPfy2pk2968929689euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714039344;
	bh=Y6uoDojVa9FO4WIczvH/+BJUzC+PPsT0muqBC0r2gWc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=W8DfLn0716RZvl0n96ZdlqNw30VTExVehVwBvENIVmDTZS7ZmeewIbkF/eMzuiyQW
	 u+UyU4DdC8XO/hSw9pEkRsdBy+0NtkMQCxoSk7/aLhq8erdX+5VYKCrZvUpYNA69Mr
	 DI5NLUcsUbqoAsz2rxkuKAN8wFUWqBKgJfoxzvZ0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240425100224eucas1p2826dc59bf516e2775094366d4e02a2cb~JfbPZXAP62727127271eucas1p2M;
	Thu, 25 Apr 2024 10:02:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.9F.09875.03A2A266; Thu, 25
	Apr 2024 11:02:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240425100224eucas1p2155f5d9988a5c4a14aeb3fb7318d0fe0~JfbPE9FH02304423044eucas1p2Z;
	Thu, 25 Apr 2024 10:02:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240425100224eusmtrp190c7b8612e52a54c2f6a6bd5beff8adf~JfbPEV75V0846808468eusmtrp1K;
	Thu, 25 Apr 2024 10:02:24 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-b6-662a2a300b70
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.C2.09010.03A2A266; Thu, 25
	Apr 2024 11:02:24 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240425100223eusmtip1fe4ba78b15c82c6ab9b1e6df341fe876~JfbOtxlDN2878028780eusmtip1s;
	Thu, 25 Apr 2024 10:02:23 +0000 (GMT)
Message-ID: <5f9052f0-ef5f-4c4f-85f9-f07fffd2b5ef@samsung.com>
Date: Thu, 25 Apr 2024 12:02:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: cyapa - add missing input core locking to
 suspend/resume functions
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrzej Pietrasiewicz
	<andrzej.p@collabora.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20231009121018.1075318-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOV0DLa00gxMnFSyWPb7HYnF40QtG
	i5ufvrFaXN41h82BxWPH3SWMHjtn3WX3+LxJLoA5issmJTUnsyy1SN8ugStj0qfFTAUdqhVd
	e96yNDDekuti5OSQEDCROLHlGHMXIxeHkMAKRom1Uy8wQThfGCUmv9kP5XxmlHh3+AczTMvP
	U8/ZIBLLGSX2Ll0KVfWRUaJn9gx2kCpeATuJ1U+XMoLYLAKqEp2TDzBBxAUlTs58wgJiiwrI
	S9y/BVEvLJAg8bJ7OliNiICtxI4VEDazQJLEl0W/oGxxiVtP5oPZbAKGEl1vu9hAbE4BB4lJ
	MyeyQ9TIS2x/Owfq0i0cEnPu1UDYLhILPz1gg7CFJV4d38IOYctInJ7cwwLygIRAO6PEgt/3
	mSCcCYwSDc9vMUJUWUvcOfcLqJsDaIOmxPpd+hBhR4mWX3uZQMISAnwSN94KQtzAJzFp23Rm
	iDCvREebEES1msSs4+vg1h68cIl5AqPSLKRQmYXky1lIvpmFsHcBI8sqRvHU0uLc9NRio7zU
	cr3ixNzi0rx0veT83E2MwJRy+t/xLzsYl7/6qHeIkYmD8RCjBAezkgjvzY8aaUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MnRsl/vn02clVLnj65OAb
	0Sl8jEzXzlScedi7SOOSsowZo5XClB8Pzr25KWmz4/9K98MeHQqXWaSaXPhu2t2YPYXX/tRh
	UxGN5wmO3b94PU4eSiuXZt/EXeFl839afHT745KLx9n3L1eoni+4WEe+bLtukdR5xYfh9pte
	aN89JslfNElWU/HP6aKXvKHNPufKvbcv+vhh1fPeRasfhOhbBc7cfYHJLW3Ri6zz4W/uTW8W
	WLvRuvpWqwdzOYNKWV7ZVjGfT79N5t0x0PgsaKHlM+EI58eXUab7HhekrW1Nijw7Vdqr69es
	Dv7G7W+ETxjsn3A4Nbxp/Sqrmb56e48tWbXypkr11y1WceKzlz//qsRSnJFoqMVcVJwIACde
	VNeYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7oGWlppBk8esFkse3yPxeLwoheM
	Fjc/fWO1uLxrDpsDi8eOu0sYPXbOusvu8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
	kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GpE+LmQo6VCu69rxlaWC8JdfFyMkhIWAi8fPU
	c7YuRi4OIYGljBKdK3awQCRkJE5Oa2CFsIUl/lzrYgOxhQTeM0qs++oJYvMK2EmsfrqUEcRm
	EVCV6Jx8gAkiLihxcuYTsDmiAvIS92/NYAexhQUSJF52TwerERGwldixAsJmFkiSOLPnOSvE
	EZMZJX5MWQ6VEJe49WQ+mM0mYCjR9RbiCE4BB4lJMyeyQ9SYSXRt7WKEsOUltr+dwzyBUWgW
	kjtmIRk1C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG0LZjP7fsYFz56qPe
	IUYmDsZDjBIczEoivDc/aqQJ8aYkVlalFuXHF5XmpBYfYjQFBsZEZinR5HxgFOeVxBuaGZga
	mphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBZaDXcZz9w9PgBPvZ3DNzuW6Ji
	+qonbvGX/tq9c9ay1Ee/Ly7rclfwLbzXZH3GPbDV7N7KXJ99wWdLzp32u+x3w8+wIOPiZXdB
	yYNz2y0qour5apI+PH7LvH8Ln8RUj2CPAyvFf3FNE1rtyCw1f9UMaZsDuZO3SpQ6Ku1Xasra
	6VonHfTq+r8zUmt/nJl+bXrLluOb2i8rffN7eWBCQvdK8bivX75++XL80901LbPnROYfKS9W
	meO+p7F12rKEsulbl3P98IpN2flQsHTfHZvmzRvUZ6d9aPNePyHm2MXdga8u7Sl4Jh/y9FN+
	oY3c6hMrvH7cTwietvO6z52XK27WLV9wx3dvX4aChJz3sqfhNUosxRmJhlrMRcWJACLDF00q
	AwAA
X-CMS-MailID: 20240425100224eucas1p2155f5d9988a5c4a14aeb3fb7318d0fe0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5
References: <CGME20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5@eucas1p1.samsung.com>
	<20231009121018.1075318-1-m.szyprowski@samsung.com>

On 09.10.2023 14:10, Marek Szyprowski wrote:
> Grab input->mutex during suspend/resume functions like it is done in
> other input drivers. This fixes the following warning during system
> suspend/resume cycle on Samsung Exynos5250-based Snow Chromebook:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1680 at drivers/input/input.c:2291 input_device_enabled+0x68/0x6c
> Modules linked in: ...
> CPU: 1 PID: 1680 Comm: kworker/u4:12 Tainted: G        W          6.6.0-rc5-next-20231009 #14109
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_unbound async_run_entry_fn
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x58/0x70
>   dump_stack_lvl from __warn+0x1a8/0x1cc
>   __warn from warn_slowpath_fmt+0x18c/0x1b4
>   warn_slowpath_fmt from input_device_enabled+0x68/0x6c
>   input_device_enabled from cyapa_gen3_set_power_mode+0x13c/0x1dc
>   cyapa_gen3_set_power_mode from cyapa_reinitialize+0x10c/0x15c
>   cyapa_reinitialize from cyapa_resume+0x48/0x98
>   cyapa_resume from dpm_run_callback+0x90/0x298
>   dpm_run_callback from device_resume+0xb4/0x258
>   device_resume from async_resume+0x20/0x64
>   async_resume from async_run_entry_fn+0x40/0x15c
>   async_run_entry_fn from process_scheduled_works+0xbc/0x6a8
>   process_scheduled_works from worker_thread+0x188/0x454
>   worker_thread from kthread+0x108/0x140
>   kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf1625fb0 to 0xf1625ff8)
> ...
> ---[ end trace 0000000000000000 ]---
> ...
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1680 at drivers/input/input.c:2291 input_device_enabled+0x68/0x6c
> Modules linked in: ...
> CPU: 1 PID: 1680 Comm: kworker/u4:12 Tainted: G        W          6.6.0-rc5-next-20231009 #14109
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_unbound async_run_entry_fn
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x58/0x70
>   dump_stack_lvl from __warn+0x1a8/0x1cc
>   __warn from warn_slowpath_fmt+0x18c/0x1b4
>   warn_slowpath_fmt from input_device_enabled+0x68/0x6c
>   input_device_enabled from cyapa_gen3_set_power_mode+0x13c/0x1dc
>   cyapa_gen3_set_power_mode from cyapa_reinitialize+0x10c/0x15c
>   cyapa_reinitialize from cyapa_resume+0x48/0x98
>   cyapa_resume from dpm_run_callback+0x90/0x298
>   dpm_run_callback from device_resume+0xb4/0x258
>   device_resume from async_resume+0x20/0x64
>   async_resume from async_run_entry_fn+0x40/0x15c
>   async_run_entry_fn from process_scheduled_works+0xbc/0x6a8
>   process_scheduled_works from worker_thread+0x188/0x454
>   worker_thread from kthread+0x108/0x140
>   kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf1625fb0 to 0xf1625ff8)
> ...
> ---[ end trace 0000000000000000 ]---
>
> Fixes: d69f0a43c677 ("Input: use input_device_enabled()")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Gentle ping?

> ---
>   drivers/input/mouse/cyapa.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index a84098448f5b..cf23f95b5f11 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -1347,10 +1347,16 @@ static int cyapa_suspend(struct device *dev)
>   	u8 power_mode;
>   	int error;
>   
> -	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
> +	error = mutex_lock_interruptible(&cyapa->input->mutex);
>   	if (error)
>   		return error;
>   
> +	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
> +	if (error) {
> +		mutex_unlock(&cyapa->input->mutex);
> +		return error;
> +	}
> +
>   	/*
>   	 * Runtime PM is enable only when device is in operational mode and
>   	 * users in use, so need check it before disable it to
> @@ -1385,6 +1391,8 @@ static int cyapa_suspend(struct device *dev)
>   		cyapa->irq_wake = (enable_irq_wake(client->irq) == 0);
>   
>   	mutex_unlock(&cyapa->state_sync_lock);
> +	mutex_unlock(&cyapa->input->mutex);
> +
>   	return 0;
>   }
>   
> @@ -1394,6 +1402,7 @@ static int cyapa_resume(struct device *dev)
>   	struct cyapa *cyapa = i2c_get_clientdata(client);
>   	int error;
>   
> +	mutex_lock(&cyapa->input->mutex);
>   	mutex_lock(&cyapa->state_sync_lock);
>   
>   	if (device_may_wakeup(dev) && cyapa->irq_wake) {
> @@ -1412,6 +1421,7 @@ static int cyapa_resume(struct device *dev)
>   	enable_irq(client->irq);
>   
>   	mutex_unlock(&cyapa->state_sync_lock);
> +	mutex_unlock(&cyapa->input->mutex);
>   	return 0;
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


