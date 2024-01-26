Return-Path: <linux-kernel+bounces-39728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E6683D577
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB5F28512A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982866341C;
	Fri, 26 Jan 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="HY+hVYQc"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC35D745
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255803; cv=none; b=C9uJQPXdVAlz0UJIZyT2aRP9Mny+uFH1p5wl+iI/8oy9QhExgFGcn+FT6mp/5wcsaQuFstIMlzpTDvXd7ijDfCl/1WlDvrZ31X8fG+XSyCnDLOtGaL821S9Ft6Ina1CpXYeba2VVUhvadWceODmq/nlclcmXE+dBlunKZCdNe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255803; c=relaxed/simple;
	bh=SGlkjOF0x1E5rB8ZCRFzqb+92VKR/RyFWfynYGQYX6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ghatFatuLlL9lT51R1QAZxmRBZbLRRdsvLORB1MUOZrFbL/ARlOHaNrOIve0Tc0tPYNwzPm5Cm57vcCMweN3GoEPivDGt1XS/HhBoaUdpbA2LobIIHb9WuvC3WGvvv+0mUQ7ZUHbPbxu70LZqXNZ+Stl1d4+q1nmzgl1R77iQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=HY+hVYQc; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706255789; x=1708847789;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SGlkjOF0x1E5rB8ZCRFzqb+92VKR/RyFWfynYGQYX6Y=;
	b=HY+hVYQcokiEIHMgXF9ka+mMTh6oXqSH+HGZVCHoBxCU6DnPl1QHSQ6Dn4sccftY
	e3M2tm+aztgE/2QGnlVBMBFr+uUk8lo3xVpTcOqh9+XxC36QEiUY/GAD7uHTkkR+
	5qZUxL2fj+N48zx6hXdlSfS+8qjSg7mvMycH/P6zWgM=;
X-AuditID: ac14000a-fbefe7000000290d-85-65b365adcc29
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A6.89.10509.DA563B56; Fri, 26 Jan 2024 08:56:29 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 26 Jan
 2024 08:56:26 +0100
Message-ID: <b63056c1-0554-4514-8cba-896d1274246a@phytec.de>
Date: Fri, 26 Jan 2024 08:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and
 wakeup R5FSS nodes
Content-Language: en-US
To: Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<u-kumar1@ti.com>
References: <20240121134017.374992-1-vaishnav.a@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240121134017.374992-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWyRpKBR3dt6uZUgzPPxSzmvjnAarFm7zkm
	i/lHzrFaLP88m92i78VDZotNj6+xWlzeNYfN4s2Ps0wWrXuPsFtM2zuD2eL6jylsFv/PfmB3
	4PHYtKqTzePOtT1sHpuX1Hscv7GdyePzJrkA1igum5TUnMyy1CJ9uwSujLZtvUwF+wUqOjsX
	sjUwnuXtYuTgkBAwkXjYI9PFyMUhJLCYSeL+rDWsEM5dRonmGb+BHE4OXgEbiY37DrCBNLAI
	qEr8um4LERaUODnzCQuILSogL3H/1gx2EFtYIE5iUussMJtZQFzi1pP5TCAzRQQ2MUq8frGY
	BSLRwyixc6oniC0kYC4xZW8PM4jNJqAucWfDN7C9nAIWEjsfzmODqLeQWPzmINRQeYntb+cw
	Q/TKS7y4tBxspgSQPe3ca2YIO1TiyKbVTBMYhWchuXUWkptmIRk7C8nYBYwsqxiFcjOTs1OL
	MrP1CjIqS1KT9VJSNzGC4k2EgWsHY98cj0OMTByMhxglOJiVRHhNTDemCvGmJFZWpRblxxeV
	5qQWH2KU5mBREudd3RGcKiSQnliSmp2aWpBaBJNl4uCUamDktN615qH1hqeNQVH72oy+vmEQ
	j047vjTGJtE+cOc0a/F/f4984BZKP6v/6G7K+dfvGA8XrN/yfOqz63pqE/KKt5b8uP5LoN7k
	gZ74rOqSO0EWYrmO2wwaOIpXTOyP9oufzjBZdI2p8CdpqfJEuYWVes8W7VvgNvu8dtgsf5XP
	Kx9tmuWa29SgxFKckWioxVxUnAgASvOwYqUCAAA=


Am 21.01.24 um 14:40 schrieb Vaishnav Achath:
> K3 Remoteproc R5 driver requires reserved memory carveouts and
> mailbox configuration to instantiate the cores successfully.
> Since this is a board level dependency, keep the R5 subsytem
> disabled at SoC dtsi, otherwise it results in probe errors like
> below during AM62P SK boot:
>
> r5fss@79000000: reserved memory init failed, ret = -22
> r5fss@79000000: k3_r5_cluster_rproc_init failed, ret = -22
> r5fss@78000000: reserved memory init failed, ret = -22
> r5fss@78000000: k3_r5_cluster_rproc_init failed, ret = -22

Shouldn't we have a similar patch for the am64 R5 cores?


>
> Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    | 2 ++
>   arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> index c4b0b91d70cf..14eb9ba836d3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> @@ -187,6 +187,8 @@ mcu_r5fss0: r5fss@79000000 {
>   		ranges = <0x79000000 0x00 0x79000000 0x8000>,
>   			 <0x79020000 0x00 0x79020000 0x8000>;
>   		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +
>   		mcu_r5fss0_core0: r5f@79000000 {
>   			compatible = "ti,am62-r5f";
>   			reg = <0x79000000 0x00008000>,
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> index 19f42b39394e..10a7059b2d9b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> @@ -78,6 +78,7 @@ wkup_r5fss0: r5fss@78000000 {
>   		ranges = <0x78000000 0x00 0x78000000 0x8000>,
>   			 <0x78100000 0x00 0x78100000 0x8000>;
>   		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>   
>   		wkup_r5fss0_core0: r5f@78000000 {
>   			compatible = "ti,am62-r5f";

