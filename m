Return-Path: <linux-kernel+bounces-32287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C26583597C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72501F22192
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5847217FF;
	Mon, 22 Jan 2024 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="os1gMFEc"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929DE15BA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892076; cv=none; b=h4VxLaLqqouBjCQ9Qo67H+JbzWri06JeWoJ8Qf2/Kl/3/NVcrjXhK82fbrqe7TeAm7eN5Ki6pSoBj40xPMGnXA4xUxuFQTgcOHApUVaCp/dx+N3CATa9jOnHXlfnqyQKsFlPeTJUMQT5s4SzcLg+9BBKoe8DoySGy/M9P3vAgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892076; c=relaxed/simple;
	bh=mfYD+6v6kk8wYnHrbApXUiZA7Uz73G+QjKzVKWVBrE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R/WV/VRfboP5yQU8tNSHjGs6+hRFMzZ68ostha73FJvugkS5nQdQ7tK93tCCbMDqGEwrKNCktePkr7HS0q+UjiBkWoIaZbY2Ab//wGQGFv9UlagThF2tnP8Kr8AwkVF2CnKQPB3iY6g2qUwMOmpe2uxe5aynUKeSfLhAtoVX0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=os1gMFEc; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705892072; x=1708484072;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mfYD+6v6kk8wYnHrbApXUiZA7Uz73G+QjKzVKWVBrE0=;
	b=os1gMFEc7p7kxIpbZdaNE0ffEfWybcOwIWl+Gtua2Vrs6Iq6r/qlCPqIRLAkC9/W
	WqFrvAg/SW0fEthainPJ7TP8Acp9FI1r5ECytO1PJcTw6Z0XiNT+NEuhxzmodwfQ
	7UY67TAqHc+UqhF+T4k43h7+obvDp7niAyaIMfUyce0=;
X-AuditID: ac14000a-fadff7000000290d-4f-65add8e7c9f0
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1C.EF.10509.7E8DDA56; Mon, 22 Jan 2024 03:54:31 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 22 Jan
 2024 03:54:27 +0100
Message-ID: <9a5711b6-5e8e-4fcb-bea6-d5f9893762eb@phytec.de>
Date: Mon, 22 Jan 2024 03:54:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: Disable clock output of the ethernet PHY
Content-Language: en-US
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <upstream@lists.phytec.de>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240119225257.403222-1-nmorrisson@phytec.com>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240119225257.403222-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWyRpKBR/f5jbWpBm1tphZr9p5jsph/5Byr
	xfLPs9kt+l48ZLbY9Pgaq8XlXXPYLN78OMtk8aFxM5tF694j7Bbd79Qt/p/9wO7A7bFpVSeb
	x51re9g8Ni+p9+jvbmH1+HPxHavH8RvbmTw+b5ILYI/isklJzcksSy3St0vgyrhzez97QRNH
	xYWXB1gbGB+xdTFyckgImEjcfbmXqYuRi0NIYDGTxOStr1ggnLuMEme3/QSq4uDgFbCRWL7I
	HKSBRUBV4tzHNiYQm1dAUOLkzCcsILaogLzE/Vsz2EFsYQFfiQfLVzCC2MwC4hK3nswHWyAi
	sJ1RYs3iRcwgDrNAG6PEgw3dYGcICVhLbN7SANbNJqAucWfDN1YQmxNo8ffu26wQkywkFr85
	yA5hy0tsfzuHGaJXXuLFpeUsEO/IS0w795oZwg6V2PplO9MERuFZSI6dheSoWUjGzkIydgEj
	yypGodzM5OzUosxsvYKMypLUZL2U1E2MoNgTYeDawdg3x+MQIxMH4yFGCQ5mJRFeftVVqUK8
	KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoYl/6UPXZwX6LE
	789eMhbNcR1OhTke5yJ2Wb35u0Wp5LHN+vYjH6f0F5qy/Lly9sXnlmsZ1bnB/RP794gFe3/R
	ZH0f0xCQzPqEc3fn31jV3Bnr4wWats0StgyZmL7i1e3q61yH7/upG7hW8iyw/r5ni2/1MnbR
	ezGFnbdnzstbIWvy6POVRZXzlViKMxINtZiLihMBuMx4BasCAAA=


Am 19.01.24 um 23:52 schrieb Nathan Morrisson:
> The clock on the ethernet1 PHY is turned on by default. This turns
> the clock off as we do not use it.
>
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


> ---
>   arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> index 4bc0134c987d..3173f6eca7ca 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> @@ -222,6 +222,7 @@ &cpsw3g_mdio {
>   	cpsw3g_phy3: ethernet-phy@3 {
>   		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
>   		reg = <3>;
> +		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
>   		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>   		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>   	};

