Return-Path: <linux-kernel+bounces-24669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B682C027
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C9B22BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790C6BB22;
	Fri, 12 Jan 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IUMXcYgw"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12459B4E;
	Fri, 12 Jan 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C8bGwb014393;
	Fri, 12 Jan 2024 13:54:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=808zVNRDpa6s3QKZxLyhTp9fJbRkhQELOG0gvuy32Us=; b=IU
	MXcYgwMO+p5NrXCwDBuYZrOXi4mGDjB+GMp1LL6ckjrgByt2+srDwii3BYOMkVVa
	Y5y7MI6XyzrK0ANnjWcrby+ph7GXHEOShQOVp3rgAe5mH+ctgDjggS/JZut9wcNq
	2THRefc8DHwg+BA4nE0+OBohebduXpGVekcdRdJtsL6uDyGro+pjSSaDQFCsw70x
	eHzGrigmiBu0DsS/QKtoMkGYmncDG0l1GXSS9eCL8htAkw5q/ZCF21XfjdShxtg/
	+8dk/HFrpkz2hsj1wNsZxzwY2sttGycPmD0P5IuK34IacVJJ8/GAG7hkDTTLzhKj
	a2kL30oi1+CKsSL6Px4Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vk22u92v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 13:54:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4879F10002A;
	Fri, 12 Jan 2024 13:54:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3C38421230C;
	Fri, 12 Jan 2024 13:54:57 +0100 (CET)
Received: from [10.129.178.37] (10.129.178.37) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Jan
 2024 13:54:54 +0100
Message-ID: <f255cb6a-44bc-4ee4-9a92-4301d43d2967@foss.st.com>
Date: Fri, 12 Jan 2024 13:54:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] dt-bindings: mfd: stm32f7: Add binding definition
 for DSI
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-amarula@amarulasolutions.com>, Lee Jones <lee@kernel.org>,
        Conor
 Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240111113146.16011-1-dario.binacchi@amarulasolutions.com>
 <20240111113146.16011-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240111113146.16011-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02


On 1/11/24 12:31, Dario Binacchi wrote:
> Add binding definition for MIPI DSI Host controller.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> ---

Hi,

Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Regards,

Raphaël


