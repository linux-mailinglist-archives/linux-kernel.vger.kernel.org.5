Return-Path: <linux-kernel+bounces-145296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673088A523B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB5A1C22946
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AACC74416;
	Mon, 15 Apr 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NPCDyNDp"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443D73189;
	Mon, 15 Apr 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189063; cv=none; b=KqTPr9zrQQrFgPGjjQGfqFV3gUQ99qBvjUkky0I1lnj8YUAgV/nwYXIhaDlpnpn2A5xcckPyMMrMjktJhvTluNOS5+dGSWkTcagSenbeqDyKFb0ASmztLaCSs1pJv/qv4yqh+wRfoHdt1pxNO5OAJ2w6l7Bnpa0hZrB8aDvBWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189063; c=relaxed/simple;
	bh=W79q4qRfqlKNo5W8Cdm9qxtElWftePm7dFAR/qWZgKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6Mm+FK9JCOhxh5Ca19cg6CnOdyOKcSJqOa/nCG+xAxMaiG3xIuFRq1oYt2dBuM5PpZtMZ/N9nayK9Kllr9CB6NIURB/m5w2yG8IPCbD6BUS5SSmNoJtnRCFDPEcxBLXDzsDRbj7wx+h2o0cPujJa4RRYvS/vVYmf651Yx/0YRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NPCDyNDp; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FBtmV0029563;
	Mon, 15 Apr 2024 15:50:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=oW6KADp3Fq37auFWfzFF4pZHgphtK8RdSAeuAIKLbFQ=; b=NP
	CDyNDpkhIwvhEv57YXyictHa+mehydSkp7PN4N7SvlUzLkI5/3Al4VOPmqyYvkRO
	JpTvlCgNcy81K5aJurWmFRuGLmJTTS3ujAkG6OdSgSSBMhzLr7CDC1JZQooubUHs
	tBM5Wu24BYVtald9HVGRBEIwAi+lCp81U2O4eOhbxxcVopS69fU9Nnhx1xF12Z1b
	FKk4+EmAch06judREwPItPG78kUBLyCT4qb/z7KtLFc2z55YKaY+O9XfYsQ/iP1O
	T488+xBp8o5H04pQCz0avHsJLtlEij7eyoPbTX5TgzBEN0WHzemaor3c8P/TSSti
	W1F3uDUt2daT4RGAV7QA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecy4eq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:50:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 16EA54004A;
	Mon, 15 Apr 2024 15:50:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C499D218627;
	Mon, 15 Apr 2024 15:49:43 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:49:43 +0200
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
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 00/11] irqchip/stm32-exti: add irq map in DT and STM32MP25 support
Date: Mon, 15 Apr 2024 15:49:15 +0200
Message-ID: <20240415134926.1254428-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216094758.916722-1-antonio.borneo@foss.st.com>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
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
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02

This series adds support for STM32MP25 to stm32-exti driver.
The STM32MP25 includes two instances of the EXTI irq controller,
each mapping their EXTI events to different GIC irq sets.

In the current driver code, the mapping between events and irqs
would require adding to the driver two new compatibles and two
new mapping tables for this new SoC. This way of working starts
showing it's limits; it doesn't scale and is not flexible.

This series uses the optional DT property interrupts-extended to
provide the mapping between EXTI events and GIC irqs, thus moving
in the DT the description of the HW connections between the EXTI
and the GIC.
Being the DT property interrupts-extended optional, it guarantees
the backward compatibility with the existing DT for STM32MP1xx.
Nevertheless the series updates and uniforms the existing DT by
adding to them the property interrupts-extended too.

At last, this series enables GPIO irqs on STM32MP25 by using the
new exti node as interrupt parent of the pinctrl nodes.


V1 -> V2
- Switch away from the clever abuse of interrupt-map to a more
  humble use of interrupts-extended.
- Drop the addition of the v2m child node in GIC, as it is not
  anymore required in this series.
- Drop Fixes tag on trivial whitespace cleanup.
- Fix S-O-B chain.
- Move the variable's declarations in the condition block where
  they are used.
- When appropriate, change/use uniformly in the commit messages
  the terms s/exti/EXTI/ and s/interrupt/event/ .


Antonio Borneo (11):
  irqchip/stm32-exti: Fix minor indentation issue
  dt-bindings: interrupt-controller: stm32-exti: Add irq mapping to
    parent
  irqchip/stm32-exti: Map interrupts through interrupts-extended
  irqchip/stm32-exti: Convert driver to standard PM
  irqchip/stm32-exti: Skip secure events
  irqchip/stm32-exti: Mark events reserved with RIF configuration check
  arm64: Kconfig.platforms: Enable STM32_EXTI for ARCH_STM32
  ARM: dts: stm32: List exti parent interrupts on stm32mp151
  ARM: dts: stm32: List exti parent interrupts on stm32mp131
  arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251
  arm64: dts: st: Add interrupt parent to pinctrl on stm32mp251

 .../interrupt-controller/st,stm32-exti.yaml   |  17 +-
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  74 +++++++-
 arch/arm/boot/dts/st/stm32mp151.dtsi          |  75 ++++++++
 arch/arm64/Kconfig.platforms                  |   1 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 176 ++++++++++++++++++
 drivers/irqchip/irq-stm32-exti.c              | 139 +++++++++-----
 6 files changed, 438 insertions(+), 44 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.34.1


