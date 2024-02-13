Return-Path: <linux-kernel+bounces-63849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7201853577
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159051C24C72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A625F577;
	Tue, 13 Feb 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Z3OGAhtm"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB445DF25;
	Tue, 13 Feb 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839919; cv=none; b=qVyViuAqwqCqU+Ugj1D5K+4zfQ69jCdA/ZM0VwhFygaqtj/o7iPF+RAQ8rHwrzvmeTYGUd6svVnilAE2pN9ccETXqQBfAQobzz0U67MwuMAEP9YrfVlsc0vigfaSWlTIbfrhDJZ1UuuBYszWFoVnDLce9vgrlPuI7zyV7aCvA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839919; c=relaxed/simple;
	bh=t9MokVMjIpOEtFvJJN7oiI58o9zM2jVHIUIbGKLKBwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eNYxzdPs3HSj/KIBSxQl2gRFWGiQ8qzDzMARcsuFuLMpIKsY2dgGvmK48fAQyBcl7pi+FmA0Ocu1BiYJmXfBhZR2RwvJ7z8SLrNobMZXGlBs0l+PYaoUJ5DXjSqWBkngLawQ+tOS71VZGyZ4WETvp43976yZlcu4/ag2Srz3Z3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Z3OGAhtm; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DFfl8Z015351;
	Tue, 13 Feb 2024 16:58:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=/7j7puYAJdXGzVp6s9NPsesdHRXPxVYZpy3cSzTw1+k=; b=Z3
	OGAhtmBsX3EzNnf9vnuK9f5xiPfL8KXPnbhAUrp8ltB0PpZ84bso1c7mc+arFnoJ
	t0IUOEepyKndq6KgjWWbRQH8fQzt+/rsoSbsy2GGkTUp42omdve3TN4ku90xQPei
	vIQtByTB4CFeUaPCe/eP5RcWcgs6qCO9DELiuZTnm/0+ntnwjHGJ/Xj0dUT4Ug6p
	lwDEPwK8DABFYlEOuA/LOiRd9OQ4/Gnnp20g1uj0oLbtt2VAjzABY65IgDqNZU7Y
	7MUs15CRtMA4agZy0XNOK1RH81msXYIj5F7GDK6gcToHtSM61EGURc87l1DVX9gi
	040yBb9Zgx0S2EbzP9VQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62jsbpu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:58:24 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 52B4840044;
	Tue, 13 Feb 2024 16:58:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0ADF62747D6;
	Tue, 13 Feb 2024 16:57:33 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 16:57:32 +0100
Message-ID: <44f24885-eb62-4730-86fd-f42b3a3cca34@foss.st.com>
Date: Tue, 13 Feb 2024 16:57:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] dt-bindings: memory-controller: st,stm32: add
 'power-domains' property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley
	<conor@kernel.org>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-3-christophe.kerello@foss.st.com>
 <20240212-chemicals-skinny-18eda1cfe781@spud>
 <c57b8094-be08-4ae4-ba85-f48522e5d2a8@foss.st.com>
 <52be1d88-51a1-4ec7-8aaf-6046f5a469f4@linaro.org>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <52be1d88-51a1-4ec7-8aaf-6046f5a469f4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02



On 2/13/24 12:57, Krzysztof Kozlowski wrote:
> On 13/02/2024 11:57, Christophe Kerello wrote:
>>
>>
>> On 2/12/24 19:33, Conor Dooley wrote:
>>> On Mon, Feb 12, 2024 at 06:48:12PM +0100, Christophe Kerello wrote:
>>>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>>
>>>> On STM32MP25 SOC, STM32 FMC2 memory controller is in a power domain.
>>>> Allow a single 'power-domains' entry for STM32 FMC2.
>>>
>>> This should be squashed with patch 1, since they both modify the same
>>> file and this power-domain is part of the addition of mp25 support.
>>
>> Hi Conor,
>>
>> Ok, I will squash this patch with patch 1.
>>
>>>
>>> If the mp1 doesn't have power domains, shouldn't you constrain the
>>> property to mp25 only?
>>>
>>
>> As this property is optional, I do not see the need to constrain the
>> property to MP25 only, but if you think that it should be the case, I
>> will do it.
> 
> The question is: is this property valid for the old/existing variant?
> 

Hi Krzysztof,

It is not currently valid but there is a plan to move MP1 on PSCI 
OS-initiated.

Regards,
Christophe Kerello.

> Best regards,
> Krzysztof
> 

