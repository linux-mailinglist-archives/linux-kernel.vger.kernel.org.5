Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69435757DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjGRNg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjGRNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:36:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A9E170E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:36:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so9151740e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689687398; x=1692279398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hp7UgnldNcHA7FZx3WIx9aOagNjv/KtuNEbWyENtJnA=;
        b=oGFGd0FP042iyZd37c7nyenPiJFz/AO4vwIGmPPiBLZ1+VUXrw/l4TlTmHUn9dn36i
         JsHuBXdt+NLWsVYWFCmcRuv50+1m9NNcVdmrGuly+uR1T8kb3wo5MBbvAi+l6c6ayI2E
         F8oBKCAjQwz4H/Nzs4tqRQNMvlTVxzFmFOxtYzVYVrraof3khRBj91sFyvyj8iDXTR/U
         PdDi2rrciwUTgm/fipsXPOEyelj5fijEswO55KMYmIVC2yQzOk7J6dL+R/aSP4mdCngI
         69rEkwQoBWmbi7KZuDule39Lnnz+uKmwME3zcxwK21INsGeG9AJvuWvjYZuN/hrKqNcd
         YAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687398; x=1692279398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hp7UgnldNcHA7FZx3WIx9aOagNjv/KtuNEbWyENtJnA=;
        b=TqsE1v2MpB6zUc3Rb+CumK6ydhcT9Ew1Mtu0IU6e3GCQB/rmwpuL7GENDg3lCObpV0
         XuiJlkx1LSk32nlxH2LceOhvHWhNTAmuL4DC27OvmPN1Z0PefiIsyZoQr6v6uvQiKuDs
         e7fLpYudX3yovfCRFjmq5ENSvWTsi6NpCpatWyxqFOSbzCF5S9VG0OGzBtcVIE2TzrET
         CMEmdwDZb+98iSjVJgdOc5hjeo4WTXa9KhWBxbmcdICYmThyBOuv4WermuxVXNESliq3
         uycZeL7vfQcRqrcKS9xUGqnZy5np3z/54J7tASYPZzdBgR2SrRMGr9z/N57bKzjvVDYV
         MadA==
X-Gm-Message-State: ABy/qLYc+m6ft+WXerKKkL9dIJAEdmOBlVgtmHbEc5ixIbcIVeADNTsW
        uMgCy1HkU+mudH0MkkKDT0CNhQ==
X-Google-Smtp-Source: APBJJlEgu9uSDaqhIXSpJjdBCEk3Mz4dqmv970bnu18XX0t6LiabJ0R4/28cYLVkOSADKddST27Gtw==
X-Received: by 2002:a05:6512:5c1:b0:4f8:83f:babe with SMTP id o1-20020a05651205c100b004f8083fbabemr9554309lfo.62.1689687397885;
        Tue, 18 Jul 2023 06:36:37 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id p11-20020ac246cb000000b004faa82946d8sm444846lfo.178.2023.07.18.06.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:36:37 -0700 (PDT)
Message-ID: <8c342c2b-db37-1360-c716-0e4cdf3809a7@linaro.org>
Date:   Tue, 18 Jul 2023 15:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/15] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CCC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
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
 <d087d0df-0bf6-c93a-7999-f9385ebb7a38@linaro.org>
 <CAA8EJppFaYPm33Z-_a+AgKYcWsaPE_y=B+agYVQ8z0ncfrvUAw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJppFaYPm33Z-_a+AgKYcWsaPE_y=B+agYVQ8z0ncfrvUAw@mail.gmail.com>
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

On 18.07.2023 15:08, Dmitry Baryshkov wrote:
> On Tue, 18 Jul 2023 at 15:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 18.07.2023 13:56, Stephan Gerhold wrote:
>>> On Mon, Jul 17, 2023 at 09:18:21PM +0200, Konrad Dybcio wrote:
>>>> On 17.07.2023 19:23, Stephan Gerhold wrote:
>>>>> On Mon, Jul 17, 2023 at 07:11:33PM +0200, Konrad Dybcio wrote:
>>>>>> On 17.07.2023 18:56, Stephan Gerhold wrote:
>>>>>>> On Mon, Jul 17, 2023 at 06:50:18PM +0200, Konrad Dybcio wrote:
>>>>>>>> On 17.07.2023 18:28, Stephan Gerhold wrote:
>>>>>>>>> On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
>>>>>>>>>> The GPU_CC block is powered by VDD_CX. Describe that.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>>>>> ---
>>>>>>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
>>>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>>>>> index 29b5b388cd94..bfaaa1801a4d 100644
>>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>>>>> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
>>>>>>>>>>                        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>>>>>>>>>                                 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
>>>>>>>>>>                                 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
>>>>>>>>>> +                      power-domains = <&rpmpd SM6115_VDDCX>;
>>>>>>>>>> +                      required-opps = <&rpmpd_opp_low_svs>;
>>>>>>>>>
>>>>>>>>> Where is this required-opp coming from? The clocks in gpucc seem to have
>>>>>>>>> different voltage requirements depending on the rates, but we usually
>>>>>>>>> handle that in the OPP tables of the consumer.
>>>>>>>> The only lower levels defined for this SoC are VDD_MIN and VDD_RET,
>>>>>>>> but quite obviously the GPU won't work then
>>>>>>>>
>>>>>>>
>>>>>>> The levels needed for the GPU clocks to run should be in the GPU OPP
>>>>>>> table though, just like e.g. sdhc2_opp_table for the SDCC clocks.
>>>>>>>
>>>>>>> I still don't really understand why this is specified here. :)
>>>>>> The GPU_CC block needs this rail to be at a certain power level for
>>>>>> register access. This describes that requirement.
>>>>>>
>>>>>
>>>>> Can you show where this is defined downstream? On a quick look I didn't
>>>>> see something like that anywhere. Or is this from some secret
>>>>> documentation?
>>>> As far as downstream goes, you can notice that no branch's or RCG's
>>>> vdd tables ever define a level lower than the one I mentioned.
>>>>
>>>
>>> As far as I can tell the vdd tables are only used when the clock is
>>> actually enabled though, not for writing to registers while they are
>>> disabled.
>> Maybe, but you can also notice that even XO rates require at least
>> SVS_LOW to function.
> 
> But the vdd tables are related to clock rates, which, in the upstream
> design, should be voted by the consumers, not by the clock driver.
Not all of the clocks are associated with OPP tables upstream, and it
would be nice if the clock controller block had power flowing to it
in case one wanted to access a different clock.

Konrad
