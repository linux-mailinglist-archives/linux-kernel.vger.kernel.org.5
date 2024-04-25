Return-Path: <linux-kernel+bounces-157918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2162C8B1894
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC0D1F24C51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB3B107A8;
	Thu, 25 Apr 2024 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EdEC6kUa"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0664C98;
	Thu, 25 Apr 2024 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010121; cv=none; b=nwjaQG5nOZo6dVYeuEhSQKqHcW5ps6Cwx+UPiay2XSB2S1F6tUUzMiUx04iSKnB7A0TXCylVp/jAdx8eqWivkVDKFhbXdw7RKwDnhimMazFg5iP3y5j4d++SIXrroKLLvbHEZAifbgzDQ+oso/pk/isEnyQWhpqe+MXOZzrqv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010121; c=relaxed/simple;
	bh=FGVt5+/HhZkvumm5NjRvVCXOp7mbK7AOolocdPJNG0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdP+TfNkxIf9/3tx08gSHfBGEycS974+nJFZUYBD87RB8k2WqFs4dHkVORpIW3btO9bHz+iToZJ5VpPc9ixGhlyLAjVOCvkZTWy3GUxNcChZSX14IxEUdi4tbCfuy+jaxA6194mhwo+dHEgvcB3DawZDemvy+NLy2H4/tzSMfDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EdEC6kUa; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714010116; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YAFRhJ5HB0TO+b/A3MNViGG2ANvDKCyKTtiq5YrhLtM=;
	b=EdEC6kUaYT7XdmHYufs/5IUpd7Jkul2VbKfQnkfPOYieJi9mipYIlUEDiGc7h1OFW7p88vNULkMlLHjDulz9U8K1k+GNkWuac32IO4jcCcd2mEy5qQt1eReP+QeGVtUgYkVfG3/tQ6XI2mH6J7Am5jlW9OLzG2wsbojl/v6LlB4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W5DXtPV_1714010114;
Received: from 30.97.48.180(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5DXtPV_1714010114)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 09:55:15 +0800
Message-ID: <d9cac14f-d8e3-4620-ba05-95c3ae689b21@linux.alibaba.com>
Date: Thu, 25 Apr 2024 09:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 erofs-fixes tree
To: Christian Brauner <brauner@kernel.org>
Cc: Baokun Li <libaokun@huaweicloud.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Gao Xiang <xiang@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240424102445.53ba5ba2@canb.auug.org.au>
 <b7332fb7-4c49-3af2-7095-e728a6af8ff7@huaweicloud.com>
 <0dbf63ba-026c-41a7-93fa-55a7a216e627@linux.alibaba.com>
 <20240424-enklave-umgezogen-93524415ee92@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240424-enklave-umgezogen-93524415ee92@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/24 20:51, Christian Brauner wrote:
> On Wed, Apr 24, 2024 at 10:13:43AM +0800, Gao Xiang wrote:
>> Hi Stephen,
>>
>> On 2024/4/24 09:26, Baokun Li wrote:
>>> Hi Stephen,
>>>
>>> On 2024/4/24 8:24, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>>>>
>>>>     fs/erofs/super.c
>>>>
>>>> between commits:
>>>>
>>>>     ab1bbc1735ff ("erofs: get rid of erofs_fs_context")
>>>>     569a48fed355 ("erofs: reliably distinguish block based and fscache mode")
>>>>
>>>> from the erofs-fixes tree and commit:
>>>>
>>>>     e4f586a41748 ("erofs: reliably distinguish block based and fscache mode")
>>>>
>>>> from the vfs-brauner tree.
>>>>
>>>> I fixed it up (I think - I used the former version) and can carry the
>>>> fix as necessary. This is now fixed as far as linux-next is concerned,
>>>> but any non trivial conflicts should be mentioned to your upstream
>>>> maintainer when your tree is submitted for merging.  You may also want
>>>> to consider cooperating with the maintainer of the conflicting tree to
>>>> minimise any particularly complex conflicts.
>>>>
>>> Christian previously mentioned that the fix from the vfs-brauner tree
>>> was an accident:
>>>
>>> "An an accident on my part as I left it in the vfs.fixes branch."
>>>
>>> So the two commits from the erofs-fixes tree are the final fixes.
>>>
>>> I'm very sorry for any inconvenience caused.
>>
>> Yeah, Christian was picked this fix by accident as mentioned in,
>> https://lore.kernel.org/r/20240419-tundra-komodowaran-5c3758d496e4@brauner
>>
>> I guest that was due to his local work at that time since the
>> original idea to fix this issue was from him (thanks again!).
> 
> Yeah, sorry about that. I dropped it a few days ago but was on the road
> for a bit. I'll push a new version by eod.

Yeah, sounds good, thanks :-)

Thanks,
Gao Xiang


