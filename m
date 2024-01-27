Return-Path: <linux-kernel+bounces-41370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3CE83EFBC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 566B8B225DC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FC2E626;
	Sat, 27 Jan 2024 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="TtE4uMBY"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E02D60C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383734; cv=none; b=pfCKnh7ZYUhgM+Pa5wS8fLclpnvl59AtEupZRrIsT5sHz3S+uzpSRcPT4oEyy21CSIYmssdSHtjkkLUopgUO2DlatMccV83jzwUzPc8JulR0Y4Wu+wmRTyRpww7a58NEWh8OvBJ5zJUijKWjU7JrZwn4XsA7MNfHUXPtXSK4z3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383734; c=relaxed/simple;
	bh=eF/NBJ90ASq64ve90nmm0ieUNR2UqRKKZT3CA/UiAu4=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=SCStVIOHHt52n9eDyttmfHgYiIM/qrO5SgkbSZIKLOGx8TQdrTvu1amSQ7pXXgmGg5+bRJNJzDk9sLsH8o1AxnaAvS2v7tRo4KxjfaLFVi2uVxDyM7XHKUSYGZ4yYfqzUHsZWTnbamShQt4y06I4JPx5Yf6DVlQOoVxsCPaiwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=TtE4uMBY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BDF79240107
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1706383730; bh=eF/NBJ90ASq64ve90nmm0ieUNR2UqRKKZT3CA/UiAu4=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=TtE4uMBY2WmwVFzntF3x88JJzuYo9GUzbP95CBoC+hbtpEDC9ERCtyNTNIQ+bCtuE
	 2z5bc9hQCQ0KSkeQALf30avF3s5gyHGHIYew1Ao+8l1WLO649jMTd/BpHC6X3Za69H
	 NujYfZM9M1DVPla9F0vrkGBR34Rlz9lTrTArJDuEmk+zh7+vKgGEyLXKgDgHFx8GkI
	 7FtDUiVnu8IkL9R7Rslg5M/Xu2w4VeqrVeG72B9StEhZUbKccr/r+tIrRChHOAgbIn
	 X3XZ1AVBE+D6jkOrMA73ue4P/3nozpRC9Ue84DR03eB556oslKQk0CNI5rL7yA2H4b
	 CGViDs3JRHJhA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TMl3k1M3Xz9rxG;
	Sat, 27 Jan 2024 20:28:50 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 27 Jan 2024 19:28:50 +0000
From: a-development@posteo.de
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 David.Kaplan@amd.com, Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
In-Reply-To: <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
Message-ID: <39be861924b05a5f3301f7fa189b20df@posteo.net>

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

