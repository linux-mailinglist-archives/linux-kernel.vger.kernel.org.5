Return-Path: <linux-kernel+bounces-160010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE908B37A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB7DB23206
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FFE147C64;
	Fri, 26 Apr 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2OVL/9e+"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADAB146A8E;
	Fri, 26 Apr 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136391; cv=none; b=t46V31ML+lWUeeSRohcSNvn/KM/CyTye6CVL9v9uaDtWEP7I9XXZVSwpq6Vm/4degs67IfWMiGJ7cLbWAEtcMtPrsHwXGsMBDN0Ec40kB536/r8NGQ/MivC+h7WWWn+XBJI/AMV+OnRDtqnI3gPPR+JRggbyE4g7B6iCyq3x4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136391; c=relaxed/simple;
	bh=ZxFJUIWX4TvIfLdPim81/AwMqb2DbXINuDtV5oNr/Lo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=olzAv5Jl5ORv1cAOWhF6H7mrkqNW0rlTmko+rQkGSWJCg4yYpg11qv75KYitePl5lSW8ePGYfPf3Z/sYWjjsXtwY/Egsc7lgvR6VfD4IRB4nJye5QvgcS0TaBQCMrgRwZ6Do4PmWW3KT4TI5k6k4dWQ54+4v7oZrYuOZtIIzgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2OVL/9e+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q9bYBw032401;
	Fri, 26 Apr 2024 14:59:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=82TTePM
	YeUp1fhEV5NgGPQLSJ7G6ou259POq1elrSMY=; b=2OVL/9e+vSzyhA5HF0B/8Iq
	xe3L1jK8NSsvNDWRSO97bVSs5e1V62MzdPGWiLy2RKqJXfqyegKXmCZNhDROnj7c
	Xitw6HLGG8t06OicTiBIMRSEb4ca11dqX5tbmgsIYD/iIscoZssnXHP5iN9IF5+Q
	JPqz0X84+xB7fL16PqgztpuMaT/1hIVF6b8OQjrjpT8ifXg5NO8kzwJY6QuwiShI
	71BrRnAfeSp35eKAUgtU1n5n4weFZCTOZsXlDlOTcrXNst1CqIwE2EbUt4DECacE
	WYy2PIZETzito+gTgaqrSXDZ4WWXrvXBd0yxF719nTNn8eN3tbQ2X2JEym72WTA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4kbhs8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:59:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 70A5140046;
	Fri, 26 Apr 2024 14:59:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1A53B222C9E;
	Fri, 26 Apr 2024 14:58:04 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:58:01 +0200
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
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/11] Series to deliver Ethernets for STM32MP13
Date: Fri, 26 Apr 2024 14:56:56 +0200
Message-ID: <20240426125707.585269-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

STM32MP13 is STM32 SOC with 2 GMACs instances
This board have 2 RMII phy:
  -Ethernet1: RMII with crystal
  -Ethernet2: RMII without crystal
Rework dwmac glue to simplify management for next stm32
Add support for PHY regulator

V2: - Remark from Rob Herring (add Krzysztof's ack in patch 02/11, update in yaml)
      Remark from Serge Semin (upate commits msg)

Christophe Roullier (11):
  dt-bindings: net: add STM32MP13 compatible in documentation for stm32
  dt-bindings: net: add phy-supply property for stm32
  net: stmmac: dwmac-stm32: rework glue to simplify management
  net: stmmac: dwmac-stm32: add management of stm32mp13
  net: stmmac: dwmac-stm32: update config management for phy wo cristal
  net: stmmac: dwmac-stm32: clean the way to manage wol irqwake
  net: stmmac: dwmac-stm32: support the phy-supply regulator binding
  ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
  ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
  ARM: dts: stm32: add ethernet1 and ethernet2 for STM32MP135F-DK board
  ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  79 +++++-
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  31 +++
 arch/arm/boot/dts/st/stm32mp133.dtsi          |  30 +++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  48 ++++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 235 ++++++++++++------
 7 files changed, 416 insertions(+), 79 deletions(-)

-- 
2.25.1


