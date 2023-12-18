Return-Path: <linux-kernel+bounces-3996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B77BC817675
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F1A1F250B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724853D568;
	Mon, 18 Dec 2023 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xZ9OGggt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88A3A1D4;
	Mon, 18 Dec 2023 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BIBNMin005423;
	Mon, 18 Dec 2023 16:57:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=8qvW327
	JWtzUxk62P/7MbSy0EvIsbaRHUR0tz6Gv+K4=; b=xZ9OGggtdcpVD6mAlStBNb3
	0YUcYfpIKrScqCsi72tEyovbLfZnpCeUmu74M8XB0VwpKnNjNlFJFRZMuTI3NgZV
	NJLfX8PyW5rdEeoHbE0QvexVglxF0ts5p8ar/CjsMPPzX9RejMmGMxs5DNp3LBRB
	FT0aQgHGCUx0xtdYZOuHIfMifHCeevrOT0sclVnkkWxXxWdCU2UYEpxNNvvIwTXL
	ltVMtpUu2dU3r9FnRqQKHn/doIWg4U5lHNySM6d2N1DenVOeEue3ob2rNQrmAi56
	vVwPV+KTxaJRNaUk54HGfpbsSPAkia7g9CEtzeHS1rVljhxngoy1i+ci4DUNU2Q=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v126ks3de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:57:32 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3115510005E;
	Mon, 18 Dec 2023 16:57:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 29B0E25F4AE;
	Mon, 18 Dec 2023 16:57:31 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Dec
 2023 16:57:30 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat
	<alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] spi: stm32: add support for stm32mp25
Date: Mon, 18 Dec 2023 16:57:12 +0100
Message-ID: <20231218155721.359198-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_10,2023-12-14_01,2023-05-22_02

This series adds support for spi bus found on the stm32mp25 and add
all instances within device-trees.

Alain Volmat (4):
  spi: stm32: use dma_get_slave_caps prior to configuring dma channel
  arm64: dts: st: add all 8 spi nodes on stm32mp251
  arm64: dts: st: add spi3/spi8 pins for stm32mp25
  arm64: dts: st: add spi3 / spi8 properties on stm32mp257f-ev1

Valentin Caron (2):
  dt-bindings: spi: stm32: add st,stm32mp25-spi compatible
  spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc

 .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 +
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  46 ++++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  88 +++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  14 ++
 drivers/spi/spi-stm32.c                       | 145 ++++++++++++++++--
 5 files changed, 280 insertions(+), 14 deletions(-)

-- 
2.25.1


