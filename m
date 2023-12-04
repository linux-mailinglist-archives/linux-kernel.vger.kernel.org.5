Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21280309D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbjLDKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjLDKjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:39:23 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D39585
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:39:29 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4AcJPj090455;
        Mon, 4 Dec 2023 04:38:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701686300;
        bh=Z3wGme8D81DQZ+o11OSsw27qizSPmniTceSQcNMNF/M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=GvzWB/bkoNM9GpYj7liwWpGMBrON1EfMaaKrMcG7YdE4FTUqNcwpOmV+bXVgyVv04
         CY/xPkjUb8D+apJTY4mOl8C78IzkYYCB+ZH9YWFGUfrN1L8Sf90U2TEZ20pSGn/TjI
         BnbiZGntcpAVswfOgk7mLzjBUoiWJ3ckrDt4B0U0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4AcJIG117077
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Dec 2023 04:38:19 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 04:38:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 04:38:19 -0600
Received: from [172.24.227.247] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4AcC23113578;
        Mon, 4 Dec 2023 04:38:13 -0600
Message-ID: <72148985-6ed3-85d3-1a67-56e6cb25ac6c@ti.com>
Date:   Mon, 4 Dec 2023 16:08:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: defconfig: Enable TI_ICSSG_PRUETH
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Peng Fan <peng.fan@nxp.com>, Udit Kumar <u-kumar1@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20231128084537.3946895-1-danishanwar@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231128084537.3946895-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 2:15 PM, MD Danish Anwar wrote:
> The Programmable Real-time Unit and Industrial Communication Subsystem
> Gigabit (PRU_ICSSG) is a low-latency microcontroller subsystem in the TI
> K3 SoCs such as AM654x, AM64x. This subsystem is provided for the use
> cases like implementation of custom peripheral interfaces, offloading of
> tasks from the other processor cores of the SoC, etc.
> 
> Currently AM654x-EVM uses ICSSG driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5ad2b841aafc..145ee4858c50 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -368,6 +368,7 @@ CONFIG_SNI_NETSEC=y
>  CONFIG_STMMAC_ETH=m
>  CONFIG_DWMAC_TEGRA=m
>  CONFIG_TI_K3_AM65_CPSW_NUSS=y
> +CONFIG_TI_ICSSG_PRUETH=m
>  CONFIG_QCOM_IPA=m
>  CONFIG_MESON_GXL_PHY=m
>  CONFIG_AQUANTIA_PHY=y

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
