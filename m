Return-Path: <linux-kernel+bounces-94032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A78738D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF2F1C208A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98694132472;
	Wed,  6 Mar 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="BsKkkRCG"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9714612FB31;
	Wed,  6 Mar 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734811; cv=none; b=JlOYE9kPS4g8qHUl+D3WzC268/2pzuDvAaP311NnYLUpW/EH/INPyLEVk8Qb9yUbaQZE2S7q8wkf4nk2I0JeVw84KPJNrk2HL+AbC/tFWwE80XrU/bmFl6N/Y1D8HqKgJXyDwR04FAZW5aHlet+CcRK68hhfnbgRHixh1BWBCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734811; c=relaxed/simple;
	bh=McctcHhqQMibqTvYby+OXEkgk4Kh1OWoXHWLWD0xOC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKIzW1i23PLMEOGSn+ehSssBA2HJXCVOsSVTRFW+a0GBWgxofwXdPT3onY4MIf4b2fth2TnviuN4l8IQmhz79JY3s8PRfbV89fHxM4dplq+Jsn87r8rQpD5x5elvdhwtNn9PlOLComcMyIlfxIBX6HQ+IBXFV/y7n1yLC6PGaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=BsKkkRCG; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TqZMQ2BVyz680t;
	Wed,  6 Mar 2024 15:20:02 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TqZMF6Xq0z681X;
	Wed,  6 Mar 2024 15:19:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709734802;
	bh=hVRSs/eDr7XRRgIPsEAN6nhxFc0Gk85vgNCTb2fvG6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BsKkkRCGa7W0CdTem+fLw58yT5TQbTKLGZNEzY02ITcRxJ1HdAHeAtWXDlbUBaEnJ
	 qFhuybrZKjKhOzDnpn/DTKkBZr49SDjgcspP/c5saZQz8zIiDCgPoB/tggQZz6s7Px
	 0s5ZXRU+XtzyQZ1c2G8iZll7IJbqmn+qvsItTM60=
Message-ID: <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
Date: Wed, 6 Mar 2024 15:19:52 +0100
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
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-05 16:26, Arnd Bergmann wrote:
> On Tue, Mar 5, 2024, at 16:06, Andreas Larsson wrote:
>> On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> 
>>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>>> index 734f23daecca..bdbde506c01e 100644
>>> --- a/arch/sparc/Kconfig
>>> +++ b/arch/sparc/Kconfig
>>> @@ -62,7 +62,6 @@ config SPARC32
>>>  	select HAVE_UID16
>>>  	select LOCK_MM_AND_FIND_VMA
>>>  	select OLD_SIGACTION
>>> -	select ZONE_DMA
>>
>> This however makes a number of PCI drivers that depend on
>> ZONE_DMA unselectable.
> 
> I think that is the correct thing to do then: the only
> drivers that I see with this dependency are PCI sound cards
> that apparently rely on DMA to the 16MB ISA range, which is
> not provided by sparc.

The ZONE_DMA dependency does not seem related to ISA per se. Commit
80ab8eae70e5 ("ALSA: Enable CONFIG_ZONE_DMA for smaller PCI DMA masks")
that started to introduce it did were about ensuring 32-bit masks.

Some of those sound card drivers sets a 24 bit mask, i.e. a 0-16MB
range, but some among those sets a 28, and 30 bit DMA mask with
dma_set_mask_and_coherent. Testing, in a different driver, setting and
allocating under a 30-bit DMA mask (or even a 28-bit DMA mask depending
on where the physical memory resides) is possible before removing
ZONE_DMA, but not after. 

I am also a bit concerned if removing ZONE_DMA will let DMA be allocated
in highmem and what that could lead to.

Cheers,
Andreas


