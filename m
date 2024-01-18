Return-Path: <linux-kernel+bounces-30307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1043831CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627F5285C31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1997A2C84E;
	Thu, 18 Jan 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ijWZhiKg"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219628E34;
	Thu, 18 Jan 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593196; cv=none; b=Dv/r6mUkd7Udcf/PPWa2Z5M1CRrQ0Wo35aGEKUSPdICLOsV/lkrh5DwY97ljtyzbTilvQwZGipSkqd2znnuw7iW75Iq1UsCZeU7k5MhrDHZCWY+g2s6PAysLKfQh7mTMIzbEBeiWUS1eYzxF1n4xdYOSlajIHRz7Y/2iwfh5MYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593196; c=relaxed/simple;
	bh=F69lXcW+BMK3xWuWKAunG1z8qeZUfL/FLTg148TbGsU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl; b=Kg5YqeMbu6mDDxrY4T8G2LVxZ0xqTPodeip4G747Wa6uwl0PfSV3XTCJe8FPXyvEeUm/rMz3O9VqCVZanKSjbKjo9uZNezZJ6JLtgp0lZU6yeI2wyw8/LuagWwIviWpe6HZ/lJgCNlfPa4c9sKAbuKNXslKBOVMLAqC3EG2Mhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ijWZhiKg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B17721BF212;
	Thu, 18 Jan 2024 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbsWh/XsZeOFv6yit27z5l5/TqUISO3EzDeBeQy/R68=;
	b=ijWZhiKgkJq5am+gqMcsVyU23bFlF4705SsoMF9vBww7ioslE8wTmPvTsrHxNEEM5GCBQR
	C2mA04RSa9WzjJvuLYF2t+83FMw9iRKYFc1IX3WbHfW3RQKnOZEK/y7mKigW1WKt1/mETX
	YB5peySdq4KEZqBjsF1NqNwuNQVjT2kF3TE9PcMotv/7eWiQrTj2ALeY60AUMzH6Gs8ny+
	m3pjTOXz5d6OoFkZoB3Z8cG8iHNj0iApONC9eQFkKm5NJjz3tPprB3RVtTDgMfZRggmcQP
	Ght9qEnhVNuOcaML90e+/jxpLWIvzHb3g5soFz1NrGHaZuvLwRglm070HiueyQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 08/15] dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
Date: Thu, 18 Jan 2024 16:52:37 +0100
Message-ID: <20240118155252.397947-9-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118155252.397947-1-gregory.clement@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

The MIPS Warrior I-class I6500 was announced by Imagination
Technologies in 2016 and is used in the Mobileye SoC EyeQ5.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
index 9bc47868d28b6..a85137add6689 100644
--- a/Documentation/devicetree/bindings/mips/cpus.yaml
+++ b/Documentation/devicetree/bindings/mips/cpus.yaml
@@ -23,6 +23,7 @@ properties:
       - brcm,bmips4380
       - brcm,bmips5000
       - brcm,bmips5200
+      - img,i6500
       - ingenic,xburst-fpu1.0-mxu1.1
       - ingenic,xburst-fpu2.0-mxu2.0
       - ingenic,xburst-mxu1.0
-- 
2.43.0


