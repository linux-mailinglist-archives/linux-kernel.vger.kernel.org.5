Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99C979F242
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjIMTkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjIMTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:40:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC3A19AE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:39:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2874074a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694633994; x=1695238794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OK49Q648RZeJBzLDivYJKqT1WEe3JHrAHiziqKuqok=;
        b=UnNW2wQ6tw5HRsae0TMCV2HnU/J3P0u1YZJ5tsoOtHlFg9q4Yem9sYB0g/zyZeDP6z
         46C+u/KoYyKX4KfaIeaFSDwqvY+afgUemUwE5LmyncgDViPQf/+7g6UyGnCLgTbr7UXo
         iUZTpXOD4pjk43FjMAahrMMbL7EKX5O6W/JgzVsb1i4iKk5CNdblfBhbWHenqTEeobTP
         rl/NHE3OpeQwIN/NMlzmj0Tux/Uo2wAcUCsh9S9i4bZ/ZdDakjswKZ8cE6NmJ88x1rqW
         h8PNS0v6bSGU+JDEMg7jytEOcROiXT8NNOqiaDT29JtIG2lOCXOXExWHtfOW+p3nHtQf
         sZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633994; x=1695238794;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OK49Q648RZeJBzLDivYJKqT1WEe3JHrAHiziqKuqok=;
        b=oIRBuq7wXkE0rZPCDqZjMe3uKZ62rzz1CTD5l111t4uBll47lNwTbCyVoyfVYNLG4V
         mk5wy5gfSZvjdcOK273fdQI/IJ9He6hrT/jJlLJBkAt9u7QNBoTsJu8XPKS/+hiSXudl
         jjiqnM8i2tlrjN7+dKiTy92+6QBMHb+e0r1fbANO9J54cliI0Gnn0NDJccqFqczHj99k
         UzwrnXMKp434aBjhhbw2f1/FoCPW3rvvl3I9Fuga0SBApo12Y5b7GRUubrwJ3jCoyqsT
         oCGAoefX/SghefxIweBCMgcFX8UasS9jNrhLx9RV4UNpsMOy+8/AUEirDcrRccs6JmLt
         QsEQ==
X-Gm-Message-State: AOJu0YwbeiNMw5r6SgfPuWeLoGEg0EcBx1QQ4J65WYs8vP1jbZ9ZgpCh
        JpmbmWy9xBsLkdMQkpreoJ02NQ==
X-Google-Smtp-Source: AGHT+IG6rihgQzBxJRk/71CpZ77juWomxErnSftTU0SO2eLeRb2aDfgAcUoWkUvxgQ4ItI7DZDdjOw==
X-Received: by 2002:a17:907:94d1:b0:9a1:e0b1:e919 with SMTP id dn17-20020a17090794d100b009a1e0b1e919mr9944811ejc.4.1694633994152;
        Wed, 13 Sep 2023 12:39:54 -0700 (PDT)
Received: from [192.168.37.232] (178235177172.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.172])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709063e0e00b0098733a40bb7sm8833493eji.155.2023.09.13.12.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:39:53 -0700 (PDT)
Message-ID: <568b4e18-1ade-4a12-9766-d16d8ca9838d@linaro.org>
Date:   Wed, 13 Sep 2023 21:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] arm64: dts: qcom: msm8916: Reserve firmware memory
 dynamically
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-4-b7089ec3e3a1@gerhold.net>
 <912f90ee-0816-43ae-bc6f-a9a9a3e33d8a@linaro.org>
 <9b1beb38-9ec2-4bdb-97f5-fccf98d3b0c3@linaro.org>
 <ZQGLioVhjCK3TRva@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZQGLioVhjCK3TRva@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2023 12:14, Stephan Gerhold wrote:
> On Wed, Sep 13, 2023 at 10:12:12AM +0100, Bryan O'Donoghue wrote:
>> On 13/09/2023 10:06, Konrad Dybcio wrote:
>>> On 11.09.2023 19:41, Stephan Gerhold wrote:
>>>> Most of the reserved firmware memory on MSM8916 can be relocated when
>>>> respecting the required alignment. To avoid having to precompute the
>>>> reserved memory regions in every board DT, describe the actual
>>>> requirements (size, alignment, alloc-ranges) using the dynamic reserved
>>>> memory allocation.
>>>>
>>>> This approach has several advantages:
>>>>
>>>>   1. We can define "templates" for the reserved memory regions in
>>>>      msm8916.dtsi and keep only device-specific details in the board DT.
>>>>      This is useful for the "mpss" region size for example, which varies
>>>>      from device to device. It is no longer necessary to redefine all
>>>>      firmware regions to shift their addresses.
>>>>
>>>>   2. When some of the functionality (e.g. WCNSS, Modem, Venus) is not
>>>>      enabled or needed for a device, the reserved memory can stay
>>>>      disabled, freeing up the unused reservation for Linux.
>>>>
>>>>   3. Devices with special requirements for one of the firmware regions
>>>>      are handled automatically. For example, msm8916-longcheer-l8150
>>>>      has non-relocatable "wcnss" firmware that must be loaded exactly
>>>>      at address 0x8b600000. When this is defined as a static region,
>>>>      the other dynamic allocations automatically adjust to a different
>>>>      place with suitable alignment.
>>>>
>>>> All in all this approach significantly reduces the boilerplate necessary
>>>> to define the different firmware regions, and makes it easier to enable
>>>> functionality on the different devices.
>>>>
>>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>>> ---
>>> [...]
>>>
>>>>   		mpss_mem: mpss@86800000 {
>>>> +			/*
>>>> +			 * The memory region for the mpss firmware is generally
>>>> +			 * relocatable and could be allocated dynamically.
>>>> +			 * However, many firmware versions tend to fail when
>>>> +			 * loaded to some special addresses, so it is hard to
>>>> +			 * define reliable alloc-ranges.
>>>> +			 *
>>>> +			 * alignment = <0x0 0x400000>;
>>>> +			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
>>>> +			 */
>>> Do we know of any devices that this would actually work on?
> 
> Yes, the "modem" firmware on DB410c seems to be fine with literally all
> correctly aligned addresses I've tested so far. But when I manually
> experimented with other addresses on actual smartphones it exploded on
> certain addresses, specific to the firmware version / device.
Moreover, the "modem" on DB410c would probably be fine with
*anything* you try to give it..

[...]

> 
>  - On DB410c it works just fine. All addresses I tried work without any
>    problems.
> 
>  - On longcheer-l8150 the modem firmare works fine when the memory
>    region starts somewhere between 0x86800000 and 0x8a800000. It also
>    works again after 0x8e800000. But on anything between 0x8a800000 and
>    0x8e800000 it's broken for who knows what reason.
> 
>  - On some Samsung devices only 0x86800000 and maybe one or two other
>    addresses worked, again for who knows what reason. Most other
>    addresses were broken.
Were you able to find a phone (likely a very reference-design-based
one) that this worked on, btw?

[...]

> To be safe my conclusion was to keep mpss at a fixed address and only
> allocate the others dynamically. This is how the patch implements it.
That sounds like the sane approach indeed.

Konrad
