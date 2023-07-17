Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4B756D00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGQTSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGQTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:18:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BA1B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:18:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb7589b187so7804786e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689621506; x=1692213506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7XTOZSfFrkx226PS4u9KRX8lwqSl60Sf16zxVQzaqY=;
        b=dTUZGKzV6bxY/9uV1wKYE19Q7F2MG58qHZFvkTTbMZ91qpsJVdhHVv7URystYI43f2
         OtsFwTJjyODjCbyqjlQGcgVgnV4hd7N5MG68mzQh96I7IucdZZCGvfAzauxj2kdBJpSU
         ld4Vf37bzlm61jNg14snMgY+0qLii4V2BUaIrZp3t3BB4ZcM5fQh+Due0DF03QzDxnwU
         258LsVDc/lOoo3q1OFv9qOj6Ek+YB4d/mcPvavfQ98Gspaa/EEpOUqqdqdaz+7BHICMM
         p3S6uENgkvxQgmOCpdaEF2KU/v0Olleiv0hitvtiy+uS5Ik5LPnfPxnaL3CeTnK1hHSI
         3xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621506; x=1692213506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7XTOZSfFrkx226PS4u9KRX8lwqSl60Sf16zxVQzaqY=;
        b=JHBwgqrP2x22tWOrLze/v4MVgkaCbVumTxnGQ7BibyT9TyldVoTtqirG5xgjGq2oF/
         SuOESH4AX0l4GTo9uFvZ3Yq3gaM1s0kltzwKbZXAEWvS5gUKTjm3VjdEngSKstEO/vYd
         GGs7kaggueQQUq4jgU10D6QpJUrtu4ZN4rPKOqeP4NsZXqHcuipHcPb8h7kSnriF5rhc
         mK3kqnsqmq/7zMeVkGwTFs8ELWNaMPcLxm76CLTHo8BxkufoeF34UddZZZnreEIwRTu2
         gkcVjavD1aeROq3HD1mAogpUfl7dHuEngyf9oaav/Y1lYAve0ezJewZURCXlf7jdganY
         SSRw==
X-Gm-Message-State: ABy/qLYQa5twzyMSldcUa1araIKZBnDm96yMYuMNFMn2ai2EG/DGm37m
        SBTN7JxacWXr7iD4BZ0aM2ojKw==
X-Google-Smtp-Source: APBJJlEzJrhwbUmixh9VLrPUhgvmGvqCesf8iMHx4lvt2fb32ekuylkBPaMLscNMj1gqk8rsR1ZVBQ==
X-Received: by 2002:a05:6512:2313:b0:4f9:51b7:a19c with SMTP id o19-20020a056512231300b004f951b7a19cmr10614450lfu.19.1689621506167;
        Mon, 17 Jul 2023 12:18:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id x22-20020ac25dd6000000b004fbab1f023csm50300lfq.138.2023.07.17.12.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:18:25 -0700 (PDT)
Message-ID: <9b28a17a-fe9c-3ff0-fa1d-320e75e174d0@linaro.org>
Date:   Mon, 17 Jul 2023 21:18:21 +0200
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZLV5CirE8CZfCjkX@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2023 19:23, Stephan Gerhold wrote:
> On Mon, Jul 17, 2023 at 07:11:33PM +0200, Konrad Dybcio wrote:
>> On 17.07.2023 18:56, Stephan Gerhold wrote:
>>> On Mon, Jul 17, 2023 at 06:50:18PM +0200, Konrad Dybcio wrote:
>>>> On 17.07.2023 18:28, Stephan Gerhold wrote:
>>>>> On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
>>>>>> The GPU_CC block is powered by VDD_CX. Describe that.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>> index 29b5b388cd94..bfaaa1801a4d 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
>>>>>>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>>>>>  				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
>>>>>>  				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
>>>>>> +			power-domains = <&rpmpd SM6115_VDDCX>;
>>>>>> +			required-opps = <&rpmpd_opp_low_svs>;
>>>>>
>>>>> Where is this required-opp coming from? The clocks in gpucc seem to have
>>>>> different voltage requirements depending on the rates, but we usually
>>>>> handle that in the OPP tables of the consumer.
>>>> The only lower levels defined for this SoC are VDD_MIN and VDD_RET,
>>>> but quite obviously the GPU won't work then
>>>>
>>>
>>> The levels needed for the GPU clocks to run should be in the GPU OPP
>>> table though, just like e.g. sdhc2_opp_table for the SDCC clocks.
>>>
>>> I still don't really understand why this is specified here. :)
>> The GPU_CC block needs this rail to be at a certain power level for
>> register access. This describes that requirement.
>>
> 
> Can you show where this is defined downstream? On a quick look I didn't
> see something like that anywhere. Or is this from some secret
> documentation?
As far as downstream goes, you can notice that no branch's or RCG's
vdd tables ever define a level lower than the one I mentioned.

Konrad
