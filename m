Return-Path: <linux-kernel+bounces-57572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90284DADD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E712869EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAD769D1E;
	Thu,  8 Feb 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d9NPE0Se"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB16A00A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378444; cv=none; b=fLa9MmJDU4VbnZTy1Ty3S87yzeEeWa2sNuSidWN6Hj1rZyUfA/KZ7iZwAGrQyOlOjRHbWfj4jlP6YkeI1ZFDVPdyHk+lXG0rVFg6ZUjTsWNaF9UrHU2zceObhe0qPpPSuiBqEplF0fzI6BAkjMtJaHiPoVKe4VbvbaLs9DhPEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378444; c=relaxed/simple;
	bh=rs2kBaMCsgHLPXvo4edq2Mb56ydmmmoaw7QnEbhCKr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kSOX8hR2rK7CSkuhJonzSpPTuDaESI9nviAU0KvdUuUMDpM0jn/dlHhKL7LlZoryxCqhaqmX0/8FX4G2LyQJFey27D3FlSDjzeT0U474g61Tr05dEDwSIHAj1vqOCHlxJCb15iS4RcdWkoLC22AOqB1ui53DOYQNA44kr0rQTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=d9NPE0Se; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240208074714euoutp012ce0df73119cb41fe2385a3f39675503~x06PezdsF0273802738euoutp01G
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:47:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240208074714euoutp012ce0df73119cb41fe2385a3f39675503~x06PezdsF0273802738euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707378434;
	bh=yMC0Idk18DbxFLrXL9xPgXLum6+/X1siig/wCCjp0zg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=d9NPE0Se8WLQRqPYbLX5M0H+7LXxQ+qlYrADqTeZ4cW8MqBvRx+thPrlVfeggC6Sy
	 vWoQcmxsNTXlgFBHLmnw8Ytp30B/RmMzYko/77pnfo03DUhWSTwNaQeJKbx2DkBwIq
	 FmXrkHmqBBK6FCjTr8P6zGjrLeJ9CBabprSg6rDo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240208074714eucas1p1485218bee9abdff23ae1d64f50b894d6~x06PN8-KQ3228832288eucas1p18;
	Thu,  8 Feb 2024 07:47:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 63.28.09552.20784C56; Thu,  8
	Feb 2024 07:47:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240208074713eucas1p15395b9e096efb41627ead90887dca45c~x06Oxzs8k1534815348eucas1p1Q;
	Thu,  8 Feb 2024 07:47:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240208074713eusmtrp2b6d41dbfe9d0de0f66b16911fa969e31~x06OxGjSA2054420544eusmtrp2o;
	Thu,  8 Feb 2024 07:47:13 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-a8-65c487027487
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.91.09146.10784C56; Thu,  8
	Feb 2024 07:47:13 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240208074712eusmtip264bd2ddbb38c89d910ed43f13ee76acc~x06ODTiNf0640106401eusmtip25;
	Thu,  8 Feb 2024 07:47:12 +0000 (GMT)
Message-ID: <8c468452-1b00-438a-b634-eeccc35d9a41@samsung.com>
Date: Thu, 8 Feb 2024 08:47:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Nathan Chancellor <nathan@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZcP3uiapKGZqw0q5@slm.duckdns.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7pM7UdSDa6s5rSYunY3k8W+i2vY
	LC7vmsNm8bn3CKPFxOObWS3aVz5ls5j7ZSqzxZnTl1gtPu7ZwGjxa/lRRovja8MduD12zrrL
	7rFpVSebx51re9g85p0M9Dh3scJjy9V2Fo/Pm+Q82g90MwVwRHHZpKTmZJalFunbJXBlPG96
	xFpwjrti++aN7A2MNzm7GDk5JARMJKbOeMjexcjFISSwglGit28PC4TzhVHi4c4vUM5nRon+
	ztVADgdYy4OnUPHlQB13nzBCOB8ZJT4uaWYFmcsrYCcx8+lXJpAGFgEVidmTjCDCghInZz5h
	AbFFBeQl7t+awQ5iCwuESLw+exSslVlAXOLWk/lMILaIgKzElWkPweYzCzQwS2xYuhKsgU3A
	UKLrbRcbiM0poC9xbuEUJohmeYntb+cwgzRICEzmlNjSsJ8Z4lEXif2T37BD2MISr45vgbJl
	JP7vBNkG0tDOKLHg930oZwKjRMPzW4wQVdYSd879YgN5h1lAU2L9Ln2IsKPE5wuP2CDBwidx
	460gxBF8EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gnMCrNQgqXWUj+n4XknVkIexcwsqxi
	FE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITGKn/x3/uoNxxauPeocYmTgYDzFKcDArifCa
	7TiQKsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cDUKvFU
	w8xAI+uCwpJZC/2uxx6fVtVwak7hiZf2R5ctN/r/4HUgk4jxdw6bldu+KQecv/BhqoXImWTn
	h92df2OUnk9i2dftFxUQPG2nnWTTg8y6bLkGT28Fs7TQzZulU2sWm/8/9yeNbV9dt7RFRvQl
	jWRu0dRji4qrxN8fvOgcJt/D6znrCzvX/q2/bllO8bD7JSugnOwcFZW/8V8vw6TcWVG7mMt0
	rUX1Fp08qyv39M7XWif+4v09B94evmhVa6wd93vlk8TL56K9F4ZpPY7Y99n64efqz0t2zS2b
	kcKV0OZ06+C85eseyDPe8UzpM780x2T7ZGumefNmT7sl5/X7Q4Vd34yOytx1Jk//SZxQYinO
	SDTUYi4qTgQAdXBZ0NEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7qM7UdSDU6t0rKYunY3k8W+i2vY
	LC7vmsNm8bn3CKPFxOObWS3aVz5ls5j7ZSqzxZnTl1gtPu7ZwGjxa/lRRovja8MduD12zrrL
	7rFpVSebx51re9g85p0M9Dh3scJjy9V2Fo/Pm+Q82g90MwVwROnZFOWXlqQqZOQXl9gqRRta
	GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlPG96xFpwjrti++aN7A2MNzm7GDk4
	JARMJB48Zeli5OIQEljKKDH/51IghxMoLiNxcloDK4QtLPHnWhcbRNF7Rok5C/sZQRK8AnYS
	M59+ZQIZxCKgIjF7khFEWFDi5MwnYHNEBeQl7t+awQ5iCwuESLw+exRsJrOAuMStJ/OZQGwR
	AVmJK9MeMoLMZxZoYpZY+m8XE8SyTywSPx93MoNUsQkYSnS9BbmCk4NTQF/i3MIpTBCTzCS6
	tnYxQtjyEtvfzmGewCg0C8khs5AsnIWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
	NzECo3bbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEV6zHQdShXhTEiurUovy44tKc1KLDzGaAgNj
	IrOUaHI+MG3klcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwdWZq
	dQSv3B745sjueMd5S/ZP3yy2uaVz97d1J6Q+5kTohcSvmP4k6Z2XeVDP3cuiaV9mKh58ybVz
	twLLqSeVG57ay9yWMU/osL7k+jFc6oPYopo2M/5pa3c/+vn5dMwMNZ6TL7z8LyS85/rnd55r
	zvSQvhptW4OHJryrsuTunFqozMwdOXGu3OUpNpnseZt7pdcZXqsvKzhyvfLzppxP93pzmUpZ
	jcq5jJ7tfnRvYrCKj8njiwW5S+f9WLZV/dRuh/CZPyekbmXl8jVJ+eLp1dDXyCHoU7zu+htl
	WYvGZW7TOzINjOb4H56pH7ThN/OuRelv66TWODP86zI4erlm0R1Nx0oGxaKsTQFKHj5PlViK
	MxINtZiLihMB7O+9q2MDAAA=
X-CMS-MailID: 20240208074713eucas1p15395b9e096efb41627ead90887dca45c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240207213600eucas1p1615e189e07dd1e96b001c7a187854fce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240207213600eucas1p1615e189e07dd1e96b001c7a187854fce
References: <10423008.nUPlyArG6x@kreacher>
	<708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
	<CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
	<4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
	<CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
	<ZcOyW_Q1FC35oxob@slm.duckdns.org>
	<2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
	<ZcPSuUBoL_EDvcTF@slm.duckdns.org> <ZcPelerpp3Rr5YFW@slm.duckdns.org>
	<b4ceab79-3208-419b-9a79-f34540db3f70@samsung.com>
	<CGME20240207213600eucas1p1615e189e07dd1e96b001c7a187854fce@eucas1p1.samsung.com>
	<ZcP3uiapKGZqw0q5@slm.duckdns.org>


On 07.02.2024 22:35, Tejun Heo wrote:
> Hello,
>
> On Wed, Feb 07, 2024 at 10:30:58PM +0100, Marek Szyprowski wrote:
> ...
>> Disabling non-boot CPUs ...
>> XXX wq_update_node_max_active: wq=events_unbound off_cpu=1 total=3 range=[32, 512] node[0] node_cpus=3 max=512
>> XXX wq_update_node_max_active: wq=events_unbound off_cpu=2 total=2 range=[32, 512] node[0] node_cpus=2 max=512
>> XXX wq_update_node_max_active: wq=events_unbound off_cpu=3 total=1 range=[32, 512] node[0] node_cpus=1 max=512
>> Enabling non-boot CPUs ...
>> XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=2 range=[32, 512] node[0] node_cpus=2 max=512
>> CPU1 is up
>> XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=3 range=[32, 512] node[0] node_cpus=3 max=512
>> CPU2 is up
>> XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=4 range=[32, 512] node[0] node_cpus=4 max=512
>> CPU3 is up
> So, the node max_active does stay at 512. The only pwq which uses min_active
> would be the dfl_pwq but I'm not sure why that'd be being used. Can you
> please post the output of `drgn -v vmlinux tools/workqueue/wq_dump.py`?

I've tried to get drgn running on the test target, but then I've noticed 
that it is not possible to run it on ARM 32bit target, as it requires 
PROC_KCORE support, which is 'Visible if: PROC_FS [=y] && MMU [=y] && 
!ARM [=y]' for some reasons.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


