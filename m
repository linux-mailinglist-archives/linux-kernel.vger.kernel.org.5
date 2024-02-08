Return-Path: <linux-kernel+bounces-57489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B839C84D9BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69014285FB8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0E67C6D;
	Thu,  8 Feb 2024 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="tpHMyee2"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48A67C65
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371921; cv=none; b=cnK+rg2/jc/Q7WVr+kJnesBmB0SHWDLzBHDwFqLJH6Rf6ahYCVlODVyyHCWNCIkxuByo/C8d2b4U1veSnbgIqo+kyH4xX7N9wWsxCstei6Z/TQa6RhuBw3tzLE1Le8EgAdS8RN15Ugpu/Ux1gAwFV4PRhgathLT7eEC+fgKbBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371921; c=relaxed/simple;
	bh=vuZmv02dgek1NDNGlHYGyHlv7kNbKCbt/ogFrVSEmrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GdNh3UUyaikQsyWOiC7i+rGvr7eslOpjRsv0h/PSVDjfyPFZOU8iiqo6n/kW4Vithc51CldqNZQaI2ua3+Tp7/2BZesXASbxfT2DH6YUbLafPkuma9SprTVsKEqon+DzvFmh/AjlIVPyx+jpjsvsDY/3gYkdJH6Zb6dAQt15XAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=tpHMyee2; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1707371909; x=1709963909;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vuZmv02dgek1NDNGlHYGyHlv7kNbKCbt/ogFrVSEmrE=;
	b=tpHMyee2nQ0RjIZ6DuNAznJ00uqmWPA5IQSVlruzUzX3cN+UQnYc7rWZJpksL1Ol
	Ea7iytXeW0pzmLrCnFJO1U/v50O0uxJWU3npZCsTBe1QzvpF6yvb7dvY8L1TbIXK
	fYjVbh+l0NcydrSSc1aNsGgY45S9u4Fkn0i1wIWyepE=;
X-AuditID: ac14000a-fadff7000000290d-61-65c46d8490f8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 13.5E.10509.48D64C56; Thu,  8 Feb 2024 06:58:28 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 8 Feb 2024
 06:58:50 +0100
Message-ID: <033de6e2-4ca4-46bc-a0a7-e9921ed15977@phytec.de>
Date: Thu, 8 Feb 2024 06:57:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable
 a GPIO fan
To: Andrew Davis <afd@ti.com>, Nathan Morrisson <nmorrisson@phytec.com>,
	<nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240207172820.478332-1-nmorrisson@phytec.com>
 <acd3c7f2-930d-46c0-9924-9775e9795fca@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <acd3c7f2-930d-46c0-9924-9775e9795fca@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWyRpKBR7cl90iqwZW3VhbvT01kt1iz9xyT
	xfwj51gtln+ezW7R9+Ihs8Wmx9dYLS7vmsNm8ebHWSaLD42b2Sxa9x5ht+h+p27x/+wHdgce
	j02rOtk87lzbw+axeUm9R393C6vHn4vvWD2O39jO5PF5k1wAexSXTUpqTmZZapG+XQJXxueO
	GawFe2Qrfl66wdjAOFOyi5GTQ0LARGLBn4ksXYxcHEICi5kkTt9cyAjh3GGUONG/grWLkYOD
	V8BGYt9Cd5AGFgEViUO9fSwgNq+AoMTJmU/AbFEBeYn7t2awg9jCAtESC+/MBbNFBC4xStx/
	Uwgyk1mgjVHiycMDzCAJIYFsiZUrjoEVMQuIS9x6Mp8JxGYTUJe4s+EbK4jNKWAlcePMJUaI
	GguJxW8OQtXLSzRvnQ01R17ixaXlLBDfyEtMO/eaGcIOldj6ZTvTBEbhWUhunYVk3SwkY2ch
	GbuAkWUVo1BuZnJ2alFmtl5BRmVJarJeSuomRlAMijBw7WDsm+NxiJGJg/EQowQHs5IIr9mO
	A6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGKfZXNX/
	v2ypyqEGxajw9bVrv9Z06ugfOPHrb9XM+1d2nkqaG/YxmeXRRqNd5/P0Vq78YWLzIPX4LI7/
	2j+n/bFfw/ZzxhOzglheyZYXPYdkb6WozTlpI7VrZ0nO0zT/v9M0HbREND4fzb6g4SsfrKGv
	8Ze7+XG9e/POur62ORzLni+MsD+iG63EUpyRaKjFXFScCACWX/irrwIAAA==

Hi Andrew,

Am 07.02.24 um 23:20 schrieb Andrew Davis:
> On 2/7/24 11:28 AM, Nathan Morrisson wrote:
>> The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
>> header and sets the fan to turn on at 65C.
>>
>> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
>> ---
>>   arch/arm64/boot/dts/ti/Makefile               |  1 +
>>   .../ti/k3-am62-phyboard-lyra-gpio-fan.dtso    | 51 +++++++++++++++++++
>>   2 files changed, 52 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile 
>> b/arch/arm64/boot/dts/ti/Makefile
>> index 52c1dc910308..379fb4f31a1f 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-mallow.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-am62-phyboard-lyra-gpio-fan.dtbo
>
> Why not call this k3-am625-phyboard-lyra-gpio-fan.dtbo to match the
> name of the base board it applies to better?

We are able to reuse this overlay for different SoMs (am625 and am62a) 
that are using the same carrier board (lyra).

Regards,
Wadim


>
> Andrew
>
>>     # Boards with AM62Ax SoC
>>   dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
>> diff --git 
>> a/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso 
>> b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
>> new file mode 100644
>> index 000000000000..9c05748bdd9d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +/*
>> + * Copyright (C) 2024 PHYTEC America LLC
>> + * Author: Garrett Giordano <ggiordano@phytec.com>
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/thermal/thermal.h>
>> +#include "k3-pinctrl.h"
>> +
>> +&{/} {
>> +    fan: gpio-fan {
>> +        compatible = "gpio-fan";
>> +        gpio-fan,speed-map = <0 0 8600 1>;
>> +        gpios = <&main_gpio0 40 GPIO_ACTIVE_LOW>;
>> +        #cooling-cells = <2>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&gpio_fan_pins_default>;
>> +        status = "okay";
>> +    };
>> +};
>> +
>> +&main_pmx0 {
>> +    gpio_fan_pins_default: gpio-fan-default-pins {
>> +        pinctrl-single,pins = <
>> +            AM62X_IOPAD(0x0a4, PIN_OUTPUT, 7) /* (M22) 
>> GPMC0_DIR.GPIO0_40 */
>> +        >;
>> +    };
>> +};
>> +
>> +&thermal_zones {
>> +    main0_thermal: main0-thermal {
>> +        trips {
>> +            main0_thermal_trip0: main0-thermal-trip {
>> +                temperature = <65000>;  /* millicelsius */
>> +                hysteresis = <2000>;    /* millicelsius */
>> +                type = "active";
>> +            };
>> +        };
>> +
>> +        cooling-maps {
>> +            map0 {
>> +                trip = <&main0_thermal_trip0>;
>> +                cooling-device = <&fan THERMAL_NO_LIMIT 
>> THERMAL_NO_LIMIT>;
>> +            };
>> +        };
>> +    };
>> +};
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

