Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF18F7B9EEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjJEOPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJEONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:13:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64F21D2C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:49:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32336a30d18so701846f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696499376; x=1697104176; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=pYqPT1GJs9o/oEYc7vUihYo+IdyN6oSJaJhVpn+wyNQ=;
        b=Cw6uZFOarpVA/swj2752qnphiN10dAWfqYa0JjUxbOofW/IgLDHn91q7T6aW9uID8U
         yGYtTBqzle6fvS6YEokBqHUxfaze7LMpa78bz6eewKB9KkUJF/F0/LCDjbqH3H5+PwxV
         NjzboW2esv0flLTlo4dCV5cd8ImY5K48lIWBctrEC9B2M3jVmUdcSg9uIHUWVvzo2Jbs
         kE1fombQpvOPfWH7WJEPevmRwv/9Soa9rcuYQqsWqPEE+2ajdcgRjLRrK4LXjKzWmOTa
         LbpodUe+t56UEs7ySzzCxuGdZf5fvB/F/vMlqJMDhI9HNTh3J2imX6BPmGp/BwIu2lEv
         dxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499376; x=1697104176;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYqPT1GJs9o/oEYc7vUihYo+IdyN6oSJaJhVpn+wyNQ=;
        b=UjziTM7BadbL2ZvvvWPiBS4RGr+nOedWjl5MlbOWtwdHqNIJ2JzKJRXITOPUb5qLtU
         8rl49xQ6bH6lcqGR+DhBXAVMBCkInDksFnpar1X9HoQ1uh517KbJ6i/X4r+tY91U/cIC
         zzy7qkD/YKxl+1poARZzKc/i2sksETBLKFcRn1O/lDpJDIaxILzIpmMqu0qvD0CQnaCV
         P4KKT1yesiUP9Q77DUQLRJk+aA0AIF105PDfThMZf8if+tFhLWmtpTJEzdYI7rV5sz/2
         KYQYRMj3gOTK7XJ576x8y2K4PcpS2EM39DWS8cxjTwv78ev7PhjYKIgMyA/Sw9wq3Uw7
         a6nQ==
X-Gm-Message-State: AOJu0Yz5VRcv6jvP5zHuZ4vU2RzGqhKuBql5s5CDdVe4iS7fPdEvu8Ji
        8gtEwbQ//6woroSDTv9ioI3jTA==
X-Google-Smtp-Source: AGHT+IG+H1AplyMOolKejY8sam55E+wpqzlnjo2WR74yXXIdT24YPEVy1N8wGCWjRBfU+sFQnUNXAg==
X-Received: by 2002:a05:6000:1b0c:b0:320:6db:3548 with SMTP id f12-20020a0560001b0c00b0032006db3548mr4052410wrz.55.1696499376045;
        Thu, 05 Oct 2023 02:49:36 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a7d6:58b1:d86b:6d1e])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b003247d3e5d99sm1376415wrx.55.2023.10.05.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 02:49:35 -0700 (PDT)
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
 <20231002141020.2403652-3-jbrunet@baylibre.com>
 <b81a296d-0640-4b2e-aab6-c9de37d10206@linaro.org>
 <1j5y3ozvmk.fsf@starbuckisacylon.baylibre.com>
 <3e69ae4b-5d9e-42ee-a21e-151de8fbb996@linaro.org>
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
Date:   Thu, 05 Oct 2023 11:42:57 +0200
In-reply-to: <3e69ae4b-5d9e-42ee-a21e-151de8fbb996@linaro.org>
Message-ID: <1j8r8hxutt.fsf@starbuckisacylon.baylibre.com>
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


On Tue 03 Oct 2023 at 09:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 02/10/2023 20:57, Jerome Brunet wrote:
>> On Mon 02 Oct 2023 at 18:45, Neil Armstrong <neil.armstrong@linaro.org>
>> wrote:
>> 
>
> <snip>
>
>>>> +&usb3_pcie_phy {
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <0>;
>>>> +	phy-supply = <&vcc_5v>;
>>>> +
>>>> +	hub: hub@1 {
>>>> +		compatible = "usb5e3,626";
>>>> +		reg = <1>;
>>>> +		reset-gpios = <&gpio GPIOC_7 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>>>> +	};
>>>
>>> Not sure the PHY is the right place to put the USB HUB,
>>> and it's probable the HUB is connected to both the USB2 and USB3 lines
>> It is connected to the USB3.0 only
>> 
>>> so you should have both USB IDs in DT like it'd done for the Odroid-C4:
>>>
>>> / {
>>> ...
>>>           /* USB hub supports both USB 2.0 and USB 3.0 root hub */
>>>           usb-hub {
>>>                   dr_mode = "host";
>>>                   #address-cells = <1>;
>>>                   #size-cells = <0>;
>>>
>>>                   /* 2.0 hub on port 1 */
>>>                   hub_2_0: hub@1 {
>>>                           compatible = "usb2109,2817";
>>>                           reg = <1>;
>>>                           peer-hub = <&hub_3_0>;
>>>                           reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
>>>                           vdd-supply = <&vcc_5v>;
>>>                   };
>>>
>>>                   /* 3.1 hub on port 4 */
>>>                   hub_3_0: hub@2 {
>>>                           compatible = "usb2109,817";
>>>                           reg = <2>;
>>>                           peer-hub = <&hub_2_0>;
>>>                           reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
>>>                           vdd-supply = <&vcc_5v>;
>>>                   };
>>>           };
>>> ...
>>> };
>>>
>>> if it only has a single USB ID, then it should go under the dwc3 node.
>> The usb controller is connected to the PHY and what's coming out of the
>> PHY
>> goes to the hub. It seems logical to hub the hub under it.
>> Why bypass the PHY ?
>
> The USB bindings the USB devices nodes should be under the controller's node,
> not the PHY, see:
>
> Documentation/devicetree/bindings/usb/usb-hcd.yaml
> ...
> patternProperties:
>   "^.*@[0-9a-f]{1,2}$":
>     description: The hard wired USB devices
>     type: object
>     $ref: /schemas/usb/usb-device.yaml
> ...
> and the example.
>
> Subnodes aren't allowed in the PHY node.

Ok, that is what schema says.
HW wise there is possible problem though.

The phy node has the power supply to the bus.
In that case it is a controllable one.

If fixed USB devices go under the controller instead of the PHY, isn't
it possible that the kernel may attempt to probe them before the bus is
powered ? For this particular board, it would make the reset we are
trying to apply useless.

>
> Neil
>
>> 
>>>
>>>> +};
>>>> +
>>>> +&usb {
>>>> +	status = "okay";
>>>> +};
>
> <snip>

