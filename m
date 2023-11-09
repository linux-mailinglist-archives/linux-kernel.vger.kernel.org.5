Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6015B7E67D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjKIKZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjKIKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:25:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A2258D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:25:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40859c464daso4660815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699525498; x=1700130298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEa65zbadXb56guqlzS9fYt6eXzoAqSRXIuLeM4+qbs=;
        b=cS70pRn99t/g68K0RdcbIlF9FjqPXjqvUBQnX8uomPLZ1YViv1SFQZASlcQ6mqzlbz
         DmKWbz3mHG8gwrC8o0tP0Rs6Zo3rDNH8WNAuTKIFukFK4eyG3h8H8BDYFa/qiRc4erkF
         dug1Dda9YROuV4a/ePHSQfedHeyrMJ3+uU1rgYz5wCskJR3IEVml3TxJctmdkUWHFMlo
         Qmh1vGXBRl4uQJq2Nv2bKsaewrL0eIgLR07CTRU2OVptEaU/5K5V0mXdyygZR+RzfUX8
         eux9DsQ8mU0HZDIvIFNb96JOvhvrq8U1ak7X2IlcGIBqJrbMM3B00JQ4pDkc9Gn40tnk
         7fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699525498; x=1700130298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEa65zbadXb56guqlzS9fYt6eXzoAqSRXIuLeM4+qbs=;
        b=iFJo7o2WJLc2lbNvOpWPHNxYCyx0nBCb5ND9zPpbkb0zMCG8pX5Wz7ArAQxrpnp3JK
         gaw5FO8vAYKKqT1W/NQWJ6+jQL/M0yXyzfNzkDGrFjjW//lLUa1AEm0g1O2evg8VnToC
         s9NPPGNSSrpPZfHu6+2D23tLdSmeznH8lMPW3JOt1PFZmIzold/ljUMOIQlpKEJk621m
         wtLGA0sdu+l9fjlogntnbIWnYvalqJ2F+wEDtA0pfp9FnV9fLu2hXd00/dnHA4eg4Kwd
         CZZFN0Vp6jopTpvm21MFRTWNEW5AeCPArAELSSeSmWPeQ682zuKnGXDIo+VMPpRRrFPl
         PQZA==
X-Gm-Message-State: AOJu0YzC0Tj9ccORPPauyw55dfb1+Sh2xXRkGXakJNaj+CPmwQfjQ5W2
        3ZELCamIbMomJJAfGmOjbxv6dQ==
X-Google-Smtp-Source: AGHT+IE37xNQ1PNI1ZTi31vf3M1OMcSN8bEeLxMU3Z3hZ/5we4zJ+aAbyZH0DVkyGOqEozLn7LRjbQ==
X-Received: by 2002:adf:e3cd:0:b0:32d:d879:1c3 with SMTP id k13-20020adfe3cd000000b0032dd87901c3mr4180617wrm.31.1699525498376;
        Thu, 09 Nov 2023 02:24:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4cc7000000b0032fa66bda58sm7074001wrt.101.2023.11.09.02.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:24:57 -0800 (PST)
Message-ID: <f58c8f3f-7b34-47e7-a33a-bddb6106fec7@linaro.org>
Date:   Thu, 9 Nov 2023 11:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: clock: rk3588: export PCLK_VO1GRF clk
 id
Content-Language: en-US
To:     zhangqing <zhangqing@rock-chips.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, mturquette@baylibre.com,
        sboyd@kernel.org, kever.yang@rock-chips.com, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com, andy.yan@rock-chips.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20231108061822.4871-1-zhangqing@rock-chips.com>
 <20231108061822.4871-4-zhangqing@rock-chips.com>
 <20231108-donation-uncertain-c4d0f560c420@spud>
 <2e520a06-0ff1-76ef-2a72-ab6663738b45@rock-chips.com>
 <20231109-send-pushchair-45b37551102a@wendy>
 <a11c847c-4f95-ea7b-3497-6ada0586c486@rock-chips.com>
 <dee8031f-d739-442c-988c-3df61d92c0d3@linaro.org>
 <f013df81-670e-37c4-c1a7-e1302352ca20@rock-chips.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f013df81-670e-37c4-c1a7-e1302352ca20@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 11:05, zhangqing wrote:
> 
> 在 2023/11/9 17:21, Krzysztof Kozlowski 写道:
>> On 09/11/2023 09:06, zhangqing wrote:
>>> 在 2023/11/9 15:29, Conor Dooley 写道:
>>>> On Thu, Nov 09, 2023 at 02:27:38PM +0800, zhangqing wrote:
>>>>> Hi:
>>>>>
>>>>> 在 2023/11/8 20:01, Conor Dooley 写道:
>>>>>> On Wed, Nov 08, 2023 at 02:18:21PM +0800, Elaine Zhang wrote:
>>>>>>> export PCLK_VO1GRF for DT.
>>>>>>>
>>>>>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>>>>>>> ---
>>>>>>>     include/dt-bindings/clock/rockchip,rk3588-cru.h | 3 ++-
>>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
>>>>>>> index 5790b1391201..50ba72980190 100644
>>>>>>> --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
>>>>>>> +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
>>>>>>> @@ -733,8 +733,9 @@
>>>>>>>     #define ACLK_AV1_PRE			718
>>>>>>>     #define PCLK_AV1_PRE			719
>>>>>>>     #define HCLK_SDIO_PRE			720
>>>>>>> +#define PCLK_VO1GRF			721
>>>>>>> -#define CLK_NR_CLKS			(HCLK_SDIO_PRE + 1)
>>>>>>> +#define CLK_NR_CLKS			(PCLK_VO1GRF + 1)
>>>>>> This definition is part of the ABI, if it is safe to change it, then it
>>>>>> is safe to delete it.
>>>>> The new ID is to solve the niu clock dependency problem(Used in PATCH V5
>>>>> 4/4).This new ID will also be used in DTS in the future.
>>>>>
>>>>> CLK_NR_CLKS represents the number of clocks used by the
>>>>> drivers/clk/rockchip/clk-rkxxx.c. It is safe to modify it, but cannot delete
>>>>> it.
>>>> Then delete it from the header and move it to clk-rkxxx.c
>>> I don't think it's more appropriate to move to clk-rkxxx.c.
>>> Because if there are new requirements later, and add new clk id, it is
>>> not in the same file, maybe forget to modify CLK_NR_CLKS.
>> Then you are not allowed to change it. It's part of ABI.
> 
> If you just don't want me to modify CLK_NR_CLKS, can I use an unused ID, 
> like [PATCH V4 3/4]:
> 
> -#define MBIST_MCLK_PDM1                        24
> +#define PCLK_VO1GRF                    24

You cannot change the ABI.

I don't understand why do you insist on this path. You got clear
comments: either this is ABI, so it cannot be changed, or it has to be
dropped. You know insist on some third path. There is no such.

Best regards,
Krzysztof

