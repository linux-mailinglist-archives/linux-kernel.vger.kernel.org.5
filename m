Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A381363C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443502AbjLNQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjLNQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:29:14 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4327121;
        Thu, 14 Dec 2023 08:29:20 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BEFk9WK028436;
        Thu, 14 Dec 2023 17:28:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=pAFj17HSIvNG/OLKmPGmMGVsrYHbgRXqCu1eFIvc9PU=; b=3b
        yN0jhljL5JhheeeJFR9IjZaIjEXxOFX95NxnHVUx8D74jxLUIXAhLS3RZv9N1iGJ
        aFUBSWUW2hynJ0Iop4ChAApJWNAzQ+a0ulntP0/B/TY7v5lROyq4bB3vvhGuKtIV
        hgohmF39qCD13T1JBQMJGNyQM0TCkSDuEPwwG6o1IBfMKfjwwHygulWibAwBCreI
        gPVVXE6JpjV8YsrknCC/Hy9KfuK2x3qap/e97pPSBTCFr/fCiZfbFUpmUJ9B2XQF
        FiJAMJzTb/L+4URlOX2AaJ9hPTOWAq7xzlmg0rjoSLu47PyukjBDQxT4utifTZYX
        BZb9fYSttgY12Uftr4+g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmpevx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 17:28:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10B76100053;
        Thu, 14 Dec 2023 17:28:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EEA6A2747B2;
        Thu, 14 Dec 2023 17:28:42 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Dec
 2023 17:28:41 +0100
Message-ID: <0145e75a-0d4c-4e34-a247-7852796f0552@foss.st.com>
Date:   Thu, 14 Dec 2023 17:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] stm32: add support for STM32MP25 BSEC to control OTP
 data
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Peng Fan <peng.fan@nxp.com>,
        Udit Kumar <u-kumar1@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20231117143338.1173475-1-patrick.delaunay@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20231117143338.1173475-1-patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_11,2023-12-14_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 11/17/23 15:33, Patrick Delaunay wrote:
> 
> Non volatile memory area is available on STM32MP25 with OTP in BSEC.
> 
> The 12 Kbits of OTP (effective) for STM32MP25x SoC Family
> are organized into the following regions:
> - lower OTP (OTP0 to OTP127) = 4096 lower OTP bits,
>    bitwise (1-bit) programmable
> - mid OTP (OTP128 to OTP255) = 4096 middle OTP bits,
>    bulk (32-bit) programmable
> - upper OTP (OTP256 to OTP383) = 4096 upper OTP bits,
>    bulk (32-bit) programmable,
>    only accessible when BSEC is in closed state.
> 
> BSEC is only accessible by secure world, so the OTP access is done
> by driver with OP-TEE TA, as on STM32MP13x family.
> 
> 
> 
> Patrick Delaunay (4):
>    dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem
>    nvmem: stm32: add support for STM32MP25 BSEC to control OTP data
>    arm64: defconfig: enable NVMEM STM32 ROMEM for stm32mp25
>    nvmem: add bsec support to stm32mp25
> 
>   .../bindings/nvmem/st,stm32-romem.yaml           |  1 +
>   arch/arm64/boot/dts/st/stm32mp251.dtsi           | 16 ++++++++++++++++
>   arch/arm64/configs/defconfig                     |  1 +
>   drivers/nvmem/stm32-romem.c                      | 16 ++++++++++++++++
>   4 files changed, 34 insertions(+)
> 


patch[4] (DT) applied on stm32-next.

thanks
Alex
