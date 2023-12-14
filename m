Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2C81349D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573760AbjLNPWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573678AbjLNPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:22:47 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80A120;
        Thu, 14 Dec 2023 07:22:53 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c580ba223so28079585e9.3;
        Thu, 14 Dec 2023 07:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702567372; x=1703172172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8729+GpJIaJexZ1ARUqsjnhie8XgW0co3vRcD9snPkc=;
        b=cBMBNZW0UXYr2meCbLrhowrUJDLCr/ygSaD8rsanF3qHwo8n3hUZlnQAWa0tNXNATu
         ik4a2Di5xfJeXj234wH2Jq3eV+Gq9HptduOervFiXeKekk8D8ELoAeHCDhG4IhWWbOm4
         REJ9xR/9h5/GUnvnLhjBlIkJMHR9tHo1Hlqo5Yg2U5yEEzfagX3qU4d2/EtmKOgOygE0
         Jo2kddC4rfsRvaG+ObGROVOBbSKH+SA0SXPGHDww0jlKjFKNMhPu5yO46odqqpn49UWO
         heXGRp3FgqLWQD0JeqIxBzpsJph+/M4ev+hb4M3+XE3PeSsa8Gx3nEC733rB74Y0Y0ol
         8wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567372; x=1703172172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8729+GpJIaJexZ1ARUqsjnhie8XgW0co3vRcD9snPkc=;
        b=VzgpnFpyeTQxa3M/h/xarSQ13jMhEQpa8+Oq2DSuRUwxikN/GkmhIhN34hW5E2OqOA
         GNEDEaXY0TO09pSG/AQYN5phckRn/2wY5PXdo/+DWLLKpCRJ5Ta2Da2K7HoH+oxA2vkg
         QPPexHnt94XISUxEWAwllMyZKfQf1T+83twV6eR3dZA5MinuZBg08EKWJPz/d0+ATVNi
         HQbptOJGi5p6ihGlcUV1QMNbZ4SjBnOfUu8lrGjM5Iwltmj6QWs0w46f1dBeE3Z5npBD
         rdIWjz+xBG26XZY463oPOxzbfuVfflA1KfyRJDNpEoa4jHv59rvdDYvMSwaLUBVF4lXB
         D1Ew==
X-Gm-Message-State: AOJu0YyExh/XdB1xZ09be/p8DFaGpG7vTzsSrc3pGbNwDbVjKq6m4uYB
        2EAYLi987TjDYtmhdQQXOQ==
X-Google-Smtp-Source: AGHT+IFSSfoKJnB1Fn5EpXxKahq1aL1UT1b1HTYMrjLf8nAPnhLq7mpyYAelUamEJbOffEM85r3ZpA==
X-Received: by 2002:a05:600c:3794:b0:40b:56f3:df64 with SMTP id o20-20020a05600c379400b0040b56f3df64mr5492295wmr.40.1702567371645;
        Thu, 14 Dec 2023 07:22:51 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:fb6a:140c:b21d:7387? ([2a02:810b:f40:4300:fb6a:140c:b21d:7387])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0040c45071c18sm17050981wmo.39.2023.12.14.07.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 07:22:51 -0800 (PST)
Message-ID: <288857ab-bebd-4f80-9cdc-9b04fa6c7386@gmail.com>
Date:   Thu, 14 Dec 2023 16:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] dt-bindings: display: rockchip,inno-hdmi: Document
 RK3128 compatible
Content-Language: en-US, de-DE
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <20231213195125.212923-2-knaerzche@gmail.com>
 <c4e394c6-c21f-4102-8c3a-f9530c0ca547@linaro.org>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <c4e394c6-c21f-4102-8c3a-f9530c0ca547@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 14.12.23 um 08:53 schrieb Krzysztof Kozlowski:
> On 13/12/2023 20:51, Alex Bee wrote:
>> Document the compatible for RK3128's HDMI controller block.
>> The integration for this SoC is somewhat different here: It needs the PHY's
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
OK. Not sure why checkpatch --strict  didn't tell me that I'm over the 
limit here.
>
>> reference clock rate to calculate the ddc bus frequency correctly. This
>> clock is part of a power-domain (PD_VIO), so this gets added as an optional
>> property too.
> If clock is part of power domain, then the power domain must be in the
> clock controller, not here. So either you put power domain in wrong
> place or you used incorrect reason for a change.
  Rockchip defines it's powerdomains per clock and I was little to much 
in that world when writing this. Actually the controller itself is part 
of the powerdomain. Will rephrase.
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   .../display/rockchip/rockchip,inno-hdmi.yaml  | 30 +++++++++++++++++--
>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>> index 96889c86849a..9f00abcbfb38 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>> @@ -14,6 +14,7 @@ properties:
>>     compatible:
>>       enum:
>>         - rockchip,rk3036-inno-hdmi
>> +      - rockchip,rk3128-inno-hdmi
>>   
>>     reg:
>>       maxItems: 1
>> @@ -22,10 +23,21 @@ properties:
>>       maxItems: 1
>>   
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    items:
>> +      - description: The HDMI controller main clock
>> +      - description: The HDMI PHY reference clock
>>   
>>     clock-names:
>> -    const: pclk
>> +    minItems: 1
>> +    items:
>> +      - const: pclk
>> +      - enum:
>> +          - pclk
>> +          - ref
> That's way overcomplicated. Just items listing the names and minItems:
> 1. See other bindings how this is done.
OK.
>> +
>> +  power-domains:
>> +    maxItems: 1
> Is it relevant to existing device?

Will move to new variant only.

Alex

>>   
>>     ports:
>>       $ref: /schemas/graph.yaml#/properties/ports
>> @@ -55,6 +67,20 @@ required:
>>     - pinctrl-names
>>     - ports
>
> Best regards,
> Krzysztof
>
