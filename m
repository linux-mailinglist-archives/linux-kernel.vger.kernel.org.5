Return-Path: <linux-kernel+bounces-109854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A835D88568D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D654B21247
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBC65337F;
	Thu, 21 Mar 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wsOg9C2n"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51B125CB;
	Thu, 21 Mar 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013485; cv=none; b=pIUjEfrZRK4jyzaAlHY5VuutL9vqdo5YQdDBXmWKIBl5ilyuAcfLFSbfnCXYg6pN76+2U9jWLB7naBkzlBCC4CMtkFut0xBrWtTMTB9JWgPCpLiCT/+CwdQQdGEhmffvq2C7sZkc5Kk7UZAhltOylaYH208jUSJLezj6oNBFU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013485; c=relaxed/simple;
	bh=TzFlFyBicWglBuM6+5UuyMfMcNrvW9nqeLaEKUhN0Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RW3dXDXijshiar+KW0N8Ulnmk+uC+m1F53YmTxHmFL996iZkaqLYoIvEdb6o+rn4YR87uzqukbFVdC19joOk7fc6RJ21sHzyjAANRX4+7LmPaCabbLzf5taWOdWnuwLPHwtWipkeysqnyphkr1K4mr+rlZUHxXo7TPBrXJyisBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wsOg9C2n; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=gn3aXvf5VTogYoFCNQ+hze3URTCA0KPJcqB9uzyTWx8=;
	t=1711013483; x=1711445483; b=wsOg9C2nMK1CryZat1gIgOb3nBUBNq/sOtpmFvIT9mCjUfa
	CdSG6CfCjbXRepKqxzHUtjFXE7XjwwNaB7+e75HivQA/1gHxAqrcC8uDK5jan4CytAWo/GNNczrYM
	vchwN4Sw/+NkoNSECrWL1jPFZm/2lGvVppaCTuSP6KeDZocjY2rBoblyYzN15K/+odi2GNT3cJmwN
	I9k9W0iK+F+r3cicWXS5KFhNlFUTomltpjEVoHZbF1J5X8VyC1kRwr4t0ji5/bXyKZMxuV/tVUM4j
	coM45dqxwPncaO5e4iv0PemIRogq/izRBKd+qenlQIlqyGnd8T2kIewOzhVVo/qg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rnElb-0005Vn-2F; Thu, 21 Mar 2024 10:31:19 +0100
Message-ID: <7ed15eea-24f9-4c75-abf0-f120c7f5b09a@leemhuis.info>
Date: Thu, 21 Mar 2024 10:31:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Failure to hibernate on Dell Latitude 7430
Content-Language: en-US, de-DE
To: David McFarland <corngood@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Chris Feng <chris.feng@mediatek.com>, linux-pm@vger.kernel.org,
 Alex Hung <alexhung@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240318191153.6978-1-corngood@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240318191153.6978-1-corngood@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711013483;97f36e79;
X-HE-SMSGID: 1rnElb-0005Vn-2F

On 18.03.24 20:11, David McFarland wrote:
> I have a Dell Latitude 7430, and recently whenever I hibernate with
> `systemctl hibernate`, the machine would immediately wake.

Thanks for the report and the proposed patch.

> I bisected it to:
> 
> 0c4cae1bc00d PM: hibernate: Avoid missing wakeup events during hibernation

I CCed the author of that change, which should at least be aware of this
any maybe help out.

Also CCed the people that take care of the code your patch modifies,
they should be the best to judge what should be done here.

FWIW, the start of the thread and the proposed patch can be found here:
https://lore.kernel.org/all/20240318191153.6978-1-corngood@gmail.com/

Ciao, Thorsten

> However, the underlying problem seems to be that during hibernation, my
> system gets a 0xcf (power button release) event, and the above change
> causes it to abort hibernation correctly.
> 
> I also noticed that holding the power button down (when it's configured
> to suspend) causes the system to suspend and then wake upon release, if
> it's held long enough.
> 
> I'm attaching a patch which fixes the problem for me, by skipping the
> wake on any of the release events.  These events are all marked
> KEY_IGNORE, so think this is a reasonable thing to do.
> 
> I'm a little worried about the consequences of doing this
> unconditionally in intel-hid.  Perhaps it should be a quirk?
> 
> David McFarland (1):
>   platform/x86/intel/hid: Don't wake on 5-button releases
> 
>  drivers/platform/x86/intel/hid.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

P.S.: To be sure the issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced 0c4cae1bc00d
#regzbot title PM: hibernate: & platform/x86/intel/hid: hibernate on
Dell Latitude 7430 fails
#regzbot ignore-activity

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


