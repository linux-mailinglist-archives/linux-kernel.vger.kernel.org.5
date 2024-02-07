Return-Path: <linux-kernel+bounces-56099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A884C5F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9503EB26298
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3389200BD;
	Wed,  7 Feb 2024 08:07:17 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D0200D1;
	Wed,  7 Feb 2024 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293237; cv=none; b=ewFP561VCtdUnAnl+SFBAg4hN/4EOE+ug/EQJuSEI2YXtvDqJzck2yTEJKxT6+e/iIMs74YbxX6SLj5fV48zr+XSIvemwrgjbgxNs/glVUROw95Q6CEOwZI1bZup6tzLysmVc2JqzXCf6QtgugRrVD9HKsytVdlTpupE051/v2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293237; c=relaxed/simple;
	bh=VSFXVUDt9KdC/Osnmmt5+KR0XBJec4bQdzZfkYDwffU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5juu1eYmMPcdwrufKCR4cA2+iFuRfSxo0zl1tfFhVQD+d/8PFS0gJ3QQjqCvFafobwtzsymNi8Vu/w43A1i20S7AtypcY3Jn/qY23V9wOaP10rO4xREaovrIH7wMPT/doQmZm3yUJkh5B8/uzwjdtM/DhpucDWsyZiJAu4K1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rXcxa-00022T-Dd; Wed, 07 Feb 2024 09:07:10 +0100
Message-ID: <4e9e5ec1-e040-49e0-84a4-9f86c0fcec1b@leemhuis.info>
Date: Wed, 7 Feb 2024 09:07:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
Content-Language: en-US, de-DE
To: Linus Walleij <linus.walleij@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Christian Heusel <christian@heusel.eu>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240123180818.3994-1-mario.limonciello@amd.com>
 <CACRpkdZxOovTOF0rOjyU1WwaRLZqML41hfYcC7z=HsAQjY8BsA@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CACRpkdZxOovTOF0rOjyU1WwaRLZqML41hfYcC7z=HsAQjY8BsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707293235;2a1c4c85;
X-HE-SMSGID: 1rXcxa-00022T-Dd

On 31.01.24 10:06, Linus Walleij wrote:
> On Tue, Jan 23, 2024 at 7:08 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> 
>> On some systems the interrupt is shared between GPIO controller
>> and ACPI SCI. When the interrupt is shared with the ACPI SCI the
>> flags need to be identical.
>>
>> This should fix the GPIO controller failing to work after commit
>> 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI").
>> ```
>> [    0.417335] genirq: Flags mismatch irq 9. 00000088 (pinctrl_amd) vs. 00002080 (acpi)
>> [    0.420073] amd_gpio: probe of AMDI0030:00 failed with error -16
>> ```
>>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Reported-by: Christian Heusel <christian@heusel.eu>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218407
>> Fixes: 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")
>> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15n4gRH48y7MEaLoXF+UA@mail.gmail.com/T/#mc5506014141b61e472b24e095889535a04458083
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Patch applied for fixes!

Hmm, Linus, that was a week ago and I still can't spot the fix in -next
or
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
; am I missing something or did something come up?

Furthermore Christian seems to grow impatient -- and I do as well, as I
recently couldn't wake up my laptop due to this while on the road. :-/
As at least one of the affected machines is quite popular in Linux
community, I'd prefer if we can fix this rather sooner than later.
Linus, if you are busy, I could ask the other Linus to pick this up
straight from the list if that's okay for you.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

