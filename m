Return-Path: <linux-kernel+bounces-47727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D275D8451D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7007D1F22F75
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2E1586D2;
	Thu,  1 Feb 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="LN9FXNY0"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FB14D421
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772072; cv=none; b=foKO+DYrWPaiFYvhdkv6CHiZbUl01MAmFIzBlr0LQNzhMtCBnqvkPUtiUtlRvJPQbulYuHiFmUsnYg+j42i72FtvI5WZMIZJE21GqRudg+6aH3KaJbxb1n3GD9jBPrYZC70+kSLm4dwLqbpopFJBI/Hp1UE6dkYZSEJbKeQa39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772072; c=relaxed/simple;
	bh=Qzy2oOPsIc5tTE7cmvxG1DcKpfVX0wiUFBwbxQE3kj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8J9FiDNmJ+2wLKej2x2ldibWCRVuN4V6h5EVeXMoi7wX+ikumDaCA9cE7KU9PpFBGnFAXJmA6R+RiuPFyIt02StAWnEEUMUmCEfEVOpv+jpPUpukTw8fHe9MbmY3nYnths+QJyj/gUqZaOEFqTZ7e3xJUu8J1dEL0wzSfmSf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=LN9FXNY0; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706772061; x=1709364061;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qzy2oOPsIc5tTE7cmvxG1DcKpfVX0wiUFBwbxQE3kj4=;
	b=LN9FXNY0+JeQx54u20Cqq5tBAur78fCmGEcQ4KjUhOP5Cbqs1mQGDm04k8zWRRYZ
	7mUQv+m8pML2/A6i9YkNKrTOcHDTPFcYJ7HQ2mRKswhi0STDuxfbHwBveN2JNPsT
	rUYByR92O71USERbQfQNi6d0ujnq/1u8bqItHftprIw=;
X-AuditID: ac14000a-fadff7000000290d-03-65bb465dc217
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4F.E2.10509.D564BB56; Thu,  1 Feb 2024 08:21:01 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 1 Feb 2024
 08:20:57 +0100
Message-ID: <ca2a2025-456a-494d-b0f0-926ea2dd3a57@phytec.de>
Date: Thu, 1 Feb 2024 08:20:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH] arm64: dts: ti: phycore-am64: Add ADC
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <upstream@lists.phytec.de>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240201001439.3259450-1-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240201001439.3259450-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWyRpKBRzfWbXeqwZxtzBZr9p5jsph/5Byr
	xfLPs9kt+l48ZLbY9Pgaq8XlXXPYLN78OMtk8aFxM5tF694j7Bbd79Qt/p/9wO7A7bFpVSeb
	x51re9g8Ni+p9+jvbmH1+HPxHavH8RvbmTw+b5ILYI/isklJzcksSy3St0vgyji3rYGt4Ahb
	xZIdjxgbGFewdjFyckgImEh0nLrH0sXIxSEksJhJYuH+N6wQzh1GicN7FjKBVPEK2Eis7P3A
	AmKzCKhIPJnVyw4RF5Q4OfMJWFxUQF7i/q0ZYHFhAVeJ/yfXs4EMEhHYziixZvEiZhCHWaCN
	UeLBhm42kCohoKkHvi5hBLGZBcQlbj2ZD7aNTUBd4s6Gb2D3cQrYSizsuQ9VYyGx+M1Bdghb
	XmL72znMEHPkJV5cWs4C8Y+8xLRzr5kh7FCJrV+2M01gFJ6F5NhZSNbNQjJ2FpKxCxhZVjEK
	5WYmZ6cWZWbrFWRUlqQm66WkbmIERZ8IA9cOxr45HocYmTgYDzFKcDArifCulNuZKsSbklhZ
	lVqUH19UmpNafIhRmoNFSZx3dUdwqpBAemJJanZqakFqEUyWiYNTqoGx7VAM1yP2R3ZTpvBG
	HbtpdCzws/WsMu19N6/MLgu0DZXbw3rYMcfp92EV1atyp5V1Q3wC99xeVPFO4rGVmMjmxeah
	SXvKfIQyFovs4vzalxDoZHb93WsN3r8+t61WcRY+ZnxyLGm7NafYjnVPDdvMWDXYdr5I1py3
	+X/S4bLS2+xCKt6zFf2VWIozEg21mIuKEwHNSq9prAIAAA==

Hi Nathan,

thank you.

Am 01.02.24 um 01:14 schrieb Nathan Morrisson:
> Add the ADC node to the phyCORE AM64x and enable the ADC.
>
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


> ---
>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 1678e74cb750..cf1940c23bfe 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -318,3 +318,10 @@ &sdhci0 {
>   	disable-wp;
>   	keep-power-in-suspend;
>   };
> +
> +&tscadc0 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};

