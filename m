Return-Path: <linux-kernel+bounces-152448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D578ABEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 07:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADFA1C2061C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E9D27E;
	Sun, 21 Apr 2024 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d4KjKCq+"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89F205E09;
	Sun, 21 Apr 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713679035; cv=none; b=FS9v7Sni7BYKfze/IPiEKxVOCQbhkx7W3imqbyRg3tYCHrD/nSN9eAnyB1/M1Da5l+PXiRG8AJc+Ng2Q8V/oACnQ/DxLxyrXVHh2V/9bA1PLJ4C4zYBnWy1HkcuQdo/oTYpLsIswQdEYZ+Lg7SH5WS9g84erhxZg51TOClSimy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713679035; c=relaxed/simple;
	bh=HYAdyF9w3Py4palVMx8BhCLJkMMxu/UozC/oJYUDqM8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dahMHs8H1y19ymHmPSveuKmvNJCb3tNS7dn1PqQFm/UyhIss6s2YINpBYPCZtt+skK/1FPruwo6o3ASCLEwlczPX9JCQORGcth0xC/8OoVwZe9sj/Pp2iBAK5iVQ51P01jMWv3IZzjWfdd9Zme9HnOOzMkxVOmCpZIxN53XoSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d4KjKCq+; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 207B540003;
	Sun, 21 Apr 2024 05:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713679024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2Kjmtq3Ybi5b8tattuXhRtpcAjxJmV4CBtd58iYrr0=;
	b=d4KjKCq+u+3vSraYnDy7e+yvNOQXi1W3H6Vimzr/Wo/QpqS53ewWw9HX5A1vo7ZoaTLkzE
	SDfV/p3+7skZXNlTP29vVva5sj2qg1elJ4A3L9PSdqpxM5D1GIJdLNSIIzK1HUjqnFgJsg
	uODQ0wUQFk2VuFI+hxhUnWP+pW3ivnvTM/ms3iGSda90JIz2HM+EFxCsGztM2RioHAdX0l
	AnjZCADOdeNbbP3ommWGIHZuUJ3ogJWeaWyBCjZ/S6ekhIW/sAkeK78+DQIPzXZd33fUUO
	8Nf/FzFArX94aS2PaCT+aHR72EuiTrDB3EAcKLpvA8ltAppwOnqAoIWoiCmKzg==
Message-ID: <e457d5f6-3289-4049-b663-2ebcfe78dce4@bootlin.com>
Date: Sun, 21 Apr 2024 07:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: dts: sophgo: add initial Milk-V Duo S board
 support
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
 <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
 <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Inochi

Thanks for your advice!

On 4/17/24 at 11:34, Inochi Amaoto wrote:
> On Wed, Apr 17, 2024 at 08:53:11AM GMT, michael.opdenacker@bootlin.com wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> This adds initial support for the Milk-V Duo S board
>> (https://milkv.io/duo-s), enabling the serial port,
>> making it possible to boot Linux to the command line.
>>
>> Link: https://lore.kernel.org/linux-riscv/171266958507.1032617.9460749136730849811.robh@kernel.org/T/#t
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> ---
>>   arch/riscv/boot/dts/sophgo/Makefile           |  1 +
>>   .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 34 +++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
>> index 57ad82a61ea6..e008acb5240f 100644
>> --- a/arch/riscv/boot/dts/sophgo/Makefile
>> +++ b/arch/riscv/boot/dts/sophgo/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
>> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2000-milkv-duos.dtb
>>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
>> new file mode 100644
>> index 000000000000..c1ecf97d5e93
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "cv1812h.dtsi"
>> +
>> +/ {
>> +	model = "Milk-V Duo S";
>> +	compatible = "milkv,duos", "sophgo,cv1812h";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x20000000>;
>> +	};
> Add a cpu specific file, and move this to it.

Now that I'm including "cv1812h.dtsi", which has the same structure, all 
I need is to change the reg setting to have 512 MB of RAM instead of 
256MB, right? See the V6 I'm sending soon.

>
>> +};
>> +
>> +&osc {
>> +	clock-frequency = <25000000>;
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> -- 
>> 2.34.1
>>
> Add necessary DT node in the cpu specific file. (clint,
> plic and clk). You also need to rebase your patch based
> on sophgo/for-next.

Same here, cv1812h.dtsi already configures &clint, &plic and &clk, so it 
seems to me I don't need to make changes again here. At least the board 
boots fine for me as it is.
Cheers
Michael.


-- 

Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


