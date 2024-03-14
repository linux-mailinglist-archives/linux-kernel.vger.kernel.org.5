Return-Path: <linux-kernel+bounces-103837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F587C52C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEDE282BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8AB4A11;
	Thu, 14 Mar 2024 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX6XtNaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD8385;
	Thu, 14 Mar 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455748; cv=none; b=B5CkMPyAuLnWVT1uQLCQVIHYnU8VivNAsm75/i2AeiLjLAWEUcSm6QkCpC/4pzUjLWvu2QB7vYepGIF+SvNso17y8HkGsVOH7Sz+gw2hoVe5PgSVqPdtNeRGYABIpC0x7HD8HJdlCXXCR9YgqG8Oxl6uz53SnJTQXl2qk3zcjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455748; c=relaxed/simple;
	bh=8m3dmRcZ5P3JHYGEc7FPn/cMufCHSynVdN4bnSMfy74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um4NpOPyORM0in+5OyQeh9GiNNJDbIbbSifkhE4szFJl0adT+6gQhByNbADwxpr8EvDVemLvQ1q+EWFvYwP5dDymCko84YNDfGVUgeJ7xjw1c2k371E42CMyqZaaWtS+xuMylg7azYY6XeakXVMYn3lSraUM1XmJOD1/4kTiR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX6XtNaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF58BC433F1;
	Thu, 14 Mar 2024 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710455748;
	bh=8m3dmRcZ5P3JHYGEc7FPn/cMufCHSynVdN4bnSMfy74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hX6XtNaWCfLPG2PNuAbv7dIU/a4MaVdCqzc81r9LMMeC1/IICY6XdfE0A9iFYtZ8b
	 gA1ZzhtjgfDjbC9GWbDiGxH13Tj5TakJ3Edufx74HD2EvvIiDrshbCq9BlQisy1NP/
	 U3+Ks2yLIJWt53lh35FdJzzqijvZiCR+VDA8JvbbpNtW68xed+51zjhgGaxvcX5Vgn
	 1SvrFkcIgqKUxLLAI/cIGU7eWlg0SlkFleRG+wy4IQMqH9S0p5Gt6m6m7kgn6xcr/x
	 jDek8DclY29qkpPmeiyMaKy7pSMFFTxN83kQDKngN2enWG9rhmv3Ku5GBHPKwTa+ag
	 VOwvwIXbIxMDQ==
Date: Thu, 14 Mar 2024 18:35:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	Andreas Herrmann <aherrmann@suse.de>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
Message-ID: <ZfN7wtnVeb9vOL1H@sashalap>
References: <20240313163957.615276-1-sashal@kernel.org>
 <73072bdd-590a-44b4-8e6d-34bd17073bb5@o2.pl>
 <ecb0b6a1-a8e7-4645-9a2c-56ada368f733@o2.pl>
 <ba297ed4-a74a-4786-a303-ce617b2de09b@o2.pl>
 <38563683-300a-487b-81c6-b2ea4dbb925c@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38563683-300a-487b-81c6-b2ea4dbb925c@kernel.dk>

On Thu, Mar 14, 2024 at 04:04:59PM -0600, Jens Axboe wrote:
>On 3/14/24 3:12 PM, Mateusz Jończyk wrote:
>> W dniu 13.03.2024 o 22:27, Mateusz Jończyk pisze:
>>> W dniu 13.03.2024 o 21:13, Mateusz Jończyk pisze:
>>>> W dniu 13.03.2024 o 17:38, Sasha Levin pisze:
>>>>> This is the start of the stable review cycle for the 6.1.82 release.
>>>>> There are 71 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>> The whole patch series can be found in one patch at:
>>>>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
>>>>> or in the git tree and branch at:
>>>>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>>>> and the diffstat can be found below.
>>>>>
>>>>> Thanks,
>>>>> Sasha
>>>>>
>>>> Hello,
>>>>
>>>> Kernel hangs during early boot. No console messages, nothing in pstore.
>>>>
>>>> Tested on a HP 17-by0001nw laptop with an Intel Kaby Lake CPU (Intel i3-7020U) and Ubuntu 20.04.
>>>>
>>>> This CPU is not affected by RFDS (at least according to the Kconfig message), so I have set
>>>>
>>>> CONFIG_MITIGATION_RFDS=n
>>>>
>>>> in Kconfig. I do not have any updated microcode (if any will be provided at all for this CPU).
>>>>
>>>> Greetings,
>>>>
>>>> Mateusz
>>>>
>>> [snip]
>>
>> Bisected down to
>>
>> commit d3d517a95e83a7d89e1ff511da1a0a31c9234155
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Fri Feb 3 16:03:54 2023 +0100
>>
>>     blk-rq-qos: make rq_qos_add and rq_qos_del more useful
>
>Do you have:
>
>commit e33b93650fc5364f773985a3e961e24349330d97
>Author: Breno Leitao <leitao@debian.org>
>Date:   Tue Feb 28 03:16:54 2023 -0800
>
>    blk-iocost: Pass gendisk to ioc_refresh_params
>
>in there?

It's not in the 6.1 tree, do we need it?

-- 
Thanks,
Sasha

