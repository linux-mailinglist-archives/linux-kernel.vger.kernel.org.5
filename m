Return-Path: <linux-kernel+bounces-155094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B586D8AE53C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1997B233B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6BE136E06;
	Tue, 23 Apr 2024 11:46:47 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5A84FAC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872807; cv=none; b=L/6CjD6YamBXr73iPDB9QCGD6WBQbHezeXZdPlUpRacAGhWcTvzexw2rRDrwsfUqes1t9YsPsz5UM4Ve7ACP9H4foVAH6fM9yQ8qg6XMk010Q0ugRecJvdfkx9R9ICTd2XDEIZYbNKt/lVkw9L7RdNuSBL75cPn3bUArNkkHSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872807; c=relaxed/simple;
	bh=X9W2Z72nbGvnBZtq8CEVJ0HQ23XHnWdWICDRUnGa5m0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owennB/b7I8PwEg828eKImTu8T26XAZVEJvuV+9s0LzeoQVdWvawAL53LZKghs0aCrvR6pjyF0ntCWnPLnkqt46NiCXN+8UIZe+L0mcLrwDp66pk41o4w1dMYufjxz/loZr45zgVmORp54xsjeG+A17/aSuT6ujtU+o7nnAjyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzEbh-0005TC-3x; Tue, 23 Apr 2024 13:46:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] arm64: dts: rockchip: fix pcie-refclk frequency on rk3588 tiger
Date: Tue, 23 Apr 2024 13:46:35 +0200
Message-Id: <20240423114635.2637310-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The clock-generator of course only produces a 100MHz clock rate,
not 1GHz.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 0e87e5a8532e..0e5b0e84d605 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -54,7 +54,7 @@ led-1 {
 	pcie_refclk_gen: pcie-refclk-gen-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <1000000000>;
+		clock-frequency = <100000000>;
 	};
 
 	pcie_refclk: pcie-refclk-clock {
-- 
2.39.2


