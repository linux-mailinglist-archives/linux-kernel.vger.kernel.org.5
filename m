Return-Path: <linux-kernel+bounces-93398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56A872F37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327BF1F24080
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7A5BAF4;
	Wed,  6 Mar 2024 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="he3Jbpx+"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0364D9EA;
	Wed,  6 Mar 2024 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709708726; cv=none; b=ix5m/rZkzWYkOhnnaVrL3LRJha1O/PhKdDsegVQssn4gyawUzJ4lYGf0zeFvbmAFaDzzH6O5RI8IYfnMBbysh8pmSTPIQo/iXflf4I6QPdNcRITdQmKThMkMMNWjJK+2KYC/m2GTFUijrWOCK32TiYR+NtZM1yvBLYVss16R9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709708726; c=relaxed/simple;
	bh=KbXtUGZ2hn2LUkqEed4ZUhwJlB3wVrf04RrkSdDWbgc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=GGF0br/ZlKdzUmRzKFwxfoHGVky3HNBvRuwxUuUos0CwgL75bii4ty1miIInpBkDfub1Fwzi0rYrr6y1tvpSxTrdabXbdCCrXioNViho3ih2FAkv0ePQMCt0sqNcXHMQybOIe2OAlHZtBEZv1F9AsL/sfAQwrF5JmVWV+Fqdzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=he3Jbpx+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=vGsq1zXJ71Gl6mQIiuZUQjxDTEd6MzYK8gXMqH4pCLY=; t=1709708724;
	x=1710140724; b=he3Jbpx+EjDECq0FOrNOVN174pKwFAon+pByCvyvgrc/ONIzuDjGVog/LOnct
	pYtmhP3FEQyzGKSb9klYp+xhVlNhvcoYvB9KZKXDrOm3h3hefeGfR+5sKkdmYqOx4EQR12RnFewgG
	MuAEGpLcoGXW9vaO0U07sqglOBgbdzQLlGc87BUwlHcvUSLszBVPHfS8M6MAsd8B6L1Scuv/lozKL
	jveR8XoylWUr4zoCins17vkxiRq3u4HSOLMGaIz2yDjue1/DXySBryZuF3VtBP5BWSSR6E6thrgJ5
	H007kcGCxPwdBU22c3Xww2ipIvCF9kpCHWitBK+J42iwyMlo7A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rhlL1-0000pi-TV; Wed, 06 Mar 2024 08:05:15 +0100
Message-ID: <5da6cf8a-4250-42f6-8b39-13bff7fcdd9c@leemhuis.info>
Date: Wed, 6 Mar 2024 08:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [regression] stm32mp1xx based targets stopped entering suspend if
 pwm-leds exist
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709708724;51dcb357;
X-HE-SMSGID: 1rhlL1-0000pi-TV

Hi, Thorsten here, the Linux kernel's regression tracker.

Uwe, I noticed a report about a regression in bugzilla.kernel.org that
apparently is caused by a change of yours. As many (most?) kernel
developers don't keep an eye on it, I decided to forward it by mail.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them in mails like this.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218559 :

> Commit 76fe464c8e64e71b2e4af11edeef0e5d85eeb6aa ("leds: pwm: Don't
> disable the PWM when the LED should be off") prevents stm32mp1xx based
> targets from entering suspend if pwm-leds exist, as the stm32 PWM driver
> refuses to enter suspend if any PWM channels are still active ("PWM 0
> still in use by consumer" see stm32_pwm_suspend in drivers/pwm/stm32-pwm.c).
> 
> Reverting the mentioned commit fixes this behaviour but I'm not
> certain if this is a problem with stm32-pwm or pwm-leds (what is the
> usual behaviour for suspend with active PWM channels?).

See the ticket for more details.

[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 76fe464c8e64e71b
#regzbot duplicate https://bugzilla.kernel.org/show_bug.cgi?id=218559
#regzbot title: stm32mp1xx based targets stopped entering suspend if
pwm-leds exist
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

