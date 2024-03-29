Return-Path: <linux-kernel+bounces-125051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A7A891F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C51A1C28962
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78F13E033;
	Fri, 29 Mar 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b="p5XN+y9z"
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4D13DDB8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.25.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717352; cv=none; b=Kb6/PtoF4QwbQnaSPMlstjqQaTRnvB3bxoKvbcEKsdxt+iUHGzHDmQWo8CDDujlhP6YPWEPp1HREZE7OjJaqYvK4XeAfPaI+e+cnbc+v6jBg3DiBqJN1OgNnOIck404wjqOsWtEIjcBkMn4PYlt20wwC5h7GFTRfiRNqXc2g/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717352; c=relaxed/simple;
	bh=4G+G6BuM+cMP6rEZ/uaw8UHoFG85g2A3tKcOaMLiEvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLTxvbdVQnntasBzA+TVvnlRbmOnmgmTPsCkm3vppuMpSaO9/5gylgjtoxqi/EcjYKbk6227LASPq95dfQrxDrORLg0NOOxXlp/LNAdRhLyqB+6heSwY8yIwp2u6qupIrRLDG91e2NT0IqtKctf/BkPAS1vHAI5hvOj81HPbKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; spf=pass smtp.mailfrom=rnplus.nl; dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b=p5XN+y9z; arc=none smtp.client-ip=178.251.25.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rnplus.nl
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 809B2379488
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqvzPpLHAdhp for <linux-kernel@vger.kernel.org>;
	Fri, 29 Mar 2024 14:05:43 +0100 (CET)
Received: from localhost.localdomain (184-179-179-143.ftth.glasoperator.nl [143.179.179.184])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 973463793D7;
	Fri, 29 Mar 2024 14:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1711717525; bh=4G+G6BuM+cMP6rEZ/uaw8UHoFG85g2A3tKcOaMLiEvY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=p5XN+y9z9I88hiQ3MEw1lqBDxoGJmvKX6uSVIi2OFwnC9lkaTMyjSFhCkMcC5LMct
	 DFnvhpI0EiaxtGx5oecuoGkg5W2zT62KRg1gh3zW+5NWzbpIEcSJNZ9LK4M2VBeWw+
	 lOsD2AWixC3PcL/5CHSH0g5GB22Mb3frtKO7c9wk=
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
Subject: [PATCH 1/3] ARM: dts: Modify GPIO table for Asrock X570D4U BMC
Date: Fri, 29 Mar 2024 14:01:39 +0100
Message-ID: <20240329130152.878944-2-renze@rnplus.nl>
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

This commit removes button-nmi-n, this board does not have support for an NMI button.
Input status-locatorled-n has been renamed to input-locatorled-n to better indicate the signal type.
The suffix -n has been appended to the name of control-locatorbutton, button-power, control-power, button-reset, control-reset, input-id0, input-id1, input-id2, output-bmc-ready to reflect the inverted signal polarity.
GPIO output-rtc-battery-voltage-read-enable has been renamed to output-hwm-vbat-enable, input-alert1-n to input-aux-smb-alert-n, input-alert3-n to input-psu-smb-alert-n, input-mfg to input-mfg-mode-n and input-caseopen to input-case-open-n.
And GPIOs input-bmc-smb-present-n, input-pcie-wake-n, input-sleep-s3-n, input-sleep-s5-n and input-power-good have been added.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 116 +++++++++---------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 3c975bc41ae7..34bc382bf492 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -79,64 +79,64 @@ iio-hwmon {
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
+	/*A0-A3*/       "input-locatorled-n",                     "",                      "",                        "",
+	/*A4-A7*/       "",                                       "",                      "",                        "",
+	/*B0-B3*/       "input-bios-post-cmplt-n",                "",                      "",                        "",
+	/*B4-B7*/       "",                                       "",                      "",                        "",
+	/*C0-C3*/       "",                                       "",                      "",                        "",
+	/*C4-C7*/       "",                                       "",                      "control-locatorbutton-n", "",
+	/*D0-D3*/       "button-power-n",                         "control-power-n",       "button-reset-n",          "control-reset-n",
+	/*D4-D7*/       "",                                       "",                      "",                        "",
+	/*E0-E3*/       "",                                       "",                      "",                        "",
+	/*E4-E7*/       "",                                       "",                      "",                        "",
+	/*F0-F3*/       "",                                       "",                      "",                        "",
+	/*F4-F7*/       "",                                       "",                      "",                        "",
+	/*G0-G3*/       "output-hwm-vbat-enable",                 "input-id0-n",           "input-id1-n",             "input-id2-n",
+	/*G4-G7*/       "input-aux-smb-alert-n",                  "",                      "input-psu-smb-alert-n",   "",
+	/*H0-H3*/       "",                                       "",                      "",                        "",
+	/*H4-H7*/       "input-mfg-mode-n",                       "",                      "led-heartbeat-n",         "input-case-open-n",
+	/*I0-I3*/       "",                                       "",                      "",                        "",
+	/*I4-I7*/       "",                                       "",                      "",                        "",
+	/*J0-J3*/       "output-bmc-ready-n",                     "",                      "",                        "",
+	/*J4-J7*/       "",                                       "",                      "",                        "",
+	/*K0-K3*/       "",                                       "",                      "",                        "",
+	/*K4-K7*/       "",                                       "",                      "",                        "",
+	/*L0-L3*/       "",                                       "",                      "",                        "",
+	/*L4-L7*/       "",                                       "",                      "",                        "",
+	/*M0-M3*/       "",                                       "",                      "",                        "",
+	/*M4-M7*/       "",                                       "",                      "",                        "",
+	/*N0-N3*/       "",                                       "",                      "",                        "",
+	/*N4-N7*/       "",                                       "",                      "",                        "",
+	/*O0-O3*/       "",                                       "",                      "",                        "",
+	/*O4-O7*/       "",                                       "",                      "",                        "",
+	/*P0-P3*/       "",                                       "",                      "",                        "",
+	/*P4-P7*/       "",                                       "",                      "",                        "",
+	/*Q0-Q3*/       "",                                       "",                      "",                        "",
+	/*Q4-Q7*/       "input-bmc-smb-present-n",                "",                      "",                        "input-pcie-wake-n",
+	/*R0-R3*/       "",                                       "",                      "",                        "",
+	/*R4-R7*/       "",                                       "",                      "",                        "",
+	/*S0-S3*/       "input-bmc-pchhot-n",                     "",                      "",                        "",
+	/*S4-S7*/       "",                                       "",                      "",                        "",
+	/*T0-T3*/       "",                                       "",                      "",                        "",
+	/*T4-T7*/       "",                                       "",                      "",                        "",
+	/*U0-U3*/       "",                                       "",                      "",                        "",
+	/*U4-U7*/       "",                                       "",                      "",                        "",
+	/*V0-V3*/       "",                                       "",                      "",                        "",
+	/*V4-V7*/       "",                                       "",                      "",                        "",
+	/*W0-W3*/       "",                                       "",                      "",                        "",
+	/*W4-W7*/       "",                                       "",                      "",                        "",
+	/*X0-X3*/       "",                                       "",                      "",                        "",
+	/*X4-X7*/       "",                                       "",                      "",                        "",
+	/*Y0-Y3*/       "input-sleep-s3-n",                       "input-sleep-s5-n",      "",                        "",
+	/*Y4-Y7*/       "",                                       "",                      "",                        "",
+	/*Z0-Z3*/       "",                                       "",                      "led-fault-n",             "output-bmc-throttle-n",
+	/*Z4-Z7*/       "",                                       "",                      "",                        "",
+	/*AA0-AA3*/     "input-cpu1-thermtrip-latch-n",           "",                      "input-cpu1-prochot-n",    "",
+	/*AA4-AC7*/     "",                                       "",                      "",                        "",
+	/*AB0-AB3*/     "",                                       "input-power-good",      "",                        "",
+	/*AB4-AC7*/     "",                                       "",                      "",                        "",
+	/*AC0-AC3*/     "",                                       "",                      "",                        "",
+	/*AC4-AC7*/     "",                                       "",                      "",                        "";
 };
 
 &fmc {
-- 
2.44.0


