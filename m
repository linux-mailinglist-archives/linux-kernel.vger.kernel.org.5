Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C57907BA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbjIBL5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjIBL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:57:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7EE10F4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:57:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500bdef7167so994797e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 04:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693655848; x=1694260648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDa7Mj6sArPataDgSx4z5NxOtH/XftsbKDNnlo52CRg=;
        b=RS53jAH4qgcbikiCiDgQ5CzSK+jO9f2kkDQdc2svtutW1wS942bfEiHOe/yhjzqzig
         NiSKHv3uQwfA69cG6BFFl5ss/SRbqk4Ltg+1VYdr2B069H6MPfXJ01WBNhR2YUAj+4lu
         JlRT9aAtK2rsl4H4kYWGqZ0Nk/5PYwRTRKNT5D20Wuh1ca9ZAOQJ8DLfTAAjDTliygrY
         Q3SEqerZUl7iKnHMPGR+n88frBkQJ/prkLIw3Ji2urCYKFTLhMndraKWeINhjrw2rI2e
         qV2dErOE4t9g/TQ8B3IcWXf53hf115qlVVo5fkGPo3c9Laejy/rILwksCRiWFmjPnsyE
         kGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693655848; x=1694260648;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDa7Mj6sArPataDgSx4z5NxOtH/XftsbKDNnlo52CRg=;
        b=YBKGLvV5nygOrFBKjMyo50XIojU/korivIFw4/UF4Ue409iRDoiTfKvZ8M/XiUGIGH
         Ty7035xt5ZzRdun0RRgxDeUePyP0Rty/jDtYlk91BNMgKPkJ2wJY4nsPkzJ6A/tPZ8wR
         wZLnRZlCo9rlZF+Hafu9rjufNpcosfDSBLdFUj9RXC3tneMPBlLEDKZyivotH9w0DJFq
         8eaVsYkSwL4Ft5/H79vCnSlsiJqJUhNu9qRl7YdX3oSwt/70jih5qS+49cToZozG50Nd
         a6vfpzOr12k7Idk1lPJYYfQ0Xy0I7DyhomTFMYr1tZoHpOzqeSbAnGJVb5AqKVzKDGPp
         27dQ==
X-Gm-Message-State: AOJu0Yy/Nxubn2qpFsHsJkM2A61I6zXjQkhCKhHF1wJA4tml5tU88OCE
        Bp6dWrBSdrf28r1vrjGzWtfbOA==
X-Google-Smtp-Source: AGHT+IEYG2aZATJsHIb7Bhd7H3gdibYwXzz6lm5qAFh0+KxyLnYy8P4+diX+3bXR9VunynVsV3RT7w==
X-Received: by 2002:ac2:4f08:0:b0:4f8:6d9d:abe0 with SMTP id k8-20020ac24f08000000b004f86d9dabe0mr1728550lfr.33.1693655848495;
        Sat, 02 Sep 2023 04:57:28 -0700 (PDT)
Received: from [192.168.1.101] (abxi170.neoplus.adsl.tpnet.pl. [83.9.2.170])
        by smtp.gmail.com with ESMTPSA id l26-20020ac2555a000000b00500998f63cdsm962839lfk.109.2023.09.02.04.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 04:57:27 -0700 (PDT)
Message-ID: <2b52c9b2-adf1-4622-9d0d-fe6599523174@linaro.org>
Date:   Sat, 2 Sep 2023 13:57:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916/39-samsung-a2015: Add flash LED
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        nikita@trvn.ru, robh+dt@kernel.org, stephan@gerhold.net,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230822140407.3316-1-raymondhackley@protonmail.com>
 <c016d9ac-da33-4a0b-8684-ab7b4b50ebe3@linaro.org>
 <20230822150035.3803-1-raymondhackley@protonmail.com>
 <fb452457-6687-4f68-9498-92a3077c9a44@linaro.org> <ZOz4460Q/JQcMcU1@L14.lan>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZOz4460Q/JQcMcU1@L14.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2023 21:43, Henrik Grimler wrote:
> Hi Konrad,
> 
> On Sat, Aug 26, 2023 at 02:09:38PM +0200, Konrad Dybcio wrote:
>> On 22.08.2023 17:01, Raymond Hackley wrote:
>>> Hi Konrad,
>>>
>>>> What about the other subdevices registered with the RT5033 MFD?
>>>
>>> Currently the MFD is not able to control the flash LED, due to missing
>>> driver for it.
>>> Alternatively we control it with GPIO pins. With driver leds-sgm3140, the
>>> binding is not under the RT5033 MFD.
>> Hm.. I have mixed feelings..
>>
>> Does the led controlled onboard this chip have some super complex
>> functionality that is going to be exposed through a specific driver
>> and that is not exposed through the sgm3140 driver?
> 
> The rt5033-led&sgm3140 situation was discussed in msm8916-mainline
> matrix room before, here is a summary for list.
> 
> Using the full rt5033-led driver (old patchset here [1]) has some
> benefits, like:
> * led can have different intensity levels
> * led can (supposedly) be used in strobe mode
> 
> Using sgm3140 driver mostly works fine, but there could potentially be
> situations where led stops working and a reboot to stock android
> kernel is required to get it working again.  So far that has only been
> reproduced by first booting a kernel with full rt5033-led driver
> (based on [1]), and then booting a kernel using sgm3140 driver
> instead.
> 
> [1] https://lore.kernel.org/linux-leds/1448446948-13729-1-git-send-email-ingi2.kim@samsung.com/
2015, whoops..

Looks like the reviewers were mostly happy (style comments for the
most part), so perhaps it'd be worth to bring it back?

As for this patch, I'll be happy to take it if you can confirm the
rt5033-leds driver won't require bindings changes (i.e. the node
you're adding today would work fine as-is if you removed sgm3140
and probed the separate driver), at least in the form that it was
posted in the link above..

Konrad
