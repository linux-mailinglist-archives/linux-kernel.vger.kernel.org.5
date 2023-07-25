Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1576107D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjGYKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjGYKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:20:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C609D3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:20:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9924ac01f98so911682466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690280420; x=1690885220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jIVNYaHHmeDQiXmoP9m789p3Mzn0tkwmSrMiWxE+uY=;
        b=CfsxZ9259skla4lUSHgp4lTpPTYElCjewiULtELpmzhpzegOTMrUaBaJ7OvAYXEVJK
         /pjs8RLYyuXyth4xF+5fYndWo2Om+b9t8VXOfZEMY5fWAS2uPZn3dxj4E1XnFJlFPZHZ
         ZeEHROCRal5I0OubsqBedHfYf1qjpOrKP75Svv+ZzL6rj+A16mZRZuPaTOYkStqLtj3c
         ETncB5auQfnoLJF5k+5QeaKNOl8gsK5O0MQ/h88iDtKU4xzvy2JfT6PQhzXUV8oOK/tQ
         kUwfOeVgdfQHlmZSFeSqeCuAGCA7UERCZhnRSkcg5OZR51SzLIQ770uFOgI3IXuKPSA4
         rWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280420; x=1690885220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jIVNYaHHmeDQiXmoP9m789p3Mzn0tkwmSrMiWxE+uY=;
        b=GOSRSPh0DzlrNeSmd1aABcsAi6DWPq+iV11QFNol0xBLSs/j5aIv05nncXcge24XOA
         TySWqCqx9dO1uha9pB0Ujo15Y9qQfHEWT6BDtcRndArupbOFDMz8ysvb28UgAQAyYDL0
         nLvFqLemr/mHwdlpdU5NPYU8TDwNrdqxRvnkqcg1OCkR8YXbv7jaZye253geJfMl26IF
         BwYaLwSsYom167IGUiXPNeLSG6zbH5ZqoE9XFesQaFkDtMElxATmdKZU1nngRacczFhY
         EnSP9tNEeQnJriWgh1229yJGwReX2sIbodERB2IDCyqOcNanhIgBKF5MpRkG6sht2Xw8
         k4Pw==
X-Gm-Message-State: ABy/qLZSEn6IvQMi3sbY3jFvsyFREc8sgfxPoplKbrJjBEKh7YrQyeBI
        I/4Y0+xZO/+WvFkm2AhKN1sALw==
X-Google-Smtp-Source: APBJJlHY9X0+bqoFGop+ibsHnoN7/6ELpRtMC0j6aM2Jx6xFfYTFRrxPc5iTwGKP7zYcJICSUetA8Q==
X-Received: by 2002:a17:906:1059:b0:993:d6e8:2389 with SMTP id j25-20020a170906105900b00993d6e82389mr14174629ejj.26.1690280419992;
        Tue, 25 Jul 2023 03:20:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906855900b00993017b64a9sm7937211ejy.223.2023.07.25.03.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 03:20:19 -0700 (PDT)
Message-ID: <40b7765e-5e6a-dca9-980b-62123b3779bf@linaro.org>
Date:   Tue, 25 Jul 2023 12:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] memory: tegra: Add dummy implementation on Tegra194
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629160132.768940-1-thierry.reding@gmail.com>
 <1fd1d5d7-7296-0e62-9f65-7347ac0f0500@linaro.org> <ZKwCYjKXtuDsOF9E@orome>
 <1ebfbbec-d5cf-c6ac-2cf1-eab970903500@linaro.org>
 <cab267a2-28a0-969a-44cd-c87c8fe65218@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cab267a2-28a0-969a-44cd-c87c8fe65218@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 12:14, Jon Hunter wrote:
> Hi Krzysztof,
> 
> On 10/07/2023 14:29, Krzysztof Kozlowski wrote:
>> On 10/07/2023 15:06, Thierry Reding wrote:
>>> On Mon, Jul 10, 2023 at 12:10:43PM +0200, Krzysztof Kozlowski wrote:
>>>> On 29/06/2023 18:01, Thierry Reding wrote:
>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>
>>>>> With the introduction of commit 9365bf006f53 ("PCI: tegra194: Add
>>>>> interconnect support in Tegra234"), the PCI driver on Tegra194 and later
>>>>> requires an interconnect provider. However, a provider is currently only
>>>>> exposed on Tegra234 and this causes PCI on Tegra194 to defer probe
>>>>> indefinitely.
>>>>>
>>>>> Fix this by adding a dummy implementation on Tegra194. This allows nodes
>>>>> to be provided to interconnect consumers, but doesn't do any bandwidth
>>>>> accounting or frequency scaling.
>>>>>
>>>>> Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra234")
>>>>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>>>>
>>>> Applied with checkpatch warning. Please be sure you run checkpatch
>>>> before sending the patches.
>>>
>>> Are you referring to the Reported-by/Closes complaint?
>>
>> Yes.
>>
>>> I didn't include
>>> a URL here because this came from an internal test report and there's no
>>> corresponding public reference.
>>
>> Ah, ok, apologies for pickiness then. :)
>>
>>>
>>> I suppose I could've left out the Reported-by altogether.
>>
>> I think it is fine. Checkpatch warning is just advisory.
> 
> 
> We need this in v6.5 as a fix, because without this change PCIe support 
> is broken on Tegra194 devices. Would you be able to send as a fix for v6.5?

Thanks for letting me know. I'll send it soon.

Best regards,
Krzysztof

