Return-Path: <linux-kernel+bounces-68360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1FE85793D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70364285E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD691CA82;
	Fri, 16 Feb 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="T9ir6dnx"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739761BC26;
	Fri, 16 Feb 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076974; cv=none; b=Am0esGmXJOmk0eZFsP0owePZMiDnDMtEWr7sC8l91CqF+CEZ4H1sOxl6wqXFUyY2G3Gn09DgSWWQqmxfyDqWtA+Gg9OshMDBC25BmAUIJNEaxc5LzN4L2uUI1Xl9gICaJnpAGAPjQrpEb/hbL0TPkHcec3dWsU20BOeO7X+UOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076974; c=relaxed/simple;
	bh=vkcf7in+HHvF7wODXOGKQNfcfhTdMHKm+z/DnZUTeD0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=chY7s9KmqTJ4y2Tz5rEkbPIzQb12f4ipdKKuK34J0Io4HiF7YGselSMVS1ogWrVpbrZeEP/5SynMKyFDcKoJvTah4IuU3elNhEL+JdREVrs7nIDQ+pdGlMLgzVBK7DYQm9Vd4RcvNCJIvyhv7qnrvlEJWAYZ8ExSRnxI1kQoOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=T9ir6dnx; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4ppm2024161;
	Fri, 16 Feb 2024 10:49:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=z/h6EJe
	qC1Av5YLNEHSAWiHso3gB+EOTqFg4TUwvKR0=; b=T9ir6dnxGhQ8vE+QMPws/4w
	0pyqUjVl4F/LLgp09kkzahj1LF7hmg0CGJsCrhqjginRLSxsDS62+9etuHKChLHN
	+jXd7+MZrqFAnGibzEfMVJ7cA2shGfmWDSBhy104TDpm1XJcf3q9NgD3RrYz9LSL
	YGGD34Q4hFgDhDGzrq3SdJIsKljfZ0OM6NeyxXgiY4IKsUO4xkQdJ+T9BfmAJv/R
	9Bu6o9UnaP9GjY4kRoE0OSV6yrlmqEAns4qgMISSUFlrEVrxqzOGOfYzxP/ZKkxj
	jPE9eY6O0uqs+GNHmSMCEpn0A83pUH0ELq5UkRrfEES+vst7AINnduFxyTQ28CA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa126gy3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:49:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5D1B040045;
	Fri, 16 Feb 2024 10:48:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 045F1237D6D;
	Fri, 16 Feb 2024 10:48:17 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:48:16 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 00/12] irqchip/stm32-exti: add irq-map and STM32MP25 support
Date: Fri, 16 Feb 2024 10:47:45 +0100
Message-ID: <20240216094758.916722-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02

This series adds support for STM32MP25 to stm32-exti driver.
The STM32MP25 includes two instances of the EXTI irq controller,
each mapping their EXTI events to different GIC irq sets.

In the current driver code, the mapping between events and irqs
would require adding to the driver two new compatibles and two
new mapping tables for this new SoC. This way of working starts
showing it's limits; it doesn't scale and is not flexible.

This series introduces an optional nexus child node to the EXTI
DT node. The nexus node provides the mapping between events and
irqs through the standard "interrupt-map" property, thus moving
in the DT the description of the HW connections between the EXTI
and the GIC.
Being the nexus child node optional, it guarantees the backward
compatibility with all the existing DT for STM32MP1xx.
Nevertheless the series updates and uniforms the existing DT by
adding to them the nexus child node too.

The DT node for the GIC of STM32MP25 is already upstream with:
	#address-cells = <1>;
This value needs to be updated to <2> because the SoC uses 64 bit
addressing and the v2m child node of GIC requires 64 bit address
too.
This minor change to the GIC property "#address-cells" impacts
the contents of the "interrupt-map" property.
This series also anticipates the addition of the v2m child node
to the GIC, thus avoiding any further rework.


Antonio Borneo (11):
  irqchip/stm32-exti: Fix minor indentation issue
  dt-bindings: interrupt-controller: stm32-exti: Add irq nexus child
    node
  irqchip/stm32-exti: Map interrupts through interrupt nexus node
  irqchip/stm32-exti: Convert driver to standard PM
  irqchip/stm32-exti: Skip secure events
  irqchip/stm32-exti: Mark events reserved with RIF configuration check
  arm64: Kconfig.platforms: Enable STM32_EXTI for ARCH_STM32
  ARM: dts: stm32: Use exti interrupt-map on stm32mp151
  ARM: dts: stm32: Use exti interrupt-map on stm32mp131
  arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251
  arm64: dts: st: Add interrupt parent to pinctrl on stm32mp251

Christian Bruel (1):
  arm64: dts: st: Add v2m to GIC node on stm32mp251

 .../interrupt-controller/st,stm32-exti.yaml   |  42 ++++-
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  49 +++++-
 arch/arm/boot/dts/st/stm32mp151.dtsi          |  51 ++++++
 arch/arm64/Kconfig.platforms                  |   1 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 154 +++++++++++++++++-
 drivers/irqchip/irq-stm32-exti.c              | 148 ++++++++++++-----
 6 files changed, 397 insertions(+), 48 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


