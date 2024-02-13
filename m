Return-Path: <linux-kernel+bounces-63506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8EA853088
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A154B1F28CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F9D24A1F;
	Tue, 13 Feb 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="t/DSLgBP"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E283A8FE;
	Tue, 13 Feb 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827461; cv=none; b=X0aGS2teaF7OQmIQ8Alar4p/XNFmIgyd9fLthUKQLOBt9NDXTZcNLhyQIromsC9UwnHQe3fe7bczAgYRAmOIp98XueM5Xgm/5UNykddERkDRw7cwrb8tSvlWfZuan2uwUee1bfj0+0wEHLFg/D+sl4eoa/bCy8PRCXcMydNuExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827461; c=relaxed/simple;
	bh=lD1PS/JX+bbCuKijEg/mbIfGVLbRgFl+UYCqNJpCNvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bleOGq/QtBy5Jq79bI8jzF9x0hOTBq5mPlh4v3/XlQIhAA8GUwdCvuwTodydhclVMuc+QWE2fMflr/Sdte5PZaSq2z9q8GKy+uYU1IFMLgjmRm5gP5qd+x5gdLezpAAr6jtRWX69GADbPpN6apiNm4M3/KTyBuc/eVe25xKyTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=t/DSLgBP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D7d0cd002349;
	Tue, 13 Feb 2024 13:30:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=kHU+w4G8rI34Tv3Gohyrk/JVIGnrPjuaVTS+MdoFwXk=; b=t/
	DSLgBPM5IwMdlpBqfKAukMqNYXOPKwWIutP9G5ZbBlV36IoNpQK7fHQ2ckWL/3kO
	bzRp9HRF3XMXQrfs5HeF6ETaRGmp+xQn930VdL0uVwnFWBcZCoCPf7klmyXdZoBn
	uFJ2h4DhhLsUgoblkaPx3W7MT4nzMZcSQojx8qfsSZPYDybWivvJoSlpi3KeD5XG
	4A0CkC8yH5Aml8m4n0XBhyA1yk/me/hIs+kRoIra7Em39z6xB4XXO0AzclHI8SD+
	/i+8Mcd9n81L1jzlxHKbIYtQC3uvmRBxtR+woghddxK4OUk8Ohx9FIhN6fp7nkQt
	7aHnZ58DqqEDvUJ+jtZA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62shtndr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:30:37 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A4D004002D;
	Tue, 13 Feb 2024 13:30:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B971F23C6AC;
	Tue, 13 Feb 2024 13:29:48 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 13:29:48 +0100
Message-ID: <f8525765-4c91-43ab-a57c-d236889cf122@foss.st.com>
Date: Tue, 13 Feb 2024 13:29:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] memory: stm32-fmc2-ebi: add MP25 support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-5-christophe.kerello@foss.st.com>
 <afb4bd72-aa22-4d74-aeb8-d3875c6d07ca@linaro.org>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <afb4bd72-aa22-4d74-aeb8-d3875c6d07ca@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02



On 2/13/24 08:36, Krzysztof Kozlowski wrote:
> On 12/02/2024 18:48, Christophe Kerello wrote:
>> Add MP25 SOC support. RNB and NWAIT signals are differentiated.
>

Hi Krzysztof,

> s/SOC/SoC/
> everywhere

Ok.

> 
>>
> 
> The way you split patches is a bit odd. Shall we understand that this
> patch is the complete MP25 SoC support?
> 

No, it is not the full support but the way the FMC2 IP has been
integrated in this SoC. As patch 5 has to be written, I am going to
merge this patch and patch 5 in one patch. I am going to follow your
recommendation and use the platform data to distinguish between each
variant.

Regards,
Christophe Kerello.

> Best regards,
> Krzysztof
> 

