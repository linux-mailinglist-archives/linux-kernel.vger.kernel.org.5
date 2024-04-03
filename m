Return-Path: <linux-kernel+bounces-129859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677389715E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181F71F217F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CB01487F4;
	Wed,  3 Apr 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b="Z26dLVSh"
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69E1487F6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.25.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151639; cv=none; b=YRBSYgUsoZKIb0HHPUzmymEG6ku9oFiDmoc7neD/2po0iTehDR1jSjr+zLxNOWEzgH1+RYw8OFAEUptobSYtI0dx4Etv6MKHYf+Xf/69S2pi+nc84Ko8Jnnkn8CdKf/GxkFXROsb1Uee04hTcyaHUKQHId98hnlIvAkz5IYpqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151639; c=relaxed/simple;
	bh=J3x6v1j8NItiPEP2ALslVPQ+eLcuXH6rDPyikVVJs7U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmm1JNrUK4BpMUCXduJpikorasZYs8KoQp2G7pd424aeQyWBiSemRBMTv8tRUqh0r3mOpjRNa31zz4AwfR2SoJ/n3GAvbOrHdPOl9eCYstP+6odI//PC2eDIjiBY1F9vTeI044wv4J1syxM6NndDlrlCDTk6epsef7wZZP91ULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; spf=pass smtp.mailfrom=rnplus.nl; dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b=Z26dLVSh; arc=none smtp.client-ip=178.251.25.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rnplus.nl
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id AD67037945A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YG9MYdbFrW8M for <linux-kernel@vger.kernel.org>;
	Wed,  3 Apr 2024 15:37:38 +0200 (CEST)
Received: from localhost.localdomain (184-179-179-143.ftth.glasoperator.nl [143.179.179.184])
	by mail.rnplus.nl (Postfix) with ESMTPSA id CBDE337947A;
	Wed,  3 Apr 2024 15:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1712151453; bh=J3x6v1j8NItiPEP2ALslVPQ+eLcuXH6rDPyikVVJs7U=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Z26dLVShrOqZaVWeKDgn4w32mfSkcvgNAkOzrO3X9xDzIkQIu66+cACZmAdvbrv86
	 kjr6bffH0ynPQYYIyKPNwQN3B+4GBGuok9EkXfnQORJWkEPYozDDcDaQh61F3YxYbG
	 VMCxGa1Nm6fuT3UzR9LBOMwRqrUOitlAZI+IGJ1E=
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
Subject: [PATCH v2 2/3] ARM: dts: Disable unused ADC channels for Asrock X570D4U BMC
Date: Wed,  3 Apr 2024 15:28:52 +0200
Message-ID: <20240403133037.37782-3-renze@rnplus.nl>
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

Additionally adds labels describing the ADC channels.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 29 +++++++++----------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index dff69d6ff146..66318ef8caae 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -337,20 +337,17 @@ fan@5 {
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


