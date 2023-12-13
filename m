Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC86812055
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442693AbjLMVDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:03:35 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B4DC;
        Wed, 13 Dec 2023 13:03:39 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5907ded6287so4492055eaf.0;
        Wed, 13 Dec 2023 13:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702501419; x=1703106219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Basja9G+3iA46yBCdGy9ByxHBfFhBIzVm+dnzKBAmR0=;
        b=ZLRXgEmBA6lwmOEB1oNRYXGyNOA5VoiPodvru8FZHUIjDJS58SYiey5O63PD3cki1X
         MKfJPgzFcrBwTfmDXRfRmWaLMK9zsICU0lerfDxIuwtA4Qv2teviE7/qRGRSNCZ+cO8e
         0kYf0KkclHHWqoH0celf0cgsNaSGOfMN7VHhT6dLZTfi5XergQUuSBIz+MWIyaQG9UFE
         xiOqYrWTRBKK1O6Hpt1PLfAzM34tU9HwRUioocI+bgv04LYnXXnfltN7amqYEqXePvZo
         dmI0NXVNaW+7XLhfe9oVaTHQpgmsW/HvBAQLIkCqJUsEHWQ9TvRiudpUXmxxH3TcvUTm
         9m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702501419; x=1703106219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Basja9G+3iA46yBCdGy9ByxHBfFhBIzVm+dnzKBAmR0=;
        b=n5mUzXoSP+P/m8NCbs96Z7JUCaXxQ060jFGfFkceYnz5IdlLWwO7zwnxDOYHKsu+dw
         VfQ2UTFVx9sN6U75xh7tFvSU4q/Cyv4ZOHfMofpfJnxEo8SC/wozdCDOGvidtT0bbJgd
         CUNtWroJ5CeEwaaAKHSmdXhQxmybyyxF2xla9sv90+SipyZeIHBEQDYg9aeJF3jGJJMA
         F2TTMimolR6MkUtZXgiszpDhY/LutV7eQyz48GvMdcLw0ERwUlCodwxQdr6v1vhR5ESR
         EtLjfr/G+IFmbdT0r/vZkjKActLqJDl8BcNrnHvXnoSdi8uA5ZAEA2qK4Tbodm8EuZzj
         1/Ig==
X-Gm-Message-State: AOJu0YznvVsiacEZRuMwAEg8Vsl8h5GmFpJWo/0BlhfiYHvHojJhHHX2
        RB5XfdisI2SuMjuzAuje6bZMC7a7+1fTL85l
X-Google-Smtp-Source: AGHT+IFTFJlMo4Ij9nby4+e/bOHC6l+Bsle/B7A1Vg5eHzmY3uA2aSVnq4C+mDgFnQ3023SjPpaTxg==
X-Received: by 2002:a4a:58cd:0:b0:590:c350:34c3 with SMTP id f196-20020a4a58cd000000b00590c35034c3mr5042839oob.5.1702501418461;
        Wed, 13 Dec 2023 13:03:38 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:b11e:59d6:a73:7922? ([2001:470:42c4:101:b11e:59d6:a73:7922])
        by smtp.gmail.com with ESMTPSA id 68-20020a4a1447000000b00587aaf6add7sm2418211ood.9.2023.12.13.13.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 13:03:38 -0800 (PST)
Message-ID: <79e1577e-0a15-d67f-55cd-eae0449063b6@gmail.com>
Date:   Wed, 13 Dec 2023 14:03:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] xhci: Introduce "disable-usb3" DT property/quirk
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231208210458.912776-1-CFSworks@gmail.com>
 <20231208210458.912776-2-CFSworks@gmail.com> <4854020.GXAFRqVoOG@phil>
From:   Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <4854020.GXAFRqVoOG@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 12:31, Heiko Stuebner wrote:
> Am Freitag, 8. Dezember 2023, 22:04:57 CET schrieb Sam Edwards:
>> Some systems may have xHCI controllers that enumerate USB 3.0 ports, but
>> these ports nevertheless cannot be used. Perhaps enabling them triggers a
>> hardware bug, or perhaps they simply aren't connected and it would be
>> confusing to the user to see an unusable USB 3.0 rhub show up -- whatever
>> the case may be, it's reasonable to want to disable these ports.
>>
>> Add a DT property (and associated quirk) to the xHCI driver that skips
>> over (i.e. ignores and doesn't initialize) any USB 3.0 ports discovered
>> during driver initialization.
>>
>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Ahoy Heiko,

Glad to have you in the thread!

> I'm very much unsure, where the line goes between hw-quirk and
> dt-is-not-a-configuration-space - in this specific instance.
> 
> DT is meant to describe the actual hardware present and not how
> any operating system supports it.

I can plumb this quirk through something other than DT if there's an 
objection to it; however, the intended meaning of this property is 
indeed hardware-description and not OS-configuration: "This xHC does NOT 
support USB3. Do not let it tell you otherwise by enumerating USB3 
ports; it is mistaken. Attempting to enable the USB3 'ports' will at 
worst provoke a hardware bug and at best register a usb3 rhub for 
something that doesn't physically exist."

For v2, I should probably rename the property from something 
"imperative" ("disable-usb3;") to something "declarative," like 
"no-usb3;" or "usb3-unconnected;" in order to reflect this intended 
meaning better. The linux-devicetree reviewers (which I will be looping 
in with v2) will probably prefer a name like that anyway.

> So having that usb3phy present in the kernel - even if only in
> a more limited form as you describe would be my preference.
> 
> 
> But for a short-term thing, the usb3-phy in the binding is optional, so
> so you could "just" deduce the no-usb3 state in your code from its
> absence from the dt-node?

Ah, so while there is a short-term benefit, this is actually meant to be 
long-term: on the Turing RK1 PCB itself, USB-DWC3 #0 is only wired for 
USB 2.0, not USB 3.0. The corresponding USBDP PHY pins are connected to 
(dedicated) DisplayPort pins.

This means there are 4 options:
1. Proceed without enabling that USB-DWC3 at all, giving up USB 2.0.
2. Enable the USBDP in USB3 mode, gaining USB 2.0 but giving up DP.
3. Enable the USBDP in DP mode, having the USB3-PIPE backend
    initialized (but disconnected from the frontend), as a "pacifier"
    for the DWC3 so it doesn't start misbehaving.
4. Disable the USB3 ports on the xHC side, by...
    a. Telling the xHCI driver that it shouldn't enable USB3 ports.
    b. Configuring the DWC3 not to enable USB3
       (see the RK3588 TRM for usb3otg0_host_u3_port_disable)
    c. Configuring the DWC3's number of USB3 ports
       (usb3otg0_host_num_u3_port)

Users won't like #1 or #2, and may be confused by #3 due to the dummy 
port that shows up. Options #2 and #3 aren't possible until a USBDP 
driver lands (though you're right that this is only a short-term 
concern). Option 4a is what I'm currently trying to do because I believe 
having physically-inaccessible USB3 ports show up in Linux is 
undesirable in any case, but I can switch to 4b/4c if we want something 
more SoC-specific.

So (as far as RK3588 is concerned) with option(s) 4(a/b/c), while this 
does let USB2.0 work before the USBDP driver lands, the "real" benefit 
is that it requires neither a dummy port nor powering up a block of the 
chip (the PHY's USB3-specific block) that isn't actually usable/useful 
because it doesn't connect to a USB 3.0 socket/device.

Though if that still doesn't sound appealing, I'm happy to change up the 
approach -- I guess the question then is whether it's because you *like* 
option 3, or *dislike* option 4.

Cheers,
Sam

> 
> 
> Heiko
> 
> 
> 
>>   Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>>   drivers/usb/host/xhci-mem.c                         | 4 ++++
>>   drivers/usb/host/xhci-plat.c                        | 3 +++
>>   drivers/usb/host/xhci.h                             | 1 +
>>   4 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
>> index 180a261c3e8f..8a64e747260a 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
>> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
>> @@ -25,6 +25,10 @@ properties:
>>       description: Set if the controller has broken port disable mechanism
>>       type: boolean
>>   
>> +  disable-usb3:
>> +    description: Ignore (don't initialize, don't use) USB3 ports
>> +    type: boolean
>> +
>>     imod-interval-ns:
>>       description: Interrupt moderation interval
>>       default: 5000
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index 0a37f0d511cf..bf8fcab626e4 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -1968,6 +1968,10 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
>>   	minor_revision = XHCI_EXT_PORT_MINOR(temp);
>>   
>>   	if (major_revision == 0x03) {
>> +		/* Ignore USB3 ports entirely if USB3 support is disabled. */
>> +		if (xhci->quirks & XHCI_DISABLE_USB3)
>> +			return;
>> +
>>   		rhub = &xhci->usb3_rhub;
>>   		/*
>>   		 * Some hosts incorrectly use sub-minor version for minor
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index b93161374293..75285fb5bbbc 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -249,6 +249,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>>   		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
>>   			xhci->quirks |= XHCI_BROKEN_PORT_PED;
>>   
>> +		if (device_property_read_bool(tmpdev, "disable-usb3"))
>> +			xhci->quirks |= XHCI_DISABLE_USB3;
>> +
>>   		device_property_read_u32(tmpdev, "imod-interval-ns",
>>   					 &xhci->imod_interval);
>>   	}
>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index 5df370482521..c53fbeea478f 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1906,6 +1906,7 @@ struct xhci_hcd {
>>   #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
>>   #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
>>   #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
>> +#define XHCI_DISABLE_USB3	BIT_ULL(47)
>>   
>>   	unsigned int		num_active_eps;
>>   	unsigned int		limit_active_eps;
>>
> 
> 
> 
> 
