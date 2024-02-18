Return-Path: <linux-kernel+bounces-70143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82E38593EB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E961F21974
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877715CB;
	Sun, 18 Feb 2024 02:01:09 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B51D1368
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708221668; cv=none; b=e+ya+ROzNLm24WCsOr0R8ph2BQfMpt6RwW8R266bny1XcnQmzcvcqhcwz8i/1YtAJN4/jAr7Kf/+6l6Apgh9l4uH1CikfBcrnIUxeQRIEGJUi749395RbTgwe27h5aAikpCwtnBtnReyyJCCAT1poepG0dLB4KsXDuFTjaVjU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708221668; c=relaxed/simple;
	bh=rFirYg2ha41WNC487DisxXZJaYp02RebDyI4wO972ao=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RitbSWVGBCRnK84NtJixQ+Rgny0NB53ELGiYE/XgE9dLeJRVmdVoobB2s5x776ak5b9pnwy4xvGpb0zExi+FsT56jAW8d8CrXn+9uqpHn9eerauEbFROh0zLJ6eaaQNJOESoA+y3ew5X0Zd3yrnsQcD58aniddeKx7G+lGg4km0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TcpmR5mWnz4f3lVm
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:00:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CD2B31A0232
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:01:02 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHcZNFlFQdoEQ--.22983S3;
	Sun, 18 Feb 2024 10:01:01 +0800 (CST)
Subject: Re: [linus:master] [kobject] 1b28cb81da: canonical_address#:#[##]
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org
References: <202402071403.e302e33a-oliver.sang@intel.com>
 <2024020840-bladder-service-0341@gregkh>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <ab5434ce-23b3-1e99-1bb0-0ac7cf9996f0@huaweicloud.com>
Date: Sun, 18 Feb 2024 10:01:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024020840-bladder-service-0341@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXKBHcZNFlFQdoEQ--.22983S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4rtF4DJrykuF4kur1rJFb_yoW8WFyrpa
	yfXan0kF4kJryIyr1jvF4UZF10vr4FyF45KrykWw15Za95ur1fJryxWryFgF93uwn5u39r
	Za1jq3WDu34DZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/2/8 23:48, Greg Kroah-Hartman wrote:
> On Wed, Feb 07, 2024 at 02:42:43PM +0800, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "canonical_address#:#[##]" on:
>>
>> commit: 1b28cb81dab7c1eedc6034206f4e8d644046ad31 ("kobject: Remove redundant checks for whether ktype is NULL")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linus/master 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478 (v6.8-rc3)]
>> [test failed on linux-next/master 076d56d74f17e625b3d63cf4743b3d7d02180379]
>>
>> in testcase: boot
>>
>> compiler: gcc-11
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>>
>> we noticed this issue is very random, as below, observed 4 times out of 68 runs.
>> but we didn't see in on parent.
> 
> Ok, this is odd, but a good enough reason to revert this for now.  I was
> worried about it, and this confirms my worry that there's some codepath
> we aren't taking into account here that those checks were protecting us
> from doing bad things.

Yes, there may be some non-standard usage. kobj->ktype was detached first?

> 
> thanks for the report, and Zhen, if you want to dig into this and see if
> you can figure out what is happening so that you can submit your change
> again, that would be great.

I'm trying to reproduce it. However, for me, it may take a lot of time to
prepare the environment. If kobj->name was printed when the error is
detected, we may be able to solve it directly by reviewing the code.

> 
> greg k-h
> .
> 

-- 
Regards,
  Zhen Lei


