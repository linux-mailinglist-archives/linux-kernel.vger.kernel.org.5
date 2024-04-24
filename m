Return-Path: <linux-kernel+bounces-156448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A588B02E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2651F22D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088D157A7C;
	Wed, 24 Apr 2024 07:12:53 +0000 (UTC)
Received: from mail-m92250.xmail.ntesmail.com (mail-m92250.xmail.ntesmail.com [103.126.92.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA11426F;
	Wed, 24 Apr 2024 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942772; cv=none; b=cOfG5r+/UK1C0kSDVg+p9V7aqVjSUiGGLmCy0DC2HBNOfdP85C+gsdP/StaBX/wQzs++Pwm4pM4kfQdEcLu5S+8LP6/pXzeJxSsO/Ev6UYFY4gSQu145wOzaenyHGyXdPtWFQkCEv0hY1+Iur8HFdqbjsXK0ZqFtebZP9RvyQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942772; c=relaxed/simple;
	bh=1qq2VCoGtIPzTz8r0fxP/6/Cncs/mnnfnOfT+3WWaB0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dUMwrRQ0BPmrE2xDypGptiPZFH2qwASeG9C2QIIkZEuHssgJBaioiWgB6+LJZgKX5fKc0ZuZsllZsYflokycRlL9VxhYbM/Xzgu8sJTNqcXPJGHJ1CmrPC9h93g1YgXtJla/hzVBHFaTeG+dYIcp0IZtagDVpTPliZllWnCQPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.126.92.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 0DA0E86023D;
	Wed, 24 Apr 2024 14:33:30 +0800 (CST)
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
To: Dan Williams <dan.j.williams@intel.com>, axboe@kernel.dk,
 John Groves <John@Groves.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dongsheng Yang <dongsheng.yang.linux@gmail.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
Date: Wed, 24 Apr 2024 14:33:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSx0aVk0aTU1KGkkeGEkfTlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f0ecf2fe2023ckunm0da0e86023d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6MDo*Sjc1DREPQhVRARgZ
	NTNPCj5VSlVKTEpIQk9LT0pLTENMVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSE5IQzcG



在 2024/4/24 星期三 下午 12:29, Dan Williams 写道:
> Dongsheng Yang wrote:
>> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
>>
>> Hi all,
>> 	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
>> 	https://github.com/DataTravelGuide/linux
>>
> [..]
>> (4) dax is not supported yet:
>> 	same with famfs, dax device is not supported here, because dax device does not support
>> dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.
> 
> I am glad that famfs is mentioned here, it demonstrates you know about
> it. However, unfortunately this cover letter does not offer any analysis
> of *why* the Linux project should consider this additional approach to
> the inter-host shared-memory enabling problem.
> 
> To be clear I am neutral at best on some of the initiatives around CXL
> memory sharing vs pooling, but famfs at least jettisons block-devices
> and gets closer to a purpose-built memory semantic.
> 
> So my primary question is why would Linux need both famfs and cbd? I am
> sure famfs would love feedback and help vs developing competing efforts.

Hi,
	Thanks for your reply, IIUC about FAMfs, the data in famfs is stored in 
shared memory, and related nodes can share the data inside this file 
system; whereas cbd does not store data in shared memory, it uses shared 
memory as a channel for data transmission, and the actual data is stored 
in the backend block device of remote nodes. In cbd, shared memory works 
more like network to connect different hosts.

That is to say, in my view, FAMfs and cbd do not conflict at all; they 
meet different scenario requirements. cbd simply uses shared memory to 
transmit data, shared memory plays the role of a data transmission 
channel, while in FAMfs, shared memory serves as a data store role.

Please correct me if I am wrong.

Thanx
> .
> 

