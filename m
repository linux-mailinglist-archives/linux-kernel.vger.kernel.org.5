Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34976E3FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjHCJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjHCJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:10:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D7DA2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:10:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5230ac6dbc5so764421a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691053801; x=1691658601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2cw0wayVSzVuqV6zzYVAtwM8IizTE7OpHCKF3YPLhQ=;
        b=GzaWUW03Toqq2BPzNsVDWewgs8jRA/7855gKFjz3MwzJyeUT6VAdPfiFEw7DcCdEo3
         dmmOguWJuGOL1jTf1MbBBEAeM+u7YINCI7xkk4kT5KyxAgXKwL4ATGc0nhOwnzoOuRjV
         chbQ4YaztBoBoyBeBvG3tS2JvfRa2Z/rec59vmAT+C6yME/S/evrQaE7MwlpuQ/WRz+Y
         a/xbC+P+PQgYTyVVzhAuUw/20uSYErMmHNxhfuTkG5jI/IyvEtctTq9+EEdP2b6bgEiD
         9hSYlwSa2YtuilbItQFmw2ic90cyBNTRngnU7LoMEI3r/MDz5guTp2hfFT0SkRCN2hmE
         MX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691053801; x=1691658601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2cw0wayVSzVuqV6zzYVAtwM8IizTE7OpHCKF3YPLhQ=;
        b=VggqBLBd1F0jprnh2ie0STE9dWepH/a2Px2QrnxUaXV1rwMSXjLMoZqlph6+sXB4of
         5GZiOUSSeBqba12wTLGDkBefqNuUpA+8IXKSKVTKSLE/oL7DXR1qkYdxgERRGYbycaiD
         NPk0KyEh5F18cUk73G/rvDRwTyVy76RCaQqqQ2uHE/eW/8EY8GsXw/WbIGheZHebLWY7
         qw168Jb0+vmMY6m6vWhBekBTIIgs5eAMudOI8Ipc2oux9+zmVRBi/1PLi4nht99Vs1+9
         NgCqe2UjN9fE+2boKV8guy3ERHzWu+2J8OSpN7HgbE0WNpdl2MrTg0lXkpHPQrhiI4rp
         s7KA==
X-Gm-Message-State: ABy/qLbQNrQA6Czycaf0zCZuhUltWmNX7fswOhcOFuR2mv1R1qi4ZFAI
        Xm9hCtlpf27x1hOsxt51i8Ow4g==
X-Google-Smtp-Source: APBJJlETmkJO+gxf62JP8pX11wPIAW5w/MW+++ebMDSrwKQ7T5rcJO5ApgKDMRXfwC+P58gqMf1OVQ==
X-Received: by 2002:aa7:cb58:0:b0:522:201f:dee8 with SMTP id w24-20020aa7cb58000000b00522201fdee8mr7304635edt.0.1691053801268;
        Thu, 03 Aug 2023 02:10:01 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id l5-20020aa7cac5000000b005222dd0b2fbsm7436686edt.92.2023.08.03.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 02:10:00 -0700 (PDT)
Message-ID: <9ce18601-02d8-686e-ebe0-04c5dc29f6c9@tuxon.dev>
Date:   Thu, 3 Aug 2023 12:09:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d29_curiosity: Add device tree
 for sama5d29_curiosity board
Content-Language: en-US
To:     Mihai.Sain@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        andre.przywara@arm.com, Andrei.Simion@microchip.com,
        Jerry.Ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Cristian.Birsan@microchip.com
References: <20230801111151.6546-1-mihai.sain@microchip.com>
 <20230801111151.6546-2-mihai.sain@microchip.com>
 <14d628cf-a40c-11e6-7743-e3ba3bd8aa2d@tuxon.dev>
 <PH8PR11MB68049899CFD7947B0B3A03EF820BA@PH8PR11MB6804.namprd11.prod.outlook.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <PH8PR11MB68049899CFD7947B0B3A03EF820BA@PH8PR11MB6804.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mihai,

On 02.08.2023 15:19, Mihai.Sain@microchip.com wrote:
>> +&macb0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_macb0_default &pinctrl_macb0_phy_irq>;
>> +     #address-cells = <1>;
>> +     #size-cells = <0>;
>> +     phy-mode = "rmii";
>> +     status = "disabled";
> Should any phy/mdio container be placed here? Also, any reason this node is disabled?
> The board has no phy.
> We will add external phy boards to macb interface and they will be present in dt-overlay.
> 

Then remove the macb0 node from here and keep it in overlay.

Thank you,
Claudiu Beznea
