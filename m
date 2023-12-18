Return-Path: <linux-kernel+bounces-4106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921E817800
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF1DB22221
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E83A4FF65;
	Mon, 18 Dec 2023 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FEMLD3Ak"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9D4FF68;
	Mon, 18 Dec 2023 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BIBVg9Y013320;
	Mon, 18 Dec 2023 17:58:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=2LbVD48cs9SSVdEVF6CGBiY28dgdHPu6RAlKrCsGHvc=; b=FE
	MLD3Ak4teHPbI6Xwmixwvt1711SnapOzLBJPaPaM6624+zpH5+YWl2XfqFNzewIZ
	w+35RSS/Uo3m9NXyvNDVl4Na4gUFdyT3AfIeH/3Vt//5qFiCwW4i06M7B5lTQqyj
	texq/5p3BUdH1T3nII+sCUwgv20eZpGs5baKWtY0lkuemCz2Q9DIU+JSbCcsjmZT
	nnXAKEAn9L2jlQhPypRp8EWMM4YA5/gG2IDFZ3OyYiwx3uSAP3YH/clUFQy+gzbd
	BEmMAmB47/k4xxR2xRTk7iZOcVei1HKItH3fqIsL89oVBP8s25H126qZrIP+Fx9Y
	py4hnheNXyxIjppjnPyw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v13nh8w9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 17:58:37 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B72510005E;
	Mon, 18 Dec 2023 17:58:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0168B26A472;
	Mon, 18 Dec 2023 17:58:36 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Dec
 2023 17:58:33 +0100
Message-ID: <abf4725b-8569-47f8-a06d-c06285595625@foss.st.com>
Date: Mon, 18 Dec 2023 17:58:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: spi: stm32: add st,stm32mp25-spi
 compatible
Content-Language: en-US
To: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>
CC: Valentin Caron <valentin.caron@foss.st.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231218155721.359198-1-alain.volmat@foss.st.com>
 <20231218155721.359198-3-alain.volmat@foss.st.com>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231218155721.359198-3-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_11,2023-12-14_01,2023-05-22_02

On 12/18/23 16:57, Alain Volmat wrote:
> From: Valentin Caron <valentin.caron@foss.st.com>
> 
> Add st,stm32mp25-spi compatible in dt-bindings.  STM32MP25 spi is similar

Hi Alain,
In case you re-submit,
Nitpicking, extra space here could be removed    ^
Capital letters for SPI could also be used here             ^

Appart from that, you can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Fabrice

> to the STM32H7 except for the following two points:
>   - Burst should not be enabled with the new DMA used on STM32MP25.
>   - STM32MP25 SPI8 has a limited feature set, it can only send words of
>     8 or 16 bits and with a maximum words number of 1024.
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index 5754d603f34f..4bd9aeb81208 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -25,6 +25,7 @@ properties:
>        - st,stm32f4-spi
>        - st,stm32f7-spi
>        - st,stm32h7-spi
> +      - st,stm32mp25-spi
>  
>    reg:
>      maxItems: 1

