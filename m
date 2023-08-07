Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA4772A50
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjHGQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHGQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:16:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3110CE;
        Mon,  7 Aug 2023 09:16:35 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377GGQGU126323;
        Mon, 7 Aug 2023 11:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691424986;
        bh=cXxX9UN9/ul+16Vg/ekotOnm0YUjkRmVdJx9FnUIEY8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=GyNJ2ZORIvh1eIEysbELMlZdReqbvs5nh6yUfg3rtMZ8w5EBfHeiIdTXMc7BEhcDA
         X2mND+H04+aW7dmJvEBTHMxDkWBbYfd7qXi7n7dBEecEAx2lkj0zHtSVhRq51rLJtp
         yu9JSTKyHqeD+SreVfcQDUCy6lLDrVrIs+py7C5c=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377GGQtC129125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 11:16:26 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 11:16:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 11:16:26 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377GGPWt105151;
        Mon, 7 Aug 2023 11:16:25 -0500
Message-ID: <191d171b-aa8d-3727-f5ad-9c25bfff96fe@ti.com>
Date:   Mon, 7 Aug 2023 11:16:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/13] arm64: dts: ti: k3-j7200: Enable GPIO nodes at the
 board level
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Dhruva Gole <d-gole@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-11-afd@ti.com>
 <ea932535-b69c-ec57-0dfe-31a891b6df5c@ti.com>
 <1b3366b0-e3a4-3609-9e25-7b880d2fe656@ti.com>
 <20230807154207.7eho6er55revipjo@shuffling>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230807154207.7eho6er55revipjo@shuffling>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 10:42 AM, Nishanth Menon wrote:
> On 10:28-20230807, Andrew Davis wrote:
>> On 8/7/23 12:38 AM, Dhruva Gole wrote:
>>> Andrew,
>>>
>>> On 03/08/23 02:23, Andrew Davis wrote:
>>>> GPIO nodes defined in the top-level J7200 SoC dtsi files are incomplete
>>>> and may not be functional unless they are extended with pinmux and
>>>> device information.
>>>>
>>>> Disable the GPIO nodes in the dtsi files and only enable the ones that
>>>> are actually pinned out on a given board.
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> ---
>>>>    .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 ++++--------------
>>>>    arch/arm64/boot/dts/ti/k3-j7200-main.dtsi      |  4 ++++
>>>>    .../arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  2 ++
>>>>    3 files changed, 10 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>>>> index dee9056f56051..4a5c4f36baeec 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>>>> @@ -240,27 +240,17 @@ &main_uart3 {
>>>>        pinctrl-0 = <&main_uart3_pins_default>;
>>>>    };
>>>> -&main_gpio2 {
>>>> -    status = "disabled";
>>>> -};
>>>> -
>>>> -&main_gpio4 {
>>>> -    status = "disabled";
>>>> -};
>>>> -
>>>> -&main_gpio6 {
>>>> -    status = "disabled";
>>>> +&main_gpio0 {
>>>> +    status = "okay";
>>>> +    /* default pins */
>>>
>>> Small question, where is the pmx for main_gpio0? What does "default pins"
>>> refer to here? Where are they pinmuxed?
>>>
>>
>> Good question, where is the pmx for main_gpio0? I don't know, it was
>> never defined before either, we only are noticing this now as we are
>> disabling by default instead of leaving an unfinished node enabled
>> by default. (another benefit of this disabled by default scheme).
>>
>> What is really happening is GPIO nodes we tend to pinmux differently
>> than normal device nodes. Their pinmux selections tends to be spread
>> out in all the nodes that make use of these GPIO pins, not all together
>> here in this node.
>>
>> For instance in this device we use one of the main_gpio0 pins as a
>> GPIO toggled regulator, and we define the pinmux for it in that node
>> (see vdd-sd-dv-default-pins).
>>
>> We can either define the rest of the pins not used elsewhere
>> here, or we can consider GPIO an exception to the rule, I'd say
>> the latter is fine for now.
> 
> 
> GPIO pinmux are typically defined where they need - the only place where
> they are explicitly called out in gpio is when they are meant to be used by
> libgpio - typically in the case of dev boards.
> 
> Just drop the comments of /* default pins */ - that is just mis-leading.
> 

True, will drop the comment for v2.

Andrew
