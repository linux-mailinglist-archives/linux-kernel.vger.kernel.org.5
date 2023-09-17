Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18347A3448
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjIQI01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjIQI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:26:21 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4C130;
        Sun, 17 Sep 2023 01:26:15 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id DFDE0408E9;
        Sun, 17 Sep 2023 13:26:09 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694939170; bh=RnwYYmjMyyRIV1V1HDGTWtsAia7F8WWhWq4msK/d1oM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mDHgyjKbYa9HZUOkBW+Bcserl/b0Qx+Drh8mL2L6zO0Lw28VynpTQOIoYmpnsr/av
         VwJVZYn017n1y+oOvxz1c9H7gSrqHfI+20gfyQ0Bn6ab7Oy2xE9RDUo+30f+knGlHN
         5iY4TvN4hLRQxCTG22SrVAywiohM+09mM9LL7fxMBrm4xjGJvAM1SHSeQRm9EeoEho
         5ODlTjBfqX6mqBQLw6hkuYAUkAwVvHoD0sn7kD3zVdIctfHnILLI1Z+Lis6a7bsMdw
         keq8IxFDhm1dLqHEnNt28pIaiEuGOzjWVfRaUz5e8DQhcrQVFyJUgjBG71RgfMH+qT
         BsvGntsMr236A==
MIME-Version: 1.0
Date:   Sun, 17 Sep 2023 13:26:08 +0500
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
In-Reply-To: <18bef7a4-608b-9ba3-ce8f-ca25999705c3@linaro.org>
References: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
 <20230916-pm8916-dtsi-bms-lbc-v1-1-7db0b42f9fb1@trvn.ru>
 <18bef7a4-608b-9ba3-ce8f-ca25999705c3@linaro.org>
Message-ID: <fac4a27d08108bd6e902ba0fa4708ec4@trvn.ru>
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

Krzysztof Kozlowski писал(а) 17.09.2023 12:58:
> On 16/09/2023 15:57, Nikita Travkin wrote:
>> PM8916 (and probably some other similar pmics) have hardware blocks for
>> battery monitoring and charging. Add patterns for respecive nodes so the
> 
> typo: respective
> 

Oops, will fix if we get to v2.

>> dt for those blocks can be validated properly.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>> Schemas for those devices were added in [1].
> 
> "Dependency"
> 

You are right, will try to word it better next time.

>>
>> [1] https://lore.kernel.org/r/20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru
>> ---
>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> index 9f03436b1cdc..8bcd76748faa 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> @@ -133,9 +133,15 @@ patternProperties:
>>      type: object
>>      $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
>>
>> +  "^battery@[0-9a-f]+$":
>> +    type: object
>> +    oneOf:
>> +      - $ref: /schemas/power/supply/qcom,pm8916-bms-vm.yaml#
> 
> That's just ref, so no need for oneOf... unless you already think this
> will grow with different schemas like the charger below?
> 

Yes, I think some other PMICs have different battery/fuel-gauge
blocks too so I'd like to have some room for expansion here.

Thanks for the review!
Nikita

>> +
>>    "^charger@[0-9a-f]+$":
>>      type: object
>>      oneOf:
>> +      - $ref: /schemas/power/supply/qcom,pm8916-lbc.yaml#
>>        - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
>>        - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
>>        - $ref: /schemas/power/supply/qcom,pmi8998-charger.yaml#
>>
> 
> Best regards,
> Krzysztof
