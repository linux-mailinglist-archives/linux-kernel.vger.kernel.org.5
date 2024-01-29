Return-Path: <linux-kernel+bounces-43305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883108411F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5211F24764
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FA46F073;
	Mon, 29 Jan 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Z2APSTt4"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96A3F9FE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552294; cv=none; b=gYpxZLRgv3eIU3ZCuZW/MnkDiQqLnWfI/gfzOg9nSarrC+1YBrpMc2AwNwnOCR0DlGPpQ9VwS+08KKe9MDyNbkDnIkp6lCgz1wnlNjGVQABXfW6BxPLUWBMHH0CgpWPrHBTOCFtiNoJOlOdfW48YcKTQdJS+lnYNBSo02qvzoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552294; c=relaxed/simple;
	bh=JgNwxAWin/PaXteMqz8nxKCsI9BFerVaW/ZZz669AKg=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=SGb0hnZUvRjgyndvj4Mo9/qQuEYKWhAV2sE/0IGK2iaDSz6f4vnSBAcSzuihQaWyMwTXzozAzdkmulgljDqWEX84WpB96yYHf4PBB2yW7+fs8xz+lb0EeyYVQuaySxGB/AgnVHtwL0jh1j53ld4XsVZr8L5a0ccHlOmL6sL8jtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Z2APSTt4; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C784324002B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1706552282; bh=JgNwxAWin/PaXteMqz8nxKCsI9BFerVaW/ZZz669AKg=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=Z2APSTt4bu+lQ7H1f1uI/ujd6FyATbgdlJPGPyJ5veh9rrdMF9P6g+s0m0EaX1zFw
	 0VdyarCKYCtvY4TrMSy1wEHjQTwj4cmUYYt0dYfDakOYd7Yr0N+Ilz8Jn4/7O1jY9x
	 3A572JjtAj6oT23BiZnXnc1VGf25JTwG7s3d81wojlcCEYhSbkiEImsDOLwLZwOvnD
	 g991UeSwQRynA8khpjCNuEGqEvidIam2YTIqOSsaClQ/9bc3G4RBAKUbZORakPXMtj
	 2w6UGB8m463cWo5yHeemvrvSCT1Yj5G0TvAJyrNKYV5z2XaVpLlzcE1cmG/dsJEBu7
	 Mb6GzqBnW+MSw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TNxP46Npmz9rxG;
	Mon, 29 Jan 2024 19:18:00 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Jan 2024 18:18:00 +0000
From: a-development@posteo.de
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 David.Kaplan@amd.com, Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
In-Reply-To: <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
 <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
Message-ID: <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>

Hello.

I have the feeling that something else is amiss.
Currently under 6.7.2-2-cachyos with srso=off.
https://0x0.st/HDqP.txt

Now I feel, further communication is rather selfish, as a clean 
environment is hard to provide.
In any case, my FUSE arguments are sshfs -o kernel_cache -o auto_cache 
-o reconnect \
                -o compression=yes -o cache_timeout=600 -o 
ServerAliveInterval=30 \
                "$source" "$target" -o idmap=user

With this line, I somehow managed to have the FUSE mount infinitely 
mounted, even if the device was offline for couple of days.
A followed suspend would fail to freeze.
srso=off would reproducibly work.

Please provide me a specific version of a kernel I should try in my 
configuration to try and reproduce.
I'd prefer a pre-compiled one; if not tell me...
I use archlinux.

Please give me a reason to not feel bad about myself.

All the best







On 27.01.2024 20:41, Borislav Petkov wrote:
> On Sat, Jan 27, 2024 at 07:27:45PM +0000, a-development@posteo.de 
> wrote:
>> I can umount the FUSE mounts and it will work fine.
> 
> Aha, so it is FUSE-related.
> 
> How do I trigger it here? What are the steps to reproduce? Suspend 
> while
> I have a FUSE mount? How do I set it up so that it is as close to yours
> as possible?
> 
>> Previously I didn't even suspend.  Also, in the log I had provided,
>> I was on a cachyos kernel, but it didn't matter, even the most recent
>> arch kernel had the same issues.
> 
> You should try an upstream kernel to confirm it reproduces there - no
> distro kernels.
> 
>> full dmesg is no problem - I can do that the next day, when I startup
>> the server again full ~/.config folder I don't want to share
> 
> Not the full .config folder - just the kernel .config of the kernel
> you're triggering this with so that I can try to do it here too.
> 
>> here is /proc/cpuinfo https://paste.cachyos.org/p/158b767
> 
> Thx.

