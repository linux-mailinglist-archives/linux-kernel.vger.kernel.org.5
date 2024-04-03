Return-Path: <linux-kernel+bounces-129957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B39897281
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E860287D19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814F1494D3;
	Wed,  3 Apr 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Epe/x9Xz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927E61494AE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154295; cv=none; b=sPZmKZeVNerVvOppa39zyTeyJZcjrPHTIxuYzvLCSK+qLUz9Q96CD8hlkvGB41d+SL4upKHzPTM1g1LLvRJF3jFWu9xJ+tGFOZ1lz2Z4KoqDikRkow6Tej8BGHkkxnWhrQLinza4LfMsfOgp2uvtCvldQKKq4B8L0YVCJag+1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154295; c=relaxed/simple;
	bh=KZAQmfykRtq5DHuaM8HKLtvCHkg+oSeIog95Kpc8CHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DetsxxOveLyIcfLFI5C2KIJ3kB++RUruTT4IeOLOEK9JAZ61LI+Z22k1SAbzAaoRWgScENFq4rSYNOZvrQt/5WRfts7o6stiiNpnBkAo671cJoC8IjTjF+CVoz5Zt096r2l+Y7ezyDu8ci89n5qlQWsDYI6+UGfADlNHq40PfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Epe/x9Xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E20C433C7;
	Wed,  3 Apr 2024 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712154295;
	bh=KZAQmfykRtq5DHuaM8HKLtvCHkg+oSeIog95Kpc8CHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Epe/x9Xznvuo7MsH+YKmAuDe+POkhUWjb1gGCpf8IzUGjlMADB4sYaV3+nN1wLngp
	 KFKK/w/CuuqUDgG9wkCU/7xzwW3s+qT0nXE9qNb3SOHf0Y2B8sCEx/7gwv+kGpM3jm
	 QfYvUtkZeoKnNpvbTB0UU1Zlv11yAmTZAFnOwSFv9XiCPpOAJHwMtkYzdQv12/dJdj
	 JyOJbPwoEcQmGSYO34f38A5+rdFcZitAIqYP2mWsXknoGdjODfm/pr2WbofabkLXIB
	 Ohi6QA0kr054/dkUAlllgE0WR0TzoKsEA6LoOjmHqWKYajlWidaVfJWKkWRZ4E/L3i
	 fmF/thnolevmQ==
Message-ID: <edb25c16-3f63-4f5b-97e5-363cf199d780@kernel.org>
Date: Wed, 3 Apr 2024 16:24:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] regulator: bd96801: ROHM BD96801 PMIC regulators
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <3a6839e2663bd064100af41f6df0cace746cf2e4.1712058690.git.mazziesaccount@gmail.com>
 <9d302a8a-a8bf-4a26-b1fb-44db6a5f5eac@kernel.org>
 <e0d760d7-5408-47b8-b204-7900bcd9c608@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <e0d760d7-5408-47b8-b204-7900bcd9c608@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 09:38, Matti Vaittinen wrote:
> Hi dee Ho Krzysztof,
> 
> Heading to the Seattle? If so - Enjoy! It's a bummer I'm not able to 
> share a beer with you in ELC this time.

Second chance, I hope, will be Vienna in September.


..

>>> +
>>> +	rdesc = &pdata->regulator_data[0];
>>> +
>>> +	config.driver_data = pdata;
>>> +	config.regmap = pdata->regmap;
>>> +	config.dev = parent;
>>> +
>>> +	ret = of_property_match_string(pdev->dev.parent->of_node,
>>> +				       "interrupt-names", "errb");
>> This does not guarantee that interrupts are properly set up.
> 
> Hmm. Yes, you're right. I'm not sure if I did think of this.
> 
>> Don't you
>> have some state shared between parent and this device where you could
>> mark that interrupts are OK?
> 
> There is currently no need to share/allocate any private data from the 
> MFD. We get the regmap using dev_get_regmap, and interrupts using the 
> platform_get_irq_byname(). Nothing else is shared between the MFD and 
> sub-devices.
> 
> Considering the use of platform_get_irq_byname() - and how failures to 
> get 'errb' IRQs are silently ignored in bd96801_global_errb_irqs() and
> in bd96801_rdev_errb_irqs() - this check is just a slight optimization 
> to not even try registering the errb IRQs if they're not found from the 
> device tree. So, I think things do not really go south even if we go to 
> "errb route" when the "errb" IRQs aren't successfully registered.
> 
> Whether this warrants a comment, or if this check is just unnecessarily 
> complex can be pondered. Personally I think the purpose is pretty clear 
> and thus the complexity is not added that much - but yes, a comment 
> above call(s) to the platform_get_irq_byname() saying errb IRQs are not 
> guaranteed to be populated might be justified.
> 

Fine with me.

Best regards,
Krzysztof


