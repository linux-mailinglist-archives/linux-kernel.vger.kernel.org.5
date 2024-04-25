Return-Path: <linux-kernel+bounces-158136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F138B1C05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267AE1C23DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569F6BFAC;
	Thu, 25 Apr 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tJkKK90P"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704D3D388;
	Thu, 25 Apr 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030622; cv=none; b=V3yFOixVtDxnoAc3LSevb/VRBDV5i9NLCJz/E2Pmpz30BVrBboOLkV/ztjY+CwRshuWKlN3X40MWjfWARfW/ISQRaMYuL2GgYU3afJbC55sTRxF50J6mHu1B2GfeJHllq0BCJMx38uo1FlEkhtVt7PF2ejEDYt5HyzfbCnholmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030622; c=relaxed/simple;
	bh=AzVF3YThY59VDeTlYIRWSwq+3dTtAAfUMzvX48Hc4Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=arhT/4pFWvpUKZ+HiGlFF/S3hgV+qJxnBmYVy9O6e2z4kqDMUWXY+1dMpTdMz5SfvrhE/+66gtS1vkMqvoafImch2TUlBb67JLInf+1hBoYuK92Okr6E19cXvcNBGnMK7mVLkMPq9tyedjnJjK5j6RzfQ6utsDdxDi8wYEbfzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tJkKK90P; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P7VAer021460;
	Thu, 25 Apr 2024 09:36:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=zcKEXefoMz98bSSERpP3RE1+JT4NimZBmrhz03/9OP4=; b=tJ
	kKK90Pn2fAScqFQfw1fcuyiL7t9gZEOt/gOvZzzOwPgP5BRriBkPIYHIBt0kDMRK
	QWAlcIIcKoecNYkjz5f28o6M/8bdcyYFhxJJlfF5BirAOGVP+X7ilHRvX5yd7yDq
	6+l2vQINEpWp0blJ1rukMUNDp5urdY+2BqQ8TbNnhH/GhBBjd9f+X2O/+y7Lfx50
	l2pVAi6+45JQAwIAW31oDNe3MV4ia8G39qWr3MP+UMgGZwJ921T3PCYS9fx2h8RP
	EityAxmed9W1TDkwEnvRPXTiZAFcg46Zteqy2m/X8IVbew2pQeKhmErb0RChRyiw
	YiCaG/gd9o5dYATFqLnA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm51wckfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:36:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3A77640044;
	Thu, 25 Apr 2024 09:36:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A3AEB2128C1;
	Thu, 25 Apr 2024 09:36:04 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 09:36:03 +0200
Message-ID: <d2721aad-b17d-4b40-908c-238d02c52a0f@foss.st.com>
Date: Thu, 25 Apr 2024 09:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/4] arm64: dts: st: add rcc support for STM32MP25
To: <gabriel.fernandez@foss.st.com>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240411092453.243633-1-gabriel.fernandez@foss.st.com>
 <20240411092453.243633-5-gabriel.fernandez@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240411092453.243633-5-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_06,2024-04-25_01,2023-05-22_02

Hi Gabriel

On 4/11/24 11:24, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Add RCC support to manage clocks and resets on the STM32MP25.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 144 ++++++++++++++++++-------
>   arch/arm64/boot/dts/st/stm32mp255.dtsi |   4 +-
>   2 files changed, 110 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 5dd4f3580a60..15b79d26d1c6 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi

Patch applied on stm32-next.

thanks!!
Alex



