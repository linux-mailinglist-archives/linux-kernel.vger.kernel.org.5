Return-Path: <linux-kernel+bounces-146497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AAE8A6617
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F96284552
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D9B156225;
	Tue, 16 Apr 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LGd4MOuT"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EB3B78D;
	Tue, 16 Apr 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256121; cv=none; b=ro+WRFmsTCPzJPjXCzIpxEW1vLjlcd82GYNAn8bcnKMk5WyOvwOAOfaXTF+MT3NpeGAdKX4IqYImTUdBsAouP1kQTQ0sMAqlRAd72psvi0uC6EhM5/86syIilvPoSA69T0pcZcszIkrwu483v8xgRds7VFadOMhbjrms9NzgfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256121; c=relaxed/simple;
	bh=4fVG0hgGeE2MEJ2IjJFjK+zjyRc2WZJcMXDmHG2OPTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqdaJkHbpigRffR6dgDxvTkhmLhI1+o5Q/RN28VxzfvZpj5Z1Mj4JGRACEmLQki8yctxm/3qULIizqgllrzBqJEy0V0u+h07+QhYpf9KLseSq1uQUPeHvUOsMR3evjyMAa0XhBbcfE0ca6uyGbd5uYAzfnfasGsM4672KgFjezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LGd4MOuT; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=vzFrt8UEjfFC2LhFGHg/hPX6/YCtSpcnbyd4WgxC8mQ=;
	t=1713256119; x=1713688119; b=LGd4MOuTk4ddDXKzQ8sqmAmUIxZGaYJYz93V8ans7Q/fgUY
	n2F86+GwCih63j7mZ6rOdsBUN2zvbAF0jlxDGytapbLtemmgb6vPhi3m7a186p/rcfjScIWXX8BMX
	9rcelsdV6I/G0wrj5Y3vsD7hm626rEVL58JqGzRwYhH2DUoGrV9jAwqbeeGC3+jQEI34fd6o2NuUb
	CoTvVkH6Sx0vUOfCSv6drGjYwUiPZpn/+X2bI2QnA26QUrI6wyJqFkbyh8KPraP0G7GrdynvJBkPt
	RmBdbELUsmF3R+bsQx3fxXCfiWDJHa5TEQGyVEjyhTRHL/ORlBs0l0epS1cCXp6g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rweBB-0002LJ-72; Tue, 16 Apr 2024 10:28:37 +0200
Message-ID: <256e3d3c-d43f-4bd6-9a7b-50fc870e75e4@leemhuis.info>
Date: Tue, 16 Apr 2024 10:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] stm32mp1xx based targets stopped entering suspend if
 pwm-leds exist
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
 linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <5da6cf8a-4250-42f6-8b39-13bff7fcdd9c@leemhuis.info>
 <2vbwacjy25z5vekylle3ehwi3be4urm6bssrbg6bxobtdlekt4@mazicwtgf4qb>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2vbwacjy25z5vekylle3ehwi3be4urm6bssrbg6bxobtdlekt4@mazicwtgf4qb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713256119;bcf7860a;
X-HE-SMSGID: 1rweBB-0002LJ-72

On 06.03.24 09:18, Uwe Kleine-König wrote:
> On Wed, Mar 06, 2024 at 08:05:15AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> Uwe, I noticed a report about a regression in bugzilla.kernel.org that
>> apparently is caused by a change of yours. As many (most?) kernel
>> developers don't keep an eye on it, I decided to forward it by mail.
>>
>> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
>> not CCed them in mails like this.
>>
>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218559 :
>>
>>> Commit 76fe464c8e64e71b2e4af11edeef0e5d85eeb6aa ("leds: pwm: Don't
>>> disable the PWM when the LED should be off") prevents stm32mp1xx based
>>> targets from entering suspend if pwm-leds exist, as the stm32 PWM driver
>>> refuses to enter suspend if any PWM channels are still active ("PWM 0
>>> still in use by consumer" see stm32_pwm_suspend in drivers/pwm/stm32-pwm.c).
>>>
>>> Reverting the mentioned commit fixes this behaviour but I'm not
>>> certain if this is a problem with stm32-pwm or pwm-leds (what is the
>>> usual behaviour for suspend with active PWM channels?).
> 
> I'd assume the following patch fixes this report. I didn't test it
> though.

Jakob confirmed it helped in the bugzilla ticket. But the patch since
then didn't make any progress afaics -- or did it and I just missed it
in my search?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> ---->8----
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Subject: [PATCH] leds: pwm: Disable PWM when going to suspend
> 
> On stm32mp1xx based machines (and others) a PWM consumer has to disable
> the PWM because an enabled PWM refuses to suspend. So check the
> LED_SUSPENDED flag and depending on that set the .enabled property.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218559
> Fixes: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED should be off")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/leds/leds-pwm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 4e3936a39d0e..e1b414b40353 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -53,7 +53,13 @@ static int led_pwm_set(struct led_classdev *led_cdev,
>  		duty = led_dat->pwmstate.period - duty;
>  
>  	led_dat->pwmstate.duty_cycle = duty;
> -	led_dat->pwmstate.enabled = true;
> +	/*
> +	 * Disabling a PWM doesn't guarantee that it emits the inactive level.
> +	 * So keep it on. Only for suspending the PWM should be disabled because
> +	 * otherwise it refuses to suspend. The possible downside is that the
> +	 * LED might stay (or even go) on.
> +	 */
> +	led_dat->pwmstate.enabled = !(led_cdev->flags & LED_SUSPENDED);
>  	return pwm_apply_might_sleep(led_dat->pwm, &led_dat->pwmstate);
>  }
> 
> base-commit: 15facbd7bd3dbfa04721cb71e69954eb4686cb9e
> ---->8----
> 

