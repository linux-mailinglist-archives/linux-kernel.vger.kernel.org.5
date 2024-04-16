Return-Path: <linux-kernel+bounces-146374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEEA8A646E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2022B22FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B8873199;
	Tue, 16 Apr 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cym5sjuC"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992471B50
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250738; cv=none; b=omTXCX2GZ/hJRKze9yvYZYlEA98gHxcb+6wkoycwRCSsi/3Q8ND9vmPsm0jNaOv8mRNubaTFx5mwxYs2crkatqOmD1NtPEb0m6p0mLK1PETbveVMNseZJbNB+83NztPVJNW6HA/mGzSrCwrlaTwauw30RuUujbOCCHlps7BGUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250738; c=relaxed/simple;
	bh=IM4cvG1Sv8fc7SXkqgdkN2hfaA94WQ3Inko2NHNFPSc=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=P8BbXvSsExx30kKopetOnqUrTaxUIkQbWXFabQ9aKs/njgjGF4kpijVdney2b5HWbujmkWN5MfspRn6AIEpOZd+w5zrRsXvesUTJTnedLUtyUTU2MG6PP7DXyxVqBXyceeOUeQvXAKRNPZtqsNSCcbLuIsdhu226AsrCxy9Oyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cym5sjuC; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9C80B240027
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1713250136; bh=IM4cvG1Sv8fc7SXkqgdkN2hfaA94WQ3Inko2NHNFPSc=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=cym5sjuCraJxg5tWJI/Lw1M3tGm0PM+7sV9wMmhzTXu/3/cq/7vmUwLFuEYH6ZY3J
	 sD8QNc33bS07LV2DIRXZAhKNeW1Hk5aLZEkmZw0kmCRXy/aN6gy8QzGdjvWFWEa4En
	 rtMGWeymVx39GPNZnO5gO0cSxc5gfXcTX4ALq7W2DSlEH0uu9bfMXGqxkuT4ulqYFr
	 TrnfNog+HkJIShrfn4apV1ZsPSGgXf3EFlwAx/AG7eqIru9UFu06F7MFSBg1MARGfY
	 eJXyeLITzSNk5ZMjC7a4Jc0lv73hAokLuBX0YqdddsCbkNBslUin8H2OPYm5QweKQS
	 s10ZwmHoJlkdA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4VJZPz0lz5z6tm4;
	Tue, 16 Apr 2024 08:48:55 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Apr 2024 06:48:54 +0000
From: a-development@posteo.de
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 David.Kaplan@amd.com, Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
In-Reply-To: <20240326222134.GNZgNKbgdBUsAU98RV@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
 <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
 <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>
 <20240326222134.GNZgNKbgdBUsAU98RV@fat_crate.local>
Message-ID: <d0dfa77ba8231652554c4e6088f985d1@posteo.net>

It worked, it worked!

https://up.tail.ws/txt/working-suspend.txt

I've tested it now quite some time.
But, I also had to start using 6.6.26-1-lts because my magewell capture 
card wouldn't without.

Thanks again!

On 26.03.2024 23:21, Borislav Petkov wrote:
> Whoops,
> 
> this fell through the cracks. Sorry about that.
> 
> On Mon, Jan 29, 2024 at 06:18:00PM +0000, a-development@posteo.de 
> wrote:
>> I have the feeling that something else is amiss.
>> Currently under 6.7.2-2-cachyos with srso=off.
>> https://0x0.st/HDqP.txt
> 
> Yah, your tasks refuse to freeze on suspend and they have this fuse
> stuff in the stacktrace:
> 
> [ 6346.492593] task:btop            state:D stack:0     pid:279617
> tgid:1548  ppid:1531   flags:0x00004006
> [ 6346.492600] Call Trace:
> [ 6346.492602]  <TASK>
> [ 6346.492607]  __schedule+0xd44/0x1af0
> [ 6346.492614]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 6346.492617]  ? __wake_up+0x9d/0xc0
> [ 6346.492622]  schedule+0x32/0xd0
> [ 6346.492627]  request_wait_answer+0xd0/0x2a0 [fuse
> db37c699d94393e946cf93306449ea0f307959a1]
> [ 6346.492638]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 6346.492643]  fuse_simple_request+0x21c/0x390 [fuse
> db37c699d94393e946cf93306449ea0f307959a1]
> [ 6346.492653]  fuse_statfs+0xf2/0x160 [fuse
> db37c699d94393e946cf93306449ea0f307959a1]
> [ 6346.492667]  statfs_by_dentry+0x67/0x90
> 
>> 
>> Now I feel, further communication is rather selfish, as a clean 
>> environment
>> is hard to provide.
>> In any case, my FUSE arguments are sshfs -o kernel_cache -o auto_cache 
>> -o
>> reconnect \
>>                -o compression=yes -o cache_timeout=600 -o
>> ServerAliveInterval=30 \
>>                "$source" "$target" -o idmap=user
>> 
>> With this line, I somehow managed to have the FUSE mount infinitely 
>> mounted,
>> even if the device was offline for couple of days.
>> A followed suspend would fail to freeze.
>> srso=off would reproducibly work.
> 
> Not in your example above. It would fail after a couple of suspend
> cycles.
> 
> And looking at your splats
> 
> [ 6366.524953]  ? switch_fpu_return+0x50/0xe0
> [ 6366.524956]  ? srso_alias_return_thunk+0x5/0xfbef5
> 		  ^^^^^^^^^^^^^^^^^^^^^^^^
> [ 6366.524958]  ? exit_to_user_mode_prepare+0x132/0x1f
> 
> the right cmdline option to disable it is:
> 
> spec_rstack_overflow=off
> 
> not
> 
> srso=off
> 
> :-)
> 
>> Please provide me a specific version of a kernel I should try in my
>> configuration to try and reproduce.
>> I'd prefer a pre-compiled one; if not tell me...
>> I use archlinux.
> 
> Just build the latest released kernel, which is 6.8 now. Take your
> .config and use it to build it. The net is full of tutorials how to do
> so.
> 
> And then try with spec_rstack_overflow=off and let's see what that 
> does.
> 
>> Please give me a reason to not feel bad about myself.
> 
> Don't worry - it's just a machine. :)

