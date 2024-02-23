Return-Path: <linux-kernel+bounces-78851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA58619BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EF01C246EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1F13DBA8;
	Fri, 23 Feb 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RYnC3Tz8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27813DB94;
	Fri, 23 Feb 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709235; cv=none; b=trEUg4MPcjd4fIoXuZ6SX3MAQDceR07+9zc52jBJUs0nysVZ3SK8cIYUKl2uA3ZPAgWHekxIXz/SuDRaS8cAyUlpjUIsT15Nqy/J7RzBUuyV9iFaOYCDfKaD1kcX8yoVGDOlVvMdevwwRh/s8ZKMoW80wix3odZqgmUpVpK6kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709235; c=relaxed/simple;
	bh=W5BmSshd0oXFwwOasjjhvcfbUwIqu6xmPd/ui1WyGEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndD06Nlf0KyMW44iShKk2via0ansYIyK8tyEJ8+guLCsjHuNBh8qsCGCUtRlIllj9D+1OZUsDpvLmNHuAHquA5wq37oapcBFq3bFR4QQFnhv3JkjaWClmJ0eBygD9IeZT02uNtbnLQktffRvcq+z4B4njB8+hlM6SK39ZDIuysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RYnC3Tz8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709234; x=1740245234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W5BmSshd0oXFwwOasjjhvcfbUwIqu6xmPd/ui1WyGEQ=;
  b=RYnC3Tz8YMlbxxIqaiqERWZNxpveLsY3yfsrW2EEPrWUaDcuFC1VW+Ga
   Y4eCPTwYzypQcRwfg9XuIXKELXWyWnJcj5q60+DJY7Hsm9ye2A+zWeASr
   3lA7ZuNT+1NHu4KOKA9lp9atON4QDugOX5TkrSO21PagRw/QtwPTaJ3KU
   5eFCn4U5ggRtODTFVoOkky4+t7QfsKbixkTPaaBZZVzd0lhQitV9zVHHo
   0TGaou0RYpADxNf4QE9Be1CPJH0JbTVBpYSBDyTRMwmkx9+SMDTbDtlAH
   usXB5uFjSLrUm8hna/GtOiVLProHyJDuqKxkn4Tn2z87GqSXAcrCVGMAS
   g==;
X-CSE-ConnectionGUID: WGdUDJySTO6s5AHkHy7fsA==
X-CSE-MsgGUID: kYk6deLtTtCG69UPyi3Npw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="18276155"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:27:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:27:04 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:27:00 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <codrin.ciubotariu@microchip.com>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 17/39] ASoC: dt-bindings: microchip: add sam9x7
Date: Fri, 23 Feb 2024 22:56:57 +0530
Message-ID: <20240223172657.672439-1-varshini.rajendran@microchip.com>
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

Add sam9x7 compatible in the DT documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v4:
- Updated Acked-by tag
---
 .../bindings/sound/microchip,sama7g5-i2smcc.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
index 651f61c7c25a..fb630a184350 100644
--- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
@@ -24,9 +24,14 @@ properties:
     const: 0
 
   compatible:
-    enum:
-      - microchip,sam9x60-i2smcc
-      - microchip,sama7g5-i2smcc
+    oneOf:
+      - enum:
+          - microchip,sam9x60-i2smcc
+          - microchip,sama7g5-i2smcc
+      - items:
+          - enum:
+              - microchip,sam9x7-i2smcc
+          - const: microchip,sam9x60-i2smcc
 
   reg:
     maxItems: 1
-- 
2.25.1


