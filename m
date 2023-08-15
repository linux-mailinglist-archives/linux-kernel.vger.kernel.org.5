Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42D77D526
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbjHOVdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbjHOVd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EDE19A7;
        Tue, 15 Aug 2023 14:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58657611F6;
        Tue, 15 Aug 2023 21:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B34EC433C8;
        Tue, 15 Aug 2023 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692135204;
        bh=tSSjd9zP2JKBKWarDV0Over61ZxmhPsZ5nxubi2sdJs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=so6Dk9Hk3okHK2uXoZLQSaH58woPs7WLiKNF4MDdxc8lAbiYG3o7Ea+fOPq2Prtp5
         fsPF6UalVezne3XQNQ4C0AUxMdFdqS3nGpWHvTJWUeZzP6I9jhN2lGprZYD3NkxoIW
         vhTpG5epc5H+R3K2ZLfgiEUvfrPfebGPAMcQ9zfmBZJ8rNlz1MlY5Zd3CaiA9wO3k+
         1lw4di6AVDK2BTYRAIhC+hIO4E9IUnNQm5+jrwaASO0IXYwapQPoMpNJ8IH6UtJmii
         N4dVyGrM8LElDSRKqZVMW2tWexULIAkHR3Coc6fIY036DcIhiolb0i16v4KKEqEeBh
         RB6hgrFJwPoHg==
Message-ID: <aa699c29-6e63-cbf6-b6ee-1fad76478036@kernel.org>
Date:   Tue, 15 Aug 2023 23:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: add WDT
To:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230815141908.1084893-1-robimarko@gmail.com>
 <20230815141908.1084893-2-robimarko@gmail.com>
 <3174c398-a19a-3b59-c2fc-3ec9a5e1a9df@linaro.org>
 <CAOX2RU6HYBzhh0TBdsFj5AJPwqdv2xQ=XsA=L-BaCwNUxTx2Vg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAOX2RU6HYBzhh0TBdsFj5AJPwqdv2xQ=XsA=L-BaCwNUxTx2Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 17:38, Robert Marko wrote:
> On Tue, 15 Aug 2023 at 16:40, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 15/08/2023 16:17, Robert Marko wrote:
>>> Add the required DT node for WDT operation.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> index 3285c86824cf..168322bfb11c 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> @@ -182,6 +182,13 @@ v2m1: v2m@1000 {
>>>                       };
>>>               };
>>>
>>> +             watchdog: watchdog@b017000 {
>>> +                     compatible = "qcom,apss-wdt-ipq5018", "qcom,kpss-wdt";
>>> +                     interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
>>
>> I think all GIC_SPI interrupts are level high.
> 
> They are most probably using GIC-500 which supports rising edge or
> active high interrupts.
> Both the older GIC-400 and newer GIC-600 also support the same.
> 
> Vendor DTS indicates this level, IPQ8074 and IPQ6018 which use the
> same core, and it
> seems the same WDT IP use the rising edge IRQ.
> 

That's ok, but now I see missing Cc to DT, so standard message goes:

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

