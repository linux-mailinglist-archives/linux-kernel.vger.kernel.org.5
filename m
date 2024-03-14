Return-Path: <linux-kernel+bounces-103794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6EE87C49E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71201281E82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92576418;
	Thu, 14 Mar 2024 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b="KyBbJo8n"
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7F76412
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450765; cv=none; b=ni41OT4OCxataLzut0hYjcn0eBmOGPT69UcBxeL3IkkjJ9xXOnYo9TOt5IOvNzBXjJ0MzxzCe2fv2GiWTlaO6Xe/D1GC64yRPs9AOJfIiWNJQoVbT3R4QxrXsJvlqTipZOL/7/RjF/TfIDUOBrA5jD0ubakzd9LHx5cHYiQq3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450765; c=relaxed/simple;
	bh=cxbt0Kto7LLbG5HBcH4uBdiNWLpw971VYFKfs7//BVE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BmEW33Fjq+EK2+nBbhtvkfTMHIW6mAMqE5ryHv6pEucPrUfXBrFRH7M/K2/uCRfXEA1RoN9ttORtX0UBqbkCD6bbOqyCl51+cS7a5Ezvk1iIInAWpTWnnaNY3Yk758DpbXyj+yl4Ie3xIOJVFc7eSvJjwGTi43chiiYPVOY4hM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b=KyBbJo8n; arc=none smtp.client-ip=193.222.135.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 27455 invoked from network); 14 Mar 2024 22:12:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1710450752; bh=YX1IMT/rGJouPHhbyVD7uVQM40o/Eaq44nz7BmgAm+U=;
          h=Subject:From:To:Cc;
          b=KyBbJo8nS7q+dODnfxHc/Cg0Luuig4CwT0+ZBXSBWahx404irZJsuYoI7AwjyJFqc
           Y2GWICZ8M+F+OBPEubqNeZlXVYiDZD55nOLtNATnhHP57KygEemnJjJv2FADvTgg1y
           1tvKW9U2Hr1qKtY1sEUcMMAzgUkPjlpeNGwF5Sjg=
Received: from aaff212.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.135.212])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <sashal@kernel.org>; 14 Mar 2024 22:12:32 +0100
Message-ID: <ba297ed4-a74a-4786-a303-ce617b2de09b@o2.pl>
Date: Thu, 14 Mar 2024 22:12:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
Content-Language: en-GB
From: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de,
 Andreas Herrmann <aherrmann@suse.de>, Tejun Heo <tj@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <20240313163957.615276-1-sashal@kernel.org>
 <73072bdd-590a-44b4-8e6d-34bd17073bb5@o2.pl>
 <ecb0b6a1-a8e7-4645-9a2c-56ada368f733@o2.pl>
Autocrypt: addr=mat.jonczyk@o2.pl; keydata=
 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
 TANkZ3QqXNX2
In-Reply-To: <ecb0b6a1-a8e7-4645-9a2c-56ada368f733@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 2e9b3fe422a5616a1c0cf133ade012c5
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [kTMU]                               

W dniu 13.03.2024 o 22:27, Mateusz Jończyk pisze:
> W dniu 13.03.2024 o 21:13, Mateusz Jończyk pisze:
>> W dniu 13.03.2024 o 17:38, Sasha Levin pisze:
>>> This is the start of the stable review cycle for the 6.1.82 release.
>>> There are 71 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
>>> or in the git tree and branch at:
>>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>> and the diffstat can be found below.
>>>
>>> Thanks,
>>> Sasha
>>>
>> Hello,
>>
>> Kernel hangs during early boot. No console messages, nothing in pstore.
>>
>> Tested on a HP 17-by0001nw laptop with an Intel Kaby Lake CPU (Intel i3-7020U) and Ubuntu 20.04.
>>
>> This CPU is not affected by RFDS (at least according to the Kconfig message), so I have set
>>
>> CONFIG_MITIGATION_RFDS=n
>>
>> in Kconfig. I do not have any updated microcode (if any will be provided at all for this CPU).
>>
>> Greetings,
>>
>> Mateusz
>>
> [snip]

Bisected down to

commit d3d517a95e83a7d89e1ff511da1a0a31c9234155
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri Feb 3 16:03:54 2023 +0100

    blk-rq-qos: make rq_qos_add and rq_qos_del more useful
    
    [ Upstream commit ce57b558604e68277d31ca5ce49ec4579a8618c5 ]
    
    Switch to passing a gendisk, and make rq_qos_add initialize all required
    fields and drop the not required q argument from rq_qos_del.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
    Acked-by: Tejun Heo <tj@kernel.org>
    Link: https://lore.kernel.org/r/20230203150400.3199230-14-hch@lst.de
    Signed-off-by: Jens Axboe <axboe@kernel.dk>
    Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 block/blk-iocost.c    | 13 +++----------
 block/blk-iolatency.c | 14 ++++----------
 block/blk-rq-qos.c    | 13 ++++++++++---
 block/blk-rq-qos.h    |  5 +++--
 block/blk-wbt.c       |  5 +----
 5 files changed, 21 insertions(+), 29 deletions(-)

Greetings,

Mateusz


