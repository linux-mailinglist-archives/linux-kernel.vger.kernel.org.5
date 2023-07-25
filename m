Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45722760CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGYI2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjGYI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:27:55 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4070A10F8;
        Tue, 25 Jul 2023 01:27:33 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 90D1C83D4;
        Tue, 25 Jul 2023 16:27:31 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Jul
 2023 16:27:31 +0800
Received: from [192.168.125.84] (183.27.99.135) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Jul
 2023 16:27:30 +0800
Message-ID: <62ddb368-d714-8986-9904-2e44edfb069c@starfivetech.com>
Date:   Tue, 25 Jul 2023 16:27:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 1/5] ASoC: dt-bindings: Add StarFive JH7110 dummy
 PWM-DAC transmitter
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
 <20230626110909.38718-2-hal.feng@starfivetech.com>
 <006ddacd-0496-70d1-3310-99b16706de84@linaro.org>
 <0312262c-28c0-9445-c6f7-2079a57db8c7@starfivetech.com>
 <c0244a98-4c91-93d8-a3e4-5210d0b3f205@linaro.org>
 <d046796e-34a0-56e5-a740-6a1fcf41d216@starfivetech.com>
Content-Language: en-US
In-Reply-To: <d046796e-34a0-56e5-a740-6a1fcf41d216@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.99.135]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 11:22:50 +0800, Hal Feng wrote:
> On Sat, 1 Jul 2023 10:17:51 +0200, Krzysztof Kozlowski wrote:
>> On 30/06/2023 03:57, Hal Feng wrote:
>>> On Mon, 26 Jun 2023 17:34:56 +0200, Krzysztof Kozlowski wrote:
>>>> On 26/06/2023 13:09, Hal Feng wrote:
>>>>> Add bindings for StarFive JH7110 dummy PWM-DAC transmitter.
>>>>
>>>> ...
>>>>
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - "#sound-dai-cells"
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    pwmdac-dit {
>>>>> +        compatible = "starfive,jh7110-pwmdac-dit";
>>>>> +        #sound-dai-cells = <0>;
>>>>
>>>> BTW, I don't see any resources here. Neither in the driver. I think you
>>>> just added this for driver, not for a real hardware.
>>> 
>>> Yes, this is a dummy PWM-DAC transmitter as described in the title. The
>>> StarFive JH7110 PWM-DAC module doesn't need a hardware codec, but a
>>> dummy codec is needed for the driver.
>> 
>> Bindings are no for drivers, therefore with such reasoning the answer
>> is: drop entire binding. If you think otherwise, please give me some
>> more details about the hardware.
> 
> I agreed. I will drop this binding and the compatible in patch 2. Thanks.

Hi, Krzysztof,

Could I use the dummy spdif codec [1][2] which is already upstream? The dummy
spdif codec is really compatible with the one which JH7110 PWM-DAC needed.
They are mostly similar.

[1] Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
[2] sound/soc/codecs/spdif_transmitter.c

In that way, patch 1 & 2 can be dropped and patch 5 will be modified as follows.

+	pwmdac_dit: pwmdac-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "left_j";
+			bitclock-master = <&sndcpu0>;
+			frame-master = <&sndcpu0>;
+
+			sndcpu0: cpu {
+				sound-dai = <&pwmdac>;
+			};
+
+			codec {
+				sound-dai = <&pwmdac_dit>;
+			};
+		};
+	};

Best regards,
Hal
