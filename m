Return-Path: <linux-kernel+bounces-155427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21D8AEA35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D914A1F2522E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E889713B7A3;
	Tue, 23 Apr 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbKvEl6D"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521C19BBA;
	Tue, 23 Apr 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884858; cv=none; b=rdua6uV2+UBVOVnXVZPca51c/goNWX+Bt6uG+x+/js926O0+Czj6Xa/3p6fngL0bQXyjbEa3/8muL3CGDFCn3upj4jsF0ikAsgErwGy8oUp8VMNNnfQUxw4k8Bk3kd9bat9MjgEJBTUAihxVfqJP/eu2QJKCF94ForrixZVeGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884858; c=relaxed/simple;
	bh=OpryniUhacXvT+jwKnN9JD+OqrCMzhvmCJwpKgY4lDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWkUQCleKYb/Uy2uLPNwfAEqyHuZgZV63EKHBdyAyPGWEacmsHQdWJu99SH2FmRzoA2EE0c86RCSwFWvYOPyrPnvJw9rmT16dq8dyPhusIzB4OPUmAXnDcMmqSyuNEqcg7/tBqbqRHrp98d0/qIysjF32AkNEpQj6atO2GkgHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbKvEl6D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3e84a302eso39723405ad.0;
        Tue, 23 Apr 2024 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713884856; x=1714489656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9jAPKslWEHbYajpa27t1FegoOa1s+mENv2urCZsTbo=;
        b=GbKvEl6Ddz69VO+CsaMWCv5iHzHhovdpFyhLvO28OV34qXU8X2w4fwBZZndSeXG9tB
         c6OxmroKBCD3ydZq1IMYyN/wMTXNyl4bTpVEJTPk8/V7DnrXbxfSvGaqkCzvKs07KmWZ
         x9+Cy3fRLRm1hF0fEORzEEpq1fNDgaax+vfJTfuWQ00h6P+oPoWlDTxtWASEhcp8UYJ8
         7w2905eK/ByNgupOhgAc5zNkJTc8pY099qSZQN4SD7RScTZ4ABXo8eZkhGODmFCMH4QU
         MvCef+d6AJIMnjrq8B60KhBQZscm5dLiV62p96vJnbKZe01TipV/xtDDDwNcxosviCRc
         rSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884856; x=1714489656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9jAPKslWEHbYajpa27t1FegoOa1s+mENv2urCZsTbo=;
        b=BUuK9XfKytbKlJknS5bhrp4Ki3FJV7vmGWnN4+ftrUL4dpBTf/T8bERomgnWKWYsw1
         rWwxRmX2krwSMzWxGiOXGRXiu9sid7YVhdmyO44VUIsjkcDuXSWpmlIbqnqk5t/7026K
         AJZ2dUEZ9FhybC0NewNjs/uT8CUrFDa1Hta2CZJRzkt9ThiQUzA0LXrT5pPFl9HPb/iU
         0f/YCD+v9NbXy30IZXYcOBGhPXlOMoajg50YUd7kAO8/At6ME9Uu5Ia2WpwJakk7HXHE
         KymJetmw0+lQiXFpOVrofovXydYUAkNJjW5LB/tft3Udo4owiCA7NQO7TMqGniitj21Q
         so+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHaMDw+2iLhGg+6m9T/Gc0U6/ntzoAmClZmSt0bCRSCecd9x+SWxuxf38fExXgVf/MGKbKcvP/UJA8pPn6o6D8ixfoybmwmf+XHiagY8aEPMpTE9l1neComhj4zJOge/7YWOLfLr1y3A==
X-Gm-Message-State: AOJu0Yy5Dcp4i6it04cYez61WwY3F0lpRaw3lF/eta+DbZtlTljVCigZ
	XBJwXji/4AMYc5p9gDZ0KekFvXSMW3YJP3K29ZDbbyz30srrthe9JT7fX2uSWzM=
X-Google-Smtp-Source: AGHT+IFyeGNaKQ3MtjhFbkhiM5QlNv4AidkVdhowp13Q/vGdKyGSEGaUtLkITjCXEdxPJ8CuwFKDlQ==
X-Received: by 2002:a17:902:f68f:b0:1e3:cdd1:dd80 with SMTP id l15-20020a170902f68f00b001e3cdd1dd80mr15952841plg.6.1713884856060;
        Tue, 23 Apr 2024 08:07:36 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id j9-20020a170903024900b001e8d180766dsm8100853plh.278.2024.04.23.08.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:07:35 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vt8500: replace "uhci" nodename with generic name "usb"
Date: Tue, 23 Apr 2024 20:37:25 +0530
Message-ID: <20240423150728.91527-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "uhci" nodenames with "usb" as it's generic and aligns with
the schema binding.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
 arch/arm/boot/dts/vt8500/vt8500.dtsi | 2 +-
 arch/arm/boot/dts/vt8500/wm8505.dtsi | 2 +-
 arch/arm/boot/dts/vt8500/wm8650.dtsi | 2 +-
 arch/arm/boot/dts/vt8500/wm8750.dtsi | 4 ++--
 arch/arm/boot/dts/vt8500/wm8850.dtsi | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/vt8500/vt8500.dtsi b/arch/arm/boot/dts/vt8500/vt8500.dtsi
index b7e09eff5bb2..f23cb5ee11ae 100644
--- a/arch/arm/boot/dts/vt8500/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500/vt8500.dtsi
@@ -115,7 +115,7 @@ ehci@d8007900 {
 			interrupts = <43>;
 		};
 
-		uhci@d8007b00 {
+		usb@d8007b00 {
 			compatible = "platform-uhci";
 			reg = <0xd8007b00 0x200>;
 			interrupts = <43>;
diff --git a/arch/arm/boot/dts/vt8500/wm8505.dtsi b/arch/arm/boot/dts/vt8500/wm8505.dtsi
index 168cd12b07bc..d9e1280372c5 100644
--- a/arch/arm/boot/dts/vt8500/wm8505.dtsi
+++ b/arch/arm/boot/dts/vt8500/wm8505.dtsi
@@ -213,7 +213,7 @@ ehci@d8007100 {
 			interrupts = <1>;
 		};
 
-		uhci@d8007300 {
+		usb@d8007300 {
 			compatible = "platform-uhci";
 			reg = <0xd8007300 0x200>;
 			interrupts = <0>;
diff --git a/arch/arm/boot/dts/vt8500/wm8650.dtsi b/arch/arm/boot/dts/vt8500/wm8650.dtsi
index bc057b6f7d16..35d12d77efc0 100644
--- a/arch/arm/boot/dts/vt8500/wm8650.dtsi
+++ b/arch/arm/boot/dts/vt8500/wm8650.dtsi
@@ -185,7 +185,7 @@ ehci@d8007900 {
 			interrupts = <43>;
 		};
 
-		uhci@d8007b00 {
+		usb@d8007b00 {
 			compatible = "platform-uhci";
 			reg = <0xd8007b00 0x200>;
 			interrupts = <43>;
diff --git a/arch/arm/boot/dts/vt8500/wm8750.dtsi b/arch/arm/boot/dts/vt8500/wm8750.dtsi
index 33aeb37491f4..b292f85d4e69 100644
--- a/arch/arm/boot/dts/vt8500/wm8750.dtsi
+++ b/arch/arm/boot/dts/vt8500/wm8750.dtsi
@@ -257,13 +257,13 @@ ehci@d8007900 {
 			interrupts = <26>;
 		};
 
-		uhci@d8007b00 {
+		usb@d8007b00 {
 			compatible = "platform-uhci";
 			reg = <0xd8007b00 0x200>;
 			interrupts = <26>;
 		};
 
-		uhci@d8008d00 {
+		usb@d8008d00 {
 			compatible = "platform-uhci";
 			reg = <0xd8008d00 0x200>;
 			interrupts = <26>;
diff --git a/arch/arm/boot/dts/vt8500/wm8850.dtsi b/arch/arm/boot/dts/vt8500/wm8850.dtsi
index 65c9271050e6..c61717ebb4f1 100644
--- a/arch/arm/boot/dts/vt8500/wm8850.dtsi
+++ b/arch/arm/boot/dts/vt8500/wm8850.dtsi
@@ -244,13 +244,13 @@ ehci@d8007900 {
 			interrupts = <26>;
 		};
 
-		uhci@d8007b00 {
+		usb@d8007b00 {
 			compatible = "platform-uhci";
 			reg = <0xd8007b00 0x200>;
 			interrupts = <26>;
 		};
 
-		uhci@d8008d00 {
+		usb@d8008d00 {
 			compatible = "platform-uhci";
 			reg = <0xd8008d00 0x200>;
 			interrupts = <26>;
-- 
2.44.0


