Return-Path: <linux-kernel+bounces-30343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F65831D54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786A4B25DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C22942A;
	Thu, 18 Jan 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RQ+1uv5x"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE892E3E8;
	Thu, 18 Jan 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594478; cv=none; b=HN0uaRFNpYLrAYAwuIiX9hxIweqehA5gvMAQsdTJQAAPcPTaGA2gF0gwu2/VHqwdkWwVWu1YbwwZD0e6i8BC9/3zQK9KogDb5/Nfyl1lmfYEnBSeQy+FLDjl1ln5XqrO5aOM7kLNRhLoeuN0fiG2xmUP/eeZytIgkTBSCqIhbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594478; c=relaxed/simple;
	bh=OWJUIlewldnhlZ2AChJ/wqce0X7gESh3qoR1yipsHrM=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=mZZFicBqPi2/xoq3r34H+PzPPbIwUod47ItOP9g5SfOKUPZFEFeBGiN+SMC1OjsHl4wuI/VkUalKfGexijaCltZoMyWKlI0NxvLtjqAtUfk/p51BUH6TS3lOso8ygUQICE45J5B3kvpJ6htKiQjb6QU4qCFdS5NU+qZOwNi6aB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RQ+1uv5x; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40IGEIXt054990;
	Thu, 18 Jan 2024 10:14:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705594459;
	bh=O+AzhLX1Qjz+NgbNfuUYk2TlA6YH0ew00AyhB6CMsZU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RQ+1uv5x0K/hjJoCY1DZHu7rVt2cbqnK/UTnqP0CpjE4+LMBg80mK2/80QcNx0UI5
	 PRV1DyfKlGHCsy9MYo8ioT7gYNOdUxF2fDKE+o/L3bIWwJ+SDEy3nsZ4I4T2Zfy00j
	 ZHsuWtY/ZJ8HVC+M7j5RbmYnl1ZjlYH9iM4HqRJI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40IGEIW6014540
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 10:14:18 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 10:14:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 10:14:18 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40IGEHix097023;
	Thu, 18 Jan 2024 10:14:17 -0600
Message-ID: <eaa10f7c-4c8e-4330-b156-8f0edbdaabdf@ti.com>
Date: Thu, 18 Jan 2024 10:14:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arm64: dts: ti: k3-j784s4-main: Convert
 serdes_ln_ctrl node into reg-mux
To: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        <tony@atomide.com>
References: <20240118094454.2656734-1-c-vankar@ti.com>
 <20240118094454.2656734-2-c-vankar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240118094454.2656734-2-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/18/24 3:44 AM, Chintan Vankar wrote:
> This removes a dependency on the parent node being a syscon node.
> Convert from mmio-mux to reg-mux adjusting node name and properties
> as needed.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index f2b720ed1e4f..56c8eaad6324 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -52,12 +52,12 @@ serdes_ln_ctrl: mux-controller@4080 {
>   			compatible = "reg-mux";

Seems this was already a "reg-mux", so the commit message is a bit
off, you are not converting from "mmio-mux" here.

Thinking about this, if this was already a "reg-mux" then this node
was likely broken by my reg-mux update as it doubles the offset (reg
is offset 0x4080 which adds to the already offset in masks). I did
check for this before sending my patch, but seems this one node
was added after I sent it, but before it was taken. Re-checking
this is the only instance of this issue, and this patch fixes the
issue.

So you should reword the commit message to include that this is
actually a fix and add:

Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")

looks good to me otherwise:

Acked-by: Andrew Davis <afd@ti.com>

>   			reg = <0x00004080 0x30>;
>   			#mux-control-cells = <1>;
> -			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> -					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
> -					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
> -					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
> -					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
> -					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
> +			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
> +					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
> +					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
> +					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
> +					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
> +					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
>   			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
>   				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
>   				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,

