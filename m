Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C108E781B59
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 01:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjHSXTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHSXTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 19:19:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D50214042
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:30:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff92e369dfso3107146e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692469833; x=1693074633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l4em45wM2Wmo1RP/Mi2Wezx/AAXIhBM6pCSJmgudygA=;
        b=ZUyK3nMJtTIKCZXuDQpDc/Y+SlarGxaImcHWuUq0dkfjfNGkDoE2vLGYOUdfREsLOz
         ThklXFBZCWlOKRenqiAVueYPmQulDnNQX987U97dBEm7IuOYB62tGM9IRETagrF8sEgV
         lAgVX0STLTVk2jTMY+XJgoGtBNUwnZ7GLNmYmFVBv1w9y81pPaTZWspzVKnuapENanqt
         qG2ri4Whp8J5z0HFWdNlcBcwXC/Dz3bFHPa3sprsiJlR29c2rTLEO28+DBl/ShKInkpx
         ivvGS9kQ5OqerFv4pgSHuvQ3zE5PqjNEnHHH2mROKuFF0+JoX5d4Z11Uslg83oRMdvi1
         LMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692469833; x=1693074633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4em45wM2Wmo1RP/Mi2Wezx/AAXIhBM6pCSJmgudygA=;
        b=a9AS2ToPZShh/k9scZgPsVXdksx8UolBnNXKyum9psYyb3d7+I/fruGTczRqoey5Mg
         sw78IYqv4LEKUdlymAToTG+25TySKAqL1a6psMKa0HtAsDHRkVfMsbP9qq6rtlzJXijd
         owB5qVQK3zFZwyANir2IHfzf/panwwuf/caKXeobImqB8bzgBukxSMUcq4VKavh5xaWd
         65U5WDeYlQIyT9Gb9AmVrPMLpSqfVMVlv2t2sx9QQnPARwd0XiserJQGED/lAn43Ewb3
         eskU1NFZyw10f98bkCidhyTlzOaveRgsygppGhuuuXlbNdpDNW4lNE4RZCglk612WqYP
         WiYg==
X-Gm-Message-State: AOJu0Yxj/dmkxg2vVZTM4rEVyyFwwNjs8uyBM8BN70XL6ed54CfXVK5K
        pXWd/vHn+rUFSEFr8/qTAdmb7w==
X-Google-Smtp-Source: AGHT+IHLbqXBFKUgEu5umyFOGP0OlV87nZoxe+tyMeqV+xuw9V5hC45+M+jsxcvvn7tHYR+BuJF27g==
X-Received: by 2002:a05:6512:3411:b0:4fe:1f27:8856 with SMTP id i17-20020a056512341100b004fe1f278856mr1948889lfr.7.1692469832997;
        Sat, 19 Aug 2023 11:30:32 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id bf6-20020a0564021a4600b005256d80cdaesm2872475edb.65.2023.08.19.11.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 11:30:32 -0700 (PDT)
Message-ID: <834800aa-65f4-4c99-4586-51a24355bc59@linaro.org>
Date:   Sat, 19 Aug 2023 20:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SJ0PR84MB2085BDDFD7C46A73C489A6E48D12A@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 17:52, Yu, Richard wrote:
> Thank you, Mr. Kozlowski, for your feedback.
> 
> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 
> Sent: Saturday, August 5, 2023 2:09 PM
> To: Yu, Richard <richard.yu@hpe.com>; Verdun, Jean-Marie <verdun@hpe.com>; Hawkins, Nick <nick.hawkins@hpe.com>; gregkh@linuxfoundation.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
> 
> On 01/08/2023 20:07, Yu, Richard wrote:
>>>
>>>>> +title: HPE GXP USB Virtual EHCI controller
>>>
>>>> The word "virtual" in bindings pretty often raises questions, because 
>>>> we describe usually real hardware, not virtual. Some explanation in 
>>>> description would be useful.
>>>
>>> Here we are working with virtual devices that are created and have no
> 
>> Unfortunately I do not know what are virtual devices which do not exist physically. 
>> I have serious doubts that they fit Devicetree purpose...
> 
> In our HPE gxp, we have an EHCI device which it is present to host as 
> standard EHCI controller.  However, this EHCI controller does not have 
> any physical port. Users can figure this EHCI controller to have 1 to 8 ports 
> (we call it as virtual ports) and attached 1 to 8 UDC devices (we 
> call them as virtual devices). User can figure each port/device to
>  have 1 to 16 endpoints. 
> 
> I am writing his driver to create the device descriptor entry for each port/UDC.
>  /sys/bus/platform/devices/80400800.vhub/80400800.vhub:p1 .... Thus, 
> the OpenBmc KVM can use them as virtual mouse/keyboard, virtual NIC .... 
> 
> I am implementing this driver using the Aspeed virtual hub driver as example. 
> 
> Just like the Aspeed virtual hub is in the Devicetree:
> 
> vhub: usb-vhub@1e6a0000 {
> 	compatible = "aspeed,ast2600-usb-vhub";
> 	reg = <0x1e6a0000 0x350>;
> 	interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> 	clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> 	aspeed,vhub-downstream-ports = <7>;
> 	aspeed,vhub-generic-endpoints = <21>;
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_usb2ad_default>;
> 	status = "disabled";
> };
> 
> In my case:  (I am replacing "udcg" with "vhub" and remove the vehci reference).
> 
>  vhub: usb-vhub@80400800 {
> 	compatible = "hpe,gxp-vhub";
> 	reg = <0x80400800 0x0200>, <0x80401000 0x8000>;
> 	reg-names = "vhub", "udc";
> 	interrupts = <13>;
> 	interrupt-parent = <&vic1>;
> 	hpe,vhub-downstream-ports = <4>;
> 	hpe,vhub-generic-endpoints = <16>;
> };

The hub is not virtual, it is real. I understand that it is some
software block or FPGA, but still I propose to skip any references to
virtual.


> 
>>> physical presence. We have modeled our code off of ASPEED's VHUB 
>>> implementation to comply with the implementation in OpenBMC.
>>>
>>>>> + The HPE GXP USB Virtual EHCI Controller implements 1 set of USB 
>>>>> + EHCI register and several sets of device and endpoint registers to 
>>>>> + support the virtual EHCI's downstream USB devices.
>>>>> +
>>>
>>>
>>>>  If this is EHCI controller, then I would expect here reference to usb-hcd.
>>>
>>> We will remove references to EHCI in code and documentation. It has 
>>> been modeled to following ASPEEDs approach as mentioned above.
>>>
>>>> + hpe,vehci-downstream-ports:
>>>> + description: Number of downstream ports supported by the GXP
>>
>>
>>>> Why do you need this property in DT and what exactly does it represent?
>>>> You have one device - EHCI controller - and on some boards it is 
>>>> further customized? Even though it is the same device?
>>>
>>> That is correct. We can configure this VHUB Controller to have one to
>>> 8 virtual ports. This is similar to the aspeed virtual USB HUB 
>>> "aspeed,vhub-downstream-ports" moving forward in the next patch we are 
>>> going to use "hpe,vhub-downstream-ports"
> 
>> Moving forward you need to address this lack of physical presence...
>> Aren't these different devices and you just forgot to customize the compatible?
> 
> I don’t fully understand here. Isn't the lack of physical presence similar to the
> Aspeed virtual hub driver?

I don't know Aspeed virtual hub driver. In any case, driver is
irrelevant to the bindings.

Why setting maximum number of downstream ports or devices would be
needed per-board? Do you save some resources that way?

Best regards,
Krzysztof

