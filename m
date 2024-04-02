Return-Path: <linux-kernel+bounces-127440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60090894B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF1281352
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5092722615;
	Tue,  2 Apr 2024 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pz+r7Hw5"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9907219FF;
	Tue,  2 Apr 2024 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039127; cv=none; b=ib/1kZl0kSFv1hp97DMe5dqrJOn9y2UbG1z2952B+jAk2mXvq7yDzTuDjCxzhNqp7sZgdXk/pmvT62fjHN0W3M2/5aI1L7SNa6l+3I+x7fcGGTbNDmJ3LwdirL5Ez5A9xjuq8+kyYIUj+HzwE6ki7sVEG4uQUrr/I2KPQVa0qSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039127; c=relaxed/simple;
	bh=96qLk1IhGOrnWXSm+XMrq7Jopu+34/nlrkSl2dbSQTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IlxTL5hCbrLtxnMH/iNv9SeC419V+xQ/QnWxxzGlILZ8owGy9F3D6gUH1IVAM5of7mH2iH2AFD87Ab27PS1FUiqa+f2dHcLpIDQJ84qXOuksxQyWpn4aUcgGTP8uxMREXmyWAiOBrSDwOi26CphegjhsiEAhtg5V7KGa5lk6NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pz+r7Hw5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4322mnmp029837;
	Tue, 2 Apr 2024 08:24:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=zvO9fT/3hnruxI2Qb+TcMhuCOsE3oJ9aHpPaLeaL1p4=; b=pz
	+r7Hw5/o9A561LptCu9IMRsqSF9k/YcJLYGgmvjHWz5XsGzcD80zy7UOtDAH2XAH
	BiULVaaqiNVeQSXsUoZx+1bX2cReN2C42TaeVqBAtOHoFkvmBdoBjKbYaM6ZbKHB
	7QeQ5nCW7SHzNleUIHmXgL/xqmPTW3NRgQUIwchhgVgD7KKICAqYNDUkJ2B4fFLk
	UH46I8r4QUfLk+Q/m2MjeH2tLhAsNUWVg4VuSaPvQapRJBj0OOWUd1vGzb7Q8nBN
	KyDIS0zW0uQ9XmE7o6cNm701135ezPO4n5ua/wmi8F8usC2WKavQlvMv0vQlnW+E
	csDo1V1sNWA/NUlplsPQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x6wsu78b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 08:24:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 526374002D;
	Tue,  2 Apr 2024 08:24:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5759520F2C5;
	Tue,  2 Apr 2024 08:23:25 +0200 (CEST)
Received: from [10.201.21.128] (10.201.21.128) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 2 Apr
 2024 08:23:24 +0200
Message-ID: <5805e6e7-76a4-4a0f-abd0-823aed023daf@foss.st.com>
Date: Tue, 2 Apr 2024 08:23:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] dt-bindings: net: dwmac: Document STM32 property
 st,ext-phyclk
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240328140803.324141-1-christophe.roullier@foss.st.com>
 <20240328140803.324141-2-christophe.roullier@foss.st.com>
 <46b065d1-82d7-4a15-9de2-1e0bdd2a9085@linaro.org>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <46b065d1-82d7-4a15-9de2-1e0bdd2a9085@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_02,2024-04-01_01,2023-05-22_02


On 3/30/24 19:40, Krzysztof Kozlowski wrote:
> On 28/03/2024 15:08, Christophe Roullier wrote:
>> The Linux kernel dwmac-stm32 driver currently supports three DT
>> properties used to configure whether PHY clock are generated by
>> the MAC or supplied to the MAC from the PHY.
>>
>> Originally there were two properties, st,eth-clk-sel and
>> st,eth-ref-clk-sel, each used to configure MAC clocking in
>> different bus mode and for different MAC clock frequency.
>> Since it is possible to determine the MAC 'eth-ck' clock
>> frequency from the clock subsystem and PHY bus mode from
>> the 'phy-mode' property, two disparate DT properties are
>> no longer required to configure MAC clocking.
>>
>> Linux kernel commit 1bb694e20839 ("net: ethernet: stmmac: simplify phy modes management for stm32")
>> introduced a third, unified, property st,ext-phyclk. This property
>> covers both use cases of st,eth-clk-sel and st,eth-ref-clk-sel DT
>> properties, as well as a new use case for 25 MHz clock generated
>> by the MAC.
>>
>> The third property st,ext-phyclk is so far undocumented,
>> document it.
>>
>> Below table summarizes the clock requirement and clock sources for
>> supported PHY interface modes.
>>   __________________________________________________________________________
>> |PHY_MODE | Normal | PHY wo crystal|   PHY wo crystal   |No 125Mhz from PHY|
>> |         |        |      25MHz    |        50MHz       |                  |
>>
>> ---------------------------------------------------------------------------
>> |  MII    |    -   |     eth-ck    |        n/a         |       n/a        |
>> |         |        | st,ext-phyclk |                    |                  |
>>
>> ---------------------------------------------------------------------------
>> |  GMII   |    -   |     eth-ck    |        n/a         |       n/a        |
>> |         |        | st,ext-phyclk |                    |                  |
>>
>> ---------------------------------------------------------------------------
>> | RGMII   |    -   |     eth-ck    |        n/a         |      eth-ck      |
>> |         |        | st,ext-phyclk |                    | st,eth-clk-sel or|
>> |         |        |               |                    | st,ext-phyclk    |
>>
>> ---------------------------------------------------------------------------
>> | RMII    |    -   |     eth-ck    |      eth-ck        |       n/a        |
>> |         |        | st,ext-phyclk | st,eth-ref-clk-sel |                  |
>> |         |        |               | or st,ext-phyclk   |                  |
>>
>> ---------------------------------------------------------------------------
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Can you please start testing patches *before* sending them?
Yes sorry, when I removed patch with phy-supply property (1/2), I had 
conflict merge and I did not pay attention that my commit was modified :-(
>
> Best regards,
> Krzysztof
>

