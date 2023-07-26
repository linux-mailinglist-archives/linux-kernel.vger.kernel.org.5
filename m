Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76722763749
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjGZNPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjGZNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:15:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C61FEC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:15:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bcf2de59cso35905966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690377333; x=1690982133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxpwGdqfKpW+2bA8L4L3lh4iGcowSXsRVpwai0mk4fQ=;
        b=aBmywB8kJps6NL8kYvNQkYJixI+qt0vHUmnmDQL+JaHi33F/2lIJLWXRTW3t4o7Mlg
         WrZHD3nyD/VyY+S65kqDZHPdUpACQQ8+BmX+U2PHnDrXJf53acmFV/x4JCy690s4zc2Y
         FYMegG8v2565mbDeZbI+3sPoFAg7DZSiGauJTCuhHbG+zmA0iCkRf1tEhQ5U/dyUOal5
         +kx9DKbzGtWh4Jg8uwEE30I7NPXDCyQQnLrmaIB1tMw+ZpvqNTMw8zKC6iDUagMHBrDZ
         OUaGlbtQGbQFid4ezBHNIomlTBjv4/DghU5y/GAhxkiATl+b6cycISfJwr162uJLLuSo
         l94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377333; x=1690982133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxpwGdqfKpW+2bA8L4L3lh4iGcowSXsRVpwai0mk4fQ=;
        b=ddZuwOlFVY6VZBBFXdmmU13WvdCYgHGveWHyb1gDGFSbNfpgnfRXKWwGOWxqdRpppW
         mlgobnE/nK9DvdaXaYc9uymBwppfjjA4EVSI47CjtOPcLV4kGoaIIQP6m7fu98Wa2Cby
         MiZNgDShJnLyRtKAnLqanu4Ll/HZHvQIjtv4hxSbNerxo7vLzBYM8d/xzupbTVArmflb
         M5EsGOAELdhIrJgugrllf8ON6zETSMUu1oI7yUq5i9ohpw+QqfSKpBrAv5VjwcVsQhSU
         ThhT+Y8/iy/n7CbdnnP1q8UDvCSSGdBEcMe7fpAOGdHriPkTzLP5WqfdVowpHl/ZYxI1
         Q0sw==
X-Gm-Message-State: ABy/qLajFYzJAcg12NCeUokMDQMDAxk2Tuii7HhSsJIE7r6nZ2WMOQLJ
        Ty6rhlJTeOKz2SywJmf5fp7+Tw==
X-Google-Smtp-Source: APBJJlFMhteteZfyviZtv4MyvkzBxODZxA8tpAKbuYijpc64a+D7iboNckbTfSv3dVIDPN6HQHdc/w==
X-Received: by 2002:a17:906:64cc:b0:994:539d:f97f with SMTP id p12-20020a17090664cc00b00994539df97fmr1726109ejn.37.1690377332545;
        Wed, 26 Jul 2023 06:15:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709064e0900b009886aaeb722sm9518979eju.137.2023.07.26.06.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:15:31 -0700 (PDT)
Message-ID: <453c362a-c9bf-1cd4-187c-8916ed406c64@linaro.org>
Date:   Wed, 26 Jul 2023 15:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/8] AMR: dts: imx28-m28evk: populate fixed regulators
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
 <20230726070322.103871-3-krzysztof.kozlowski@linaro.org>
 <CAOMZO5C1JN7w+LhK-J0_ttKVopyeRq6VmCpAHujN_tGPMobotA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOMZO5C1JN7w+LhK-J0_ttKVopyeRq6VmCpAHujN_tGPMobotA@mail.gmail.com>
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

On 26/07/2023 15:08, Fabio Estevam wrote:
> Patches 1, 2, 3, and 4 have a typo in the Subject: s/AMR/ARM.
> 
> On Wed, Jul 26, 2023 at 4:03 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Fixed regulators put under "regulators" node will not be populated,
>> unless simple-bus or something similar is used.  Drop the "regulators"
>> wrapper node to fix this.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts | 45 ++++++++++------------
>>  1 file changed, 20 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts b/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
>> index e350d57a4cec..6bf26f386a5e 100644
>> --- a/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
>> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
>> @@ -18,33 +18,28 @@ backlight {
>>                 default-brightness-level = <6>;
>>         };
>>
>> -       regulators {
>> -               reg_vddio_sd0: regulator@1 {
>> -                       compatible = "regulator-fixed";
>> -                       reg = <1>;
>> -                       regulator-name = "vddio-sd0";
>> -                       regulator-min-microvolt = <3300000>;
>> -                       regulator-max-microvolt = <3300000>;
>> -                       gpio = <&gpio3 28 0>;
>> -               };
>> +       reg_vddio_sd0: regulator-1 {
> 
> It should be better to write:
> 
> reg_vddio_sd0: regulator-vddio-sd0 {
> 
> regulator-1 is not very descriptive.

Node names should be generic, not descriptive. These are old sources, so
they do not use fully override-by-phandle/label style, thus with
existing naming I reduce the chances of wrong overrides in some other
board or DTSI.

Best regards,
Krzysztof

