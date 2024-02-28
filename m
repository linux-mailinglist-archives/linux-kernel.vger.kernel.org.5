Return-Path: <linux-kernel+bounces-84319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776A86A4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7239FB26F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F51852;
	Wed, 28 Feb 2024 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ife+onZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D6EDD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083290; cv=none; b=s1T/G+5e/rwwHXl1v3m6o4H8wxc1uO9fHHvbQ1g9cqwz3NOnmLmvLLTUeYnBr0hYYrF+rbhraPyunSkDi8YnH3L4HLBQVcaL/4Jm/pLtlo+03sbHtSFajTzysIPkE3QNucwyF2t4/Z3nEp9nLf/ea4yGmh2uFjLrByvH+W2bQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083290; c=relaxed/simple;
	bh=xbDh3NL+tZVp1UyHoiJ9+BKG31EbR4SOQpOg0CSDafg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFlyScehwKp7G5BpV6Dt8QvM06VDLgTvBBBxEjuOw+C6qKiC5uRjGlYo5qqQBWa3yDKAaJlYEahQO3/EWgzAqSV5RwnHiFdx+5GT/dbrTFlV9+4DwFkIqRVAwdcvNoQyadK5ocz0tS5VRvYh/qh5O9pYwOuVP0fY7P+sKjPOlKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ife+onZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771BBC433F1;
	Wed, 28 Feb 2024 01:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709083290;
	bh=xbDh3NL+tZVp1UyHoiJ9+BKG31EbR4SOQpOg0CSDafg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ife+onZuQUz70GgqxLfbizZLJsArG7Kkqc9+5dR4MXnVNJAH0fbewtJVQYpd828jP
	 cc1QErW+Y12QtmlXiUePwI01zPk1b5vkSQb1ujOg9cbEcJRY/qOq3gD64sfgzto71L
	 YknoaVHk7DX+dYHku7VYAmgwz/BCCQ5KsJqB+Ut6WiNdXvGaoQxFOOXhPMpC4Hm0Xz
	 UIUM4AxC9U8n/fdGhFhgY+1ixhhEmuUSvmeGGuRCI3RLuc+AtEz0abITYnVcOavZt/
	 u1Ziw3B0gJgz7BdqqdaynKSPuL0kW1ENKV9mHWIGhg9EsQGQIn2KkjOXBTwFdc4mGY
	 2l7z1YA8HQ4qA==
Message-ID: <f188ef53-b74e-4173-9d34-5f04c620fc2b@kernel.org>
Date: Wed, 28 Feb 2024 09:21:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org>
 <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
 <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org>
 <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>
 <Zd03RHMKBqv1f6GF@google.com>
 <CAHJ8P3Lj_1pa=npkAsMfeStEY3nWgf591tFndKTT_skFYLv+GQ@mail.gmail.com>
 <Zd4ZTokbVPkj5gy4@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zd4ZTokbVPkj5gy4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/28 1:18, Jaegeuk Kim wrote:
> On 02/27, Zhiguo Niu wrote:
>> On Tue, Feb 27, 2024 at 9:13 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>>
>>> On 02/26, Zhiguo Niu wrote:
>>>> Dear Chao,
>>>>
>>>> On Fri, Feb 23, 2024 at 10:38 AM Chao Yu <chao@kernel.org> wrote:
>>>>>
>>>>> On 2024/2/23 10:01, Zhiguo Niu wrote:
>>>>>>
>>>>>>
>>>>>> On Thu, Feb 22, 2024 at 8:30 PM Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> wrote:
>>>>>>
>>>>>>      On 2024/2/7 10:01, Zhiguo Niu wrote:
>>>>>>       > A panic issue happened in a reboot test in small capacity device
>>>>>>       > as following:
>>>>>>       > 1.The device size is 64MB, and main area has 24 segments, and
>>>>>>       > CONFIG_F2FS_CHECK_FS is not enabled.
>>>>>>       > 2.There is no any free segments left shown in free_segmap_info,
>>>>>>       > then another write request cause get_new_segment get a out-of-bound
>>>>>>       > segment with segno 24.
>>>>>>       > 3.panic happen in update_sit_entry because access invalid bitmap
>>>>>>       > pointer.
>>>>>>
>>>>>>      Zhiguo,
>>>>>>
>>>>>>      Can you please try below patch to see whether it can fix your problem?
>>>>>>
>>>>>>      https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org <https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org>
>>>>>>
>>>>>>      Thanks,
>>>>>>
>>>>>>
>>>>>> Dear Chao,
>>>>>> I need to coordinate the testing resources. The previous testing has been stopped because it was fixed with the current patch. In addition, this requires stability testing to reproduce, so it will take a certain amount of time. If there is any situation, I will tell you in time.
>>>>>
>>>>> Zhiguo, thank you!
>>>>
>>>> We tested this patch  this weekend on the previous version with
>>>> problem, and it can not reproduce panic issues,
>>>> so this patch should fix the original issue.
>>>> thanks！
>>>
>> Dear Jaegeuk,
>>> Hey, do you guys please point out which patches were tested without what?
>> This problem occurred during our platform stability testing.
>> it can be fixed by my  this patch set, mainly be fixed by:
>> f2fs: fix panic issue in update_sit_entry & f2fs: enhance judgment
>> conditions of GET_SEGNO
>> and Chao's patch can also fix this problems testing without my patch
>>> IOWs, which patches should I remove and keep Chao's patch?
>> I think chao's patch is more reasonable, it does error handling more complete.
>> but my patch just do some sanity check for return value of GET_SEGNO
>> Same as other codes(update_segment_mtime)
>> and i think it also needed except this part:
> 
> Thanks for confirmation. It seems it'd be better to revert yours and apply
> Chao's patch first. If you think there's something to improve on top of it,
> could you please send another patch afterwards?

Agreed.

Thanks,

> 
>>
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 3bf2ce46fa0907..bb22feeae1cfcb 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -96,7 +96,8 @@ static inline void sanity_check_seg_type(struct
>> f2fs_sb_info *sbi,
>> (GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (BLKS_PER_SEG(sbi) - 1))
>> #define GET_SEGNO(sbi, blk_addr) \
>> - ((!__is_valid_data_blkaddr(blk_addr)) ? \
>> + ((!__is_valid_data_blkaddr(blk_addr) || \
>> + !f2fs_is_valid_blkaddr(sbi, blk_addr, DATA_GENERIC)) ? \
>> NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi), \
>> GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
>> #define CAP_BLKS_PER_SEC(sbi)
>> because Chao's patch let new_addr=null_addr when  get_new_segment
>> returns NOSPACE,
>> so I think this can be reverted and it also saves code running time.
>> How about Chao's opinions?
>> thanks!
>>>
>>>>
>>>>>
>>>>> BTW, I've tested this patch for a while, and it looks there is no issue w/
>>>>> FAULT_NO_SEGMENT fault injection is on.
>>>>>
>>>>>> btw, Why can’t I see this patch on your branch^^?
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test <https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test>
>>>>>
>>>>> Too lazy to push patches in time, will do it in this weekend. :P
>>>>>
>>>>>> thanks！
>>>>>>
>>>>>>
>>>>>>       >
>>>>>>       > More detail shown in following patch sets.
>>>>>>       > The three patches are splited here because the modifications are
>>>>>>       > relatively independent and more readable.
>>>>>>       >
>>>>>>       > ---
>>>>>>       > Changes of v2: stop checkpoint when get a out-of-bound segment
>>>>>>       > ---
>>>>>>       >
>>>>>>       > Zhiguo Niu (4):
>>>>>>       >    f2fs: correct counting methods of free_segments in __set_inuse
>>>>>>       >    f2fs: fix panic issue in update_sit_entry
>>>>>>       >    f2fs: enhance judgment conditions of GET_SEGNO
>>>>>>       >    f2fs: stop checkpoint when get a out-of-bounds segment
>>>>>>       >
>>>>>>       >   fs/f2fs/file.c          |  7 ++++++-
>>>>>>       >   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
>>>>>>       >   fs/f2fs/segment.h       |  7 ++++---
>>>>>>       >   include/linux/f2fs_fs.h |  1 +
>>>>>>       >   4 files changed, 27 insertions(+), 9 deletions(-)
>>>>>>       >
>>>>>>

