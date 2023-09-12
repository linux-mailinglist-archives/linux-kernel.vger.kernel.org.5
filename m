Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28779CF19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjILLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjILLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:01:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56C510D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:01:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so7140922a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694516467; x=1695121267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBOOTYnIbc7jXGk6LLtBsEP6Hing17bwVORuVZHF9dw=;
        b=BsCbKNsaHIKCI3UDtRCG1EjV6JYtUL6G7mk4P3SjbvqP553bIVjucSFHeRVVPGizqv
         JjEDX6qlFYY6skYeDxsQmkd8tumGmrpMzCyWBl5I7fnBYJpDqB5f7B8MlhzBW8l9hLYS
         PvzuMhPoCvQwuz/CdOdIPbya56YJTvwOA/G8Ko8zeqNOGtWb6IWM+783sxgJ0sOiQhst
         YTjOA68Ys89Z9CWAhtTYtrThc4xkAqy7U78d3NY8DfH5s6C5kjJz7PzqHIlAUieRh5M4
         WhHQn6pqYPcC1TiuPsKtQGcofBHzHGnqUIO9UaTRczSI7iWPrXGCySFAGHWn8AxH0kTX
         IBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694516467; x=1695121267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBOOTYnIbc7jXGk6LLtBsEP6Hing17bwVORuVZHF9dw=;
        b=XaiYaf8u3pBwZ4C69lOx3/PEmpfdJyCwU0ogiubPOcKg9Q+Ido1uFwETdi9oj8m+OW
         pGniSsuupxvJ2FL3t+xLqChDGtY61FbhmeWWi1nxIFZ0Eys5RA5Y3REmnDV2mI844ApB
         0tWnuhOA9dgqWeAIdL0mxlMrbqrV1F9sIHJSJxQtwi/1MAze/KvBNz7oX1PgfiSUMEFa
         3/9FERrsPZj9mhvxgph1p2mCUrLQwD2aP9YAfD2xJvgidGJKC+jSFQVnGLahj/w9NpW8
         xrLDhLMb8SNHt6SAVi1V4zWIts8vrHdFAeztq1PP7a0m3EFHPfxMeEQRZ3S7lkSwotGp
         CgBw==
X-Gm-Message-State: AOJu0YzX/tCrdVJP7QA4TXc37ME3Iij3wg9Xrd86biS0Nougwb4/QFB4
        ZJGQUCxj4k0y74Yf96t84zK7zg==
X-Google-Smtp-Source: AGHT+IF/AigYTNC1xfg71ULrrI6VsQI63f6+heLFLtnVSJ/ib4KvxtVvVDrFyHmCrhN5Lz3g9cf+RA==
X-Received: by 2002:aa7:c74c:0:b0:528:90d7:a1f with SMTP id c12-20020aa7c74c000000b0052890d70a1fmr10961153eds.10.1694516467067;
        Tue, 12 Sep 2023 04:01:07 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id be6-20020a0564021a2600b005224d960e66sm5724607edb.96.2023.09.12.04.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:01:06 -0700 (PDT)
Message-ID: <151c12f5-dc5b-3a25-f644-bd65775ae787@tuxon.dev>
Date:   Tue, 12 Sep 2023 14:01:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d29_curiosity: Add device tree
 for sama5d29_curiosity board
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mihai.Sain@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, andre.przywara@arm.com,
        Andrei.Simion@microchip.com, Jerry.Ray@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Cristian.Birsan@microchip.com
References: <20230801111151.6546-1-mihai.sain@microchip.com>
 <20230801111151.6546-2-mihai.sain@microchip.com>
 <14d628cf-a40c-11e6-7743-e3ba3bd8aa2d@tuxon.dev>
 <PH8PR11MB68049899CFD7947B0B3A03EF820BA@PH8PR11MB6804.namprd11.prod.outlook.com>
 <9ce18601-02d8-686e-ebe0-04c5dc29f6c9@tuxon.dev>
 <18943157-a1fb-0fda-e3d4-e0478d18a849@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <18943157-a1fb-0fda-e3d4-e0478d18a849@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nicolas, Mihai,

On 11.09.2023 19:01, Nicolas Ferre wrote:
> Hi Mihai, Claudiu,
> 
> First of all, thanks a lot for your help on this board DT, that's great!
> 
> On 03/08/2023 at 11:09, claudiu beznea wrote:
>> Hi, Mihai,
>>
>> On 02.08.2023 15:19,Mihai.Sain@microchip.com  wrote:
>>>> +&macb0 {
>>>> +     pinctrl-names = "default";
>>>> +     pinctrl-0 = <&pinctrl_macb0_default &pinctrl_macb0_phy_irq>;
>>>> +     #address-cells = <1>;
>>>> +     #size-cells = <0>;
>>>> +     phy-mode = "rmii";
>>>> +     status = "disabled";
>>> Should any phy/mdio container be placed here? Also, any reason this node
>>> is disabled?
>>> The board has no phy.
>>> We will add external phy boards to macb interface and they will be
>>> present in dt-overlay.
>>>
>> Then remove the macb0 node from here and keep it in overlay.
> 
> What about choosing a phy and making it enabled by default. Because I doubt
> people will use this board without a phy under Linux, honestly.
> Overlays would remove this "by default" node and add the replacing phy if
> hardware plugged-in is different.

The only thing about it (FMPOV) is that there might be people expecting the
default bindings to work with every PHY.

> 
> By doing this we avoid having difficult situations where the most used phy
> with this board is disabled or non existant and that we absolutely need an
> overlay for such a basic thing as having Ethernet working out-of-the-box...

I undestand your POV but DTS should describe the hardware. At least, is
there any PHY shipped with the board to be considered the default one?

SAMA5D3 EDS uses the same approach: it defines individual overlays for each
supported ethernet PHYs.

Thank you,
Claudiu Beznea

> 
> Just my $0.02, but it might simplify our life in the long run...
> 
> Best regards,
>   Nicolas
