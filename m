Return-Path: <linux-kernel+bounces-48523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D537845D39
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CB3297AAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894327E0E9;
	Thu,  1 Feb 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="34Msl+Kz"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE757E0F0;
	Thu,  1 Feb 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804850; cv=none; b=pd4Ew+f4MYr4XlVKxW/IBJ0QdjP9Sk+VvDQET0brMp8tmRHDcCSIxyh5hIYIneLj1LQc7tFSGwmJWE7n470NoGBlMMO83KaulErZ16ZT0R2cMnKNvlXuJEO+nPtaNkxjuTwqb0CSplfMPWHXKlvW4hk23eLmGYTtC2Ljhvsdtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804850; c=relaxed/simple;
	bh=iZg1XvNNrQTqQv9Xbt4+0uhfMfb2hZQVzICMpctE37w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9H0Q5NiLNi1ThVudYiAeD3YGRN9fS6wCf0yBGtsVkuyajQrTQX7XDod0Vla4eM9+oUldDmt012d1d4Xne80tTsXVGx/HAUxYlgx17OyUKNGu8HqVhEJuMCDxsXYKzzrHmycjlp3qOWZWhKWoIb26of63IYUJZhNTW0QJkLhHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=34Msl+Kz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=iniiD51Qgwz4Ao5KkCfkCegFHmr+NHhd1gASxkl1EPQ=; b=34Msl+Kzci4le/Fltq2WjQe4dY
	Lkds1Yh6T5voCbgUvpxUYWOaENRUru1C38IxGT1Mx9hFGzz42uVHPLz8qWcdpmpERZ7LRs/S0lueF
	lO3jTUer7HIPfFrRK92hpdJbu8YUOeKy7mACF7Vi/1+2ouP1ShwgNXgK1XbYKOrJBm0jKheci6F32
	gK3ciPgWdu3mt+MjdVmCx/jk1XboMIPay+kvHvN4dVceOByETtUP00CrFfQPe0BkIwGThG4o/UTDb
	GnjdA6qICYnQTUjdr42ogpZEqOzS7X7Eiis82odl0GUJuAKzTMbStKcNMODFlPDp0fVbJxW5BfJlb
	ZgrFT00g==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVZuQ-00000008dpB-3Znr;
	Thu, 01 Feb 2024 16:27:26 +0000
Message-ID: <1f53a83d-cae4-4223-ad47-6d1d9c80dc2b@infradead.org>
Date: Thu, 1 Feb 2024 08:27:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] ARM: OMAP2+: fix a bunch of kernel-doc warnings
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 patches@armlinux.org.uk, Paul Walmsley <paul@pwsan.com>,
 =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Kevin Hilman <khilman@kernel.org>
References: <20240117011004.22669-1-rdunlap@infradead.org>
 <20240117131305.GP5185@atomide.com>
 <e6692a04-142c-4df4-83dc-534ab27a55f6@infradead.org>
 <ZbtlOWcGglCeYj6X@shell.armlinux.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZbtlOWcGglCeYj6X@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/1/24 01:32, Russell King (Oracle) wrote:
> On Wed, Jan 17, 2024 at 08:52:16AM -0800, Randy Dunlap wrote:
>>
>>
>> On 1/17/24 05:13, Tony Lindgren wrote:
>>> * Randy Dunlap <rdunlap@infradead.org> [240117 01:10]:
>>>> Fix many kernel-doc warnings in arch/arm/mach-omap2/:
>>>
>>> Thanks for fixing these. These are unlikely to conflict with anything so
>>> please queue them along with other clean-up:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Or alternatively let me know if you want me to apply them.
>>
>> Yes, please go ahead and apply them.
> 
> If you intend people other than me to apply patches, then please do not
> copy the patches to the patch system. I now have to go through all 16
> patches and search the mailing list to find out what happened... and so
> far for the few I've checked, other people have applied them. So I'm
> coming to the conclusion I should just discard the entire lot.
> 

Got it. and sorry about that.  :(


-- 
#Randy

