Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CDB810991
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjLMFoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjLMFoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:44:09 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D90D3;
        Tue, 12 Dec 2023 21:44:13 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 79749401B5;
        Wed, 13 Dec 2023 10:44:10 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1702446250; bh=vMUS9nUEC9yE8MKSq7Q13xga7SNG1itLZJttw52Z/VA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=byiPWoGTBddnLJgT1lIYVljWak+C42MLwkWPAfbknpNISrJiKc0FfQK4+b6vNWQwc
         rsIkFQLik/EdiCeNu39VqF7OI2SWevr4sjoxdGG5wns1RshCoo8WWy/7n76Y8ecC4Y
         85+nuPKsESb2AH7oDkhA/y2TGcaF9AcF7G0n98hqHu+EyxV4hQET7LroLeQeQnWexB
         dNwpVN3nBB9sLV3hkO9z4I/f4hdQLO7eWsYSXD7gJkgBV0ms+FV8gGfMAkFuttx6hz
         rCxvPcpQ7nKwkw1UZI7RvcqqVc1p84oNLlVU6WIEwoeIyolpxa3vwuT63dWTU8zp7X
         dHOecFLC9Hg4Q==
MIME-Version: 1.0
Date:   Wed, 13 Dec 2023 10:44:09 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Conor Dooley <conor@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
In-Reply-To: <20231212-wasp-overcoat-cf2bd1383670@spud>
References: <20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru>
 <20231212-aspire1-ec-v2-1-ca495ea0a7ac@trvn.ru>
 <20231212-wasp-overcoat-cf2bd1383670@spud>
Message-ID: <d79b9a017644004f6d6a3e182935b0f5@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley писал(а) 12.12.2023 22:24:
> Hey,
> 
> On Tue, Dec 12, 2023 at 05:49:09PM +0500, Nikita Travkin wrote:
>> Add binding for the EC found in the Acer Aspire 1 laptop.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  .../bindings/power/supply/acer,aspire1-ec.yaml     | 67 ++++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
>> new file mode 100644
>> index 000000000000..1fbf1272a00f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Acer Aspire 1 Embedded Controller
>> +
>> +maintainers:
>> +  - Nikita Travkin <nikita@trvn.ru>
>> +
>> +description:
>> +  The Acer Aspire 1 laptop uses an embedded controller to control battery
>> +  and charging as well as to provide a set of misc features such as the
>> +  laptop lid status and HPD events for the USB Type-C DP alt mode.
>> +
>> +properties:
>> +  compatible:
>> +    const: acer,aspire1-ec
>> +
>> +  reg:
>> +    const: 0x76
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  acer,media-keys-on-top:
>> +    description: Configure the keyboard layout to use media features of
>> +      the fn row when the fn key is not pressed. The firmware may choose
>> +      to add this property when user selects the fn mode in the firmware
>> +      setup utility.
> 
> I'm not a huge fan of the property name/description here.
> For the description, I'm not sure from reading this what the default
> behaviour is and how the fn row works when the fn key is pressed.
> Is the default behaviour that pressing the fn key enables the media keys
> and the row by default provides the fn functionality? And then when this
> option is set in firmware the behaviour is inverted?
> 

Yes. By default pressing i.e. F11 would create F11, Fn+F11 would be vol+.
With this option set, the default for F11 would be vol+ and Fn+f11 would
be F11.

Perhaps this description would be better?

  Configure the keyboard layout to invert the Fn key. By default the
  function row of the keyboard inputs function keys (i.e F11) when
  Fn is not pressed. With this option set, pressing the key without
  Fn would input media keys (i.e. Vol-Up). Firmware may (...) 

> For the name, the "on-top" bit seems a bit weird. I would prefer it to
> be reworded in terms of the behavioural change of the fn key. The media
> keys are physically at the top of the keyboard whether or not this
> option is enabled, hence the "on-top" seeming a bit weird to me.
> 

I was trying to be unambiguous with this name without making
it too long. The implied meaning of "on-top" was "On the top
keyboard layer" (in the opposition of the "Fn" layer). Perhaps
"acer,media-keys-on-top-layer" would have been better then?

I was trying to define this property via the word "media"
since using "fn" is somewhat ambiguous (fn row key vs F(1..12) key
vs Fn key), and something like `inverted-fn-key" would not reflect
what is the impact on the layout. Using "fn-selects-function-keys"
also felt a bit ambiguous to me.

FWIW I can also invert the default and make it
"fn-selects-media-keys" which would be clear. I haven't yet
written the firmware that would pass this property from the
setup so it shouldn't be a problem from the DT POV, but this
is not the "reset" default for the EC.

Do any of those suggestions sound better to you?

Nikita

> Thanks,
> Conor.
> 
>> +    type: boolean
>> +
>> +  connector:
>> +    $ref: /schemas/connector/usb-connector.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |+
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        embedded-controller@76 {
>> +            compatible = "acer,aspire1-ec";
>> +            reg = <0x76>;
>> +
>> +            interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +            connector {
>> +                compatible = "usb-c-connector";
>> +
>> +                port {
>> +                    ec_dp_in: endpoint {
>> +                        remote-endpoint = <&mdss_dp_out>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>>
>> --
>> 2.43.0
>>
