Return-Path: <linux-kernel+bounces-78825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF386195C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A3B22D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFEF12D77A;
	Fri, 23 Feb 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GerLm7Fi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFC823A1;
	Fri, 23 Feb 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709056; cv=none; b=sg6ql+jfKZhlttpChWo0OUDJ35MqKwUmmFadO+F258IerYOqxcr5PQlu3oS7l/X94cIZc43w8HgcBTARURNZj1xY3KFGZwJGy+XeCi1PYN3S90EmJuUMaRGmE2pMaiEsMtNF1wDthiXMfh0H/Pv35Ap9pFbq0jpoQONLWBAaT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709056; c=relaxed/simple;
	bh=wnWXsy8zY6VRlAbrWYh9V7zguQIGEAQdCsEXb2Ur2W4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXdoXT4cZPBad+6p0K48HTCHW2ihYFjv5gxNHqk9sSrNUUB55kcpb/vkUSk+4yrh1t7KdMQf1Wc2OyqMu/W7xBTG3leieTLBUXvd0crFvy3bbOfGcVAqx26plSr1OADVOqN+doaZLbQyvx8gDId7amb1PSkvf5AD9E/eLzk7tuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GerLm7Fi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709054; x=1740245054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wnWXsy8zY6VRlAbrWYh9V7zguQIGEAQdCsEXb2Ur2W4=;
  b=GerLm7FiaaVVr/1cYD19q8eEe8MJqCjfZLlIzha9Ei7DDnKKEDWr961t
   334wXWQipjtb6ZtnQyF5ktHubrlS5g3PW9jj1D2Rp00nPN4mkagFFcYjv
   XJE7VxyVTkFpI/CPbG0uiyCvMr7ukBZ5m33o7Uy7/o7Kz5gvTomGmPlKR
   FbdDLE9Ck0Vq6+cjYix6/NjrbJwwK7+vXqTs9po9c2+t0aBSriEqwBcEZ
   uzq/6VPMHKInYCYz33Ft4aT+hC69yVFj0abuQQ9wSbs1EbESIqD9XISWd
   qTft6P2v4R44YzV5lBY5mICGoxVFnmDswbmxZiPC01cO0w0n/Bbx4afcc
   Q==;
X-CSE-ConnectionGUID: iohkZhWBQkWaq7QUPmZNTw==
X-CSE-MsgGUID: W6oFT/8mTwCJ6jlDgdbggQ==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="18276013"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:24:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:23:58 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:23:52 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<tudor.ambarus@linaro.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 03/39] dt-bindings: crypto: add sam9x7 in Atmel AES
Date: Fri, 23 Feb 2024 22:53:10 +0530
Message-ID: <20240223172310.671661-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add DT bindings for atmel AES.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
- Updated Acked-by tag
---
 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 0b7383b3106b..7dc0748444fd 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -12,7 +12,11 @@ maintainers:
 
 properties:
   compatible:
-    const: atmel,at91sam9g46-aes
+    oneOf:
+      - const: atmel,at91sam9g46-aes
+      - items:
+          - const: microchip,sam9x7-aes
+          - const: atmel,at91sam9g46-aes
 
   reg:
     maxItems: 1
-- 
2.25.1


