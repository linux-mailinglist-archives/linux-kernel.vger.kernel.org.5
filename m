Return-Path: <linux-kernel+bounces-142375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F398A2ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCAB1F231E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C600B53804;
	Fri, 12 Apr 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGnGOBHq"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749714006;
	Fri, 12 Apr 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913500; cv=none; b=RVPuQlQOF2HiKniNRTtM+32YE8GQ3q+1RvmVk8OxipJzmMxi8S5RSzi8+OEZOFy92ftakLys7+dMNaomlSloCOlzEDJ2PZV6tbAP5jBvsB76OPGYAV2BUaY9dcfuOcZy0eaAdwyKVvySiSc3DzomtdSH746rTXi/ku0A7xj2A/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913500; c=relaxed/simple;
	bh=9WADVJJVD9uJ1S9KzLlikKR0zghswLsvPBCUmK13lFQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FStLSi5hmAdYqXaDXVRquOQ/BOraL3xWAteClm62XlVWadZhN6NSpJAqu0bosdirzCxrMwRE11HRdOmOCDQMSPfmvCsJgKgfnOxGihbcOoX1afU0qGXtXr5XbRSWcBE2kY05tYqU68ZXsy0OIlrWfWOGaSsI5TRXpMWskLbt4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGnGOBHq; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea1ef9e4e9so319413a34.1;
        Fri, 12 Apr 2024 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913498; x=1713518298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+fqIWtBV/T+80XSNaZFcmZX/ftnbYEEAJ0ueKG+0WM=;
        b=lGnGOBHq47voLstRMfhLejOQgukQK2LA8VqULgI7fOiAnCKXZp6SW9glprVw6Xj01q
         F4DHB1kG87dtpa0i8RqkXND8VV+BtDBbC2TjfAERIHF913n0Vsqn3Q/tZy1U4Tpmo0AN
         RHtc/pH/rwKyj11lUn+K3cvvmMXU1iuX+BEGmIWH9XMdF/TgjzKmjaRBpzQhpsHlu9Wt
         i78DFf7mW9QpACqeHmf9zFmMvXc01LSJBWmx4qicDEmK2V6o9R38cpw8L2vTmAiVqCGA
         q9KeWoGP42M10tOO35SuSscaYxsA0c55JlhFdPUFvuXlJl0WlcDx+kJ7700L5tgp4TUk
         YuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913498; x=1713518298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+fqIWtBV/T+80XSNaZFcmZX/ftnbYEEAJ0ueKG+0WM=;
        b=RpDggxI9g7gBa8sTnnufho6vemTJrqek+iDjHFYusC/8w73FbnizDNeMV9vR2oXcgs
         EEAgrxsDU/84hUs5jUZ0u8RhNrZezGaoxv2+SxP6D1KRsZaBFMmfGhvbFy0ZSt7AOlyh
         J3U2IB+NqgI3KLU5QD06fj7vFXpOuTiPJRUc9sGdHA/JKsNRL9nz9Cz+IGDpf6zoQ/oS
         ymE3vXeKT2Mbg0K7QbitWuKqFL7WZgdGSOlq5TkCxZeJB1aW76Qmh8NRlv7htmxzQByK
         +VJmefvXEO5Poe0+uZUzp3E3eMh91/K7tYPE3HMKznHeUmQ0vLD2WfZYB6G409nJ0vx/
         cD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzavIFeN/GBeJEu2kBUOtflmGIMbsTb/htQNbroBzBgJpdjsc7gnRR2/DvjFmH8fWOFiDzT6uayLcRjvBYCL7v5b2qFo1ezAKPOJoEbou5KL4PlGUx3avXAsxxbcbweDV0Ew1abKulJw==
X-Gm-Message-State: AOJu0Ywe8jaCMh7YGLyM/A/n+vPpSldFNEApGdiUJJ3bVT+iRbj7v4EE
	J6x/86lxuA8QXM/VpQpcEUPdPoemO2paL2lkGz6oEzTx7Dg2kp2Q
X-Google-Smtp-Source: AGHT+IF7wJIWrxBXDGre2KaDfG+Umj6T8KelYCmPYrslfD82jg2/QK85jfSzGd5FWv0aHhTq77ZZPQ==
X-Received: by 2002:a05:6830:1692:b0:6ea:d43:9db2 with SMTP id k18-20020a056830169200b006ea0d439db2mr2024550otr.4.1712913497944;
        Fri, 12 Apr 2024 02:18:17 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:17 -0700 (PDT)
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
Subject: [PATCH v5 05/12] ARM: dts: aspeed: Harma: Add spi-gpio
Date: Fri, 12 Apr 2024 17:15:53 +0800
Message-Id: <20240412091600.2534693-6-peteryin.openbmc@gmail.com>
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

Add spi-gpio for tpm device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 36aad01dda20..ca3052cce0e0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -28,6 +28,8 @@ aliases {
 		i2c29 = &imux29;
 		i2c30 = &imux30;
 		i2c31 = &imux31;
+
+		spi1 = &spi_gpio;
 	};
 
 	chosen {
@@ -67,6 +69,25 @@ led-2 {
 			gpios = <&gpio0 124 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 // HOST BIOS Debug
-- 
2.25.1


