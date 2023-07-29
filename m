Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F9767F01
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjG2MGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjG2MGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:06:21 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EF4212B;
        Sat, 29 Jul 2023 05:06:19 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8F322420F1;
        Sat, 29 Jul 2023 17:06:14 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690632376; bh=R0KZMvOhnM+yv/uaZVh6BLbdlwssU/v47ML/OJSRJ8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AMOPdQNeI1aQCNcAU2/jrxjsKVr8sqdyskaE35fdHHV+gaWHE4f9s7O8TN5xI2ZVm
         hNTG0DfRpJ+3j9nfLzMngThsRBuwHIPf0j7JCoiKEwImpNY3t1i6NHgqiFloVLaPH+
         7M0BE3WyhS4oH61TqWwm0bE2ixyk6m9sQaTyTNOHl9gYCTl/Sj3N8kDBbA0arjB1Ay
         FAM99S812cwEPTE3RPV/WNfEvO/K8oT4c25HWXZDpdf/UhTRa+9X53jRexA8yqqgoN
         aiL8jxA67WnZnd/Su0lgpu2uVzgu4wJ4RmFeu6bpzHXZ34OK6FkuHiEh+jw0hMnjHh
         R2oM1EJt2KWYg==
MIME-Version: 1.0
Date:   Sat, 29 Jul 2023 17:06:14 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Conor Dooley <conor@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
In-Reply-To: <20230729-facecloth-trembling-3311ca245505@spud>
References: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
 <20230728-pm8916-bms-lbc-v1-1-56da32467487@trvn.ru>
 <20230729-facecloth-trembling-3311ca245505@spud>
Message-ID: <25e933dc3f28fd73a9b76f172dacfdb2@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley писал(а) 29.07.2023 15:03:
> On Fri, Jul 28, 2023 at 10:19:30PM +0500, Nikita Travkin wrote:
>> Qualcomm Voltage Mode BMS is a battery monitoring block in PM8916 PMIC.
>> Document it's DT binding.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  .../bindings/power/supply/qcom,pm8916-bms-vm.yaml  | 64 ++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml
>> new file mode 100644
>> index 000000000000..455973d46862
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/qcom,pm8916-bms-vm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Voltage Mode BMS
>> +
>> +maintainers:
>> +  - Nikita Travkin <nikita@trvn.ru>
>> +
>> +description:
>> +  Voltage Mode BMS is a hardware block found in some Qualcomm PMICs
>> +  such as pm8916. This block performs battery voltage monitoring.
>> +
>> +allOf:
>> +  - $ref: power-supply.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,pm8916-bms-vm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: FIFO update done
> 
> You don't need items: here since you only have one - const: will do.
> 

Ack.

>> +  interrupt-names:
>> +    items:
>> +      - const: fifo
> 
> Same here, but do you really need a name, when you have only one
> interrupt?
> 

Hm, thinking of this more, the hardware actually has more than one
interrupt, even though this one seems to be the only really useful
one. Would a better way forward be to list all of them (and fix
the driver to get the value by it's name) or it would be
acceptable to leave the names here and extend the list at a later
date when (if ever) other interrupts are needed?

Thanks for the review!
Nikita

> Thanks,
> Conor.
> 
>> +
>> +  monitored-battery: true
>> +
>> +  power-supplies: true
>> +
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +  - monitored-battery
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    pmic {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      battery@4000 {
>> +        compatible = "qcom,pm8916-bms-vm";
>> +        reg = <0x4000>;
>> +        interrupts = <0x0 0x40 4 IRQ_TYPE_EDGE_RISING>;
>> +        interrupt-names = "fifo";
>> +
>> +        monitored-battery = <&battery>;
>> +        power-supplies = <&pm8916_charger>;
>> +      };
>> +    };
>>
>> --
>> 2.41.0
>>
