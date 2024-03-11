Return-Path: <linux-kernel+bounces-98877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40A87808F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B51C2048A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629813D978;
	Mon, 11 Mar 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="POIRogeK"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253A3D3B8;
	Mon, 11 Mar 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163530; cv=none; b=Ygw8npD5+vFj3iSVBAa1d6QnmJby2iNo9U3yeDwWyJ5orXJAM0YHJJljeXIRcjUQFaqv2aywFd7qWx7MohdB7i0sunKR6tCkE8XMgwsiMRsvTMdRZUBA5FPraRFjzH6skFeGEgHy2Knh59+Gt8+JDrnJrnMcFSRXG8eluJrCbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163530; c=relaxed/simple;
	bh=UUAqMi7Co+l4NOvT5ZZYkyg1zIseIM6SCpMddQezQIE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=aAkJKKol41iE95fC9jgHVzrsQPSm0fBAWGKtgF36ljsnTRvx2qmu2wd/M/1u1b3RIl573udsMBcCkzQJIe1tB21rHA6udX7axBhFMn/xoC+9EAKWpXaWOARD3KxTKKidXFG7Vj6R7DtXte27j6dKAfSsxfqgESwN9zElR+vdSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=POIRogeK; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UUAqMi7Co+l4NOvT5ZZYkyg1zIseIM6SCpMddQezQIE=; t=1710163528; x=1710595528;
	 b=POIRogeK9tjJGvsXUXwTA00e6r4ostS7Ci7hLifWpbYlMGJf+dQkT24BekNc+94naI9c5zPDDS
	n/yTZk3+HjXJQGuMEZpJv0srnJoj+KawZiwCqdXJNoJGEkOByfYPV3g1diQpqUexupfCR+3ecJR1a
	NS5ZSrQs6whixJmzfdLoh64jvzQt27FmBjdWIHLl8NpvulbXHMU9bwu0RX54xvXeXVVdefxVs18Sr
	b8rGPFPfu9aUoBL66FgWnWgMKXvUN7iuZ330YIZnPRws/YwW/xZtVbbe17TDUZnhrHeUC07coBSTE
	YUd8l9W0HF41WyA8A6vqzceNojeHIP+oHA8lw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rjfeg-0003xn-JK; Mon, 11 Mar 2024 14:25:26 +0100
Message-ID: <1b6130bc-69c5-4683-86d1-5ff631da3f80@leemhuis.info>
Date: Mon, 11 Mar 2024 14:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [REGRESSION] Bug 218538 - 3cc2ffe5c16d from 6.6 breaks S3 resume on
 SATA SSD OPAL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710163528;1a717e69;
X-HE-SMSGID: 1rjfeg-0003xn-JK

Hi, Thorsten here, the Linux kernel's regression tracker.

Danien, I noticed a regression report in bugzilla.kernel.org that seems
to be caused by a commit of yours. As many (most?) kernel developers
don't keep an eye on it, I decided to forward it by mail.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them in mails like this.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218538 :

> Problem: since linux kernel 6.1.64 (which correspond to Debian
> linux-image-6.1.0-14-amd64 through 15, 16, 17 and 18) the system is
> unable to fully wake up from suspend. Most of the time it wakes up to a
> black screen and CAPS LOCK led doesn't change when pressing the CAPS
> LOCK button. Sometimes the monitor turns on and I can login in a tty but
> no command ever works. Not even `reboot` `shutdown` etc. Regardless if
> the monitor turns on, I can shutdown with Alt + SysRq + B.
The user later confirmed the problem still occurs with a recent mainline
and bisected it to 3cc2ffe5c16dc6 ("scsi: sd: Differentiate system and
runtime start/stop management") [v6.6-rc4].

See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 3cc2ffe5c16dc6
#regzbot title: scsi: sd: S3 resume on SATA SSD OPAL broke
#regzbot from: desgua
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218538
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

