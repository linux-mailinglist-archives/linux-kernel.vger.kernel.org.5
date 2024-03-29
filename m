Return-Path: <linux-kernel+bounces-125049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC1891F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060A91F2F587
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181D85950;
	Fri, 29 Mar 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b="fBVHIO8h"
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB513D8AF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.25.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717349; cv=none; b=ukU2JOZTEHb7LCYshF7dM2q9If/Vn1Cq7A3aB8l2h9OySDs8oYXM1me0QENgYNa2XhYsSwpU87Zblan/OH+jWZnNuaxtBsZuF02aMHdRRE4EyN7M2fQ3d6GOH9aqhD3Zz/eKYUT6BqiNMnaV/a80dYlegEkKMCmOCiztuGv72uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717349; c=relaxed/simple;
	bh=5PYPUmi19U+0jj9vdpCCTkSTJgKRWQ8R0dIQUA2UZbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlP6RgxRklZcJyoPfStzyqlJ9TzS7pPrdGUdDWu8pzj2B8CXdcByJ4RBMAKJ9TQZOMg7912a2DtkpYEcIfZOYneEGXdrGgH8ViFeyT2yR7skJasmObvrqA9aiLM4zxeU50pVlMKb7Gxn2vqPY0nCmKTjFI2kv91cpMuhYCEE6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; spf=pass smtp.mailfrom=rnplus.nl; dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b=fBVHIO8h; arc=none smtp.client-ip=178.251.25.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rnplus.nl
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 25736379494
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J6VXY4_AXJKG for <linux-kernel@vger.kernel.org>;
	Fri, 29 Mar 2024 14:05:47 +0100 (CET)
Received: from localhost.localdomain (184-179-179-143.ftth.glasoperator.nl [143.179.179.184])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 0672237947A;
	Fri, 29 Mar 2024 14:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1711717526; bh=5PYPUmi19U+0jj9vdpCCTkSTJgKRWQ8R0dIQUA2UZbQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=fBVHIO8hCb0A1p99N4Btml3jm86eC3uivf3DR0owUhSW/RIz4SyzKyclEFfEIRA9N
	 e4bGLksiqZcXJvb1IK9ksr7jtCAnTY7rp5VYUzdcER72DPzZimAZz46tVqaI5MTp/Y
	 Ug/v3hWNqdjOfWBLFEBcORdoxnLk+ecl5Kk3gwto=
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
Subject: [PATCH 2/3] ARM: dts: Disable unused ADC channels for Asrock X570D4U BMC
Date: Fri, 29 Mar 2024 14:01:40 +0100
Message-ID: <20240329130152.878944-3-renze@rnplus.nl>
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

This commit disables unused ADC channels and labels the ADC channels used with their function.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 29 +++++++++----------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 34bc382bf492..e93c2f0b8414 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -358,20 +358,17 @@ fan@5 {
 &adc {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc0_default
-				&pinctrl_adc1_default
-				&pinctrl_adc2_default
-				&pinctrl_adc3_default
-				&pinctrl_adc4_default
-				&pinctrl_adc5_default
-				&pinctrl_adc6_default
-				&pinctrl_adc7_default
-				&pinctrl_adc8_default
-				&pinctrl_adc9_default
-				&pinctrl_adc10_default
-				&pinctrl_adc11_default
-				&pinctrl_adc12_default
-				&pinctrl_adc13_default
-				&pinctrl_adc14_default
-				&pinctrl_adc15_default>;
+	pinctrl-0 = <&pinctrl_adc0_default       /* 3VSB */
+			&pinctrl_adc1_default    /* 5VSB */
+			&pinctrl_adc2_default    /* VCPU */
+			&pinctrl_adc3_default    /* VSOC */
+			&pinctrl_adc4_default    /* VCCM */
+			&pinctrl_adc5_default    /* APU-VDDP */
+			&pinctrl_adc6_default    /* PM-VDD-CLDO */
+			&pinctrl_adc7_default    /* PM-VDDCR-S5 */
+			&pinctrl_adc8_default    /* PM-VDDCR */
+			&pinctrl_adc9_default    /* VBAT */
+			&pinctrl_adc10_default   /* 3V */
+			&pinctrl_adc11_default   /* 5V */
+			&pinctrl_adc12_default>; /* 12V */
 };
-- 
2.44.0


