Return-Path: <linux-kernel+bounces-132489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA38995CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F02B23E3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054452D61B;
	Fri,  5 Apr 2024 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxKhsRUk"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC12C68B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299598; cv=none; b=oKM9si1dtz/AM30ZGFkZ5wbzQlkcfcS1k/+wQuEgRHPAwDjfTxjp75fZncWwX87+3fwp31AF03baf43JknGKXtrOhb1jnjOQn2l4Yoc1Gn09wtq/hpDYEXjv2LSgC2DIiKeEql78DFdxBnxsIBAALAGtsSFGaS/R3ghJmdftzxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299598; c=relaxed/simple;
	bh=waqetObMvnNvavo4PJvhq0indN1pJDU4Yd8ifTWsybE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjKuWmMTg+Gs02kn8oxV4a2PpNobDLtNIn4KaoLGxniScY99odMwPTYO2yTBd+wSSeJ94kjIabYDriyj3TAGmYreHLPrfxEpOMrVTj0bI/aJwB+q7rcT1BbBo9Dp+7dAcAYSPgPpOnuUfzspAK5lS1VjfvQq+0q9E3ZSZWA5b8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxKhsRUk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e2b41187aso1030165a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299595; x=1712904395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OsNd1Zvbhvpy0Prr8UcMcF9SUo+KwwufXMf2s1i4ho=;
        b=xxKhsRUkoQv4gFVbar8u20HXVSmNBKsuHItWRRyAyxzaSoOdSw/aURl+0yqJ8ztqXi
         cogvndTkfuq1LdgG/DUPrCC6zOv7kHz5M+G5ulQ7xKCNuMC7bpub2rzJu8gBSIKGX4OW
         5qtJampXVtTYBZz5axc90Hyj7f65Z4uGokvS07e0ofQsuXwGjiPasSgLeEXYTapVIG2x
         SOE4cdKMQjW2xEpsy4uHw3Uz9kQHf9xw+WWBclIpJubQHoK99ULHOXDnCYloqRsNzwII
         q4oBbS3icW2UQWQP1uRzA86dab7zBdndrav+Vy/ewy+jEyXA4BNzDMG19qWWzKr6yaBM
         RJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299595; x=1712904395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OsNd1Zvbhvpy0Prr8UcMcF9SUo+KwwufXMf2s1i4ho=;
        b=YnMiZSWaALyo+hRZg3uAmWVwAOVuPVR/DI7XSXVrAt0PyvrgLd4oqlrAdZyRKDwNh3
         1GHk7OSxHKYz+9sTzZwLau830cw+i9/RmfUXtDulDOwZfkmXk9cW6okh/UQhlA6mFsVc
         QdPoHIJUuHmy3V+KRuy5F0KKOjErx6BEygkDxNfV3fQyHhdYDZG9HwxYi2LuNHyKmo4w
         G9OFkF+8Et5S1/9W09ukqEqJcGITaup3aryXLFaKKiaxj+0AwfIhRPumMF0FTJb5n2u/
         fQrjKTwQQ+QVtKR3jp1/kxfuMre7I273EenU64BQEx9CVQ9WH4qJ/5zyPlDG7JkgVpJs
         aIwA==
X-Forwarded-Encrypted: i=1; AJvYcCWcyjf9INF+3rLneKUNk1ORjAvpSNAfE0ay7lRXWS3yZl0OcbfJ4RH+7zkyRD2QFxbCnAZTEaOZ29huFj+ErI8PTTeWSJYxRfdZRY4Q
X-Gm-Message-State: AOJu0Ywj4LUymIuXvYYZ6n70+bTudSvDUoIz8APvOibInT78oQVWODvW
	vN5JG8z+mvKJkzEJTEiigU7yfDfOPcY3Ve+1wGp9gBk6SiHiIZdOb6l+Po0hP4c=
X-Google-Smtp-Source: AGHT+IGcSW6YjVx2WoyiEZV2vm8/F8YAbla7uK0FkCvrxBbSwJQKhh3paZslTk5YzeC3tYo10mtLDw==
X-Received: by 2002:a05:6402:1c07:b0:56e:2d0a:b9f6 with SMTP id ck7-20020a0564021c0700b0056e2d0ab9f6mr891890edb.14.1712299595023;
        Thu, 04 Apr 2024 23:46:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id en16-20020a056402529000b0056e310e6655sm278888edb.68.2024.04.04.23.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 23:46:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 5/5] ARM: dts: aspeed: drop unused ref_voltage ADC property
Date: Fri,  5 Apr 2024 08:46:24 +0200
Message-Id: <20240405064624.18997-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
References: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aspeed ADC "ref_voltage" property is neither documented nor used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. None
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 1 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts | 2 --
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 7b540880cef9..3c8925034a8c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -813,7 +813,6 @@ bmc_ast2600_cpu: temperature-sensor@35 {
 };
 
 &adc0 {
-	ref_voltage = <2500>;
 	status = "okay";
 
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
index 9a6757dd203f..998598c15fd0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
@@ -211,7 +211,6 @@ &i2c13 {
 };
 
 &adc0 {
-	ref_voltage = <2500>;
 	status = "okay";
 	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
 			&pinctrl_adc2_default &pinctrl_adc3_default
@@ -220,7 +219,6 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 };
 
 &adc1 {
-	ref_voltage = <2500>;
 	status = "okay";
 	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc10_default
 			&pinctrl_adc11_default &pinctrl_adc12_default
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 1bd555a6c3ba..b4d003cbae8b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -596,7 +596,6 @@ i2c-mux@72 {
 };
 
 &adc0 {
-	ref_voltage = <2500>;
 	status = "okay";
 	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
 			&pinctrl_adc2_default &pinctrl_adc3_default
@@ -605,7 +604,6 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 };
 
 &adc1 {
-	ref_voltage = <2500>;
 	status = "okay";
 	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
 };
-- 
2.34.1


