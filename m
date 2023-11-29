Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836B67FCC69
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376727AbjK2BnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2BnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:43:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507FEF5;
        Tue, 28 Nov 2023 17:43:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c115026985so5991569b3a.1;
        Tue, 28 Nov 2023 17:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701222209; x=1701827009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iT90c21pyrsUl0yRSolDbsHY6gNhOwvDglDwx9J8xk=;
        b=bN6dJ4tyl/krsgMQgyeptNNFgQSclRWCp+B0LtEbI4sL2RyuXp2QF1a/lBHC5PgyDJ
         8Mi2qdWxbjEMiq/m61v5dSUtfdqK9yb5TFA3NmKYPn2P5IminWL+V/s1YWh5vkWUiY92
         bCWaWNZUQVrnb38l5Fa+6X6KMOmR48WoQDowFL7ge575E/r05/LrEv++Y689N/Nf4319
         N97vkd3pCD19M3FNhFl3TnIOjlzYed8nLxlYueI5KKjKfXJyPNWYu+bpS4mlZfm1ApNX
         CK3aX5Yu0C0GMkAl0/tnVWUiIgMKoOKlHlWdeAlZNDvWjN7KJ3zsgLU7+KEV8ocW0h2W
         EjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701222209; x=1701827009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iT90c21pyrsUl0yRSolDbsHY6gNhOwvDglDwx9J8xk=;
        b=KqqOHEgaH9vHzuWRwRwSf3W42VxSgT/b0dTwCnmAffz/vXxg1e/0mv1upCEQuhquku
         JqwrjrW/sdI+IU9oSCo62/I+c1iqHGF1ZCB+jsmuftPcOAwzKdYHs3gqbwX7rZgguqKU
         yWkNzu2G4Gj3vEzwxxmVRMHut4CFDgGjcCtKvnZYFnR8wj028Mm5Mlp9kJ6AMXLaOs34
         C7RjRVlEzJP1jTA9R9xuoGy5iM4OzT+B4TL3A/5XxghgFxyYeNgAqC8qrTNOdQ2Q7GiN
         2yKhjf0gv1oWSI8EmYmCV+tGmYCqIkXinA0mimJ9V+MMS27kgPTu+x1iw/UbJKp8/x7z
         BY4w==
X-Gm-Message-State: AOJu0Yz/aVFb1aU9m2dmhfqTUuiORFiUB86saMAOu5Qs2VO4Q2xf/UTk
        BNqTBu4OqITOnFnIKWyFQtE=
X-Google-Smtp-Source: AGHT+IF1HFKSrLZGJUXNWMIpuVB0MTPE7TOXj4Rob4KrWH8A43EbOW/4Oe2ImDH3ga07LrCnj9W6XQ==
X-Received: by 2002:a05:6a00:3909:b0:6be:130a:22a0 with SMTP id fh9-20020a056a00390900b006be130a22a0mr18890678pfb.14.1701222208657;
        Tue, 28 Nov 2023 17:43:28 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id fh20-20020a056a00391400b006bb5ff51177sm9610454pfb.194.2023.11.28.17.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 17:43:28 -0800 (PST)
Message-ID: <428082d9-474b-4dfc-90b0-f739a35a1f48@gmail.com>
Date:   Wed, 29 Nov 2023 09:43:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: nuvoton: Add pinctrl support for
 ma35d1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-4-ychuang570808@gmail.com>
 <18276c95-26e8-4b07-8351-7555d7595f7c@linaro.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <18276c95-26e8-4b07-8351-7555d7595f7c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thanks for your review.

On 2023/11/28 下午 07:03, Krzysztof Kozlowski wrote:
> On 28/11/2023 07:11, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
> ...
>
>>   
>>   		sys: system-management@40460000 {
>> -			compatible = "nuvoton,ma35d1-reset";
>> +			compatible = "nuvoton,ma35d1-reset", "syscon";
>>   			reg = <0x0 0x40460000 0x0 0x200>;
>>   			#reset-cells = <1>;
>>   		};
>> @@ -95,6 +96,162 @@ clk: clock-controller@40460200 {
>>   			clocks = <&clk_hxt>;
>>   		};
>>   
>> +		pinctrl: pinctrl@40040000 {
>> +			compatible = "nuvoton,ma35d1-pinctrl";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			nuvoton,sys = <&sys>;
>> +			ranges = <0x0 0x0 0x40040000 0xc00>;
>> +
>> +			gpioa: gpio@40040000 {
>> +				reg = <0x0 0x40>;
> Your unit address does not match reg.
>
> You must test your DTS with `dtbs_check W=1`.
>
>
>> +				interrupts = <GIC_SPI  14 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPA_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>
> Best regards,
> Krzysztof
>

"OK, I will fix 'gpioa: gpio@40040000' to 'gpioa: gpio@0', and similarly 
for gpiob to gpion. I will also eliminate all redundant spaces behind 
GIC_SPI." Best Regards, Jacky Huang
