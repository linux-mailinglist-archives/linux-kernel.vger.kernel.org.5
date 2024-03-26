Return-Path: <linux-kernel+bounces-119050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8988C33B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B02E3330
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EED7441F;
	Tue, 26 Mar 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="YBYljSo1"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C867A00;
	Tue, 26 Mar 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459121; cv=none; b=hAK8kJQrspuI6S9WP1kSoO5H4XyrrN3zxYqhzeFdntXvJ4SF4189+pjIQleGFv74TBF66oqpxp/gXXg8UV81mltUXOlFe0zls6k0UEo9aCvqa/aHibnwQXFzRiC4wyCM4MSC7MtxseZGKHuf+QsmxEXoYg/EjuWLcZWBvdM4VE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459121; c=relaxed/simple;
	bh=kwbtxjvyoboouuP30XD7UmJ9Tak2JX2+1XT+llOTBfU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=QVmHGcJ/2CLE/0jFhB4SMli7S8cgy2C8vv7nReIO1sArDXPGnx0E4HW3CVWRP8X2vtA5GZZgH3x7m2bVxzPc33DGomuri3dw+9rUezHKC13E8Awf6nms3BNQKc9KoTOD0Pm469mBjlvVGFStB3YK05nk8mfQlSGDTqs4gdHVBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=YBYljSo1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=lKr8vjI/MKPiGxt3h9ZRIfJRuD3apPKLQIAIGxuGMwY=; t=1711459119;
	x=1711891119; b=YBYljSo1n6H8XdcfSJPHGDeh0/bBwb7Cwdtg4HST5YWsGyxgXgNz5Omgyz5IX
	X8E/OQ6VqUggXEbl0UMTb0hAr2IZHe1mY8e9X2PlpHFws7PVaZ5Qss8/c19Vl2tSc+5/flRms7UHP
	3Uwv4Cp4XPPyxb/1qOkr/HrI6IX/VeiIj25+exwzcoyCAZzM1SSmfxTE1dULHG3g5AeZt/9i53Eku
	XhqZxQdn8MOlpWSuQRQRLAqbx/nZq8Kr0APR6UEqPQeetQD9DAuZMzS6ZIp4Wlbz9Pgcp6A7cM5U1
	edLgOX6nTIPuXvmEqEDtI7tXaNyxYQfctzBQk74voWToGZcz4A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rp6hI-0005Mm-No; Tue, 26 Mar 2024 14:18:36 +0100
Message-ID: <5b778e74-1278-42b1-84e1-a2c04a8211f0@leemhuis.info>
Date: Tue, 26 Mar 2024 14:18:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [regression] Bug 218641 - Framework Laptop 13 AMD suspend/wakeup
 regression with 6.9rc1
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711459119;1ec67ad1;
X-HE-SMSGID: 1rp6hI-0005Mm-No

Hi, Thorsten here, the Linux kernel's regression tracker.

Anna-Maria, I noticed a regression report in bugzilla.kernel.org that
apparently is caused by a change of yours. As many (most?) kernel
developers don't keep an eye on it, I decided to forward it by mail.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CC them in mails like this.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218641 :

>  David Markey 2024-03-25 22:08:29 UTC
> 
> Was trying out 6.9rc1 to give prefcore a whirl but I've noticed that
> when I go to s2idle I cannot wake up, the power button does not wake
> the laptop up again and stays flashing and requires a full reboot to
> become responsive again.
Later:

>  Mario Limonciello (AMD) 2024-03-26 02:38:06 UTC
> 
> I finished up bisecting and it comes down to this commit:
> 
> ```
> commit 7ee988770326fca440472200c3eb58935fe712f6
> Author: Anna-Maria Behnsen <anna-maria@linutronix.de>                          
> Date:   Thu Feb 22 11:37:10 2024 +0100                                                   
>                                                                                          
>     timers: Implement the hierarchical pull model
> ```
See the ticket for more details and additional comments.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 7ee988770326fca440472200c3eb58935fe712f6
#regzbot title: timers: suspend/wakeup problems on Framework Laptop 13 AMD
#regzbot from: David Markey
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218641
#regzbot ignore-activity

