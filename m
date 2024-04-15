Return-Path: <linux-kernel+bounces-145299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BCD8A5249
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DBD1F227FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1076023;
	Mon, 15 Apr 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tSxBej4Y"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7867442F;
	Mon, 15 Apr 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189110; cv=none; b=GfnTiA6VmnzlEot5Tn3NAO1EMM+E/yZXcNMpyEqgFkQE6Ke2w0AruLkUR/xhDWiwNWsRO2D/7Ehnbvfz7NX9ijQSyZhvYE4BENNK3aHpGVnEVxQooOskRo3ZH5zmciUs8tJFiiF1/sc/dTRajwIAv+hdTQKBW/nq29UbegIG/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189110; c=relaxed/simple;
	bh=0KJIq5Q+ZIIelBnyiMJFTamVtS1O5Lag9ZKrLVV5fv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfGsJDix5kID0/SaINQ09i5ZfggfnUoXvFZ7iUsdW16T5RcWMHcvpvS6Ewmm62pW+xGguR3kkzblVx9xId/QBVvnRwucbm9b+m8hNEUoJ/JBBP+2YCm92dgLGri8vNhB6mX8/CUw1mnT0ZSNPwoESq9PG/hM4g+w6rMB7XCLS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tSxBej4Y; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FBMjbG004772;
	Mon, 15 Apr 2024 15:51:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=j8IkHP4WnjuBkU+LCPf5A447SFa2M/YqCamK7zG7Rlg=; b=tS
	xBej4YVmRuq6/w0+lkhSwieyZFyTSeN2x8+O7kKHmplEbDLqnF+w7lW//2QoWnYS
	81NUO3/t0CpCG8HpfdbdzjGD1Jg7M5H14iCZ2PpG5vQhumC44XfU/QThZlWkVdTN
	bTqVX5meGXeS+6diib+nBWfG3Rnvxbm6Uggsgqx4DS5BNEpthGHnKb5+Ldu7eH7N
	xUSRduPxANkSyV7QzkMPUouby4UKxu1mn5e4f7oWa8F3e6mkr5qNkThovfsKSzEV
	d4WoM99c/DOBDahXjKgRMOBjOD+znVe1qZGQdMJqkLopE25ZNuednCn/Jw4XYEHF
	PFmwgJFqPdHfJE73sj0Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffff860m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:51:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 71F4040045;
	Mon, 15 Apr 2024 15:51:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBAEB212316;
	Mon, 15 Apr 2024 15:50:50 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:50:50 +0200
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
Subject: [PATCH v2 08/11] ARM: dts: stm32: List exti parent interrupts on stm32mp151
Date: Mon, 15 Apr 2024 15:49:23 +0200
Message-ID: <20240415134926.1254428-9-antonio.borneo@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02

Stop using the table inside the EXTI driver and list in DT the
mapping between EXTI events and its parent interrupts.

Convert the driver's table for stm32mp151 to the DT property
interrupts-extended.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index fa4cbd312e5a1..bcb3ed94b2656 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -1224,6 +1224,81 @@ exti: interrupt-controller@5000d000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x5000d000 0x400>;
+			interrupts-extended =
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 8   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 9   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 23  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 64  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 65  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 66  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 67  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 40  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 42  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 76  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 77  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 31  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 33  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 72  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 95  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 37  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 38  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 39  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 71  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 52  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 53  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 82  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 83  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_40 */
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 93  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<&intc GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 62  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_70 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		syscfg: syscon@50020000 {
-- 
2.34.1


