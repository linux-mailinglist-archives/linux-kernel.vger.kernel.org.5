Return-Path: <linux-kernel+bounces-129861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0224897161
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3AF28AF0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D81148FF6;
	Wed,  3 Apr 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b="VxnvNx3K"
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41314884C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.25.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151643; cv=none; b=SLSzE1hMoYH7/hN1ACSlETmn19AZMW57FyghwQRu7f5z/997YTbOEMyl6RidrUxuU2c0p8n0U2g+znp4txBxNQvhxNq2J9m3oT8mfNSwCxcnX7sjhoY1LaEG5WVCGBX9PgPNbyupZIIBFXmEWG3XjWb4BzBHAQvUw0wDannZn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151643; c=relaxed/simple;
	bh=FIkSUNs/sbSf4YGW1uMUy2MIHSMnoVsTHAqBue/Rj2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxHv2dwBTEgzMYCDKmD24H/mrB7o5c+bPqyl3lzmndkkjdy2KjKhUIxJy4kvB0z4VvTHUo63Oq8kU/Ems+wp6gGP9fCjx45KLpmEYh4v5TeT0JaS+DbrY3uLvU5ycoQ9ZcCuDf+0OG+z/pVvO478tsYyB1dHUaPpmm5bfzg1BAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; spf=pass smtp.mailfrom=rnplus.nl; dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b=VxnvNx3K; arc=none smtp.client-ip=178.251.25.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rnplus.nl
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id D6B0737948D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0YXc4MUKzB1d for <linux-kernel@vger.kernel.org>;
	Wed,  3 Apr 2024 15:37:36 +0200 (CEST)
Received: from localhost.localdomain (184-179-179-143.ftth.glasoperator.nl [143.179.179.184])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 9705137945A;
	Wed,  3 Apr 2024 15:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1712151451; bh=FIkSUNs/sbSf4YGW1uMUy2MIHSMnoVsTHAqBue/Rj2c=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=VxnvNx3KCHNzIfzWa9MUtUbD8cvjAwRoqSRHFOmK5Xw6HO/ZVKMz90FJ7W9a8uWl9
	 ODCKkJfa64wt9RUCy5wNNOL0yN195qb1/Q2HCAGUsNOq56fap8ZuWjNNTRtmM19zoX
	 9XiWOwS7O/7ua21mCF3mOuCVlxAOsfkeXHeAx4j8=
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
Subject: [PATCH v2 1/3] ARM: dts: Modify GPIO table for Asrock X570D4U BMC
Date: Wed,  3 Apr 2024 15:28:51 +0200
Message-ID: <20240403133037.37782-2-renze@rnplus.nl>
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

Restructure GPIO table to fit maximum line length.

Fix mistakes found while working on OpenBMC
userland configuration and based on probing
the board.

Schematic for this board is not available.
Because of this the choice was made to
use a descriptive method for naming the
GPIOs.

 - Push-pull outputs start with output-*
 - Open-drain outputs start with control-*
 - LED outputs start with led-*
 - Inputs start with input-*
 - Button inputs start with button-*
 - Active low signals end with *-n

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 95 ++++++++-----------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 3c975bc41ae7..dff69d6ff146 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -79,64 +79,43 @@ iio-hwmon {
 &gpio {
 	status = "okay";
 	gpio-line-names =
-	/*A0-A3*/       "status-locatorled-n",                    "",                      "button-nmi-n",          "",
-	/*A4-A7*/       "",                                       "",                      "",                      "",
-	/*B0-B3*/       "input-bios-post-cmplt-n",                "",                      "",                      "",
-	/*B4-B7*/       "",                                       "",                      "",                      "",
-	/*C0-C3*/       "",                                       "",                      "",                      "",
-	/*C4-C7*/       "",                                       "",                      "control-locatorbutton", "",
-	/*D0-D3*/       "button-power",                           "control-power",         "button-reset",          "control-reset",
-	/*D4-D7*/       "",                                       "",                      "",                      "",
-	/*E0-E3*/       "",                                       "",                      "",                      "",
-	/*E4-E7*/       "",                                       "",                      "",                      "",
-	/*F0-F3*/       "",                                       "",                      "",                      "",
-	/*F4-F7*/       "",                                       "",                      "",                      "",
-	/*G0-G3*/       "output-rtc-battery-voltage-read-enable", "input-id0",             "input-id1",             "input-id2",
-	/*G4-G7*/       "input-alert1-n",                         "input-alert2-n",        "input-alert3-n",        "",
-	/*H0-H3*/       "",                                       "",                      "",                      "",
-	/*H4-H7*/       "input-mfg",                              "",                      "led-heartbeat-n",       "input-caseopen",
-	/*I0-I3*/       "",                                       "",                      "",                      "",
-	/*I4-I7*/       "",                                       "",                      "",                      "",
-	/*J0-J3*/       "output-bmc-ready",                       "",                      "",                      "",
-	/*J4-J7*/       "",                                       "",                      "",                      "",
-	/*K0-K3*/       "",                                       "",                      "",                      "",
-	/*K4-K7*/       "",                                       "",                      "",                      "",
-	/*L0-L3*/       "",                                       "",                      "",                      "",
-	/*L4-L7*/       "",                                       "",                      "",                      "",
-	/*M0-M3*/       "",                                       "",                      "",                      "",
-	/*M4-M7*/       "",                                       "",                      "",                      "",
-	/*N0-N3*/       "",                                       "",                      "",                      "",
-	/*N4-N7*/       "",                                       "",                      "",                      "",
-	/*O0-O3*/       "",                                       "",                      "",                      "",
-	/*O4-O7*/       "",                                       "",                      "",                      "",
-	/*P0-P3*/       "",                                       "",                      "",                      "",
-	/*P4-P7*/       "",                                       "",                      "",                      "",
-	/*Q0-Q3*/       "",                                       "",                      "",                      "",
-	/*Q4-Q7*/       "",                                       "",                      "",                      "",
-	/*R0-R3*/       "",                                       "",                      "",                      "",
-	/*R4-R7*/       "",                                       "",                      "",                      "",
-	/*S0-S3*/       "input-bmc-pchhot-n",                     "",                      "",                      "",
-	/*S4-S7*/       "",                                       "",                      "",                      "",
-	/*T0-T3*/       "",                                       "",                      "",                      "",
-	/*T4-T7*/       "",                                       "",                      "",                      "",
-	/*U0-U3*/       "",                                       "",                      "",                      "",
-	/*U4-U7*/       "",                                       "",                      "",                      "",
-	/*V0-V3*/       "",                                       "",                      "",                      "",
-	/*V4-V7*/       "",                                       "",                      "",                      "",
-	/*W0-W3*/       "",                                       "",                      "",                      "",
-	/*W4-W7*/       "",                                       "",                      "",                      "",
-	/*X0-X3*/       "",                                       "",                      "",                      "",
-	/*X4-X7*/       "",                                       "",                      "",                      "",
-	/*Y0-Y3*/       "",                                       "",                      "",                      "",
-	/*Y4-Y7*/       "",                                       "",                      "",                      "",
-	/*Z0-Z3*/       "",                                       "",                      "led-fault-n",           "output-bmc-throttle-n",
-	/*Z4-Z7*/       "",                                       "",                      "",                      "",
-	/*AA0-AA3*/     "input-cpu1-thermtrip-latch-n",           "",                      "input-cpu1-prochot-n",  "",
-	/*AA4-AC7*/     "",                                       "",                      "",                      "",
-	/*AB0-AB3*/     "",                                       "",                      "",                      "",
-	/*AB4-AC7*/     "",                                       "",                      "",                      "",
-	/*AC0-AC3*/     "",                                       "",                      "",                      "",
-	/*AC4-AC7*/     "",                                       "",                      "",                      "";
+	/*  A */ "input-locatorled-n", "", "", "", "", "", "", "",
+	/*  B */ "input-bios-post-cmplt-n", "", "", "", "", "", "", "",
+	/*  C */ "", "", "", "", "", "", "control-locatorbutton-n", "",
+	/*  D */ "button-power-n", "control-power-n", "button-reset-n",
+		 "control-reset-n", "", "", "", "",
+	/*  E */ "", "", "", "", "", "", "", "",
+	/*  F */ "", "", "", "", "", "", "", "",
+	/*  G */ "output-hwm-vbat-enable", "input-id0-n", "input-id1-n",
+		 "input-id2-n", "input-aux-smb-alert-n", "",
+		 "input-psu-smb-alert-n", "",
+	/*  H */ "", "", "", "", "input-mfg-mode-n", "",
+		 "led-heartbeat-n", "input-case-open-n",
+	/*  I */ "", "", "", "", "", "", "", "",
+	/*  J */ "output-bmc-ready-n", "", "", "", "", "", "", "",
+	/*  K */ "", "", "", "", "", "", "", "",
+	/*  L */ "", "", "", "", "", "", "", "",
+	/*  M */ "", "", "", "", "", "", "", "",
+	/*  N */ "", "", "", "", "", "", "", "",
+	/*  O */ "", "", "", "", "", "", "", "",
+	/*  P */ "", "", "", "", "", "", "", "",
+	/*  Q */ "", "", "", "", "input-bmc-smb-present-n", "", "",
+		 "input-pcie-wake-n",
+	/*  R */ "", "", "", "", "", "", "", "",
+	/*  S */ "input-bmc-pchhot-n", "", "", "", "", "", "", "",
+	/*  T */ "", "", "", "", "", "", "", "",
+	/*  U */ "", "", "", "", "", "", "", "",
+	/*  V */ "", "", "", "", "", "", "", "",
+	/*  W */ "", "", "", "", "", "", "", "",
+	/*  X */ "", "", "", "", "", "", "", "",
+	/*  Y */ "input-sleep-s3-n", "input-sleep-s5-n", "", "", "", "",
+		 "", "",
+	/*  Z */ "", "", "led-fault-n", "output-bmc-throttle-n", "", "",
+		 "", "",
+	/* AA */ "input-cpu1-thermtrip-latch-n", "",
+		 "input-cpu1-prochot-n", "", "", "", "", "",
+	/* AB */ "", "input-power-good", "", "", "", "", "", "",
+	/* AC */ "", "", "", "", "", "", "", "";
 };
 
 &fmc {
-- 
2.44.0


