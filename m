Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59A67AAA3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjIVH2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIVH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:28:08 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F2180;
        Fri, 22 Sep 2023 00:28:01 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M3QAW4014025;
        Fri, 22 Sep 2023 09:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=0bp+NRqfXUCXmXbjcCA67hlANJccbiq96hkutpc8qzk=; b=Uy
        BO7y8X7Ny0Oo3Hl4YFrV2KyCU0z/yR0RYevIRGRs2hwXLBgAb97CKGEjcJbynK1a
        yhowZJfMJzv/+YfEUnM0YlUzgs32UhfY1695rc510idhaEi+z3F20qZza9gWnY0x
        MvvRGzMHkr9zAeA/MJ6phwNY5G4FqVE+n4wyyh1PQuwdwcoEnOJT3qRJ7I4rw7KB
        YfIll2jUUQwfeBAVF0bRKqNNg4Q6GUestvkrfk3Phv+01NBTVaTJkBweC9l4cuKb
        VfNhAmGCbJDXMPzdGft07iRSTdRL9EaKX2Ay271KgSOyM1EHd/9BGZg5EDeygub8
        b4hjtGSXIlNNwY3vQTgw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t8tt7j2d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 09:27:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5187100051;
        Fri, 22 Sep 2023 09:27:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CC56F2105B2;
        Fri, 22 Sep 2023 09:27:44 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 09:27:44 +0200
Message-ID: <614e085b-3c71-a19b-c34b-610501c49aa1@foss.st.com>
Date:   Fri, 22 Sep 2023 09:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] Add SD-card support on STM32MP25
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
References: <20230904132212.157405-1-yann.gautier@foss.st.com>
Content-Language: en-US
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230904132212.157405-1-yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_05,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yann

On 9/4/23 15:22, Yann Gautier wrote:
> Add sdmmc1 node in SoC DT file, then the pins used on STM32MP257F-EV1
> board, and then the node in board file for SD-card support.
> 
> Yann Gautier (3):
>    arm64: dts: st: add sdmmc1 node in stm32mp251 SoC file
>    arm64: dts: st: add sdmmc1 pins for stm32mp25
>    arm64: dts: st: add SD-card support on STM32MP257F-EV1 board
> 
>   arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 54 +++++++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        | 13 +++++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 22 ++++++++
>   3 files changed, 89 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
