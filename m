Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105C78F0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbjHaPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHaPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:53:43 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068711A3;
        Thu, 31 Aug 2023 08:53:39 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37VE3Toe012289;
        Thu, 31 Aug 2023 17:53:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=tdfXHbaA8B9kmWWa7lzvV7hPJOZ3PDnaE1ei6pzWp5M=; b=tJ
        xKDbn7+rxWdFXMOyLMw0rZWWSk2WZS4XKTFPqrpWZaBDxZPUpQHUcqThqKA0NzkY
        MmKQ+6UwJ1iMaAaxD1d/L8APEr3UNGQpwkGZ9JraNXdc5khwo6CbRqsVWof2iyic
        4HppAH+eGWIzRoXYKzXrxmsbq4p7VAjWpcwB1wlDFcvYV9ZBiI0IPGVQ3x+ya5u4
        djK3Xle9egS2qMrDg3SvyrBhMHRN2xkNdYn5EH/fe7YM40qJKoUGQzroEviDhTnf
        GDt2UFllxFYMTHcyMZjQCu4stvItpUT8ddGriR9zo3vSJNs8LkegLAyZ+WVEn6H2
        hmk/GTuQKoQY3GLc+ORg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqvbhm8m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 17:53:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C7359100056;
        Thu, 31 Aug 2023 17:53:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C53C2092E2;
        Thu, 31 Aug 2023 17:53:02 +0200 (CEST)
Received: from [10.201.20.178] (10.201.20.178) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 31 Aug
 2023 17:53:01 +0200
Message-ID: <d17f56a5-6f6b-d359-0123-ce04bb177e33@foss.st.com>
Date:   Thu, 31 Aug 2023 17:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v2 03/11] dt-bindings: iio: stm32-dfsdm-adc: add scaling
 support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <alsa-devel@alsa-project.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
 <20230727150324.1157933-4-olivier.moysan@foss.st.com>
 <20230811171011.GA3618531-robh@kernel.org>
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20230811171011.GA3618531-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_14,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/11/23 19:10, Rob Herring wrote:
> On Thu, Jul 27, 2023 at 05:03:14PM +0200, Olivier Moysan wrote:
>> Add scaling support to STM32 DFSDM.
>>
>> This introduces the following changes:
> 
> Why?
> 

This RFC is an attempt to support scaling through a change in DFSDM 
topology.

These changes have some impacts on DFSDM and sd modulator bindings.
To keep things simple in this RFC, I skipped legacy support, to put the 
emphasis on the new bindings proposal.
There are two changes here: adoption of the generic IIO bindings and new 
"io-backends" property. This needs to be put in two separate patches at 
the end, I think (as already done for driver patches)

Anyway, the current bindings would become deprecated with these changes. 
I still have to consider how to support these legacy bindings for next 
step, However.

BRs
Olivier

>> - Add ADC generic channel binding and remove support of deprecated
>> channel bindings.
> 
> When was it deprecated?
> 
>> - DFSDM is now implemented as a channel provider, so remove io-channels
>> properties.
>> - Add iio-backend property to connect DFSDM to an SD modulator.
> 
> io-backends
> 
> All sorts of ABI issues with this change. Please explain why you don't
> care.
> 
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>>   .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 189 ++++++------------
>>   1 file changed, 63 insertions(+), 126 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
>> index 1970503389aa..128545cedc7f 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
>> @@ -85,22 +85,14 @@ patternProperties:
>>           description: Specifies the DFSDM filter instance used.
>>           maxItems: 1
>>   
>> -      interrupts:
>> -        maxItems: 1
>> +      '#address-cells':
>> +        const: 1
>>   
>> -      st,adc-channels:
>> -        description: |
>> -          List of single-ended channels muxed for this ADC.
>> -          On stm32h7 and stm32mp1:
>> -          - For st,stm32-dfsdm-adc: up to 8 channels numbered from 0 to 7.
>> -          - For st,stm32-dfsdm-dmic: 1 channel numbered from 0 to 7.
>> -        $ref: /schemas/types.yaml#/definitions/uint32-array
>> -        items:
>> -          minimum: 0
>> -          maximum: 7
>> +      '#size-cells':
>> +        const: 0
>>   
>> -      st,adc-channel-names:
>> -        description: List of single-ended channel names.
>> +      interrupts:
>> +        maxItems: 1
>>   
>>         st,filter-order:
>>           description: |
>> @@ -111,39 +103,6 @@ patternProperties:
>>           $ref: /schemas/types.yaml#/definitions/uint32
>>           maximum: 5
>>   
>> -      "#io-channel-cells":
>> -        const: 1
>> -
>> -      st,adc-channel-types:
>> -        description: |
>> -          Single-ended channel input type.
>> -          - "SPI_R": SPI with data on rising edge (default)
>> -          - "SPI_F": SPI with data on falling edge
>> -          - "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
>> -          - "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
>> -        items:
>> -          enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
>> -        $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> -
>> -      st,adc-channel-clk-src:
>> -        description: |
>> -          Conversion clock source.
>> -          - "CLKIN": external SPI clock (CLKIN x)
>> -          - "CLKOUT": internal SPI clock (CLKOUT) (default)
>> -          - "CLKOUT_F": internal SPI clock divided by 2 (falling edge).
>> -          - "CLKOUT_R": internal SPI clock divided by 2 (rising edge).
>> -        items:
>> -          enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
>> -        $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> -
>> -      st,adc-alt-channel:
>> -        description:
>> -          Must be defined if two sigma delta modulators are
>> -          connected on same SPI input.
>> -          If not set, channel n is connected to SPI input n.
>> -          If set, channel n is connected to SPI input n + 1.
>> -        type: boolean
>> -
>>         st,filter0-sync:
>>           description:
>>             Set to 1 to synchronize with DFSDM filter instance 0.
>> @@ -157,14 +116,68 @@ patternProperties:
>>           items:
>>             - const: rx
>>   
>> +    patternProperties:
>> +      "^channel@([0-9]|1[0-9])$":
>> +        type: object
>> +        $ref: "adc.yaml"
>> +        description: Represents the external channels which are connected to the DFSDM.
>> +
>> +        properties:
>> +          reg:
>> +            items:
>> +              minimum: 0
>> +              maximum: 19
>> +
>> +          label:
>> +            description: |
>> +              Unique name to identify channel.
>> +
>> +          st,adc-channel-types:
>> +            description: |
>> +              Single-ended channel input type.
>> +              - "SPI_R": SPI with data on rising edge (default)
>> +              - "SPI_F": SPI with data on falling edge
>> +              - "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
>> +              - "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
>> +            items:
>> +              enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
>> +            $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +
>> +          st,adc-channel-clk-src:
>> +            description: |
>> +              Conversion clock source.
>> +              - "CLKIN": external SPI clock (CLKIN x)
>> +              - "CLKOUT": internal SPI clock (CLKOUT) (default)
>> +              - "CLKOUT_F": internal SPI clock divided by 2 (falling edge).
>> +              - "CLKOUT_R": internal SPI clock divided by 2 (rising edge).
>> +            items:
>> +              enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
>> +            $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +
>> +          st,adc-alt-channel:
>> +            description:
>> +              Must be defined if two sigma delta modulators are
>> +              connected on same SPI input.
>> +              If not set, channel n is connected to SPI input n.
>> +              If set, channel n is connected to SPI input n + 1.
>> +            type: boolean
>> +
>> +          io-backends:
>> +            description: |
>> +              phandle to an external sigma delta modulator or internal ADC output.
>> +            $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +        required:
>> +          - reg
>> +          - io-backends
>> +
>> +        additionalProperties: false
>> +
>>       required:
>>         - compatible
>>         - reg
>>         - interrupts
>> -      - st,adc-channels
>> -      - st,adc-channel-names
>>         - st,filter-order
>> -      - "#io-channel-cells"
>>   
>>       allOf:
>>         - if:
>> @@ -175,14 +188,6 @@ patternProperties:
>>   
>>           then:
>>             properties:
>> -            st,adc-channels:
>> -              minItems: 1
>> -              maxItems: 8
>> -
>> -            st,adc-channel-names:
>> -              minItems: 1
>> -              maxItems: 8
>> -
>>               st,adc-channel-types:
>>                 minItems: 1
>>                 maxItems: 8
>> @@ -191,14 +196,6 @@ patternProperties:
>>                 minItems: 1
>>                 maxItems: 8
>>   
>> -            io-channels:
>> -              description:
>> -                From common IIO binding. Used to pipe external sigma delta
>> -                modulator or internal ADC output to DFSDM channel.
>> -
>> -          required:
>> -            - io-channels
>> -
>>         - if:
>>             properties:
>>               compatible:
>> @@ -207,12 +204,6 @@ patternProperties:
>>   
>>           then:
>>             properties:
>> -            st,adc-channels:
>> -              maxItems: 1
>> -
>> -            st,adc-channel-names:
>> -              maxItems: 1
>> -
>>               st,adc-channel-types:
>>                 maxItems: 1
>>   
>> @@ -237,15 +228,9 @@ patternProperties:
>>                   "#sound-dai-cells":
>>                     const: 0
>>   
>> -                io-channels:
>> -                  description:
>> -                    From common IIO binding. Used to pipe external sigma delta
>> -                    modulator or internal ADC output to DFSDM channel.
>> -
>>                 required:
>>                   - compatible
>>                   - "#sound-dai-cells"
>> -                - io-channels
>>   
>>   allOf:
>>     - if:
>> @@ -278,52 +263,4 @@ allOf:
>>                   minimum: 0
>>                   maximum: 5
>>   
>> -examples:
>> -  - |
>> -    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> -    #include <dt-bindings/clock/stm32mp1-clks.h>
>> -    dfsdm: dfsdm@4400d000 {
>> -      compatible = "st,stm32mp1-dfsdm";
>> -      reg = <0x4400d000 0x800>;
>> -      clocks = <&rcc DFSDM_K>, <&rcc ADFSDM_K>;
>> -      clock-names = "dfsdm", "audio";
>> -      #address-cells = <1>;
>> -      #size-cells = <0>;
>> -
>> -      dfsdm0: filter@0 {
>> -        compatible = "st,stm32-dfsdm-dmic";
>> -        reg = <0>;
>> -        interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
>> -        dmas = <&dmamux1 101 0x400 0x01>;
>> -        dma-names = "rx";
>> -        #io-channel-cells = <1>;
>> -        st,adc-channels = <1>;
>> -        st,adc-channel-names = "dmic0";
>> -        st,adc-channel-types = "SPI_R";
>> -        st,adc-channel-clk-src = "CLKOUT";
>> -        st,filter-order = <5>;
>> -
>> -        asoc_pdm0: dfsdm-dai {
>> -          compatible = "st,stm32h7-dfsdm-dai";
>> -          #sound-dai-cells = <0>;
>> -          io-channels = <&dfsdm0 0>;
>> -        };
>> -      };
>> -
>> -      dfsdm_pdm1: filter@1 {
>> -        compatible = "st,stm32-dfsdm-adc";
>> -        reg = <1>;
>> -        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
>> -        dmas = <&dmamux1 102 0x400 0x01>;
>> -        dma-names = "rx";
>> -        #io-channel-cells = <1>;
>> -        st,adc-channels = <2 3>;
>> -        st,adc-channel-names = "in2", "in3";
>> -        st,adc-channel-types = "SPI_R", "SPI_R";
>> -        st,adc-channel-clk-src = "CLKOUT_F", "CLKOUT_F";
>> -        io-channels = <&sd_adc2 &sd_adc3>;
>> -        st,filter-order = <1>;
>> -      };
>> -    };
>> -
>>   ...
>> -- 
>> 2.25.1
>>
