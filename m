Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5C78A7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjH1IYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjH1IYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:24:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0FCDD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:23:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fef34c33d6so27949105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693211026; x=1693815826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLLA/RmlQ5dfWWOneWVbwaDTQxGK1OaSwXDEB5yYU24=;
        b=xSjoT0xEs8WHbd1ccKeYkQZF4Piwwb/3IYTjIeDbn/idm3TO3MI9SPhqs+87I9I2dh
         nzJD40E3ICAf1Q4LQzlPiJfphzR2FgDgEfcxe0Mxoa6xWGhnqZGtzsmJPmKmtieaeVzT
         7BjmLIxf/4xltN1eD+fz1FrI9RPyGZG6lYT7k6C+cCtJL319qkuxdE1AjUzx1PjU8G4R
         +NQuZy29nVn+l2DuoqQFyf7odPhqqzXggmt/IJ8yxnVGFyjF5MI1YzmMaEEGRpgHZ/ay
         1M+gMq3Qw3YEqietJYC+eGqvwLENJUIS61m8rKuWLpL3LNKcsHBSveCBAx3N7odwSoc8
         RaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693211026; x=1693815826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tLLA/RmlQ5dfWWOneWVbwaDTQxGK1OaSwXDEB5yYU24=;
        b=eAtvt3GNXhg2qR9zt/jszUodXkw87i80kcQQNL8eCtQ3kgCAd78x6rOakyrqnD7ER4
         CXFg1RqW/ooeTKqmtfMnmk0ncz+N0YvGgXGsEK9ofhMbU0zyP+OMyTsjFgCwTTNmec9D
         G0Q2e5U0kVotep9HGqWwXsFZTzqnZLAbFkPk6JvkMT1ABDz5ZNmOwFofS6TJCEQgBMKm
         znRugzeBKVQjQM4kmyBGVne9G4ry3H7mvpfA46y8pWgmmAlgrINufM8+TXMZKeubJI8o
         F2tjA/PSRo5rs/F4d/Kc+y4TAlvVzlI+Yi8tBoWL9EPKZIln55WnANzcJvUZxI6/HNXo
         5FWg==
X-Gm-Message-State: AOJu0YzqsPIb/zqTFpgU603EDExm4Oz/rMP8thbOBZSVSe4eQY3knIEF
        bMc7H2Ysx75H0gEPkdubByS6uDzepEenDb7LFClP5s1V
X-Google-Smtp-Source: AGHT+IEYN+ttXM+q/7NxPz54iIGGuwHDyAk+HSdey3so7/prKGEnX1QOkB3RejwDO5x0aA+bIU+BOQ==
X-Received: by 2002:a05:600c:22c8:b0:401:b504:b698 with SMTP id 8-20020a05600c22c800b00401b504b698mr6042555wmg.17.1693211025716;
        Mon, 28 Aug 2023 01:23:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5e59:c27b:747a:3f52? ([2a01:e0a:982:cbb0:5e59:c27b:747a:3f52])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b003fedcd02e2asm9993248wmj.35.2023.08.28.01.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 01:23:45 -0700 (PDT)
Message-ID: <e070f432-28bd-465f-ad66-53add8b61907@linaro.org>
Date:   Mon, 28 Aug 2023 10:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Content-Language: en-US, fr
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Lucas Tanure <tanure@linux.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230827082944.5100-1-tanure@linux.com>
 <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
 <09735262-1bc0-40cf-b139-22cccf70bcab@linux.com>
 <e73260c9-04f8-eb1e-bb5b-c3bd2219625e@linaro.org>
 <8d2ba0d3-55eb-45cf-b88a-bafef35e96b9@linux.com>
 <20230828082009.kehgwi4fxtj3bfze@CAB-WSD-L081021>
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
In-Reply-To: <20230828082009.kehgwi4fxtj3bfze@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/08/2023 10:20, Dmitry Rokosov wrote:
> On Sun, Aug 27, 2023 at 11:31:35AM +0100, Lucas Tanure wrote:
>> On 27-08-2023 11:23, Neil Armstrong wrote:
>>> Hi Lucas,
>>>
>>> Le 27/08/2023 à 12:04, Lucas Tanure a écrit :
>>>> On 27-08-2023 10:48, Neil Armstrong wrote:
>>>>> Hi Lucas,
>>>>>
>>>>> Le 27/08/2023 à 10:29, Lucas Tanure a écrit :
>>>>>> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
>>>>>> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't
>>>>>> need a OF_EARLYCON_DECLARE.
>>>>>>
>>>>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>>>>> ---
>>>>>> Since V1:
>>>>>> - add Signed-off-by:
>>>>>>
>>>>>>    drivers/tty/serial/meson_uart.c | 2 --
>>>>>>    1 file changed, 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/meson_uart.c
>>>>>> b/drivers/tty/serial/meson_uart.c
>>>>>> index c4f61d82fb727..790d910dafa5d 100644
>>>>>> --- a/drivers/tty/serial/meson_uart.c
>>>>>> +++ b/drivers/tty/serial/meson_uart.c
>>>>>> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct
>>>>>> earlycon_device *device, const char *opt
>>>>>>    OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>>>>>>                meson_serial_early_console_setup);
>>>>>> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
>>>>>> -            meson_serial_early_console_setup);
>>>>>>    #define MESON_SERIAL_CONSOLE_PTR(_devname)
>>>>>> (&meson_serial_console_##_devname)
>>>>>>    #else
>>>>>
>>>>> How do you use earlycon with this removed ?
>>>>>
>>>>> Neil
>>>> This is my kernel cmdline:
>>>> console=ttyS0,921600 no_console_suspend earlycon=ttyS0,0xfe078000
>>>>
>>>> And I can see my log:
>>>> boot 64bit kernel
>>>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd092]
>>>> [    0.000000] Linux version 6.5.0-rc7-next-20230825+
>>>> (tanureal@ryzen) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the
>>>> A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621,
>>>> GNU ld (GNU Toolchain fo3
>>>> [    0.000000] KASLR disabled due to lack of seed
>>>> [    0.000000] Machine model: Khadas vim4
>>>> [    0.000000] OF: reserved mem:
>>>> 0x0000000005000000..0x00000000052fffff (3072 KiB) nomap non-reusable
>>>> secmon@5000000
>>>> [    0.000000] OF: reserved mem:
>>>> 0x0000000005300000..0x00000000072fffff (32768 KiB) nomap
>>>> non-reusable secmon@5300000
>>>> ...
>>>> [    0.079368] io scheduler mq-deadline registered
>>>> [    0.079374] io scheduler kyber registered
>>>> [    0.079549] io scheduler bfq registered
>>>> [    0.083373] fe078000.serial: ttyS0 at MMIO 0xfe078000 (irq = 14,
>>>> base_baud = 1500000) is a meson_uart
>>>> [    0.083403] printk: console [ttyS0] enabled
>>>>
>>>> As the log is OK, and T7 for now is binding against S4 code we
>>>> should drop this patch and add a S4 one if needed.
>>>>
>>>> But just having this log is not enough for testing earlycon?
>>>> I am assuming that by just having the log since 0.0000 is a good
>>>> sign that earlycon is working.
>>>> Could you give further guidance?
>>>
>>> First the kernel argument is simply "earlycon" with no other options,
>>> the earlycon code will fetch the first uart using the DT
>>> /chosen/stdout-path property.
>>>
>>> Then you should see something like right after "Machine model":
>>> [    0.000000] earlycon: meson0 at MMIO 0x00000000ff803000 (options
>>> '115200n8')
>>>
>>> The boot log you share doesn't use earlycon, it waits until all
>>> depedency of the UART
>>> has been probed before probing the UART driver and prints the whole boot
>>> log.
>>>
>>> Earlycon is a mechanism to use the UART HW as configured by the
>>> bootloader in
>>> a minimal way very early in the boot in order to detect very early lockups.
>>>
>>> Keeping OF_EARLYCON_DECLARE for t7 would enable this.
>>>
>>> Neil
>>>
>>>>
>>>> Lucas Tanure
>>>>
>>>
>> But then we would need to add Earlycon for S4 too.
>> How can we add one Earlycon for all future SoCs, like S4 and T7?
>>
> 
> Per my understanding, you just need to declare UART dts node with the
> following compatible string: "amlogic,meson-ao-uart". It will enabled
> earlycon. There is no neccessary to declare separate
> OF_EARLYCON_DECLARE(). It's working okay for A1 dts:

This works on A1 because uart_AO_B is an Always-On UART, and using amlogic,meson-ao-uart
is corrent.
But for S4 & T7, Amlogic dropped the Always-On power domain, so there's no more AO uarts,
so using amlogic,meson-ao-uart on those is abusing the DT to enable a driver functionality.

So the solution is to add those OF_EARLYCON_DECLARE and only use the correct
/chosen/stdout-path property.

Neil


> 
> meson-a1.dtsi uart declaration:
> 	uart_AO_B: serial@2000 {
> 		compatible = "amlogic,meson-a1-uart",
> 			     "amlogic,meson-ao-uart";
> 		reg = <0x0 0x2000 0x0 0x18>;
> 		interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> 		clocks = <&xtal>, <&xtal>, <&xtal>;
> 		clock-names = "xtal", "pclk", "baud";
> 		status = "disabled";
> 	};
> 
> earlycon declaration from dts:
> 	aliases {
> 		serial0 = &uart_AO_B;
> 	};
> 
> 	chosen {
> 		stdout-path = "serial0:115200n8";
> 	};
> 
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

