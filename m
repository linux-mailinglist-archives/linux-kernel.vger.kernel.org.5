Return-Path: <linux-kernel+bounces-60137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8685009D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572E71F2556A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534038F9B;
	Fri,  9 Feb 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DTu7QvoC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2538392
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520394; cv=none; b=S73JT8u5yumIi4FQyShb3Ucvm5wiiNccd6Ki73rWHFEieod3xHTO3YmyWbPtH4WMdgHt2iXJW7TXTyqSg0Q48Dc9qbKaIFJPbQwJzhC8u4gDyvG92BT60BpmQkDipk2GEaUViSIIAE7NX+rZ1mdo8RhihY2taqMLKurN64ziLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520394; c=relaxed/simple;
	bh=uuEtxV5ALQgg4gSV6SbtQnnx2jogxdpn3fOeoMd9OM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d3qvoybpJL9CYnxvO4O5JjBWmcaXqxVNLUlBQq5UwkG2obodVcb08fFMM8KX4oE5WLYmmf4lH7lEfFqkU+kBOO4oDp0lPqBEV8UiGEyWrtxk/EB05+MVw7bGIPMaZTL8V2MG1pljhpWUdHXEp0ukQZQh+SYwaozEY2FBFEEs6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DTu7QvoC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=f7VpLXkaZnyYw4ZAn+6l9WcMSrOCeJHNjRP6J5T3G+s=; b=DTu7QvoC0kGiSXt2VutNJetr1P
	/kFSFhX4twKqRTu9TlBBNfBdG5E6lUanYO2bjS+K6hci0feUcPrh5F/9DWKM7NSN6P/7kJ7/z82w1
	z8tWUApRyGP2neRpNd95Cw2/9gmqP6ceqe6CZwDqW+gFOgfdoaJzDF83ERowTy9SoYWqvTodoMzv4
	cID1af4QqcV0DNdF6r5eufZ9QxfvrD9RpUdJFRTy2RdbAiisEzRy++0arRRnXHrJf7W9b402ov0KW
	cEx8c0+2rBpdPuDoildGhmG2H/rYwQnAFZ2tn9z3dQKFKfGxTJOMb5b2D6dAV2eopQqtbuTsFTlci
	b+B2HEFQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYa3U-00000000qm4-1Wt2;
	Fri, 09 Feb 2024 23:13:12 +0000
Message-ID: <ed358bfb-9603-4c73-bc20-0980a9678f73@infradead.org>
Date: Fri, 9 Feb 2024 15:13:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: add boot param to disable stack dump on panic
Content-Language: en-US
To: Nir Lichtman <nir@lichtman.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240206213902.GA1490631@lichtman.org>
 <ZcLmjrBxE2BA_hLG@archie.me> <20240208081425.GA1511946@lichtman.org>
 <81f2df0b-0780-458c-b432-5d61b78e8157@gmail.com>
 <20240209095049.GA1528371@lichtman.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240209095049.GA1528371@lichtman.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 01:50, Nir Lichtman wrote:
> On Fri, Feb 09, 2024 at 04:22:12PM +0700, Bagas Sanjaya wrote:
>> On 2/8/24 15:14, Nir Lichtman wrote:
>>> In a lot of cases when there is a kernel panic it obscures on the display the previous problem that caused it and the main
>>> reason is that the call stack prints a lot of lines on the display - and there is no way to scroll back up.
>>> What led me to make this patch is that I was working on running the kernel on my old computer and when I passed root=/dev/sda
>>> to the kernel there was a panic and it could not start init, but since the call stack took almost all the space on the screen,
>>> I couldn't see the available partitions the kernel does detects.
>>>
>>> After this patch, I could just pass in the new boot parameter I added here and then it would not print the call stack,
>>> and I saw the line in which the kernel prints the available partitions.
>>>
>>
>> Please don't top-post; reply inline with appropriate context instead.
>>
>> Thanks for the explanation. Now please send v2 with appropriate maintainers
>> and lists Cc'ed (use scripts/get_maintainer.pl to find ones). Also read
>> Documentation/process/submitting-patches.rst before sending.
>>
>> Ciao!
>>
>> -- 
>> An old man doll... just what I always wanted! - Clara
>>
> 
> Yah I read the docs about submitting patches and ran the get_maintainer script but it didn't find anything for the
> changes I made (except documentation maintainers), I guess maybe the panic.c file has no main mantainer?

True, it doesn't have a primary maintainer. You can use
$ git log kernel/panic.c
to see who has been merging patches for it.

Examples:
Andrew Morton
Petr Mladek (printk or log buffer related)
Ingo Molnar (preemption related)
etc.

If in doubt, Andrew Morton is usually a good guess.

-- 
#Randy

