Return-Path: <linux-kernel+bounces-129862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D0897162
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA40828BEAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E48E1494C5;
	Wed,  3 Apr 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b="CosIn5k/"
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44B14884F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.25.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151648; cv=none; b=QwSwQ2tiAO6YATjJcdWPLApDrlu3N6jurzZyAo5RsluPbDETGUXuT+twRHT3vy4HBq30MxmNGN+PKi2hcpddhKeGmVhnG2i6PCo2x8n7nf9OdfZ/bzj+hgCOsewJh5alzN7e8wxAKpVy4loGkzlHhOt1NmDcrDXwi4XgKQe9NZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151648; c=relaxed/simple;
	bh=r1SkfVNj9bPZQxz4eJiuARml22W5WexeFCEA4WoTAhE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNmdUDdcEJSH5tyBTlfDcf6PWCuIYBToDfUwZWJfbObgYAR8E0dbV/i6t/Tnuf7iEhGF6hS6OEDhuiJWn3pZEa5wJ/ysLXXgbNBF+g44sIaFg6G97jfUKCvx5uAtefUHUSKauS4kphlcow4EfvzNbN+Wbvg/CGM2AM3t8Uga7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; spf=pass smtp.mailfrom=rnplus.nl; dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b=CosIn5k/; arc=none smtp.client-ip=178.251.25.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rnplus.nl
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 906DF37949B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2vRHyTsPZY-p for <linux-kernel@vger.kernel.org>;
	Wed,  3 Apr 2024 15:37:40 +0200 (CEST)
Received: from localhost.localdomain (184-179-179-143.ftth.glasoperator.nl [143.179.179.184])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 2BC6437947E;
	Wed,  3 Apr 2024 15:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1712151454; bh=r1SkfVNj9bPZQxz4eJiuARml22W5WexeFCEA4WoTAhE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=CosIn5k/pC1BTczzT1M+4joQcZbp4n7ILWW8+2LUwn+17UFB9/XFtruCrIC/knOkp
	 cz6ov+aZUrGlc2TpXaN9CvqURx13tabctFSqaKWIDf/xwo5vlUI97XZTPBHqpZvVQs
	 bmxf5CeBaVeJN8oXUrN8s/Cgm1tCmivWkrit1rJo=
From: Renze Nicolai <renze@rnplus.nl>
To: renze@rnplus.nl,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	arnd@arndb.de,
	olof@lixom.net,
	soc@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	joel@jms.id.au,
	andrew@aj.id.au
Subject: [PATCH v2 3/3] ARM: dts: Modify I2C bus configuration
Date: Wed,  3 Apr 2024 15:28:53 +0200
Message-ID: <20240403133037.37782-4-renze@rnplus.nl>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403133037.37782-1-renze@rnplus.nl>
References: <20240403133037.37782-1-renze@rnplus.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable I2C bus 8 which is exposed on the IPMB_1 connector
on the X570D4U mainboard.

Additionally adds a descriptive comment to I2C busses 1 and 5.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 66318ef8caae..8dee4faa9e07 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -162,6 +162,7 @@ &i2c0 {
 };
 
 &i2c1 {
+	/* Hardware monitoring SMBus */
 	status = "okay";
 
 	w83773g@4c {
@@ -219,6 +220,7 @@ i2c4mux0ch3: i2c@3 {
 };
 
 &i2c5 {
+	/* SMBus on BMC connector (BMC_SMB_1) */
 	status = "okay";
 };
 
@@ -243,6 +245,11 @@ eth1_macaddress: macaddress@3f88 {
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


