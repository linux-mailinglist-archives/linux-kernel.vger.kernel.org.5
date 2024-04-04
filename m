Return-Path: <linux-kernel+bounces-130962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C3B898126
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D391F24196
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631254E1CB;
	Thu,  4 Apr 2024 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="LgfwWiA0"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B9495FD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210405; cv=none; b=cOittFMNZouJJMuTAloZPKh3nIixTtDM7kM0eJOUf1ijpHUYz/H5pIgNjev/LwHtwIJnb1sHlhwUZP0Ad55TAyG9v3USjS5C4Ofv63NTur6VTD3OolBgATJotodluoQ7BOTEvicqxHAIgET2ZycECzbeuzVInXHsRCXCjSbgPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210405; c=relaxed/simple;
	bh=aIZ71xpdNE319zeVgp11x3qaqeydbVVrYQzt/n5Sdts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QdqbDYPK1sj9wA+gfHlWNKbTUlofILWydYJ13c3vN1pOo731nAdbDAQap1oSQ9tdGJhMaN+KE7CzdCAjnJpAhoPRfWGeCNQilGk9FGdRwe2mqonzeVwzXq93hArZeA4vkzEBpzGlsC9dmjgqZSkAnccgLy+GxFwFOjVu80qc8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=LgfwWiA0; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1712209479; x=1714801479;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aIZ71xpdNE319zeVgp11x3qaqeydbVVrYQzt/n5Sdts=;
	b=LgfwWiA0KuCL5AgPtvRoD0H1hzXnLqPjE3VI4uP4wnW8n5gX63LXcbRnnsXia2Ho
	hIKCEB3Act5XzYrj9x9ymQaVEpK/9osfslPoa21JxzXXI4XZV7Eo4tSaWPhYtPMz
	JJxAHQdE/hzE2ehNmtdCx4xf+7+JLgLYzowPdflPfkw=;
X-AuditID: ac14000a-fbefe7000000290d-4f-660e3e476d60
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 52.87.10509.74E3E066; Thu,  4 Apr 2024 07:44:39 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 4 Apr 2024
 07:44:37 +0200
Message-ID: <962bd104-b30f-4fad-a41e-d0db349d8bd2@phytec.de>
Date: Thu, 4 Apr 2024 07:44:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am642-phyboard-electra-rdk:
 Increase CAN max bitrate
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240402160825.1516036-1-nmorrisson@phytec.com>
 <20240402160825.1516036-3-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240402160825.1516036-3-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWyRpKBR9fdji/NoO+UmMWaveeYLOYfOcdq
	sfzzbHaLvhcPmS02Pb7GanF51xw2izc/zjJZfGjczGbxf88Odovud+oW/89+YHfg9ti0qpPN
	4861PWwem5fUe/R3t7B6/Ln4jtXj+I3tTB6fN8kFsEdx2aSk5mSWpRbp2yVwZVx/n1iwgavi
	3aX5zA2MWzi6GDk4JARMJE5eDOhi5OIQEljCJPHs4wZ2COcOo8S95olsXYycHLwCNhI9B2+z
	g9gsAioS7yb/YYGIC0qcnPkEzBYVkJe4f2sGWI2wQJLE4V2rwGwRgS2MEu3fVECGMgu0MUo8
	eXiAGSQhJJAv8av9CROIzSwgLnHryXwwm01AXeLOhm+sIDangK3Eo5u9UDUWEovfHGSHsOUl
	tr+dAzVHXuLFpeVgR0gA2dPOvWaGsEMltn7ZzjSBUXgWkltnIVk3C8nYWUjGLmBkWcUolJuZ
	nJ1alJmtV5BRWZKarJeSuokRFHciDFw7GPvmeBxiZOJgPMQowcGsJMLb7cCbJsSbklhZlVqU
	H19UmpNafIhRmoNFSZx3dUdwqpBAemJJanZqakFqEUyWiYNTqoGxqDpZe+4hq0Ns+SlTCoqf
	KZTY5F75N7V1Rq9yXVvHujM3rL8e/qNvfmnbfr86H5VYq2OMkfce/fyolfDm2TYOz4yNh2V8
	7qw4w1PCdyrb8/amMvGN+UsNLm7l+h1t72yk1r8/gV2j8H3zr9udXQzGi3xtTl4MV/tR3eI1
	5873h44OBlzMJsuUWIozEg21mIuKEwENjWfcqQIAAA==

Am 02.04.24 um 18:08 schrieb Nathan Morrisson:
> The phyBOARD-Electra has two TCAN1044VDD CAN transceivers which
> support CAN FD at 8 Mbps.
> 
> Increase the maximum bitrate to 8 Mbps.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>

For both patches

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


> ---
>   arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> index 8237b8c815b8..522699ec65e8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -42,7 +42,7 @@ can_tc1: can-phy0 {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&can_tc1_pins_default>;
>   		#phy-cells = <0>;
> -		max-bitrate = <5000000>;
> +		max-bitrate = <8000000>;
>   		standby-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
>   	};
>   
> @@ -51,7 +51,7 @@ can_tc2: can-phy1 {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&can_tc2_pins_default>;
>   		#phy-cells = <0>;
> -		max-bitrate = <5000000>;
> +		max-bitrate = <8000000>;
>   		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
>   	};
>   

