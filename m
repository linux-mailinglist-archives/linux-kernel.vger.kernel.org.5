Return-Path: <linux-kernel+bounces-135076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6AB89BACF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9081F23DED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22FE3A1CF;
	Mon,  8 Apr 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lBPR9JC2"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D239FC3;
	Mon,  8 Apr 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566052; cv=none; b=EYphL74PDDcjapbSdS4ytCSAOrn5GdY+sPAr9328qm1L1/T4cY2TcLQFISM3dfZO7D8Nh526lk33PRJxnsAyeLyREE8jihY422qaxvPzE0jYgrJKQFnwZ6WEMDWd+0XAmJtdspw3GaRV9Qy7pOssqVLmpQaSylWJPjqMm6xhqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566052; c=relaxed/simple;
	bh=2eFFwSttun3uIY1XfPS/pkCzpl162LzG/iBNQ1c3Jtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jaZ4ulCgG32k1xzVyXWB4Q1o2NA3IGV3cyHAl4eG39efv3WNx3zjjYVSSP4fTnlGFaGUqjJhJEM51HwXy1pnm8jEpQ/EUlpmBLgxICTk4ccDA5P1N6H3Ct0bpCad29UDiWuTU6lb91DqrLs3HxMG7OOE1tso9u2hgZFDTlnFLNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lBPR9JC2; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4387ZL2J018496;
	Mon, 8 Apr 2024 10:47:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=TYkH34uMprj1yxX3lrhsXG/hLH2prLf+ZcjW3uXuFz0=; b=lB
	PR9JC2p7c01IdWmLJnsJT9OHGXY5r9aM5KTIA10Am6I2Ihi7Oklace7Gmceesroo
	KSS43gD+w+LyTSUrYnO0tnymt5zelli6Y2kwN216V7GIaT3BLgerkECsFWTRLfeh
	QMMCw7+SXrAydTyls/eFQN4ZHj2lSI43ZujZDp/tau0IC2mHzKnh34T+JQhHOVCy
	M1G5cYRfSFrzn5f3mPMWMFohCrowb0z/mS3SBIXUbNJvmP84d0L1O819jp0gWvUG
	7TO1RE6ZwiKPVWDKqNCMZWIFzTsc5PCAe/6egTlnSgRRBsdIlN9QUg0I9nq7VnND
	9Ab8yhS49ruVTI6bSdKw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xawqxnpx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:47:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4FE4C40046;
	Mon,  8 Apr 2024 10:46:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E65C02105B8;
	Mon,  8 Apr 2024 10:46:18 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 8 Apr
 2024 10:46:18 +0200
Message-ID: <8b25daf7-2518-42eb-b1a1-857d02d8c3a2@foss.st.com>
Date: Mon, 8 Apr 2024 10:46:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: move can3 node from stm32f746 to
 stm32f769
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-amarula@amarulasolutions.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240325075635.1382911-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240325075635.1382911-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02

Hi Dario

On 3/25/24 08:56, Dario Binacchi wrote:
> According to documents [1], [2] and [3], we have 2 CAN devices on the
> stm32f746 platform and 3 on the stm32f769 platform. So let's move the
> can3 node from stm32f746.dtsi to stm32f769.dtsi.
> 
> [1] https://www.st.com/en/microcontrollers-microprocessors/stm32f7-series.html
> [2] RM0385: STM32F75xxx and STM32F74xxx advanced Arm®-based 32-bit MCUs
> [3] RM0410: STM32F76xxx and STM32F77xxx advanced Arm®-based 32-bit MCUs
> Fixes: df362914eead ("ARM: dts: stm32: re-add CAN support on stm32f746")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  

Applied on stm32-next.

Cheers
Alex

