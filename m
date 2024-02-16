Return-Path: <linux-kernel+bounces-68374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE6857968
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF39A1C225C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990CC1CD2C;
	Fri, 16 Feb 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tyUFMbEJ"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3F1BDCB;
	Fri, 16 Feb 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077091; cv=none; b=kQ+hmVStUmcjL7qI3Hi61IABL2R58tBoNiVfUSDkUq00uduMOrXxgieQNcDlAyayPVZjXZO4MDGXxTqnk7/SWb4vBXVlxNTyxphwNshfhNSh16W9rxq76z1Qty8m2DXmT8/2z/WWiGEPoGKQIM93mRKKuz7hHVnOPFWNs1qliLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077091; c=relaxed/simple;
	bh=nn2ftYrplEypTEvfcJUwrwUlSUH/K8lqqqJ84+zkhLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i13+RxYwwWZEug0/D6qpCFVNxS19RRoXHxs58DCgLtiIUMql6YFvhq9lE1nM92/ujx8J9Ipizva0tdssoRxjW5SJrsd2C0dWzy9q822SYV6A6aOs+RBl89FQPAg3YjQiN6LUX5F262L6df2aALJzV2fW/qGQlnpf9HgpkLhVkOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tyUFMbEJ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4pf9J024119;
	Fri, 16 Feb 2024 10:51:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=ZRp5vGAcix3Wpj/vQ2UmL/6M8zmhJtR1etki3Khip70=; b=ty
	UFMbEJLmWAIHFMANH8bq2WgnktZFbF+8uSO4sIEXjyfzjtxuu3xqIj1yrNYOWWz3
	Z2J1j4YlmGi4B0lESxFmT/xdmEiwP7mKCjNZqoW8UPG4qiO0tFySCb43c0sEy0xo
	L7nc/uLS9dNtWYcPVjulyozYjP0vATy0okMmdlTiywM0owylKJT3GaPEJ1jWcpfb
	Rzk3iXhASJ9PQzu+SPz00t6lAarbatgG12RyRvzM1gWAI+rbuivo7QNeB9a+QFSd
	Zvv24DHgfxgQXWc8vg/iq4RSFQDW75jYufYHSi5OVwqm6GBRbTYcBZbDmDVQNUNe
	bShuV0PKg+iBjgHemQlA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa126gybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:51:14 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 31EB740047;
	Fri, 16 Feb 2024 10:51:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7112229A92;
	Fri, 16 Feb 2024 10:50:28 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:50:28 +0100
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
Subject: [PATCH 12/12] arm64: dts: st: Add interrupt parent to pinctrl on stm32mp251
Date: Fri, 16 Feb 2024 10:47:57 +0100
Message-ID: <20240216094758.916722-13-antonio.borneo@foss.st.com>
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
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02

Add exti1 as interrupt parent for the two pin controllers.
Add the additional required property st,syscfg.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 4253f5bcd000..6d46450afd4d 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -254,6 +254,8 @@ pinctrl: pinctrl@44240000 {
 			#size-cells = <1>;
 			compatible = "st,stm32mp257-pinctrl";
 			ranges = <0 0x44240000 0xa0400>;
+			interrupt-parent = <&exti1>;
+			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
 
 			gpioa: gpio@44240000 {
@@ -383,6 +385,8 @@ pinctrl_z: pinctrl@46200000 {
 			#size-cells = <1>;
 			compatible = "st,stm32mp257-z-pinctrl";
 			ranges = <0 0x46200000 0x400>;
+			interrupt-parent = <&exti1>;
+			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
 
 			gpioz: gpio@46200000 {
-- 
2.34.1


