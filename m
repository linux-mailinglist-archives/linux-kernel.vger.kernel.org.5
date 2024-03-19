Return-Path: <linux-kernel+bounces-106982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2225987F646
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9622282CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517B87C083;
	Tue, 19 Mar 2024 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="uTd/7nUi"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B97BAFE;
	Tue, 19 Mar 2024 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710821150; cv=none; b=fT4QwDT7SK9Xe4tqVm2ahVIhtViU9SVesGMSP+JYV5lWvBsJTr992Oq4b+Kwc1qbD6UHei6z1IJfHkdzw8MgRbkgzavIceOqmDFMwt+3woOT/LQa3eUt9w162AqMj1OJQVgT6Thea95Ixvnouiix41iFnUGSOaL3lBfuHwS95FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710821150; c=relaxed/simple;
	bh=81XegKACPjNHTRIf2dxcxXcdyuI7WQPUV7vIHAI5ltc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYWjppn92uwi+QXOjfcJfGqKqiflL2+ihfgYGUMGWgtVI9yawJfvG5+dvcax1IHtbeGnHJenao/cCHMXRVzlEEmMKW05a2tUJRlHgqCzB/zYPfAYITMVWIh3+QgEtzQeIjBxcF/znsSL/+3jqfj3GwXeSBZUgmu5931rfMwUPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=uTd/7nUi; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 81B5A87ED1;
	Tue, 19 Mar 2024 05:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710821141;
	bh=jBZcyAZwPc3c9H9QIxIxQb/mu6RynF42oc1cRAenTCk=;
	h=From:To:Cc:Subject:Date:From;
	b=uTd/7nUiZg4RZ9RXOs0qkQFDSSMD6vqtdfTK9cu/W4LUQPdL1T4Gy3TsQQsX3u+3Q
	 /ZdjAHPBfjH2rPnbLGycOH+9tw4JLzEDDOxSawPYUEwtOknR1kMgBPKZ7PCveMCzaT
	 0QsXMDTamG/6XS5pG/ZocLjC7wi2ddVXoOzA0yzpwmXe32UqWSH+Ke51UAQr3o5IxA
	 WRDlxUTQ07rGEKnScAXySW41EUCMxruES4qLuHuc0o0/ClHLu6Ryne+fDpZ6g/TX/P
	 z1OWhgcwSg3ZJBHrYefpR/1xTmqMXnQFRrZI9Ph40VHcQkEBnieedXdF8DFkL7Q8ko
	 YBt2xsPjM3UMA==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: add PWR regulators support on stm32mp131
Date: Tue, 19 Mar 2024 05:05:06 +0100
Message-ID: <20240319040528.104932-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch adds STM32 PWR regulators DT support on stm32mp131.
This requires TFA to clear RCC_SECCFGR, is disabled by default
and can only be enabled on board DT level.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 3900f32da797b..58b8ae759998d 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1092,6 +1092,30 @@ rcc: rcc@50000000 {
 				 <&scmi_clk CK_SCMI_LSI>;
 		};
 
+		pwr_regulators: pwr@50001000 {
+			compatible = "st,stm32mp1,pwr-reg";
+			reg = <0x50001000 0x10>;
+			status = "disabled";
+
+			reg11: reg11 {
+				regulator-name = "reg11";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+			};
+
+			reg18: reg18 {
+				regulator-name = "reg18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			usb33: usb33 {
+				regulator-name = "usb33";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+
 		exti: interrupt-controller@5000d000 {
 			compatible = "st,stm32mp13-exti", "syscon";
 			interrupt-controller;
-- 
2.43.0


