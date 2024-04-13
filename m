Return-Path: <linux-kernel+bounces-143865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A18A3E7B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891961F21584
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ECC56770;
	Sat, 13 Apr 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDUJQK/v"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A205677D;
	Sat, 13 Apr 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039773; cv=none; b=iY0lCnldvfCOCUVs6xVQq4fA1d/2CHE34SsTCf4YShiEiLyuqVbPAMVsNIbTUlHFiV+0Sazn4e4kqi8N0lxLqyJBTD2Ns9n05KRKyH0GbvZZBL8VTYsVlfLXO4ecyN2ArZT67GZCu5nqxIBPvsuQNLw39evItCjV/C5x7srdpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039773; c=relaxed/simple;
	bh=MljIxyWTISU+l2odfMzkGB6VwOiZuuSwves7xqGR7H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6rA4op2mYrowl1M7yp8hsK/PxELwTHKyx7NsRSHRPP+HADLoNIvAvgNwOM7frik9Al5kr+A6T7XjEuTcFqhlktj1D1wzJoV2JkNUCxsEVhJNMcA4AKjTJMUwOYeYEM3hGKlhqVH8KErsYIr+SymP6w7wiI5aOtSQuIq3a5XywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDUJQK/v; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1921240a12.0;
        Sat, 13 Apr 2024 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713039770; x=1713644570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jSeqduTcQGsgyy//ksgmL2wkqDSRJ2+W9of4aqh+v0=;
        b=JDUJQK/v+FLPkiaJQkiWDFNdPtwcJG9uiyZpZNdFUklmFhrVOPSeh7HdJfJH6j+CAm
         xOcofnMoKz5+27yj9HTXyh5cGnwJ3AP73cEwus0rxPCxe07NddvvVCSoBFaLSp6c3qZv
         oVud4g9uvYs9UiHRwR4qBkthNkwDeeKnbRJAqER4d+wZH/HW2wbhmNZiD1F+Rr3F9z3O
         cnADMHtF0vEZm4c7+V3Pv4fmGL8zsQoGYj/TsKE68ri1FaJ+r5NYVD8OjKzkAziauZso
         ppahdt7pLuIP+NXVJFqqzlbpxFt7h96ouZdMhWTEvGXY5UjtL0UvshbTN7K8woygGlN5
         Eddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713039770; x=1713644570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jSeqduTcQGsgyy//ksgmL2wkqDSRJ2+W9of4aqh+v0=;
        b=tH8Zdd/nQFRNhwEk43TYSQV7Ct9V3X0Gu1Kg65YoCB2c0Yv4dY96lf9YbUEAx4At4u
         liCyGFDGfXOvxk5XTQ5v/KltiIhl7AliQ4abLxW1oUkd0KZcXtcqYdX9kj6Ow5i3h6WN
         IJhnB/miQ0kJF5vCEYns+mScwMfoYYRTfxMCFW/UH+gCsmG03sf2zdiZTo8EGLapkLiw
         iOgnle3G5OAB/76gHMczlBm1G6Ci4r1u/JhHL06PtQYEA8PopnDkipHSMPIEVJ8H3Kh9
         31TUFEW3+Ax6lhN8vId9ocL4miZ9znbf2qMxBQFXjJ+aIsJWMO9qvGSQcg4zmj9J3Kfi
         AMxA==
X-Forwarded-Encrypted: i=1; AJvYcCU+eVhps54XYZ4VtEJd4R8v0qYVt6lv5ZaUZpFOMEJjRG2K2tDlsCrX1YYZKehf70JliRUMHrGc1bXuQNma73HGxYGc5CbMZU/lzeVqyvSzucOvaqKsHnCkHc5Wybyw0QyJlXJGgCRcUQ==
X-Gm-Message-State: AOJu0YzauaYSx2/HnLSmfWgzO1RYZ59LTA3FJuNO8xbVoJmMHuLHvffK
	/8M5G49SD+XypTaLB18BA8D8Ih/aGvj1zLGP2THXrHRhUHESjMIW
X-Google-Smtp-Source: AGHT+IFI7Mf7+BKywKM8fQneaNYeKg0506rdVS6QAqUcQ7Sr40AdzNrF/+duFNOTOQ9+ESOR4ghevw==
X-Received: by 2002:a50:d49a:0:b0:56f:e585:2388 with SMTP id s26-20020a50d49a000000b0056fe5852388mr4401777edi.36.1713039769896;
        Sat, 13 Apr 2024 13:22:49 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id f16-20020a056402161000b0056e2f1d9152sm2881222edv.93.2024.04.13.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 13:22:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 13 Apr 2024 22:22:18 +0200
Subject: [PATCH v3 3/4] dt-bindings: rtc: pxa-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240413-rtc_dtschema-v3-3-eff368bcc471@gmail.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
In-Reply-To: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713039763; l=2124;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=MljIxyWTISU+l2odfMzkGB6VwOiZuuSwves7xqGR7H0=;
 b=0hoxOE3BWo7kiUwrQF39RyMoaHenD1MV06IuWnROQZSVZunX4H4UoO1i7iwQUSMpguSIn2XGd
 S1ID4OqYE1ID8dS9mbiLSrji4QpzQWpT85Iw6n/t53Y1eOSpUv3BPqf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

The missing 'reg' and 'interrupts' properties have been added, taking
the 2 supported interrupts into account to fix the example.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/marvell,pxa-rtc.yaml   | 40 ++++++++++++++++++++++
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  | 14 --------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/marvell,pxa-rtc.yaml b/Documentation/devicetree/bindings/rtc/marvell,pxa-rtc.yaml
new file mode 100644
index 000000000000..43d68681a1bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/marvell,pxa-rtc.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/marvell,pxa-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PXA Real Time Clock
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: marvell,pxa-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: 1 Hz
+      - description: Alarm
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@40900000 {
+        compatible = "marvell,pxa-rtc";
+        reg = <0x40900000 0x3c>;
+        interrupts = <30>, <31>;
+    };
diff --git a/Documentation/devicetree/bindings/rtc/pxa-rtc.txt b/Documentation/devicetree/bindings/rtc/pxa-rtc.txt
deleted file mode 100644
index 8c6672a1b7d7..000000000000
--- a/Documentation/devicetree/bindings/rtc/pxa-rtc.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* PXA RTC
-
-PXA specific RTC driver.
-
-Required properties:
-- compatible : Should be "marvell,pxa-rtc"
-
-Examples:
-
-rtc@40900000 {
-	compatible = "marvell,pxa-rtc";
-	reg = <0x40900000 0x3c>;
-	interrupts = <30 31>;
-};

-- 
2.40.1


