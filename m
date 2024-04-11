Return-Path: <linux-kernel+bounces-140667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09378A178A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008E81C21129
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953817BCF;
	Thu, 11 Apr 2024 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="X+rnlLe8"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B67E556;
	Thu, 11 Apr 2024 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846344; cv=none; b=cIvCldgiW5vt2g0JHKBKlyGOoEEiK+hrCPai1oV9TduKvGVLW9uMvz27/l+5XNaRibVzXBTfhT9XWLKx4rZYD03Js+aflO9s5UmG2xrrnb7ZaxAeQ3NNeRcIle8E8Bi92QOipavTp49+sgBipxtYpEkrjLBXJVuXSE3x9oIFYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846344; c=relaxed/simple;
	bh=7bY6nOkOAlF1gyhNvUOhk5vTC8tNW8cjWAcSwtGF6BU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KqidGHKD5bN+OhZxYJUjj44LYESIUTZQ/WbAXoUH88V/HeZHcOA6xlBIXUDcKjwzH6ukdNJashzlZ/ZaRejjBEM7q+yxkoiRaFSQxZujunIN5BuZihL70BwgzoiacW52bONC96pd1K6F741aBKPQiufUyNOCsvwTXv19LMd/w8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=X+rnlLe8; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BCl6W4029833;
	Thu, 11 Apr 2024 16:38:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=R3t6i2R
	wKT1qwlckR/vo2LKwYj9pYC+YLWuQmMNxUu0=; b=X+rnlLe89rFmtVYeXFgY67M
	2U85EeIgO+B9edFEsgxK1mrRyOpWRbZV78aVfR14J/4hZPcYAmLnQJWxY22H77Ss
	oO9qBSfrnxSLXPGhN/g41E5nDLOQfl6m3/EBYfZDQaFKicom1yH25EGbyYlnpzg5
	bcLCLofjGy4NMBgX6gQ3OrFaLS3fJ4DVKpi0OB6xTFW+mQam6BJRa+7UA7QQBRDR
	DWUo5lnNmiWDyttYGRIIbCSvqACUgZNK1CoDB8EE02FkjJyXQ9/jvbXueF95ypxO
	QV2UcMOl/TNq3Kj6+lsAfs6QwQV/PEnVPwrAxACyvSrs+FqejCgEwctSZeSjplQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbfy13qxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:38:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 64CCD40044;
	Thu, 11 Apr 2024 16:38:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BE42A21BF52;
	Thu, 11 Apr 2024 16:37:21 +0200 (CEST)
Received: from localhost (10.48.86.106) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 16:37:21 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/11] Series to deliver Ethernets for STM32MP13
Date: Thu, 11 Apr 2024 16:36:47 +0200
Message-ID: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02

STM32MP13 is STM32 SOC with 2 GMACs instances
This board have 2 RMII phy:
  -Ethernet1: RMII with crystal
  -Ethernet2: RMII without crystal
Rework dwmac glue to simplify management for next stm32
Add support for PHY regulator

Christophe Roullier (11):
  dt-bindings: net: add STM32MP13 compatible in documentation for stm32
  dt-bindings: net: add phy-supply property for stm32
  net: ethernet: stmmac: rework glue to simplify management for next
    stm32
  net: ethernet: stmmac: add management of stm32mp13 for stm32
  net: ethernet: stmmac: stm32: update config management for phy wo
    cristal
  net: ethernet: stm32: clean the way to manage wol irqwake
  net: ethernet: stmmac: stm32: support the phy-supply regulator binding
  ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
  ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
  ARM: dts: stm32: add ethernet1 and ethernet2 for STM32MP135F-DK board
  ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  83 ++++++-
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  31 +++
 arch/arm/boot/dts/st/stm32mp133.dtsi          |  30 +++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  48 ++++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 235 ++++++++++++------
 7 files changed, 421 insertions(+), 78 deletions(-)

-- 
2.25.1


