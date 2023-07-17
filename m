Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDDD7569E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGQRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGQRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:11:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87579131
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:11:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b743161832so71275191fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689613896; x=1692205896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdUy8GMTrWucV9wCoA87XadPmnzE11dEz/NCrV18J1Y=;
        b=dJbijU/dso944TXJCQtlOA2upkp4Btsdngl31G428/moDy7XklV0Tmw5Z4DdWJuyH3
         8pWgnV1M3XhLgfGmo3e0PEwUN6LsTcNgpuOrt0aCJpK6EmgtPR1KyPEv+9gvRm4mZ4rk
         PZlCJ+ylonx6GqP9124mrD+ROyYHvEOrr9YiMpkEty4b4np4LzfGlEi0pa/b3zlf3BsG
         J9BSLtmommkdEIMl6oLA/QJ+Sb74YGbyRDexOSL2m+GSoumPwd94ALZq7qmy4o7g3uS1
         UFXJiF4OrrI/caD88uKrWdPvunjIRkZ0liM++9sHMudXjl32qjQ3MH79CKsLaoz5ONmz
         w9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689613896; x=1692205896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdUy8GMTrWucV9wCoA87XadPmnzE11dEz/NCrV18J1Y=;
        b=enuXoQw/QBCzPuYukoMgQZ/IQjKFb+OPsU93/FlQy5DaDqnGDksYJjyYyk9G75W+Jq
         Oxm3v2azwiKKSV44LuG9fzou7UOtjm6lIbCIcPknnKFVbz5JVl/bIY4My3osIkOrevKx
         eVjTfWjUbKmAm3YiqlQ+r1n4FriLNyaK/4kZ+iBXIAK8kCEXkDeP0JnS/MmgNJ48qFo1
         KOJ0Tkb8jJeyHcIaTChrL2CXx1sRPBI29t36KRSzY8IpB6wDBWc8dttH8JyjZFKQNvca
         dRksnl6sRk70vaE4LY/L6/5a1lVmxb+q8Fk+ztFVjrqsTaxfUj4CJLEJa+DImQoTrqPK
         ftww==
X-Gm-Message-State: ABy/qLYKXzvYSkVWQFuTUtTjZY4sWWjeR0Xa1LcEJE354f0A2etghecr
        XqsHjOc9Cp3ACgEbsCFDsbTG1w==
X-Google-Smtp-Source: APBJJlFjLae5XLO90WMwuCjsT5AeiwDRBCFEcMfuu3f7z5JblyEioCWHbbcrKv1U59DGlGuSj9ETwQ==
X-Received: by 2002:a2e:a410:0:b0:2b6:e7ce:4e7d with SMTP id p16-20020a2ea410000000b002b6e7ce4e7dmr8725246ljn.43.1689613895792;
        Mon, 17 Jul 2023 10:11:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id a23-20020a05651c011700b002b94805a043sm452ljb.138.2023.07.17.10.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:11:35 -0700 (PDT)
Message-ID: <8c5dc146-c305-bef9-0d97-76a91345ed1a@linaro.org>
Date:   Mon, 17 Jul 2023 19:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/15] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CCC
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
 <ZLVsN40kYsvQm1z6@gerhold.net>
 <a193a4dd-0a0a-0d36-6d83-0424cd1dce80@linaro.org>
 <ZLVyvHnKPdOfqAck@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZLVyvHnKPdOfqAck@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2023 18:56, Stephan Gerhold wrote:
> On Mon, Jul 17, 2023 at 06:50:18PM +0200, Konrad Dybcio wrote:
>> On 17.07.2023 18:28, Stephan Gerhold wrote:
>>> On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
>>>> The GPU_CC block is powered by VDD_CX. Describe that.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> index 29b5b388cd94..bfaaa1801a4d 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
>>>>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>>>  				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
>>>>  				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
>>>> +			power-domains = <&rpmpd SM6115_VDDCX>;
>>>> +			required-opps = <&rpmpd_opp_low_svs>;
>>>
>>> Where is this required-opp coming from? The clocks in gpucc seem to have
>>> different voltage requirements depending on the rates, but we usually
>>> handle that in the OPP tables of the consumer.
>> The only lower levels defined for this SoC are VDD_MIN and VDD_RET,
>> but quite obviously the GPU won't work then
>>
> 
> The levels needed for the GPU clocks to run should be in the GPU OPP
> table though, just like e.g. sdhc2_opp_table for the SDCC clocks.
> 
> I still don't really understand why this is specified here. :)
The GPU_CC block needs this rail to be at a certain power level for
register access. This describes that requirement.

Konrad
