Return-Path: <linux-kernel+bounces-165497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A38B8D44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6CE1C215C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71812FB18;
	Wed,  1 May 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsYOGQX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0212F59D;
	Wed,  1 May 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577808; cv=none; b=SJA2Izqbfga6KAIxZlBAIhvLvxqAZK9Avvl5Wl68eUilu7Xt31QtRmAoXog2rCVTYra23NXbJNJQ4KJpCady4AYbTfNU/uEz8amVwhLIONy01z9wezCNLYQxgtJz4A6Vqpxu197gyU4D+w7B3d7ErtAntKpev75JmJ7nO1wnf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577808; c=relaxed/simple;
	bh=H43Z4wgbneQvtO9lOey4SVLIXIEEJWVeRwaZ4YWCu7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klq3fpObB5q605Bj80K14LA8pIDjzutgy9zheKs/AU54cfqYzvdo9HYFNLv54W9C2PMDhGOJPNbOdsuwq4GRPjjIea5ilDoU5JjjVwgURDgR59OSW4Rs79bUiWZJ/1BPCS+jlLfGDVsU6m7YcI3JwYffW0N9wRwmRojxbx+yOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsYOGQX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F879C072AA;
	Wed,  1 May 2024 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714577808;
	bh=H43Z4wgbneQvtO9lOey4SVLIXIEEJWVeRwaZ4YWCu7A=;
	h=From:To:Cc:Subject:Date:From;
	b=UsYOGQX/t6MdBD4L55qbAiRXgRV0yCJL0PcNAH1ykns2kVT6+aiGrDVNTioib50qO
	 fVuMzecaVmfudYZ8y/t696yAT9dEdBpGPbjSaGMGWU/wel/omYY6a/lGruZci9DqmS
	 /bUmpsqdbdWbAHpdI4cM+rFHTaVtiLAbUvbR7sOfUtbsZUh0/aSQdMZhmDDYRWzqqQ
	 VPkgWo2xyKeyfHiC3FjG0rL3SEwDLNS+4pteQEcEKYJiUADzefGYAiKJC3bvH63z1r
	 3bOHEjsY6Ee5t49S7R26BatI1lgqu0ROEiT4tdEVg/+25F8k1RSFwuO+J8fJyAf3hT
	 QPSp6tOzank6Q==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: microchip: add pac1934 power-monitor to icicle
Date: Wed,  1 May 2024 16:36:31 +0100
Message-ID: <20240501-spearman-primary-17df3c21c770@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=FR3O438NmrY2UU2Fa9xj9X2SWoXZf7FrPgh3S7n8dV4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlGifUKzt45m0oaa5d41NdWVy8Mez3HUb3t6cwZywV9E hcqODB0lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCIh0xn+mQrefiVZOiMkf9aE zSHevarTsgryiss2FzedmfU4pTpvBiPDt1/c3M9cc68WaAQYzvsoX/i+JfxTrGP6g97jhySOXlL lAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The binding for this landed in v6.9, add the description. In the
off-chance that there were people carrying local patches for this based
on the driver shipped on the Microchip website (or vendor kernel) both
the binding and sysfs filenames changed during upstreaming.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 .../boot/dts/microchip/mpfs-icicle-kit.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 222a39d90f85..f80df225f72b 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -100,6 +100,38 @@ &i2c0 {
 
 &i2c1 {
 	status = "okay";
+
+	power-monitor@10 {
+		compatible = "microchip,pac1934";
+		reg = <0x10>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@1 {
+			reg = <0x1>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDREG";
+		};
+
+		channel@2 {
+			reg = <0x2>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDA25";
+		};
+
+		channel@3 {
+			reg = <0x3>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDD25";
+		};
+
+		channel@4 {
+			reg = <0x4>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDA_REG";
+		};
+	};
 };
 
 &i2c2 {
-- 
2.43.0


