Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7107B11CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjI1EzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjI1EzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:55:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDD812A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:55:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so14790633a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695876902; x=1696481702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJzDx2Q6nxZ+DWJMtFRfSZYTpolzYPfGhsHuRSrEKc0=;
        b=EKzk6BImnX69tO7583aNdG72Q5H0VQtVH6PmrOGI+8m7o03tpVWjulVafAAczF9EbH
         WFv18onUrVkF/lRCY3LhM5zqG8EvzPxtWhMUn1kvSDEx+ttCxqh0Vkx76Hp9fkXzWlph
         m1RAGzmXDQH8Iu6My45r6OBJ2eo1yb3B3eChZ/LYgLlRiC/7OUlwe1qcX5IWitDMgW8k
         QIngZRpoar/F4PlDApZsL1+bJn+I1em6GIkiKuIOjOcs75l7tDDymCLf0uJXYPWon1jM
         aSlr0q8GeSMlFs/FKYaLHlyJvoBcsOVZZNkFJItgXYnLddmzg+NzeJaxkjZG2DBB2Zdj
         cOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876902; x=1696481702;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJzDx2Q6nxZ+DWJMtFRfSZYTpolzYPfGhsHuRSrEKc0=;
        b=LZ78+wk7RIgHGHGw7YNZGJc+JuSgPKi9uAYgSW8B8S8qZQgdnBZI0CnOOoDISzRtT7
         Ien2Hw1fG9dqRdcjHfl98M+iCZmYUrJHHWj5bhlpA9hFkLBqSA6CJ/adR82D56bFTiHs
         pdxAHCL4bPHDC0btw+j97YbTt895BqMuUfs0AgExwcHpFHjfq19XQYXMswnT0Uf0i9Gm
         1SH6RnAKXesMw1TBim+iIramMHWSyZFipicJsk6fKD/TwEQmOuumzr2abzEcVvM/iEuO
         oICUEVkgD/9qidaFskMgYrQG6P6b6YWBPVdxLxZjvVCzj3NK2aFWXWTJ/DIpsf69HAlD
         6csw==
X-Gm-Message-State: AOJu0YzfL01qFguQQuL+4TX7bgUnkizeQMmk5N2X7IljhC7NqT4p40ql
        ZHlTCt2mHZBE/5A54VTu6F3ioA==
X-Google-Smtp-Source: AGHT+IHACU5tHsuZ4EvgrKipDUERUw5JqVpj7Q+M3eWKWUApcch67+gkqynZubl+rC/1s3suEWX+5Q==
X-Received: by 2002:a17:906:28e:b0:9ae:552a:3d3f with SMTP id 14-20020a170906028e00b009ae552a3d3fmr181199ejf.28.1695876902123;
        Wed, 27 Sep 2023 21:55:02 -0700 (PDT)
Received: from [192.168.1.231] (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b009adc77fe165sm10082708ejo.118.2023.09.27.21.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 21:55:01 -0700 (PDT)
Message-ID: <f488a583-6229-4e6b-a22e-4abb224895fe@linaro.org>
Date:   Thu, 28 Sep 2023 06:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: omap4-embt2ws: Add Bluetooth
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230926204204.2120316-1-andreas@kemnade.info>
 <be991b32-018a-478d-bd74-6c79ea1c788e@linaro.org>
 <20230927182903.4cf1527f@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20230927182903.4cf1527f@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 18:29, Andreas Kemnade wrote:
> 
> 
> On Wed, 27 Sep 2023 09:56:28 +02Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 26/09/2023 22:42, Andreas Kemnade wrote:
>>> Since the required clock is now available, add bluetooth.
>>>
>>> Note: Firmware (bts file) from device vendor reroutes tx for some time
>>> during initialisation and later put it back, producing timeouts in
>>> bluetooth initialisation but ignoring that command leads to proper
>>> initialisation.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>> Depends on: https://lore.kernel.org/linux-omap/20230916100515.1650336-6-andreas@kemnade.info/T/#u
>>>  arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
>>> index 9d2f2d8639496..25b80385dc1f0 100644
>>> --- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
>>> +++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
>>> @@ -478,10 +478,12 @@ &uart2 {
>>>  	interrupts-extended = <&wakeupgen GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
>>>  			       &omap4_pmx_core OMAP4_UART2_RX>;
>>>  
>>> -	/*
>>> -	 * BT + GPS in WL1283 in WG7500 requiring CLK32KAUDIO of pmic
>>> -	 * which does not have a driver
>>> -	 */
>>> +	bluetooth: tiwi {  
>>
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>> E.g. "bluetooth"
>>
> well, that is what I get currently as a reward from the kernel for describing
> the hardware and so the motivation for the patch, not necessarily the most important
> functionality.
> 
> But the over the uart runs the ti shared transport protocol (also there is
> a non dt compatible driver in drivers/misc/ti-st) which provides more than Bluetooth,
> e.g. it also provides at least GNSS and FM (although it do not know if it works in this particular
> hardware). GPS/GNSS should work.
> 
> So the node name would be bluetoothgnss then? Well, I think we do not need the label then.

bluetooth-gnss would work for me if it was accepted by bindings... but
it is not, so this leaves you so far with "bluetooth".

Best regards,
Krzysztof

