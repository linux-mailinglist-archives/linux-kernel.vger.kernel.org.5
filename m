Return-Path: <linux-kernel+bounces-41368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9D83EFBA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4813B2261C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511412E41F;
	Sat, 27 Jan 2024 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="N+uwzBNB"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065BA20
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383677; cv=none; b=acCSCGMbP1sVvMtsWOpWK+OUm0J7O03gxR02ettniIJ5oYARvtZX/xE82MQLB/1zu3G1vTXUTpec/inmTstawHdHje1b2TIOE5hvA7o5l46xeFAjD+UCVyoJ+CeYbFhAdNO+DvGYhsbYNjJJrRaAUbYoAqNScg+skB+GeKQDgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383677; c=relaxed/simple;
	bh=eF/NBJ90ASq64ve90nmm0ieUNR2UqRKKZT3CA/UiAu4=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=LsR8Lb9JJkxepod5J5Z3g0qRlrNAzYTPiK0DaDjlZrt+KtgKQE6iMH0PfEw4OLvi+PQu9YWx7EtwnxX4ZVX+6TON9NYqwq/McTqc6plp1CAsJF3WSFdzVzJ+GLNE9FDUriuBU1ROXCwrJUJqwYfxINoV3jtZG8rXXjCU/8UsceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=N+uwzBNB; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 753B6240029
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:27:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1706383666; bh=eF/NBJ90ASq64ve90nmm0ieUNR2UqRKKZT3CA/UiAu4=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=N+uwzBNBJvjxCNYJ2hAkSGk/N1CwAaW/Ar1xjWTktuDyqDsgJN44CBjVkYNfq5AAn
	 YHc9nxp7wo6ZexKvv8w5QVDrU6ISCJbKZlBM9b3pDKqcbKabCdMHBEwqKao65FxIoC
	 GuyskvWsU/VZaBG+t2WiHpK20IjBb4ffg95skRj0a7Ok67Uz+r7e75/VNCefTQNOjT
	 f7EAi3etJoR68mGtrYt/5EMxZr+6fIrGVhuvpMN0ShS/+6rJGj+n83yBjxX0uVEGf0
	 jRku56m3Umq47T73NaLaQ6TfjrUj0xiU15fuMM23/umkAscsoAbSn+Mz9nzGPOcGN3
	 zi/k5emmbvo4Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TMl2T4Strz9rxD;
	Sat, 27 Jan 2024 20:27:45 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 27 Jan 2024 19:27:45 +0000
From: a-development@posteo.de
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 David.Kaplan@amd.com, Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
In-Reply-To: <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
Message-ID: <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>

Oh that was quick :)

I can umount the FUSE mounts and it will work fine.
Previously I didn't even suspend.
Also, in the log I had provided, I was on a cachyos kernel, but it 
didn't matter, even the most recent arch kernel had the same issues.

full dmesg is no problem - I can do that the next day, when I startup 
the server again
full ~/.config folder I don't want to share
here is /proc/cpuinfo https://paste.cachyos.org/p/158b767

Thanks

On 27.01.2024 20:19, Borislav Petkov wrote:
> On Sat, Jan 27, 2024 at 06:58:37PM +0000, a-development@posteo.de 
> wrote:
>> putting srso=off in the cmdline fixed up my FUSE related issues.
>> Basically, I could not suspend anymore.
>> kernel 6.7.1.
>> 
>> This is the behavior with srso enabled...
>> https://paste.cachyos.org/p/bae7257
> 
> Can you disable, if possible, whatever's doing FUSE and try suspending
> then?
> 
> Also, can you share full dmesg, .config and /proc/cpuinfo from the
> machine?
> 
> Thx.

