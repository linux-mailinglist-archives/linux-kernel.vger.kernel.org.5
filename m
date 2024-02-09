Return-Path: <linux-kernel+bounces-59318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C45D84F54C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE341F24C95
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45721374DD;
	Fri,  9 Feb 2024 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4fU8DQn"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525837171
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482329; cv=none; b=uhlw73zhwUosoVJfHYStrqmFA7j1cxY6mXwe0GVR91T6TDbtkzEiWXGYAkgdM2mUWFhej2fltYtDhJw0UnxxUQX0Hq/Bc0I19i8h/vI7k+y5YQqUD36hnRWtLOHYm9eRnrYmhAxhhOkj2Mj7shKroMbR9w064isKK7nSiDkxakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482329; c=relaxed/simple;
	bh=/7ePMKhf/jwpNQyGAfViRmSleIJsB8xN+xpJpmyGV3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dJ482lEoHAlqCAevTl3cpI0Z8HevobR/tAgayDT5kyzzCTiEBMBxndWkti7q9PY0QabeNxM8il2efUBGuBiBDgM/xHeDpIt7dIG9ktpZANYRYxTq8UX3OD9lvcv4ip1udkfd1hdHxgqXSjqY7h0FG3vU10nfgxpozzKcRved2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b4fU8DQn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso7222155e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 04:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707482325; x=1708087125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MCv2kQLqTwyLEu6yumZzrrTFSEY37Nydh42fHPDeBe0=;
        b=b4fU8DQnKWptQOYbr+D0GzWd78swUJza1vcZMapeDfMoCNgnK/u2VQLXiEfjOHw0u+
         LjZxn6dcKgoQmpb7v6xHsZNmH+3dvXKtv9NWiDzB2UabejvZQQ8mxmAPtKJuU62c9iPu
         fwJ2/gp4AFLCWMbk5d/9t0fuF+TRNNHQjVHcAhHgsTLe1Dk5rBtPyiBbs9EMPzCPUd7Z
         D7QouYe/0vxCPKgMO+oZBYfxJKrDaMLcLIfziug9qB2JBQd4sQGbiLOWaRvRcfuZvF+b
         UugmTy20sSZkCSulx/P60C2RUAOiLIBXLpR4VpK6DnNxd2eE22z0zlos6TqDlRAJZfg8
         V0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707482325; x=1708087125;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCv2kQLqTwyLEu6yumZzrrTFSEY37Nydh42fHPDeBe0=;
        b=Ai8DzYVbgrjMIx70KRH8WSplQcJK+oXMbEtkKO75pgU0coqVHF5t+HLzffsIqqRUCR
         a+EaOTwL3AnyWc9QGx0JyBM9fPMfuK2QsZpEFp8CssoAHYo34LtuFi02VgWLvsqlyInq
         VBpX/NW2wPrPKOSV5wsaCp+hjXEH+Zs1uFaVbLfS2ugOrcAsr/PWZEDdAZCxL3rK/mKR
         N6A5BqJiTTTgNqFvAH06+zbtviCdZA62SQ+aDppeGiD9F7nNrrRfVBk3iksIsuwN/zJV
         hmVOT1OWIkGA49ZG+wcKvqZm2gL30GSr/vMLT4f+JwSRlfICnFXf8Niw1SF6kkXcOwOJ
         yzbg==
X-Gm-Message-State: AOJu0Yyj/DZj9DUfc60lRHU5Qq6yjDHifwVOX+Ud9QGegncEGQ1tE1Z/
	maA9ME2zu5Tuw617ijdSYmxEqW3X6bE3vlLs45hOeZQGqTM0I7JpJSwSsmcKiHY9wCQvuZ/UR+b
	u
X-Google-Smtp-Source: AGHT+IFaynWaB4IOtcO4cVsPTOTuo8vTmoP1T8geeHJOYORcTko7JoBDxt1ruNCLKTCEVwR7Q91Z3w==
X-Received: by 2002:a05:600c:1c81:b0:40f:4e0a:4ead with SMTP id k1-20020a05600c1c8100b0040f4e0a4eadmr920192wms.26.1707482325455;
        Fri, 09 Feb 2024 04:38:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWH45pCXG3ZTSbLNCdN35lJIE4pV+eRqZI62/Iwo68mO96KiIvKzmeNe+pCIZ4B2dNaMEHFNgUyiNbxdbcXiDjsDcruf86HCRB0SvXE2Kai4ruPzYNukRLcBDDXddathsMaiMVr10zX9IX8vDGUDSF+LvYW9Ya9c2ojj6XF+iTTrp3V5g97dAqsiEzp1bg/jbi2tU4vgQPqGAIZMUN5o0af4M28s74q7lQT2ninCSPTrLPsEg7tIxNspR9QlXf/U6kHqXV+872UXqV4rzfHbKk2I/g9RKy2gwcYTk7RtmbBsp88eH59Ct25XEXU1WwA83Wqjlr+W5JrVQiujSytvxfTw7dDyZL1qo+160DnaDSzzQ+dJfANoRZR
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ay3-20020a05600c1e0300b004107ab8158bsm569370wmb.2.2024.02.09.04.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 04:38:45 -0800 (PST)
Message-ID: <dda6c22e-8f35-4c18-9fea-6a6295dee3a1@linaro.org>
Date: Fri, 9 Feb 2024 13:38:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
To: Supreeth Venkatesh <supvenka@amd.com>,
 Supreeth Venkatesh <supreeth.venkatesh@amd.com>, joel@jms.id.au,
 andrew@aj.id.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, robh+dt@kernel.org
References: <20240110033543.799919-1-supreeth.venkatesh@amd.com>
 <d4fe8b55-a1ea-4ce7-89ac-ce17e8ff4e45@amd.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d4fe8b55-a1ea-4ce7-89ac-ce17e8ff4e45@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 15:57, Supreeth Venkatesh wrote:
> This patch is pending for a month now.
> 
> Can DT maintainers please help review this and provide feedback?

I don't have the original patch in my inbox anymore, so probably you
should resend. Anyway quick look points to obvious issues (comments below).

> 
> On 1/9/24 21:35, Supreeth Venkatesh wrote:
>> This patch adds initial device tree and makefile updates for
>> AMD Onyx platform.
>>
>> AMD Onyx platform is an AMD customer reference board with an Aspeed
>> ast2600 BMC manufactured by AMD.
>> It describes I2c devices, Fans, Kcs devices, Uarts, Mac, LEDs, etc.
>> present on AMD Onyx platform.
>>
>> Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |  1 +
>>   .../boot/dts/aspeed/aspeed-bmc-amd-onyx.dts   | 98 +++++++++++++++++++
>>   2 files changed, 99 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>> index fb9cc95f1b60..2b27d377aae2 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-ast2600-evb.dtb \
>>   	aspeed-bmc-amd-daytonax.dtb \
>>   	aspeed-bmc-amd-ethanolx.dtb \
>> +	aspeed-bmc-amd-onyx.dtb \
>>   	aspeed-bmc-ampere-mtjade.dtb \
>>   	aspeed-bmc-ampere-mtmitchell.dtb \
>>   	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>> new file mode 100644
>> index 000000000000..a7056cd29553
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Copyright (c) 2021 - 2024 AMD Inc.
>> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>> +
>> +/dts-v1/;
>> +
>> +#include "aspeed-g6.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +
>> +/ {
>> +       model = "AMD Onyx BMC";
>> +       compatible = "amd,onyx-bmc", "aspeed,ast2600";

Undocumented compatibles.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

>> +
>> +       aliases {
>> +               serial0 = &uart1;
>> +               serial4 = &uart5;
>> +      };
>> +
>> +       chosen {
>> +               stdout-path = &uart5;
>> +               bootargs = "console=ttyS4,115200 earlyprintk vmalloc=512MB";

earlyprintk is debugging, not for mainline, so drop.

Console should be encoded in stdout-path.

vmalloc looks like OS tuning, so also not suitable for mainline DTS.


>> +       };
>> +
>> +       memory@80000000 {
>> +               device_type = "memory";
>> +               reg = <0x80000000 0x80000000>;
>> +       };
>> +

Drop redundant blank lines.

>> +};
>> +
>> +&mdio0 {
>> +       status = "okay";
>> +
>> +       ethphy0: ethernet-phy@0 {
>> +               compatible = "ethernet-phy-ieee802.3-c22";
>> +               reg = <0>;
>> +       };
>> +};
>> +
>> +&mac3 {
>> +       status = "okay";
>> +       phy-mode = "rgmii";
>> +       phy-handle = <&ethphy0>;
>> +
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_rgmii4_default>;
>> +};
>> +
>> +>> +

Drop redundant blank lines. You can open existing, recent DTS from
maintained platforms like Qcom or TI and look there at coding style.



Best regards,
Krzysztof


