Return-Path: <linux-kernel+bounces-56377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF484C977
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 695CEB276CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46A1AACF;
	Wed,  7 Feb 2024 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mzmvVkaY"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78D1AACC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304592; cv=none; b=KGoM4lk2PHqGYluUoYMPgkxEeK2bYq34Zm/auxJLNZGaG34RaRJTM+w1gYG/d4AlQ8iwappdCJF2JdLkO90jibaKKlDpg+jERKcI38EaUzokgdLnAUJHp/8zFDENQpX6W8ZtyA4b/jgMkUSu+IzZ2z2O0Nvo8gUKU1ldsWygMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304592; c=relaxed/simple;
	bh=LJtFGIADyf/tpqM1VRO1P2IVV+9g5WuvYQlUJGQtzAQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=YVsj3zKTsv4ZVRcQxhYp2mDhOOv1kpWhax4hRCo6W0Kvya/l0e9E1N84PvvBg9nWsIjp9WFMkgMD0V/4H5YH0WS/s8bDEq9qLcvdEdW92h5/OASWjj2igj/dndSr11GK98RbZhMq8j+DQjm7zQZjRmQ5qEmzM3gXf8NsHR+G14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mzmvVkaY; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240207111628euoutp02f670d881fee32aaed66d12a4bceb664a~xkHpBvhdV0413104131euoutp02e
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:16:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240207111628euoutp02f670d881fee32aaed66d12a4bceb664a~xkHpBvhdV0413104131euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707304588;
	bh=Y5FZSjgrrNPEIoeyx60PXrwjiJiBieeyiawTNRw4j0g=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=mzmvVkaY8AuaCxvIYbs71IwEsnZs8XnfUPbS4gv88beWLSkF6wlMp9ODAN1deINDj
	 oZfo5dxrimOY9YqUxU0MbJNKzaQYqjKy8LwyPeUemSYCOgSZXfLKQcFHNd1F6+xT2A
	 VsDEVRbXEvojxSLs4JES43niccqWxShZGqwMcs20=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240207111628eucas1p291cb78a004be8b706c065337e82c576f~xkHoxRXIf1544215442eucas1p2u;
	Wed,  7 Feb 2024 11:16:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.76.09552.C8663C56; Wed,  7
	Feb 2024 11:16:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240207111627eucas1p18965924f9815a1d8bf94c3bedcd6a945~xkHoXLbtw0515305153eucas1p1g;
	Wed,  7 Feb 2024 11:16:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240207111627eusmtrp1b7afce73360a0814c5dd87e926b37662~xkHoWivvZ3199031990eusmtrp1j;
	Wed,  7 Feb 2024 11:16:27 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-08-65c3668c9894
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.DC.09146.B8663C56; Wed,  7
	Feb 2024 11:16:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240207111626eusmtip1f12e8a2850e8d6b9df2ea7087b60f46e~xkHnlIucd1225112251eusmtip1h;
	Wed,  7 Feb 2024 11:16:26 +0000 (GMT)
Message-ID: <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
Date: Wed, 7 Feb 2024 12:16:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tejun Heo
	<tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Language: en-US
In-Reply-To: <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87o9aYdTDfafY7WYunY3k8W+i2vY
	LC7vmsNm8bn3CKPFxOObWS3aVz5ls5j7ZSqzxZnTl1gtPu7ZwGjxa/lRRovja8MduD12zrrL
	7rFpVSebx51re9g85p0M9Dh3scJjy9V2Fo/Pm+Q82g90MwVwRHHZpKTmZJalFunbJXBlnHwy
	j71ggkDFisk/WBsYF/N2MXJySAiYSEw4O5Gli5GLQ0hgBaPE8RNX2SCcL4wS73d+hXI+AzkH
	f7DCtLSt+QCVWM4o8W/2PkYI5yOjxIbHl5i6GDk4eAXsJE7c4gBpYBFQkdh1YisjiM0rIChx
	cuYTFhBbVEBe4v6tGewgNpuAoUTX2y42EFtYIETi9dmjYMtEBLQlliy6ygwyn1ngE5PE7YnN
	YM3MAuISt57MZwKxOQUCJS7OuMIOEZeXaN46G6xBQmAyp8Sl+TsZIc52kfi89wczhC0s8er4
	FnYIW0bi9OQeFoiGdkaJBb/vM0E4ExglGp7fguq2lrhz7hcbyGvMApoS63fpQ4QdJVqXbGAF
	CUsI8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkMJlFpLXZiF5ZxbC
	3gWMLKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzEC09jpf8e/7mBc8eqj3iFGJg7GQ4wS
	HMxKIrxmOw6kCvGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBK
	NTCVRxTO7OJ0DA7ZbCeidrF2xq7v/84umnb8gcGEtrlPi8pMrp6Oje90eFBtb338Tb7Q4Wh7
	/9fqp2U3Tm/uuHhFaIlB4Nf+HbwWPbFO6tpX0modY9uKZB8xKq6ckCWVF5/w/3O42ovi7bk2
	4YK6y1/lVR76rpTow6IhMf3DrjbmldqGU8NaT8zmkNaWF9RsPLxtIWOG0ju237NnShR935vV
	ZhAVFO7TaaDCpc+/NXPint8JP2/aJiSz33544nHC5Vnr15Wn8m2eFuqWcni3dkT2gUDVly8W
	5fNs2q6xe/H84jJTydx1ZocXhPJ8ThAVOyrD08P6nfV3S/YnjSsrjTp1uH/tmWQdvuOH1bPI
	CUosxRmJhlrMRcWJAOXs9LzSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7rdaYdTDU7e0LaYunY3k8W+i2vY
	LC7vmsNm8bn3CKPFxOObWS3aVz5ls5j7ZSqzxZnTl1gtPu7ZwGjxa/lRRovja8MduD12zrrL
	7rFpVSebx51re9g85p0M9Dh3scJjy9V2Fo/Pm+Q82g90MwVwROnZFOWXlqQqZOQXl9gqRRta
	GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlnHwyj71ggkDFisk/WBsYF/N2MXJy
	SAiYSLSt+cDWxcjFISSwlFHi2Ow9rBAJGYmT0xqgbGGJP9e6oIreM0qs6F/F3MXIwcErYCdx
	4hYHSA2LgIrErhNbGUFsXgFBiZMzn7CA2KIC8hL3b81gB7HZBAwlut6CzOHkEBYIkXh99ijY
	fBEBbYkli64yg8xnFvjCJPFp0kpWiGW/GCVmrPoL1s0sIC5x68l8JhCbUyBQ4uKMK1BxM4mu
	rV2MELa8RPPW2cwTGIVmITlkFpL2WUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93
	EyMwbrcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4TXbcSBViDclsbIqtSg/vqg0J7X4EKMpMDQm
	MkuJJucDE0deSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPT5GBW
	Tn67Gz8nTi+dopYrbv7fU12wOmTzU92cPxcvKjpWNt1it9bdb1Q5bfvlU3GbGW8mvVmjf3tm
	/6KLK6dPqBA8Yuj+f+LMri1Tylvnyr+adppN4qNJrozqkfIn65++85pad/SnQM3Rc3VHXuf8
	1b5eOfejTdPNU87OIieKi4u7BKT/Ld3xaPaPX9Onzp6zJ/7u64fZws4LXwUWvjG02O1jLrRT
	YYqzxvfySsfTWx6fYGC/u2tBhJjy7njprs5CgZ3/tayjpdui1/bVvjqko+L6c/33L9Oa0jsf
	9y3vLntu8eLmu2KpOIeoIJtMsx1z4gsr5/hIpTR6qs773TnV+mjP8tPe3/qLmacuCm6LV2Ip
	zkg01GIuKk4EAC1oeRhkAwAA
X-CMS-MailID: 20240207111627eucas1p18965924f9815a1d8bf94c3bedcd6a945
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
	<10423008.nUPlyArG6x@kreacher>
	<708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
	<CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>

On 07.02.2024 11:38, Rafael J. Wysocki wrote:
> On Wed, Feb 7, 2024 at 11:31 AM Marek Szyprowski
> <m.szyprowski@samsung.com>  wrote:
>> On 09.01.2024 17:59, Rafael J. Wysocki wrote:
>>>    From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>>>
>>> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
>>> system-wide PM code"), the resume of devices that were allowed to resume
>>> asynchronously was scheduled before starting the resume of the other
>>> devices, so the former did not have to wait for the latter unless
>>> functional dependencies were present.
>>>
>>> Commit 7839d0078e0d removed that optimization in order to address a
>>> correctness issue, but it can be restored with the help of a new device
>>> power management flag, so do that now.
>>>
>>> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>>> ---
>> This patch finally landed in linux-next some time ago as 3e999770ac1c
>> ("PM: sleep: Restore asynchronous device resume optimization"). Recently
>> I found that it causes a non-trivial interaction with commit
>> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement
>> for unbound workqueues"). Since merge commit 954350a5f8db in linux-next
>> system suspend/resume fails (board doesn't wake up) on my old Samsung
>> Exynos4412-based Odroid-U3 board (ARM 32bit based), which was rock
>> stable for last years.
>>
>> My further investigations confirmed that the mentioned commits are
>> responsible for this issue. Each of them separately (3e999770ac1c and
>> 5797b1c18919) doesn't trigger any problems. Reverting any of them on top
>> of linux-next (with some additional commit due to code dependencies)
>> also fixes/hides the problem.
>>
>> Let me know if You need more information or tests on the hardware. I'm
>> open to help debugging this issue.
> If you echo 0 to /sys/power/pm_async before suspending the system,
> does it still fail?

In such case it works fine.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


