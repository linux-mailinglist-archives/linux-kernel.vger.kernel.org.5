Return-Path: <linux-kernel+bounces-156935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDFA8B0A90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E621F24B27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ABA15B98B;
	Wed, 24 Apr 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ligt8wZM"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7615A4B0;
	Wed, 24 Apr 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964297; cv=none; b=V9h1Nv52UrmiL2Y+gkrlpwRkZOHR0d6Rbyue62ohTlkMBrxTBSHumBXMzSev11aZ82URvXvfKrMho2WJ833tz/kijlC+ChqGy0PYij6AU9HTHEgli2ZsTvbHkGcrXM0MyK3+a8MS7BCh0tVgLYx8l+h0Hq1fo0qVunEvVNVczhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964297; c=relaxed/simple;
	bh=0GM9qCjYncLlk2eyXQbEJr4kraDbbsFDY3wf8G6s70w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dNLEyhT8gifKiHwqTKGHHbSgrVSPCG9FIJ5dckJX6dZMCT0nNzmHxW1NlQQ41h5bhfB9RV/hqNsZfcJGyPi4/nBSc7IdO0FiPuDkdoGFCp4Zkl/MuBJmfGBTINZwLXjbgbzjE+hzGRIQpPG4J96z7cRg944/godjl86OJO/YIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ligt8wZM; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OBiLD7018292;
	Wed, 24 Apr 2024 15:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=HYSJG1sPeSjl23kgI1bzRXZCAj4WS/GfNG5nWWxw0Vk=; b=Li
	gt8wZMTOL0sPyiSCxLlgRIUH/Vc82ELF6mVIODBNPHBiyGzugekT687g3kBWT6Fy
	1iL5xeh5qo65/dnTsTyiKTVzRsq4R+3DEhG46rEaijnxESXbwMmPL45C15SaED4v
	50Qcba0NgM4I+6/uL3aFTNs2S0jMD7ezz6yyeVXaw/ZSEB9JfstuMsUfE0WNKy3/
	NtyMhdvqvde+Bas+TdXdtJl/Bs5rT2e5+WXEw4wJ6Gl/PR5DVxHHjren2plshRQI
	B1nu12Sq34EmDylnO5QlOpXkfHLDa7op6xIUgueLRput5kXau/kTTUnFUAAJ878d
	upGthvtis7RdJJjRy3kg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cngp6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:11:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4F19B4002D;
	Wed, 24 Apr 2024 15:11:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C10821ED4A;
	Wed, 24 Apr 2024 15:10:27 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 15:10:26 +0200
Message-ID: <f625f62c-6351-4799-92c8-20abb7185ac5@foss.st.com>
Date: Wed, 24 Apr 2024 15:10:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: dt-bindings: add access-controllers to
 STM32MP25 video codecs
To: Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240415093211.809927-1-hugues.fruchet@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240415093211.809927-1-hugues.fruchet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-24_01,2023-05-22_02

Hi

On 4/15/24 11:32, Hugues Fruchet wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> ---
>   .../devicetree/bindings/media/st,stm32mp25-video-codec.yaml   | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
> index b8611bc8756c..73726c65cfb9 100644
> --- a/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
> +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
> @@ -30,6 +30,10 @@ properties:
>     clocks:
>       maxItems: 1
>   
> +  access-controllers:
> +    minItems: 1
> +    maxItems: 2
> +
>   required:
>     - compatible
>     - reg

Applied on stm32-next.

Thanks!
Alex

