Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932B279BCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbjIKU4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjIKPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:03:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346BF1B9;
        Mon, 11 Sep 2023 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694444606; x=1725980606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oNtoBDcZl0l4n/LZPVWvVpTFsIxqriN3BWtNMonwvjI=;
  b=lOLdScc3ANg6UIKNJejs2vuRRWg8E537Bqle61Gz25zNPqXJTItAanQ5
   YaGSqI26JDmABIlkYyiyAMWknTfSOd0qDubkc6ItyJBefYXplUijIpfo3
   05NTYgASGrOA451mgLAxbTl3f+H9sZmqtMaBPRgqFoD946J6iesOk+cnq
   E489JIpC44FBTHIJqHWPV/BNGLKPthMjthKIFVR51Dm6lO+0pgwvByDbJ
   a2S3IHKy9F2VrQ52efP/zfOioKAeF67PvMCIp0XonfeV2nevCG70UkSPv
   ov2vgMUWDagftxRh8fK/vdNAX8xkYMxehqqNKN+kPvAemtMvxyLR+U+eO
   Q==;
X-CSE-ConnectionGUID: Vw3n3ru6S2K4artdADjP1Q==
X-CSE-MsgGUID: wiE4NC9IQ4yAzNDyPZXNQg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="4012446"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 08:03:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 11 Sep 2023 08:03:24 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 11 Sep 2023 08:03:21 -0700
Message-ID: <d0296fbd-63d9-10af-4326-68857c6580be@microchip.com>
Date:   Mon, 11 Sep 2023 17:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: ARM: at91: Document Microchip SAMA5D29
 Curiosity
Content-Language: en-US, fr-FR
To:     Conor Dooley <conor@kernel.org>,
        Mihai Sain <mihai.sain@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <andre.przywara@arm.com>,
        <andrei.simion@microchip.com>, <jerry.ray@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <cristian.birsan@microchip.com>
References: <20230801111151.6546-1-mihai.sain@microchip.com>
 <20230801-unbalance-baguette-cd0d4e7e0107@spud>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230801-unbalance-baguette-cd0d4e7e0107@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 at 17:35, Conor Dooley wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> index dfb8fd089197..89d75fbb1de4 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> @@ -79,6 +79,13 @@ properties:
>>             - const: atmel,sama5d2
>>             - const: atmel,sama5
>>   
>> +      - description: Microchip SAMA5D29 Curiosity
>> +        items:
>> +          - const: microchip,sama5d29-curiosity
>> +          - const: atmel,sama5d29
>> +          - const: atmel,sama5d2
>> +          - const: atmel,sama5
> What is the benefit of adding the two familial compatibles? Is there
> software that actually uses these?

"atmel,sama5d2" is used by arch/arm/mach-at91/sama5.c file
"atmel,sama5" is used by drivers/soc/atmel/soc.c file, so yes they are 
needed to instantiate a sama5d29 SoC.

Best regards,
   Nicolas

