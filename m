Return-Path: <linux-kernel+bounces-86418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E9E86C51F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5B31C22F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C545D728;
	Thu, 29 Feb 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="O6jGRkix"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A125A7AB;
	Thu, 29 Feb 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198896; cv=none; b=b1yoR7Sctg+sV7dGb8Dm+uUXYFratNMIqGnd0Y/KdEaCXIdkgjLMdbgEl2IpEBjeF5c9mVBWA45bTih3Ve5tAhNR/sbaX0gM5w1heAc3wWMIrpfeXnyZkW1PSLUNzPrDoD6CZgh15oKALr5eywRCJecNYI5N1cOrPUSMjkkPiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198896; c=relaxed/simple;
	bh=Lf9OncCg/T0enHUIz5IfRMFRJB6Ylufpu6rL2gWmXMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EeTGxaESN4TlG189sfcdBkVuYggYN9hNbDMRwR6NerBQHU7RVN9k0AJ00mvfvhPJzTzyUxh5wUT2eF2HhDgdJXzV0raZwROhBfQILC+q2muuffMvgCP1NqBeIqYpZeKPcGrYuFL7047DBUWxc/gpnsneIFFdOkS96ewygkrr4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=O6jGRkix; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T54AFB018062;
	Thu, 29 Feb 2024 10:28:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=lLzXK4ziQ0XZhX6SdDGA9H4+IrlVv8lehxYOD5oOBtY=; b=O6
	jGRkixP9Gjyj9Rfbee6LCP/TUEVsCY2dxkZf1Y1PQPu0n5iB8QqYLSjQco8Q/MGt
	dQrFrE8nrq7mT082pvBETart2Dp65Dcl2CITmwIzOkCJZVXkrNENr3RIhhR457jd
	0Rv0K6ev0WT++Aggfe6AHuk4ln2qD9EmxbbGJizllevUeIm266ztQ506KJh32dXw
	aXob2uFE6mXtNebPHWh6O0Oqkff9jwTCy7lZz4VpnZ0vygVJAKxXvidRv6EF/Lnr
	vHwDOATcES+wTZXNAG41422tAaqGmNfUestW555YrWeYIu/EEtJDl+IXaSRv2XcY
	/aq3NXFP4r5iKXlMPIUA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4e1992-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:28:02 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0E7B840048;
	Thu, 29 Feb 2024 10:27:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3C39424F9C4;
	Thu, 29 Feb 2024 10:27:27 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 10:27:25 +0100
Message-ID: <1da6174d-a8b2-420b-a1f2-db6975d68948@foss.st.com>
Date: Thu, 29 Feb 2024 10:27:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Enable the CRC and CRYP IP on STM32MP135F-DK board.
Content-Language: en-US
To: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240219113745.92538-1-thomas.bourgoin@foss.st.com>
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240219113745.92538-1-thomas.bourgoin@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02

Hi Thomas

On 2/19/24 12:37, Thomas Bourgoin wrote:
> Enable the CRC and CRYP internal peripherals on STM32MP135F-DK board.
> 
> The first 2 patches adds the node crc1 in file stm32mp131.dtsi and
> enables it for the board stm32mp135f-dk.
> The last patch of the patchset enables the node cryp for the board
> stm32mp135f-dk.
> 
> Lionel Debieve (2):
>    ARM: dts: stm32: add CRC on stm32mp131
>    ARM: dts: stm32: enable CRC on stm32mp135f-dk
> 
> Thomas Bourgoin (1):
>    ARM: dts: stm32: enable crypto accelerator on stm32mp135f-dk
> 
>   arch/arm/boot/dts/st/stm32mp131.dtsi    | 7 +++++++
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts | 8 ++++++++
>   2 files changed, 15 insertions(+)
> 

Series applied on stm32-next.

Thanks
Alex


> --
> 2.25.1
> 

