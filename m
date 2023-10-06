Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B57BB492
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjJFJxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjJFJxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:53:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAEF9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:53:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so17339865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696586022; x=1697190822; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=EAsXkny87ZOF57hq2rRzij47Q/y5dvWojHFo8373xlo=;
        b=p/Yjr8SJzp0FOZvU9tGkYOv8Sy5p+MEBUZH350LpCar5L7/wzXgLi3NIoXCcM5yNE6
         8siV/oHsbWfT10ihKrAfmopoRfeJcdM7pJcE2zl4ruLyYG2x/JKZ+fQQj5kyCxFowOLE
         CfPuau5HCGuGeQ4vQBSBa5NJNYGt1lkmyC5fjnM83xpfMm0l8U8L3NHfMNMUO7pjrk8d
         hZrbM851eZ8jZGBQzBrKoEGtKcFLyBiounrN/3unxBfFDEzL+EpoLwJmodejLveqJNtK
         cTZIWhntZeeyJIK6H2Nvso2ZT+FSUQhpg8uH2GbVEsSu5ZBkhQQyHNLklkBJy+tfQpwL
         nGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696586022; x=1697190822;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAsXkny87ZOF57hq2rRzij47Q/y5dvWojHFo8373xlo=;
        b=GQUuTIHTmWBGNGZVlZ54aPetID4uiDGm10nBFGRLQU7HH/Dn2iJBwgP5/I/mRz+s1K
         UPgIfb5JlEBM2ryZ6+sTlV7R8B7RBjuzXzIS2HKY2w3QLL3p42xpnM/rIabxkwFE3K7N
         LVxnUKa4zeLnAfgqGsDSWH4VMi98q/xY/L1Y8pBOLhTbVET4FST6RWPZy8aN15/5xR5V
         9zymh8VKSo2TW1llL46IjzLeNBs51XSsWHygNL+5DcjhUlQE3DknA9Mt6+s0nacJD/lW
         fdcvhJFnNIa7bLes9kt42RVrPSmghFsQcDoN08ZVQPMAZi/yFTscsGbpbfE9RZ6y/lBt
         uBfA==
X-Gm-Message-State: AOJu0YxXU9ZtATgbDFreyp0mNb4AqXspIc0TviZmcuHjDkImXo3QdrSb
        VBFoEOBWLOW/rr0ZhqDo7Qd5ig==
X-Google-Smtp-Source: AGHT+IHrcOMJ9DKWXLL+OqURxmxVAi/wXO6noduuqphftmmCBE8BiZD7h8nJrZjcg+IQZX0E+BghMg==
X-Received: by 2002:a05:600c:2a4e:b0:3fe:fc0f:52e2 with SMTP id x14-20020a05600c2a4e00b003fefc0f52e2mr6934953wme.37.1696586022042;
        Fri, 06 Oct 2023 02:53:42 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:8f44:72b3:5bcb:6c6b])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0ac500b0040586360a36sm5579460wmr.17.2023.10.06.02.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:53:41 -0700 (PDT)
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
 <20231002141020.2403652-3-jbrunet@baylibre.com>
 <b81a296d-0640-4b2e-aab6-c9de37d10206@linaro.org>
 <1j5y3ozvmk.fsf@starbuckisacylon.baylibre.com>
 <3e69ae4b-5d9e-42ee-a21e-151de8fbb996@linaro.org>
 <1j8r8hxutt.fsf@starbuckisacylon.baylibre.com>
 <036a9fef-02fd-4bfd-afb5-50724f15176c@linaro.org>
 <1j4jj4xik6.fsf@starbuckisacylon.baylibre.com>
 <78c8d21f-99b1-40ed-a76f-fdf3cbb42274@linaro.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, Da Xue <da.xue@libretech.co>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: add libretech cottonwood support
Date:   Fri, 06 Oct 2023 11:52:58 +0200
In-reply-to: <78c8d21f-99b1-40ed-a76f-fdf3cbb42274@linaro.org>
Message-ID: <1jzg0wvzyz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 06 Oct 2023 at 10:32, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 06/10/2023 10:21, Jerome Brunet wrote:
>> On Thu 05 Oct 2023 at 12:04, Neil Armstrong <neil.armstrong@linaro.org>
>> wrote:
>> 
>>> On 05/10/2023 11:42, Jerome Brunet wrote:
>>>> On Tue 03 Oct 2023 at 09:35, Neil Armstrong <neil.armstrong@linaro.org>
>>>> wrote:
>>>>
>>>>> On 02/10/2023 20:57, Jerome Brunet wrote:
>>>>>> On Mon 02 Oct 2023 at 18:45, Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> wrote:
>>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>>>>> +&usb3_pcie_phy {
>>>>>>>> +	#address-cells = <1>;
>>>>>>>> +	#size-cells = <0>;
>>>>>>>> +	phy-supply = <&vcc_5v>;
>>>>>>>> +
>>>>>>>> +	hub: hub@1 {
>>>>>>>> +		compatible = "usb5e3,626";
>>>>>>>> +		reg = <1>;
>>>>>>>> +		reset-gpios = <&gpio GPIOC_7 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>>>>>>>> +	};
>>>>>>>
>>>>>>> Not sure the PHY is the right place to put the USB HUB,
>>>>>>> and it's probable the HUB is connected to both the USB2 and USB3 lines
>>>>>> It is connected to the USB3.0 only
>>>>>>
>>>>>>> so you should have both USB IDs in DT like it'd done for the Odroid-C4:
>>>>>>>
>>>>>>> / {
>>>>>>> ...
>>>>>>>             /* USB hub supports both USB 2.0 and USB 3.0 root hub */
>>>>>>>             usb-hub {
>>>>>>>                     dr_mode = "host";
>>>>>>>                     #address-cells = <1>;
>>>>>>>                     #size-cells = <0>;
>>>>>>>
>>>>>>>                     /* 2.0 hub on port 1 */
>>>>>>>                     hub_2_0: hub@1 {
>>>>>>>                             compatible = "usb2109,2817";
>>>>>>>                             reg = <1>;
>>>>>>>                             peer-hub = <&hub_3_0>;
>>>>>>>                             reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
>>>>>>>                             vdd-supply = <&vcc_5v>;
>>>>>>>                     };
>>>>>>>
>>>>>>>                     /* 3.1 hub on port 4 */
>>>>>>>                     hub_3_0: hub@2 {
>>>>>>>                             compatible = "usb2109,817";
>>>>>>>                             reg = <2>;
>>>>>>>                             peer-hub = <&hub_2_0>;
>>>>>>>                             reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
>>>>>>>                             vdd-supply = <&vcc_5v>;
>>>>>>>                     };
>>>>>>>             };
>>>>>>> ...
>>>>>>> };
>>>>>>>
>>>>>>> if it only has a single USB ID, then it should go under the dwc3 node.
>>>>>> The usb controller is connected to the PHY and what's coming out of the
>>>>>> PHY
>>>>>> goes to the hub. It seems logical to hub the hub under it.
>>>>>> Why bypass the PHY ?
>>>>>
>>>>> The USB bindings the USB devices nodes should be under the controller's node,
>>>>> not the PHY, see:
>>>>>
>>>>> Documentation/devicetree/bindings/usb/usb-hcd.yaml
>>>>> ...
>>>>> patternProperties:
>>>>>     "^.*@[0-9a-f]{1,2}$":
>>>>>       description: The hard wired USB devices
>>>>>       type: object
>>>>>       $ref: /schemas/usb/usb-device.yaml
>>>>> ...
>>>>> and the example.
>>>>>
>>>>> Subnodes aren't allowed in the PHY node.
>>>> Ok, that is what schema says.
>>>> HW wise there is possible problem though.
>>>> The phy node has the power supply to the bus.
>>>> In that case it is a controllable one.
>>>> If fixed USB devices go under the controller instead of the PHY, isn't
>>>> it possible that the kernel may attempt to probe them before the bus is
>>>> powered ? For this particular board, it would make the reset we are
>>>> trying to apply useless.
>>>
>>> The usb core has a special handling for those usb hubs doing the power
>>> up at the right time during the USB setup, including the PHY powering up.
>>> So the power sequence should be fine.
>>>
>>> This has been done on Odroid-C2 and Odroid-N2 already.
>> Tried it. Unfortunately something is off with the hub under the dwc3 node
>> I often get this error (like once in 3 boots):
>> [    0.419301] usbcore: registered new interface driver usbfs
>> [    0.424434] usbcore: registered new interface driver hub
>> [    0.429696] usbcore: registered new device driver usb
>> [    0.921460] usbcore: registered new interface driver usb-storage
>> [    0.968157] usbcore: registered new interface driver usbhid
>> [    0.972114] usbhid: USB HID core driver
>> [    1.132529] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
>> [    1.134897] dwc3-meson-g12a ffe09000.usb: USB3 ports: 1
>> [    1.144451] dwc2 ff400000.usb: supply vusb_d not found, using dummy regulator
>> [    1.147231] dwc2 ff400000.usb: supply vusb_a not found, using dummy regulator
>> [    1.154464] dwc2 ff400000.usb: EPs: 7, dedicated fifos, 712 entries in SPRAM
>> [    1.219515] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
>> [    1.469260] usb 1-1: new high-speed USB device number 2 using xhci-hcd
>> [    1.745395] usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
>> [    9.794777] usbcore: registered new device driver onboard-usb-hub
>> [   10.255484] onboard-usb-hub 1-1: Failed to suspend device, error -32
>> [   10.261699] onboard-usb-hub 1-1: can't set config #1, error -71
>> [   10.287500] onboard-usb-hub 1-1: Failed to suspend device, error -32
>> [   10.287844] onboard-usb-hub 1-1: USB disconnect, device number 2
>> [   10.573277] usb 1-1: new high-speed USB device number 3 using xhci-hcd
>> [   10.921468] usb 2-1: reset SuperSpeed USB device number 2 using xhci-hcd
>> [   11.193453] usb 2-1: reset SuperSpeed USB device number 2 using xhci-hcd
>> While it works reliably when the onboard-usb-hub is under the phy node.
>> I added the 5v supply as vdd under the hub for good measure.
>
> The .reset_us you used from genesys_gl852g is probably too low, you may need to use a bigger one then.
>

Indeed. This seems to do the trick.
I'll change this

Thx

> Neil
>
>> 
>>>
>>> Neil
>>>
>>>>
>>>>>
>>>>> Neil
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +&usb {
>>>>>>>> +	status = "okay";
>>>>>>>> +};
>>>>>
>>>>> <snip>
>>>>
>> 

