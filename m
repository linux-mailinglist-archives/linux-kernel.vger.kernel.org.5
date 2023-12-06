Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62D807305
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442211AbjLFOuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442128AbjLFOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:50:20 -0500
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A4D4B;
        Wed,  6 Dec 2023 06:50:25 -0800 (PST)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3B6D9YF5029854;
        Wed, 6 Dec 2023 15:50:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=PCez8zo5/G+mlbJxk86sZFdZWbd334WWlRXxYxZXHeI=; b=Hc
        JU5hsBpjx31tZsvFIzlwKkuqy4dGkNB/QWcVR5s5eywJ3ZcKTup720Gmjstj5XPn
        ZbJbKZWaWAYmQxT0oCGAp5CqeJ3b01rpUYWHTh7CvHmcYFtaeeQ7L0nixpEcLUSd
        vRV3XWetyAW55GQx6z3Eky+njGgceDrF1H9fZlhC9qKk+X1dKywvASxnGKn8vc89
        g713ye3zoFzaj/WsQMacvU+cQNbx30xpMki4Vfvl4lye0Sb+g924RO9CqQc1mBGz
        Q8nuO57cFQPq2yrdPChLoL+CsKAjb4ZNkutPS9sb5cgHqamj93uMl2mGB8v2CD7v
        owLPfHPcT0KCVAYhyLEA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3utd2jkh9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 15:50:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11DC3100053;
        Wed,  6 Dec 2023 15:50:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 09DBA23C6A4;
        Wed,  6 Dec 2023 15:50:07 +0100 (CET)
Received: from [10.201.21.240] (10.201.21.240) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Dec
 2023 15:50:06 +0100
Message-ID: <fe5cf8bf-fa80-400c-b2e0-969b5ed68c8b@foss.st.com>
Date:   Wed, 6 Dec 2023 15:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] clk: stm32: introduce clocks for STM32MP257
 platform
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231206140029.492906-1-gabriel.fernandez@foss.st.com>
 <20231206140029.492906-5-gabriel.fernandez@foss.st.com>
 <ec1912eab8bead59f520c48b6d73a084fd07732d.camel@pengutronix.de>
Content-Language: en-US
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <ec1912eab8bead59f520c48b6d73a084fd07732d.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.240]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_12,2023-12-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp, thank's for reviewing.

On 12/6/23 15:20, Philipp Zabel wrote:
> Hi Gabriel,
>
> On Mi, 2023-12-06 at 15:00 +0100, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> This driver is intended for the STM32MP25 clock family and utilizes
>> the stm32-core API, similar to the stm32mp13 clock driver.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
> [...]
>> diff --git a/drivers/clk/stm32/stm32mp25_rcc.h b/drivers/clk/stm32/stm32mp25_rcc.h
>> new file mode 100644
>> index 000000000000..b1aca78a0b22
>> --- /dev/null
>> +++ b/drivers/clk/stm32/stm32mp25_rcc.h
>> @@ -0,0 +1,4977 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
>> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>> + */
>> +
>> +#ifndef STM32MP25_RCC_H
>> +#define STM32MP25_RCC_H
>> +
>> +#define RCC_SECCFGR0				0x0
> [...]
>
> What is the purpose of all the unused #defines?
>
> I initially wanted to point out that the _SHIFT #defines are redundant
> because the same information is already contained in the corresponding
> _MASK #defines, but it seems like neither of the register field
> definitions are used anywhere. It appears only some of the *CFGR
> register offset #defines are actually used.

It's a generated file that is also used for other components,

but it's not a big deal to remove the unused defines in the Kernel.

I'm waiting for other remarks before sending a V6

Best regards

Gabriel

> regards
> Philipp
