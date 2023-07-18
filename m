Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3E757BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGRMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGRMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:21:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E00E56
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:21:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso9345471e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689682894; x=1692274894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMcbYQlwObKdmoguJ/6t09m79nKWr0R7fK7izdG7yQU=;
        b=uCUJB3qtrSsWhpK1EXCApHzjDcVw7hzhV+4mh3/wHPuqTM/yIhN5TcN+Bf5WcYjK8d
         lVlNHcFySHY7aQ2v0oxRmpZmM8lUumlhwVuSa3bpa+L7YgGMfRejBOuYjj/nrjp0aGvB
         xjHWLlso2u3wp6wr3IR7Kd4X9ArlbkA3jFIC97zTq/lKbJe5horolVk/N4SrqvxJos0r
         oSBJlRaNs986ZlcqMhgCme/LkIQ72GAOZz+7DVdVMReFmhqWLB9SfnBbDsj+KKTdj51Q
         DqIHD0+a4CebP06bsykV5auluC2opkv9ZLVkRIA3elOgxNMd4MQjDO7fPby2/2kNgjqf
         Girw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689682894; x=1692274894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMcbYQlwObKdmoguJ/6t09m79nKWr0R7fK7izdG7yQU=;
        b=MpbdxY0Ou1gfndnM9sh4dvgt3nRc8zc8MQRKKGdOFNd9xCAb6cDQqR+kTQU6xhbJxy
         owKCFLhjrt9Wxto0HWYFYlHTtmRv28zwgiNzdq1XewcqAGKON3sScnaXzNFiTcK1Jmtf
         bE0BwTmCCteW5f9ZVqARibbEhQaAo8INU80yzhRFeOSuUZ7buJCO9LniXh14B1bgpoDG
         YfkbgzbHvxaWTZdQiHOsbj0+Q0aRNxpOkPOVW45euR7wDbmQSE3VriAi9zdMl1gk3WmU
         PW12tsNBUI+pNCW/ilw9i94aPEUpjBj+Zp10Va5QRtmIsmrD+ixqPsawtopzYz7KMN+7
         ykhQ==
X-Gm-Message-State: ABy/qLYRlW/qr6RAw3Uj6evNyIVVZaWghpkjT/OhyI2R/9qKUZiB7GBt
        IzwzXxpJ4I8d6AztFN+bxXTP2g==
X-Google-Smtp-Source: APBJJlGe4GL0krm7OOQiJm+l9w7tSgm+QxPJv7V+vEhUqcBY/HhQ/2kae1gjm9qUqzU/LneamilPMg==
X-Received: by 2002:ac2:57ca:0:b0:4fb:97e8:bc25 with SMTP id k10-20020ac257ca000000b004fb97e8bc25mr8590146lfo.34.1689682893753;
        Tue, 18 Jul 2023 05:21:33 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id x3-20020ac259c3000000b004fcdf89080csm416068lfn.180.2023.07.18.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:21:33 -0700 (PDT)
Message-ID: <18e192cb-eafe-3aa9-6602-b1a9dbe020d5@linaro.org>
Date:   Tue, 18 Jul 2023 14:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/15] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CCC
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
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
 <zha5rmva3zhvvknnmeso6errwhkdjomk6r5d72an7moimdvymq@skow5jqtps5g>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <zha5rmva3zhvvknnmeso6errwhkdjomk6r5d72an7moimdvymq@skow5jqtps5g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2023 06:25, Bjorn Andersson wrote:
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
> And that is not the lowest level reported by command db?
> Please describe this part in the commit message as well.
command-what? ;)

RPM exports VDD_NONE (off), VDD_MIN (the lowest state before collapse)
and then low_svs is usually the lowest "actually on" state for all
consumers.

Konrad
