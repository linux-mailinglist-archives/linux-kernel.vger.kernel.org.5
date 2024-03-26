Return-Path: <linux-kernel+bounces-118492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373A588BBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D2A1C2DBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F5132C09;
	Tue, 26 Mar 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="S4YxDNco"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34A4CB2E;
	Tue, 26 Mar 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439767; cv=none; b=VpGif0xIPXnj1b+NlRUWzQn2yH4yovlKW/hjGha0cKFpELT2wVmHSpkU9MtgyJzAebhKKPq4hEcMlFVKN2rFDViksunVJTOF+LKQhu7aPCd7z3MDgKRMMN5AHYa2O58Nmf6sJp7wAheoSfuoN/F2KCTkejanKqcaI/nAkWhYwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439767; c=relaxed/simple;
	bh=77n1NlsLgQOtQf7Esgl8bEJ1rWyy2eHY3D2N40RUx18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzU5kx9Mp8KWO9IaaS3dkHGn3ygC3bjv4U9+CaJICbmRtB1Z9N9YfG9tJTyVUaBX2nFr8Tr0jnCamXSttAHDtDv3kF8Iwj0oOHkhE27y/X/t3DZZAGJrSNTytzgCGPN9RETb56S7fggiCs7940YYqrdNOzdjLtjfMt8+ga7HcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=S4YxDNco; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q7rht5020463;
	Tue, 26 Mar 2024 08:55:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=Na0dP/m
	dBs4BLxpEYdqbjgbAo3j03TJxGOWuR82MAOQ=; b=S4YxDNcoUGspfJQBA6y8fa1
	+MNSYdj2PJGI/bQ++DY9JwS3MLd8eUlasogLBsYuZcZrP1+i5P7AY4MulzM47ExC
	yQNSHCVuLikaRR13vrKMX1uDTwxARNkWcbUH0zNpt2gnWB/63m3hzItYgqpeJ1OF
	ANqWQX7LHnrbWOuho3Z+Xx6Nh5XD4dyMcddr8I6j2hLJAlNAsjJ86mPEgFHrsOwu
	7kIUmrq64Z25vCTUvY3iXUq9ZCocdqkc9RZ0OTdDtEcyg8H8va+C17mPNzMWBBpm
	v7q4ECKQOxU8MTBNYWM0qW/8dlHZiTZlcS0E1+759Ht12cPnG4VEUtA0WB5U/Qg=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1qa342v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 08:55:41 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 368DD40046;
	Tue, 26 Mar 2024 08:55:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 85EBB2105BE;
	Tue, 26 Mar 2024 08:54:41 +0100 (CET)
Received: from localhost (10.201.20.71) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Mar
 2024 08:54:41 +0100
From: <patrice.chotard@foss.st.com>
To: <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2] ARM: dts: stm32: add heartbeat led for stm32mp157c-ed1
Date: Tue, 26 Mar 2024 08:54:38 +0100
Message-ID: <20240326075438.2891335-1-patrice.chotard@foss.st.com>
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
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add heartbeat led for stm32mp157c-ed1.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

V2 changes :
  _ add color and function properties.

 arch/arm/boot/dts/st/stm32mp157c-ed1.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
index 66ed5f9921ba..525d9ca7d576 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
@@ -10,6 +10,7 @@
 #include "stm32mp15-pinctrl.dtsi"
 #include "stm32mp15xxaa-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/mfd/st,stpmic1.h>
 
 / {
@@ -24,6 +25,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	led {
+		compatible = "gpio-leds";
+		led-blue {
+			gpios = <&gpiod 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+
 	memory@c0000000 {
 		device_type = "memory";
 		reg = <0xC0000000 0x40000000>;
-- 
2.25.1


