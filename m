Return-Path: <linux-kernel+bounces-101167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F24A87A355
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B6D1C213CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC5F168CD;
	Wed, 13 Mar 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSv52H4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EFB15AD9;
	Wed, 13 Mar 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314237; cv=none; b=pwgCkYmtUTac/+wJ1UxdYivBtbr+D8II7A5qTnSVLQLEJzGiUli/XSkKyQJ5TLut5XkkdDrSO7Re495L6ie1dFNZ2vy0NbY+3RF5iyJziJ8dJk3AGqxum46BdDzk/ES248XwWbpYkuUobWlmhe7W1lCjtoegQfGdMEb3qeL/Uzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314237; c=relaxed/simple;
	bh=WR/CQmYn4DztICQp/hNE91OpnL/Dz/YARF2+odO59hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBnVu01RfOPZW7pTqD6qyTTHd0IZeFVnGW6IwCC0uC/M0JzojgKRV6r1Q2cC8JjztS6kgErLcmfIAmx5rjcqd9Z8818DOAXALu4VmURC1qvQ8aSNNwN6HoWn4p86mcr69eeLjPpV77gyKvjEevGxub1o5RQrPf/PRb7SRAYLP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSv52H4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AABC43390;
	Wed, 13 Mar 2024 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710314237;
	bh=WR/CQmYn4DztICQp/hNE91OpnL/Dz/YARF2+odO59hk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XSv52H4/Va0qCfjK9QjaS1PlPMvkgveb5vM3S1DAoBDHAc2zAYLKJ2P4prqv8m+Qt
	 BNckNsevaEYpGV3wpFlzE+2dGMKGbMPzlJXccEZBsLP7J3Y4PzlMWXtR6ss+tLk54k
	 fpQlKk4p5HsTBNWB10XZgME9hZ18GFg4BsjOTQ6UysM5e1H0cMBJFgX6dy9nqhQ8Ps
	 WSYxxHOFD9X78iu+CYTWO+sZ8STgeGljI/rhxoDfLl4mHiVy9yEGZ0gSqsKiMOfCUj
	 QE8s5eyIYMSTa9pG7orCAJORGsUel7wHqsU2jIOko1FRyx8UFi/otPdCisIHKNxA4/
	 GzCELGZpu1zSA==
Message-ID: <72352c6c-fb49-4542-b41e-232919e2a7d7@kernel.org>
Date: Wed, 13 Mar 2024 16:17:14 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Bug 218538 - 3cc2ffe5c16d from 6.6 breaks S3 resume
 on SATA SSD OPAL
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Niklas Cassel <cassel@kernel.org>
References: <1b6130bc-69c5-4683-86d1-5ff631da3f80@leemhuis.info>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1b6130bc-69c5-4683-86d1-5ff631da3f80@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 22:25, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> Danien, I noticed a regression report in bugzilla.kernel.org that seems
> to be caused by a commit of yours. As many (most?) kernel developers
> don't keep an eye on it, I decided to forward it by mail.
> 
> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CCed them in mails like this.
> 
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218538 :
> 
>> Problem: since linux kernel 6.1.64 (which correspond to Debian
>> linux-image-6.1.0-14-amd64 through 15, 16, 17 and 18) the system is
>> unable to fully wake up from suspend. Most of the time it wakes up to a
>> black screen and CAPS LOCK led doesn't change when pressing the CAPS
>> LOCK button. Sometimes the monitor turns on and I can login in a tty but
>> no command ever works. Not even `reboot` `shutdown` etc. Regardless if
>> the monitor turns on, I can shutdown with Alt + SysRq + B.
> The user later confirmed the problem still occurs with a recent mainline
> and bisected it to 3cc2ffe5c16dc6 ("scsi: sd: Differentiate system and
> runtime start/stop management") [v6.6-rc4].

+ linux-scsi and Martin

Thorsten,

Thank you for bringing this to my attention. Checking the code, I think I
understand what is going on here: commit
3cc2ffe5c16dc65dfac354bc5b5bc98d3b397567 changed sd_resume() to do nothing and
delegate the disk resume to libata, as it should, because we cannot issue any
command, even START STOP UNIT, unless the ata port and device is first fully
resumed. However, the change also causes
opal_unlock_from_suspend(sdkp->opal_dev) to *NOT* be called, thus leaving the
drive locked after resume, so unusable.

Fixing this is not trivial because as mentioned above, we must first wait for
the ata port and device to be resumed before attempting to access the drive. So
I will need some brainstorming to come up with a fix. Give me a couple of days
please (I do have SED OPAL drive so I should be able to reproduce this issue).

-- 
Damien Le Moal
Western Digital Research


