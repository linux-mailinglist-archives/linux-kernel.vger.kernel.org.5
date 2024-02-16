Return-Path: <linux-kernel+bounces-68377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFB885796C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD53B25A98
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A11C6BD;
	Fri, 16 Feb 2024 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xt+JEEOw"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48821BF28;
	Fri, 16 Feb 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077107; cv=none; b=IgnLnFgijI3VmivbizQ5pMtAv/RbpuVnnVhS//1iSkJWiAeD+h/l7iTWjS1wUXGrcHQ8tjh/Dh3vCyEUlgY+l0xc5h69HbrWlcznW3Em4SSkm3JstdC1qd6vQkcdHidLfZn2ed2FbxoNypHPKo3YO4MqSmpBERe2waCKZO09b2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077107; c=relaxed/simple;
	bh=htFPPCRNPyJQ94F7XATypHzQyMpmSmZex9/abw55Q3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUsNMdz3FaNYmVVcpUjSDqCYqk4+zNFFm77jWZRvQEZ2ao4nQjYxr0pc8xawxhkHt+dR8NVmA7TdKThmMwb+0ZizZ1X98lL+CC1kVZ3n6KqxTIjLmwZXexD74NLMbfhUaSw/4uBpuLNn8shaneAHfW9pKUyDcL0h6E+NarhIBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xt+JEEOw; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4pWkN008754;
	Fri, 16 Feb 2024 10:51:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=lG/404Pv7+RWktWppSnM5oXw2eG/j2wJbKBMjahgEeU=; b=xt
	+JEEOw+Ke7EY8qyrUeZiwOJT3tauI1vIwgaAlXu5nGDeERibdAWnYzvHCzLdDAcD
	/M/Dj1RmLPL76E0HRMjqcqRLrO4psSWmYTDy6dMWg/AW1FxLiUmR22Qy61JzJnq0
	r+Zpiz755STDbThG8QMFjSu6iUiP0h2+ii2B4PhbEzQNARVW5xAK6Mzo3LB3Aqk3
	dVaFLpWL29O50ZXeyrZvaE+jtPEEp3ZwkkV3e1nyB3AxwcMaaHl7n5Y/w3y58ldv
	HVLasqjIys8nV9GYU2inrWte1DoEL/SM/yq6dXQa6JgxzHLAFm7h07NbcAVIQ38b
	mSQfinnDFxDLA2UtKldA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa124gy9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:51:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C89584002D;
	Fri, 16 Feb 2024 10:51:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A35522D187;
	Fri, 16 Feb 2024 10:50:27 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:50:27 +0100
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
        <linux-arm-kernel@lists.infradead.org>,
        Christian Bruel
	<christian.bruel@foss.st.com>
Subject: [PATCH 10/12] arm64: dts: st: Add v2m to GIC node on stm32mp251
Date: Fri, 16 Feb 2024 10:47:55 +0100
Message-ID: <20240216094758.916722-11-antonio.borneo@foss.st.com>
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

From: Christian Bruel <christian.bruel@foss.st.com>

The GIC of STM32MP25 includes v2m extension for PCIEe MSI support.

Add the v2m sub-node to the GIC interrupt controller and adapt the
other properties accordingly.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 96859d098ef8..5c9095382cc7 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -81,12 +81,20 @@ scmi_reset: protocol@16 {
 	intc: interrupt-controller@4ac00000 {
 		compatible = "arm,cortex-a7-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		interrupt-controller;
 		reg = <0x0 0x4ac10000 0x0 0x1000>,
 		      <0x0 0x4ac20000 0x0 0x2000>,
 		      <0x0 0x4ac40000 0x0 0x2000>,
 		      <0x0 0x4ac60000 0x0 0x2000>;
+		ranges;
+
+		v2m0: v2m@48090000 {
+			compatible = "arm,gic-v2m-frame";
+			reg = <0x0 0x48090000 0x0 0x1000>;
+			msi-controller;
+		};
 	};
 
 	psci {
-- 
2.34.1


