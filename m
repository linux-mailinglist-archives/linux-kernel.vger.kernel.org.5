Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410B477E09E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbjHPLjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244703AbjHPLjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:39:45 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CF4138;
        Wed, 16 Aug 2023 04:39:41 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G8qjjf002232;
        Wed, 16 Aug 2023 13:39:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=a8L54AqLoW+YCVf5muWdGfhIDNv/gOLzOo4eeextb24=; b=wT
        sLsklvobkJHK4RDIIDi6CiH/ENfG3+EN25t25S77kRYign479HodC8eXywKBES7Q
        0dN/h3NwCc1z6d6DRWBXVLe9YOmNnmAKfpYE81/58s2fV/03+K7wnlP5kAdbbPmv
        EGuedlynJi69hHWc3hcgTbgYy+7yfOHTXE3YqnA+GLf2qZv3fUI1VuKV+1rOWNQJ
        ljsHcjSyf1YPDxtMdgIB0GluU1c5iXD3OIzABKdylWkqCXVBQ9MDrla+kCWWzmHe
        9nBdmGlWbSLgeSEIlAgGb5MAd0TYwZEciEcu3HGDPfcdVayltHPvn3u+f059hHBZ
        az2q+V1rEejY6dn8kGnA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgth61d4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 13:39:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D68E9100064;
        Wed, 16 Aug 2023 13:39:09 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CB7F22309FB;
        Wed, 16 Aug 2023 13:39:09 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 13:39:08 +0200
Message-ID: <e0e35593-bccc-4959-1de6-07062849ccf5@foss.st.com>
Date:   Wed, 16 Aug 2023 13:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] STM32MP13x expose SCMI regulators
Content-Language: en-US
To:     <p.paillet@foss.st.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Etienne Carriere <etienne.carriere@foss.st.com>
References: <20230712142432.1885162-1-p.paillet@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230712142432.1885162-1-p.paillet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_10,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pascal

On 7/12/23 16:24, p.paillet@foss.st.com wrote:
> From: Pascal Paillet <p.paillet@foss.st.com>
> 
> Updates STM32MP13 DTS files to define the voltage regulators
> exposed by OP-TEE SCMI service and remove the fixed regulator
> abstraction previously used.
> 
> Etienne Carriere (3):
>    dt-bindings: rcc: stm32: add STM32MP13 SCMI regulators IDs
>    ARM: dts: stm32: STM32MP13x SoC exposes SCMI regulators
>    ARM: dts: stm32: add SCMI PMIC regulators on stm32mp135f-dk board
> 
> Pascal Paillet (1):
>    ARM: multi_v7_defconfig: Add SCMI regulator support
> 
>   arch/arm/boot/dts/st/stm32mp131.dtsi          | 50 +++++++-------
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts       | 68 ++++++++-----------
>   arch/arm/configs/multi_v7_defconfig           |  1 +
>   .../regulator/st,stm32mp13-regulator.h        | 42 ++++++++++++
>   4 files changed, 98 insertions(+), 63 deletions(-)
>   create mode 100644 include/dt-bindings/regulator/st,stm32mp13-regulator.h
> 

Series applied on stm32-next. Commit title of patch[4] has been updated 
to explain the reason of the patch (as suggested by Krzysztof). I also 
ordered the config flag.

Regards
Alex
