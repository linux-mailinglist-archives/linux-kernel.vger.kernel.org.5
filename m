Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024677BF3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442420AbjJJHPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442324AbjJJHPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:15:15 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBCB6;
        Tue, 10 Oct 2023 00:15:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id B4231E0002;
        Tue, 10 Oct 2023 07:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696922111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SWNhwB9xX+AIGst/dz41McHRtLFLngoPhPXaZJs1igY=;
        b=QVdUreOdVIVCO7bF9WiWDvI72HiHRnyRMxT/mK7QIj5IA56Qys2e/rln3Smot1MH+EydwU
        eZ4oQG0liGgBCUHUrKsFU3S3FDbDZYkEKz22Vz1SPgzGrlrNAQUVAyMnyIrRUSqtbTOeJP
        xkYA4PFiVck+r+C6yTzJY2bsNLyMIMgeAnvC2T8pFu6U6ElP22nGHLrBRjXc3fzVYb88GS
        TpRFO7Nu/NI+Os4YAhHX31fitVQTZeVCYcKkCRjkrBwNkFXXTrlOQWOkAZZ/eV4wj2HWdv
        KSQgvQT6TtiOnwNIA4p09UBLL36ZBgJr5EQJ78enm5/ahtDqnat4P/FFXjf9MA==
MIME-Version: 1.0
Date:   Tue, 10 Oct 2023 09:15:08 +0200
From:   kamel.bouhara@bootlin.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.satterthwaite@touchnetix.com,
        pedro.torruella@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Add bindings for TouchNetix
 axiom touchscreen
Message-ID: <79160a2ebe3fd35fe7f9b93e30cf89fa@bootlin.com>
X-Sender: kamel.bouhara@bootlin.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Le 2023-10-09 17:05, Krzysztof Kozlowski a écrit :
> On 09/10/2023 15:44, Kamel Bouhara wrote:
>> Add the TouchNetix axiom I2C touchscreen device tree bindings
>> documentation.
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> 

OK.

>> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> ---
>>  .../touchscreen/touchnetix,axiom-ax54a.yaml   | 51 
>> +++++++++++++++++++
>>  MAINTAINERS                                   |  6 +++
>>  2 files changed, 57 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/input/touchscreen/touchnetix,axiom-ax54a.yaml
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/input/touchscreen/touchnetix,axiom-ax54a.yaml 
>> b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,axiom-ax54a.yaml
>> new file mode 100644
>> index 000000000000..41201d7112a6
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,axiom-ax54a.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: 
>> http://devicetree.org/schemas/input/touchscreen/touchnetix,axiom-ax54a.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TouchNetix Axiom series touchscreen controller
>> +
>> +maintainers:
>> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: touchnetix,axiom-ax54a
>> +
>> +  reg:
>> +    const: 0x66
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  irq-gpios:
>> +    maxItems: 1
> 
> Why these are GPIOs? Interrupts are usually just interrupts... You need
> to clearly describe this.
> 

I've been using this for some specific acpi stuff hence it need to be 
removed.

> 
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +additionalProperties: false
> 
> This goes after required: block.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      axiom@66 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 

Ack.

> 
> 
>> +        compatible = "touchnetix,axiom-ax54a";
>> +        reg = <0x66>;
>> +        interrupt-parent = <&gpio2>;
>> +        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>> +        irq-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> 
> Eh? This looks really wrong.

OK let's clean that as well.

Thanks

> 
> 
> Best regards,
> Krzysztof
