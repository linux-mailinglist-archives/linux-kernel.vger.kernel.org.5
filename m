Return-Path: <linux-kernel+bounces-138930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B509E89FC25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6966328E007
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA51172774;
	Wed, 10 Apr 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNY3u+YA"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BB16F268;
	Wed, 10 Apr 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764552; cv=none; b=uVDWZ467a6wUzly4XD4IRFLXiixk7prUE8aP3sO5TjFkqwc1XgIyAXLQAqH08eiPo8u4tmKs5ICIKAhWX8LFhR9+2P/nH8Zdt7H4/snkQE3JUocIAWZ0KdSev+dAu1zZgUKyqZCvf3x0rqpyc5UewF2LaD6sKdc8Ej1yGURHtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764552; c=relaxed/simple;
	bh=ZJ06gPeNSTQ2DySuOzdESjyZIxHEy/NT6VtQopAeiQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDY3+aqKhk6MN795Qr7Wj2QYbyZo8bbEoO4SjCoKOYss+N9YCrLAo9+iHVw4jg5KvRPNZZS4jd3Fc3GIVbhvB/WwtOVJwXy2V214bxnKvEspJvlGgYYFzG9b3CjYjcuqsF12/JLGTKQVyDmT1QNbfTUojXiF4ybH/gl5v+KepeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNY3u+YA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51ddc783e3so420899366b.0;
        Wed, 10 Apr 2024 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712764548; x=1713369348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzWm9MO6MRh2JhYRh9d9r60JurAw8zbzSiBG8Vp4F7A=;
        b=lNY3u+YAY/QZuLqWZ3DnxvJQGZjkyIfpPFrugZ/ktS0g90QHRaUtIx7kSnT/bNaVNQ
         dLRiG+V+i55vDKkmybwtFBZu1FfpHevtU2wg97+07TJfmDjyvUXzdbn3X/VEbpFELBE9
         CH3xXspN0y2WzL6ghmq9QYjR8yFv15vrwadmhfqWR/PywU9BWHso9wn+IBuAt/XTf7Gm
         B5qHY8QXEbbqpzCBaHv5en5UNcuHKfgHa07Q/Ug+VnBOKXdXCZaxWC3hpU3ConMEcmJ3
         VeKVrWsiU5fi9g19K7dztAKBcNot5S2Pu4NeMJ1zurFaZKxB3jS8gXOLi7t8XuVpl77O
         OuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764548; x=1713369348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzWm9MO6MRh2JhYRh9d9r60JurAw8zbzSiBG8Vp4F7A=;
        b=g4Jfr2oy9e7B/Js0ivKg9uarvYj/EfN7PewzVLg7dUF4t6wnA0LMInxHPyyBVwMleF
         p0OzgbUyzNUtkyo22URPCD9JfNx8is8tGy6GtkXelMAOM6/eqlDNTiOCgAnilkaNZMGd
         q1aYH/FlTdYkW2xLRlnLhTKfMUvbhEvm2TlHvrmOjj/dIpTfVfkuQep+uDtwin+Ayr3d
         vXy91lefiKfZlwoFmXPeU/n0JM88m4BvwRFCJv5dUFS9Vmsn60m82V8cgxSXErYXfa4k
         5DPTWsRYJu5YApWksO+e7CN4wk9UmJttTiS+V9t9YaMc0/aLy3qyKYY/OGiPjaM5q2pl
         WRBg==
X-Forwarded-Encrypted: i=1; AJvYcCWDXV1YitlS+IYNkSjcaa/T1lXtXTmL+KtMK8S2Ke0eBRDSqrzME3WeYx+mQedZv6z1npcrbhthvZdNZLcVG0CICla1riZN4QnUuJBhD7/NRg++1R6Rf67U67WfCSBAu9hkDm6wEJYZrw==
X-Gm-Message-State: AOJu0YzyZ/AKnEc2ALakb8YS4MmKM/LSZjvxviFQYjdvKEzW2QHF8pvX
	NHGAYXaDNhP5EIlm1LO2e+2bYSfZt5fCpClozQC/3SjrPDL05RnNnz7XpHkT+A4TUA==
X-Google-Smtp-Source: AGHT+IGWT0zg2GfhSFE2SOFKfpvXgozYERgxjlvwRfCaQ5TT835wuPhVMQ4kvDupf6tnP6/hPhy/bQ==
X-Received: by 2002:a17:906:ee87:b0:a51:962d:cf0d with SMTP id wt7-20020a170906ee8700b00a51962dcf0dmr2330371ejb.12.1712764548277;
        Wed, 10 Apr 2024 08:55:48 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id qw6-20020a1709066a0600b00a52172808c9sm279884ejc.56.2024.04.10.08.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:55:47 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 10 Apr 2024 17:55:34 +0200
Subject: [PATCH v2 2/4] dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
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
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712764543; l=2099;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ZJ06gPeNSTQ2DySuOzdESjyZIxHEy/NT6VtQopAeiQc=;
 b=OWv7GNhwJh5KCDkRW7ERfspAklaTpWgWcxbYfHhi4SlqF6l+Dk6ATof15wOpkwnTCDEg8Vawt
 6TzRRYUgVEgA0j8sdfATE22NOBeslYc9HH6g4bJakYvCUttKWqZHKL9
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

Add the undocumented 'clocks' property.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
 .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt b/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
deleted file mode 100644
index a87a1e9bc060..000000000000
--- a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* NXP LPC32xx SoC Real Time Clock controller
-
-Required properties:
-- compatible: must be "nxp,lpc3220-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: The RTC interrupt
-
-Example:
-
-	rtc@40024000 {
-		compatible = "nxp,lpc3220-rtc";
-		reg = <0x40024000 0x1000>;
-		interrupts = <52 0>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
new file mode 100644
index 000000000000..62ddeef961e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,lpc32xx-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx SoC Real Time Clock
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: nxp,lpc3220-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
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
+    rtc@40024000 {
+        compatible = "nxp,lpc3220-rtc";
+        reg = <0x40024000 0x1000>;
+        interrupts = <52 0>;
+    };

-- 
2.40.1


