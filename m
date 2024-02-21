Return-Path: <linux-kernel+bounces-74395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5E185D364
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98496B25467
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A23D0C6;
	Wed, 21 Feb 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="MP0cVlVC"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225AF383BF;
	Wed, 21 Feb 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507394; cv=none; b=HGP1NSwJJ8qr890u7VrW3u7HlkPF8YNF7pWFVI4GSrG8dwzBQIj43REdRyHjuFU5Nh/9qx4LLkKAdA7U0YE/p9T2rYQBDOjLfYBjlRIoU5BrDOi/A+t3uu0/jkBWRSBmIthTdOlybq7jQgHf1fVmOomO2DyLNW21brTRXoopMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507394; c=relaxed/simple;
	bh=0QR9CkrQOkYy9tKXZSu0qJqpOgrTbQV4Pwczfzxc8Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWBhXP6NTreXNLdz/O57IeEXlzmuDhHeeRlF/ILPyO3pQDB6/F0WgmURTMbjkSJz0jgA8V+YIBooBsCwLtOG4yLm/Ql3kq/qlQydw339aO4OPrYK48bXbE8xB/J/Zy7bYaYUJIY0nwwnPCfGcN3ZE2EEl24qE63v3Go4HvsEcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=MP0cVlVC; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=a5Y+jbVzMCuiskWa37OxLyCmdTfxWKxLyTZ3/6MLB0k=; t=1708507392;
	x=1708939392; b=MP0cVlVCG9MH5+TEumEcBDB3ppnbXhkML/1DPSbQK13Z7VQ6MEp0KipAZxwLq
	VnTXzVPhb/eN9TclYdgf0mhcaNSaIqeyTZ7JZgqFu2gJOUeTn5Lwwd9vrQhqIrWsISh8M+/IYTc/o
	RoAnf4rPScBh+J1AE6S8NCdkvL/Dk9VT1+wVfDQFCeRnKHt68wFo6943hKjaKGhqmSlBEq0JP7ad9
	FyMdxbuilSrZYMfNfsZxmwazA1jY56bRk/vzrB4DHW3olddyrAy0Eiq7HSMpox4IBRap8+ZDKAIBp
	N+K8OTZgu4HMIo5Zd6d0x8YV7eRNTHshz/oy8yZ+HKXzL0SGYg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rciom-0008Qf-JP; Wed, 21 Feb 2024 10:23:08 +0100
Message-ID: <27ee0d22-18aa-453e-9020-76f4687bc044@leemhuis.info>
Date: Wed, 21 Feb 2024 10:23:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: fix build without CONFIG_NTFS3_LZX_XPRESS
Content-Language: en-US, de-DE
To: Chris Clayton <chris2553@googlemail.com>,
 Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
References: <20240214224500.811609-1-shiftee@posteo.net>
 <89630027-f93c-4e1d-a9c0-a120b8f0bc9e@googlemail.com>
 <0f3542a4-d558-447c-9dd7-cbb410c88e23@googlemail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <0f3542a4-d558-447c-9dd7-cbb410c88e23@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708507392;987ebf7b;
X-HE-SMSGID: 1rciom-0008Qf-JP

On 21.02.24 09:27, Chris Clayton wrote:
> 
> This build regression also shows up, along with other problems, in a
> report to the ntfs3 list by the kernel test robot.[1]
> 
> Also, as this patch seems not to have been picked up by the NTFS3
> maintainer I've added Thorsten Leemhuis so he can consider adding
> this egression to the tracker.

You mistyped my email address, but I noticed this by chance. :-D

Mark, could you do me a favor and send a v2 that picked up the Tested-by
and includes a Fixes: tag for the commit causing it? Then in case
Konstantin doesn't pick this up any time soon I'll ask Linus to pick
this up straight from the list.

Ciao, Thorsten

> [1]
> https://lore.kernel.org/ntfs3/202402211322.4GbTCzp8-lkp@intel.com/T/#u>
> Chris>
> On 19/02/2024 07:21, Chris Clayton wrote:
>> Hi.
>>
>> On 14/02/2024 22:45, Mark O'Donovan wrote:
>>> When CONFIG_NTFS3_LZX_XPRESS is not set then we get the following:
>>> fs/ntfs3/frecord.c:2460:16: error: unused variable ‘i_size’
>>>
>>> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
>>> ---
>>>  fs/ntfs3/frecord.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
>>> index 3b42938a9d3b..7f27382e0ce2 100644
>>> --- a/fs/ntfs3/frecord.c
>>> +++ b/fs/ntfs3/frecord.c
>>> @@ -2457,7 +2457,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>>>  	struct ATTR_LIST_ENTRY *le = NULL;
>>>  	struct runs_tree *run = &ni->file.run;
>>>  	u64 valid_size = ni->i_valid;
>>> -	loff_t i_size = i_size_read(&ni->vfs_inode);
>>>  	u64 vbo_disk;
>>>  	size_t unc_size;
>>>  	u32 frame_size, i, npages_disk, ondisk_size;
>>> @@ -2509,6 +2508,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>>>  		err = -EOPNOTSUPP;
>>>  		goto out1;
>>>  #else
>>> +		loff_t i_size = i_size_read(&ni->vfs_inode);
>>>  		u32 frame_bits = ni_ext_compress_bits(ni);
>>>  		u64 frame64 = frame_vbo >> frame_bits;
>>>  		u64 frames, vbo_data;
>>>
>>> base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
>>
>> Mark - Thanks for the patch.
>> Alex - Fixes a build bug introduced by 4fd6c08a16d7f1ba10212c9ef7bc73218144b463.
>>
>> Tested-by: Chris Clayton <chris2553@googlemail.com>

