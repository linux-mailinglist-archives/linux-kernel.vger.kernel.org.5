Return-Path: <linux-kernel+bounces-148104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55868A7DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A611F24BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8377CF39;
	Wed, 17 Apr 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="FM9WsaZA"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8F184D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341345; cv=none; b=aotAZOtWTOjY6NRpomjeh/0SX0Sgnzy+sSFfqzMt15qZCVHvM39ltwAC29tdCPGNdy2SxLY0pYSXTDT9kB1oyK+3+Pi04wSnqgn8LWs71JnSruYrxANEXBMrhhgeHog3r+xTL9KHV8RK6I22CprHUJJMkNh1lf18og9uIQ/hhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341345; c=relaxed/simple;
	bh=/LEKZRORROoTQRP7TKB8vIKR9n/GfPO8OkDwKQz4NS8=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=qQH7Kz+PbvxprOqenNqv8dvcWUxp8Fdk/h1+M4AvtvZHDn68+Hfbjglyscjp7m2AuwADed9Ms7LP2ixfHYPB99bp8B7lj2vPbM2wzIuCycbmhKH0QIgnbNGTntoRVU0HnxpMqxpcjtnXFxLH/k920LZ1KyV73ZHWpHyXzXgmLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=FM9WsaZA; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8871A24002A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1713341334; bh=/LEKZRORROoTQRP7TKB8vIKR9n/GfPO8OkDwKQz4NS8=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=FM9WsaZA5wBLIVmFymasDFBHOY4ESIJLPJggeIUB2DWAKke4uK+/ANq12zXmmND9l
	 hA8ai8b6F/B0baoj4iDFCkI6ZbHyST/WbNftT8VZtSJd+JL/EaSxhpkiLSkhv6Jy3h
	 M6Ddj/DN/z24Ppc0GjqQmXbscXBKBWtyifjBNZTO+OSkxq9SRQXVSkGafb0otzf1id
	 QRlBjsY4juqy1Cv7xAC0k/QhKu6BYssGi/ZtnM9qMCsSi0sYqqI76lp38zDRU9/tIp
	 hAlWiZr7kmu0vPFHhjCKFViltr8vC5ndu1Nl1m7QI1jCmgLJ36mdkY3zlK3J1HwhQR
	 T2lDVyelXGMQA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4VKD7n5lg3z6tyK;
	Wed, 17 Apr 2024 10:08:53 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Apr 2024 08:08:53 +0000
From: a-development@posteo.de
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 David.Kaplan@amd.com, Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
In-Reply-To: <a49e7560f982f00ef1c5452483459b26@posteo.net>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
 <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
 <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>
 <20240326222134.GNZgNKbgdBUsAU98RV@fat_crate.local>
 <d0dfa77ba8231652554c4e6088f985d1@posteo.net>
 <20240416084544.GAZh46uKW6ijAfftmI@fat_crate.local>
 <a49e7560f982f00ef1c5452483459b26@posteo.net>
Message-ID: <0065fda592b2652d1a2730ddbc81cea6@posteo.net>

Today I failed to suspend, and the spec_rstack thing was off.

https://up.tail.ws/txt/non-working-suspend-2.txt




On 16.04.2024 22:14, a-development@posteo.de wrote:
> Now that it is deactivated, the machine no longer suspends!
> 
> https://up.tail.ws/txt/non-working-suspend.txt
> 
>> Then, the other thing you could try is whether suspend works without
>> that proprietary crap.
> 
> I refuse. I can explain. I tried lots of capture cards that stated
> they support uvcvideo and linux.
> This problem existed prior and I need it for work on this machine.
> But none of them worked reliably or would straight up glitch out.
> Thats because they do not implement it properly.
> 
> It had to be a product from Magewell, who manage an array of bash
> scripts and the AUR maintainer gets updates if something breaks, too.
> Why do I use a PCIe HDMI Capture Card?
> I need to use Cameras and Displays.
> 
> As for USB Cameras, unless its a product from e.g Logitech, they kept
> giving me similar headaches.
> And that included an older setup that ran a Intel i7 8700K as well.
> 
> Thx.
> 
> 
> 
> On 16.04.2024 10:45, Borislav Petkov wrote:
>> On Tue, Apr 16, 2024 at 06:48:54AM +0000, a-development@posteo.de 
>> wrote:
>>> It worked, it worked!
>>> 
>>> https://up.tail.ws/txt/working-suspend.txt
>>> 
>>> I've tested it now quite some time.
>>> But, I also had to start using 6.6.26-1-lts because my magewell 
>>> capture card
>>> wouldn't without.
>> 
>> Right, that thing I guess:
>> 
>> [Mon Apr 15 18:37:58 2024] ProCapture: loading out-of-tree module 
>> taints kernel.
>> [Mon Apr 15 18:37:58 2024] ProCapture: module verification failed:
>> signature and/or required key missing - tainting kernel
>> 
>> So, machines do suspend even with SRSO enabled and since your machine 
>> is
>> affected, you probably should try without spec_rstack_overflow=off to
>> see if it works with the new kernel.
>> 
>> Then, the other thing you could try is whether suspend works without
>> that proprietary crap.
>> 
>> And then we can see.
>> 
>> Thx.

