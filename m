Return-Path: <linux-kernel+bounces-35655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E52A8394DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8F828A3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95A7F7F7;
	Tue, 23 Jan 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YKfS3eVU"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62C7F7D0;
	Tue, 23 Jan 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027820; cv=none; b=fkzfqrZcoPvK9dPHlZD1ESeHYaxLmoWYC1USpkgIOiInzfHum4IeNER/bwgp7+kMJh3qLxu4W1NNHvr041YO8xFGmzSBSQ6M84nBKble5YXYLeCj4doPmgM5nZHRDuGPAGIYb6lXt/VOMGYPgQ5iXuX4M4YYLQLJWntMu3U6Jfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027820; c=relaxed/simple;
	bh=yOSEuTIzfuAVZ01EyAtyLu+wgPr4srwS3XuNrzRBEG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r1FkVOsKancOBkyStddnv+7egEXLflAaNPds7y44akFqVF21HHJ6YnMnA9S7WrTRqDmt/LgLqifk24Pw14B0maC5Ztm58nJjpqppQmwUNPhd7tS1G5nHEzeYpm/6/F2icdp4pF8Ur+3ExlRvfRH7KEnqqFoxHnmhERRN1Lh3Tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YKfS3eVU; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NDGPpY025074;
	Tue, 23 Jan 2024 17:36:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=f4r28JTyj8rXZ4Hw+jKUzy+y+XqwXgGyRB/ME3czeEQ=; b=YK
	fS3eVU2geFjov0jvlj6gp55G9D36a/Vtu/dBbrqUO+EmXt/PHpGaOlnatwsOHzla
	pnceUuwDeuPJ/cJGKmqpuZrJC8dgmMRCCPoYwH9kqHFop/H2EsbWbUrl1VgOYgOT
	msiBqbhfAciUF9eHFyB162PxPx0RL2pVG0uILjz2foGJCd4MMwjx4xAcIRifgcSK
	APKUuzTFKj/A/dKJUa0MMWRqi8NzDmEPUL8rrd3YQu9hIQov2fGPHuJdl/5Yapb8
	IFRNHriS5sk2Iw9pqe7+mcxCDfk3TWXBpS43WRLtZUdRl6/+g+/Gy5vgG1/ws+LS
	FqaVhG5Tunxej4ENyxag==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vsrxppbxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 17:36:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 117BF100056;
	Tue, 23 Jan 2024 17:36:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0607628E3B4;
	Tue, 23 Jan 2024 17:36:14 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 17:36:13 +0100
Message-ID: <2f3144e2-2438-4ea8-ada0-3fbdd79ee131@foss.st.com>
Date: Tue, 23 Jan 2024 17:36:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] ARM: dts: add
 stm32f769-disco-mb1225-revb03-mb1166-reva09
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-amarula@amarulasolutions.com>, Lee Jones <lee@kernel.org>,
        Raphael
 Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch
 Siach <baruch@tkos.co.il>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?=
	<l.goehrs@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Peter
 Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Sean Nyekjaer
	<sean@geanix.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240112144902.40044-1-dario.binacchi@amarulasolutions.com>
 <20240112144902.40044-6-dario.binacchi@amarulasolutions.com>
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240112144902.40044-6-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02

Hi Dario

On 1/12/24 15:48, Dario Binacchi wrote:
> As reported in the section 8.3 (i. e. Board revision history) of document
> UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
> related to the board revisions addressed by the patch:
> - Board MB1225 revision B-03:
>    - Memory MICRON MT48LC4M32B2B5-6A replaced by ISSI IS42S32400F-6BL
> - Board MB1166 revision A-09:
>    - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK
> 
> The patch only adds the DTS support for the new display which belongs to
> to the Novatek NT35510-based panel family.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> 

I still have YAML error. Do you have same on your side or maybe I missed 
a dt-binding patch somewhere ?

/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dtb: 
dsi@40016c00: Unevaluated properties are not allowed ('interrupts', 
'panel-dsi@0' were unexpected)
	from schema $id: http://devicetree.org/schemas/display/st,stm32-dsi.yaml#
/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dtb: 
panel-dsi@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: 
http://devicetree.org/schemas/display/panel/novatek,nt35510.yaml#

Aside that, I just have a cosmetic question. Can we find a shorter name 
for the board ? (not sure we can).

Cheers
Alex



> ---
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
>   ...2f769-disco-mb1225-revb03-mb1166-reva09.dts | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
>   create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
> 
> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
> index 7892ad69b441..aa5b50d7ac61 100644
> --- a/arch/arm/boot/dts/st/Makefile
> +++ b/arch/arm/boot/dts/st/Makefile
> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32f469-disco.dtb \
>   	stm32f746-disco.dtb \
>   	stm32f769-disco.dtb \
> +	stm32f769-disco-mb1225-revb03-mb1166-reva09.dtb \
>   	stm32429i-eval.dtb \
>   	stm32746g-eval.dtb \
>   	stm32h743i-eval.dtb \
> diff --git a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
> new file mode 100644
> index 000000000000..014cac192375
> --- /dev/null
> +++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
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

