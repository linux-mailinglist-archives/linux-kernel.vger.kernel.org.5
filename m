Return-Path: <linux-kernel+bounces-114027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868738887F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68F01C26FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331322ABB5;
	Sun, 24 Mar 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRK9iLo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122B1FB704;
	Sun, 24 Mar 2024 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321304; cv=none; b=qNMVz5V/g0A29uFJ8rciow9KPejbmYviHjzm6Kraj6Gm9CnPo/ndQH3QUVREWvTzHfHTdY2AdGj/WRZ4rTwTIoLcA+KuDB4TqJxXpZB9pna1uc1XersO7lzZFFFDHo+fYwCS1rlE8/+u9Xo46glAI+hoNDSc8Cjack0sw6+ljKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321304; c=relaxed/simple;
	bh=T/akRPi5ao0d12BmCz3WEgH+FPHY9KHNebOOEFBHkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEYFStCGXiatWCjJJeNlCA9KpnN7qTSGeO+GVmcFVM2tZJoRbueCLEqvLRXPsadB+oTecZvYQQWgTWrnGfIKIz5mtGXJuL4UmfhMkmdXFog/f9AYxNhglYFto+RVxtDjRsAg+BqjO1OFk7DJk1/mJJGtXH37E0sPU9fghTTEw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRK9iLo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2684C43390;
	Sun, 24 Mar 2024 23:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321303;
	bh=T/akRPi5ao0d12BmCz3WEgH+FPHY9KHNebOOEFBHkBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRK9iLo+bacb4Iqm8R4zBHJP+zRQYb1qsXklDJ6YrPMbBg/5zOtdTAIWDx/WcBRH2
	 FRAGht7CitdWv+lhz1SLF3sdW1Ax7H58OELKBUAuxZA/S1GFxXoAB254E9T5pJWML/
	 CyaSCvRRdDOahw7QKrWhhO7ZeJlXR0XSeTza2Sybh5vbBpSRKmhRJrshmlUS3nivv1
	 wm1ZVUG1udEpuY0m38x8LULh5kY8V8i+zykB6kbvnxS6PIRVwaQ9iDuF9tKglbR0Xk
	 6CSVviPMUDYyZaSDH7Td054AlN4eMZNTH/KFogD3mFSXF8L2fhJRsLYb3+toRwmoI2
	 fyxocrogjsXww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 026/638] riscv: dts: sifive: add missing #interrupt-cells to pmic
Date: Sun, 24 Mar 2024 18:51:03 -0400
Message-ID: <20240324230116.1348576-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit ce6b6d1513965f500a05f3facf223fa01fd74920 ]

At W=2 dtc complains:
hifive-unmatched-a00.dts:120.10-238.4: Warning (interrupt_provider): /soc/i2c@10030000/pmic@58: Missing '#interrupt-cells' in interrupt provider

Add the missing property.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135ca..72b87b08ab444 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -123,6 +123,7 @@ pmic@58 {
 		interrupt-parent = <&gpio>;
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
-- 
2.43.0


