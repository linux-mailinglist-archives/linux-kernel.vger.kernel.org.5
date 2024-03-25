Return-Path: <linux-kernel+bounces-117546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D03888AC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DA91FA28DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585DE130AD1;
	Mon, 25 Mar 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Hl45zEKl"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D640130A59;
	Mon, 25 Mar 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386478; cv=none; b=htYNxC0gHZxQRTlisbSkGFa/Fy2A4kyHPDNM8ChtYgYo02vUXFk2thHHyLx0A+3frbCpdebaKRPn8NvYM3NXFsW4qQ4Zlmk2cdwOxM0RlHplR0v/OL3h7cAvBUhL9JERlmjmLYBmAPLg0FWp46w1jUeUMx0mhMlY3aGvxT3Y/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386478; c=relaxed/simple;
	bh=yaX/wjHhAcwywTQkaxdociJkZMvKghVx1DALgRYGtu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=INLYu8f2D5KUxBbD6G+ukqTiv/QJV4xseHsfZOppWxD/g+WJttTWyJKnv1BWs/8FjyM07lGjj1yGscbEODTvpamFMf5QAiEKKzBE4rdb8Bd58B8TSsgZNdYCEftVJTgyM+AZYtnnXZgr8VZJJRhFrawkcrPbyAaKmrwM7oe1Tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Hl45zEKl; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PDh2Y7016725;
	Mon, 25 Mar 2024 18:07:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=tFOLqS0
	E65gTiJl7LWTPhWVSXxAUkT+dmYlJApHxVFE=; b=Hl45zEKlk/8CTeWSR75QtWs
	6zfcScp6vcSUxv0VfcBbu9+cbSh45X2p1P2X1p2vxwd9IwM4mFQYEd0MUXiUxByr
	4qSioBRz4vcQQm3qxe9r/PFRS5zlFeoWiRxzRZJNdqIRjgi04M3Uz6DX+sQSbsTh
	2Ju8+xn0JF5apbogRJhA1hjTuD9FqhhrL24Ai+veBIvgYT+/92G8rKwFr13cwbY9
	HVyk+SITA6lUacugJugWeMPWVH+NmPGt4orILtALIbs7sES2lx14PCr7HQJxs7MM
	P21Q3hvMtSYjWG267xnl5eVJUPGVvbQ4WiiviMMBNTOIjZ/CVSjok4TDb3C8UpA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1pug92jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:07:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 77E5840045;
	Mon, 25 Mar 2024 18:07:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 68E8222D827;
	Mon, 25 Mar 2024 18:07:01 +0100 (CET)
Received: from localhost (10.201.20.71) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Mar
 2024 18:07:01 +0100
From: <patrice.chotard@foss.st.com>
To: <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: add heartbeat led for stm32mp157c-ed1
Date: Mon, 25 Mar 2024 18:06:56 +0100
Message-ID: <20240325170656.2829600-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 definitions=2024-03-25_15,2024-03-21_02,2023-05-22_02

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add heartbeat led for stm32mp157c-ed1.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
index 66ed5f9921ba..bd727455a7e4 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
@@ -24,6 +24,15 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	led {
+		compatible = "gpio-leds";
+		led-blue {
+			gpios = <&gpiod 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
+
 	memory@c0000000 {
 		device_type = "memory";
 		reg = <0xC0000000 0x40000000>;
-- 
2.25.1


