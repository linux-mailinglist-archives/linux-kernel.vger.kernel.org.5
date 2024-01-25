Return-Path: <linux-kernel+bounces-38253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F357F83BD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E84A1C22B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38C61BC56;
	Thu, 25 Jan 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ihRZ83cq"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B61C6AE;
	Thu, 25 Jan 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174593; cv=none; b=rJVhJWkxycuQPAGDkqpceDxMN2FmGkUTaMhRjp/aHHgwg4KmoQ7x9L63j/kkjTj/mcRiQdxv5QHPADWCMwbuvRojleLfzCrAtVFqwhwH8dzLC3dZV1ItRo5AzC/mTpfeGba5ArKCL7CdAgZO8aoBDTeCSkkwIRj1hX/gPSF+KXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174593; c=relaxed/simple;
	bh=fXFbKRBE8R8j26jWgNr+6m8YuTvOSuVQlhrk8Y4vpho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qLaNykNE41yNa7OlX3sl9N9usblXB4v8M7pGSEteunQVVx/HBP3lDTIqxaVdloCTLrNZGO8oA8bOuJjW+RJhTY+9+/2v9BUW8c04esPXpy4b15RAALMka84ARVwiF65KVvKyKAZ4XKC6vq8Fmx75oZodm1XKQZMRuoS0QKYcJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ihRZ83cq; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P3TH8o031133;
	Thu, 25 Jan 2024 10:22:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=Msx1MMGlXbEbEdl4gJcqYdH22Y4+8xYTs1q0zeYndR4=; b=ih
	RZ83cqUW5SKppQ20svWJ3WknYwfYXvi8QKlz0cDrPuSnWq5/qimrD1Vsco7yHQDj
	OoC5rbKcJhy/CXoe7gTtkHxcEpiFFAl38A36wHw1DLYBsnL9i7Uz0+hUVzC5a+Jt
	6JkuDnVFDe8pByXVQkKw6HyLxEtCDCNR9JHYKGD1lzemDwsrxMM8AiJCLEarkoNN
	PJkG8aSD63+nwlXxy1EVwwuZb8NzKRLSnyBYbC3aINEMhqpf/uL1XaADpTcw+3cR
	Ruw3Bn9powq7OrRsvFuGgLpggNxtaoUjF8FKRRtKPBFZi1zbclrz6WCcM6QCCant
	mOKRwcjUjt3xA43ZoZ/A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vtmf7q92p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:22:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CADAC10005D;
	Thu, 25 Jan 2024 10:22:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD7CC233008;
	Thu, 25 Jan 2024 10:22:22 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 25 Jan
 2024 10:22:21 +0100
Message-ID: <12b1747b-5cbb-415a-8cfd-1304be5558a6@foss.st.com>
Date: Thu, 25 Jan 2024 10:22:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] ARM: dts: add stm32f769-disco-mb1166-reva09
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-amarula@amarulasolutions.com>, Lee Jones <lee@kernel.org>,
        Raphael
 Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?=
	<l.goehrs@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob
 Herring <robh+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240124113336.658198-1-dario.binacchi@amarulasolutions.com>
 <20240124113336.658198-6-dario.binacchi@amarulasolutions.com>
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240124113336.658198-6-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_04,2024-01-24_01,2023-05-22_02

Hi Dario

On 1/24/24 12:33, Dario Binacchi wrote:
> As reported in the section 8.3 (i. e. Board revision history) of document
> UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
> related to the board revision addressed by the patch:
> - Board MB1166 revision A-09:
>    - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK
> 
> The patch adds the DTS support for the new display which belongs to the
> the Novatek NT35510-based panel family.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> 

I still have the following yaml error:

arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dtb: panel@0: 'port' 
does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: 
http://devicetree.org/schemas/display/panel/novatek,nt35510.yaml#

It seems that "port" property is missing in "novatek,nt35510.yaml" file, 
can you update it ? Or delete it in the dts file if not needed.

With this change I'll take your series.

I also saw that stm32f769-disco has a similar problem with 
orisetech,otm8009a.yaml file, "backlight" property is not defined.

thanks in advance
Alex

> ---
> 
> Changes in v9:
> - Change commit message
> - Rename stm32f769-disco-mb1225-revb03-mb1166-reva09 to
>    stm32f769-disco-mb1166-reva09
> 
> Changes in v8:
> - Add Reviewed-by tag of Linus Walleij
> - Add Reviewed-by tag of Raphael Gallais-Pou
> 
> Changes in v7:
> - Replace .dts with .dtb in the Makefile
> 
> Changes in v6:
> - Drop patches
>    - [5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
>    - [7/8] drm/panel: nt35510: move hardwired parameters to configuration
>    - [8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
>    because applied by the maintainer Linus Walleij
> 
> Changes in v5:
> - Replace GPIOD_ASIS with GPIOD_OUT_HIGH in the call to devm_gpiod_get_optional().
> 
> Changes in v2:
> - Change the status of panel_backlight node to "disabled"
> - Delete backlight property from panel0 node.
> - Re-write the patch [8/8] "drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK"
>    in the same style as the original driver.
> 
>   arch/arm/boot/dts/st/Makefile                  |  1 +
>   .../dts/st/stm32f769-disco-mb1166-reva09.dts   | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
>   create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts
> 
> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
> index 7892ad69b441..9fedd6776208 100644
> --- a/arch/arm/boot/dts/st/Makefile
> +++ b/arch/arm/boot/dts/st/Makefile
> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32f469-disco.dtb \
>   	stm32f746-disco.dtb \
>   	stm32f769-disco.dtb \
> +	stm32f769-disco-mb1166-reva09.dtb \
>   	stm32429i-eval.dtb \
>   	stm32746g-eval.dtb \
>   	stm32h743i-eval.dtb \
> diff --git a/arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts b/arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts
> new file mode 100644
> index 000000000000..014cac192375
> --- /dev/null
> +++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +#include "stm32f769-disco.dts"
> +
> +&panel_backlight {
> +	status = "disabled";
> +};
> +
> +&panel0 {
> +	compatible = "frida,frd400b25025", "novatek,nt35510";
> +	vddi-supply = <&vcc_3v3>;
> +	vdd-supply = <&vcc_3v3>;
> +	/delete-property/backlight;
> +	/delete-property/power-supply;
> +};

