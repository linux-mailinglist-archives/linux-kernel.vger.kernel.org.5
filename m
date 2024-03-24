Return-Path: <linux-kernel+bounces-113094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246588816A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CEC287DA0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CACA154421;
	Sun, 24 Mar 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+iy6e2V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391BF153BE9;
	Sun, 24 Mar 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319902; cv=none; b=P5lZfohhvqvUz2sfVSXmpG7tca5Kq2RxakaWbaHyp5iCka5ysvC21T3lNADbFeSJLJBGEwjEeIQaAkITyJpAI4jVB7PDCUlHAWLq+tzMu1iKdQHwAW4JauGFI4LlkG2x5qTgi+8Tw4OmtaPVhp6auJWLSJOTHurOtq5xVZ5DyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319902; c=relaxed/simple;
	bh=7dpTwiOnZAO9FZsNTkOr0S+hOw0Zk3lrSPh8sthhtPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQe/zvivZQl7boVwtk19dPHXGDXX1+gFar6gzYUrMvduLt3yo8XmemBgIXAQAJXwQP6a4V7O9vPA7luputuznjKshT4h3DJPqrJQtgDjP+VkPpsxnJ19HJBc5Og/KACmNRwWkOsOfDEgOR3wycwlsFtbFv+wXm8XBrNoRMV3UIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+iy6e2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61775C433C7;
	Sun, 24 Mar 2024 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319902;
	bh=7dpTwiOnZAO9FZsNTkOr0S+hOw0Zk3lrSPh8sthhtPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+iy6e2V7k+waNzXR5eogm+mvENQhraIbTWoRYvgFAphpZjM34GZu5Q3ApJXfiVpi
	 n6F1Sa1e0ideT6UduDs3HOopS+NrU6FULKHxXHScoPg2+UQ3QrWEotPOwXT6HyzUHC
	 S5u3k90hQH86KIiZncVEh3iW0YpTrqn0IF8Y9ad+EcCCuM/MtIy8KPUqV8LEKqAMSi
	 htm6RhB/rfFVo0s0V0ioQlDNpMnqdJSiY2vlWJGM9pnFeQWkctEeQrKi/YUhPgu1bO
	 FUDkG0fZInH3sK8Qhzm9dMYB8qEuZhutgDXI8eNfUayFi5AMJvKyJ3lKF3YpN5XwPk
	 GzfvDjmQlvTnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Romain Naour <romain.naour@smile.fr>,
	Neha Malcom Francis <n-francis@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 207/715] arm64: dts: ti: k3-j721e-sk: fix PMIC interrupt number
Date: Sun, 24 Mar 2024 18:26:26 -0400
Message-ID: <20240324223455.1342824-208-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Romain Naour <romain.naour@smile.fr>

[ Upstream commit 7f25d6926d178734db17cfc12f0b1841e82914da ]

The tps659413 and tps659411 nodes set WKUP_GPIO0_7 (G28) pin as input
to be used as PMIC interrupt but uses 9 (WKUP_GPIO0_9) as
"interrupts" property.

Replace 9 by 7 for both tps659413 and tps659411 after checking in the
board schematic [1].

[1] https://www.ti.com/tool/SK-TDA4VM

Fixes: b808cef0be46 ("arm64: dts: ti: k3-j721e-sk: Add TPS6594 family PMICs")
Cc: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Romain Naour <romain.naour@smile.fr>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Link: https://lore.kernel.org/r/20240209171146.307465-2-romain.naour@smile.fr
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 188dfe291a32b..658764f7d5443 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -574,7 +574,7 @@ tps659413: pmic@48 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&wkup_gpio0>;
-		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ti,primary-pmic;
@@ -651,7 +651,7 @@ tps659411: pmic@4c {
 		reg = <0x4c>;
 		system-power-controller;
 		interrupt-parent = <&wkup_gpio0>;
-		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		buck1234-supply = <&vsys_3v3>;
-- 
2.43.0


