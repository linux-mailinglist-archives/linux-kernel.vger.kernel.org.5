Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35B075AD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGTLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGTLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:39:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D273136
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:39:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso886899a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689853176; x=1690457976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpDIiAHaPUZVf5LebjEBr8OH0I3cBK4Zu9lxXtRN+j8=;
        b=yVqkZqcvP1/+Xhmydsg4zm2sTYnSjVetXHtNE0auHaDTtZwn8I1ns+rxjYXCd5OiEX
         p2bThGpbj3BfVYsXW2tApUdi+pi9ImbMnt+yyL/4CteviSlUlZhqAfuX3t+KPeGuFP4d
         vaRCBwExruSm0uzrQBFfy03kZiBpJfmzQq6cLlp86WJ5a+X2Oz/KUyVyXgBGfUWfKoR6
         5Z9FnkaDelLmlwyn6YzpBnukfaw9XybkIYevo6UW93mHv6kWLLSiXuwM4gKjLiI66+dY
         ODfIX2repgCD1Jh4ATCuiRm53/lluDGhFYR0AYtIihFdpI+ntP2KMQB/t2gIY13JhWIv
         6BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853176; x=1690457976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpDIiAHaPUZVf5LebjEBr8OH0I3cBK4Zu9lxXtRN+j8=;
        b=PNkDs5hWE2ooVqSxMhr7y1i6at5zBIQv2cs7ggZQmnqScrP8Er4ypnQcZtCWxJA5w3
         DBWDP7qJEnbMMydLUg3wi9aek6MAF8ZWad8QNpKWsnFPoS3dqAt8ReM1N0fNm0uc2kVp
         CQKoPImttMGdeX6R/VL/mE+LXr2XR4TqcIqk7OPxz2dYLzf+NRgQSGZkhZxEmIVZRpiL
         wBzooohSbEWW/xmJbs6qCvRzRBaLznnFlClx1LjajqRwTf+mEzB4AHPLrzyE9prsyUEO
         Xe7wmCqJhCyuDKyeZiZIbMa/pG46bfueGDvaBXNZtnw0v6+49Vf/w1VjRO/GWdRTIqi4
         kDWQ==
X-Gm-Message-State: ABy/qLb+tSvZ8JfyOtZgDYQRHw6pNWeS8spaukDs9SYF1DMGvQ4XCUCt
        020d2L0H/DCpJF/s4+r8z/Pa8g==
X-Google-Smtp-Source: APBJJlHukb8lIEJ+Bf8COr7m61XARCKx+7qoKXiobz6DCgQy8cBqj8R4tJQqWqqjOINxssXSF+LADA==
X-Received: by 2002:aa7:d888:0:b0:51e:1858:693a with SMTP id u8-20020aa7d888000000b0051e1858693amr4261855edq.31.1689853175786;
        Thu, 20 Jul 2023 04:39:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k6-20020a056402048600b0051bfc85afaasm631304edv.86.2023.07.20.04.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 04:39:35 -0700 (PDT)
Message-ID: <c70e397e-dee8-2155-9f0b-538e95bda2eb@linaro.org>
Date:   Thu, 20 Jul 2023 13:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board
 support
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230719224141.3716815-1-james.hilliard1@gmail.com>
 <20230719224141.3716815-2-james.hilliard1@gmail.com>
 <0ad5a223-d70f-deaa-6261-a2bd2b2af40d@linaro.org>
 <CADvTj4qvXvuV=ASg5h4hPr8QG-NR48j6G36AZC5xHDdhLyjT7w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADvTj4qvXvuV=ASg5h4hPr8QG-NR48j6G36AZC5xHDdhLyjT7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 12:49, James Hilliard wrote:
> On Thu, Jul 20, 2023 at 12:15 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/07/2023 00:41, James Hilliard wrote:
>>> This patch adds support for the Variscite MX6 SoM Carrier Board.
>>>
>>> This Carrier-Board has the following :
>>> - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
>>> - HDMI Connector
>>> - USB Host + USB OTG Connector
>>> - 10/100/1000 Mbps Ethernet
>>> - miniPCI-Express slot
>>> - SD Card connector
>>> - Audio Headphone/Line In jack connectors
>>> - S-ATA
>>> - On-board DMIC
>>> - RS485 Header
>>> - CAN bus header
>>> - SPI header
>>> - Camera Interfaces header
>>> - OnBoard RTC with Coin Backup battery socket
>>> - RS232 Debug Header (IDC10)
>>> - RS232 DTE
>>>
>>> Product Page : https://www.variscite.com/product/single-board-computers/var-mx6customboard
>>>
>>> The dts file based on the ones provided by Variscite on their own
>>> kernel, but adapted for mainline.
>>>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>> ---
>>>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>> warnings can be ignored, but the code here looks like it needs a fix.
>> Feel free to get in touch if the warning is not clear.
>>
>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>  .../arm/boot/dts/imx6q-var-mx6customboard.dts | 279 ++++++++++++++++++
>>>  3 files changed, 281 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/imx6q-var-mx6customboard.dts
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> index 15d411084065..0f583852de8a 100644
>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> @@ -298,6 +298,7 @@ properties:
>>>                - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
>>>                - uniwest,imx6q-evi         # Uniwest Evi
>>>                - variscite,dt6customboard
>>> +              - variscite,mx6customboard
>>>                - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
>>>                - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux board
>>>                - ysoft,imx6q-yapp4-pegasus # i.MX6 Quad Y Soft IOTA Pegasus board
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 59829fc90315..9cfc3d3e91ea 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -665,6 +665,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>>       imx6q-udoo.dtb \
>>>       imx6q-utilite-pro.dtb \
>>>       imx6q-var-dt6customboard.dtb \
>>> +     imx6q-var-mx6customboard.dtb \
>>>       imx6q-vicut1.dtb \
>>>       imx6q-wandboard.dtb \
>>>       imx6q-wandboard-revb1.dtb \
>>> diff --git a/arch/arm/boot/dts/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/imx6q-var-mx6customboard.dts
>>> new file mode 100644
>>> index 000000000000..66047dff11ec
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/imx6q-var-mx6customboard.dts
>>> @@ -0,0 +1,279 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Support for Variscite MX6 Carrier-board
>>> + *
>>> + * Copyright 2016 Variscite, Ltd. All Rights Reserved
>>> + * Copyright 2022 Bootlin
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "imx6qdl-var-som.dtsi"
>>> +#include <dt-bindings/pwm/pwm.h>
>>> +
>>> +/ {
>>> +     model = "Variscite i.MX6 QUAD/DUAL VAR-SOM-MX6 Custom Board";
>>> +     compatible = "variscite,mx6customboard", "fsl,imx6q";
>>
>> Where is the SoM compatible?
> 
> I mostly just copied this from the DART-MX6 device tree which is
> another variscite
> imx6q based modular SoM custom board combination:
> https://github.com/torvalds/linux/blob/v6.5-rc2/arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dts#L17
> 
> The terminology is a bit confusing in general here, variscite has 2
> families of pin2pin
> modules, the "VAR-SOM" and the "DART" family.
> https://www.variscite.com/variscite-pin2pin-system-on-module-families/

I know, I am familiar with them.


> 
> Within each connector family there are then multiple SoM boards that
> can be used with the same carrier boards(ie the Custom Board carrier board
> like the evaluation kit) although they are often bundled together with specific
> boards in practice.

No, they are being shipped to the customers which then use them in their
products. Having common compatible can be useful, although it depends
what's in the common part. For example for IMX8 it was quite a lot, thus
it made sense.

> 
> So the existing DART-MX6 I think uses the same SoC but is in a different
> family and as such has a different carrier board. However as the relation
> between the SoM and the carrier board is effectively the same, I just copied
> the way compatibile is being set there for the VAR-SOM-MX6 from the
> existing DART-MX6 custom board device tree.
> 
> I think this roughly represents the SoM board device tree associations as I'm
> understanding them:
> 
> pin2pin Family: DART
> SoM: https://www.variscite.com/product/system-on-module-som/cortex-a9/dart-mx6-cpu-freescale-imx6/
> SoM part: DART-MX6
> SoM device tree: imx6qdl-var-dart.dtsi
> SoM SoC: imx6q
> Board: https://www.variscite.com/product/single-board-computers/dt6customboard/
> Board device tree: imx6q-var-dt6customboard.dts
> Board compatible: compatible = "variscite,dt6customboard", "fsl,imx6q";
> 
> pin2pin Family: VAR-SOM
> SoM: https://www.variscite.com/product/system-on-module-som/cortex-a9/var-som-mx6-cpu-freescale-imx6/
> SoM part: VAR-SOM-MX6
> SoM device tree: imx6qdl-var-som.dtsi
> SoM SoC: imx6q
> Board: mx6customboard
> https://www.variscite.com/product/single-board-computers/var-mx6customboard/
> Board device tree: imx6q-var-mx6customboard.dts
> Board compatible: compatible = "variscite,mx6customboard", "fsl,imx6q";
> 
> What's confusing here is that the DART-MX6 is also described as a SoM:
> "DART-MX6 from Variscite is the smallest System on Module (SoM) / Computer
> on Module (CoM) supporting NXP/Freescale’s i.MX6 Quad and Dual-core
> Cortex-A9™ processor"

It is not confusing. It is a SoM.

> 
> So we have a "DART-MX6" SoM part which corresponds to the "VAR-SOM-MX6"
> SoM part, with both being SoM's but only one("VAR-SOM-MX6") having SoM in
> the actual part name.

Vendor naming is one thing, but true meaning is second. These are
System-on-Modules.

> 
> Does the compatible section for imx6qdl-var-dart.dtsi look correct?
> 
> I'm not sure what exactly a "SoM compatible" should look like here as SoM is
> both a generic term(used to describe by both the "DART-MX6" and
> "VAR-SOM-MX6" parts) as well as term used within a part(used in the
> part for "VAR-SOM-MX6" as well as other SoM's in the "VAR-SOM" family
> but not the "DART-MX6" part or other SoM's in the "DART" family).

Take a look at IMX8 Variscite SoMs.

Best regards,
Krzysztof

