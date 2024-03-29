Return-Path: <linux-kernel+bounces-125050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D62891F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A81288F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8B13DDDF;
	Fri, 29 Mar 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b="zujQAt4V"
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E013D8AE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.25.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717351; cv=none; b=rhT7l/W+s/zpG01kiDHIsKz2MnrwmL+ZdS+2n1Q/SwY4TxWMDbjQtWC2k3XMEVRpMaoDy3/41AuByjgndELzgVl649bPMn4Qc8ydHcXN4FptA6oi9E3jBaHnV9ETO465S6AQEWhMmvye/QpEPaps+RfjAQJFBcYagXQKzQ4qJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717351; c=relaxed/simple;
	bh=fAvAnvABUo7HyKuMjevhf/jv5qC2EXV4aai6G+pLpAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnTUcVnEG+joDmv9WDmRkzi2Fs3de9H7VsBoGWVVYb6ty0lerQUfPMbLIREE//3B6Kh7woy85D4go5m/qDZmz59wijQGbfnGKTuwx3LoOMmpElm3iz78TajcBNGgyIjxwpLhZ2jBZqfwVskuyrzOtsiJeat/fCpsDx3INy2X+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; spf=pass smtp.mailfrom=rnplus.nl; dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b=zujQAt4V; arc=none smtp.client-ip=178.251.25.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rnplus.nl
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 1995C37948C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:05:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xpcy1SOSgici for <linux-kernel@vger.kernel.org>;
	Fri, 29 Mar 2024 14:05:48 +0100 (CET)
Received: from localhost.localdomain (184-179-179-143.ftth.glasoperator.nl [143.179.179.184])
	by mail.rnplus.nl (Postfix) with ESMTPSA id F015C37947B;
	Fri, 29 Mar 2024 14:05:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1711717527; bh=fAvAnvABUo7HyKuMjevhf/jv5qC2EXV4aai6G+pLpAA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=zujQAt4VCctGPhyNc7BqplQeCWC4PHXqkNF1G8Bp1BgJrkLCm78UrJpy3qm7nXQ6q
	 ytsDDNWm9eQolzBUvRxMfFbd1CzWPMwEJj26tzsegM3jbO0JGB6/0p0ZWh7ycoixvC
	 21bFBmKbEFVoFxZZpz8WMrWmyf7GuIAOteC3T6vA=
From: Renze Nicolai <renze@rnplus.nl>
To: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	arnd@arndb.de,
	olof@lixom.net,
	soc@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	joel@jms.id.au,
	andrew@aj.id.au,
	renze@rnplus.nl
Subject: [PATCH 3/3] ARM: dts: Modify I2C bus configuration
Date: Fri, 29 Mar 2024 14:01:41 +0100
Message-ID: <20240329130152.878944-4-renze@rnplus.nl>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329130152.878944-1-renze@rnplus.nl>
References: <20240329130152.878944-1-renze@rnplus.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit enables I2C bus 8 which is exposed on the IPMB_1 connector on the X570D4U mainboard.
Additionally it adds a descriptive comment to I2C busses 1 and 5.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index e93c2f0b8414..3b1c77a12605 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -183,6 +183,7 @@ &i2c0 {
 };
 
 &i2c1 {
+	/* Hardware monitoring SMBus */
 	status = "okay";
 
 	w83773g@4c {
@@ -240,6 +241,7 @@ i2c4mux0ch3: i2c@3 {
 };
 
 &i2c5 {
+	/* SMBus on BMC connector (BMC_SMB_1) */
 	status = "okay";
 };
 
@@ -264,6 +266,11 @@ eth1_macaddress: macaddress@3f88 {
 	};
 };
 
+&i2c8 {
+	/* SMBus on intelligent platform management bus header (IPMB_1) */
+	status = "okay";
+};
+
 &gfx {
 	status = "okay";
 };
-- 
2.44.0


