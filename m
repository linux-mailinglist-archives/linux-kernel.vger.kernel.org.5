Return-Path: <linux-kernel+bounces-126811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D16893CF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E5A28322A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C04CB4A;
	Mon,  1 Apr 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/4h5ber"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AED4D584;
	Mon,  1 Apr 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985893; cv=none; b=Mvv+jdsTdZkk/LivmCZ6c9HxGuIfsDSt8kxjFOEpp1EQDskOSf9RQ4xlxIdEp/Lx+UwaVsuHOa1J/JrghpusFWW+VuhsrUKIZ+W+W0rctOxW/4MQZsgeinVR7pj0/C1e2iAc2gdIJWR5b9zytFNMIvaSNksSSbBHNBmPy6WllnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985893; c=relaxed/simple;
	bh=e40uKtgwHOMJ0qXjF39L3KNX2tZQf8rMLmYjexZGlmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VIZf7HLlrsYJxmAJ1eLUWzTol+1lWBuYu4+kk9ZQITHSNM7Dr5jqDggxJD3mljqLu0g35lNZ/otdhSTW8/qFd/dHj4mVmIeFNsr1cw4qYiaUX+hl+C/xGwYz/rNZjHS/W/yXJEksCBGAKUAT6lLHWS4fsrOI+oaqhqNZ8wynw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/4h5ber; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2531C43394;
	Mon,  1 Apr 2024 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711985892;
	bh=e40uKtgwHOMJ0qXjF39L3KNX2tZQf8rMLmYjexZGlmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/4h5berDLFQhREHk0G1pfczxuCosz+Caikz+K/Lfgm13EOqeHocM14udPObtukXs
	 0XqUyaGqREgDrnaVMIMeg7fQ5a8IRooGglnxgEf+xB6gBFsXiFHXdk8VqtLMNTkPrr
	 Q7/H5BLHpgFY+CP952O1SfjBT14TbRMgEEDoB31Qvt8WJzQTZB8eTnH1meUZvRL9I3
	 dZqIyyV695SGkWCoQCUAQJqlsGGXT9AuOjlPbKovHoMfNnBVOyGCy7ZbzBoF7/UQXY
	 4NQ+n+FOdYY+IsdDEhBp8oUK3HodwhBmhn1Kp+KHKT7NgJI/ReUFTq0xB8gPQpvhc+
	 Z7624yzBr6LzA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 06/10] arm64: dts: microchip: sparx5_pcb135: align I2C mux node name with bindings
Date: Mon,  1 Apr 2024 17:37:36 +0200
Message-Id: <20240401153740.123978-6-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401153740.123978-1-krzk@kernel.org>
References: <20240401153740.123978-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DT schema expects node names to match certain.  This fixes dtbs_check
warnings like:

  sparx5_pcb135_emmc.dtb: i2c0-imux@0: $nodename:0: 'i2c0-imux@0' does not match '^(i2c-?)?mux'

and dtc W=1 warnings:

  sparx5_pcb135_board.dtsi:132.25-137.4: Warning (simple_bus_reg): /axi@600000000/i2c0-imux@0: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index bf51a6e11cf1..860975ffe0a1 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -129,7 +129,7 @@ &sgpio2 {
 };
 
 &axi {
-	i2c0_imux: i2c0-imux@0 {
+	i2c0_imux: i2c-mux {
 		compatible = "i2c-mux-pinctrl";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1


