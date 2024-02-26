Return-Path: <linux-kernel+bounces-81110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4986704F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7631F2AF60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE5383B1;
	Mon, 26 Feb 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XqsvtyJm"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40411C292;
	Mon, 26 Feb 2024 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941130; cv=none; b=qCpC6xoDkVLB4B4oQ77cRZbXDrcCbE8RfStgdNQ94Mt0V+ivDN59EeqMCCJc3514cNliIiCw2jYvjOUGw9xBro7fjodMKXxJShar2GCYM/PuzDM19nOgzGYCt2aukogzlVE3c7Ld3pnosKawF0BDWw9iC8q1eFflgkE1fsjFXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941130; c=relaxed/simple;
	bh=bjjIsryzIkgWdBrE8ljZIXZJZRlbXaBSO7Ggu+Lj5iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e44vq4T9c08Nce+1u3e1cpeYkaAt7qn22ZZS8K/bZA30VN2p6gVwrQYE0i5hxSSXb9SSwNPDDNIZ3XcEa7cLHHR56SCxs0kFvvT5PE/S0tf+AlpaCB1OwP/nolBgOJhty9+26tLGHUOVS39c2JLalXBtZkuyBZr+RG3PGCqId30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XqsvtyJm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=L5xZC2Izj3nU4loPeVkRvNhUrf88CIQ/mXkio06DCJA=;
	t=1708941128; x=1709373128; b=XqsvtyJmNUSaNWFt9a2Zxhc3MycXQ0yGyWfptFBzVgwvvJV
	ZER5JGxcGB0baVlQqe+3Rhjez/IvMkT7cV9pjA+F/tnRfu1S2nxLtVOa7dQGhQeZ8PbcBYBSe1S2n
	AwPY7QlC75hRGY+k1WRKpU7xGLLLmNn+Q3VbrC25DN84K2Kz3mZKR5fn2xUP7xo5Gl8xMFooD0otp
	j7MKKdIa5or+lre24YntO+jo0QHfL/e6uJ3kjH6ioOYzelpBqOm34JHF3PVVr4FzQGETyAnSEjOBj
	ISHxuZFoVP59sFQ7PaZvnVdaH+Zeuj2CYsOKyN74WZjh8bLkHwG15Gy+PTz/BLIg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1reXeL-0004Te-6R; Mon, 26 Feb 2024 10:51:53 +0100
Message-ID: <410817b8-1cf9-4285-b20b-f1fa0513cee8@leemhuis.info>
Date: Mon, 26 Feb 2024 10:51:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: This is the fourth time I've tried to find what led to the
 regression of outgoing network speed and each time I find the merge commit
 8c94ccc7cd691472461448f98e2372c75849406c
Content-Language: en-US, de-DE
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-x86_64@vger.kernel.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
 <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
 <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
 <CABXGCsOd=E428ixUOw+msRpnaubgx5-cVU7TDXwRUCdrM5Oicw@mail.gmail.com>
 <34d7ab1b-ab12-489d-a480-5e6ccc41bfc3@infradead.org>
 <10487018-49b8-4b27-98a1-07cee732290d@infradead.org>
 <4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com>
 <3ea25443-1275-4c67-90e0-b637212d32b5@leemhuis.info>
 <1e719367-01ae-565a-2199-0ff7e260422b@linux.intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <1e719367-01ae-565a-2199-0ff7e260422b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708941128;d91db294;
X-HE-SMSGID: 1reXeL-0004Te-6R

On 26.02.24 10:24, Mathias Nyman wrote:
> On 26.2.2024 7.45, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 21.02.24 14:44, Mathias Nyman wrote:
>>> On 21.2.2024 1.43, Randy Dunlap wrote:
>>>> On 2/20/24 15:41, Randy Dunlap wrote:
>>>>> {+ tglx]
>>>>> On 2/20/24 15:19, Mikhail Gavrilov wrote:
>>>>>> On Mon, Feb 19, 2024 at 2:41 PM Mikhail Gavrilov
>>>>>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>>>> I spotted network performance regression and it turned out, this was
>>>>>> due to the network card getting other interrupt. It is a side effect
>>>>>> of commit 57e153dfd0e7a080373fe5853c5609443d97fa5a.
>>>>> That's a merge commit (AFAIK, maybe not so much). The commit in
>>>>> mainline is:
>>>>>
>>>>> commit f977f4c9301c
>>>>> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
>>>>> Date:   Fri Dec 1 17:06:40 2023 +0200
>>>>>
>>>>>       xhci: add handler for only one interrupt line
>>>>>
>>>>>> Installing irqbalance daemon did not help. Maybe someone experienced
>>>>>> such a problem?
>>>>>
>>>>> Thomas, would you look at this, please?
>>>>>
>>>>> A network device and xhci (USB) driver are now sharing interrupts.
>>>>> This causes a large performance decrease for the networking device.
>>>
>>> Short recap:
>>
>> Thx for that. As the 6.8 release is merely two or three weeks away while
>> a fix is nowhere near in sight yet (afaics!) I start to wonder if we
>> should consider a revert here and try reapplying the culprit in a later
>> cycle when this problem is fixed.

Thx for the reply.

> I don't think reverting this series is a solution.
> 
> This isn't really about those usb xhci patches.
> This is about which interrupt gets assigned to which CPU.

I know, but from my understanding of Linus expectations wrt to handling
regressions it does not matter much if a bug existed earlier or
somewhere else: what counts is the commit that exposed the problem.

But I might be wrong here. Anyway, not CCing Linus for this; but I'll
likely point him to this direction on Sunday in my next weekly report,
unless some fix comes into sight.

> Mikhail got unlucky when the network adapter interrupts on that system was
> assigned to CPU0, clearly a more "clogged" CPU, thus causing a drop in max
> bandwidth.

But maybe others will be just as "unlucky". Or is there anything to
believe otherwise? Maybe some aspect of the .config or local setup that
is most likely unique to Mikhail's setup?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

