Return-Path: <linux-kernel+bounces-60947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2778850B75
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C06A1F2237F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F1C5EE7A;
	Sun, 11 Feb 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVHdbPNt"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA75DF2E;
	Sun, 11 Feb 2024 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707683242; cv=none; b=rKhQiuWo0XnnvTY3NaH4MJOjumHOer56rb74LkpyWA5ooKhgZ/STXkBXqVWHGMyogOluKbCipV3BFOwzlJtJOVToKWjwbzioXXjzefN/owm53SyI56YwoVGEApzyw/bSncmPEz/yVWQZ8L1FB70eMCkzr2fv+WpvBFKyPys9fcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707683242; c=relaxed/simple;
	bh=Dr3fLzk8kA922HbxhveF4yYarebxt3ZJKSb4iwmQ3t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gt/iFu+pGKHOLDubL30DMbjKE8DeDYcczG9N5oRAwxGBjeu1h+L1QixIhRuH4zMs8n0U4ukw2wRsXT4MsZ8w1yex9kRtMPwnnO+ptwOjI5wYiLn6w3JBhGfH5phr7Q7X8W7pGMuwFTD43QpgKeBkkw4wVRFFXh3Y3dmw0K8HoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVHdbPNt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b815b182fso184401f8f.3;
        Sun, 11 Feb 2024 12:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707683239; x=1708288039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfjESUyL60qQjpBUzMKvPhhO/EQtTKQK2CnbnGbsaOw=;
        b=SVHdbPNtw1do72ozVA0tpVtqlKQTJw17MciGSXIQTZMVs1yoqfGLDqxiztV42sJ3Mo
         gyUGYXMbA43YkHjN1qn5gRia/svdxrB4bBp5iSZRik/hMTFSJq5PZp28njAcU9Lpo/Y3
         PwKOQ7nUwIBlkefZ+hohyNY9PG+8qtY2f7rh6HyQvaArQ68F6tcp6RmskKlagy+RrbSL
         d6pqechTvHYx3tTlDmoQbzfvn/AEDohuUwM+4FfF2WHxTT0n6ZdrPl2yqIsiBIwHrLcW
         uTA5m2oZWWgV8c1Wro3JiUbON37EbgOpVvbaLQ3X70p6wjiSSwmLuIssOQnMEMhFDBxn
         B9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707683239; x=1708288039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfjESUyL60qQjpBUzMKvPhhO/EQtTKQK2CnbnGbsaOw=;
        b=KXTdvkL3K4y/SKRt2PEaYuC9A061kjgNc7w4U6+eZqelS+ZmYdPg3nAK21xSQCMv7M
         iVbVbC8U/fFeVtO/+ViH/LIec9a1hEq+WUEKh6XTQHDtuL0ZwQoCaD3Z4NBvswvoKUda
         oGOoh7FLm/XRhqydFvKr94qo4hi24t/qtceyMXrr1yW0xinv9GhhRqTRhQpvJprUIgcm
         Mn180QI4hIoMRxQDtpU07csFfRxFvkTZCcXXmFThxQQBAWsSK8ndlvJrkkTNjyApjTEE
         19myw3c0UakuvId2u/A5FLD/jbAvMwcVqpR7o6FmgQTaqdym5hebDWVY8Xewm0aXC56U
         l+oA==
X-Gm-Message-State: AOJu0Yy4jhvozpkoBdvlF4ffR1hbr4tLeoX7S4AjE7GgXCUTwPbwqOZf
	QxYGUiuZPQ48jhUE//9/yJb3bc20jX35DjB7IhMcib4NWxXIeZKl
X-Google-Smtp-Source: AGHT+IFpzaOGbMHpBLmEW+9pJTDC0gg8iTM+pW6/GJz00psxpVJpc4GMU37OTQr/Nx7oUzfOMQaPyA==
X-Received: by 2002:adf:eec9:0:b0:33b:2281:ef32 with SMTP id a9-20020adfeec9000000b0033b2281ef32mr3718249wrp.69.1707683238705;
        Sun, 11 Feb 2024 12:27:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVb4O9ZzbLNsUmZmbrYbBo7NMd8GBzCdmP0OF72ZmbKMzTCONPiuBLBB5JUMLPH9briiTxQz1v1ydVeOhpQKsa/t2Aqodu5+s05jN88DircY7Z/xYgGnuhaw4Gw+EetsvPSZNPXWK7P8uE4D/yTiYP0g6X5ZWMfPiwen9CuDpHcAJouD1WT3GaqKqO5PkX4qxazNj8tZQp/BguxUwJnQ7YdW7rSMGNzugDW4i7bd0kXc7r65LjsLN1pu7JYVgg3VWckw2SrfsmeaAYCJ9JA7ROr2QfM6kOENeoAq2ak0k5MduDXy8f2ohG0rY7vrc=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r17-20020adfe691000000b0033aeb0afa8fsm4969194wrm.39.2024.02.11.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:27:18 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] ARM: dts: qcom: ipq4019: add QCA8075 PHY Package nodes
Date: Sun, 11 Feb 2024 21:26:55 +0100
Message-ID: <20240211202700.17810-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add QCA8075 PHY Package nodes. The PHY nodes that were previously
defined never worked and actually never had a driver to correctly setup
these PHY. Now that we have a correct driver, correctly add the PHY
Package node and set the default value of 300mw for tx driver strength
following specification of ipq4019 SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 35 +++++++++++++++---------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index f989bd741cd1..6c97d852d342 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -603,24 +603,33 @@ mdio: mdio@90000 {
 			reg = <0x90000 0x64>;
 			status = "disabled";
 
-			ethphy0: ethernet-phy@0 {
+			ethernet-phy-package@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "qcom,qca8075-package";
 				reg = <0>;
-			};
 
-			ethphy1: ethernet-phy@1 {
-				reg = <1>;
-			};
+				qcom,tx-drive-strength-milliwatt = <300>;
 
-			ethphy2: ethernet-phy@2 {
-				reg = <2>;
-			};
+				ethphy0: ethernet-phy@0 {
+					reg = <0>;
+				};
 
-			ethphy3: ethernet-phy@3 {
-				reg = <3>;
-			};
+				ethphy1: ethernet-phy@1 {
+					reg = <1>;
+				};
+
+				ethphy2: ethernet-phy@2 {
+					reg = <2>;
+				};
+
+				ethphy3: ethernet-phy@3 {
+					reg = <3>;
+				};
 
-			ethphy4: ethernet-phy@4 {
-				reg = <4>;
+				ethphy4: ethernet-phy@4 {
+					reg = <4>;
+				};
 			};
 		};
 
-- 
2.43.0


