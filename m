Return-Path: <linux-kernel+bounces-119198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843F88C575
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694CA1C32ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343CD763E6;
	Tue, 26 Mar 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="N7QBY2ec"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B813C3E8;
	Tue, 26 Mar 2024 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464168; cv=none; b=f00aFacUguG0IicA+HeThz/Co8u3qPdl9FxPF2/ZNvmAEr3oqy21ZwdoXnkz+zBkU1MIzWTKiJ+8qVz6ClYUeX2ar8sAgGzVAkTkhhNFDoyrjIYUiTbdwYjwLFUTrWvSoROn4BvwZfhIiikkpQLu7E47yDj0ydDKT7Da+CfMmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464168; c=relaxed/simple;
	bh=+KV3AdzDzpYqpS+EbXnPmHttAO5r/1XNhRRlBBa+ycs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TR3HaRpp87LtYxMGwsKaZ07YiX7W3RRZMmnLEBYbUTmuFDglIJqCCj8mN+GTb0KYRaAWn1AOfVtb0lQXPDCKh/fuf01M3/vEDoBl1/ED95Muh6mn/Kv/LimRhWoThznHCOPxnxUUGnuERUOEeMKPagrH8esDtAJIdC7VlhBWAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=N7QBY2ec; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QCBklK007694;
	Tue, 26 Mar 2024 15:42:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=9pRVmSnmGKK7LB7PnddfDWHBQ6XSXKYj11IRLNtwqSQ=; b=N7
	QBY2ec7CNT8qV5bVJxFwCDKNtHCHQLL1A2stjMn/y2a4mdDZEu0nBAlJV+jMjui2
	LYszZwLbZByRXeHRFaejhU3MjTETCjwfNjUV4Njk6S49C7OFaHuZE0vstFESInfg
	aFKxKYfkE0yQr0qm0EIQkqonrNGxlKa7j1DR0xai5h+k1qWGd0XjS0ljqbziXDH9
	IXA0/FVPB/FuzD1YgnAEdDcCXk82T1afpRWlcIyoxY10xDZz/x3b7U5N05QolwH1
	E5JdYkwfgD8f4fw3SFTHtD1z/PVr8jNDN3aCM2bf/IcLIN9I+tesoV12ZYhQlA0L
	lxrGKJQnhPk5G8mFWXdw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x29h5ueb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 15:42:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 119E840044;
	Tue, 26 Mar 2024 15:42:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5347A220B61;
	Tue, 26 Mar 2024 15:41:15 +0100 (CET)
Received: from [10.201.21.128] (10.201.21.128) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Mar
 2024 15:41:13 +0100
Message-ID: <a19b20ae-d12a-47c8-9d1f-482a84924e6c@foss.st.com>
Date: Tue, 26 Mar 2024 15:41:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: net: add phy-supply property for
 stm32
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240326125849.226765-1-christophe.roullier@foss.st.com>
 <20240326125849.226765-2-christophe.roullier@foss.st.com>
 <0e14ad5d-3c25-40ab-981a-fbc4e245fc94@lunn.ch>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <0e14ad5d-3c25-40ab-981a-fbc4e245fc94@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02


On 3/26/24 14:58, Andrew Lunn wrote:
> On Tue, Mar 26, 2024 at 01:58:48PM +0100, Christophe Roullier wrote:
>> Phandle to a regulator that provides power to the PHY. This
>> regulator will be managed during the PHY power on/off sequence.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> index fc8c96b08d7dc..80937b28fa046 100644
>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> @@ -82,6 +82,9 @@ properties:
>>         Should be phandle/offset pair. The phandle to the syscon node which
>>         encompases the glue register, and the offset of the control register
>>   
>> +  phy-supply:
>> +    description: PHY regulator
> ~/linux/drivers/net/ethernet/stmicro/stmmac$ grep regulator_get *
> dwmac-rk.c:	bsp_priv->regulator = devm_regulator_get(dev, "phy");
> dwmac-sun8i.c:	gmac->regulator = devm_regulator_get_optional(dev, "phy");
> dwmac-sunxi.c:	gmac->regulator = devm_regulator_get_optional(dev, "phy");
>
> Maybe i'm missing something, but i don't see an actual implementation
> of this binding?
>
> 	Andrew

Hi Andrew,

You are right, my next step is to upstream support of Ethernet MP13 glue 
and some update like Phy regulator support

(it is look like 
https://lore.kernel.org/linux-arm-kernel/20230928122427.313271-9-christophe.roullier@foss.st.com/)

Regards,

Christophe


