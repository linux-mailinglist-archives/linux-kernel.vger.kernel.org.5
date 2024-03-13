Return-Path: <linux-kernel+bounces-102460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD2387B26A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238BC1F26E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1734D9F8;
	Wed, 13 Mar 2024 19:59:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450694E1DB;
	Wed, 13 Mar 2024 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359948; cv=none; b=H33oN2hFdKUz22OP4VQCj0lbmtLRQH7f5vWWOlLaJYEncGWHKJS2/f0JNPIpy6ZzeqHieJbBKTqCfkdzg3XJ9jevRGXlL3UIf2CiBQ7fWf1z/m68GGLYUv2J4y7wr2fi6POMcSTrOunQMbxiEd9emmJJ/IZwqrIbsytJFhN4D1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359948; c=relaxed/simple;
	bh=tMxoBIHD4i2UejoCyKbx93/PX4tj2Zs7is+Y90aQgA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0GsHUh0uzxQ88HjRNGJC8Oeh++ieNtw4YmnltbVzhbot+oxWCM1KQCKloLlAENwYo3vRLDT4hmBxGpHjpqSRrfGROVpxSypdAG44B3iUvGVlcj5wIb6USX3IAokQrZr1ihQOyEfsBl2ZHbi6Rz1C+MTEirgRy4SkMJp+DBWIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 156BB1007;
	Wed, 13 Mar 2024 12:59:41 -0700 (PDT)
Received: from [10.57.52.245] (unknown [10.57.52.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E03BB3F64C;
	Wed, 13 Mar 2024 12:59:01 -0700 (PDT)
Message-ID: <8c784016-9257-4d8a-b956-a0a406746c76@arm.com>
Date: Wed, 13 Mar 2024 19:59:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: Add Arm remoteproc
Content-Language: en-GB
To: abdellatif.elkhlifi@arm.com, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
 Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-01 4:42 pm, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> introduce the bindings for Arm remoteproc support.
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> ---
>   .../bindings/remoteproc/arm,rproc.yaml        | 69 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 70 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml b/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
> new file mode 100644
> index 000000000000..322197158059
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/arm,rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Arm Remoteproc Devices
> +
> +maintainers:
> +  - Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> +
> +description: |
> +  Some Arm heterogeneous System-On-Chips feature remote processors that can
> +  be controlled with a reset control register and a reset status register to
> +  start or stop the processor.
> +
> +  This document defines the bindings for these remote processors.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - arm,corstone1000-extsys
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      Address and size in bytes of the reset control register
> +      and the reset status register.
> +      Expects the registers to be in the order as above.
> +      Should contain an entry for each value in 'reg-names'.
> +
> +  reg-names:
> +    description: |
> +      Required names for each of the reset registers defined in
> +      the 'reg' property. Expects the names from the following
> +      list, in the specified order, each representing the corresponding
> +      reset register.
> +    items:
> +      - const: reset-control
> +      - const: reset-status
> +
> +  firmware-name:
> +    description: |
> +      Default name of the firmware to load to the remote processor.

So... is loading the firmware image achieved by somehow bitbanging it 
through the one reset register, maybe? I find it hard to believe this is 
a complete and functional binding.

Frankly at the moment I'd be inclined to say it isn't even a remoteproc 
binding (or driver) at all, it's a reset controller. Bindings are a 
contract for describing the hardware, not the current state of Linux 
driver support - if this thing still needs mailboxes, shared memory, a 
reset vector register, or whatever else to actually be useful, those 
should be in the binding from day 1 so that a) people can write and 
deploy correct DTs now, such that functionality becomes available on 
their systems as soon as driver support catches up, and b) the community 
has any hope of being able to review whether the binding is 
appropriately designed and specified for the purpose it intends to serve.

For instance right now it seems somewhat tenuous to describe two 
consecutive 32-bit registers as separate "reg" entries, but *maybe* it's 
OK if that's all there ever is. However if it's actually going to end up 
needing several more additional MMIO and/or memory regions for other 
functionality, then describing each register and location individually 
is liable to get unmanageable really fast, and a higher-level functional 
grouping (e.g. these reset-related registers together as a single 8-byte 
region) would likely be a better design.

Thanks,
Robin.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - firmware-name
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    extsys0: remoteproc@1a010310 {
> +            compatible = "arm,corstone1000-extsys";
> +            reg = <0x1a010310 0x4>, <0x1a010314 0x4>;
> +            reg-names = "reset-control", "reset-status";
> +            firmware-name = "es0_flashfw.elf";
> +    };
> +
> +    extsys1: remoteproc@1a010318 {
> +            compatible = "arm,corstone1000-extsys";
> +            reg = <0x1a010318 0x4>, <0x1a01031c 0x4>;
> +            reg-names = "reset-control", "reset-status";
> +            firmware-name = "es1_flashfw.elf";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 54d6a40feea5..eddaa3841a65 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1768,6 +1768,7 @@ ARM REMOTEPROC DRIVER
>   M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   L:	linux-remoteproc@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
>   F:	drivers/remoteproc/arm_rproc.c
>   
>   ARM SMC WATCHDOG DRIVER

