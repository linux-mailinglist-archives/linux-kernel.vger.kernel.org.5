Return-Path: <linux-kernel+bounces-148615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AB8A8523
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B13C1F214AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C291411C3;
	Wed, 17 Apr 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="C/QaNKmH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="i/v8b+oa"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5C140381;
	Wed, 17 Apr 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361488; cv=none; b=X2IUXoiYr+Sa05kUJRsX5r2z4w9V8Vf909rWFiz8FvPV7zxip4zGazidvZpi1zvk44omtK5gezacHtnCSuJkHDaI6LRNqRFCu+UHCbrJ4+M/y0a2lVLhaYh1hRklZbisq9ThYiijUa0ERX5QJvSIoJkw4zyJ5obSuYBpNgJraJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361488; c=relaxed/simple;
	bh=NEaYgAWRd6TcMPM/LBwSVWln9/i/3Yena3DmCf4ovYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZ0GIwaca9O5T+4W99I/vL6GKe8OqHYU7srgk1NX9lJIbt3VxZVVVN1S0PQEYOS0RvNFyN6AnOWEOXhqC0wzGjCYeg8Au0rK4IF9X448/FPKTdJMHZB44nYNP9o2eEbUTwZgYovVgISLkamtQPKz0UCDUAjMufbhCevuBhqkQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=C/QaNKmH; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=i/v8b+oa reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713361486; x=1744897486;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=b3ELLPN+ySGYaDSAWWGeNI7utIoIFKJYGDkEJ6HDu/A=;
  b=C/QaNKmHD0PQBrtwgfcZ56sjR5FokPc5tZljQ2v1YsAA9Yjq1XjP+QUE
   FoYFbJ3ihmnc0wrWL8i77xBt6/hjb3B/c2TTQHZ27lnl5tHk3EljkbLyE
   m2jmPzIHYC+DqQ0QXXfy0yWU6gc3CtmKUytM8V2t0giwlPO4w4Poq+Gae
   bgtVAa4ag7YvFB5Z7KvhIEyu3T1MZwIIl9c2EZcxYjQ+hjv9LX79wOPi0
   izwQuyHlXntPXKn//Bec4J2ZZWPn+pc5LFx8E8RYsYXKWFFIdwgefBrmS
   JBlxVoqDKrO/sjV2QGBw5Z3Kb0SZg8gihKVDCdr/4lugiYORyiASUYGat
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="36469982"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 15:44:43 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA06D17306A;
	Wed, 17 Apr 2024 15:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713361479;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b3ELLPN+ySGYaDSAWWGeNI7utIoIFKJYGDkEJ6HDu/A=;
	b=i/v8b+oaWPEM44e21oTH/NIvw6b+HUaPep4JDDfuY3OOHWq1LyWsdt6GDmGviH3U16vVFf
	veZrLsGuJKsOrtHefQHh4N7QddNMO/ZwzCt8lG6tiQFuThhrwSBq0HJIxl5LGVfSF4Eu2t
	+CDcn16CRMQIT3qp5a8yfCyDnHBsihoW3lYj1PjqhhN6O17rT+SZP/AYcIsZoRr6SkbOQ3
	XtH4WwQv8vcHcQjG9gdWjJNs5Pu32UKKR1rU8TTI/4KsZCJnlnGA3eTmjfPrYZFTSrl3bx
	Boci8oKMsw4258wHKhtpZCGsY8lrB+f9y+A5vQs0u+L10L/Y7iB/N1/tpS4GIA==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 17 Apr 2024 15:43:57 +0200
Subject: [PATCH 4/4] dt-binding: can: mcp251xfd: add gpio-controller
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-mcp251xfd-gpio-feature-v1-4-bc0c61fd0c80@ew.tq-group.com>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 alexander.stein@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713361443; l=827;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=NEaYgAWRd6TcMPM/LBwSVWln9/i/3Yena3DmCf4ovYI=;
 b=/IY1DPKUqbMX8ny61LuUyhOymyEQXILW7azYSjzbg6Yp11Mhehe8Zww4yVU/L4yaoJtCuhWSK
 A6v1kB+T015ABBOKI3NciM37pAZEDNhSSSyuPzO4kMjeAQzmd3Uo+7j
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

The mcp251xfd has two pins that can be used as gpio. Add gpio-controller
property to binding description.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index 2a98b26630cb..e8a3ad4b1231 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -49,6 +49,8 @@ properties:
       Must be half or less of "clocks" frequency.
     maximum: 20000000
 
+  gpio-controller: true
+
 required:
   - compatible
   - reg

-- 
2.34.1


