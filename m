Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B47BDB34
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376292AbjJIMQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbjJIMPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:15:19 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741D1FC8;
        Mon,  9 Oct 2023 05:13:24 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3997rFWx025374;
        Mon, 9 Oct 2023 14:13:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=Js7aNeSM/SCYmsb14dgCNvgdxI7cquNA2ZnKLbNhFyE=; b=Nj
        v3Izd41BIlnR9vOrf1uVhFLA8s3JCkVpAi3cohJSSOAy9XJ5VJZaSMjT/nxUavT6
        eOCCl6Q6zpoXEb3NCPaWbeF4sRyRi9tGM3siErqlqODkKyr4IximXf0E/1e90Y/o
        KUS2D4mKzUx/E5MuQc3bUEN4mcJAjqK0pKHPPXJV9ddgVSRrFaHoVGXwug3k30hS
        LKh6A6sHn47ofgUeW5FDvSixAMoSOdA5xtKhIOjOCM/5g9v23YC6FvcuECq3j5V0
        nYA5Jy/41k4TTDSsVIbU4cQhPLmig7/13trQEJ8YeVKZY/4YTFMy7U88lL8wQHuX
        mGYblL7//oPyns1L0rHQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhk3d1np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:13:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1862710005E;
        Mon,  9 Oct 2023 14:13:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EE2F2171DF;
        Mon,  9 Oct 2023 14:13:08 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 14:13:07 +0200
Message-ID: <be5521e7-5093-e8c2-9a9b-ebd09cb11386@foss.st.com>
Date:   Mon, 9 Oct 2023 14:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] ARM: dts: stm32: add SDIO pinctrl sleep support on
 stm32f7
Content-Language: en-US
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <20231002171339.1594470-1-ben.wolsieffer@hefring.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20231002171339.1594470-1-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben

On 10/2/23 19:13, Ben Wolsieffer wrote:
> Add support for switching the SDIO pins on the STM32F7 series to analog
> mode when not in use to save power.
> 
> I don't have any of the disco/eval boards to test, but I have tested
> this on an Emcraft STM32F746 SOM with a UCL-SOM-BSB carrier (using an
> out-of-tree DT) and our custom carrier board.
> 
> Ben Wolsieffer (2):
>    ARM: dts: stm32: add stm32f7 SDIO sleep pins
>    ARM: dts: stm32: add SDIO pinctrl sleep support on stm32f7 boards
> 
>   arch/arm/boot/dts/st/stm32746g-eval.dts   |  3 ++-
>   arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 22 ++++++++++++++++++++++
>   arch/arm/boot/dts/st/stm32f746-disco.dts  |  3 ++-
>   arch/arm/boot/dts/st/stm32f769-disco.dts  |  3 ++-
>   4 files changed, 28 insertions(+), 3 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex
