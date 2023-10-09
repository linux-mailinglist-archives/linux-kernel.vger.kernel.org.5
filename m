Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E8F7BDA9B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbjJIMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346349AbjJIMCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:02:40 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E6F94;
        Mon,  9 Oct 2023 05:02:38 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3997geT5019817;
        Mon, 9 Oct 2023 14:02:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=Ooh4/yFf2JrfwSnSbYFLoguRGY36sVafq2HkIA5SYLU=; b=AJ
        2z5BLPOcyLWbr1PZ/gTxyvfnaYiryLmKpeGdAx/avu12n162KReV1M+NCElLCssi
        LGCMcQNb0vkumr0vnFQwbaBRpIxUrhrP52PSMKVBJC2IGXkkYKsLHsHWMprHpDoW
        PkbtGQG4jujNBM7PvL5n+Jjb6hCo1BHr/7r0jMcZon/UK6qNDjaHecSIs7wr932H
        kW8LfByqRARtPG4BMAqBsmFGd2rSEPyXM1a4R1i+IC4M5mRODRcFIvYkWi0YsWGP
        IZ5KAKPW8dZUgkW0/58ywmdFlA9I3pQHBfnHHM48QwjyExmtUomOKew4UCtFbCmp
        cliaoWKvGQICaNMfW4Sg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhfdw1n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:02:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B85D610005E;
        Mon,  9 Oct 2023 14:02:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF5B5233C9B;
        Mon,  9 Oct 2023 14:02:11 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 14:02:10 +0200
Message-ID: <5bd1a669-9eab-717f-6f58-0ecb4587cf22@foss.st.com>
Date:   Mon, 9 Oct 2023 14:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/9] hwrng: stm32: support STM32MP13x platforms
Content-Language: en-US
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230921080301.253563-1-gatien.chevallier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230921080301.253563-1-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 9/21/23 10:02, Gatien Chevallier wrote:
> The STM32MP13x platforms have a RNG hardware block that supports
> customization, a conditional reset sequences that allows to
> recover from certain situations and a configuration locking
> mechanism.
> 
> This series adds support for the mentionned features. Note that
> the hardware RNG can and should be managed in the secure world
> for this platform, hence the rng not being default enabled on
> the STM32MP135F-DK board.
> 
> Changes in V2:
> 	- Use pm_ptr() and add __maybe_unused on PM API
> 	- Correct bug using WARN_ON
> 
> Changes in V3:
> 	- Squash of bindings patches
> 	- st,rng-lock-conf property declaration rework
> 	- Fix stm32_rng_pm_ops declaration in patch [5/9]
> 
> Gatien Chevallier (9):
>    dt-bindings: rng: introduce new compatible for STM32MP13x
>    hwrng: stm32 - use devm_platform_get_and_ioremap_resource() API
>    hwrng: stm32 - implement STM32MP13x support
>    hwrng: stm32 - implement error concealment
>    hwrng: stm32 - rework error handling in stm32_rng_read()
>    hwrng: stm32 - restrain RNG noise source clock
>    hwrng: stm32 - support RNG configuration locking mechanism
>    hwrng: stm32 - rework power management sequences
>    ARM: dts: stm32: add RNG node for STM32MP13x platforms
> 
>   .../devicetree/bindings/rng/st,stm32-rng.yaml |  20 +-
>   arch/arm/boot/dts/st/stm32mp131.dtsi          |   8 +
>   drivers/char/hw_random/stm32-rng.c            | 511 +++++++++++++++---
>   3 files changed, 455 insertions(+), 84 deletions(-)
> 

Patch[9] applied on stm32-next.

thanks
alex
