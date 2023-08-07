Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349AF772370
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjHGMJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjHGMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:09:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D195;
        Mon,  7 Aug 2023 05:09:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377C8TbD123376;
        Mon, 7 Aug 2023 07:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691410109;
        bh=HPfzbM7oNbyfW57kvap8c6blYiDjkmk5BN0fvHXFECw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=A5dm5TyfpNcSaFYrmeYYukWDkWE0w/hNz5mjBcZSjy2pCExIRdfYVGEPFKBbDpUCa
         mYEZUCfJG/LQLqa9AH65PX5Grj4vWGwyd46B/wYbuzdFKcWjS45BuzyjPmcd8GtQ1D
         dZYlYHh0ykPW0SejiLUIMFlJaJhbg8MD/JCAyIyg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377C8Tsb110254
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 07:08:29 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 07:08:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 07:08:28 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377C8SYt095933;
        Mon, 7 Aug 2023 07:08:28 -0500
Date:   Mon, 7 Aug 2023 07:08:28 -0500
From:   Nishanth Menon <nm@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>
CC:     <vigneshr@ti.com>, Peng Fan <peng.fan@nxp.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: defconfig: Enable PRUSS as module
Message-ID: <20230807120828.voznckdnhvnyzqnf@accurate>
References: <20230807105919.2611138-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230807105919.2611138-1-danishanwar@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:29-20230807, MD Danish Anwar wrote:
> Enables PRUSS as kernel module for TI SoCs.


You still have'nt addressed the review feedback from v1. what is
PRUSS? What boards are using it?

> 
> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index bf13d5c46578..0aecdf43a5d1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1339,6 +1339,7 @@ CONFIG_ARCH_TEGRA_186_SOC=y
>  CONFIG_ARCH_TEGRA_194_SOC=y
>  CONFIG_ARCH_TEGRA_234_SOC=y
>  CONFIG_TI_SCI_PM_DOMAINS=y
> +CONFIG_TI_PRUSS=m
>  CONFIG_ARM_IMX_BUS_DEVFREQ=y
>  CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
>  CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
