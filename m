Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4B7BB346
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjJFIdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjJFIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:32:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CCA9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:32:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406619b53caso16406075e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696581176; x=1697185976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCb9D1FjS4+NDKYTdM8qk2zeUHNmgn7rdqdfEVBXslw=;
        b=JyMF+5T18MkzJXVdBBIIRH3x08bvj+vAatBEelKNL6ZC6b+GYC1ZxDzoLhrm+xu2e1
         BkCoMWp557rzGzje/wReEnk+D3MCrxalFbwCXCe18rdtOuFUQ+gWYh95X3IVo4mRrQQH
         WzF3E/TkaI9+BWMMO5tVGqKKCPUC2iXwdNV2gNWaTQNi4EP9q3nXHWA43a7xKVw4NDeA
         4enXifVcixsskSjXgpQV4vB14DxDWgEaJyAtFmLCnunteOHRoVwemlTNdXH2toJzbLbi
         QGQ+HB4a2b13cikGUWOdvDzEzKnSUJgDlZMy1a/hocbu4HeAshvz6eKD20oFakz6RMJv
         oCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696581176; x=1697185976;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCb9D1FjS4+NDKYTdM8qk2zeUHNmgn7rdqdfEVBXslw=;
        b=PzAUlu9mR2FvrFwm3pjp+CmBl4GWnTETDdDccCD2gy0rnXclpbY7ZH13LbGqj+tNbq
         1KiQT9iVgoMxVa8YBDRno4sjPe7xZdnwvbBLx0aLL2ubEsYwIq6OABLU/Xr1Gh93749Y
         05aVbYUDNMZshF3fubdO8bwPGwoJG5N6svprNCswdbTXwIzyiFiNIjeWL0KGP55AZ5jC
         JPNmAfAysmzlThKosBcCzAhs1j+MrSUEQBA1tzVK/+Xc+STT4tNksXvlT8lFSqG7tmzU
         IxVMYso+0YuLriKru8PuptP5HK6exLQkQlBbRoxMFVD8b/RsHU8mUHfwDVY0MyN3INpv
         GIvA==
X-Gm-Message-State: AOJu0Yxj0L5hPXKTT3/7GbQ9Clk0/Jj9yqg/BUWARf5Czo4WebBaxyCA
        WnTfMazlDvrcBy54OFK89N1W6A==
X-Google-Smtp-Source: AGHT+IHiTVR3OKeX7kUy9Hg4DdtYO7T8hiHWacTptZHC0AdvMu0LZxFN2/s3GsA8SB24cs7KPjSvcw==
X-Received: by 2002:a1c:720c:0:b0:3fe:4cbc:c345 with SMTP id n12-20020a1c720c000000b003fe4cbcc345mr7031719wmc.41.1696581175812;
        Fri, 06 Oct 2023 01:32:55 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c378d00b004063cd8105csm5430421wmr.22.2023.10.06.01.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 01:32:55 -0700 (PDT)
Message-ID: <78c8d21f-99b1-40ed-a76f-fdf3cbb42274@linaro.org>
Date:   Fri, 6 Oct 2023 10:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: add libretech cottonwood support
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, Da Xue <da.xue@libretech.co>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
 <20231002141020.2403652-3-jbrunet@baylibre.com>
 <b81a296d-0640-4b2e-aab6-c9de37d10206@linaro.org>
 <1j5y3ozvmk.fsf@starbuckisacylon.baylibre.com>
 <3e69ae4b-5d9e-42ee-a21e-151de8fbb996@linaro.org>
 <1j8r8hxutt.fsf@starbuckisacylon.baylibre.com>
 <036a9fef-02fd-4bfd-afb5-50724f15176c@linaro.org>
 <1j4jj4xik6.fsf@starbuckisacylon.baylibre.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <1j4jj4xik6.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 10:21, Jerome Brunet wrote:
> 
> On Thu 05 Oct 2023 at 12:04, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 05/10/2023 11:42, Jerome Brunet wrote:
>>> On Tue 03 Oct 2023 at 09:35, Neil Armstrong <neil.armstrong@linaro.org>
>>> wrote:
>>>
>>>> On 02/10/2023 20:57, Jerome Brunet wrote:
>>>>> On Mon 02 Oct 2023 at 18:45, Neil Armstrong <neil.armstrong@linaro.org>
>>>>> wrote:
>>>>>
>>>>
>>>> <snip>
>>>>
>>>>>>> +&usb3_pcie_phy {
>>>>>>> +	#address-cells = <1>;
>>>>>>> +	#size-cells = <0>;
>>>>>>> +	phy-supply = <&vcc_5v>;
>>>>>>> +
>>>>>>> +	hub: hub@1 {
>>>>>>> +		compatible = "usb5e3,626";
>>>>>>> +		reg = <1>;
>>>>>>> +		reset-gpios = <&gpio GPIOC_7 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>>>>>>> +	};
>>>>>>
>>>>>> Not sure the PHY is the right place to put the USB HUB,
>>>>>> and it's probable the HUB is connected to both the USB2 and USB3 lines
>>>>> It is connected to the USB3.0 only
>>>>>
>>>>>> so you should have both USB IDs in DT like it'd done for the Odroid-C4:
>>>>>>
>>>>>> / {
>>>>>> ...
>>>>>>             /* USB hub supports both USB 2.0 and USB 3.0 root hub */
>>>>>>             usb-hub {
>>>>>>                     dr_mode = "host";
>>>>>>                     #address-cells = <1>;
>>>>>>                     #size-cells = <0>;
>>>>>>
>>>>>>                     /* 2.0 hub on port 1 */
>>>>>>                     hub_2_0: hub@1 {
>>>>>>                             compatible = "usb2109,2817";
>>>>>>                             reg = <1>;
>>>>>>                             peer-hub = <&hub_3_0>;
>>>>>>                             reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
>>>>>>                             vdd-supply = <&vcc_5v>;
>>>>>>                     };
>>>>>>
>>>>>>                     /* 3.1 hub on port 4 */
>>>>>>                     hub_3_0: hub@2 {
>>>>>>                             compatible = "usb2109,817";
>>>>>>                             reg = <2>;
>>>>>>                             peer-hub = <&hub_2_0>;
>>>>>>                             reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
>>>>>>                             vdd-supply = <&vcc_5v>;
>>>>>>                     };
>>>>>>             };
>>>>>> ...
>>>>>> };
>>>>>>
>>>>>> if it only has a single USB ID, then it should go under the dwc3 node.
>>>>> The usb controller is connected to the PHY and what's coming out of the
>>>>> PHY
>>>>> goes to the hub. It seems logical to hub the hub under it.
>>>>> Why bypass the PHY ?
>>>>
>>>> The USB bindings the USB devices nodes should be under the controller's node,
>>>> not the PHY, see:
>>>>
>>>> Documentation/devicetree/bindings/usb/usb-hcd.yaml
>>>> ...
>>>> patternProperties:
>>>>     "^.*@[0-9a-f]{1,2}$":
>>>>       description: The hard wired USB devices
>>>>       type: object
>>>>       $ref: /schemas/usb/usb-device.yaml
>>>> ...
>>>> and the example.
>>>>
>>>> Subnodes aren't allowed in the PHY node.
>>> Ok, that is what schema says.
>>> HW wise there is possible problem though.
>>> The phy node has the power supply to the bus.
>>> In that case it is a controllable one.
>>> If fixed USB devices go under the controller instead of the PHY, isn't
>>> it possible that the kernel may attempt to probe them before the bus is
>>> powered ? For this particular board, it would make the reset we are
>>> trying to apply useless.
>>
>> The usb core has a special handling for those usb hubs doing the power
>> up at the right time during the USB setup, including the PHY powering up.
>> So the power sequence should be fine.
>>
>> This has been done on Odroid-C2 and Odroid-N2 already.
> 
> Tried it. Unfortunately something is off with the hub under the dwc3 node
> I often get this error (like once in 3 boots):
> 
> [    0.419301] usbcore: registered new interface driver usbfs
> [    0.424434] usbcore: registered new interface driver hub
> [    0.429696] usbcore: registered new device driver usb
> [    0.921460] usbcore: registered new interface driver usb-storage
> [    0.968157] usbcore: registered new interface driver usbhid
> [    0.972114] usbhid: USB HID core driver
> [    1.132529] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
> [    1.134897] dwc3-meson-g12a ffe09000.usb: USB3 ports: 1
> [    1.144451] dwc2 ff400000.usb: supply vusb_d not found, using dummy regulator
> [    1.147231] dwc2 ff400000.usb: supply vusb_a not found, using dummy regulator
> [    1.154464] dwc2 ff400000.usb: EPs: 7, dedicated fifos, 712 entries in SPRAM
> [    1.219515] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [    1.469260] usb 1-1: new high-speed USB device number 2 using xhci-hcd
> [    1.745395] usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
> [    9.794777] usbcore: registered new device driver onboard-usb-hub
> [   10.255484] onboard-usb-hub 1-1: Failed to suspend device, error -32
> [   10.261699] onboard-usb-hub 1-1: can't set config #1, error -71
> [   10.287500] onboard-usb-hub 1-1: Failed to suspend device, error -32
> [   10.287844] onboard-usb-hub 1-1: USB disconnect, device number 2
> [   10.573277] usb 1-1: new high-speed USB device number 3 using xhci-hcd
> [   10.921468] usb 2-1: reset SuperSpeed USB device number 2 using xhci-hcd
> [   11.193453] usb 2-1: reset SuperSpeed USB device number 2 using xhci-hcd
> 
> While it works reliably when the onboard-usb-hub is under the phy node.
> 
> I added the 5v supply as vdd under the hub for good measure.

The .reset_us you used from genesys_gl852g is probably too low, you may need to use a bigger one then.

Neil

> 
>>
>> Neil
>>
>>>
>>>>
>>>> Neil
>>>>
>>>>>
>>>>>>
>>>>>>> +};
>>>>>>> +
>>>>>>> +&usb {
>>>>>>> +	status = "okay";
>>>>>>> +};
>>>>
>>>> <snip>
>>>
> 

