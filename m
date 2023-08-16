Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8077DB38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbjHPHgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbjHPHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:36:21 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B710C8;
        Wed, 16 Aug 2023 00:36:19 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G3mWI2002776;
        Wed, 16 Aug 2023 09:36:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=/U0DPhfgxKLwSl5AGYdxKKmhtbKYxf8AYN+Ii1NUbKQ=; b=1j
        7WQhSmCySTbCXDklb0Z1lt7tr0DhGOsBsJELXg6s4WW2/dh3JF9iVPTyZ44rhWHq
        oXxJLtzF1AhO5NIxNerXhA4/fciSLuqGAYwb3E/uws2ZOfsvoqWMI4lzzNbNMte1
        Ub0IFKfqF9vM+AS8XLEiGsdyQg8WPdGGamnZAlbC9dePIofoQV7dMbnrkhq97F3m
        NWdWudhND9uWBFYuc5bUB9pZVQpz+6C9qCp2S5usKw/lR4zoRY7nJfhG4LmrrVkp
        HB+731OZuaHQfumbP9mPdD2fiZOy7KfcY/PY5FG+vuxDVolKxVQ+U6sn1EYD/SII
        ykgfs1l/8Lk7smUq/3hA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgpvgs02q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:36:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 505C410005D;
        Wed, 16 Aug 2023 09:36:04 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 417E02194D1;
        Wed, 16 Aug 2023 09:36:04 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 09:36:03 +0200
Message-ID: <8a23e34b-4feb-f294-7b64-31ce78efbed0@foss.st.com>
Date:   Wed, 16 Aug 2023 09:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 0/4] Add display support on the stm32f746-disco board
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     Philippe Cornu <philippe.cornu@foss.st.com>,
        <michael@amarulasolutions.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_05,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

On 8/14/23 15:28, Dario Binacchi wrote:
> The series adds support for the display on the stm32f746-disco board.
> 
> Changes in v8:
> - Add the patch [3/4] "ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f746-disco" to
>    th series.
> - Add the 'power-supply' property to panel-rgb node.
> - Move backlight and panel-rgb nodes after the vcc-3v3 node.
> 
> Changes in v7:
> - Add 'Reviewed-by' tags I forgot in v6.
>    https://lore.kernel.org/linux-arm-kernel/20230629083726.84910-1-dario.binacchi@amarulasolutions.com/T/
> 
> Changes in v6:
> - Remove dma nodes from stm32f746-disco.dts, they are not used by LTDC,
>    so there is no need to enable them.
> 
> Changes in v5:
> I am confident that framebuffer sizing is a real requirement for STM32 boards,
> but I need some time to understand if and how to introduce this functionality.
> Therefore, I drop the following patches to allow the series to be fully merged:
>   - [4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
>   - [5/6] ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
>   - [6/6] drm/stm: set framebuffer bit depth through DTS property
> 
> Changes in v4:
> - Use DTS property instead of module parameter to set the framebuffer bit depth.
> 
> Changes in v3:
> - rename ltdc-pins-a-0 to ltdc-0.
> - drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
>    Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
>    https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
> - drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
>    Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
>    https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc
> 
> Dario Binacchi (4):
>    ARM: dts: stm32: add ltdc support on stm32f746 MCU
>    ARM: dts: stm32: add pin map for LTDC on stm32f7
>    ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f746-disco
>    ARM: dts: stm32: support display on stm32f746-disco board
> 
>   arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++
>   arch/arm/boot/dts/st/stm32f746-disco.dts  | 50 +++++++++++++++++++++--
>   arch/arm/boot/dts/st/stm32f746.dtsi       | 10 +++++
>   3 files changed, 92 insertions(+), 3 deletions(-)
> 

Series applied on stm32-next.

Thanks!!
Alex
