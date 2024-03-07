Return-Path: <linux-kernel+bounces-95549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8427874F53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2595B1C21469
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18812BEB1;
	Thu,  7 Mar 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="EdsQNeU6"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410B7E76B;
	Thu,  7 Mar 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815344; cv=none; b=i/kdBIgnqEHt3yldHBBNmcgPltRrwRbEjqZxM83IwCW23ikOFHrq/q8cr2f9AqpOJicOUGCfkeueV/8ZLQ5HE+xhyWlXLXXmMho/y08IJqyEGFjkMf7qUd36iv33MZWMDX8ey5nURq/iQx9x5DAPKGZgsFLANwpii5AMNZpgvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815344; c=relaxed/simple;
	bh=t6HuFttPC1nxD+nyrrov2Y2NoChjRlY3Abi30iwUEyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1Wz96tUieUlgavuoOsXGycrxt1f/q+87S8X1QXld1hdA69FhTei9QfMxg331sBg993JAcg/73zegonD5L73k36ndejscnnNbXRj0fkkYuZDhGz1p060ggOFlwQIopOMg2Z3gCGf5fgmvM99yTG0dERaWIzx5MSHPH3PvtEdyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=EdsQNeU6; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tr88819Wpz686f;
	Thu,  7 Mar 2024 13:42:16 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tr87z50BGz6821;
	Thu,  7 Mar 2024 13:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709815335;
	bh=AVHNr47rSvulz8LrB0QQznO8Zw2QTzCYetLSkLBWuf4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EdsQNeU616Fl0FTZl709rzR8Xv5Qe21y99dZvo+Xe5uc50GnmuOwMEEulTzrVUMQJ
	 NvD9sACX5r2g2QNQ5g7PLCkrSYzBTcIe/JhIaNGEx9Gd/WdWUg2UkBJI+cJAGY2qnl
	 VjaWLmRBcT+SpQVQdcGoKb8OaDg7P1GCNjsi9aEg=
Message-ID: <74afd65d-85ed-4ee9-b5f2-a6702f9bc01c@gaisler.com>
Date: Thu, 7 Mar 2024 13:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
 <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
 <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
 <75a4a08d-85c2-4a60-9cbd-90dd50f765a8@app.fastmail.com>
 <5d97d50a-9d40-4651-8071-073dee5f9aa8@gaisler.com>
 <001ba36a-9d4c-45c4-b1f2-448824848afc@app.fastmail.com>
 <5568f26d-9e1a-4530-a086-564659b21666@app.fastmail.com>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <5568f26d-9e1a-4530-a086-564659b21666@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-06 19:19, Arnd Bergmann wrote:
> On Wed, Mar 6, 2024, at 17:22, Arnd Bergmann wrote:
>> On Wed, Mar 6, 2024, at 16:31, Andreas Larsson wrote:
> 
>> On a relate note, it does seem odd to have such a small
>> lowmem area, and I wonder if that could be extended.
>> The 192MB lowmem limit comes from 
>>
>> #define SRMMU_MAXMEM            0x0c000000
>>
>> but I don't understand if that is a hardware limitation
>> or a design choice that can be changed, and if it is
>> even valid on leon or only on the old sun machines.
> 
> I had another look and found that this is a result of
> 
> arch/sparc/include/asm/page_32.h:#define PAGE_OFFSET    0xf0000000
> 
> which gives 3840MiB to userspace addresses, leaving only
> 256MiB for kernel lowmem and vmalloc space, which is
> less than any other architectures.
> 
> I still don't know the history behind this choice, but I
> see this was already configured the same when arch/sparc/
> was originally merged. You can probably change it to a more
> sensible 0xc0000000 or 0x80000000 like on other
> architectures and run without highmem on anything with
> less than 2GB of total RAM.
> 
> How much RAM do Leon machines have typically, or at the
> maximum?
The amount of RAM can vary greatly between systems, from less that
128 MiB up to 2 GiB. An upcoming design uses the entire 36-bit
physical address space and have the possibility of having up to 60
GiB memory.

Thanks,
Andreas


