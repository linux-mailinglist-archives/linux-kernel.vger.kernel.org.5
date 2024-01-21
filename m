Return-Path: <linux-kernel+bounces-32098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D854B83566E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906421F22D23
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB9376F6;
	Sun, 21 Jan 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="q1q7P7rM"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968B376E7;
	Sun, 21 Jan 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851669; cv=pass; b=QZm/yYcvO1ZE58cdsV8/y0xhI+M4gXLxCLAgpzRHNRXVNWooNBYDhV0JhR4S26GxLqEiSybMiSunc3Lyuf7rUBP2M2Mq5x+QfwT5wy4ioryGsE85WeOTwhzqNMtIkFCF1Gr+LmqKGifCrMRZQcYnbwzYJMZ3FLMj902r0Zsg+8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851669; c=relaxed/simple;
	bh=ZWAnbNX2A77f01fY1Jm8qIefZg4RE+HtH8CrZCSOWLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoVly4yAj0RCJ1QNeOSxM4p4HzFphltwNDO967PHHV+UmcWBr7s5X/inr+e1mm2943bzcbdD0yZZWpUo6M8PwBFEOsYnqtkje7WhPdI4eLyXW7vDjWq3M08B3XYhNvfSUfo3/eIADlbrvhFQso69ukBIHOY40UIIONNKrZRS2Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=q1q7P7rM; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1705851659; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gw666675PWOPgIIu3/i+rbesN7H/JWLT92hLYkK7muB+nS72M6N5VVC4z90hYkMerqN91mDd9EC/GisYKDG5KtIwisXu5wm4Rq+uVACHqu5ImaO/fO2C4TnYwSaXmnMksHG2uBILN3q15NOuuV8mN3RCAI6tbn1pPhOHRTxXt3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705851659; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cyagiiBoIXS1dCugNkX9WQAwzX03eRiQHiuPnM6GWHA=; 
	b=hBEFbgWTBD6qSJCB3Y0iVrqox8WFW8/0mDoHFybZootAWbSI+/ya/laxvzqMGpvNu0eFOKPS8vWpht0Rj8AKIsZ1bWWowtvXUvTA1Lwr5DepjWQrykmGH+ne5TW0/ZZbFfhuybPOGHOTPTJoFsw/u9BXPD3XtKLY8fOhdbgjH9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705851659;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cyagiiBoIXS1dCugNkX9WQAwzX03eRiQHiuPnM6GWHA=;
	b=q1q7P7rMXL3lsuaYk3bNqhRGXu/AytCi6g3LQd2OcLdb9B3sx2qAgD5DxoVIJyZR
	mk/y1XIEIiK1CBddsVAW+LK3Zj7Gsaoxe004hrE/4HODQ6CXdHomw1bGtVtjEW88Gg4
	4adwQBrdDOXgeUw04p/Z7kr5cIzObILtLZs+u7Jg=
Received: from tb.lan (182.118.232.129 [182.118.232.129]) by mx.zohomail.com
	with SMTPS id 1705851657832354.4997771838583; Sun, 21 Jan 2024 07:40:57 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/4] ARM: dts: qcom: msm8974-samsung-klte: Add label on /i2c-gpio-led
Date: Sun, 21 Jan 2024 23:39:56 +0800
Message-ID: <20240121154010.168440-2-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121154010.168440-1-i@rong.moe>
References: <20240121154010.168440-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Some variants of klte, e.g., the China edition (kltechn), have minor
differences to differentiate them from klte. This includes the GPIO pins
connected to /i2c-gpio-led.

A label is added on /i2c-gpio-led to allow DT of other variants to
reference it conveniently. Considering both LEDs and a GPIO expander are
connected to the node, it is named "i2c_led_gpio".

Signed-off-by: Rong Zhang <i@rong.moe>
---
 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
index b93539e2b87e..013946ccda0f 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
@@ -77,7 +77,7 @@ touchkey@20 {
 		};
 	};
 
-	i2c-gpio-led {
+	i2c_led_gpio: i2c-gpio-led {
 		compatible = "i2c-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.43.0


