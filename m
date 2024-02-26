Return-Path: <linux-kernel+bounces-80567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89438669B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505901F2230A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DA1BC35;
	Mon, 26 Feb 2024 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="TdQPjhip"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7063B1;
	Mon, 26 Feb 2024 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708926320; cv=none; b=GJrIq9UVaS10zcDMF1tFOvo9Zn981HPoUsKkK71/zNWYPEhnVmfUBgtKAlaZVWp1VZSKqzX4m2deeqO7uHvFAm2B2ejieMIjIQsKtZXtD0pX1YfDEt/Rc/Sr19TDHl3C7qcrpgsRaXrUYtOyq2xbo9WIMegL0pAPHCnTWlfi1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708926320; c=relaxed/simple;
	bh=W3WvYJ1W5iT5Wm3BhTG/0Guh2FnUeZ88SryJ8IUXzFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgLjD9nZa+Ed0E/oNzPmrLj0rmvIbwODSEiF3hc2rnHTuPSEre8zkMSeM+m8OLBf7/3PVQGUfOfQf6XQ6z0qp2vIr4PNduI4Hw0Y+Nj2Wg7Kwt3Od1LmzyHS0kgWTACi67rICXGefqNsiMH7TybQRDTS/BUQmiGIobwLn3nNqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=TdQPjhip; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=xB6Xu0g1GUOqfI8cI44Sn7TMaBOPivnjHJRwlKgemTY=;
	t=1708926318; x=1709358318; b=TdQPjhip8FDnMiKR3r8b7gW4EpcO2xNww/f4U2byLWM0qXs
	LaNA456aD317RE7fR5rY5uAJbu8veF0nSN4+2/wTcitOeldakFSwNWaL/CfWv5NpxVcA94JCfCZCR
	qNvS7cb15ZQ1cT1GNZqBHbakvJTrKw0W2yvHyhUkNrA8Z7Oi90U6R+F1sqQlDGMZok3pieFtnU8j7
	u2j/bRIW7nY0GOv0ZDAFQ1+gur5FiETVmQ+BFZw9yhgr1L2T0c1zX0GWyA6IxSck2RTDMiscCsssC
	hRPoXGlPwLecYOgrMdH12a7AcRgih4itOVIT5hu04TDAENxpdKLxe/HV54pPhLbw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1reTnZ-00069C-F6; Mon, 26 Feb 2024 06:45:09 +0100
Message-ID: <3ea25443-1275-4c67-90e0-b637212d32b5@leemhuis.info>
Date: Mon, 26 Feb 2024 06:45:08 +0100
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
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-x86_64@vger.kernel.org, netdev@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Randy Dunlap <rdunlap@infradead.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
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
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708926318;be2f5cd3;
X-HE-SMSGID: 1reTnZ-00069C-F6

On 21.02.24 14:44, Mathias Nyman wrote:
> On 21.2.2024 1.43, Randy Dunlap wrote:
>> On 2/20/24 15:41, Randy Dunlap wrote:
>>> {+ tglx]
>>> On 2/20/24 15:19, Mikhail Gavrilov wrote:
>>>> On Mon, Feb 19, 2024 at 2:41 PM Mikhail Gavrilov
>>>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>> I spotted network performance regression and it turned out, this was
>>>> due to the network card getting other interrupt. It is a side effect
>>>> of commit 57e153dfd0e7a080373fe5853c5609443d97fa5a.
>>> That's a merge commit (AFAIK, maybe not so much). The commit in
>>> mainline is:
>>>
>>> commit f977f4c9301c
>>> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
>>> Date:   Fri Dec 1 17:06:40 2023 +0200
>>>
>>>      xhci: add handler for only one interrupt line
>>>
>>>> Installing irqbalance daemon did not help. Maybe someone experienced
>>>> such a problem?
>>>
>>> Thomas, would you look at this, please?
>>>
>>> A network device and xhci (USB) driver are now sharing interrupts.
>>> This causes a large performance decrease for the networking device.
> 
> Short recap:

Thx for that. As the 6.8 release is merely two or three weeks away while
a fix is nowhere near in sight yet (afaics!) I start to wonder if we
should consider a revert here and try reapplying the culprit in a later
cycle when this problem is fixed.

Mathias, would that be an option? Or is there still hope that we see a
fix for this regression before the release of 6.8?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> xhci (USB) and network device didn't share interrupts, or even interrupt
> the
> same CPU in either good or bad case.
> 
> A change in how many interrupts xhci driver requests changed which CPU
> the network device interrupts.
> 
> In the bad case Mikhail Gavrilovs network device was interrupting CPU0
> together with:
> - IR-IO-APIC    2-edge      timer
> - IR-PCI-MSIX-0000:07:00.0    1-edge      nvme1q1
> 
> In the good case network device was interrupting CPU27 together with:
> - IR-PCI-MSIX-0000:04:00.0   27-edge      nvme0q27
> - IR-PCI-MSIX-0000:07:00.0   28-edge      nvme1q28
> 
> Manually moving network device irq 87 from CPU0 to CPU23 helped.
> (echo 800000 > /proc/irq/87/smp_affinity)
> 
> Thanks
> -Mathias
> 

