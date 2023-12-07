Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C79807F62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjLGDwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGDwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:52:19 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A7FD71;
        Wed,  6 Dec 2023 19:52:22 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2DB5481EA;
        Thu,  7 Dec 2023 11:52:10 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Dec
 2023 11:52:09 +0800
Received: from [192.168.125.88] (183.27.97.199) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Dec
 2023 11:52:08 +0800
Message-ID: <53b992e8-1b36-4540-a993-fde8e550faf9@starfivetech.com>
Date:   Thu, 7 Dec 2023 11:48:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: raspberrypi: Add
 compatible property for waveshare 7inch touchscreen panel
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
        <sam@ravnborg.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <florian.fainelli@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <eric@anholt.net>,
        <thierry.reding@gmail.com>, <changhuang.liang@starfivetech.com>,
        <keith.zhao@starfivetech.com>, <jack.zhu@starfivetech.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231124104451.44271-1-shengyang.chen@starfivetech.com>
 <20231124104451.44271-2-shengyang.chen@starfivetech.com>
 <20231124-lesser-sinister-7f9cd7b80e35@spud>
 <2d48e460-e46e-431f-bd7b-e34ebe73a40c@starfivetech.com>
 <20231206-isolating-smoked-b490952029d0@spud>
From:   Shengyang Chen <shengyang.chen@starfivetech.com>
In-Reply-To: <20231206-isolating-smoked-b490952029d0@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.199]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor

thanks for comment

On 2023/12/6 23:40, Conor Dooley wrote:
> On Wed, Dec 06, 2023 at 05:43:48PM +0800, Shengyang Chen wrote:
>> Hi, Conor
>> 
>> On 2023/11/24 20:31, Conor Dooley wrote:
>> > On Fri, Nov 24, 2023 at 06:44:50PM +0800, Shengyang Chen wrote:
>> >> The waveshare 7inch touchscreen panel is a kind of raspberrypi pi
>> >> panel
>> > 
>> > Can you be more specific about what "is a kind of rpi panel" means?
>> > Are they using identical chips as controllers or something like that?
>> > 
>> 
>> Wareshare panel has same i2c slave address and registers address with 
>> the original raspberry pi panel. They both use Atmel firmware and they
>> got same reg id. It can be operated by using the driver of raspberry pi driver
>> after some change of the code. So I suppose it may be a kind of raspberry pi panel 
>> and discribe it in this way. It's my own judgement. Sorry about that.
>> Maybe just like Dave said, It cloned the behaviour of the raspberri pi panel.
>> I will change the discribtion in next version to not make other confused.
>> 
>> By the way, we will try Stefan's method before next version. 
>> The method we used in this patch may be abandoned if Stefan's method is verified in our platform.
>> At that time yaml may also be changed to fit new method.
> 
> I don't know what Stefan's approach is, but I do not think that a
> bindings patch should be dropped. The waveshare might be a clone, but it
> is a distinct device. If the same driver can control both, then the
> compatible setups that should be permitted are:
> compatible = "raspberrypi,7inch-touchscreen-panel";
> and
> compatible = "waveshare,7inch-touchscreen-panel", "raspberrypi,7inch-touchscreen-panel";
> 
> Cheers,
> Conor.
> 

Here is our consideration of this submit:

Although Waveshare panel reuse the driver of raspberry pi panel, they are different in probing process
and panel parameters.
we try to use compatible and data to distinguish these two panel

Here are the reference
driver part:
https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/gpu/drm/panel/panel-simple.c
dt-binding part:
https://elixir.bootlin.com/linux/v6.7-rc3/source/Documentation/devicetree/bindings/display/panel/panel-simple.yaml


For example:

in driver part:

in drivers/gpu/drm/panel/panel-simple.c:#in line 4189
----------------------------------------------------------------------------------
we can got different compatible with its own data.
================================================
static const struct of_device_id platform_of_match[] = {			//the of_match array list
	{
		.compatible = "ampire,am-1280800n3tzqw-t00h",
		.data = &ampire_am_1280800n3tzqw_t00h,		//we define our panel parameter or special panel function, which can distinguish different panels
	}, {
		.compatible = "ampire,am-480272h3tmqw-t01h",
		.data = &ampire_am_480272h3tmqw_t01h,
	}, 
...
...
}
===============================================

in drivers/gpu/drm/panel/panel-simple.c:#in line 4611
----------------------------------------------------------------------------------
we can use the generic probing process to probe our driver
after getting its own data.
================================================
static int panel_simple_platform_probe(struct platform_device *pdev)
{
	const struct panel_desc *desc;

	desc = of_device_get_match_data(&pdev->dev);			//we get our panel parameter
	if (!desc)
		return -ENODEV;

	return panel_simple_probe(&pdev->dev, desc);			//probe with returned data
}



================================================

in yamel part:

in /Documentation/devicetree/bindings/display/panel/panel-simple.yaml#in line 33
----------------------------------------------------------------------------------
We refer to this approach, adding our compatible to the yaml of raspberry pi panel
================================================

properties:
  compatible:
    enum:
    # compatible must be listed in alphabetical order, ordered by compatible.
    # The description in the comment is mandatory for each compatible.

        # Ampire AM-1280800N3TZQW-T00H 10.1" WQVGA TFT LCD panel
      - ampire,am-1280800n3tzqw-t00h
        # Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
      - ampire,am-480272h3tmqw-t01h
================================================



If we use Stenfan's method, we can reuse the code of panel-simple.c
we may submit our patch to
/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
/drivers/gpu/drm/panel/panel-simple.c
as a new panel porting. That may less confuse.


here is Stenfan's method:
[1] - https://github.com/lategoodbye/rpi-zero/commits/v6.7-7inch-ts
[2] -
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtso?h=v6.6.2&id=6b4da1354fd81adace0cda448c77d8f2a47d8474


Thanks

Best Regards,
Shengyang


>> >> and it can be drived by panel-raspberrypi-touchscreen.c.
>> >> Add compatible property for it.
>> >> 
>> >> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
>> >> Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
>> >> ---
>> >>  .../bindings/display/panel/raspberrypi,7inch-touchscreen.yaml | 4 +++-
>> >>  1 file changed, 3 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
>> >> index 22a083f7bc8e..e4e6cb4d4e5b 100644
>> >> --- a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
>> >> +++ b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
>> >> @@ -22,7 +22,9 @@ description: |+
>> >>  
>> >>  properties:
>> >>    compatible:
>> >> -    const: raspberrypi,7inch-touchscreen-panel
>> >> +    enum:
>> >> +      - raspberrypi,7inch-touchscreen-panel
>> >> +      - waveshare,7inch-touchscreen-panel
>> >>  
>> >>    reg:
>> >>      const: 0x45
>> >> -- 
>> >> 2.17.1
>> >> 
>> 
>> 
>> thanks.
>> 
>> Best Regards,
>> Shengyang
>> 

