Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC6750F46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjGLRHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGLRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:07:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B138E19A7;
        Wed, 12 Jul 2023 10:07:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so117532781fa.1;
        Wed, 12 Jul 2023 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689181623; x=1691773623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FE5KwK6xtbJwjxewxFtWZgkPMU4+i3I7JpZZxSBsN4A=;
        b=I2UcMynPls0dwldfCvndqaeg/Ab3Ry7stGdckHltSYfHU4A3xXoS54lkGsjdXMXlve
         5bgK7vzoerqhgjb0dUDBYOz6TWqov11sMF3c2hqlcXkeFp/M54mQZOfe90aGcCoEJACj
         XjgALzq/xWEQ+rkFCzZoLVbMZsQWyxoGZsypVTEAXqsOC96LlYtDIZqAvk7Or++6T4bo
         DaFlW0IqUPGjE7+jar7uG6XiDED21uNPoA6loJ7R91GXHXULsAm5Eo3ZQMpnIGiOlz5K
         rQFw9TyBCbAQ4HuQDoA+X0B7IQocWp0Ue7PBGcgx7V0xDWq31pj4xJZREg+yM7kU78ya
         J9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181623; x=1691773623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FE5KwK6xtbJwjxewxFtWZgkPMU4+i3I7JpZZxSBsN4A=;
        b=PSUjKU/qvG7p5IkqBjPt9mmUAOIz6aWYinsTyf38JNnYbjKHVRa245TxJ7QpKmP26/
         jf4mT6LAkgvvRtd/XyWSZ35DCDs8Ny71lytsiD9HhrmC8xho0e/M9YdutznSgawWFSn2
         uwFUzUz/fjVKMVHShHb3AzIQWMTbeRiTw2rUI0InWnz4lC2VcARGkKMBBoNh+PiSIS/g
         uuRuC7+x5G50/l26EhJLhhjkJh1IWOPWnfmSdezH+Yy2XYQLzaN72c+EZydTk0K2C7T6
         V+fsUGXezsOYu9/OGWCVWk3JvjDFHkpwMJXAHNoQMRMXywf4OB90QXF3Rd4KfRFeTJX6
         VxJw==
X-Gm-Message-State: ABy/qLbBztHUCSfBzj7mVjv7C9MnrlESERE4TNBFkPcB8z1MdDt1+3bu
        bCddPAVqbvqCh/TINIvxqlc=
X-Google-Smtp-Source: APBJJlE/iL1XcNM0oII5gni/wrAbTIUN+TnAxxUWdLc/w1rOTECLURpXdUouZp8t0yEnE5O9OH4NVg==
X-Received: by 2002:a2e:9958:0:b0:2b6:dec9:2812 with SMTP id r24-20020a2e9958000000b002b6dec92812mr17074978ljj.33.1689181622542;
        Wed, 12 Jul 2023 10:07:02 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id j11-20020a2e3c0b000000b002b6ee0ff9bbsm1015556lja.67.2023.07.12.10.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:07:02 -0700 (PDT)
Message-ID: <2beb9364-7b5d-4cf7-9003-2d70122731c3@gmail.com>
Date:   Wed, 12 Jul 2023 19:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys
 EA6500 V2
To:     Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Kjellerup?= <rk.katana.steel@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksey Nasibulin <alealexpro100@ya.ru>, stable@vger.kernel.org
References: <20230712014017.28123-1-ansuelsmth@gmail.com>
 <fc94da45-aba8-4e69-a1a0-c1d58a90c68c@lunn.ch>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <fc94da45-aba8-4e69-a1a0-c1d58a90c68c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2023 17:23, Andrew Lunn wrote:
>> --- a/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
>> +++ b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
>> @@ -19,7 +19,8 @@ chosen {
>>   
>>   	memory@0 {
>>   		device_type = "memory";
>> -		reg = <0x00000000 0x08000000>;
>> +		reg = <0x00000000 0x08000000>,
>> +		      <0x88000000 0x08000000>;
> 
> So there is a hole in the middle? Does this require any special
> CONFIG_ option to support sparse memory?

This is how RAM is mapped on all known Northstar devices. Using two
blocks.

I've heard there is a way to design Northstar SoC board to have all RAM
in one region but thay requires disabling something (I don't remember
what) and in practice to vendor decided to do that.

AFAIK no extra CONFIG_* option is needed to make Linux map multiple RAM
regions.
