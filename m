Return-Path: <linux-kernel+bounces-78846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF38619AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D4D1F26D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E5013B794;
	Fri, 23 Feb 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IWmPmoYo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D812F5B5;
	Fri, 23 Feb 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709190; cv=none; b=FDJp+M1h4xnmhPzdxTHVjcdiQKGQUOe/M0q5w+IDSRg1PJI4zLN5VNgUzLqvIkAOZHKfh7slXmZfAwqyRoz4E1Z2UMJyfAQvkpNgWq0nyf0sgm7G4QW6VEqXuPnsDFddfRE726qW+4iRyrQKYMA1aXvdbhd9wuwzRfLwKEaQ6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709190; c=relaxed/simple;
	bh=Zuw2kUsXk1o2lkzNgp948IBHTt7y/pU6Q3zzvW0bjQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOWAhfTtQRJjNYI/aMSHiU1rm8dCtdKGW3+D3z929Xcbs7HeEM2fsVM4Wyb162PYnNbFCYpjsPhXFHb4XL4MAOOw3YqoQoDw/LdeMIXqgjs5wd8Gpjr9pjrmht1O8H+jQCXTVnKSpNwon1HBc5/kCODep9GM2gYYDrEbqRZKB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IWmPmoYo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709189; x=1740245189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zuw2kUsXk1o2lkzNgp948IBHTt7y/pU6Q3zzvW0bjQo=;
  b=IWmPmoYoElk0op8OC4HaMFP7mr9wLdEp/dnl2B1qlTU4lgv37jSZl35c
   83tYuIO+t4Up6yzR9p9xpJ16usyjq9+FOjOzN0hRs7VBoK3rlSM2C2HYj
   evQ0cwMfdNCm5J6fmOkMPWf/3LU04eHtdMeDs3TmKIlK5+z6bHma2Ht7z
   chs/4ZYj8QNxwQpbJgreqJwd3UiGDSuMHGdwDxamVDjDyFoPTLi5HKe2K
   xQZ5nfkVPrnzxBH+fmHjTigJz7EURDzGapR/evAUjNzWIjXnxUp8YlUxP
   tw8DkvtKs3Q1bgFDcb4FmqivsuNDZz7f0f8pqymEhE+H+67Sze+jN6aJs
   g==;
X-CSE-ConnectionGUID: t18HA6KHT7+gZ8BIMsEZ6A==
X-CSE-MsgGUID: IB6QRYiQRsut+YfRq1SLEA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16734497"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:26:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:26:18 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:26:14 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 13/39] ASoC: dt-bindings: atmel-classd: add sam9x7 compatible
Date: Fri, 23 Feb 2024 22:56:08 +0530
Message-ID: <20240223172608.672190-1-varshini.rajendran@microchip.com>
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

Add sam9x7 compatible to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Changed the subject prefix matching the subsystem
- Removed unwanted '-items' from the syntax
---
 .../devicetree/bindings/sound/atmel,sama5d2-classd.yaml    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
index 43d04702ac2d..ae3162fcfe02 100644
--- a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
+++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
@@ -18,7 +18,12 @@ description:
 
 properties:
   compatible:
-    const: atmel,sama5d2-classd
+    oneOf:
+      - items:
+          - const: atmel,sama5d2-classd
+      - items:
+          - const: microchip,sam9x7-classd
+          - const: atmel,sama5d2-classd
 
   reg:
     maxItems: 1
-- 
2.25.1


