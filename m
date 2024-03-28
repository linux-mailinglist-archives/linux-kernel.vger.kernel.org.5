Return-Path: <linux-kernel+bounces-122281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250688F4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3744F29B593
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF422325;
	Thu, 28 Mar 2024 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRHZ6TVB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF5225CF;
	Thu, 28 Mar 2024 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589594; cv=none; b=JoFipMu0dv0N0z7UBnzXa7eM7H1bHnHTpi4E9hTvaJPDRblg3SsSgGSz+FP1HmgPDBkSk8zZKKK66KpQGed7zYj+gA3q/F1iyCUUb8/BOSwyYKdjL3NfqPxutpOlBFdTj3SE+awDOzumSq/eXJCZTSl5xBt46i4F7lUDi6ZlZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589594; c=relaxed/simple;
	bh=i2IRRjTZyiYex34MyWLMNAUhtzs5XV3CN9xcafzB4wU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYQl6T/QcJPW/envCHOg8nVv7klyTX+PYV2RE7AOLS58rhWsPiVrmu+qnj1SgiuDZmGE1TGwu3ZhYWi7z7pA8++CXlDHTBuve43EErHg2Z6BvvjyDVheOmUxDZxSWT6n4qNNb+4cfFta0ohIdhaCZpJAr85bQEB4995OnloIo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRHZ6TVB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e00d1e13a2so3748945ad.0;
        Wed, 27 Mar 2024 18:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589592; x=1712194392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axYCeiGWmH5zGIGoROlm87X0Iv4FCoHgVdnjtyDTc9Q=;
        b=gRHZ6TVBC32AqngKpSBAmeBN4YXw0AXhjJ3JFMhjr62cDDsy6AZ69B+6SknklAyc+x
         TId8TmTVh0r9uuh2aEzuXtZnqU91ENtaW/yzgeCepardkjC6vj1BKGiI8j5UEjiULtFO
         bwk1QE+zJTi0qNnL8yggu3TDeS5k+e7GEEjEBdeJcmZ/lCZ6i87/5MqAWOrM+DyDJuey
         n79YjMnN3xnSUrmWMOoOYra17jgySaapYYXcb7+GqhTYysleE0Gc9+1Tt5giiGfftAk+
         ojyorc2FX+lLQ8ZZ1x3QuH7zfNkoQKvep0jazNbIVCepycIxlNx0xWZdE0NulfMOAMWJ
         EK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589592; x=1712194392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axYCeiGWmH5zGIGoROlm87X0Iv4FCoHgVdnjtyDTc9Q=;
        b=CTWZcd/tfgf53QRSFnQ0rYC3JWr9jvqe1qlKzqpmP/e0QENNC+5+jy5cT+OklqYslJ
         YqDZx2U+iQln9kpG4ipWRH/lGmrqilOl6hsO6V9q0b4pz+dSSeKAe5bUYGoUGaElh3ZJ
         5sHCGO6ZyuRJvvreIQx2u68amGVFIgPyLruijdLUCCPSbl6UEo5xBiWz2tQRhPbfBeNy
         VZn5HA9/gOphsAMB3xFHRxyXQ6vAxKJwv4uDOYC2CtwpiQy0j8UQA0u/foM11Duy3SFp
         DglJqoLiAHlkrmkzP2FN0gxjcB8ENnXZq45iztA44DG8kRQXxS5tRkDeREM2kcX/qRUh
         0RxA==
X-Forwarded-Encrypted: i=1; AJvYcCWa5DSFbIv29/rLIbNtmo/EsTk8qOpSCc1OZGmlgcfZIBgCX16bnJwsM+ho+NVN5BsOccfxHd+WX9FnA2m9qu+6mXpGQbxe5dg+IIasohZ2PQu/W/XbULgu+qJe28GF/zew6sZKhl/mXBtrGZb4uiZ17DbqN8fmRTqcpsuc57IUujf74A68KAd/
X-Gm-Message-State: AOJu0YyYd1wE/Ktu78Dx44fi0F6Sm4tOeJ7Ohj1Vzi+cU/B8ib6rRTKp
	pNM0X7wsmYzBP+48Wb72+gnF6nSDTkMyFtCKSdSIeOJX3Iyrvx7m
X-Google-Smtp-Source: AGHT+IEZEoeW2NdDTGEuRTb0RH18Hq2hYgJ7S9WDoccBaiJjGZNW9oQwol0ryh3GxnsQsqJ4xh8gVQ==
X-Received: by 2002:a17:902:cf4b:b0:1dc:418f:890b with SMTP id e11-20020a170902cf4b00b001dc418f890bmr1550409plg.40.1711589592392;
        Wed, 27 Mar 2024 18:33:12 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-b4d0-66d2-2269-ef6c.emome-ip6.hinet.net. [2001:b400:e355:7eb0:b4d0:66d2:2269:ef6c])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001e0e85a21f5sm201338plg.32.2024.03.27.18.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:33:12 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] ARM: dts: aspeed: Add the AST2500 WDT with SCU register
Date: Thu, 28 Mar 2024 09:32:59 +0800
Message-Id: <20240328013303.3609385-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328013303.3609385-1-peteryin.openbmc@gmail.com>
References: <20240328013303.3609385-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AST2500 WDT references the System Control Unit
register for its operation.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 04f98d1dbb97..5fd12c057c31 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -410,12 +410,14 @@ wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785000 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt2: watchdog@1e785020 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785020 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt3: watchdog@1e785040 {
@@ -423,6 +425,7 @@ wdt3: watchdog@1e785040 {
 				reg = <0x1e785040 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				status = "disabled";
+				aspeed,scu = <&syscon>;
 			};
 
 			pwm_tacho: pwm-tacho-controller@1e786000 {
-- 
2.25.1


