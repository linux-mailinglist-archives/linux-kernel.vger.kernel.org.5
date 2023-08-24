Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2E786788
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjHXGcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbjHXGb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:31:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24DF1704
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:31:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50043cf2e29so7352568e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692858712; x=1693463512;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MkXUytM4APvBf/WIGJ2/OJYgxtV1wh1rm1M4ur5Z1fE=;
        b=BLoc/WkDGP2X6E6KgzEbfYD/ZQR6CZsfn5QSbuWukoF/TBjtur9N6rXmorT6cQctvI
         rq3q7dE0gkVUDozo8Zl5KsrYSI46kXVCN3XNzwsKN/A5Eca3TbAmsexqlmaZ6UVdVEiB
         kB4l56Ux23EFSHsODHQxnks7ra/U1Ow5G8R3suGogXQDI8yNMWqWg6BsW/TrgJ15qb+H
         CDQ5vE0J/4m/yijNzmH/cmBZIm1zdZ/L4QOBZaHU8CQiWbg3vjKE5qkfVm6pBHwJ8u88
         s+wECGSMqD4NkZy4DV4vKCPl1BqNtw+emIY+15/x/DfKC7E8CiffTibU4dTO8CeysHMS
         ObEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692858712; x=1693463512;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkXUytM4APvBf/WIGJ2/OJYgxtV1wh1rm1M4ur5Z1fE=;
        b=ByxXOuHafn9DwEtRv+8vo8O9B2G/eTp6OukNBDTcv2OcegNlZl+VbtWNYh7TWv5JiV
         ah7slp33SjequkTLd95zzOSQtntHBeJ/H0QZkxZJul4mzddmqjTWCcfpuK/p4gpW/ig0
         AzF+Ml8NBfZbrGsEa7sRWHoE5ts5S7iNEKO6JOSbD+wd1sfDavITaKA5Lo3um+ENHpZ0
         7+2b79FrksBsBnR27GZYPnlGKqmtpAD0fRXa/79pYIIyG+LTmPIK/fRb/fgTE6CIhyco
         w3SAoP+oORR64UECXuXFrnL9vxTIrSOSQZx7s4Hdh6vH4uPKE9/IRk8DOLX3LIQApF3p
         qFhw==
X-Gm-Message-State: AOJu0Yy0jH+Jx1trFZz/qUinC7R5SadbdTxPLITqw3p/YHqMzcchtFIH
        ynVCS7mYAcrvDXrNqmg04IVRhw==
X-Google-Smtp-Source: AGHT+IF1EkeSpVUpI9rk+rAnB7/ELYaPSWH162DDLwcm188uNu0v3HENMLiNw3z31Xpegz63nIHw9g==
X-Received: by 2002:a05:6512:2395:b0:4fb:8ee0:b8a5 with SMTP id c21-20020a056512239500b004fb8ee0b8a5mr13650471lfv.46.1692858711724;
        Wed, 23 Aug 2023 23:31:51 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id d19-20020aa7c1d3000000b005232ea6a330sm10171793edp.2.2023.08.23.23.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:31:51 -0700 (PDT)
Message-ID: <541ce5de-88b2-7d67-6aaa-2faaeb4f6703@linaro.org>
Date:   Thu, 24 Aug 2023 08:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Content-Language: en-US
To:     "Yu, Richard" <richard.yu@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chang, Clay" <clayc@hpe.com>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-2-richard.yu@hpe.com>
 <9f1bd0f1-d93e-243a-4622-721319fd1235@linaro.org>
 <SJ0PR84MB20854B4A444283E31025FA398D0AA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
 <e2e7c830-07f4-a34e-6bf8-c9e8dc33bf57@linaro.org>
 <SJ0PR84MB2085BDDFD7C46A73C489A6E48D12A@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
 <834800aa-65f4-4c99-4586-51a24355bc59@linaro.org>
 <SJ0PR84MB20859D909E55BB1BC62EE3C68D1CA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SJ0PR84MB20859D909E55BB1BC62EE3C68D1CA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 18:07, Yu, Richard wrote:
> 
> Thank you, Mr. Kozlowski.
> 
>>> I am implementing this driver using the Aspeed virtual hub driver as example. 
>>>
>>> Just like the Aspeed virtual hub is in the Devicetree:
>>>
>>> vhub: usb-vhub@1e6a0000 {
>>> 	compatible = "aspeed,ast2600-usb-vhub";
>>> 	reg = <0x1e6a0000 0x350>;
>>> 	interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>>> 	clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
>>> 	aspeed,vhub-downstream-ports = <7>;
>>> 	aspeed,vhub-generic-endpoints = <21>;
>>> 	pinctrl-names = "default";
>>> 	pinctrl-0 = <&pinctrl_usb2ad_default>;
>>> 	status = "disabled";
>>> };
>>>
>>> In my case:  (I am replacing "udcg" with "vhub" and remove the vehci reference).
>>>
>>>  vhub: usb-vhub@80400800 {
>>> 	compatible = "hpe,gxp-vhub";
>>> 	reg = <0x80400800 0x0200>, <0x80401000 0x8000>;
>>> 	reg-names = "vhub", "udc";
>>> 	interrupts = <13>;
>>> 	interrupt-parent = <&vic1>;
>>> 	hpe,vhub-downstream-ports = <4>;
>>> 	hpe,vhub-generic-endpoints = <16>;
>>> };
> 
> 
>> The hub is not virtual, it is real. I understand that it is some software block or FPGA, but still I propose to skip any references to virtual.
> 
> I will remove any references to "virtual" in comment and documentation.
> 
> 
>>>>>> + hpe,vehci-downstream-ports:
>>>>>> + description: Number of downstream ports supported by the GXP
>>>>
>>>>
>>>>>> Why do you need this property in DT and what exactly does it represent?
>>>>>> You have one device - EHCI controller - and on some boards it is 
>>>>>> further customized? Even though it is the same device?
>>>>>
>>>>> That is correct. We can configure this VHUB Controller to have one 
>>>>> to
>>>>> 8 virtual ports. This is similar to the aspeed virtual USB HUB 
>>>>> "aspeed,vhub-downstream-ports" moving forward in the next patch we 
>>>>> are going to use "hpe,vhub-downstream-ports"
>>>
>>>> Moving forward you need to address this lack of physical presence...
>>>> Aren't these different devices and you just forgot to customize the compatible?
>>>
>>> I don’t fully understand here. Isn't the lack of physical presence 
>>> similar to the Aspeed virtual hub driver?
> .
>> I don't know Aspeed virtual hub driver. In any case, driver is irrelevant to the bindings.
> 
>> Why setting maximum number of downstream ports or devices would be needed per-board? 
>> Do you save some resources that way?
> 
> That is correct. Each port/devices will have to allocate resources and create device descriptor entry.

The answer to "why" is not "that is correct".

> Currently, I set the number of downstream ports to be 4. Thus, I will have:
> 
> /sys/bus/platform/devices/80400800.vhub/80400800.vhub:p1   <=== for kvm keyboard/mouse
> /sys/bus/platform/devices/80400800.vhub/80400800.vhub:p2   <=== for virtual CD/DVD/ISO image
> /sys/bus/platform/devices/80400800.vhub/80400800.vhub:p3   <=== for virtual USB key
> /sys/bus/platform/devices/80400800.vhub/80400800.vhub:p4   <=== for virtual NIC

So resources in Linux? That's not really relevant and important. I still
do not see the need of this property.

> 
> Just like aspeed:
> In g5 (aspeed-g5.dtsi), aspeed,vhub-downstream-ports = <5>;
> In g6 (aspeed-g6.dtsi), aspeed,vhub-downstream-ports = <7>;

I did not review that. Poor or incorrect example is not an argument. If
they introduced obvious bugs or obvious non-DT properties, shall you do
the same?

Best regards,
Krzysztof

