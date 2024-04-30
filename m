Return-Path: <linux-kernel+bounces-163977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969728B76C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FA01F2409C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDEC172769;
	Tue, 30 Apr 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="SOiYZRDu";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ecbIntZt"
Received: from c180-15.smtp-out.ap-south-1.amazonses.com (c180-15.smtp-out.ap-south-1.amazonses.com [76.223.180.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606317166C;
	Tue, 30 Apr 2024 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483016; cv=none; b=egUdpJ2hoEHYUPZY9M3DuqAHgLZ/BxnX/cv9Y0bAJItz0nmSZH57HDMftQv5Zb1KuDupOyDbe2QsigF7CFnipdsCvvFIwtK1oXDqApiAXjMgU6xAQBxSc5sTsfeWxNbCx7Me9IVsgO7zx/lsh+3zmQz8KHy5n72nk+FEvW1wscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483016; c=relaxed/simple;
	bh=UEdOs4UfnECnvOUdq3tW2tCJOukxn82iBBTNqs61wr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KW6WF9pqmC5lHXXb6C8wAHHy3rXN7+TvSc+sXmovGHTElxF3bTVYaavhuBNnnQnzfuDJeTiIoPOwjQNG0ZA4t0Yd1xqEzuG4vZAP3P/II+Ml/ncYApQcvfRr9hLfohxCJx7oYFTiH4liZjjgEEDwFSp2QpYGmpnINBzpNujrhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=SOiYZRDu; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ecbIntZt; arc=none smtp.client-ip=76.223.180.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1714483012;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UEdOs4UfnECnvOUdq3tW2tCJOukxn82iBBTNqs61wr0=;
	b=SOiYZRDuVfswCYD4AOrZQ8E+x2moHXUYtMBq/gRoKqo90Wx6WmhQMQoTrq85eksH
	RThx0Bbkv7DW6M5uZ/q2zwcKb9q+pIHJR+7hzyg9FmonQZOtbfwNl0LXwRHVnH2bI1s
	mvwjSh/af3Ms74CztVIB5EmPhluK4RGdKInQ3TXEkY+7Q6HoHqOOu5AJu0IIGMZowPd
	Eub/Q63HdPZ02m/1PXkYTbYHu58OStUlrwBmfGBu5K0j2h7BxGTy53CqjYYyb/Ojll3
	HcShcmqPbzjt3jXgp7NzI9rmZ+mIUf+S3pknc1M1kt5vnmjVaQpN9NaCftfzi4Pg1OY
	RFMpFlFd3g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1714483012;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=UEdOs4UfnECnvOUdq3tW2tCJOukxn82iBBTNqs61wr0=;
	b=ecbIntZtZqZ3KEEUxDWOnVN5Pm2mNGyzeFmY8fxA2BAmUmbjvVXgyCO1U2fqNbSz
	3jAhJSuzFd+qm0OVqB/NPe1T6ViI83A2v4xXMXSKzdWOrmlYDKdGBTogeP2wKAkBFYz
	1RHWqJM2dRagol8e6Sbobl695ij4DmfKb+5rbO6w=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org, 
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, 
	kristo@kernel.org, eblanc@baylibre.com, 
	Bhargav Raviprakash <bhargav.r@ltts.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 03/10] dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
Date: Tue, 30 Apr 2024 13:16:51 +0000
Message-ID: <0109018f2f26a14f-157bb3a2-2f9b-4653-a619-46e1feb8f229-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
References: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.30-76.223.180.15

TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
regulators, it includes additional features like GPIOs, watchdog, ESMs
(Error Signal Monitor), and PFSM (Pre-configurable Finite State Machine)
managing the state of the device.

In addition TPS65224 has support for 12-bit ADC and does not have RTC
unlike TPS6594.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
index 9d43376be..6341b6070 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
@@ -21,6 +21,7 @@ properties:
       - ti,lp8764-q1
       - ti,tps6593-q1
       - ti,tps6594-q1
+      - ti,tps65224-q1
 
   reg:
     description: I2C slave address or SPI chip select number.
-- 
2.25.1


