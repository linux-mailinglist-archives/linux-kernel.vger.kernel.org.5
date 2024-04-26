Return-Path: <linux-kernel+bounces-159414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A958B2E54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664131C21B04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2732517FF;
	Fri, 26 Apr 2024 01:26:40 +0000 (UTC)
Received: from mail-m3296.qiye.163.com (mail-m3296.qiye.163.com [220.197.32.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD897F8;
	Fri, 26 Apr 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714094799; cv=none; b=gCHkub3ucTTIesU3JFQs4gwPrrfU/8uWh6lgJGC16/ekT5cjfwDyorbyNh2KxOIy1zJPbgTReSENtM/rMm+yAllKvhbXmKNdnadL0VmjQRUDwkpQq4WpxWXthnx38L8vtva5CJ69kGyVAXy7pM6AkXBfdTSdcU/3VAAdDeU+ejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714094799; c=relaxed/simple;
	bh=3xE+7K7ojONhLEDdZlIdx4TbxDGU7UCPcCuHDWCcDH4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WyEkKf9kM3Sa+9Bip1uDPbLcZJTjKNKe2Cdbei2HNuusNk2rm3vBpug638GWgHbB1rwNNv3nQTUOodzatXwx085W01/HIQfbWUkw6ORQPRDHKfAflGYHrMyQHDfciTe4+PAVhI6n1OMsZJmR8s5Y3GuI7plpaIIh++FRXM3Cmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 426828601B7;
	Fri, 26 Apr 2024 09:25:55 +0800 (CST)
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
To: Gregory Price <gregory.price@memverge.com>
Cc: Dan Williams <dan.j.williams@intel.com>, axboe@kernel.dk,
 John Groves <John@groves.net>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Dongsheng Yang <dongsheng.yang.linux@gmail.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
 <ZikhwAAIGFG0UU23@memverge.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <bbf692ec-2109-baf2-aaae-7859a8315025@easystack.cn>
Date: Fri, 26 Apr 2024 09:25:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZikhwAAIGFG0UU23@memverge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSB8dVk1CTkMYSUgeQktDGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f18024efa023ckunm426828601b7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDI6TDo*HzcwIxY3GFEcNAlL
	CEhPFEhVSlVKTEpPS0JPTE5NS09NVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBT0JISTcG



在 2024/4/24 星期三 下午 11:14, Gregory Price 写道:
> On Wed, Apr 24, 2024 at 02:33:28PM +0800, Dongsheng Yang wrote:
>>
>>
>> 在 2024/4/24 星期三 下午 12:29, Dan Williams 写道:
>>> Dongsheng Yang wrote:
>>>> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
>>>>
>>>> Hi all,
>>>> 	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
>>>> 	https://github.com/DataTravelGuide/linux
>>>>
>>> [..]
>>>> (4) dax is not supported yet:
>>>> 	same with famfs, dax device is not supported here, because dax device does not support
>>>> dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.
>>>
>>> I am glad that famfs is mentioned here, it demonstrates you know about
>>> it. However, unfortunately this cover letter does not offer any analysis
>>> of *why* the Linux project should consider this additional approach to
>>> the inter-host shared-memory enabling problem.
>>>
>>> To be clear I am neutral at best on some of the initiatives around CXL
>>> memory sharing vs pooling, but famfs at least jettisons block-devices
>>> and gets closer to a purpose-built memory semantic.
>>>
>>> So my primary question is why would Linux need both famfs and cbd? I am
>>> sure famfs would love feedback and help vs developing competing efforts.
>>
>> Hi,
>> 	Thanks for your reply, IIUC about FAMfs, the data in famfs is stored in
>> shared memory, and related nodes can share the data inside this file system;
>> whereas cbd does not store data in shared memory, it uses shared memory as a
>> channel for data transmission, and the actual data is stored in the backend
>> block device of remote nodes. In cbd, shared memory works more like network
>> to connect different hosts.
>>
> 
> Couldn't you basically just allocate a file for use as a uni-directional
> buffer on top of FAMFS and achieve the same thing without the need for
> additional kernel support? Similar in a sense to allocating a file on
> network storage and pinging the remote host when it's ready (except now
> it's fast!)

I'm not entirely sure I follow your suggestion. I guess it means that 
cbd would no longer directly manage the pmem device, but allocate files 
on famfs to transfer data. I didn't do it this way because I considered 
at least a few points: one of them is, cbd_transport actually requires a 
DAX device to access shared memory, and cbd has very simple requirements 
for space management, so there's no need to rely on a file system layer, 
which would increase architectural complexity.

However, we still need cbd_blkdev to provide a block device, so it 
doesn't achieve "achieve the same without the need for additional kernel 
support".

Could you please provide more specific details about your suggestion?
> 
> (The point here is not "FAMFS is better" or "CBD is better", simply
> trying to identify the function that will ultimately dictate the form).

Thank you for your clarification. totally aggree with it, discussions 
always make the issues clearer.

Thanx
> 
> ~Gregory
> 

