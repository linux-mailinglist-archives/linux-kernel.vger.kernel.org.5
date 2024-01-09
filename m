Return-Path: <linux-kernel+bounces-21420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD12828EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26970B24F57
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEB53DB8F;
	Tue,  9 Jan 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mGJXSdUt"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380A53DB81;
	Tue,  9 Jan 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409LWCt4066726;
	Tue, 9 Jan 2024 15:32:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704835932;
	bh=8A3QGAA9HNfAlHBJ5H1Pvkj719z47zsKht4dME/yYBA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mGJXSdUtGqr8wIZBDPWp3Jl5rfDm3ketQ8C6cMOS2PxIY6BvAxYuKNB/5MgHoPZQQ
	 RsM94QWUXTafiRnqiq/u792vR4vl2OwpNX12dKhgVdy9rlu6fcp4ehNR/28JzOoFsg
	 oGtLQFfwW7LLqsDJJ+LUMqIdNVTjUX7VtG9v/vnk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409LWCvt064895
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jan 2024 15:32:12 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 15:32:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 15:32:11 -0600
Received: from [10.249.40.136] ([10.249.40.136])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409LWB0L102525;
	Tue, 9 Jan 2024 15:32:11 -0600
Message-ID: <5c01d596-1b98-4073-b361-faf7301faf62@ti.com>
Date: Tue, 9 Jan 2024 15:32:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: keystone: Replace http urls with https
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240109195612.3833281-1-nm@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240109195612.3833281-1-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/9/24 1:56 PM, Nishanth Menon wrote:
> Replace http url instances with https.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi      | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi  | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts      | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi   | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi         | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts      | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts      | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi   | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi         | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts     | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi  | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi        | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi  | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts      | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi   | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi         | 2 +-
>   arch/arm/boot/dts/ti/keystone/keystone.dtsi             | 2 +-
>   18 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi
> index 0397c3423d2d..20bab90ee0ba 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for Keystone 2 clock tree
>    *
> - * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   clocks {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi
> index cf30e007fea3..74720dbf3110 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 Edison SoC specific device tree
>    *
> - * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   clocks {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
> index 6978d6a362f3..58099ce8d449 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 Edison EVM device tree
>    *
> - * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   /dts-v1/;
>   
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
> index 5c88a90903b8..e586350ae4dc 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for Keystone 2 Edison Netcp driver
>    *
> - * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   qmss: qmss@2a40000 {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
> index 65c32946c522..662aa33cba11 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 Edison soc device tree
>    *
> - * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/reset/ti-syscon.h>
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
> index f0ddbbcdc972..bf5f67d70235 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for K2G EVM
>    *
> - * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   /dts-v1/;
>   
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts
> index 6ceb0d5c6388..264e1e0d23c8 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for K2G Industrial Communication Engine EVM
>    *
> - * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   /dts-v1/;
>   
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
> index 7109ca031617..974c8f2fa740 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for K2G Netcp driver
>    *
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   qmss: qmss@4020000 {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
> index 102d59694d90..790b29ab0fa2 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for K2G SOC
>    *
> - * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi
> index 4ba6912176ef..3ca4722087c9 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 Kepler/Hawking SoC clock nodes
>    *
> - * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   clocks {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
> index 8dfb54295027..b824fad9a4ec 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 Kepler/Hawking EVM device tree
>    *
> - * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   /dts-v1/;
>   
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
> index c2ee775eab6a..3ab1b5d6f9bc 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for Keystone 2 Hawking Netcp driver
>    *
> - * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   qmss: qmss@2a40000 {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
> index da6d3934c2e8..4fdf4b30384f 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 Kepler/Hawking soc specific device tree
>    *
> - * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/reset/ti-syscon.h>
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi
> index 635528064dea..fcfc2fb6cc2d 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 lamarr SoC clock nodes
>    *
> - * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   clocks {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
> index be619e39a16f..ccda63ab12fe 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 Lamarr EVM device tree
>    *
> - * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   /dts-v1/;
>   
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
> index 1afebd7458c1..b8f880faaa31 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for Keystone 2 Lamarr Netcp driver
>    *
> - * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   qmss: qmss@2a40000 {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> index 2062fe561642..330b437b667f 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone 2 Lamarr SoC specific device tree
>    *
> - * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/reset/ti-syscon.h>
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone.dtsi b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
> index 1fd04bb37a15..ff16428860a9 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/interrupt-controller/arm-gic.h>

