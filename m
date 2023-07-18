Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3182C757C27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGRMsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjGRMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:48:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B32126
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:47:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso51680911fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689684478; x=1692276478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+fpBsnE5go0f1t1rc3yenivCXFLqTDod2bLdDrF20I=;
        b=sxOl1Km89lkK1KQq/bEGKvyyw4dpGPYi4aiiVdbH/zkiPGj8SC4tRu8ZGg0CA3P5gk
         R0iB8Fsg4FJx49LQPwxVw5/antraWEl1QEO18pUq6Bu7eudaI/z+1UopXAxS4Ovt+eNF
         H/uSbgo05syy4+EuK6+7GbMvQcC5ZChb5kQwa8Zo15ahYbvRrKeoPCL+eoaQy92PjdPN
         lUlIHlM61PcYM6SqBXiSVoSPbt4n/j2lE0JMfGJuB4ffy35CHh1+LwQmwGi+oi+0qdx3
         ZinXr2w9TzyBkK5swWcMGbX9XciYMuN9xFmXhHNMJ7u/XJfas3T+CF93C805hnLDzQls
         jSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684478; x=1692276478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+fpBsnE5go0f1t1rc3yenivCXFLqTDod2bLdDrF20I=;
        b=ZdBGpEGMGOOEje8sqfClafqrzRYRDZBDOqQPZkSVwz5sx2tEqWjdire6yaOjkgv7U1
         QzQHHEAOwdslBxG5hfKf6wSDt6G5Qy/vrWr0xU5+0DybXTJ10utXFtW7KfMHfPEv+OsM
         SkITlOiAOGnRGNuFDp/KAYOGpuPZqqDAjba35aIF2bBZhVkL9XxXC/HsL1bI6c/3d3Le
         2PCcUTO/IznDg/q30J0gFacbS9NUymtTMrbZfg4Itna4fVTqVUx5d730ctoULMP0Az6O
         0AfM/erqAdryMWR1cnGvUXsmQS2L4DdWnz2DhDb/i97/lKuW8c1Zs47EPG57vjrkK/4o
         RJbw==
X-Gm-Message-State: ABy/qLYsS2le0laJYbkVBU8K+w8hg1a+ZBKc+0oCeQ8puP3J/lOq4yBQ
        aHNzNnrD9wzEfvPkCRX/nnxrL897EO/0Kmk1wDtx2A==
X-Google-Smtp-Source: APBJJlHaYF1oYWvL6+djJSqNXrsysizzv/7ID3YezX+m9Y7pnf78BNgH+IRF/nLhqba1MYG8P6eq3w==
X-Received: by 2002:a2e:7a01:0:b0:2b7:a64:91bd with SMTP id v1-20020a2e7a01000000b002b70a6491bdmr14333345ljc.35.1689684478146;
        Tue, 18 Jul 2023 05:47:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id x11-20020a2e838b000000b002b6ec3d4a53sm479605ljg.50.2023.07.18.05.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:47:57 -0700 (PDT)
Message-ID: <d087d0df-0bf6-c93a-7999-f9385ebb7a38@linaro.org>
Date:   Tue, 18 Jul 2023 14:47:55 +0200
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
 <8c5dc146-c305-bef9-0d97-76a91345ed1a@linaro.org>
 <ZLV5CirE8CZfCjkX@gerhold.net>
 <9b28a17a-fe9c-3ff0-fa1d-320e75e174d0@linaro.org>
 <ZLZ94Qc6x1HyjJPQ@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZLZ94Qc6x1HyjJPQ@gerhold.net>
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

On 18.07.2023 13:56, Stephan Gerhold wrote:
> On Mon, Jul 17, 2023 at 09:18:21PM +0200, Konrad Dybcio wrote:
>> On 17.07.2023 19:23, Stephan Gerhold wrote:
>>> On Mon, Jul 17, 2023 at 07:11:33PM +0200, Konrad Dybcio wrote:
>>>> On 17.07.2023 18:56, Stephan Gerhold wrote:
>>>>> On Mon, Jul 17, 2023 at 06:50:18PM +0200, Konrad Dybcio wrote:
>>>>>> On 17.07.2023 18:28, Stephan Gerhold wrote:
>>>>>>> On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
>>>>>>>> The GPU_CC block is powered by VDD_CX. Describe that.
>>>>>>>>
>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>>> ---
>>>>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>>> index 29b5b388cd94..bfaaa1801a4d 100644
>>>>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>>> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
>>>>>>>>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>>>>>>>  				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
>>>>>>>>  				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
>>>>>>>> +			power-domains = <&rpmpd SM6115_VDDCX>;
>>>>>>>> +			required-opps = <&rpmpd_opp_low_svs>;
>>>>>>>
>>>>>>> Where is this required-opp coming from? The clocks in gpucc seem to have
>>>>>>> different voltage requirements depending on the rates, but we usually
>>>>>>> handle that in the OPP tables of the consumer.
>>>>>> The only lower levels defined for this SoC are VDD_MIN and VDD_RET,
>>>>>> but quite obviously the GPU won't work then
>>>>>>
>>>>>
>>>>> The levels needed for the GPU clocks to run should be in the GPU OPP
>>>>> table though, just like e.g. sdhc2_opp_table for the SDCC clocks.
>>>>>
>>>>> I still don't really understand why this is specified here. :)
>>>> The GPU_CC block needs this rail to be at a certain power level for
>>>> register access. This describes that requirement.
>>>>
>>>
>>> Can you show where this is defined downstream? On a quick look I didn't
>>> see something like that anywhere. Or is this from some secret
>>> documentation?
>> As far as downstream goes, you can notice that no branch's or RCG's
>> vdd tables ever define a level lower than the one I mentioned.
>>
> 
> As far as I can tell the vdd tables are only used when the clock is
> actually enabled though, not for writing to registers while they are
> disabled.
Maybe, but you can also notice that even XO rates require at least
SVS_LOW to function.

Konrad
