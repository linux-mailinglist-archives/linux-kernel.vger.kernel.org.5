Return-Path: <linux-kernel+bounces-151145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D038D8AA9B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB1EB23CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7AB4EB54;
	Fri, 19 Apr 2024 08:03:21 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53704E1DC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513800; cv=none; b=smT+n9ViOr/nk3gdNwBPgGjT6CyUOYVHqoAnaiUj8aioI0R/p1yDAkCnmEADlYH/5IsnsaH/cWBoiW65tfZ+TCAvXt3v8TIr+MkBdMGddplT9RnxjZL8lZDmP7gIeEYHE+Q6yxUfF7l6bfWmvl5iGPtZ15tL4DKFGZn2lApLOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513800; c=relaxed/simple;
	bh=+ItYQoQ8bG+YvpLv8Q544UX/b7yZxgsLsv3ZyhN+Qdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZvs4LzRfzaelJeWioVFcDD0Pq4Swu1miS8FeIqvy4sHYeSICDDYLnKs/T+ZVGQsNQdWLwA28jE+n57CCRnJuShCkdJhd4rphzV1RznLo1XKyJZX+0n8boJkrubAbz5bA60y/k2oxtGW5AnSGNrU1cgGbzEXO0r17D1r3l4T5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxjDC-0007e3-87; Fri, 19 Apr 2024 10:03:10 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] arm64: dts: rockchip: move uart2 pinmux to dtsi on rk3588-tiger
Date: Fri, 19 Apr 2024 10:03:03 +0200
Message-Id: <20240419080303.2402184-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The association of uart2 to the q7-uart pins is part of the module
itself and not the baseboard used. Therefore move the pinctrl over
to the tiger dtsi.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 1 -
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi       | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index d6e30d5697bd..ce38ebda5fd5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -269,7 +269,6 @@ &u2phy3_host {
 };
 
 &uart2 {
-	pinctrl-0 = <&uart2m2_xfer>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 78f5bbddabba..48a3cbca38d0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -711,6 +711,10 @@ &tsadc {
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-0 = <&uart2m2_xfer>;
+};
+
 /* Mule-ATtiny UPDI */
 &uart4 {
 	pinctrl-0 = <&uart4m2_xfer>;
-- 
2.39.2


