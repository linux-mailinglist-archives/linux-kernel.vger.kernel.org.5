Return-Path: <linux-kernel+bounces-63485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0C853042
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E1E28A884
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED738DD9;
	Tue, 13 Feb 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XPTm/XEJ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F783FE2E;
	Tue, 13 Feb 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826267; cv=none; b=ZZspwPLCqVAcV/04KtY+7mSrSFYxHhkcFupE/IUZ0dlvbNcsA6CMkz70SYeNOffBBO9yz/JrstpVxM7a4cq+s25l7IzlSGGn4GnPBnzeLvtxxQvvoT+vQOWcyAYOI/KSzssNx4kxPwoW/+ODdsHLDzDLwfYX85dCHRwLshqI250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826267; c=relaxed/simple;
	bh=+N6oWphlV7CU8man21/8n4+EzJmAqK7AheWgjqy0khU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jblZsztlVwdw6RTC2Nbm5DUWRAV+qSjEHq6rsLogp1IqzrdlU8KVLYY9L+du8mVwtTLb/3+tF3b06rAuCyctw1TXLzy5mXnHCjLnhX42kBWkMh6fq/og3kdH4H9Kvehi4+hCxYI7ofUbNJ2AJg5N11HCx82iF/IldfuHmGHOZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XPTm/XEJ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D9saVg015351;
	Tue, 13 Feb 2024 13:10:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=ChetLBdDsyZCoOZVq/CcmKPawKKxLlNm8k9kly42dxc=; b=XP
	Tm/XEJXAj0h03nwlwl/5vxOFM6OZLESY21fyNEWi0nQ/8/y0YIVcbyeNNmqfeN0D
	SwLoUTSRgO78vD9fJTSxJL+uRY3CWqcjZ76WQ1Czj5Mu7RSy34gpSsZVZtDr5y7i
	NWYZaPwXWhfMPlIINoPXFCOEmu7hwz5ARJrTbn9RURFPVCC7pjh4Jm+pU6+GxG1s
	7oqMgPSWe8VOaR9JwFI/2UuS/YrUysTHG+AMFcJ6PWRuO+l5BCpHNF1OYSu/5eeI
	psFdzYGXlZrW4ioscXxhwNj0n4ayVmD+XYGCZZu7kPxfVlW7/7YY9sV5xC/hIC4s
	U9R0H2GHa1Sgk3zdYYAg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62jsatc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:10:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 472C04002D;
	Tue, 13 Feb 2024 13:10:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C219236951;
	Tue, 13 Feb 2024 13:09:56 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 13:09:55 +0100
Message-ID: <9f20563b-bef1-41d0-a1ba-fefeabed2e09@foss.st.com>
Date: Tue, 13 Feb 2024 13:09:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Add MP25 FMC2 support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <fbaad3c7-13b7-41a2-a8f6-7036ec1ca2fe@linaro.org>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <fbaad3c7-13b7-41a2-a8f6-7036ec1ca2fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02



On 2/13/24 08:34, Krzysztof Kozlowski wrote:
> On 12/02/2024 18:48, Christophe Kerello wrote:
>> Add MP25 SOC support in stm32_fmc2 drivers:
>>   - Update stm32-fmc2-ebi driver to support FMC2 revision 2 and MP25 SOC.
>>   - Update stm32_fmc2_nand driver to support FMC2 revision 2 and MP25 SOC
> 
> Why do you combine memory controller driver and NAND in one patchset if
> there is no dependency? On any further submissions, please split
> independent works.

Hi Krzysztof,

NAND driver patch 11 refers to the compatible described for the memory
controller (so there is a dependency), but anyway, I am going to split
this patchet.

Regards,
Christophe Kerello.

> 
> Best regards,
> Krzysztof
> 

