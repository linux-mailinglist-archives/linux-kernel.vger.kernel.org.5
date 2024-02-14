Return-Path: <linux-kernel+bounces-65068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD7854767
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050BF28F5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459F18638;
	Wed, 14 Feb 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="EKClzF++"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552217543
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907344; cv=none; b=ouWRcPBorISuXJPDdIH3gH2jOPn9KqvedaK7RS505CEhNIr71pAPblkVG3tL+K+NNV4JkdZJNMb1Cy9yPLuVuGiV6dmnrpbhdSI340IxB5FWqys4ETqNQzSdScXiJ1DmAoowxrEwNnTMgmtdT0xjmbECUabJ9H+kmSL1Bt+3W/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907344; c=relaxed/simple;
	bh=6ZsuriBMCohN5uvava8Z+HPI6zdzB9t2C5NoARUcrA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dkR+d/dPqYJYdVd/deZSFW0HGapO3PHSlG/uZr6ies7t3I+5rVfG+e+rJnmMPzQPPQ1UIYS6z1266VcFLFiKwYmsXVftegmAfBMoUYESUMASbdZYyRtm/Sym51Q7Zw+n2rR08f6/O7T2yAWVGg3SIAV2sv88TuqKrBEdOBQ2E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=EKClzF++; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1707906416; x=1710498416;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ZsuriBMCohN5uvava8Z+HPI6zdzB9t2C5NoARUcrA0=;
	b=EKClzF++kzDneUpOxjj1LNg3J7VxxTXQ1o2BclCJuH+nZuex6qvYbqRLUhHQURHE
	fHbhCbzIt9u5NVU8Aq6dJNxUdppaCcyGYiwYhaXKUMJrc8h0EX55Hhat7JA/Nm70
	ZMiAtmvOfIVosah5kf6esFDJuGIvP+3nQkxu/SmCz6s=;
X-AuditID: ac14000a-fbefe7000000290d-ac-65cc9570d89d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1F.75.10509.0759CC56; Wed, 14 Feb 2024 11:26:56 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 14 Feb
 2024 11:26:53 +0100
Message-ID: <6c8feafd-a34c-4c7b-b6cd-4cd73b086259@phytec.de>
Date: Wed, 14 Feb 2024 11:26:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Fix MMC properties on Sitara K3 devices
Content-Language: en-US
To: Judith Mendez <jm@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
References: <20240213235701.2438513-1-jm@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240213235701.2438513-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWyRpKBR7dg6plUg6VrDC3W7D3HZDH/yDlW
	i7tLfzJafPqQabH882x2i74XD5ktNj2+xmpxedccNos3P84yWbTuPcJu8f/sB3YHbo9NqzrZ
	PO5c28PmsXlJvcfxG9uZPDa98vD4vEkugC2KyyYlNSezLLVI3y6BK2Piu+ksBU+lK9rmHGBq
	YDwm1sXIySEhYCLxY/lk5i5GLg4hgcVMEj9777NAOHcZJY7OOMLWxcjBwStgI/Hppz9IA4uA
	qsStbQeYQGxeAUGJkzOfsIDYogLyEvdvzWAHsYUFnCXubm0CizMLiEvcejKfCWSmiMACRolD
	h3eBOcwCrUwSDxpegnUICRhIXFjeBmazCahL3NnwjRXE5hQwlDjQ8YoZYpKFxOI3B9khbHmJ
	7W/nMEP0yku8uLScBeIdeYlp514zQ9ihEkc2rWaawCg8C8mxs5AcNQvJ2FlIxi5gZFnFKJSb
	mZydWpSZrVeQUVmSmqyXkrqJERRvIgxcOxj75ngcYmTiYDzEKMHBrCTCO6n3TKoQb0piZVVq
	UX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGxqm8zgXHL4tPYOsLX1S3
	u+HMP82oI+fnvb1acU04xvphn8SNlf4egQ82Z2r96LJoFvtSv8Xp0eOGo5vdPZvUbQJLSj5m
	cjM4fJt1b3Z8zvnL+zfq2jJL/Iiwy3Z1iwmYeDn5um3RkTdf7gvkJG7gtb6c6Pa5LqeVO8hH
	z39//PN31+TfnT/drMRSnJFoqMVcVJwIAEHTlw2lAgAA


Am 14.02.24 um 00:56 schrieb Judith Mendez:
> This patch series aims to fix and update MMC nodes for TI
> Sitara K3 devices with the following changes.
>
> The series introduces sdhci0 and sdhci2 nodes and enables
> eMMC for AM62ax platform.
>
> Also introduce fixes for MMC ITAP/OTAP values for AM64x
> platform according to device datasheet [0], and add ITAP/
> OTAP values for AM62p to enable the highest timing possible
> for MMC0 and MMC1, according to device datasheet [1].
>
> The DLL properties ti,trm-icp and ti,driver-strength-ohm
> should be removed for soft PHYs since drive strength cannot
> be changed, so remove these properties when not applicable.
> Since this fix touches non-TI boards and therefore cannot be
> tested, all tested-by's are welcome.
>
> Also include a few fixes for ti,clkbuf-sel, bus-width,
> and bootph-all device tree properties in MMC nodes.
>
> This series was tested on:
> - AM62a SK
> - AM62x SK
> - AM62p SK
> - AM64x GP EVM
> - AM64x SK EVM
> - Beagleplay

Adding my Tested-by for the phyBOARD-Electra-AM642 board.

Tested-by: Wadim Egorov <w.egorov@phytec.de>


>
> [0] https://www.ti.com/lit/ds/symlink/am6442.pdf
> [1] https://www.ti.com/lit/ds/symlink/am62p.pdf
>
> Fixes since V2:
> - Remove ti,driver-strength-ohm property in sdhci1 node for
>   k3-am642-tqma64xxl-mbax4xxl and k3-am642-phyboard-electra-rdk board files.
> - Add Francesco's Acked-by
>
> V2: https://lore.kernel.org/linux-devicetree/20240213002416.1560357-1-jm@ti.com/
> V1: https://lore.kernel.org/linux-devicetree/22af7436-8833-4049-bdbb-f79bb3314ee8@ti.com/
> RFC: https://lore.kernel.org/linux-devicetree/c94b7399-31c0-4e7d-a616-8f29c86a27ba@ti.com/
>
> Judith Mendez (7):
>    arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
>    arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
>    arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
>    arm64: dts: ti: k3-am6*: Remove DLL properties for soft PHYs
>    arm64: dts: ti: k3-am6*: Fix ti,clkbuf-sel property in MMC nodes
>    arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
>    arm64: dts: ti: k3-am6*: Add bootph-all property in MMC node
>
> Nitin Yadav (2):
>    arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
>    arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
>
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 12 +++--
>   .../boot/dts/ti/k3-am62-phycore-som.dtsi      |  1 -
>   .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    |  1 -
>   .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi |  1 -
>   .../boot/dts/ti/k3-am62-verdin-wifi.dtsi      |  1 -
>   arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |  2 -
>   .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  4 --
>   .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     |  1 -
>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 45 ++++++++++++++++++-
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 27 ++++++++++-
>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 44 ++++++++++++++++--
>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  3 +-
>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 -
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 15 +++++--
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  4 +-
>   .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |  1 -
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  2 -
>   .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    |  1 -
>   18 files changed, 129 insertions(+), 38 deletions(-)
>
>
> base-commit: 1e6bbc5185bcd113c8d2f7aa0a02f588a6bdbe5d

