Return-Path: <linux-kernel+bounces-128506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA1895BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4741C22D10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FCE15B102;
	Tue,  2 Apr 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNKAuKIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2F15AD86;
	Tue,  2 Apr 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082769; cv=none; b=aZDYsjo6DVLQtTv3Ii9cUpf8tX3AxcDODH80ybARRN+cl4XHgtbCaqBzbKDz5aYvZyH+8JUMreoLofXceiq0e6WS3jmJRO4I5tS/h/6wX1b7mtmSACbdnTihwGJLhUbo8HAwmLHzY4lsI/tBIua3PsZL9j282JCcKLrLab0VJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082769; c=relaxed/simple;
	bh=af2EBy7vcEvCvMvRtwWF7Cfdbqfz9lWIVTEff0unu0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vE1qIB/EgDFTX9ebLEjHDSPX0i5t+sktPihtL26iBExYEQlQJHJ2JgXAn8A51ZyphoNsG0UD5HM9QdR4t8agNLMMFS4/ZsO3P9ALnc7SQgWQrTMePkWEuw1QKDDzFNJ8fhmfoERsQwNUDgQGM33POyL0cYM5jAkUrfTAAhZwxng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNKAuKIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52096C433C7;
	Tue,  2 Apr 2024 18:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712082768;
	bh=af2EBy7vcEvCvMvRtwWF7Cfdbqfz9lWIVTEff0unu0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=NNKAuKIvCQhIz74ikyryd1E2sQNG/WLtA8UXlMN9fsIGxQUAIm9vR8wZ4oQsl3xGo
	 5JhY4GQFZj3zVrtWY4Vdz+fHYYaKCzqyThCAbrU1lboox4W3RWglsfxsvUpjmuGlIk
	 9raqzcZ9yBVlrrkzUMmPCkCaWVyU+ZwlbVKiuF/moLHEZBDNype7Bl9+GpI87aUCJa
	 2wbsnKzGI9eTFGk8C3S0bBMlfSCNewbIUp1S+baX7EYYQD1cNAGvbdyHLTmLVr1k5O
	 yCee9vTbGmrClNbez7qRFy8fuMh5U9M3AW4+LfRIjpZW9BxnqYkMG6JVJvYpOT7Af6
	 Z0rpYHOs4evjA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] arm64: dts: marvell: eDPU: drop redundant address/size-cells
Date: Tue,  2 Apr 2024 20:32:38 +0200
Message-Id: <20240402183240.49193-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethernet-switch node does not have children with unit addresses, so
address/size-cells are not really correct, as reported by dtc W=1
warning:

  armada-3720-eDPU.dts:26.19-60.4: Warning (avoid_unnecessary_addr_size): /soc/internal-regs@d0000000/mdio@32004/switch@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

This probably also fixes dtbs_check warning, but I could not find it, so
not sure about that.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
index d6d37a1f6f38..91c2f8b4edfa 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
@@ -25,8 +25,6 @@ &mdio {
 	/* Actual device is MV88E6361 */
 	switch: switch@0 {
 		compatible = "marvell,mv88e6190";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0>;
 		status = "disabled";
 
-- 
2.34.1


