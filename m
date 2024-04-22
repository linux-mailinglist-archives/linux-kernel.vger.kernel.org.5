Return-Path: <linux-kernel+bounces-152813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B28AC4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF05B2810FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3448787;
	Mon, 22 Apr 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="A6TNrzvi"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11568482ED
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769273; cv=none; b=geQkh8f83PcLDsI27JParjp2lTzrTHqHksmmoQvA7YV1dV7Mrx56oi9RGyCqaOal7vCTU7UaPSv1ndU5enuZTMbyqVEgJp57FHq0ZQHkrhxd0Dc++5OU1V026eZl1fWliIuEUukf8WxYtb1eDiUjaS5i0vMy9TxEINrq9N0BCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769273; c=relaxed/simple;
	bh=XNuK4qbKnADfMXviTzs6nnvQDFLAwer8iqIgdbyp8hU=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=fm24h0W1uQhT86qf12qHk/uW+a5ByacHPQxcDcf3tTfqyK8Lnh9eiyvdmMfpF8alSGICOlY9dV+2tC3HH8OREftJIeGjxJ6OfmYcJSQECSN3+DNSrWgNx3oAcy1pAeswk0fuoWBykrBScL7eQzgfuNAgmlBd32zKF40KHAGMvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=A6TNrzvi; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4E3E6240104
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1713769264; bh=XNuK4qbKnADfMXviTzs6nnvQDFLAwer8iqIgdbyp8hU=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=A6TNrzviFhHFrYszwgREJ5iTO94EMYzAXNLzJdxNHfYsP2tXLcSvIjYoBs2lFWMxP
	 /uROVMewqcHGK9ZMgZ2H+7qS0+K9LUpgMgI3267ZYFUfOQhcE6sApHpHajgkx5s5uA
	 MXNUZj2Iqg8l5DATZRVRlpHMZnaCrV+OTbqZ8tUXtDZNKtX/BGKnH/g1PXeUF9HvCy
	 +mB/3nBKzSH9S9OWXN4sDLZnd4ndMB+WN+GxbZjiOIOXwgWOOjNFC/r6oUf7Nni8k7
	 3uwNQRv7f3LJplC4qBbIA8qfbG8W5IcmK/UY/hqkxrEdtbNi4Lzcjzqcr2zdg/jACb
	 CUez8t9gnZNsg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4VNGPB6MLPz6tsf;
	Mon, 22 Apr 2024 09:01:02 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Apr 2024 07:01:02 +0000
From: a-development@posteo.de
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 David.Kaplan@amd.com, Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
In-Reply-To: <20240417091200.GAZh-SYOGABCnsqpKj@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
 <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
 <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>
 <20240326222134.GNZgNKbgdBUsAU98RV@fat_crate.local>
 <d0dfa77ba8231652554c4e6088f985d1@posteo.net>
 <20240416084544.GAZh46uKW6ijAfftmI@fat_crate.local>
 <a49e7560f982f00ef1c5452483459b26@posteo.net>
 <0065fda592b2652d1a2730ddbc81cea6@posteo.net>
 <20240417091200.GAZh-SYOGABCnsqpKj@fat_crate.local>
Message-ID: <98d6c53b244c579b7c7e28872d5cb665@posteo.net>

Hello. I have installed the kernel through 
https://aur.archlinux.org/packages/linux-mainline and noticed that SRSO 
is disabled. "Speculative Return Stack Overflow: IBPB-extending 
microcode not applied!"

cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
Vulnerable: Safe RET, no microcode

So far, I have been succesfully suspending the one night I used it.

Assuming this is per-default, I've installed the kernel module for my 
PCIe Capture card and testing it.

Any new instructions?

Thanks

On 17.04.2024 11:12, Borislav Petkov wrote:
> On Wed, Apr 17, 2024 at 08:08:53AM +0000, a-development@posteo.de 
> wrote:
>> Today I failed to suspend, and the spec_rstack thing was off.
>> 
>> https://up.tail.ws/txt/non-working-suspend-2.txt
> 
> Ok, but please do not top-post. Put your reply underneath the next
> you're replying to and remove the rest of the quoted text like I just
> did.
> 
> So this could be caused by the proprietary module or something else.
> 
> If you want this debugged, you'd have to try to reproduce it with the
> latest upstream kernel from here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> after having removed the propietary module.
> 
> HTH.

