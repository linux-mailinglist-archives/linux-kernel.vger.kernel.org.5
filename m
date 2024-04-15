Return-Path: <linux-kernel+bounces-145301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801448A524D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329A42822BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6CF76408;
	Mon, 15 Apr 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6GIBxY29"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5075815;
	Mon, 15 Apr 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189112; cv=none; b=BCetkuFyDIg1FqGd+Njfv4doV/GbsyZJCcH52F2RI4K9S0qu9Ifh3Wr+v0lJ9csUK93ZH0xX5dh1GM4tsMFmE2W84q5AEA+ifeoDmxV0wZMKAwFLRM9xemHcO9UK2tq4510CSqt3IFBFL2/r8QRnBD2JMmw9fuFKEZ498+UVcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189112; c=relaxed/simple;
	bh=mV8OFqp0HBA+4TFJQzgX++xwHvZ0vXXitaj4vQc7TYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEgVtSiFxV7+Dr7oghUkWVtkYOnNO+ZP8eN3hPRc0MyCZwxwkFV276YDOhvGhbxOwg5d9kfER8EMjfxdwxuYAXLccFRIO9ZsrzW1UOzpuSZfVpNvsj70isX/4SMm/cukVbAZ9Et61Jh02OrAfOFDDugULqaSrVWNrT1lycXT/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6GIBxY29; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FCEbqv013411;
	Mon, 15 Apr 2024 15:51:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=Qh+d821k3hfgEZijAk5AUEPE177e4SfDnVA2TKafL5Q=; b=6G
	IBxY29LyremTr+C97DwebPQbPfkYQ2kmePUcXBUxVW3Of8fDOhsIT/zvvZcA8WTV
	+WRVMzz+4AkFuOYM9Zq2yoJg6pVrsCm4RYUkWtKGZs81C3xcj254Q7ZFFQiqrhVR
	pS0xooKWuOiJBo6RGNCtEc8gevB+Rk6FNeEBcz+5jgT2RzuWJatXNNaukgs2ynL4
	B7ujWhHx+m5P/uOPHOvHooh+AjOTkiFPUfLHQcjzvo5m0AdfTjjft5N4uf8JHTIA
	f6MuOaJNpYJF9+8fYWBxkTr/AVTFjNJX8S2J+p04Y3eeXVSY3ih4myhI3xgUyeZp
	xd2CdM9mr6wC0nwuNFuA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m0dtac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:51:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 137E440046;
	Mon, 15 Apr 2024 15:51:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B685216EE1;
	Mon, 15 Apr 2024 15:50:51 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:50:51 +0200
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
Subject: [PATCH v2 09/11] ARM: dts: stm32: List exti parent interrupts on stm32mp131
Date: Mon, 15 Apr 2024 15:49:24 +0200
Message-ID: <20240415134926.1254428-10-antonio.borneo@foss.st.com>
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

By switching away from using the internal table, there is no need
anymore to use the specific compatible "st,stm32mp13-exti", which
was introduced to select the proper internal table.

Convert the driver's table for stm32mp131 to the DT property
interrupts-extended.
Switch the compatible string to the generic "st,stm32mp1-exti", in
place of the specific "st,stm32mp13-exti".

Older DT using compatible "st,stm32mp13-exti" will still work as
the driver remains backward compatible.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 74 +++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 3900f32da797b..c432fe109cbec 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1093,10 +1093,82 @@ rcc: rcc@50000000 {
 		};
 
 		exti: interrupt-controller@5000d000 {
-			compatible = "st,stm32mp13-exti", "syscon";
+			compatible = "st,stm32mp1-exti", "syscon";
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x5000d000 0x400>;
+			interrupts-extended =
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 8   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 9   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 24  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 65  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 66  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 67  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 68  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 41  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 43  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 77  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 78  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 32  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 34  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 73  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 93  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 38  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 39  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 40  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 72  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 53  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 54  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 83  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 84  IRQ_TYPE_LEVEL_HIGH>,
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
+				<&intc GIC_SPI 96  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<&intc GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 63  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 98  IRQ_TYPE_LEVEL_HIGH>;	/* EXTI_70 */
 		};
 
 		syscfg: syscon@50020000 {
-- 
2.34.1


