Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FB76BF4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHAV33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHAV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:29:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00723C3;
        Tue,  1 Aug 2023 14:29:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso37197365e9.3;
        Tue, 01 Aug 2023 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690925363; x=1691530163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvrJDYhMh0ipsbPLtlBKb2BJs11MXVwQDoPuVVK7f6M=;
        b=kEgM6t5w0gCQ99Zb4xGrUZS/0V5cGqtyVWtNpJAJJakP73exH890uNC5PtuWpR4/6l
         Q4x6tZNiHP8N43YvRzLN+TpWGkFv0I1ByF7pr146qk6ws9Ih773A38HbpPGYfFoZMAsv
         DYKODbyrKsn8aauPjYrlT+Ycf2KBFRca+mhEHQbI2AO4cHBwVDvb0pCz3IQUTdgGKeZz
         CKk7wpICDKe1BvCsfSMt2Hjt7QeNLYaZNsumcHjp5RPeduKmvsEp2EeDdkGQG6YmycOI
         chmHwTlBLcDeuN0fbHp/8A9WtLx4r5y8gRJ+LSEaXk67yyCCR5faGlsbTv2DlV45TbUk
         aSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690925363; x=1691530163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvrJDYhMh0ipsbPLtlBKb2BJs11MXVwQDoPuVVK7f6M=;
        b=H8yyVtuqvQyQpDXWDNj/ss/EnqpDVL5/3PogRX4yg86QagEzGH0kttx/l6zi0yeg8k
         9MCwCC46bb9odEuTU4aMawdCz5ibJUjYnBzflCHjJsd0EFufg6xqxwFU7mbpCZmIhdnt
         g8dXB4NlfjdHBFNTyfVyzWnivgFgyBGBd+WM9+8uhBkHze4xaJFKsxvIRPjTpexHAw4r
         hLUL4D+VomrOt75lEs0Ta+ypd7q0AO8KFSg8elQp8dYeKe1g48F7V6s+S32c+lOS8Jve
         UIfqSdbu7gauBcnkesn80yWBWbqkiD25L4WxkvAsmXA/fkegjgIBv+o/pW5l9xewhh8f
         nZRA==
X-Gm-Message-State: ABy/qLbM+OWENUBfj+h7df1zZsHIDQa9wytDr7+R63swr5tcS4BAlxM8
        Pfjftu0mCWwa/NaCRaJvvdBt8TM/9/qH0iTY
X-Google-Smtp-Source: APBJJlFTwE67qCLWrvjvM7nS+hdpSjfdyeAfkDg+wdrDBPbNEjGvOKRgjysckZ0D0y+5wqUUwc/tIg==
X-Received: by 2002:adf:ef8b:0:b0:307:8c47:a266 with SMTP id d11-20020adfef8b000000b003078c47a266mr3095894wro.61.1690925363133;
        Tue, 01 Aug 2023 14:29:23 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:e7fa:7d4d:a96f:4b43? ([2a02:908:8b3:1840:e7fa:7d4d:a96f:4b43])
        by smtp.gmail.com with ESMTPSA id z1-20020adfd0c1000000b0031424f4ef1dsm17257809wrh.19.2023.08.01.14.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 14:29:22 -0700 (PDT)
Message-ID: <310fda11-c74a-118a-9975-40e2cfd26465@gmail.com>
Date:   Tue, 1 Aug 2023 23:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] ARM: tegra: transformers: add connector node
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230618085046.10081-1-clamor95@gmail.com>
 <20230618085046.10081-3-clamor95@gmail.com> <ZMKJE1G87-jWeg2_@orome>
 <5A2447D3-DB49-4788-AA05-182AF0F04ED2@gmail.com> <ZMKgW6eYpJVqeZJM@orome>
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
In-Reply-To: <ZMKgW6eYpJVqeZJM@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27.07.23 18:50, Thierry Reding wrote:
> On Thu, Jul 27, 2023 at 07:26:28PM +0300, Svyatoslav Ryhel wrote:
>>
>>
>> 27 липня 2023 р. 18:11:15 GMT+03:00, Thierry Reding <thierry.reding@gmail.com> написав(-ла):
>>> On Sun, Jun 18, 2023 at 11:50:46AM +0300, Svyatoslav Ryhel wrote:
>>>> All ASUS Transformers have micro-HDMI connector directly available.
>>>> After Tegra HDMI got bridge/connector support, we should use connector
>>>> framework for proper HW description.
>>>>
>>>> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS TF T30
>>>> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101 T20
>>>> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201 T30
>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>> ---
>>>>  arch/arm/boot/dts/tegra20-asus-tf101.dts      | 22 ++++++++++++++++---
>>>>  .../dts/tegra30-asus-transformer-common.dtsi  | 21 ++++++++++++++++--
>>>>  2 files changed, 38 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
>>>> index c2a9c3fb5b33..97350f566539 100644
>>>> --- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
>>>> +++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
>>>> @@ -82,9 +82,11 @@ hdmi@54280000 {
>>>>  			pll-supply = <&hdmi_pll_reg>;
>>>>  			hdmi-supply = <&vdd_hdmi_en>;
>>>>  
>>>> -			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
>>>> -			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
>>>> -				GPIO_ACTIVE_HIGH>;
>>>> +			port@0 {
>>>> +				hdmi_out: endpoint {
>>>> +					remote-endpoint = <&connector_in>;
>>>> +				};
>>>> +			};
>>>
>>> Does this need a bindings change? nvidia,tegra20-hdmi currently doesn't
>>> support OF graphs, so this would probably fail to validate if we merge
>>> it without a corresponding DT bindings update.
>>
>> drm/tegra patch is backwards compatible and connector node is optional.
> 
> We still need to document the connector node, otherwise the DT
> validation will complain about port@0 being used here, won't it?

this change indeed causes several new warnings:

    /mnt/linux/.output/arch/arm/boot/dts/tegra20-asus-tf101.dtb: hdmi@54280000: 'port@0' does not match any of the regexes: 'pinctrl-[0-9]+'
            From schema: /mnt/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
    /mnt/linux/.output/arch/arm/boot/dts/tegra20-asus-tf101.dtb: hdmi@54280000: 'nvidia,ddc-i2c-bus' is a required property
            From schema: /mnt/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
    /mnt/linux/.output/arch/arm/boot/dts/tegra20-asus-tf101.dtb: hdmi@54280000: 'nvidia,hpd-gpio' is a required property
            From schema: /mnt/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml

BTW, the parallel RGB port isn't properly documented in nvidia,tegra20-dc either.

Best regards,
Maxim
