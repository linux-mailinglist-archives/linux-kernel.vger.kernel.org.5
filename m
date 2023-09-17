Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31C87A34B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjIQIyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjIQIys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:54:48 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7911186;
        Sun, 17 Sep 2023 01:54:42 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 26B77408E9;
        Sun, 17 Sep 2023 13:54:40 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694940880; bh=zGA3bn2I6aIG1camvyuPV4ppUOrnRMOzLfdsDkjVc9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GYSyBN7fl2zAnhLH0wmyTgp8UCcb4dp3Z8GAr+Ok6KSct1PFGjHCktMg9voUVPGht
         0d8cJeMG6L+sWUsaJ5Pss7hOxQ/p9s4HyBJZClnW0axnA7mCWpzYSGt+DEFSWzub+U
         B9pjA2jxX7KeLXlq2Aqff1OtoyMXrgHVqlBd65oXWZjeM+MY2JXi+CysheDwqz5ypH
         Md/bS2CTXBsWef8v6QC5hrZThRGffs+4rEQq+YX+YnkJuKBkhE44P8bNE/4cEwMyY9
         0+osf62pe14Sh2Zl8mSUZ5guEtVGrDVIKWo4MnotGYEB27/jKWT6tQgvISgJ7bPoix
         qxB3Qdr0YI65w==
MIME-Version: 1.0
Date:   Sun, 17 Sep 2023 13:54:39 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms
 and lbc
In-Reply-To: <011074e5-cec2-1c69-7324-30d9ab653577@linaro.org>
References: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
 <20230916-pm8916-dtsi-bms-lbc-v1-1-7db0b42f9fb1@trvn.ru>
 <18bef7a4-608b-9ba3-ce8f-ca25999705c3@linaro.org>
 <fac4a27d08108bd6e902ba0fa4708ec4@trvn.ru>
 <011074e5-cec2-1c69-7324-30d9ab653577@linaro.org>
Message-ID: <27adb905b990398989b4c13f03339ae9@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 17.09.2023 13:32:
> On 17/09/2023 10:26, Nikita Travkin wrote:
>> Krzysztof Kozlowski писал(а) 17.09.2023 12:58:
>>> On 16/09/2023 15:57, Nikita Travkin wrote:
>>>> PM8916 (and probably some other similar pmics) have hardware blocks for
>>>> battery monitoring and charging. Add patterns for respecive nodes so the
>>>
>>> typo: respective
>>>
>>
>> Oops, will fix if we get to v2.
>>
>>>> dt for those blocks can be validated properly.
>>>>
>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>> ---
>>>> Schemas for those devices were added in [1].
>>>
>>> "Dependency"
>>>
>>
>> You are right, will try to word it better next time.
>>
>>>>
>>>> [1] https://lore.kernel.org/r/20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru
>>>> ---
>>>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>>>> index 9f03436b1cdc..8bcd76748faa 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>>>> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>>>> @@ -133,9 +133,15 @@ patternProperties:
>>>>      type: object
>>>>      $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
>>>>
>>>> +  "^battery@[0-9a-f]+$":
>>>> +    type: object
>>>> +    oneOf:
>>>> +      - $ref: /schemas/power/supply/qcom,pm8916-bms-vm.yaml#
>>>
>>> That's just ref, so no need for oneOf... unless you already think this
>>> will grow with different schemas like the charger below?
>>>
>>
>> Yes, I think some other PMICs have different battery/fuel-gauge
>> blocks too so I'd like to have some room for expansion here.
> 
> There is always room. Which other device will have different battery
> charger?
> 

I know of non-"VM" BMS block in PM8226. It's used on some Nokia
devices that people were working on so I expect it to appear in
the future.

There is also some BMS block in more modern PM6150 that I've
seen being looked at by people interested in bringing sm7125
phones upstream.

Both of those, to my knowledge, are completely different from
this VM-BMS block, which I believe was present in the generation
of pm8916, pm8909 and was abandoned again shortly after...

Nikita

> Best regards,
> Krzysztof
