Return-Path: <linux-kernel+bounces-122560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D840588F97A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92027296307
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961953E3B;
	Thu, 28 Mar 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fUZYtRXW"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3B537E0;
	Thu, 28 Mar 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612935; cv=none; b=Rs8yndrGt44WJNcQ3P2lJOrcecc3Pp0N+Gd0xJJqdiilfzi8YiV0LSrjzGBHoG8A+t0aWPv+U0AAjvvJk1FLqe9oTxdEzlLkPWUp5yAwWMhU3yChxy8RkdmGU4EvHPio3AHkJaohhBvWLGeivLUqIrAj4Sg2cN41aCJxHP9HgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612935; c=relaxed/simple;
	bh=SrdpeFjSHn0LCnvMBJIKDdbpLNAKMxwnnZuXs0WPO/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nMxaZfdJY7/Wh/KlaXfFxPj0E+cg7ksK5h5dtxoLXRF1GL1Zo9V5tiQ50osoZcdP5NPU4WmIQ6oS8UnajkCNi6oMZrsTu279yMa3+TsWnG22wQE1MlmiU2kVEdxRhEDJLxEaBPqKsblbB8KbVzA4NnEHlp0NJGBKjmbiDQYzB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fUZYtRXW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S20cbJ007927;
	Thu, 28 Mar 2024 09:01:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=B3k9NYQ
	+W0JovX05lxSOFMRWz6YTKcx+T4goM/utJYs=; b=fUZYtRXWdHKLTsnBLtLfC41
	A9d0Z0pqU+WM2pMGPSPYfObG2u0azWHtiu9+Wx+1t2YjW776IKo3CRM5i6msA6aZ
	RWxncsIv76TmXIqnPMB+lpC6C/8VcIzvp4Qkyi0M/CUuoJGYswEgzc+bNP+R6xqj
	wgSe02V9961lRcB8VTHXQZbEI/oDkBafNxHu4Hb2m64s6mR7WaF2ePUGU5KAGNKR
	rtqCap8RKiCExXxXeG83oQS4Jwr19KxNbYOvYwJiWByDkEIV89BAPeGtNOW2Kyh8
	sLrToKtVrmEp4DqB8LRfaVKu5F7Qz1PYDe17+Ima4dGF2nvPpbiAafGtykBPocA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1pugrc0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:01:40 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4E9E440044;
	Thu, 28 Mar 2024 09:01:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 238F0210743;
	Thu, 28 Mar 2024 09:01:11 +0100 (CET)
Received: from localhost (10.201.20.71) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Mar
 2024 09:01:10 +0100
From: <patrice.chotard@foss.st.com>
To: <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v1] ARM: dts: stm32: Update button on stm32mp135f-dk
Date: Thu, 28 Mar 2024 09:01:05 +0100
Message-ID: <20240328080105.3910099-1-patrice.chotard@foss.st.com>
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
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02

From: Patrice Chotard <patrice.chotard@foss.st.com>

On schematics, 2 buttons are available on stm32mp135-dk board:
  _ button "user1" connected to GPIOA14
  _ button "user2" connected to GPIOA13

Reflect that on device tree.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 52171214a308..f7e03bc7eccb 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -48,9 +48,15 @@ optee@dd000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		button-user {
-			label = "User-PA13";
+		button-user-1 {
+			label = "User-1";
 			linux,code = <BTN_1>;
+			gpios = <&gpioa 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+
+		button-user-2 {
+			label = "User-2";
+			linux,code = <BTN_2>;
 			gpios = <&gpioa 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
 		};
 	};
-- 
2.25.1


