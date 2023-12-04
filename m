Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE864803F3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjLDUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:25:25 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB978CB;
        Mon,  4 Dec 2023 12:25:31 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50be03cc8a3so3969889e87.1;
        Mon, 04 Dec 2023 12:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701721530; x=1702326330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4zwTB/miMPtSWCRzH5LYRAkGFmdPgzBkW3R45x59/A=;
        b=BCLHeL/oROUHSd9M3gfWOOFd6Tt/19UvDPvMIVmG3eOBtzzLYLmueFDaFx7YkFXUOO
         mBmJJvSoqOcH1WPn1JKnSP8aMHVIAyxG6uHLZW4TB8b/uUWGUIGHmnocd4SGMiDfpAOj
         Xmh0pSlkqfLKKMZ7nRLJYvxGXixFO5ASKL8/L1PEP1ViexgsHblasNVv/jIVKnrdtO29
         wkP3YOhbo/GXnaJkaCt36fEx8AhRgalOlviWTE3EmaWhO9Bm9WMvDT9lk/XqqGbQBF1L
         c2MmB/pgmD1MOtm2i5yvHE/iwuFSH+nuW5vUCfynI0Jsf425QeCHdusjsDcVxWfxdTIz
         NC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721530; x=1702326330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4zwTB/miMPtSWCRzH5LYRAkGFmdPgzBkW3R45x59/A=;
        b=N8wM2j60MfiF/ocPFu8F7jKZpz/F3dAKNuiA7bYqr1BznkTA+IPpaFsGxTdq5jAy19
         mGtVScA94SBsMpQzqAKyYXfc0sCIlpQzDk3IBCXzeeH0l8AtP6f8ksanC1lx+ClL7vE0
         pDjr2CH0kEfbeU2UM0kkcWi7Zi7c5orqYlmr2FxRYva8bmFb7XvRkk7IXxiQ1lg0AZTh
         mHK65tezXglPQk1UBxc4nar5tXqI3KKPv5sLglVGtevt3nNjDtCKW7xT4ZeyNPiJTzod
         uCC28iBCCk9uolUSb80NNq4dypTXOGu61nDKsg/MVy076JPqpTIFrSY2kGt75kklovWM
         3mEA==
X-Gm-Message-State: AOJu0Yxvs8QyDvVSOxe8NF6Y/gdz/WcJdG7Pp5AeYc9v6YyrXWbS4SOH
        W3kOfQ5sBU/9/GlzPwmowfo=
X-Google-Smtp-Source: AGHT+IHghfI/wepGC1I4yJLErrynLmDWoNAeInmFJJD7a8PBE9bsHDIMPexR8UEVinabv/Xruuf+Ew==
X-Received: by 2002:a05:6512:2343:b0:50b:fcd6:cb10 with SMTP id p3-20020a056512234300b0050bfcd6cb10mr904083lfu.130.1701721529711;
        Mon, 04 Dec 2023 12:25:29 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f4-20020a056402150400b0054c9df4317dsm180568edw.7.2023.12.04.12.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 12:25:29 -0800 (PST)
Message-ID: <bdda61be-8e02-36f5-6261-37d4b75278ba@gmail.com>
Date:   Mon, 4 Dec 2023 21:25:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/3] ARM: dts: rockchip: rk3036-kylin: add
 hdmi-connector node
Content-Language: en-US
To:     Alex Bee <knaerzche@gmail.com>, heiko@sntech.de, hjc@rock-chips.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
 <f5bc182b-f9b6-26a8-8649-19ce33e3c0e1@gmail.com>
 <447b1bde-584f-4eb4-8bfb-9abd3aa8b6fa@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <447b1bde-584f-4eb4-8bfb-9abd3aa8b6fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex, Heiko,

On 12/4/23 20:12, Alex Bee wrote:
> Hi Johan,
> Am 04.12.23 um 18:40 schrieb Johan Jonker:
>> Add hdmi-connector node to comply with the inno_hdmi binding.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   arch/arm/boot/dts/rockchip/rk3036-kylin.dts | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
>> index 67e1e04139e7..a213333be011 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
>> +++ b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
>> @@ -13,6 +13,17 @@ memory@60000000 {
>>           reg = <0x60000000 0x20000000>;
>>       };
>>
>> +    hdmi_con: hdmi-con {
>> +        compatible = "hdmi-connector";
>> +        type = "c";


> According to [0], kylin has an A-Type HDMI port - so this should be
>  +        type = "a";
> > [0] http://rockchip.wikidot.com/kylin

Not sure from the text or do I miss something...

I did look at that board picture before submitting.
Can be wrong, but to me it looks a smaller HDMI connector.

Does anyone have a Kylin picture from a different angle?
Or reference design?

Else apply and fix later? (Heiko ?)
Let me know.

Johan

> 
> Regards,
> Alex
>> +
>> +        port {
>> +            hdmi_con_in: endpoint {
>> +                remote-endpoint = <&hdmi_out_con>;
>> +            };
>> +        };
>> +    };
>> +
>>       leds: gpio-leds {
>>           compatible = "gpio-leds";
>>
>> @@ -110,6 +121,12 @@ &hdmi {
>>       status = "okay";
>>   };
>>
>> +&hdmi_out {
>> +    hdmi_out_con: endpoint {
>> +        remote-endpoint = <&hdmi_con_in>;
>> +    };
>> +};
>> +
>>   &i2c1 {
>>       clock-frequency = <400000>;
>>
>> -- 
>> 2.39.2
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
