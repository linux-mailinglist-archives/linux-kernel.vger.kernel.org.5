Return-Path: <linux-kernel+bounces-21950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E29829705
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7601F22621
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7F3FB27;
	Wed, 10 Jan 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="S8+AufQw"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24FC4776F;
	Wed, 10 Jan 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704881410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77sXWLAHqXDVC5wRoMijHbBW+M2cd0clYpjD4I2uM1s=;
	b=S8+AufQwFw2PeVpUuBfxpb15QbqWsJSS3MOKhgpnHZGiPFfX8HA8DDjZbkwI7G7WAzrL7s
	0D3p/ZSGuJ9Lx5PkwhATDeizVaQfgv52zTSZGrwlcCoKtNo0j07Um+oZIWMfU73tAgFNiR
	7dHWbcVWhHjYogIbB5H3bIFy1TD2MBk5KXAdXVzSMtBYgAp5+sK/m62GbYdrgI/YT1TMqN
	m2U2tU/APcpPSkms1Anf2+cZop399rh0mntUqn2Mg0Zq8t1e152fV/msaPZoVKCRK2z4ib
	PfEfopv6rS0Qiquf+vgFwqMYax0gdul6MM/Ml1SuK2EBNmiXbGgfNnnhfFo/Jw==
To: Mark Greer <mgreer@animalcreek.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] dt-bindings: nfc: ti,trf7970a: fix usage example
Date: Wed, 10 Jan 2024 11:09:13 +0100
Message-ID: <20240110100913.587849-1-t.schramm@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org

The TRF7970A is a SPI device, not I2C.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
index 9cc236ec42f2..d0332eb76ad2 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -73,7 +73,7 @@ examples:
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    i2c {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.43.0


