Return-Path: <linux-kernel+bounces-154537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787848ADD56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA61F22AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF8D225AE;
	Tue, 23 Apr 2024 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iGvnYS9m"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7E63C8;
	Tue, 23 Apr 2024 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713852696; cv=none; b=Zd0OQYsKxDb2F6SRXHb2IXwi9edVH4agyIkw+Y7jz+BmMXRDfO8AA9xAYugV+5B6P7En2ISv+5vo8tYzKANroMVct5Hq7winlEKr8Lap+vXZYV4uogJz7K92K3Yi9o0g90VGKCn8DmvnYxQ73kPObFdKAUYHQBD9fOrZu11X4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713852696; c=relaxed/simple;
	bh=w31PcluYey0MaZLOk51qwGylQZCnQvX5ImKoMCDqQt8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dKYstuh/5b1Mzf/zJhgELJrwdHPTbtG0pBEqBWMK0jTKJa/iACJ6/fsUgrimumDRyAWhPa+llkZf6egWfhGtNBn7Z+MGlUfS6B5AexxAQ/UXaJCrBQSBlkwOmhu7bRQuQdp9f5ZNESgzsv9a5pIfwzIpSpwxMcEucF7IwdSRolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iGvnYS9m; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0398040003;
	Tue, 23 Apr 2024 06:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713852691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emJM6JECa8OhqTBhCwE/o7mPRrnseSWT8F4796SNfSo=;
	b=iGvnYS9mH/mNc/kmCknZxVTnmloR18k9z0DPL8exdP8dQHbFcbnLPPd7SO92i9nzwJF7fV
	e3+9O8qpfpMLpeH7KUpcT+PLXw1Z9+K+M5Z8p/tFiPi406YfxBKTlAj8V3cjwhAZX/fu8T
	x5XnOy9qcqZJITmZty25Mkggh3IWfqSWwyj0K34V6dqftxq+YpGdkUTUhoP51FLNST82cV
	47kThbG+YS2Jr0HhluoyZYQov8N+PJ3g+WxAkjakwgC2TXKt3qwrG0WOk88hWfENB8rQ0g
	LwNUnED1+tvTj4/EaoxD2xM0HkLNlBihmWOP9xHl0CpKJMFWW7Vozx1jaR4QIw==
Message-ID: <fbdcc77e-eab4-41da-803c-d65405f37f02@bootlin.com>
Date: Tue, 23 Apr 2024 08:11:29 +0200
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
 <e457d5f6-3289-4049-b663-2ebcfe78dce4@bootlin.com>
 <IA1PR20MB4953D0D45EB0EDB6E8046664BB132@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <IA1PR20MB4953D0D45EB0EDB6E8046664BB132@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Inochi,

Thanks for the advice.

On 4/21/24 at 08:30, Inochi Amaoto wrote:
> On Sun, Apr 21, 2024 at 07:57:01AM GMT, Michael Opdenacker wrote:
> +++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "cv1812h.dtsi"
> +
> +/ {
> +	model = "Milk-V Duo S";
> +	compatible = "milkv,duos", "sophgo,cv1812h";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>;
> +	};
>>> Add a cpu specific file, and move this to it.
>> Now that I'm including "cv1812h.dtsi", which has the same structure, all I
>> need is to change the reg setting to have 512 MB of RAM instead of 256MB,
>> right? See the V6 I'm sending soon.
>>
> No, Duo S does not use cv1812h, in any means. I just told you to use
> cv1812h for local test. If you want to upstream Duo S, you must add
> the right cpu compatibles and necessary nodes. These two are different
> things.

So, do you mean I should create a new "sophgo,sg2000" compatible, 
together with  a new "sg2000.dtsi" (or "sg200x.dtsi"?) file? Could this 
file include "cv18xx.dtsi"?

By the way, where's the best source of information about the Sophgo 
sg2000 and sg2002 processors? Even the Sophgo website doesn't seem to 
have them :-/ . It just mentions the CV18xx ones.

Thanks again
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


