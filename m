Return-Path: <linux-kernel+bounces-104523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DB87CF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8CE1F2351D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB838380;
	Fri, 15 Mar 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR12Ozyq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36B635;
	Fri, 15 Mar 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513778; cv=none; b=BAwz9xH+nb15F0Be//e8/4AHD+A9Y8MW2dJgGVPLvYJsheNVKuyQW06uviMTtDcYYo27c3hG+NXktrs6e2+nM2r+TTSsxW0S+1UFIE/uRR8e7kuCTgoOIUVb6XD4JQBiQ4y2GGDTN3ORTJPFiRjW4Vsvsu5DKDiOo9X1tSPaIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513778; c=relaxed/simple;
	bh=YVZ3AGkdGM4IWkgAh20tY5NW5h5KLE+t1feZQl2lz8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL38EPwzPhyPQpjUwqMr5BjyPqwMQdE8Xfwwp/8x6euj29c/TNllLM+rnZEfrZYpr+/yeHBO1K1SUUVKB0Cm2iDCMLYwJ+lgBcSqXkOM/EH6yiD0XwJYEQKpy5Q32ZHwy4ICeBkM8dlcd6JhAQUYvQdg3rub+U9IHkVUgyu7Apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR12Ozyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099EBC433F1;
	Fri, 15 Mar 2024 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513777;
	bh=YVZ3AGkdGM4IWkgAh20tY5NW5h5KLE+t1feZQl2lz8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KR12OzyqELPcwTH6wg2e7Mg86ByTHoFFIT9ZsHLlrjJuTU+SwZ5JFtrbKeZSGF8bB
	 CqTCGTTlLyljh7jktSJFhrj2e0oT1BhdeIJN5kpSZ+FbrXM0UN/IR8+W4oel24jx/O
	 kZi7OdxgjCvLVblSWEY3+NOrtWLgL/OijugUbXFhSnz9AAbzpuy9rMgiPSMX4J2t1H
	 mIzjiuGthzgfhUwPXIlMyJHv7KQTYJmttDCvEN1zhJvgN7FjrTU3JUV17B8bteTJuM
	 DCAPyVch/0c4p6YgP2OcQkQIfWoiydA5ILnvy1f54bijRfUlmMc3deAz19uLqIhLIm
	 FhvYSu9VNlPRw==
Date: Fri, 15 Mar 2024 10:42:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	Andreas Herrmann <aherrmann@suse.de>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
Message-ID: <ZfReb38_gCrKno7A@sashalap>
References: <20240313163957.615276-1-sashal@kernel.org>
 <73072bdd-590a-44b4-8e6d-34bd17073bb5@o2.pl>
 <ecb0b6a1-a8e7-4645-9a2c-56ada368f733@o2.pl>
 <ba297ed4-a74a-4786-a303-ce617b2de09b@o2.pl>
 <38563683-300a-487b-81c6-b2ea4dbb925c@kernel.dk>
 <ZfN7wtnVeb9vOL1H@sashalap>
 <267b0000-fba0-4dcf-945d-72b8ca4704c8@kernel.dk>
 <ZfQ7wRX06R-d3X7F@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZfQ7wRX06R-d3X7F@sashalap>

On Fri, Mar 15, 2024 at 08:14:57AM -0400, Sasha Levin wrote:
>On Thu, Mar 14, 2024 at 04:40:53PM -0600, Jens Axboe wrote:
>>On 3/14/24 4:35 PM, Sasha Levin wrote:
>>>On Thu, Mar 14, 2024 at 04:04:59PM -0600, Jens Axboe wrote:
>>>>On 3/14/24 3:12 PM, Mateusz Jo?czyk wrote:
>>>>>W dniu 13.03.2024 o 22:27, Mateusz Jo?czyk pisze:
>>>>>>W dniu 13.03.2024 o 21:13, Mateusz Jo?czyk pisze:
>>>>>>>W dniu 13.03.2024 o 17:38, Sasha Levin pisze:
>>>>>>>>This is the start of the stable review cycle for the 6.1.82 release.
>>>>>>>>There are 71 patches in this series, all will be posted as a response
>>>>>>>>to this one.  If anyone has any issues with these being applied, please
>>>>>>>>let me know.
>>>>>>>>
>>>>>>>>Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
>>>>>>>>Anything received after that time might be too late.
>>>>>>>>
>>>>>>>>The whole patch series can be found in one patch at:
>>>>>>>>        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
>>>>>>>>or in the git tree and branch at:
>>>>>>>>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>>>>>>>and the diffstat can be found below.
>>>>>>>>
>>>>>>>>Thanks,
>>>>>>>>Sasha
>>>>>>>>
>>>>>>>Hello,
>>>>>>>
>>>>>>>Kernel hangs during early boot. No console messages, nothing in pstore.
>>>>>>>
>>>>>>>Tested on a HP 17-by0001nw laptop with an Intel Kaby Lake CPU (Intel i3-7020U) and Ubuntu 20.04.
>>>>>>>
>>>>>>>This CPU is not affected by RFDS (at least according to the Kconfig message), so I have set
>>>>>>>
>>>>>>>CONFIG_MITIGATION_RFDS=n
>>>>>>>
>>>>>>>in Kconfig. I do not have any updated microcode (if any will be provided at all for this CPU).
>>>>>>>
>>>>>>>Greetings,
>>>>>>>
>>>>>>>Mateusz
>>>>>>>
>>>>>>[snip]
>>>>>
>>>>>Bisected down to
>>>>>
>>>>>commit d3d517a95e83a7d89e1ff511da1a0a31c9234155
>>>>>Author: Christoph Hellwig <hch@lst.de>
>>>>>Date:   Fri Feb 3 16:03:54 2023 +0100
>>>>>
>>>>>    blk-rq-qos: make rq_qos_add and rq_qos_del more useful
>>>>
>>>>Do you have:
>>>>
>>>>commit e33b93650fc5364f773985a3e961e24349330d97
>>>>Author: Breno Leitao <leitao@debian.org>
>>>>Date:   Tue Feb 28 03:16:54 2023 -0800
>>>>
>>>>   blk-iocost: Pass gendisk to ioc_refresh_params
>>>>
>>>>in there?
>>>
>>>It's not in the 6.1 tree, do we need it?
>>
>>If the bisected commit is in there, then yes we need it. It's marked as
>>fixes that, so puzzled why it isn't in there?
>
>Sorry, I take it back - both e33b93650fc5 ("blk-iocost: Pass gendisk to
>ioc_refresh_params") and d3d517a95e83 ("blk-rq-qos: make rq_qos_add and
>rq_qos_del more useful") are currently in the 6.1 tree.

I'll go ahead and drop the backport of f814bdda774c ("blk-wbt: Fix
detection of dirty-throttled tasks") as well as the dependencies (which
is where this issue bisected to), and all follow-up fixes.

We can revisit this for the next release.

-- 
Thanks,
Sasha

