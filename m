Return-Path: <linux-kernel+bounces-27658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292CD82F3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A611FB22461
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448B1CD31;
	Tue, 16 Jan 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="1iw6Gtit"
Received: from mail.fris.de (unknown [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4711CF87;
	Tue, 16 Jan 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428694; cv=none; b=s6Vokf72EWzBX8dE2Bj4wsgFJnm3hHsGJRkrOIlrxJhiZq8MyZZgvyH5jEC3gQMSsfmqQOTgUMU1BVGwQy/FlQTqxw2epQDrBWQtIYHC+CdGYBWTJavgf0Ia6tW42usM/Y1+S5C/Qf0jHmfgxItBQU4UJXggjcP22QIHbSCCUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428694; c=relaxed/simple;
	bh=gY8YGXwKOb339LG32IE073RzsRu5jVChs1T+/qOikqM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version; b=Pnc55ItNnDLcYZZCQH8a04I1SQ8VkJAHCG8bm3HGEAa6dwVRlgn0VYYB0sAm6WpSPYyayUoVufDpc2Mld7wuQfKKErF4VHyzWChCQzcLfkeVk+CdRqab5GLoGEFuop8hq5hNTxaEZOZjW2+pwtKIAoC0cOf2uqfYY0EO5eE5xT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=1iw6Gtit; arc=none smtp.client-ip=116.203.77.234
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EABDC0359;
	Tue, 16 Jan 2024 19:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1705428690; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yjFpr0ZCRTUXhWOcwt8Uq8uGB9wjDpQAUtj/tOfndBg=;
	b=1iw6GtitMXQnbDzQJV/2A+ZknFJoJmt9ov8vJGEhzDS3CbtPE35CJK89oG7K8QDnPDW8+Z
	pam3fXuhCtk15kLDD8CRI7iLIAqPHTL3G+VUAPfVbOkJwELuqFle6krRa+9DbVrzTo2+CI
	CrZbyL/1+3IG/GqAJ2aK7sY8SzaU+TXS87G35/gqK0di7+ns1uqQn2muEaIcszm2e/rzSh
	O0bgAwip0OiSAbsmRygufW7esnBNGL6MR5nwXUYJbOmn7cGN1ohMEsWhakvETGImvC8yfT
	46RfVhkSB+HXPlugxq3s08Ryn+OPd+hkdfWZk+gtv5EVMSqp97HeAU22JyTYGw==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Sielaff
Date: Tue, 16 Jan 2024 19:10:26 +0100
Message-ID: <20240116181100.382388-2-frieder@fris.de>
In-Reply-To: <20240116181100.382388-1-frieder@fris.de>
References: <20240116181100.382388-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add "Sielaff GmbH & Co. KG Automatenbau Herrieden" (https://sielaff.de).

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
* Add Acked-by from Conor (Thanks!)
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c84..8825a9f60ac5a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1233,6 +1233,8 @@ patternProperties:
     description: Si-En Technology Ltd.
   "^si-linux,.*":
     description: Silicon Linux Corporation
+  "^sielaff,.*":
+    description: Sielaff GmbH & Co. KG Automatenbau Herrieden
   "^siemens,.*":
     description: Siemens AG
   "^sifive,.*":
-- 
2.43.0


