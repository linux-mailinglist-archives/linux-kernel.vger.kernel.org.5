Return-Path: <linux-kernel+bounces-154599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA28ADE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC831C21AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29219535CF;
	Tue, 23 Apr 2024 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbJ5Z1Gt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0547F7A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856948; cv=none; b=WZg6jY6ENkHStd4CD8uTonH1ecRaaNYXTwe0Smwmr2/mN7ZS6XnEYUoLoZk2lN/JFUCm49THqWwCp/KBMOVcrNxDB/ftRMrrrbPn7ZfV+lM8BjSeANekmi8w4cccaVMbzX9RfMMWE5Ep+1Q1gBTiA09cv8YF8do1HLuqtHLGoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856948; c=relaxed/simple;
	bh=TBerHdNcd/VaASBcrY0w9ZfZal4wjbWMeedPNUSWFT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4K0TSNs8U2oyITVmWGJCo0FefpLjUzSOylTluMRChR1XqnmZ4By2ODAAUX36EpCjgVaE/SJQjrN1nmnfwiytBA+lkQWLv9UFQOGgQsOrkACUienMUevVugttAizNx+m/ENoF5k23Tg0emc2PPq1LrqBDNaakZToZOR9Kkgl65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UbJ5Z1Gt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41a77836f16so12106845e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 00:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713856945; x=1714461745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5JDwEM0S+y8m3kJjVaTErVxuzPV5GK/2cL9D2vmiaQ=;
        b=UbJ5Z1Gtyt8ydfbXku7hag+Hn7/Ivj8orb7LgJm9dN3mRsiGC6269pBnn9ZQvTCC6L
         x6PsWLjq4zSKiz/5uW6AiJMwJmEH5tTWmgrtTUdUlcSUENRT9+fZMYQ/hdBVo+ADkAg+
         woOgi0znTx13UERfjyIwCxK02g/k3g8NzsfppjyUvlLVevWZV5YL/WlRn+t52tmVv5cg
         ELVKvoyHxPydVu9Qy8lcvcCaIR2NlcObOOI16/pEBV1tkfGYBb/I4ee9zrlmx/vc1wP9
         juogFmrKoetJ0fTLrPIKuWqwCQ33mA942uNLLesXGUpueMpB+HDNLvbV9xwTrq8rXl3/
         3ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856945; x=1714461745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5JDwEM0S+y8m3kJjVaTErVxuzPV5GK/2cL9D2vmiaQ=;
        b=ns5KPVPTtm+YUiOFQqzGEQd991j/V/uhA2Su8xpK7wmEMY4YTfGGrOhXgMRS2WxdBy
         4Oud7ySRF3VEj+hQBxqWXl8z5TgFO/J2f4afmCx0kHMbzpDyqqdm6b31/7Rh3QJBEyFj
         ZeNWJbSPCQvyCcwyD41IvVu4b2j0S8oY8pe/3ueVCZBW2Ty9w9o7OROtSk8+4MHqYbkp
         hmq/dAKpT3YabgyzvUbLKJvObefCpNJwQ8IljEZRNLyagzhJypOnXIS/0d3B6kYv6jGk
         Nc7wp4GfSZgwQKDzT4yIO01h/bG6qfDclEUmxORin1KQYiuC2m9SXt1rH2epARP5iiAC
         l9tA==
X-Forwarded-Encrypted: i=1; AJvYcCVwdDxjuLNnzXrff8Kg3lxmvt/sPnBmVn0vMQoaMbaIgu92rUWrEt6x23h+IteOzoNQECCt8p5CoTFgE+llkZfTkQFEoUk4UXZ6Laat
X-Gm-Message-State: AOJu0Yxl+C1fq4NhuxQB0owKm8dVPulE2sTQi5hFbjNboYe8heGc1ALf
	6xCJ85xuUvUDVOC3X+eVyVYQGMZg9pcbOa2E5L4uE+a8+j6p8sQ12HByRTncLW0=
X-Google-Smtp-Source: AGHT+IGxE63ul961rmdayPpwfWtYcPyASuIixgCszvjaulRux0YGT/IzWKGo6KnTBv1DRd8c/eNyMw==
X-Received: by 2002:a05:600c:a11:b0:418:f86a:5468 with SMTP id z17-20020a05600c0a1100b00418f86a5468mr10608692wmp.21.1713856944782;
        Tue, 23 Apr 2024 00:22:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm23034393wmb.41.2024.04.23.00.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 00:22:24 -0700 (PDT)
Message-ID: <8fd3faf9-0179-425e-a68e-d0dc0a2d7da9@linaro.org>
Date: Tue, 23 Apr 2024 09:22:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: kirkwood: Convert to platform remove callback
 returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230712094014.41787-1-frank.li@vivo.com>
 <20231204115517.zxjgi6ateobjj52d@pengutronix.de>
 <h2sjdrgs7hwmbucr3rxlpusnkpj5tgq2fx27gijtrglr5ffhs6@s63cp4isu4mx>
 <fgmvwuzy34cruggah2z7fau4nnfzopuylsgjs6zzdypp26boya@ekrj5myjef5f>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <fgmvwuzy34cruggah2z7fau4nnfzopuylsgjs6zzdypp26boya@ekrj5myjef5f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/04/2024 18:32, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Mar 06, 2024 at 10:33:06PM +0100, Uwe Kleine-König wrote:
>> On Mon, Dec 04, 2023 at 12:55:17PM +0100, Uwe Kleine-König wrote:
>>> On Wed, Jul 12, 2023 at 05:40:13PM +0800, Yangtao Li wrote:
>>>> The .remove() callback for a platform driver returns an int which makes
>>>> many driver authors wrongly assume it's possible to do error handling by
>>>> returning an error code. However the value returned is (mostly) ignored
>>>> and this typically results in resource leaks. To improve here there is a
>>>> quest to make the remove callback return void. In the first step of this
>>>> quest all drivers are converted to .remove_new() which already returns
>>>> void.
>>>>
>>>> Trivially convert this driver from always returning zero in the remove
>>>> callback to the void returning variant.
>>>>
>>>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>>
>>> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>
>>> Can you pick this up?
>>
>> This patch isn't in next yet. Is this still on someone's radar for
>> application? Would be great if this patch made it into the mainline
>> during the upcomming merge window.
> 
> It didn't made it into the merge window leading to 6.9-rc1. What are
> the chances to get it into v6.10-rc1?
> 
> I just checked, the patch was submitted when Linus's tree was just after
> v6.5-rc1. So it already missed four merge windows without any maintainer
> feedback :-\

Sorry, it is applied now.

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


