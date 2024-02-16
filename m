Return-Path: <linux-kernel+bounces-68233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D98577A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F81B28342E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C51BDD0;
	Fri, 16 Feb 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyY52mB+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7651BDD5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071838; cv=none; b=iPmQDCS0QDKtorJcDtUGeunfg7qLf9jvj2/ASyxzM8l6RLuVPNCu1HS+zjXkh8AKL0jtQeWBmd2Q3RaxIVRARAkMEjprUZDy/A8KXUV4/Bq3dYlBwkLTdR/200vv5fFiut13iUf//s64BObp8S9oJBxtilKBlL9BcmS+tUf6Z3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071838; c=relaxed/simple;
	bh=CuSzYkpW1cnbd7QLiY8ENrnT3YE8nLPOXunubIBTc1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrfsbYVXbChRzaheRpKybT6FU8XCZtUr0oooETVyZHF3Jn5ouXp3Q5X7CeDusy0Phw5lIbN4uNhNDWN9jQtITG/UkT5QpWr6deHl3QbkEbW5ZhN4tgRTdPdUbxBw6purU6bPsrETXaZrT2DQnR+8zddh5aZ9noZppVuwjMUDGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hyY52mB+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2a17f3217aso220378966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708071835; x=1708676635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cy3LXUzEOfblety0Bw1Qjn68YCgKHMaFfLyUL/Ni24s=;
        b=hyY52mB+eY0ra707WIBQUBBYO8rcdDRgWUzeRUrWjOGGgqgqZFukR9yzXSPMC4Afbm
         zvEVhuNZ/WlfP11mG2HlAQlbUPQDfIajCt0jrzObWtBZZt5U6lhqDmNgKFMaf9pGaUxn
         QUmGs2aS6YLGJziWeLh4m7NRq0BB+pv67oLZtRga9uQOEMs5VzHsCm/9xiXSg3yiHXf1
         SXTWLwBYfAhTuQsjnVLIzH151R5oBniWfEKm63763AzJnPfo2sx2gQ0+rW+O35MZsF2e
         1nXRcq0hdjDjuU8pbCFRPdQybk2QjZ8tZRYdAg8boZyyYnh40yn+jvEv6daxJZS3kcrQ
         LmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071835; x=1708676635;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy3LXUzEOfblety0Bw1Qjn68YCgKHMaFfLyUL/Ni24s=;
        b=JJzxYtgtUD1E4rI+xUnW4nUIvJaBVLoFyM1/OczL4y+U0v0bmwu7+l36/WK2Pm6sR8
         xwIpiW+nRjEqxa6eo43K9/DtJy3pYgNinGe9wsFD52hbdXmu2rgSuKd6/lkB+aUrtzwA
         gBpYejqQzzhey+WX8DEsv8AElNg3EaLcSeqbC6/Bxl/OsvDA2LOS67SPXaN3zMiYdl5J
         1d7t5MOaI0okCf8y0+ddAku33xGNFxBX9eOytuC/m5bc2PtsBuiICdI3Ej2lVmQ96OBn
         4kpSWkGMZEO5blbj2NqNcdO7WQNsgbFFRgAIvI0fTqYQ85njN9UhYGK/3BJH4pAGQBcN
         IvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsmowhTrHCYefb35Z3pd2V+JQ+0aPuai/hMa6Wt3N5KguSNZzhV6DEw/qr2kyNkn0n03ogxCKaSgANjdawO9L95wLQAjocIz14osoM
X-Gm-Message-State: AOJu0YwCgUWsJlCIWGZdJR/BtFhdAD8Ssd/8JMAeYyt3s3iI7JUotSmW
	XHrf4k+m4STmVHxHvPPmy+MsET/aBHX7/p7UL8g47ur/UDr/5JnFQUxc60KR8tw=
X-Google-Smtp-Source: AGHT+IGq/dh41TSBWnHjI/60+m3wWYWEYYnc9Ru61/hm+O7hpItu994ZfNVTMifi2a7L2ggk1W0bcw==
X-Received: by 2002:a17:906:2dc7:b0:a3d:dee9:e554 with SMTP id h7-20020a1709062dc700b00a3ddee9e554mr610611eji.13.1708071835000;
        Fri, 16 Feb 2024 00:23:55 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id vg12-20020a170907d30c00b00a3d6a2d3904sm1328560ejc.146.2024.02.16.00.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 00:23:54 -0800 (PST)
Message-ID: <acc38b94-7810-4db3-9d7c-5d269d99d709@linaro.org>
Date: Fri, 16 Feb 2024 09:23:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: net: remove outdated hisilicon-femac
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-3-e0ad972cda99@outlook.com>
 <86a4d31d-80e4-4c11-9c71-e14494e3c8f2@linaro.org>
 <SEZPR06MB69597BA5B7F02E0B9995131A964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69597BA5B7F02E0B9995131A964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 09:03, Yang Xiwen wrote:
> On 2/16/2024 3:21 PM, Krzysztof Kozlowski wrote:
>> On 16/02/2024 00:48, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> The user documented(Hi3516) is not found in current kernel anymore.
>>> Remove this binding entirely due to recent driver changes.
>> Hardware does not change because you decided to re-implement driver.
> 
> The only hardware i have is the hi3798mv200. According to downstream 
> driver name, this is supposed to be a hisi-femac-v3 actually. I don't 
> know much about Hi3516, but it confuses me a lot. According to the 
> device tree node example in the text binding file, the MDIO bus is 
> supposed to be inside the femac core (femac core is at 0x0-0x1000 & 
> 0x1100-0x1300 and mdio bus is at 0x1100-0x1120). So i think it's highly 
> possible they are the same hardware. But according to the TRM and my 
> tests, there are 3 clocks in total for femac core in hi3798mv200, one 
> for mac ctrl, one for ahb bus(I'm sure this "bus" clock is not MDIO bus 
> clock), and one for phy, which is very similar to the hisi-gmac driver.
> 
> Which complicates things a lot is the complex clock enabling timing 
> requirements here. at least for hi3798mv200(and all SoCs with 
> hisi-femac-v3 core i think according to the downstream kernel source), 
> It must strictly follow the sequence in hisi_femac_phy_reset() (disable 
> MAC clk and BUS clk first before asserting PHY reset), or the PHY would 
> fail to work. So as said in previous reply, the simplest way is to do 
> all resets and clocks management in the MAC driver, or else it'll be 
> very hard to implement. I can't find an easy way to "tell" a driver to 
> kindly disable its clocks remotely.
> 

None of these explain why support for these devices should be dropped...

Best regards,
Krzysztof


