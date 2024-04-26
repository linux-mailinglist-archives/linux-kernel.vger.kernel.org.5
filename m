Return-Path: <linux-kernel+bounces-159946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBAE8B36A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE3C282FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ECF14534B;
	Fri, 26 Apr 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EFbrcrlS"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05805144D3F;
	Fri, 26 Apr 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131743; cv=none; b=KCkK2XEEjW6/WgUfQ/cd8uwSL4Ur3HHDYOlnmFSNL0HkKeRjQsTXzLSCWs/1IfJWLmhoKvUr/56JtnKB+1nE1EybuUlp3KVxDiTnEkhFq+8keItuhXgOS8SAEDKF6+7fQpt9spig+WF9a5b+yy1YdSrzWvLJHDP4knwW3a1w0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131743; c=relaxed/simple;
	bh=r1LBvcN21bnCsvNbCvInEtP2axcREmP/1hM9yXgtm84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ePoKPudbpX0ajvf9ZMP1pvD/zQlv90909eedXEsmZF55A0B73BfkN6gt1yzdp8kcQPTAyCaE352YQmz88p6Zca2ZCtlRvMLMVmtQrxxjMLoerMCIbDvxIaDNBwFh0RVqCQOGghHaJulgOjcJ5vLPOIv3Zjn5n2iorRecIZiIFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EFbrcrlS; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q9YZbQ003998;
	Fri, 26 Apr 2024 13:42:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=xlp/k6NhfJf0MqxY61zVVi1EscMRkgrov08pc3xWnOQ=; b=EF
	brcrlSp46O1V38x7aimygEW9OOem1rrJnfo1JuqJegCGR9OogPSz7VKupSeL3T3V
	pqW7mazob116524aoeNUmLKrH81SIFt/gMORjwOOnDBMPj45kg4fxwz7PSGEB6V0
	FZs8g/JUmBmjNQ4e6HCH+OM8aGMeEehZIfM36OGF8c3hy4xxkyPdFbKnTBWQK7Eq
	KeyCgtmpqjif0ai204Bywn5alXego3R9uiCHICxdmCvwg0eBkq1+HbdCkD5zRSBp
	RdCeVJOEkbpwDRrXZeFRq7yfQ4kDfECoax2q7coLWPA8FrMM5TWYtlK8FW1inqBb
	frfX0FIJ7nKaVXbLAzCA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4ee9jx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 13:42:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F36D74002D;
	Fri, 26 Apr 2024 13:41:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF31E2194CC;
	Fri, 26 Apr 2024 13:41:14 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:41:13 +0200
Message-ID: <28aeb8b1-72f1-4dd9-b433-f5b693150475@foss.st.com>
Date: Fri, 26 Apr 2024 13:41:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ARM: st: use a correct pwr compatible for stm32mp15
To: Rob Herring <robh@kernel.org>
CC: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Pascal Paillet
	<p.paillet@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
 <20240425163035.GA2783061-robh@kernel.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240425163035.GA2783061-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

Hi,

On 4/25/24 18:30, Rob Herring wrote:
> On Thu, Apr 25, 2024 at 09:48:31AM +0200, Patrick Delaunay wrote:
>> This patchset removes the unexpected comma in the PWR compatible
>> "st,stm32mp1,pwr-reg" and uses a new compatible "st,stm32mp1-pwr-reg"
>> in STM3MP15 device trees.
> Why? I don't see any warnings from this. Yes, we wouldn't new cases
> following this pattern, but I don't think it is worth maintaining
> support for both strings. We're stuck with it. And the only way to
> maintain forward compatibility is:


Yes, no warning because the compatible string are not yet checked by tools.


I propose this patch to avoid the usage of this compatible for other SoC 
in STM32MP1 family.


I see the invalid compatible string when I reviewed the U-Boot patch to 
add the PWR node for STM32MP13 family:

https://patchwork.ozlabs.org/project/uboot/patch/20240319024534.103299-1-marex@denx.de/


So I prefer change the PWR binding before to have the same patch applied 
on Linux device tree

> compatible = "st,stm32mp1-pwr-reg", "st,stm32mp1,pwr-reg";


Yes, I will update the SoC patch with you proposal.

it is the only way to have compatibility of OLD Linux kernel (with old 
driver) with NEW device tree.

I miss this compatibility issue.


>
> Rob
>
>
>
Regards

Patrick


