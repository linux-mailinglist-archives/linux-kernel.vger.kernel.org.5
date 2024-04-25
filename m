Return-Path: <linux-kernel+bounces-158188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C007C8B1CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5E21C2168D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741E74432;
	Thu, 25 Apr 2024 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Z7bNRD/T"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6324205D;
	Thu, 25 Apr 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033338; cv=none; b=A4e9evh9f5k4wvqpn5wEagsYJhMbs9cm6700EwfNm0hIL2F6WF8NQXM+doOtsJrmD0KFqBXimwWwP1VqBubPzWD6TQwCH1KZndXFye4XHTFX5fz5CJ3DBO8xjgikSD3fNSsh3dHP4HFzunqC5yDoug/KeLqgzjsoRpX0hiRUfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033338; c=relaxed/simple;
	bh=65uS8QK637r5AEkeZi5BHkJu+vtvg1RJSMsNHk/A9oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AGt2DGuukUoboO8HXDIXlRA93kNpH1E0lTaGZNFQHcP9TxMpjh52c9a/RfoL2umvI5Vxm/6SSngDHNPKv3qKYmCJcMlZ7SSK9SZ1PGnswj3Z8ZmUO3nPCSWN62JwD9GtITma/NN2yG/ScjAicC7vm0zzxPeQ/6njsGP8vvxb8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Z7bNRD/T; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P7eqUk026286;
	Thu, 25 Apr 2024 10:22:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=i2xvSKGi0kduhQpp0jPnnSJVZO3fv1dsJElSbwSfge8=; b=Z7
	bNRD/T75coGR0wnv1ucjcEhcgQl/dfOAUul54AdY6QvnqmpAO2Z2gHItsg1gJIP4
	DaeeF6FKZx3FvlLyXaIDVXkY/Xpguo55Kw0taSszYSqEnV03bKGlquTO5AX4gRD3
	yIS2Yh3LmltmXQCVlF48IGxiFb5Qp9EQypAjXV6d3jpw3J8Tcq0d8HqiStEH33tM
	sLpnhh33C8m3j0nXNshfuhKIe3YZM5aZf1OW+gsXCz10g6qJ8tX7mvdIv6ZZQ60V
	RqaDvTZlkId0S/PovorxYAUvhbzOjBqKzrSFxdLxE5NTtKMznzlc2t0PBGTLipuc
	u2wStV67X1JFeylNuRNw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmq90tnf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:22:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B41A84002D;
	Thu, 25 Apr 2024 10:21:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92D01210F60;
	Thu, 25 Apr 2024 10:21:18 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 10:21:17 +0200
Message-ID: <c217117d-6388-4230-8afa-d26226bb11ce@foss.st.com>
Date: Thu, 25 Apr 2024 10:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] spi: stm32: add support for stm32mp25
To: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Erwan Leray
	<erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231218155721.359198-1-alain.volmat@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20231218155721.359198-1-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_07,2024-04-25_01,2023-05-22_02

Hi Alain

On 12/18/23 16:57, Alain Volmat wrote:
> This series adds support for spi bus found on the stm32mp25 and add
> all instances within device-trees.
> 
> Alain Volmat (4):
>    spi: stm32: use dma_get_slave_caps prior to configuring dma channel
>    arm64: dts: st: add all 8 spi nodes on stm32mp251
>    arm64: dts: st: add spi3/spi8 pins for stm32mp25
>    arm64: dts: st: add spi3 / spi8 properties on stm32mp257f-ev1
> 
> Valentin Caron (2):
>    dt-bindings: spi: stm32: add st,stm32mp25-spi compatible
>    spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc
> 
>   .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 +
>   arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  46 ++++++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |  88 +++++++++++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  14 ++
>   drivers/spi/spi-stm32.c                       | 145 ++++++++++++++++--
>   5 files changed, 280 insertions(+), 14 deletions(-)
> 

DT patches applied on stm32-next.
I added "access-controller" bindings for all SPI nodes.

Cheers
Alex

