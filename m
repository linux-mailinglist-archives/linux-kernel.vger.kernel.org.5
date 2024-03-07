Return-Path: <linux-kernel+bounces-96010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF57875605
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894FE1C21267
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004A13440D;
	Thu,  7 Mar 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="e6EJ1O7h"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E357130E3B;
	Thu,  7 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835633; cv=none; b=i913RrES1Kep9x01JDbF5arfvEXdDu4AC41vDcMWWS/LLFvVO1zH6fHDeHjGJL2U4FGy3WA14nFamJKxHoMOnFjU6BlGFgnkHbOUTsJt1iKg+YW835F0Z4vqf1+JP0ZEZuNaYXxvq4Ysof75rLL/is7M6YrzLqvp3vnp6/w/DU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835633; c=relaxed/simple;
	bh=MQ07orCZLuAVz2SXJ+Q340+1S+7a9Vt0FAvrlO4XyU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KxZ9LdSqFXn0MHqZvdncJykP8AtH5AQ1/G6Z0IPlADqGtywVIa/koGCQIaPf9989XNGdptvFu9I/qYoubWdSUG5FNMV9a+jn5Ym2Dd2IPqsAJfvsE2wPrHAbLRVuWr0C7XviS5x7Pb1By8Y9ISLk5ljgD/w6CIIwMrTB2js6bHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=e6EJ1O7h; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TrHfM3GKMz6833;
	Thu,  7 Mar 2024 19:20:27 +0100 (CET)
Received: from [10.10.15.20] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TrHf91SvTz6851;
	Thu,  7 Mar 2024 19:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709835627;
	bh=PuM/TBOUHyQ36cC1eReWyFL59PuLO2Dm+PS5yf10Cfw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=e6EJ1O7hOg8LDh16/jsCKqsHOVVzDxr/sdUeM9Z6/9bz1GzwlT1YxdsgTRLa8QWjs
	 p4a4eVPE+4DNPJetW3tPReXVNU+DnHrhJ6zSHxlFV5I+k/j7T8nP/91OHRcuOjLkS0
	 9TGGnyCdn2+lKwy6d6DAJkFCjrz7ATM3wp6AnU3k=
Message-ID: <c5654b69-209e-4406-ac70-9a4547adfc36@gaisler.com>
Date: Thu, 7 Mar 2024 19:20:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] sparc32: Fix section mismatch in leon_pci_grpci
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
 <b62d0ae6-c2cb-4f2c-b792-2dba52a44e35@gaisler.com>
In-Reply-To: <b62d0ae6-c2cb-4f2c-b792-2dba52a44e35@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-05 16:06, Andreas Larsson wrote:
> On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>>
>> Passing a datastructre marked _initconst to platform_driver_register()
>> is wrong. Drop the __initconst notation.
>>
>> This fixes the following warnings:
>>
>> WARNING: modpost: vmlinux: section mismatch in reference: grpci1_of_driver+0x30 (section: .data) -> grpci1_of_match (section: .init.rodata)
>> WARNING: modpost: vmlinux: section mismatch in reference: grpci2_of_driver+0x30 (section: .data) -> grpci2_of_match (section: .init.rodata)
>>
>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Andreas Larsson <andreas@gaisler.com>
> 
> Could you also add
> 
> Fixes: 4154bb821f0b ("sparc: leon: grpci1: constify of_device_id")
> Fixes: 03949b1cb9f1 ("sparc: leon: grpci2: constify of_device_id")
> 
> for these fixes in your v3 of the series as well as CCing stable?

I'll pick up the whole series apart for the ZONE_DMA removal, so there
is no other need for a v3. I can add the Fixes lines to this one, if it
is ok with you Sam, or take it as is.

Thanks,
Andreas

