Return-Path: <linux-kernel+bounces-159568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2DF8B306C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1A4B23670
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AB37160;
	Fri, 26 Apr 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="yUt9hb3Z"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C620631;
	Fri, 26 Apr 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113032; cv=none; b=HbFmAwcXlAeCo4569dqOt7n7xzFbN7fqpgZWKqfCTkj11yvUl888IgQ5FNdbY3+bxeEFU96OYmlBh/YVO8XdR1Ndbmq55qRqbkRB5meIJGhR+i+svrVvWu+W2VtqBO/l2TUvLxvcfcI4jLG4tV2emweVsUPdxB2wAZnT5YoFJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113032; c=relaxed/simple;
	bh=H+5rwc89tCjEHu0KqwHwKpS4+vjC45z3KXV2smJhxTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oV5VNlShmdYuGyTep9IwrMPZHADr5HH7WgkW4yFhpsk56f98KYE+PEibqjeNf+07FYIeFaM77agECT8zGNObDFJMp9xdSuDGRKzE5/lNoRVt/QrZDuwLltxi8wPNNByf0XOAOA3YcVzhroBzzV3Y6E29OW21fFauqkLhtHFW20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=yUt9hb3Z; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=AYzZEF7JC/Zux/HGDdSRgGYZlcZDlsavbIJ+OlNLhvI=;
	t=1714113030; x=1714545030; b=yUt9hb3ZCnhz8vzbtmAY88dQFtay6Dw4j8vxZcMJbBLc6JW
	x6WKer61bW0GT1ePUmFTNGmvKu5YMlT3raSGjHW/hUaNEGmE0RR31t/ocx5+G9Xqt0x6KV+DTgg/K
	agQ394LfVNnjiNGrRZUCiMjEzSZ5FywEtg3wLUWVdlpPvm2dsovL3NFvfylmec1uy1th8ntu5EfPr
	mi7smirKCN+E25fmbd3mHid0KdXsTD2agiuSXMH3f3vS2nm9ct2JsY4Aw5DkLqhNtxXXWKOHtcwfn
	PPKaUFX2yILly9bVjVB+blqbW/Yfx9dEGgFpg+VLkPWtX5wXSeA/hpBXQDjyS5Rg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s0F6J-0003S9-SU; Fri, 26 Apr 2024 08:30:27 +0200
Message-ID: <b36151b9-15af-41cd-92ca-9ab515d03256@leemhuis.info>
Date: Fri, 26 Apr 2024 08:30:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: pwm: Disable PWM when going to suspend
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lee Jones <lee@kernel.org>
Cc: kernel@pengutronix.de, linux-pwm@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-leds@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240417144943.GA2399047@google.com>
 <20240417153846.271751-2-u.kleine-koenig@pengutronix.de>
 <yitqw57rdkr44ly32sxukxa2m4a6jm74upfxc74dmbklucl6kq@3ni7emsqgzx4>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <yitqw57rdkr44ly32sxukxa2m4a6jm74upfxc74dmbklucl6kq@3ni7emsqgzx4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714113030;349e5dd1;
X-HE-SMSGID: 1s0F6J-0003S9-SU

On 26.04.24 08:17, Uwe Kleine-König wrote:
> On Wed, Apr 17, 2024 at 05:38:47PM +0200, Uwe Kleine-König wrote:
>> On stm32mp1xx based machines (and others) a PWM consumer has to disable
>> the PWM because an enabled PWM refuses to suspend. So check the
>> LED_SUSPENDED flag and depending on that set the .enabled property.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218559
>> Fixes: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED should be off")
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> ---
>> Hello,
>>
>> On Wed, Apr 17, 2024 at 03:49:43PM +0100, Lee Jones wrote:
>>> On Tue, 16 Apr 2024, Uwe Kleine-König wrote:
>>>> If you don't consider that suitable, I can create a patch that is easier
>>>> to pick up.
>>>
>>> Yes, please submit it properly.
> 
> Gentle ping. Even given the regression was introduced in v6.7-rc1
> already, I think this should go into v6.9. [...]

FWIW, I guess Linus would agree (even if it's the second to last release
in this case):

https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

