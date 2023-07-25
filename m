Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6287762303
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGYUIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGYUIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:08:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139D21BCB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:08:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso8742998a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690315683; x=1690920483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDKN19P6dBOohM5VC/TSDT31wIPP0nkH4L5VMai41rU=;
        b=KyjXqrZmLed+WgPxDo49a+SriVvV+M4d5NbjByva1m2/KdW2gvdR+TPaWGtttRFcV1
         EJzpGgtkGxZjdaqDldHlbHxPAnQtO5eJIwTPWTpvwQ7lNYGNDA/zcIf7G43zuLT6kDF3
         70NfJGPOboxdJzWQlM4mNuiGkP8dNilwXSsHXtE4lRTUVDX6xO4eRtT6J3KBxsohueSK
         2GyT4yMtlpU4n3e0aXgf8+aYLa2B1y8TzO9U+/lGrE94tIhJIZxhQascMV9yw0muf2Z3
         Dn+VNMeHlm1keDjdpFKUDiSzJWgebrS0Jy1vYzt62YZDxYoVM51qJgfvyvgLIwUz7v3t
         l+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690315683; x=1690920483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDKN19P6dBOohM5VC/TSDT31wIPP0nkH4L5VMai41rU=;
        b=SJLFIQYGmHh9FQBGU/EQJKujuRB7nRtFYHyO4WSZyUSWOgfGTCRlptA7yLNNO/8+9e
         Ws/yWOem3cSFDgjmRYNOe+HIgokfO/eq171PZUoe0dbcnyXIdNW6Gb2V9zoEUzU5Imce
         frKoALsXUg8bfYcUktW5DAr2MNwtD/7srOrOsBSbNzq+kgIF4Xi7vMAwiHHo+48eK285
         0bMsZyXT4o9rEXFOh6aXgb2NE9ENx6SXLOvkzSw1uFggRR4rsWmnAFPUkxi7bF9zJcil
         R5YEk8l7oZ9CW0EV0uEuRpWZ6rTGlL0/XagjlTwkwYqbqNZOteXjHhkRtYVZZgtCwUSh
         JLWQ==
X-Gm-Message-State: ABy/qLbPJvp+/vIi2BuNTvavM/x+ri9IylTFWmEW/VlNkytJkw8pmC/Z
        op6gDouhkeJmh82ITk01od2eYg==
X-Google-Smtp-Source: APBJJlECUnJNkq/AGm4ptzFaRHMy9CJzn7ioFyC2Zg0eGxhZ74Pq2VWOQH2A0DmCgq4gOyWwy83/kw==
X-Received: by 2002:a17:907:2cf6:b0:99b:5c3c:3e61 with SMTP id hz22-20020a1709072cf600b0099b5c3c3e61mr13207963ejc.1.1690315683602;
        Tue, 25 Jul 2023 13:08:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l14-20020a1709066b8e00b00992aea2c55dsm8607985ejr.153.2023.07.25.13.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:08:03 -0700 (PDT)
Message-ID: <d04af4a2-a07b-66b7-47e1-5c90fb11fe54@linaro.org>
Date:   Tue, 25 Jul 2023 22:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ARM: dts: samsung: exynos4412-midas: add USB connector
 and USB OTG
To:     Henrik Grimler <henrik@grimler.se>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Artur Weber <aweber.kernel@gmail.com>
References: <20230723142417.97734-1-krzysztof.kozlowski@linaro.org>
 <ZMAfSIF0Rwc69nEv@grimlerstat.localdomain>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZMAfSIF0Rwc69nEv@grimlerstat.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 21:15, Henrik Grimler wrote:
> On Sun, Jul 23, 2023 at 04:24:17PM +0200, Krzysztof Kozlowski wrote:
>> Add full description of USB-MUIC (MAX77693 MUIC) and MUIC-MHL
>> connections, along with proper USB connector and OTG mode for DWC2 USB
>> controller.
>>
>> This fixes dtc W=1 warnings:
>>
>>   Warning (graph_child_address): /i2c-mhl/hdmi-bridge@39/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: replicant@osuosl.org
>> Cc: phone-devel@vger.kernel.org
>> Cc: ~postmarketos/upstreaming@lists.sr.ht
>> Cc: Martin Jücker <martin.juecker@gmail.com>
>> Cc: Henrik Grimler <henrik@grimler.se>
>> Cc: Artur Weber <aweber.kernel@gmail.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Tested-by: Henrik Grimler <henrik@grimler.se>
> 
> * Peripheral mode (still) works
> * MHL somewhat works
> * OTG (still) does not work
> 
> Further details for those interested:
> 
> MHL works reliably if cable is attached before boot, but if cable is
> attached on already running device it sometimes work after detaching
> and attaching cable a few times.  On cable attach, when it does not
> work, we get:
> 
>   [  252.831734] max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
>   [  253.733916] max77693-muic max77693-muic: external connector is attached(chg_type:0x1, prev_chg_type:0x1)
>   [  253.735232] max77693-muic max77693-muic: CONTROL1 : 0x09, CONTROL2 : 0x04, state : attached
>   [  254.691877] i2c i2c-15: sendbytes: NAK bailout.
>   [  254.692150] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
>   [  255.984336] sii9234 15-0039: RGND is not 1k
>   [  256.068970] sii9234 15-0039: RSEN_HIGH without RGND_1K
>   [  256.104457] sii9234 15-0039: discovery failed, no power for MHL?
>   [  256.118272] i2c i2c-15: sendbytes: NAK bailout.
>   [  256.118539] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
>   [  256.375966] sii9234 15-0039: RSEN_HIGH without RGND_1K
>   [  256.411561] sii9234 15-0039: discovery failed, no power for MHL?
> 
> while when it works:
> 
>   [  175.348307] max77693-muic max77693-muic: external connector is detached(chg_type:0x1, prev_chg_type:0x0)
>   [  175.349576] max77693-muic max77693-muic: CONTROL1 : 0x00, CONTROL2 : 0x01, state : detached
>   [  179.304373] dwc2 12480000.usb: new device is full-speed
>   [  179.305920] max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
>   [  180.205735] max77693-muic max77693-muic: external connector is attached(chg_type:0x1, prev_chg_type:0x1)
>   [  180.207211] max77693-muic max77693-muic: CONTROL1 : 0x09, CONTROL2 : 0x04, state : attached
>   [  180.309727] i2c i2c-15: sendbytes: NAK bailout.
>   [  180.309996] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
> 
> Not sure if issue here is in muic driver or sii9234 driver.
> 
> OTG still does not seem to work, the muic driver detects (only) a
> detach when OTG cable is attached:
> 
>   max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
> 
> Same happened when otg cable was attached before these hsotg changes
> as well. I suppose issue here is with max77693-muic driver.
> 

Thanks for testing. I miss here one important thing - did anything
regressed? Is MHL behaving not worse than before? OTG, as non-working,
matters less in such case.

Best regards,
Krzysztof

