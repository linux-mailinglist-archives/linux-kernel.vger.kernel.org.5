Return-Path: <linux-kernel+bounces-73833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2285CC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A121F23EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6FC154C18;
	Tue, 20 Feb 2024 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A8vUMgrM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5440BFD;
	Tue, 20 Feb 2024 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472624; cv=none; b=Uts6cjN+ZcDCYbTvYSUxnb5CqM7rrN3rb1coyyg7/gzB7JNbuim8vfQJcVNiHWB8AEqZxnW4oJjBQN6oRRNArj+tO39yUGM8u9g0N63CICQBgegnAWye6Jdp9ZHOGpQhJX568d0MDwObGVmIE1C0vg2DSrsPcF+qpqQVmdEjGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472624; c=relaxed/simple;
	bh=VazGMhJSTvkwFrahEoUGy3nRCIbT6OF0OS3vNCyiu6I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GQ8spNbvbvqKgPeGgg/KBdlFeE8wN4CQvMF1okuYXSQV9m6YHHgLX6yQcFi++M4q2BVa5gzL1X4lt/XaPJ2asLnhZI6WkRqNQvE5/s/Ca7xKjC3J8U3JnW/+rAc2nsPYwjIvc2QNx239TYiK0gM0qH/U1jfJ+ccBozeME5FAOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A8vUMgrM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=x9Dw4MMF3VS5sGivOkHB9gl6mDFzLtT5Gcu7DU0nXrQ=; b=A8vUMgrM4eMxWlxhvLYm/CX4Do
	ZOfr4rSfAmNGZfDfoqzcfcTFj9oi/z2WE7OBtJpds9ib4IuJdMCLqLasIOyoKsWZ5XInON/Y52lr7
	kdxV+PCh6l2VpNVbN0jhqCvrT3wZq6p5QBwaxS00RoIg4e6SZagyjJcz/0PDk5lFEh5XoBSGPR1X9
	4cfZYX7I2sbO09tg79kiMm7VPB9UDVno3Ff5yqV+ZR6nRLVPxhpsCOS8vgT6Mow74wXcxeVrD+4XO
	/9L8iSGBHjG+mekRL0XPhp+nOLX4RHka1QjobbqUOVYoKWzTdqZkDek2a/RUpgae77CxLnVQxgEWY
	ppn8k8Aw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcZm2-0000000GXFj-1oxN;
	Tue, 20 Feb 2024 23:43:42 +0000
Message-ID: <10487018-49b8-4b27-98a1-07cee732290d@infradead.org>
Date: Tue, 20 Feb 2024 15:43:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-x86_64@vger.kernel.org, netdev@vger.kernel.org
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
In-Reply-To: <34d7ab1b-ab12-489d-a480-5e6ccc41bfc3@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/20/24 15:41, Randy Dunlap wrote:
> {+ tglx]

(this time for real)

> 
> On 2/20/24 15:19, Mikhail Gavrilov wrote:
>> On Mon, Feb 19, 2024 at 2:41 PM Mikhail Gavrilov
>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>
>>> I installed irqbalance daemon and nothing changed.
>>> So who is responsible for irq balancing?
>>
>> Sorry for the noise. Can anyone give me an answer?
>> Who is responsible for distributing interrupts in Linux?
>> I spotted network performance regression and it turned out, this was
>> due to the network card getting other interrupt. It is a side effect
>> of commit 57e153dfd0e7a080373fe5853c5609443d97fa5a.
> 
> That's a merge commit (AFAIK, maybe not so much). The commit in mainline is:
> 
> commit f977f4c9301c
> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
> Date:   Fri Dec 1 17:06:40 2023 +0200
> 
>     xhci: add handler for only one interrupt line
> 
>> Installing irqbalance daemon did not help. Maybe someone experienced
>> such a problem?
>>
> 
> Thomas, would you look at this, please?
> 
> A network device and xhci (USB) driver are now sharing interrupts.
> This causes a large performance decrease for the networking device.
> 
> The thread begins here:
> https://lore.kernel.org/lkml/CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com/
> 
> 
> motherboard:
> "My motherboard is MPG-B650I-EDGE-WIFI looks like it is related to the
> mentioned commit.
> https://www.msi.com/Motherboard/MPG-B650I-EDGE-WIFI"
> 
> network device:
> Network: RTL8125 2.5GbE Controller (rev 05)
> 
> 
> thanks.

-- 
#Randy

