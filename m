Return-Path: <linux-kernel+bounces-23476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF382AD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBE6B26EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A40914F92;
	Thu, 11 Jan 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ady4bBw4"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC031549A;
	Thu, 11 Jan 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BA1fUg011257;
	Thu, 11 Jan 2024 12:22:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=m3GNVAvX3k8htTlkp4Usks8fTVv88WEHu4xrWJGJQwU=; b=Ad
	y4bBw4Wy7pvRySTAQn+a92J5NKcopXq7oMKUuI3RDuYuu2S1D+2PHarEO5pnuRO7
	ClWnlSti34jH4+rSXWpgUI8MbqTjO3xAKQrbFbyFTE5LAqJ8lkjdbQqipABTCJ+8
	ZG7Wqi2DpnFzLDRHQrCNG1iq2YdTT38yNI3/VkFFlW13DqK8KwxCnfNMgwu82EZT
	pH5SA6w+Gyf+w/R74zmuN8SLHIJIhIN3wbwHMe8cAA9n2RTe1083OSCE2s4JvbOa
	hyjUlLD3SWqGdq+bqrm46uKQV4tOjCSABUXdXyP6+rUDvW07iBxfiWh08DspZGXc
	4sx3iaPbHKR5b0rFyROw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vexrccsnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 12:22:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DC0D10002A;
	Thu, 11 Jan 2024 12:22:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3EA4E237D84;
	Thu, 11 Jan 2024 12:22:52 +0100 (CET)
Received: from [10.252.29.122] (10.252.29.122) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Jan
 2024 12:22:49 +0100
Message-ID: <7889dff7-2c38-43c0-b6f7-281a20ae9733@foss.st.com>
Date: Thu, 11 Jan 2024 12:22:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH v6 5/5] ARM: dts: add
 stm32f769-disco-mb1225-revb03-mb1166-reva09
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Florian
 Fainelli <f.fainelli@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andre Przywara
	<andre.przywara@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, <linux-amarula@amarulasolutions.com>,
        Peter Rosin <peda@axentia.se>, <linux-arm-kernel@lists.infradead.org>
References: <20240110080729.3238251-1-dario.binacchi@amarulasolutions.com>
 <20240110080729.3238251-6-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240110080729.3238251-6-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02


On 1/10/24 09:05, Dario Binacchi wrote:
> As reported in the section 8.3 (i. e. Board revision history) of document
> UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
> related to the board revisions addressed by the patch:
> - Board MB1225 revision B-03:
>   - Memory MICRON MT48LC4M32B2B5-6A replaced by ISSI IS42S32400F-6BL
> - Board MB1166 revision A-09:
>   - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK
>
> The patch only adds the DTS support for the new display which belongs to
> to the Novatek NT35510-based panel family.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
> Changes in v6:
> - Drop patches
>   - [5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
>   - [7/8] drm/panel: nt35510: move hardwired parameters to configuration
>   - [8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
>   because applied by the maintainer Linus Walleij
>
> Changes in v5:
> - Replace GPIOD_ASIS with GPIOD_OUT_HIGH in the call to devm_gpiod_get_optional().
>
> Changes in v2:
> - Change the status of panel_backlight node to "disabled"
> - Delete backlight property from panel0 node.
> - Re-write the patch [8/8] "drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK"
>   in the same style as the original driver.
>
>  arch/arm/boot/dts/st/Makefile                  |  1 +
>  ...2f769-disco-mb1225-revb03-mb1166-reva09.dts | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
>
> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
> index 7892ad69b441..390dbd300a57 100644
> --- a/arch/arm/boot/dts/st/Makefile
> +++ b/arch/arm/boot/dts/st/Makefile
> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
>  	stm32f469-disco.dtb \
>  	stm32f746-disco.dtb \
>  	stm32f769-disco.dtb \

Hi Dario,


Did you meant dtb here ? ;)


Regards,

Raphaël

> +	stm32f769-disco-mb1225-revb03-mb1166-reva09.dts \
>  	stm32429i-eval.dtb \
>  	stm32746g-eval.dtb \
>  	stm32h743i-eval.dtb \
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

