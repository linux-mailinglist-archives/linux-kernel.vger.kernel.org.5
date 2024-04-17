Return-Path: <linux-kernel+bounces-148427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656308A8269
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7750B25543
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8FB13DDD8;
	Wed, 17 Apr 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="KAES1WoT";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Orbo1jBi"
Received: from c180-16.smtp-out.ap-south-1.amazonses.com (c180-16.smtp-out.ap-south-1.amazonses.com [76.223.180.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773713D2B8;
	Wed, 17 Apr 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354598; cv=none; b=SvHwq81g+TCyqBo6XT6L36XdWGSioX+yoQSzhJgSMPU2iCnXNh6b3o6CgvcRAjRro8pTss0/0noS4vdQMHl7XQsePQ0P4llemZVnsa9ZG1h2La96JzJRtoTqh5OHNB2lx5T3HhXIsIWmgQW25k7L+k0KidVX8rdPK8p7ClUh0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354598; c=relaxed/simple;
	bh=UEdOs4UfnECnvOUdq3tW2tCJOukxn82iBBTNqs61wr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fewh0OdRhtbVixKHmYTR0Y7vIZFjMStbx6qVp3JCezoAz5kyEsiUV/bqPrGg66RfmDhU+ZGbc+wrUDnT9XWDEQ0uwVsAc/BdFoqbqY8umGRTwUUXQOQp3mmYMlzs3xpPMormE345+UhUzocwF7plxz4Sbhq1TVa7ZDOmeWtPSzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=KAES1WoT; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Orbo1jBi; arc=none smtp.client-ip=76.223.180.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713354594;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UEdOs4UfnECnvOUdq3tW2tCJOukxn82iBBTNqs61wr0=;
	b=KAES1WoTKvuGXsf7WUma1t96QaOSYRxbC+2vBa9i19ndVrbngxAwK/NlKQ0JyM9p
	NsHNwJbqv9bE4p0Wm1v20ins/NmO2MOO/XVsGZSgTQmlx+2De00P5VGj/DioeOHVyBn
	mBhwiRqSs/8hhfU9p4pjt+M7KN0FkdnE6ZOXXcid9sTSKy7PR7ubTFEfMGC7PoF0MFS
	WibTTyClFEWkTEn7gpxG1cFWAJeyN/p3dCUY1jyHm94K2uuQXk2/J2VIGGDlejW+ZA3
	weEz+gx2xEv3EEQV6XHsP9OqgA6KOMlIpr6ftPCBo5/ZIMaU3bw1acuN0z4KWWTQisN
	pu6GCM+BqA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713354594;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=UEdOs4UfnECnvOUdq3tW2tCJOukxn82iBBTNqs61wr0=;
	b=Orbo1jBiXPsRbrAilylrqXbG+PcahcrbfDxP74D/Dl79QK7/mZPGcZViws/9fnYU
	p+T2hEaz3MQ72JMqNlYnzSbisxdpY9IkhPNhHGdWldxl+B5gIM3mppHVOlmXI1d/vbq
	IHjnqy43VDxODtw1bOonlLCgz3uZo41oI/rc96/Y=
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
Subject: [PATCH v7 03/10] dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
Date: Wed, 17 Apr 2024 11:49:54 +0000
Message-ID: <0109018eebe4570b-95ede177-d891-420d-896e-c2b8c3efa16e-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417114934.186248-1-bhargav.r@ltts.com>
References: <20240417114934.186248-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.16

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


