Return-Path: <linux-kernel+bounces-153551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6194E8ACF84
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB8B2843FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0335315217B;
	Mon, 22 Apr 2024 14:34:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A33CF65
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796447; cv=none; b=PCvZ8DAtzuqIMN7tJuwo5J7JPFjmKQVchMH+oqinG6vpkc2MZzxnYEmkOWbYKrdZb9Q2pWV/fiYhz1t7Tn4nMbNcYhYm/BC8cQ2nDx3LdfgiPEt6ri/0StD925hQLBs6oH8ZyHUQuR6VZxHvslODuuGSguOXmiNm0GgNyOJuQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796447; c=relaxed/simple;
	bh=v/HbQsB4MeFSKet9POUFrGm/INKOAcbLSRTwwHpbvYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TqfLwS1+gvXZvw9Z5c4dhtEDQ78T2XxEHgX4FBjAMIb3D45i9044sXO+1J2OD5yzxTYX1yadhrPzHosZ/d+1JhGHbTimSorMvO73fpsTYJ2mAPA6yzhwfF1/HbVX9OyNVysNN0Lt5970GSOqAEAryZ4nz1QlM8ProWRt4FRtbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d85.versanet.de ([94.134.29.133] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ryuk2-0003mD-S0; Mon, 22 Apr 2024 16:33:58 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2] arm64: dts: rockchip: move uart2 pinmux to dtsi on rk3588-tiger
Date: Mon, 22 Apr 2024 16:33:56 +0200
Message-Id: <20240422143356.2596414-1-heiko@sntech.de>
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
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
changes in v2:
- add comment specifying where the signals go to on the Q7 connector
- add Quentin's review

 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 1 -
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi       | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index d672198c6b64..9bdd14799eff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -231,7 +231,6 @@ &u2phy3_host {
 };
 
 &uart2 {
-	pinctrl-0 = <&uart2m2_xfer>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 72fe696b0034..4984e36a8c2d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -688,6 +688,11 @@ &tsadc {
 	status = "okay";
 };
 
+/* Routed to UART0 on the Q7 connector */
+&uart2 {
+	pinctrl-0 = <&uart2m2_xfer>;
+};
+
 /* Mule-ATtiny UPDI */
 &uart4 {
 	pinctrl-0 = <&uart4m2_xfer>;
-- 
2.39.2


