Return-Path: <linux-kernel+bounces-133499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D7889A494
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889E61F22426
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E416D328;
	Fri,  5 Apr 2024 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcyD8HD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C1172BBE;
	Fri,  5 Apr 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343877; cv=none; b=AzXRbSbz6E5XdYyfHiABG+/fePcQDc/7WrAWSNpkdeFH1e4Fg062Mh4QUKPrcaX0ysvoyXq/5XhwocEW1i/O9cxNw123HpaVPoqMUyyGgEkaF0OVu/UDdwivuZcdaaoNBtGabgqrxDbTQ1d8qlb06aID0Wxtu/o6KO8us9xAtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343877; c=relaxed/simple;
	bh=Y6Zm7FoeCkmRHqJcg1sajpZCsZm8IpqlpsHT1dhl0Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/ZZliFtgTKZ2Txzu8saWwtHxxBVHAeURSGqxkTuh3l434gXxXR81+7rlUuTCy/A/TGsCOvWZrrP7uEEiNOVgQGHbza0BdNjQyU/F1wtPJnkfF+Ph4XT9dV9gEx2rEHTudj3XdGUhK9CUA07D0ysvtiyr1ODLcmv4dijpYfpoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcyD8HD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C87C43399;
	Fri,  5 Apr 2024 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343877;
	bh=Y6Zm7FoeCkmRHqJcg1sajpZCsZm8IpqlpsHT1dhl0Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcyD8HD8KfPCNfIi9MFoQuys3zWAmjE/0T5Oj8cmXV+/lCSUUJjN9lQJn24Fiujez
	 Mtc3kAElATd5jCCJCEMUtfUvBm0QnD7xyzZYhKvbAPPQF2RX3kz+mJpBf//pvn27F8
	 0nXiFRwMnAA52oLDDJ3W3eAVKWxFPFFduCRVfw3aIqPO0NKsSXN85LdCVBCXiKfmbp
	 egdtICvfcfWesh9ccrbAwGI6qq8UOBDlJ/c+w64nQVtI/sB+y4Yjbw27gshofkSj8P
	 ZrxPI7HkheIX/ma4TZcrR0R2nxS8YU74WirBfJnN0IGordAC8jNHknWV5zKI1Rw1QI
	 vSDMncb7iVbCw==
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
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: horatiu.vultur@microchip.com,
	steen.hegelund@microchip.com,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 02/10] arm64: dts: microchip: sparx5: correct serdes unit address
Date: Fri,  5 Apr 2024 21:04:11 +0200
Message-Id: <20240405190419.74162-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405190419.74162-1-krzk@kernel.org>
References: <20240405190419.74162-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unit address should match "reg" property, as reported by dtc W=1
warnings:

  sparx5.dtsi:463.27-468.5: Warning (simple_bus_reg): /axi@600000000/serdes@10808000: simple-bus unit address format error, expected "610808000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 5d820da8c69d..c3029e0abacc 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -460,7 +460,7 @@ mdio3: mdio@61101031c {
 			reg = <0x6 0x1101031c 0x24>;
 		};
 
-		serdes: serdes@10808000 {
+		serdes: serdes@610808000 {
 			compatible = "microchip,sparx5-serdes";
 			#phy-cells = <1>;
 			clocks = <&sys_clk>;
-- 
2.34.1


