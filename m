Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2278C76325E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjGZJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjGZJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:35:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD144BB;
        Wed, 26 Jul 2023 02:33:48 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q7mprC023350;
        Wed, 26 Jul 2023 11:33:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=/Cq+mWzaYAzM3dk654+FXTT9IrqSv23zfpbnKE8bKxM=;
 b=Q3i1gVoUyXsOG+9S8AzF+qC7KGYRPJp1BCc8yu19RqFYSEYXR+81aMgiqDR45yEeyPqO
 J+U3uov9ofSS5wPMhYZ9+4/I7yoG4y4+8katCpM+tSm+G4l/cyvw4mN5swVzqt2fYz1S
 bfKZRzHV8x7Kom11ShfbZ53EZcJIdyyJN+AiP8cxN5/mICmfx+rToX+nVgHVP8/cnFWf
 epKhxqQqSlw0L+nHtRZGH+rh+T1QQLgWgFQA+vVJ65W56Qod/6jQdjeSkvBm9SME4WcU
 E4hHx370z65KeipWwjPTCZPdxiSvq2f8S2ouOVDcvTyBIP2Gg5qihokSU89pm2KM33oL pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s2ye8gv6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 11:33:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A74DF10002A;
        Wed, 26 Jul 2023 11:33:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90F66212FCB;
        Wed, 26 Jul 2023 11:33:17 +0200 (CEST)
Received: from [10.48.1.0] (10.48.1.0) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 26 Jul
 2023 11:33:16 +0200
Message-ID: <a442c999-4120-c945-c671-d5fe2c21522c@foss.st.com>
Date:   Wed, 26 Jul 2023 11:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] ARM: multi_v7_defconfig: Add SCMI regulator support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <p.paillet@foss.st.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
 <20230712142432.1885162-5-p.paillet@foss.st.com>
 <aa05bcd6-140d-d951-2c7f-c09abf7f49f7@linaro.org>
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <aa05bcd6-140d-d951-2c7f-c09abf7f49f7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.1.0]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_03,2023-07-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/12/23 21:25, Krzysztof Kozlowski wrote:
> On 12/07/2023 16:24, p.paillet@foss.st.com wrote:
>> From: Pascal Paillet <p.paillet@foss.st.com>
>>
>> Enable ARM SCMI regulator support.
>>
> This we see from the diff. Please explain why, e.g. which boards use it.
>
> Best regards,
> Krzysztof


The STM32MP platforms rely on OP-TEE to boot: Clocks and regulators are 
handled in
the secure world by OP-TEE and exported to the non secure world (LINUX)
thanks to ARM SCMI protocol.

Today it is used in the ARMv7 STMicrolectronics stm32mp boards:
- for STM32MP13: stm32mp135f-dk
- the STM32MP15 boards with SCMI variant, introduced by commit 5b7e58313a77
   ("ARM: dts: stm32: Add SCMI version of STM32 boards (DK1/DK2/ED1/EV1)")
   * stm32mp157c-ev1-scmi
   * stm32mp157c-ed1-scmi
   * stm32mp157c-dk2-scmi
   * stm32mp157a-dk1-scmi

This SCMI server provide access to "secured" resources protected in SoC
(for example with RCC_SECFGR); the resources need to be available early
for these board and the  SCMI server is associated with OP-TEE, already
activated by the commit 24c159793238  ("ARM: multi_v7_defconfig: Add
OPTEE support").

Regards

Patrick

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
