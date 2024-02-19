Return-Path: <linux-kernel+bounces-70942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74E859E71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290981F215C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF2721357;
	Mon, 19 Feb 2024 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOE+9gg6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007422314
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331809; cv=none; b=VTjIsGIb7usGpMA9Pb9iQOgiggIn7t/Wvc39nbphlNz+C9OEj+6dsT+pvIOaG723PriIZnwMAa2sCTd0rJ5MTiK/EP3+QR6Esv4bqvWtcHicTzESIAb6kIdYb+Rfyfn4G3AMEAEoe+Qe/qurUrCWoq35p4XMUy3LMqYR0J/wKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331809; c=relaxed/simple;
	bh=sGqXoy8qn0fL36LzY9Ib6FKPWFCHugzeSHrYM28JcUM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CxHxLY0MVAWW3s1/pbAq6zoosInmpYVaMv9PNQtz2MGhK0PE+oyTtnBS5vhkKRLNT3A1X8geSdwNb2mMJyz0ft2ocs3dXgrDoPaHHgxP0UMfP9TcD/sTEOwTTUTEzrT4BZFi995MzvwO8Uzg+1K5dXKtORfkR9VKTkRv4niEdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOE+9gg6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41266ef4bc3so3468495e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708331806; x=1708936606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7P/OAc7Evr5FDjQX4GvBQWaS03fCMTdV1e5S55Ss+A=;
        b=ZOE+9gg6/KaSRcsDY3He76lhJ64ehQjdtRY6vx77q2TDOQX+FuxkWQBBKQLJvpQscI
         5n7PpVI6aj7Qhxm3kDZBq3QvoCmNTVmXXRgdS9NfisuKmFvG62KS09DSeaQwCQKgBRT1
         0RQEPSlcivj8jOLn3GtIDNPEyTmp3g8RXsZTDCwQTrY4xmzmMZpG98oswdaiZoN307XL
         Dxj19DykBzYKcxJhoS0sF7Lj4oJBqOHhLjk1+LApkEHlCvtOhTzY7IoR6Hfr1zhctrli
         bkMcPls7nsKWkGRXqzPnHBEz0slzDnqx0gw6HVPfw1KHQsknSW+UOYuWjFVFWAROn5eW
         E1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708331806; x=1708936606;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q7P/OAc7Evr5FDjQX4GvBQWaS03fCMTdV1e5S55Ss+A=;
        b=hP0BtCE0WVfFBJ9MSsPLxD4+EyHCC8JZUiSjuBTeInt7i2eE2FbLfWIdTx8sDO9QVC
         34NExSa9VQfTDujlFyKvwcNGS7LDm1H3tAVvqX+GTHHBrJVPhNeZ9EwX8p1rawz6JiNe
         YnxAsrLmi0//wUXeLi0xNkqMh5lRKTY89ZU/GzAglnb605IY/EE6IhjH1JRFC0PuY438
         12GOZEJU5vjYL4XMorbCDblTbXxNVgkSRPMAdITCQzuxK2m85wDVlqMv1aZobrCLIa1j
         P2evNP29xBnFRjFHSbuwh6UvvpRgz2K85ZrwTENhSBl9pqx4s1vc/9ztAMO185QdQtRg
         lfig==
X-Forwarded-Encrypted: i=1; AJvYcCVjkVElZ0IYmLiopRLKTVM9MOt2wwrvYmVqk+fqUwQMKFCrA40lIwyJMEQcK07mrgpOZURPbJJEa6a35rKWnmF05LIjobtd/gZ6VHvp
X-Gm-Message-State: AOJu0YyJvwNrq9u/CcFkagA+SBFMOCwKzfINZqHxhTQ01L1KDJKYHpuQ
	LpZKSFHPcOR3izu++xFCs+iq8zFswASkjbffBnVNZHIlseLyVR5srLvYld4Twv0=
X-Google-Smtp-Source: AGHT+IHNZOkec6o6o+9C1SPAUFr1YKayqNHIW2bLtDJRj1fba4Jet9+45Xj6ZKfmMaIBpuUgOJYjmQ==
X-Received: by 2002:a05:600c:4f83:b0:411:fbfa:959f with SMTP id n3-20020a05600c4f8300b00411fbfa959fmr8433387wmq.27.1708331805696;
        Mon, 19 Feb 2024 00:36:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f? ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
        by smtp.gmail.com with ESMTPSA id g19-20020a7bc4d3000000b004126101915esm4868608wmk.4.2024.02.19.00.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:36:45 -0800 (PST)
Message-ID: <475dd166-6590-4a76-b076-a878c784ae31@linaro.org>
Date: Mon, 19 Feb 2024 09:36:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [DMARC error][DKIM error] [PATCH 0/5] soc: amlogic: add new
 meson-gx-socinfo-sm driver
Content-Language: en-US, fr
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Viacheslav Bocharov <adeep@lexina.in>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231122125643.1717160-1-adeep@lexina.in>
 <20240216074716.a33hrvl5xnpm7aep@CAB-WSD-L081021>
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
In-Reply-To: <20240216074716.a33hrvl5xnpm7aep@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/02/2024 08:47, Dmitry Rokosov wrote:
> Hello Neil,
> 
> May I put in my two cents on this patch series?
> 
> There appears to be a misunderstanding regarding the terminology used.
> Allow me to clarify my perspective.
> 
> The original Amlogic chipid has the following format:
> 
>      4 bytes      12 bytes
>      +-------+-------------------+
>      |       |                   |
>      | CPUID | SOC SERIAL NUMBER |
>      |       |                   |
>      +-------+-------------------+
>      0                          15
> 
> 
> In the current uboot [1] and kernel [2] upstream, only the SOC SERIAL
> NUMBER bytes are read from efuse OTP storage (and it isn't swapped, as
> Amlogic reference code does [3]). We refer to these bytes as "serial".
> 
> The original chipid value is utilized in several algorithms (for
> example, in the Amlogic boot protocols), making it crucial to have the
> ability to read the original chipid value as intended by the vendor.
> 
> In my opinion, we should align our naming terminology as follows:
>      - "chipid" - Represents the complete Amlogic SoC ID, includes
>                   "cpuid" and "serial"
>      - "serial" - 12 byte unique SoC number, identifying particular die
> 
> We strongly believe that this patch series is essential and are highly interested in seeing it applied to the upstream linux-amlogic, for the following reasons:
>      - We use chipid for device identification in our boards
>      - The Amlogic boot protocols utilize the full version of chipid
>        (ADNL, Optimus). As I mentioned in the IRC, we are preparing a
>        patch series for uboot incorporating them.
>      - in OPTEE: for generation of SSK (Secure Storage Key) [4]
>      - RPMB: for generation of RPMB key, further provisioned into RPMB
>        controller (thus particular SoC is bound to particular eMMC
> 
> Therefore, I propose that we rename "soc_id" in the Viacheslav patch
> series to "chipid" and subsequently port this patch series to uboot.
> 
> What are your thoughts on this matter?

I'm perfectly fine with that, but I don't like the shared functions, the only
shared stuff are the soc id tables, the shared functions is not important enough
to be shared.

Neil

> 
> Links:
> [1] - https://elixir.bootlin.com/u-boot/v2024.01/source/arch/arm/mach-meson/sm.c#L84
> [2] - https://elixir.bootlin.com/linux/v6.7.4/source/drivers/firmware/meson/meson_sm.c#L268
> [3] - https://github.com/CoreELEC/u-boot/blob/3efc85a8370796bcec3bcadcdecec9aed973f4a9/arch/arm/mach-meson/g12a/bl31_apis.c#L398-L417
> [4] - https://github.com/OP-TEE/optee_os/blob/5df2a985b2ffd0b6f1107f12ca2a88203bf31328/core/tee/tee_fs_key_manager.c#L152
> 
> On Wed, Nov 22, 2023 at 03:56:38PM +0300, Viacheslav Bocharov wrote:
>> The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
>> unique SoC ID starting from the GX Family and all new families.
>> But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
>> chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.
>>
>> This is the second attempt to publish data from the Amlogic secure monitor
>> chipid call. After discussions with Neil Armstrong, it was decided to
>> publish the chipid call results through the soc driver. Since
>> soc_device_match cannot wait for the soc driver to load, and the secure
>> monitor calls in turn depend on the sm driver, it was necessary to create
>> a new driver rather than expand an existing one.
>>
>> In the patches, in addition to writing the driver:
>> - convert commonly used structures and functions of the meson-gx-socinfo
>> driver to a header file.
>> - transfer the chipid sm call constants to a header file (perhaps they
>> need renaming?).
>> - add secure-monitor references for amlogic,meson-gx-ao-secure sections
>> in dts files of the a1, axg, g12, gx families.
>>
>> Viacheslav Bocharov (5):
>>    soc: amlogic: meson-gx-socinfo: move common code to header file
>>    soc: amlogic: meson-gx-socinfo: move common code to exported function
>>    firmware: meson_sm: move common definitions to header file
>>    soc: amlogic: Add Amlogic secure-monitor SoC Information driver
>>    arm64: dts: meson: add dts links to secure-monitor for soc driver in
>>      a1, axg, gx, g12
>>
>>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   1 +
>>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   1 +
>>   .../boot/dts/amlogic/meson-g12-common.dtsi    |   1 +
>>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   1 +
>>   drivers/firmware/meson/meson_sm.c             |   4 -
>>   drivers/soc/amlogic/Kconfig                   |  10 +
>>   drivers/soc/amlogic/Makefile                  |   1 +
>>   .../soc/amlogic/meson-gx-socinfo-internal.h   | 102 ++++++++++
>>   drivers/soc/amlogic/meson-gx-socinfo-sm.c     | 178 ++++++++++++++++++
>>   drivers/soc/amlogic/meson-gx-socinfo.c        | 106 ++---------
>>   include/linux/firmware/meson/meson_sm.h       |   4 +
>>   11 files changed, 317 insertions(+), 92 deletions(-)
>>   create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h
>>   create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c
>>
>> -- 
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 


