Return-Path: <linux-kernel+bounces-140165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3368A0C46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD368287209
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E849145327;
	Thu, 11 Apr 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f8ghDbR0"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0194143868;
	Thu, 11 Apr 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827557; cv=none; b=bAu9/Xxd/rYEX54+uQbkFK8WMq6PSBlSrxGX2xU8sj6MXqyNn+jiBzODmFVqMvu0Vz47eX/fhlIdEfvs4XwkKjYyWB6Q0HPUkR3MGXqMkArYRmEGI8ulESPyl8ak2jcXZf3qcyxdcAi2JQ9nG6BnU1fuXFD/wl1S0zn/eMyBFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827557; c=relaxed/simple;
	bh=lpH3Pg5opeW9yilRG6jpjNBucP0rgbthlWRy8sbS36Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jBqTC7Xi7aQ4wITVHFoEKl54sjA679uZbMbZ5qDxDInm0NxAXODmI4cowLtcSgJ9wyVMvBB1EHKJcPfe8WYNu9Ar06Ho4m8ivpoyz/Hu1hOILskeBzRvLHmIf088KUmfB2gb68UMYkgQnDwPYY3PcWh1mqfwvj/CdVXGkVUmxf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f8ghDbR0; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B75YPm009700;
	Thu, 11 Apr 2024 11:25:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=TUGotz/RGgZ0ogm1f0DO+fTxmgoJm/qfo/BcIhv3uTA=; b=f8
	ghDbR00PE6qnZfX0dzmLDa7aMYJHZCxeKnpfIS/E/GjB90q2uq31BhSLuLzSfcAL
	T+wITslxuyv4F3TwfqeYGFxDT3NPsR488v8hVxQnjdwCXABdGAydkHYrZ1Tt7pEg
	7ccUetfAO5+EJekbPXAcwMvwvk3BGTt36RagOYF+MKAArAqAXjgzeNVbBLQk+hhP
	1vuOXNoE5sIae3bIiPo4yY2ILRtwzXqW1hCab2WmzwKwVYT/V5UvVuHd9Co9VGxS
	/iSlKJXlVCEtv158UnCzN87kcRcnTurL9TJPgU9rSoCz8fvWPJJQZv4NXlVqY5Vz
	lNCOxiIxeMrg4ZMiPy2g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xaw9d41f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:25:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 645624002D;
	Thu, 11 Apr 2024 11:25:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 71AE1212FB5;
	Thu, 11 Apr 2024 11:24:23 +0200 (CEST)
Received: from [10.48.86.110] (10.48.86.110) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 11:24:22 +0200
Message-ID: <9eda526d-a38c-4680-9886-114cddf34f00@foss.st.com>
Date: Thu, 11 Apr 2024 11:24:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/4] clk: stm32: introduce clocks for STM32MP257
 platform
To: Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240409171241.274600-1-gabriel.fernandez@foss.st.com>
 <20240409171241.274600-4-gabriel.fernandez@foss.st.com>
 <7498985788263268d4acfcd1589a5994.sboyd@kernel.org>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <7498985788263268d4acfcd1589a5994.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_03,2024-04-09_01,2023-05-22_02


On 4/11/24 08:36, Stephen Boyd wrote:
> Quoting gabriel.fernandez@foss.st.com (2024-04-09 10:12:40)
>> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-stm32mp25.c
>> new file mode 100644
>> index 000000000000..23876e7d9863
>> --- /dev/null
>> +++ b/drivers/clk/stm32/clk-stm32mp25.c
>> @@ -0,0 +1,1876 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
>> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>> + */
>> +
>> +#include <linux/clk.h>
> Use clk-provider.h not clk.h
ok
>
>> +#include <linux/of_address.h>
> Doubt this is the right include. Drop?

yes i will drop


>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-stm32-core.h"
>> +#include "reset-stm32.h"
>> +#include "stm32mp25_rcc.h"
>> +
>> +#include <dt-bindings/clock/st,stm32mp25-rcc.h>
> [...]
>> +       .clock_data     = &stm32mp25_clock_data,
>> +       .reset_data     = &stm32mp25_reset_data,
>> +};
>> +
>> +static const struct of_device_id stm32mp25_match_data[] = {
>> +       { .compatible = "st,stm32mp25-rcc", .data = &stm32mp25_data, },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
>> +
>> +static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       void __iomem *base;
>> +
>> +       base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (WARN_ON(IS_ERR(base)))
> Drop WARN_ON

ok

Thank's

Best Regards

Gabriel


>> +               return PTR_ERR(base);

