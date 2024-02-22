Return-Path: <linux-kernel+bounces-76045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE485F254
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E1C285B12
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4A1B27A;
	Thu, 22 Feb 2024 08:02:34 +0000 (UTC)
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758871863E;
	Thu, 22 Feb 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588954; cv=none; b=OQAMmzdCP3OMmVjRJGtaJ30Q+cO8dR0gDNvciePeBU0Wg0EROfncvr0+rA09f6COvv/5kBKLL+0XHx/aZ9tuF4h6xPGbQO37MoBIOoOwEToEvzRyB0rqdJvx669LuFNNBo9e526yFpObj7h8H3t8TBh+rjC3iQ3V96ryY3Or0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588954; c=relaxed/simple;
	bh=0i4fJdV4oWd0UtPBLzel1D30DZMFT1rhF4jCxciFWeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hG8cOXlqnRNd77kyIKqiUbK8o8dP5fQBocCeG3dvIp7V/Z5bee8Mr0o07RTrzNSIte9arxI7RRVAfS0lYD6wjYX6CxTlG6glRrXXAsWLISgoycN0s9LN5V8c9plALcUGnw0oxvtrN7IpgcPnx28QDDRkh1tTZXKlBu8Zq6WcbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Thu, 22 Feb 2024
 15:47:18 +0800
From: Huqiang Qin <huqiang.qin@amlogic.com>
To: <tglx@linutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<neil.armstrong@linaro.org>, <khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <hkallweit1@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [RESEND PATCH 3/3] arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs
Date: Thu, 22 Feb 2024 15:46:39 +0800
Message-ID: <20240222074640.1866284-4-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240222074640.1866284-1-huqiang.qin@amlogic.com>
References: <20240222074640.1866284-1-huqiang.qin@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add GPIO interrupt controller device.

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index ad1cac42e9d8..5248bdf824ea 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -171,6 +171,16 @@ gpio: bank@4000 {
 				};
 			};
 
+			gpio_intc: interrupt-controller@4080 {
+				compatible = "amlogic,t7-gpio-intc",
+					     "amlogic,meson-gpio-intc";
+				reg = <0x0 0x4080 0x0 0x20>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts =
+					<10 11 12 13 14 15 16 17 18 19 20 21>;
+			};
+
 			uart_a: serial@78000 {
 				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
 				reg = <0x0 0x78000 0x0 0x18>;
-- 
2.42.0


