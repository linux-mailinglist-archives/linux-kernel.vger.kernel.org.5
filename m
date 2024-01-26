Return-Path: <linux-kernel+bounces-40375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168E83DF33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F451C21A43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1651DFEA;
	Fri, 26 Jan 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="taW7AgVv"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48AF1EB27;
	Fri, 26 Jan 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287910; cv=none; b=ur34JjKlem1djqWgGl3wpeSI8+Ln8SieaD19VWILB+ZdtDSN4PC1BpR/kL8TldNbZIGkSflREObs73hUKhPl09P7hMjuaeEE98ua86XTcePufKQn4mXRVPLfgLxWZjpe2+NIPprL5J3XxQWKjMxf9ODGg0X7HjAkHHS3Rxicyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287910; c=relaxed/simple;
	bh=+cXzMvBAtJb3wVlA116iwNKAecdGtSbYbPHtkLdN4cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ilrcK7500Ws8TAJLIO7oFMeY1gGvCqxEOGZ4azQsND226rC8ND4Z7WiHuEwGpwqewL1NTin4FK6iAuFN9prXDaJHawr1r6Fc8tlvnDZML3NjGz9FHSee/sgFVgeYzt8PHfsoVlFKAf23EmKlmkGVLQUPyGJx3WurSv2E/k6JXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=taW7AgVv; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9E5511F8F7;
	Fri, 26 Jan 2024 17:51:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706287903;
	bh=JeCPYSKbHNIMCupfAvsor19aGaKE9SOf3p/CedSlNcM=; h=From:To:Subject;
	b=taW7AgVv/P6+S+x2yoiimUts3sgYrlpyF/21GqKL2fi1oYR7/InpjKHjdN/oj/sS1
	 Q97EKcXWc0hrrdEDD4NOUXkk97GU2qSqdrRCeHl3zAlEA2nK+lubh5MwU413Dzvnc2
	 u9niJ+/pk/mDgQdglzMI37MLmK8qMTQ8KV18ITFVlkae1LLzYqJZ1KPo63H9CVa1aV
	 EzNRBOCaGaOXXINOyOHP4YBYIOAZfQDK6NwjPH1klRr5egtf+yHkw1a5gIVhWg8ZaG
	 rSLHzx8JcL3vlT0bjMQ6Wj9mS8euYKC4R/GWdxovvr8JtRNcco2hXPdY9S8B0BwDG6
	 SL5ZQz0Isev/A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: verdin-am62: mallow: add TPM device
Date: Fri, 26 Jan 2024 17:51:36 +0100
Message-Id: <20240126165136.28543-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add TPM device to Mallow device tree file, the device is connected to
the SoC with SPI1/CS1, the same SPI interface is also available on an
extension header together with an additional CS0 signal.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
index 17b93534f658..77b1beb638ad 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
@@ -127,6 +127,16 @@ &main_spi1 {
 		    <&pinctrl_qspi1_cs2_gpio>;
 	cs-gpios = <0>, <&main_gpio0 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_qspi1_dqs_gpio>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <18500000>;
+	};
 };
 
 /* Verdin UART_3 */
-- 
2.39.2


