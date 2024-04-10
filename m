Return-Path: <linux-kernel+bounces-138931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5289FC29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE90CB27FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B416F853;
	Wed, 10 Apr 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YogFa6fE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BD171091;
	Wed, 10 Apr 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764553; cv=none; b=Fw1C/2x07WCMBLnD7+H5LASsm3Xr32IbvSrsx9QNb8T+V+NX22K0g71cp9YtmRMJQRoxxfVIyFF3ZBcSHJ0gcGL1mV5y4uGYUkAoFQAHfeT4BAFCXEvX3UNELjAr2/M6X64k/1rYOykmAvNZWb1h41R2/N26pRGee91Qrgjp1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764553; c=relaxed/simple;
	bh=MljIxyWTISU+l2odfMzkGB6VwOiZuuSwves7xqGR7H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CzwxONn4N/lbp+9vXEH+Pxx4aJckfHQV5uuPuqsuH/VXbfO+WmHdHg5uv65Dd7Cb+ZH7WQX9nIYdLPzrEtA+DHYJkEHRYaubt+JVVw2jWUU8/EjDpZHmRlrgBCORKp5KzoAp5XLHkmEpZq28z3c3r6vJIrgxWOG4+3wMGVsB7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YogFa6fE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so4364722a12.3;
        Wed, 10 Apr 2024 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712764550; x=1713369350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jSeqduTcQGsgyy//ksgmL2wkqDSRJ2+W9of4aqh+v0=;
        b=YogFa6fE4mWXn2IR9fWx43NWA1ylCxUQjmwAjcL4UMBYiZ2XXrB4XO5mCktZ4ZdCaI
         6JJYLvjIK7pn+vUP0d+UvO4e2TC4vGmoapfrgcl4m//b4Hv2C4samSr1BhrVuM/DiQbo
         A2I0MrRxEBXEZO2tyMA0+W4DOH5+kuukXyqMnHq3uRKQXxZoTa/DxtU+RdWBY/7jz8xC
         rW15HitMi4h9MnOvwTw1/HpKEyvrDN2f81+ENlf5dWl6Qce24HeTxDKgSJxzMbYO9qjM
         3sdzwBuwqBJ8X6Og2q3ueiA7MCvWtuObsOEFrHGtYH+iDxujHHzwZp76pw9BQkP2a+SQ
         yU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764550; x=1713369350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jSeqduTcQGsgyy//ksgmL2wkqDSRJ2+W9of4aqh+v0=;
        b=IfOr/v6qEepDoleYeaRHd8ma+94JJ5r2UdwOYIGknyOWcOg+UdMVui9qUutEOLDcYD
         AkZCx/zzaFTZj1PPF0LmVQhmITX8eadjf1C/Mn2h/pQ4YcfqhWlStcGlkBE5RDcM1J0x
         jUY/vQG5TBi47ALbklrLbWXpHQkfNc9aUhNXxhEoyIi1W+rf//+6d85+jN0lwaM0Z5Rd
         h76yJvdcb7CIxPQOT8DzH/D8yFQmlKeSqX1he839aOZsNBBTAFYVnJTWDRv5vrH6Q6aM
         jJmrGFUFsycu6ixtCxMocBJs8f90Ec1NT08YaaUHu3QiAEVfNCkaTR6oKdk6SB+KoJDn
         +B+w==
X-Forwarded-Encrypted: i=1; AJvYcCVKxmk2Lemh6MQ76ezb7wq1Re4MVdRYMzP9NjLevJ0H7MYPN5HtF643IvJpAaDdiZbtjQtTW+HaYQ75RbuYnCPD9KzorHTj5uvb9DTj2gUttWrFEfQe8SB58CcJqcFwr82YUo6AFfkbhA==
X-Gm-Message-State: AOJu0YzDIiryMaHm2c2YbPEi2Q3nDVPcwcqZ+xsQ6vfFVj6VAxFSrGVF
	cbRII/x7pkUoGU+dvK4qKMh2ncoE2JgivVCUNpxYJq1pHQ/I9soGOvvVc8cuA+jJmQ==
X-Google-Smtp-Source: AGHT+IHpKcHkzaocAzKrmqOnvknnOqrXFgO2SiOZTgXtv8v+e/D+kmcUtUHf56S5Bi+ZgUEYHg907g==
X-Received: by 2002:a17:906:fb11:b0:a51:9f5b:b659 with SMTP id lz17-20020a170906fb1100b00a519f5bb659mr1789622ejb.34.1712764549870;
        Wed, 10 Apr 2024 08:55:49 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id qw6-20020a1709066a0600b00a52172808c9sm279884ejc.56.2024.04.10.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:55:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 10 Apr 2024 17:55:35 +0200
Subject: [PATCH v2 3/4] dt-bindings: rtc: pxa-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-rtc_dtschema-v2-3-d32a11ab0745@gmail.com>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
In-Reply-To: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712764543; l=2124;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=MljIxyWTISU+l2odfMzkGB6VwOiZuuSwves7xqGR7H0=;
 b=+KJHEjpPSKgc0aYcDAt7jz8cMXuHaOsYXEx5xaxeDu98Mi3pAhR8m4a1H7J9Gj9c95Iq1CkTX
 C3b9IAdDAlrBY7JmKPRwT4zrKX9Ox8dBgU+omNT/BdB/TfsjCFwU3O4
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


