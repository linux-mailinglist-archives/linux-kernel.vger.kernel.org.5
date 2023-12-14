Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F58134EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573834AbjLNPhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573801AbjLNPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:37:44 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671C10F;
        Thu, 14 Dec 2023 07:37:50 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BEFRSLY006650;
        Thu, 14 Dec 2023 16:37:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=z+Okecx9m3lcQPbiL7ZlZzQneMvRP6AYBDxySkUnCxA=; b=e6
        f2Z6krzrutBAiwdO7Z2D4b7/heMdokJJ/UEjc9gVA1NIYUflmISkKwznYUtUSVQ1
        eCOHF321XRe+RyBRHoJe8zDnLkaloW7HUfOhSjHnuf2f9+3MGJszOQXMvtLHDF85
        U2HwpVw0ig8p9GCHPP6RKouLZyyHjPQPY8i6VeN8LrtXO0jVSTAIBa8KGlnKFcLZ
        WqIZ2qlyFqavLQ169t/eM4VOljjW2ZBnSSAYOT9z+0WbQ6zZ5Tpgah9JMgkWwpPS
        6XVxDd53fW/lYADzwYau6pCL+lJS/6lPFoDziDe/bs2C5TUQ2alurFqOqWuKenvy
        tVC7dsnPq69aRo8u5NSg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvg0h5m92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 16:37:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A19D100053;
        Thu, 14 Dec 2023 16:37:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 107ED26C06D;
        Thu, 14 Dec 2023 16:37:33 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Dec
 2023 16:37:32 +0100
Message-ID: <8adec7b4-bdd9-4ad0-a302-326ed99ea732@foss.st.com>
Date:   Thu, 14 Dec 2023 16:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: stm32: don't mix SCMI and non-SCMI board
 compatibles
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231122185235.2017642-1-a.fatoum@pengutronix.de>
 <20231122185235.2017642-2-a.fatoum@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20231122185235.2017642-2-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_10,2023-12-14_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 11/22/23 19:52, Ahmad Fatoum wrote:
> The binding erroneously decreed that the SCMI variants of the ST
> evaluation kits are compatible with the non-SCMI variants.
> 
> This is not correct, as a kernel or bootloader compatible with the non-SCMI
> variant is not necessarily able to function, when direct access
> to resources is replaced by having to talk SCMI to the secure monitor.
> 
> The binding has been adjusted to reflect thus, so synchronize the device
> trees now.
> 
> Fixes: 5b7e58313a77 ("ARM: dts: stm32: Add SCMI version of STM32 boards (DK1/DK2/ED1/EV1)")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---

Thanks to have fix my error.

Both patches applied on stm32-next.

Cheers
Alex

>   arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts | 2 +-
>   arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts | 2 +-
>   arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts | 2 +-
>   arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts | 3 +--
>   4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
> index afcd6285890c..c27963898b5e 100644
> --- a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
> @@ -11,7 +11,7 @@
>   
>   / {
>   	model = "STMicroelectronics STM32MP157A-DK1 SCMI Discovery Board";
> -	compatible = "st,stm32mp157a-dk1-scmi", "st,stm32mp157a-dk1", "st,stm32mp157";
> +	compatible = "st,stm32mp157a-dk1-scmi", "st,stm32mp157";
>   
>   	reserved-memory {
>   		optee@de000000 {
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
> index 39358d902000..622618943134 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
> @@ -11,7 +11,7 @@
>   
>   / {
>   	model = "STMicroelectronics STM32MP157C-DK2 SCMI Discovery Board";
> -	compatible = "st,stm32mp157c-dk2-scmi", "st,stm32mp157c-dk2", "st,stm32mp157";
> +	compatible = "st,stm32mp157c-dk2-scmi", "st,stm32mp157";
>   
>   	reserved-memory {
>   		optee@de000000 {
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
> index 07ea765a4553..c7c4d7e89d61 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
> @@ -11,7 +11,7 @@
>   
>   / {
>   	model = "STMicroelectronics STM32MP157C-ED1 SCMI eval daughter";
> -	compatible = "st,stm32mp157c-ed1-scmi", "st,stm32mp157c-ed1", "st,stm32mp157";
> +	compatible = "st,stm32mp157c-ed1-scmi", "st,stm32mp157";
>   
>   	reserved-memory {
>   		optee@fe000000 {
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
> index 813086ec2489..2ab77e64f1bb 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
> @@ -11,8 +11,7 @@
>   
>   / {
>   	model = "STMicroelectronics STM32MP157C-EV1 SCMI eval daughter on eval mother";
> -	compatible = "st,stm32mp157c-ev1-scmi", "st,stm32mp157c-ev1", "st,stm32mp157c-ed1",
> -		     "st,stm32mp157";
> +	compatible = "st,stm32mp157c-ev1-scmi", "st,stm32mp157c-ed1", "st,stm32mp157";
>   
>   	reserved-memory {
>   		optee@fe000000 {
