Return-Path: <linux-kernel+bounces-145304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDB68A5257
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E87AB2375F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9673501;
	Mon, 15 Apr 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="h93D0VG0"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029D208B0;
	Mon, 15 Apr 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189175; cv=none; b=hhq7O8fQBrVd8lm2GfRuam0scOp1eEI13zUTneS8n4NJDoXJJirgKHb9fwaavs6FR06IFeOpC8z75JW+kjCd3zGlbadtDGHToYl1nSoHxcrj7UcEZBDlfdhKF1YZVYjbJKg3pWC28XPvM9NHKYUEau8xY8XgS5SpHaRglOdxA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189175; c=relaxed/simple;
	bh=U+4pgle3dsFiaWJNGuuL2e5Su5y14I72sd1m/tBMuo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJADNS2RazbutOMBHo5T1gj4qjzolsoKKzazPOtTMWCcIugOguKN0UBS0YcF9Uidbl8KU4HIG/EwxSnJJrvgWxnkgGL2VfITJJiRCJ3NUraM6DNLuhceBrVj+DPzjd2c1lVzhNHwbUwPkZ1hIDvo8IHpERPAS7rTmaCKmszgCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=h93D0VG0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FBMjbU004772;
	Mon, 15 Apr 2024 15:52:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=uIBsK4tjXsUxouAGNHNv9Rqw7KTBxkK0VeFWE/k0QV8=; b=h9
	3D0VG0zKklMLfBxL9Kup7dWymvKQhLpAVfP6X53XJxVpN4E82OhQK0nyQa0wdIyS
	idXP62w1QRH753D/lpd0fdMFIhFpF4Jt8Q/Xu4dfiXqx1xeA0QhwK/C1M/YNz1nP
	oGNIdJeKJvemh8iBw6W8oDAUPtxC8IvP1az8BsihtYRZrhgRx+jkwHqENv0W/ONI
	r01G0arw/s2Tj/B70IR2Hbo8HL5tvGqnZ6y3JEP5sWax/PHKnP0lbVSNIHMezxft
	K030qvUHD7uv+0402Xhe3u5gy8ESKJiZx+K5yojy/IWE5faDonWjVc6sfhQZA/ra
	UMGN93iHL6tWUe29F0vw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffff8665-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:52:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4F60940044;
	Mon, 15 Apr 2024 15:52:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7F7F215BEB;
	Mon, 15 Apr 2024 15:51:54 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:51:54 +0200
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
Subject: [PATCH v2 11/11] arm64: dts: st: Add interrupt parent to pinctrl on stm32mp251
Date: Mon, 15 Apr 2024 15:49:26 +0200
Message-ID: <20240415134926.1254428-12-antonio.borneo@foss.st.com>
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

Add exti1 as interrupt parent for the two pin controllers.
Add the additional required property st,syscfg.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 1426446ca1b11..e7d1614dc744c 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -271,6 +271,8 @@ pinctrl: pinctrl@44240000 {
 			#size-cells = <1>;
 			compatible = "st,stm32mp257-pinctrl";
 			ranges = <0 0x44240000 0xa0400>;
+			interrupt-parent = <&exti1>;
+			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
 
 			gpioa: gpio@44240000 {
@@ -400,6 +402,8 @@ pinctrl_z: pinctrl@46200000 {
 			#size-cells = <1>;
 			compatible = "st,stm32mp257-z-pinctrl";
 			ranges = <0 0x46200000 0x400>;
+			interrupt-parent = <&exti1>;
+			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
 
 			gpioz: gpio@46200000 {
-- 
2.34.1


