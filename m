Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444957E70E9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbjKIRxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344889AbjKIRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:53:18 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8013A92
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:53:16 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9df8d0c2505so243212266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699552394; x=1700157194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4oEO8MSO87TqmnDdahLLrcDvp47TDgYSBhqIayM2v4=;
        b=cKBiMYeCMw0HkW1jLFxhDQguh4qaK1tgDVGrBPaNBTyKWkNAGMvFpGSH07dmW985U5
         S77KZfKJg+y6fDzo0cU04f4OFoHud4RYwEUzhmjzvS8+RqSYUgNAdjsYDSKHiI4mfLvZ
         OKzhf5t/6Lc5FuCNvlE47wyrPMpQmgjR8Qkbsr46MXw9+9VFBxlcBM9YIAItgOFzK7wT
         OxUo9tduCiHOUjD/mFfkBC3+QyNc0a5H/IHTLGO3pexzhRoZfIy/v7QSkXRwUlhj3n5F
         2Siq1guJNEtJS9uYbskWmH3O3fIRo5vJKSZgLYKcmi9WXMxrXH50V4Q2rmIhO/yllM9G
         8NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552394; x=1700157194;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4oEO8MSO87TqmnDdahLLrcDvp47TDgYSBhqIayM2v4=;
        b=D9T5XghdQTZDozBdtb5xyppUeYUSm06dL20H+SKhdZflpLPLI6w7ylyyiu5AS6ehXZ
         hPEUCstR3+fHhIzMpQ6uRhWXu1MJUtQw9g/zozkq7Vnxn4Ukrb4XW/01+pSJMWbKXVEX
         J2prmaVBO9cOtONFZc/mdzsWwHkFuDdg0JyZeH2agQ7j0RyO7zingVdo4s30ivu0ePzP
         fb3ufZCXAkTKokLJopgj1tt+/oLdIAo9rNomwaUemeYn82ASpXrYBRqlxI6mlAMP4ny1
         Q3EMxTDwj9q5RVsaBcSqPA9tLasUNisElLXSt3mvGwKjp1vpv8TBKVn7tfRK6TtaeuoC
         aIZw==
X-Gm-Message-State: AOJu0YxBb8XAqto1TNLub+h7NORv/H6aBMtoYzK0fKVsvYQD2/ZZID8B
        9kwApFdtyLgWr7F7k5ebWWkCsw==
X-Google-Smtp-Source: AGHT+IF+vU179+jGHJa4FD2pGFCEyDzz4K/7gO8/XCozwgW53hMMkfZwo7pYx4VMXFde+PI7WreLPg==
X-Received: by 2002:a17:906:74cb:b0:9a9:405b:26d1 with SMTP id z11-20020a17090674cb00b009a9405b26d1mr8810024ejl.5.1699552394487;
        Thu, 09 Nov 2023 09:53:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id lf17-20020a170906ae5100b009b947f81c4asm2815179ejb.155.2023.11.09.09.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 09:53:14 -0800 (PST)
Message-ID: <e5b1f0dd-0aab-4ce5-82ba-879a4d736e7e@linaro.org>
Date:   Thu, 9 Nov 2023 18:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Content-Language: en-US
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, michael.riesch@wolfvision.net
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <037bcabf97294d37b271537e4b11fb88cf9bb6f6.1699460637.git.mehdi.djait@bootlin.com>
 <20231109-closable-superglue-5e7f39739cf1@spud>
 <ZU0avuRRaITV4jws@aptenodytes>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZU0avuRRaITV4jws@aptenodytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 18:45, Paul Kocialkowski wrote:
> Hi,
> 
> On Thu 09 Nov 23, 17:24, Conor Dooley wrote:
>> On Wed, Nov 08, 2023 at 05:38:56PM +0100, Mehdi Djait wrote:
>>> Add a documentation for the Rockchip Camera Interface binding.
>>>
>>> the name of the file rk3066 is the first Rockchip SoC generation that uses cif
>>> instead of the px30 which is just one of the many iterations of the unit.
>>
>> I think this is becoming ridiculous. You've now removed the compatible
>> for the rk3066 but kept it in the filename. I don't understand the
>> hangup about naming the file after the px30-vip, but naming it after
>> something that is not documented here at all makes no sense to me.
>> Either document the rk3066 properly, or remove all mention of it IMO.
> 
> I think the opposite is ridiculous. We have spent some time investigating the
> history of this unit, to find out that RK3066 is the first occurence where
> it exists. Since we want the binding to cover all generations of the same unit
> and give it a name that reflects this, rk3066 is the natural choice that comes
> to mind. As far as I understand, this is the normal thing to do to name
> bindings: name after the earliest known occurence of the unit.
> 
> What is the rationale behind naming the file after a generation of the unit
> that happens to be the one introducing the binding? This is neither the first
> nor the last one to include this unit. The binding will be updated later to
> cover other generations. Do we want to rename the file each time an a generation
> earlier than px30 is introduced? That sounds quite ridiculous too.
> 
> We've done the research work to give it the most relevant name here.
> I'd expect some strong arguments not to use it. Can you ellaborate?

If you do not have rk3066 documented here, it might be added to entirely
different file (for whatever reasons, including that binding would be
quite different than px30). Thus you would have rk3066 in
rockchip,rk3066-cif-added-later.yaml and px30 in rockchip,rk3066-cif.yaml

Just use the filename matching the compatible. That's what we always
ask. In every review.

Best regards,
Krzysztof

