Return-Path: <linux-kernel+bounces-80605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC5866A44
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A761282AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517751BC40;
	Mon, 26 Feb 2024 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtaDjU+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6C18E2A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930102; cv=none; b=eL9TY6QclF/T+ZbCY56bFT3Z94dRqgEvWUlitqTg3iwociKGsE5bTLpf81f3DfGE161IVLSpIf8hO1Ni85FrYwv/pbS6y4kCZfXE5fIy6Xl0xNa6uGaW9YkSpe6baxucpuYbIkmRFXzyHRcj4Eut1O19KALnA5lsvSRiv6s8Fz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930102; c=relaxed/simple;
	bh=FNhLB11u49PkDdPAlymv79Dni35HVKGs4cgtYI0JOd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akscTTaCp/gdmpy1GExzX7sy1R+ICY7TZVWkGYL2ccxCQHdXkAkBwwRPVIaglBonzblCwsvfsMZIz8Www6UGSsF6gesE8wTszWVkbr+Kj87kV1i7vtoqcD2aXcHc+bQY0Hox5C0EeThvkm5OBhWN+mNy+jTatt5xrmjdvm8EpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtaDjU+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37527C433F1;
	Mon, 26 Feb 2024 06:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708930102;
	bh=FNhLB11u49PkDdPAlymv79Dni35HVKGs4cgtYI0JOd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RtaDjU+q2AGjbskrExrHxJCKsfi4cDqvPObSm94Gmn4YFYjl7dyuSMHcW5BQDuuRs
	 86Xa98gyNVCR4uaXyIIxFs5gteN5osYJR72sNDgxyC8KEPQ8nS/Inw4k8GKc/UtF+u
	 SsYUINlmOo7FpTaZBCzVvIdG5dMfHB+zaEPqUPmDKzE6AG16zjG3m4jTRJIZntWOa3
	 RX+XJlChhUBelWhY77a7V1OUxZe5WfvYDh4y6fFjwdZxgPBrkZeJNB7He3VdzNgsX1
	 lnOtVVrrhvtqwbrsMrrn7gWoJfAPjMgSW4TmiAffwjf4rgGRctEQpqlGjElW8vIdX3
	 GbWwkJ/s+WIKg==
Message-ID: <03f16549-fdbf-4050-888a-b9e27e2b2dff@kernel.org>
Date: Mon, 26 Feb 2024 14:48:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org>
 <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
 <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org>
 <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/26 11:25, Zhiguo Niu wrote:
> Dear Chao,
> 
> On Fri, Feb 23, 2024 at 10:38 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/2/23 10:01, Zhiguo Niu wrote:
>>>
>>>
>>> On Thu, Feb 22, 2024 at 8:30 PM Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> wrote:
>>>
>>>      On 2024/2/7 10:01, Zhiguo Niu wrote:
>>>       > A panic issue happened in a reboot test in small capacity device
>>>       > as following:
>>>       > 1.The device size is 64MB, and main area has 24 segments, and
>>>       > CONFIG_F2FS_CHECK_FS is not enabled.
>>>       > 2.There is no any free segments left shown in free_segmap_info,
>>>       > then another write request cause get_new_segment get a out-of-bound
>>>       > segment with segno 24.
>>>       > 3.panic happen in update_sit_entry because access invalid bitmap
>>>       > pointer.
>>>
>>>      Zhiguo,
>>>
>>>      Can you please try below patch to see whether it can fix your problem?
>>>
>>>      https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org <https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org>
>>>
>>>      Thanks,
>>>
>>>
>>> Dear Chao,
>>> I need to coordinate the testing resources. The previous testing has been stopped because it was fixed with the current patch. In addition, this requires stability testing to reproduce, so it will take a certain amount of time. If there is any situation, I will tell you in time.
>>
>> Zhiguo, thank you!
> 
> We tested this patch  this weekend on the previous version with
> problem, and it can not reproduce panic issues,
> so this patch should fix the original issue.

Zhiguo,

Thanks a lot for the test!

Do you mind replying to original patch below tag?

Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Thanks,

> thanks！
> 
>>
>> BTW, I've tested this patch for a while, and it looks there is no issue w/
>> FAULT_NO_SEGMENT fault injection is on.
>>
>>> btw, Why can’t I see this patch on your branch^^?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test <https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test>
>>
>> Too lazy to push patches in time, will do it in this weekend. :P
>>
>>> thanks！
>>>
>>>
>>>       >
>>>       > More detail shown in following patch sets.
>>>       > The three patches are splited here because the modifications are
>>>       > relatively independent and more readable.
>>>       >
>>>       > ---
>>>       > Changes of v2: stop checkpoint when get a out-of-bound segment
>>>       > ---
>>>       >
>>>       > Zhiguo Niu (4):
>>>       >    f2fs: correct counting methods of free_segments in __set_inuse
>>>       >    f2fs: fix panic issue in update_sit_entry
>>>       >    f2fs: enhance judgment conditions of GET_SEGNO
>>>       >    f2fs: stop checkpoint when get a out-of-bounds segment
>>>       >
>>>       >   fs/f2fs/file.c          |  7 ++++++-
>>>       >   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
>>>       >   fs/f2fs/segment.h       |  7 ++++---
>>>       >   include/linux/f2fs_fs.h |  1 +
>>>       >   4 files changed, 27 insertions(+), 9 deletions(-)
>>>       >
>>>

