Return-Path: <linux-kernel+bounces-128872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E6389615C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945C9B24A62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8A125CC;
	Wed,  3 Apr 2024 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEIFKcI5"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E967B1870;
	Wed,  3 Apr 2024 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104020; cv=none; b=mQDaoIpw1l/3TWJOLR/apScbZm2O05g2OjBQP1W6YyXNS2m3P4XguoK2G0A0AuD1YXQ+1iXTTA1hvTPqEjLi46dMbeNKDDHq8JICnn6OuuAnu3omI6mieUeEpH8QyGsZ6N2z/X0mL9pzkfNjsmAHXQo6nAwsfnYy0SiLYuJ7MGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104020; c=relaxed/simple;
	bh=KUIMvQFpEGXh2hYj0le3llFT2iS+yt6YfWMAnT/9QfA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iDF3EbVZuQJEC8XKjf97JQqA9a0OkIoA7/H2m6aaK2XONxXNZNEynujH0PvSJ5TuiWD8jzEXhSGVbHJu9qymJ1u7p8r3ojP05HDMa0NzgNgbGnOESyv8oBEvyAod2Ttw8QlCfP9mkoH9hGd4XU+11F6ZyOtoXV+aGqkrq9hNXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEIFKcI5; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a4b35ff84eso3722396eaf.2;
        Tue, 02 Apr 2024 17:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712104017; x=1712708817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJynIROMAU+9B7UDiFFRoCdDhIpw65xNX+rGxpgSGeo=;
        b=QEIFKcI56bhoTNUHxDTX2HzuunjDtiPcd6BtgQ+kPACCpnyiAn7GsH2oPIJXrbdtZR
         ohlSFybYjbBDrAps7wKMK1XOYPZUzj0dlgSUlJI2Z4DPYUebNIYt/2IJqZfWjQhqBKAF
         z4ZvTHg2+uGNmRKqHSWce8MxBoIdQW135nojW58vyOBVp3GPkqjX7AK039GRsPbRBIKD
         zi9xFVr0coNjU6d63gYKE818e/J4yfiM1aWR3k/AZirMJYBkgBIMLadDfcfMfYQg/8sk
         JSaFD7iExnuqR8b1j8kG/eI/4S7gR/hl9C+KetvL/X/a8KLX79hm4F7/tgXDU77JKPBu
         Rq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712104017; x=1712708817;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJynIROMAU+9B7UDiFFRoCdDhIpw65xNX+rGxpgSGeo=;
        b=HuQpm41t8YzWtXf8BaWxQHfM0nNFyHRPuXTULd7Ea8AM9d4uWcsENWBh9gJ+GAIZTu
         i5+RfP9yRjWv0IyAeHBg5ROU5IH15SZp7Byg/yaBY7pDv0nHJ5HmbpvXEB1pWA0i39Lx
         15iEe65F87JmykwpWRKLP4mBARDviSqE5IXCMHPaqAx47/QV9U3ujXOJn4K7i7JiWuhz
         udmxfLymu3DMf20ZERHMdIAYWBU9bbd9ka/M9E81/EaYWVj1tOuKfByHpTG3Rgc8fYiP
         HudsBojQVGli1rYbliqDyd+cNobVIYC80bwt5R+pttKjTjlSGfpX3w3OS4eKfW3USNVF
         cSgA==
X-Forwarded-Encrypted: i=1; AJvYcCV+aPQOHGD7DluoSmV3mNJoBE3Tlr23lqxWKjEkM90Lxyo9N2E5BuKQxNAu+KQZwRteXk1qe+StsIAWOpz3Wt7aQIeRiBwmX08S6lZ6D8oJJbuxs/r3r4DQXWKa8h9v6zk3gsFm2HnHTBWiTsZGBxRwJ99b3tLDeaNVKi1o/QmO2L3oiw==
X-Gm-Message-State: AOJu0YyQFmqQ1B52ovR8jYqM5ay4oegIZQShKB61M04tRX1mtXd2KqOI
	tL4+MTa8sDPDScuS+/hofJIaSH/KjpEJZie5ZWIWn6MMrzq4peyhyGPUF8w8gTY=
X-Google-Smtp-Source: AGHT+IHhljBegJ+lKt5ZBT0wk8a5MZ4tYNQVcpSUH/dt+V7eojih7U8r9PBN6Az5f3nk+1efsx40eg==
X-Received: by 2002:a05:6358:49f:b0:183:630a:a88d with SMTP id x31-20020a056358049f00b00183630aa88dmr1197722rwi.9.1712104016926;
        Tue, 02 Apr 2024 17:26:56 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id a10-20020a63e84a000000b005dc491ccdcesm10213080pgk.14.2024.04.02.17.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 17:26:56 -0700 (PDT)
Subject: Re: [PATCH v3] clk: starfive: pll: Fix lower rate of CPUfreq by
 setting PLL0 rate to 1.5GHz
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20240402090920.11627-1-xingyu.wu@starfivetech.com>
 <8d21b1bc-9402-41d4-bd81-c521c8a33d2d@kernel.org>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <7e363fb9-5dff-b8de-fd4f-54b3596ad179@gmail.com>
Date: Tue, 2 Apr 2024 17:26:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8d21b1bc-9402-41d4-bd81-c521c8a33d2d@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 4/2/24 9:18 AM, Krzysztof Kozlowski wrote:
> On 02/04/2024 11:09, Xingyu Wu wrote:
>> CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
>> But now PLL0 rate is 1GHz and the cpu frequency loads become
>> 333/500/500/1000MHz in fact.
>>
>> So PLL0 rate should be default set to 1.5GHz. But setting the
>> PLL0 rate need certain steps:
>>
>> 1. Change the parent of cpu_root clock to OSC clock.
>> 2. Change the divider of cpu_core if PLL0 rate is higher than
>>     1.25GHz before CPUfreq boot.
>> 3. Change the parent of cpu_root clock back to PLL0 clock.
>>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>
>> Hi Stephen and Emil,
>>
>> This patch fixes the issue about lower rate of CPUfreq[1] by setting PLL0
>> rate to 1.5GHz.
>>
>> In order not to affect the cpu operation, setting the PLL0 rate need
>> certain steps. The cpu_root's parent clock should be changed first. And
>> the divider of the cpu_core clock should be set to 2 so they won't crash
>> when setting 1.5GHz without voltage regulation. Due to PLL driver boot
>> earlier than SYSCRG driver, cpu_core and cpu_root clocks are using by
>> ioremap().
>>
>> [1]: https://github.com/starfive-tech/VisionFive2/issues/55
>>
>> Previous patch link:
>> v2: https://lore.kernel.org/all/20230821152915.208366-1-xingyu.wu@starfivetech.com/
>> v1: https://lore.kernel.org/all/20230811033631.160912-1-xingyu.wu@starfivetech.com/
>>
>> Thanks,
>> Xingyu Wu
>> ---
>>   .../jh7110-starfive-visionfive-2.dtsi         |   5 +
>>   .../clk/starfive/clk-starfive-jh7110-pll.c    | 102 ++++++++++++++++++
> 
> Please do not mix DTS and driver code. That's not really portable. DTS
> is being exported and used in other projects.
> 
> ...
> 
>>   
>> @@ -458,6 +535,8 @@ static int jh7110_pll_probe(struct platform_device *pdev)
>>   	struct jh7110_pll_priv *priv;
>>   	unsigned int idx;
>>   	int ret;
>> +	struct device_node *np;
>> +	struct resource res;
>>   
>>   	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>   	if (!priv)
>> @@ -489,6 +568,29 @@ static int jh7110_pll_probe(struct platform_device *pdev)
>>   			return ret;
>>   	}
>>   
>> +	priv->is_first_set = true;
>> +	np = of_find_compatible_node(NULL, NULL, "starfive,jh7110-syscrg");
> 
> Your drivers should not do it. It's fragile, hides true link/dependency.
> Please use phandles.
> 
> 
>> +	if (!np) {
>> +		ret = PTR_ERR(np);
>> +		dev_err(priv->dev, "failed to get syscrg node\n");
>> +		goto np_put;
>> +	}
>> +
>> +	ret = of_address_to_resource(np, 0, &res);
>> +	if (ret) {
>> +		dev_err(priv->dev, "failed to get syscrg resource\n");
>> +		goto np_put;
>> +	}
>> +
>> +	priv->syscrg_base = ioremap(res.start, resource_size(&res));
>> +	if (!priv->syscrg_base)
>> +		ret = -ENOMEM;
> 
> Why are you mapping other device's IO? How are you going to ensure
> synced access to registers?
> 
> 
> 
> Best regards,
> Krzysztof
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

Hi Xingyu,

Echoing Krzysztof's point. This piece code seems wrong to me. This logic belongs
to syscrg, rather than pll. Why don't you do the pll0->osc->pll0 switching from
syscrg side during probing?

Bo

