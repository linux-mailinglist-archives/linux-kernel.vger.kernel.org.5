Return-Path: <linux-kernel+bounces-142383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B358A2AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC252832FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6B524B8;
	Fri, 12 Apr 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyj5UWD0"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0723C5732E;
	Fri, 12 Apr 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913518; cv=none; b=pDSA5mLkcjiN/nIVca8GtBslgPbWZ1b3vngoafTRlLQDU0MySsy/3ITh2miXR2NBnN+3j/cY9KjKhSvaZ1utVq8HkV559aoJsEfAQf3Yjlfgy48UopgjihCyVleOedcpkd1zD3b67oyY99vYYGdNqqevZ3TcPNA0DNv9EnCsSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913518; c=relaxed/simple;
	bh=Ryy/lwApd8/64leqR7ninfDTgUFolUziygAVRILXylw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRh77hEtXkL0xZTmnkOChXkvv2cWttyMg7kl5qQ3RWxbdph0Unnh72RFO5psn4B08ZO6PydXpJU8sEumUI0rQBb5g/ME+zJ/IO2KYRNq6eKz1TnRce8kEaAZr0ic5kduYo0qmShNAdxwJYu+pOMB/EdTGMFZ9Paw9gohrxaIFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyj5UWD0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so559688a12.3;
        Fri, 12 Apr 2024 02:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913516; x=1713518316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLhEm1cQTgYq4Cay+gDZBnFx7MCkPnHfSrf0in79+7k=;
        b=iyj5UWD0usEUt2Isa24ieemlJV7DW5zN7i3OHjq2BU8DxUiA9F2Hx1Oha0e6LAyC7w
         1NfnSCkII2BS5GHn7HDIRXBiN+RwjFUMpCQ+FNKIexZLNp5nd/J9VOCCD8/g1t8hza2O
         EoOeUYdvTL+fV6UYkdjPkgV8wRFmG85yzO3Awfey9A+F9pjxBfFwUGieMbJ4T1eq4JMr
         h3xoCf23RS3ywgZkYAilUUNboGpanl29e40xptT26G9uz5wSOgSnPBAJup4iEARsEOVw
         Hr3E6pAk+dvtEizCGvovZaaBrjTzZk7rGYOYOUJgu6nkeIsXmObdLUZwZqpfLMdw5aty
         9AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913516; x=1713518316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLhEm1cQTgYq4Cay+gDZBnFx7MCkPnHfSrf0in79+7k=;
        b=mlr7/JVkcF5usl9dIQGnbQ+v98ZN1zgNdwVm13/fYMkjLhuHH3LxzZpJ8uDh4DH3YK
         4a9Lft5ZPkJtNN2xQ54vskbZ4ML+eHul9qUlw0X+sReNkOdkL1Hr+j5w2YmqVmrLCu4B
         i4Vr7bfQBoEa4ko44VbTrKL5rNwub2FNDv75/QbkYUEgKiP59GOOCYuMddt9+MPsbZhu
         nt640Q+Ycr7dKVnprhVcLkrr43/2yHFOOsI8EBNc9RxsWMf/PM6jMxWctoDp7CtFCBR2
         7Wdb8chHRwlSaXPsx/rK7bF2g8p9XmpbCJMXg+2ZuSOZcJxjIbxWNaLzni8GUCee9LgI
         ugXw==
X-Forwarded-Encrypted: i=1; AJvYcCWzFgC/5ASI7S/2WaqPw1XESjQpJEm/orCi+eXPuchCp1iQ5iVDk+2I0j43TbMc/X66dogaAAMOSZHxTGLkKE8BGpXaxLvnKcWfD0hWT/GdQc5oIM34ctXTMulVjwLDmvtLtVvDFph8Dw==
X-Gm-Message-State: AOJu0Yxqwwhf3khPe2KLnCpby531nuw+wTDACsT0jpBiz9Dp3JUkDlwz
	npfaziA/0F1CSqGnXk4+c6GvKGLpzsxdyb49V6HfdgzDF2ImX7Ts9YVDBQ==
X-Google-Smtp-Source: AGHT+IGlb1alqgq8RG5vCcKY5zvrVt/1FkUs9Nblo1e0iPMP4ckeJANiyp3bwgt0kBCN42Zklkd+bA==
X-Received: by 2002:a05:6a20:a11e:b0:1a7:54b4:8e84 with SMTP id q30-20020a056a20a11e00b001a754b48e84mr2667412pzk.10.1712913516383;
        Fri, 12 Apr 2024 02:18:36 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:36 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/12] ARM: dts: aspeed: Harma: Modify GPIO line name
Date: Fri, 12 Apr 2024 17:16:00 +0800
Message-Id: <20240412091600.2534693-13-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add:
"reset-cause-platrst", "cpu0-err-alert", "leakage-detect-alert",
"presence-post-card", "ac-power-button", "P0_I3C_APML_ALERT_L",
"irq-uv-detect-alert", "irq-hsc-alert", "cpu0-prochot-alert",
"cpu0-thermtrip-alert", "reset-cause-pcie", "pvdd11-ocp-alert"

Rename:
"power-cpu-good" to "host0-ready",
"host-ready-n" to "post-end-n

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index a5abb16e5d8b..e7f4823ca4b3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -332,6 +332,12 @@ gpio@31 {
 		reg = <0x31>;
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","","","",
+		"","","presence-cmm","",
+		"","","","",
+		"","","","";
 	};
 
 	i2c-mux@71 {
@@ -471,7 +477,8 @@ &gpio0 {
 	/*A0-A7*/	"","","","","","","","",
 	/*B0-B7*/	"","","","",
 			"bmc-spi-mux-select-0","led-identify","","",
-	/*C0-C7*/	"","","","","","","","",
+	/*C0-C7*/	"reset-cause-platrst","","","","",
+			"cpu0-err-alert","","",
 	/*D0-D7*/	"","","sol-uart-select","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
@@ -480,7 +487,8 @@ &gpio0 {
 	/*I0-I7*/	"","","","","","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","",
+			"leakage-detect-alert","","","",
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"led-postcode-0","led-postcode-1",
 			"led-postcode-2","led-postcode-3",
@@ -499,7 +507,16 @@ &gpio0 {
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-	/*Z0-Z7*/	"","","","","","","","";
+	/*Z0-Z7*/	"","","","","","","presence-post-card","";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/ "ac-power-button","","","","","","","",
+	/*18B0-18B7*/ "","","","","","","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","","","","","","";
 };
 
 &sgpiom0 {
@@ -548,10 +565,10 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"power-cpu-good","reset-control-smb-e1s-0",
+	"host0-ready","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
 	"","reset-control-smb-e1s-1",
-	"host-ready-n","reset-control-srst",
+	"post-end-n","reset-control-srst",
 	"presence-e1s-0","reset-control-usb-hub",
 	"","reset-control",
 	/*E4-E7 line 72-79*/
@@ -602,13 +619,16 @@ &sgpiom0 {
 	"SLOT_ID_BCB_2","",
 	"SLOT_ID_BCB_3","",
 	/*K0-K3 line 160-167*/
-	"","","","","","","","",
+	"","","","","","","P0_I3C_APML_ALERT_L","",
 	/*K4-K7 line 168-175*/
-	"","","","","","","","",
+	"","","","","","","irq-uv-detect-alert","",
 	/*L0-L3 line 176-183*/
-	"","","","","","","","",
+	"irq-hsc-alert","",
+	"cpu0-prochot-alert","",
+	"cpu0-thermtrip-alert","",
+	"reset-cause-pcie","",
 	/*L4-L7 line 184-191*/
-	"","","","","","","","",
+	"pvdd11-ocp-alert","","","","","","","",
 	/*M0-M3 line 192-199*/
 	"","","","","","","","",
 	/*M4-M7 line 200-207*/
-- 
2.25.1


