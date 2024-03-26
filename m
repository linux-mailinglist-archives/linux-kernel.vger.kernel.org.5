Return-Path: <linux-kernel+bounces-119026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B1788C2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAC41C3F1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBFF71B5D;
	Tue, 26 Mar 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="iLzYSNvJ"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573864A9F;
	Tue, 26 Mar 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458063; cv=none; b=idDxYYVIrbD9qmnigleKl+A4gnNsPkadhVj4d9f1360BgZPqUm/F6jQ2+/pJiMtiyiB1XZvWRtVaRmIiVwgtiw0OsemvD5etpxoLwego5iC6IBpklpEsOrcqhUJez9JcPZ6ONV3zlgkX+QBNbwp96nIszSUjoW9R/D4IktPPQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458063; c=relaxed/simple;
	bh=xxvJRawpyW3eNtN94M248HISBAJChQIwETjY8F6DX1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bqab7a8C0Qt6BC2u5/dcjiFt/nEgruPQHvFlVgWhphjO2NERnH8EEJJKYA5SAoKoUBv4d1vPWHuQBvbwXo0GQQiCOg0vaiaYLIrIN9djYu7ls/siF8ruDom8lK0NahGYUhKjt9pB3wxO9EYpwdLeQt/Or/7RaKucwz+ay2aaQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=iLzYSNvJ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QCwvYX028115;
	Tue, 26 Mar 2024 14:00:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=/db77bR
	vEP4jYO3usvNHt4toe1IvRseqPMS2T/ZuErE=; b=iLzYSNvJlosukfvG0AizBaJ
	amhux4Y0xAOTGcwKMIGIldiS2vmsAffVQWAHScZED21qjfYoLBCsKlTmzRoJQN8U
	bHiCo/e1lHcbEHug0PbnrAp9BLrXLA1cicH2P8iQ7FK2KPgyouynX081Yr25Nhju
	6WCOzZi2WIAXeEFCeVnSOdmPUJtyM+9SMtp6rN6nr7TLXiCpvKk8Nq31vgL8dm2r
	1uxhTSbZSsS6W8RuqZlMav9wzdfvUCc8OfLLIVYz3Dn6Gyh7Rz66vP4O9+le1TYK
	+rMLTIoNCA34RBsgD0xAvBwGN1HUJcLaUa3NmMu0NWikKZANvBj4jiV7CBCbLoQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1n39dgf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:00:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1BEBD40048;
	Tue, 26 Mar 2024 14:00:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 04788218631;
	Tue, 26 Mar 2024 13:58:56 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Mar
 2024 13:58:55 +0100
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
Subject: [PATCH v4 0/2] Add properties in dwmac-stm32 documentation
Date: Tue, 26 Mar 2024 13:58:47 +0100
Message-ID: <20240326125849.226765-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02

Introduce 2 new properties in dwmac-stm32 documentation

 - phy-supply: to manage PHY regulator.
 - st,ext-phyclk: is present since 2020 in driver so need to explain
   it and avoid dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb: 
ethernet@5800a000: Unevaluated properties are not allowed 
('st,ext-phyclk' was unexpected)
   Furthermore this property will be use in upstream of MP13 dwmac glue. (next step)

V2: - Drop deprecated: property for st,eth-clk-sel and st,eth-ref-clk-sel
V3: - Rework commit message
V4: - Fix syntax issue in commit message

Christophe Roullier (2):
  dt-bindings: net: add phy-supply property for stm32
  dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk

 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.25.1


