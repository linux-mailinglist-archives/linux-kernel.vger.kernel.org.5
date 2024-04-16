Return-Path: <linux-kernel+bounces-147499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A98A7555
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB63AB215B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E43139D0C;
	Tue, 16 Apr 2024 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cgIVDJqD"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74733139CF6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298458; cv=none; b=tp9ZAfzuqXwP6yTyDYpbyMip4ZPV8l0srw0cqFPwWBlAdRK1QG3bQTJlNBLN0C00gg7pV0wni2GlOnBdr7j2RNE7xtpxbiUVTzL+/lideRCyaTr9OMtkZcUwG/xXsZLwFRgrbaN7XRyAvVyoZHnPEcz04INFjvqV1D79iKfsCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298458; c=relaxed/simple;
	bh=wyfPN0Q4kVOjc0eOT6c2jdoyUDUNEVQHYUAxM9t/7x0=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=MGYRRoXo1grf01/mUMjFj16jSaUs+wBPkEKTrEqk65dMyvakfjb0U8bOti7f7X0AyPs2nxHuWpMu/u8Cph29lZVukKMRzg7uuvbU/rOKtCzMz8zC9tqCallOebWx7q+X1tSL6Y6cj0J9OyvqAP93xexEKK7In/kWkiqasKYIfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cgIVDJqD; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 22B52240027
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1713298453; bh=wyfPN0Q4kVOjc0eOT6c2jdoyUDUNEVQHYUAxM9t/7x0=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=cgIVDJqDAu8CVzN/qx4sdjxXpjAfpy85fNnWSklrojd9T4b73czIwU3ZJbJQBqPAE
	 kUrGpk6H1VvnDgvsHZd7hFooMvq7C1gpzot+AZtEDh+sN7adzAoATqNlH3VtmSrpIN
	 l+ZsRblycxYbSa5EkdvfKjDs4WXnJ1RObjnrdZEsKDCMqMUwG+vmRLfMqr9kdOJ5+D
	 iTnluHJjuG0naYLXEnnFOqQ2sdD9m/BqsYQ+T6WTp3fW2iKlO6pOC8oKtEgtyCf5o2
	 dEsmnEapDPZ0lktg5VGJD0WopB3zWo8nmqkHvYmPawY90YjFFS1sY4h7u2mlEG6nD4
	 mabMzu5CQWOAA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4VJwH81htBz9rxD;
	Tue, 16 Apr 2024 22:14:12 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Apr 2024 20:14:12 +0000
From: a-development@posteo.de
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 David.Kaplan@amd.com, Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
In-Reply-To: <20240416084544.GAZh46uKW6ijAfftmI@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
 <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
 <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>
 <20240326222134.GNZgNKbgdBUsAU98RV@fat_crate.local>
 <d0dfa77ba8231652554c4e6088f985d1@posteo.net>
 <20240416084544.GAZh46uKW6ijAfftmI@fat_crate.local>
Message-ID: <a49e7560f982f00ef1c5452483459b26@posteo.net>

Now that it is deactivated, the machine no longer suspends!

https://up.tail.ws/txt/non-working-suspend.txt

> Then, the other thing you could try is whether suspend works without
> that proprietary crap.

I refuse. I can explain. I tried lots of capture cards that stated they 
support uvcvideo and linux.
This problem existed prior and I need it for work on this machine.
But none of them worked reliably or would straight up glitch out.
Thats because they do not implement it properly.

It had to be a product from Magewell, who manage an array of bash 
scripts and the AUR maintainer gets updates if something breaks, too. 
Why do I use a PCIe HDMI Capture Card?
I need to use Cameras and Displays.

As for USB Cameras, unless its a product from e.g Logitech, they kept 
giving me similar headaches.
And that included an older setup that ran a Intel i7 8700K as well.

Thx.



On 16.04.2024 10:45, Borislav Petkov wrote:
> On Tue, Apr 16, 2024 at 06:48:54AM +0000, a-development@posteo.de 
> wrote:
>> It worked, it worked!
>> 
>> https://up.tail.ws/txt/working-suspend.txt
>> 
>> I've tested it now quite some time.
>> But, I also had to start using 6.6.26-1-lts because my magewell 
>> capture card
>> wouldn't without.
> 
> Right, that thing I guess:
> 
> [Mon Apr 15 18:37:58 2024] ProCapture: loading out-of-tree module 
> taints kernel.
> [Mon Apr 15 18:37:58 2024] ProCapture: module verification failed:
> signature and/or required key missing - tainting kernel
> 
> So, machines do suspend even with SRSO enabled and since your machine 
> is
> affected, you probably should try without spec_rstack_overflow=off to
> see if it works with the new kernel.
> 
> Then, the other thing you could try is whether suspend works without
> that proprietary crap.
> 
> And then we can see.
> 
> Thx.

