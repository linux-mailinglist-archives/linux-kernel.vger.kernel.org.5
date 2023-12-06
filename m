Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F24806B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377301AbjLFJ4m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 04:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjLFJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:56:40 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCA0FA;
        Wed,  6 Dec 2023 01:56:44 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C6B9C24E2B7;
        Wed,  6 Dec 2023 17:56:36 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 17:56:36 +0800
Received: from [192.168.125.88] (183.27.97.199) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 17:56:35 +0800
Message-ID: <0447c983-ee90-475e-9356-ad451f32da1d@starfivetech.com>
Date:   Wed, 6 Dec 2023 17:53:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Add waveshare 7inch touchscreen panel support
Content-Language: en-US
To:     Stefan Wahren <wahrenst@gmx.net>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
        <sam@ravnborg.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <florian.fainelli@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <thierry.reding@gmail.com>, <changhuang.liang@starfivetech.com>,
        <keith.zhao@starfivetech.com>, <jack.zhu@starfivetech.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231124104451.44271-1-shengyang.chen@starfivetech.com>
 <dab03c60-caa9-47e3-9dac-fa499227b67b@gmx.net>
From:   Shengyang Chen <shengyang.chen@starfivetech.com>
In-Reply-To: <dab03c60-caa9-47e3-9dac-fa499227b67b@gmx.net>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.97.199]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stefan

Thanks for your comment and review

On 2023/11/24 22:54, Stefan Wahren wrote:
> Hi Shengyang,
> 
> [fix address of Emma]
> 
> Am 24.11.23 um 11:44 schrieb Shengyang Chen:
>> This patchset adds waveshare 7inch touchscreen panel support
>> for the StarFive JH7110 SoC.
>>
>> Patch 1 add new compatible for the raspberrypi panel driver and its dt-binding.
>> Patch 2 add new display mode and new probing process for raspberrypi panel driver.
>>
>> Waveshare 7inch touchscreen panel is a kind of raspberrypi panel
>> which can be drived by raspberrypi panel driver.
>>
>> The series has been tested on the VisionFive 2 board.
> surprisingly i was recently working on the official Raspberry Pi
> touchscreen and was able to get it running the new way.
> 
> What do i mean with the new way. There is almost nothing special to the
> Raspberry Pi touchscreen, so we should try to use/extend existing
> components like:
> 
> CONFIG_DRM_PANEL_SIMPLE
> CONFIG_TOUCHSCREEN_EDT_FT5X06
> CONFIG_DRM_TOSHIBA_TC358762
> 
> The only special part is the Attiny on the connector PCB which requires:
> 
> CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY
> 
> So the whole point is to avoid writing monolitic drivers for simple
> panel like that.
> 
> There is a WIP branch based on top of Linux 6.7-rcX, which should
> demonstrate this approach [1]. Unfortunately it is not ready for
> upstreaming, but it has been tested on a Raspberry Pi 3 B Plus. Maybe
> this is helpful for your case.
> 
> Actually i consider panel-raspberrypi-touchscreen.c as a dead end, which
> shouldn't be extended.
> 
> Btw there are already DT overlays in mainline which seems to use the
> Raspberry Pi 7inch panel (without touch function yet) [2].
> 
> [1] - https://github.com/lategoodbye/rpi-zero/commits/v6.7-7inch-ts
> [2] -
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtso?h=v6.6.2&id=6b4da1354fd81adace0cda448c77d8f2a47d8474
> 

Thank you very much for your advice. We will try this method before making new patch.
This method will be used if its verified in our soc.
If there is any problem, we may continue to contact. Thanks a lot.

>>
>> Shengyang Chen (2):
>>    dt-bindings: display: panel: raspberrypi: Add compatible property for
>>      waveshare 7inch touchscreen panel
>>    gpu: drm: panel: raspberrypi: add new display mode and new probing
>>      process
>>
>>   .../panel/raspberrypi,7inch-touchscreen.yaml  |  4 +-
>>   .../drm/panel/panel-raspberrypi-touchscreen.c | 99 ++++++++++++++++---
>>   2 files changed, 91 insertions(+), 12 deletions(-)
>>
> 


thanks

Best Regards,
Shengyang
