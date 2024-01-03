Return-Path: <linux-kernel+bounces-15573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91034822E50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00693B21CB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFA61A27E;
	Wed,  3 Jan 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b2EV8F3h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61695199BD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F18E3F802
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704288542;
	bh=0q4qVCL28lgyouuyHQW1jAXVMv496RwqdrhrVphRrLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=b2EV8F3hYzJt6VAYCRYBs/yCgxuPMWhEfv/+hQzIStUe/dR55e51TORX0w75YT8a5
	 T1EXtAUQl9kKm3qjAFLcTqmezjIeP5Ge5bqtmHP/zubz/rpvwsM04eBa2JnlDPRaRf
	 SReQvOoOIaQ365ScLQ/Py76dDzKn8cOjS3L4+f7FGBY677y5DS8o3W5pqee0Obg7KF
	 obt/+1b76NYFjmTjYXrDWAZkRL1hg7JqU1sr1zY66ARSQv8ZgMtOeOHbyKpAhlbCx8
	 CTQH1iujT2JHD0geoE1UADzUYGPZBnVV6uKg7mJRsQ7dC+cTxteqLUogfgl0XMoOrB
	 K98spyNAfQZvA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9fd0a58549bso49996866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288537; x=1704893337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0q4qVCL28lgyouuyHQW1jAXVMv496RwqdrhrVphRrLU=;
        b=kNglPDStwEeLOTmEw3ExZmgULKEMH9EguVLvskaIF/5PpQ59AvqUT85IiBKEdx9Q3k
         eA3t0lxeT/7SQLrYufski+a+Yprze4R47jvrQHQHJ0eVqNnUOMWXtjYmmd6Q1Qm9ekUj
         YQM8J4IjNfkHozkIEetYnbAApchANIwsMzccy4HhUsqsNFmUvsgEjuo2KjPMXxZ8YwnX
         64bwSipYIsMK+St/0HWounGDCeVhnxrU2qk5JSZo9ogK0+Gc2F0tQIQ4zCKL04UE4iqB
         wTBVlgxUfcJqJ82j4znKPLPJplRc+oBZcJHm56q2isTB1t8XybwKS9tosg6wbc7FSW8g
         S0RA==
X-Gm-Message-State: AOJu0YyRKV3Nms9hafCkIyRb0DCViOW9uod6cyh1/1YAt8+RZCjf7+IW
	l5Bd4E7l0eESWGiY8G6BSyIfzLIj41vL+Yh1hRNQ+pd8FU7ehzdDT8okTO5cXnIQRozJlZDIrlL
	4y9y3qnwEeXyBDVI2Ay7Lvik1coTrGnSp56flAiCiv7hv8pGgNkNx0mdS
X-Received: by 2002:a17:906:3148:b0:a28:7191:b45c with SMTP id e8-20020a170906314800b00a287191b45cmr913108eje.37.1704288537609;
        Wed, 03 Jan 2024 05:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOKs0kME56k92k5vGgUD816ieBRpvwkjnTW39Klylw99PDVweylgaw2xEPfO2+zsSEHnmBmA==
X-Received: by 2002:a17:906:3148:b0:a28:7191:b45c with SMTP id e8-20020a170906314800b00a287191b45cmr913089eje.37.1704288537400;
        Wed, 03 Jan 2024 05:28:57 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:5af0:999b:bb78:7614])
        by smtp.gmail.com with ESMTPSA id eu18-20020a170907299200b00a26e53be089sm9549873ejc.44.2024.01.03.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:28:56 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 4/8] riscv: dts: thead: Add TH1520 GPIO ranges
Date: Wed,  3 Jan 2024 14:28:41 +0100
Message-ID: <20240103132852.298964-5-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add gpio-ranges properties to the TH1520 device tree, so user space can
change basic pinconf settings for GPIOs and are not allowed to use pads
already used by other functions.

Adjust number of GPIOs available for the different controllers.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index e65a306ff575..5eb841ba5124 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -223,6 +223,7 @@ portc: gpio-controller@0 {
 				gpio-controller;
 				#gpio-cells = <2>;
 				ngpios = <32>;
+				gpio-ranges = <&padctrl0_apsys 0 0 32>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -240,7 +241,8 @@ portd: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				ngpios = <32>;
+				ngpios = <23>;
+				gpio-ranges = <&padctrl0_apsys 0 32 23>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -265,6 +267,7 @@ porta: gpio-controller@0 {
 				gpio-controller;
 				#gpio-cells = <2>;
 				ngpios = <32>;
+				gpio-ranges = <&padctrl1_apsys 0 0 32>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -282,7 +285,8 @@ portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				ngpios = <32>;
+				ngpios = <31>;
+				gpio-ranges = <&padctrl1_apsys 0 32 31>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -424,7 +428,8 @@ porte: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				ngpios = <32>;
+				ngpios = <16>;
+				gpio-ranges = <&padctrl_aosys 0 9 16>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -448,7 +453,8 @@ portf: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				ngpios = <32>;
+				ngpios = <23>;
+				gpio-ranges = <&padctrl_aosys 0 25 22>, <&padctrl_aosys 22 7 1>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-- 
2.43.0


