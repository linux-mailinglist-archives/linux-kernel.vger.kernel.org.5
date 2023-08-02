Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12B76CB36
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjHBKqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjHBKqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:46:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DC9C;
        Wed,  2 Aug 2023 03:46:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372AkcAm090085;
        Wed, 2 Aug 2023 05:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690973198;
        bh=sjKISY2w4kPMY4QfWdJQ8Vgjr9mMhjxX+gcxu7Aoczs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RxN4CqH7ELdHXP0ff6jYb8Jz0eqPSHh1ztNsSLtZfNVLiDkG3bb6JpkC7cM6ABVMi
         W33cnA59UMkjVYsH6Fd7voXdBaAOzwmXR+sP2I/PIUteVw2dhyuvLwYHU9LBz1BbCu
         +UCsHPanqpcd9EOz+PdQUckjXnaW/RYy7uVYO0yU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372Akcai023112
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 05:46:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 05:46:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 05:46:38 -0500
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372AkY7t030456;
        Wed, 2 Aug 2023 05:46:34 -0500
Message-ID: <22e92c94-b3ee-3505-57d3-a3243e8671d8@ti.com>
Date:   Wed, 2 Aug 2023 16:16:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
 <20230731-mcasp_am62a-v1-5-8bd137ffa8f1@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230731-mcasp_am62a-v1-5-8bd137ffa8f1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/23 18:14, Jai Luthra wrote:
> SK-AM62A-LP uses TPS6593x PMIC (interfaced over I2C) to power the SoC
> and various other peripherals on the board [1].
> 
> Specifically, the audio codec (TLV320AIC3106) on the board relies on the
> PMIC for the DVDD (1.8V) supply.
> 
> [1]: https://www.ti.com/lit/zip/sprr459
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 03fce1752521..9bcfa9b50876 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -714,6 +714,7 @@ CONFIG_MFD_SEC_CORE=y
>  CONFIG_MFD_SL28CPLD=y
>  CONFIG_RZ_MTU3=y
>  CONFIG_MFD_TPS65219=y
> +CONFIG_MFD_TPS6594_I2C=m
>  CONFIG_MFD_TI_AM335X_TSCADC=m
>  CONFIG_MFD_ROHM_BD718XX=y
>  CONFIG_MFD_WCD934X=m
> 
