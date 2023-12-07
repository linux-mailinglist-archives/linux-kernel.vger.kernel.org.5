Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E994F80887F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379472AbjLGMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjLGMwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:52:14 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2ED7F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:52:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b3ffaso1259660a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701953538; x=1702558338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2V1Nu5Y3M7B3c5KtqzFbEZA29nzyhwL2JmdTIY4szc=;
        b=YjprtQhldkfGAJQNy+UfThmCa4zhfZy8zfBGmy0amyLBlUpOVW31nzw0iUEt0Mrxlm
         bvBt6l/NCZUXbhLM85TvTPashgXcx64ml1oPYFaLSctGBatzTlB0Tcz5v+ZiWmDIZimu
         EZNq2vlj/oegIa+9DSvGzHOSzcy0+snm8QxlETItcbNqkEjnKYUNWTsn1HVfX1zjPXbx
         m/Eq9iB7LbuMVN5UXAuKiRE32lXzmKeXKk6TG491opKuHzUQHvISHkc5u/BXmpsRL+N6
         jkXKEElcDh4+2hq5n5lTKv1LhE3rwjm8CsZWiH2ZNQMcOSQtWh0OQAEkXQ18a88ax9zx
         kC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953538; x=1702558338;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2V1Nu5Y3M7B3c5KtqzFbEZA29nzyhwL2JmdTIY4szc=;
        b=li0WOkjs7Qty9H8gP6L6Cd/LXJMmckBfLD3LcZn6St3aXDBoM2LDB23rrwRlJQgtkw
         cmoN8/3BMgVOLxCnlRqSXsbY+2vgYTd40qGhxrcLL/uPdNJQrTOKIrpkdCBfWqo8vrbw
         RCiAqf/lmZKrMUJS6jYJ7QQ0Uje54qk6W5Ktc1Af3cA6SrifAYhiXz7pdoDU5kdNkpYj
         GWYsvn+v2sOd3QdrRtfeDGvwfekNqPhiocjaxpIqFER5LaoyHge6hMjkeRYZRqFseGVU
         AFMlQ/OkYfYQjcYjHMmTSSBzlhdla0rNvXJYJemoo9M9ut3yxj+sY21ywxQ0TCFvhxlY
         oCZQ==
X-Gm-Message-State: AOJu0Yz5T1jZM1qe/3RXINW3I59MHV1iauY5a9dNuPg3rQPT9ESmFGhZ
        RWwaI4yfwuNNGwsJMgH+48Jikg==
X-Google-Smtp-Source: AGHT+IFht54XAvdFOQ/lNFTSE16Z0z3a5hJ4XsdAOJVB02lM8AR5iw4enjeAPcl2cN19a5tGdwNr6Q==
X-Received: by 2002:a50:8d53:0:b0:54c:a676:d1de with SMTP id t19-20020a508d53000000b0054ca676d1demr1377196edt.60.1701953538552;
        Thu, 07 Dec 2023 04:52:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id er9-20020a056402448900b0054c6a70a435sm736766edb.44.2023.12.07.04.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 04:52:18 -0800 (PST)
Message-ID: <375bb6e4-18dc-4f54-9a06-6f9f2ba0a0ec@linaro.org>
Date:   Thu, 7 Dec 2023 13:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] riscv: dts: sophgo: add clock generator for Sophgo
 CV1800 series SoC
Content-Language: en-US
To:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Liu Gui <kenneth.liu@sophgo.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        qiujingbao.dlmu@gmail.com, dlan@gentoo.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <f9db367c-a96b-4789-9884-f2062499765a@linaro.org>
 <IA1PR20MB49531D4EFD4626834B5C604ABB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <IA1PR20MB49531D4EFD4626834B5C604ABB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 10:42, Inochi Amaoto wrote:
>>> +&clk {
>>> +	compatible = "sophgo,cv1810-clk";
>>> +};
>>> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> index 2d6f4a4b1e58..6ea1b2784db9 100644
>>> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> @@ -53,6 +53,12 @@ soc {
>>>  		dma-noncoherent;
>>>  		ranges;
>>>
>>> +		clk: clock-controller@3002000 {
>>> +			reg = <0x03002000 0x1000>;
>>> +			clocks = <&osc>;
>>> +			#clock-cells = <1>;
>>
>> I don't find such layout readable and maintainable. I did some parts
>> like this long, long time ago for one of my SoCs (Exynos54xx), but I
>> find it over time unmaintainable approach. I strongly suggest to have
>> compatible and other properties in one place, so cv1800 and cv1812, even
>> if it duplicates the code.
>>
> 
> Hi Krzysztof:
> 
> Thanks for your advice, but I have a question about this: when I should
> use the DT override? The memory mapping of the CV1800 and CV1810 are
> almost the same (the CV1810 have more peripheral and the future SG200X
> have the same layout). IIRC, this is why conor suggested using DT override
> to make modification easier. But duplicating node seems to break thiS, so
> I's pretty confused.

Go with whatever your subarchitecture and architecture maintainers
prefer, I just shared my opinion that I find such code difficult to read
and maintain.

Extending node with supplies, pinctrl or even clocks would be readable.
But the compatible: no. The same applies when you need to delete
property or subnode: not readable/maintainable IMHO.

Best regards,
Krzysztof

