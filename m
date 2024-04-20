Return-Path: <linux-kernel+bounces-152292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3F8ABBFA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4521C2086A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750C726AFF;
	Sat, 20 Apr 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcM0E2Cq"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB11D680;
	Sat, 20 Apr 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713622882; cv=none; b=SqSVbW9fwwa9jisGDOVb23mvzrM2qH4rqKIBJ4Fo3z3VoFFX0RG+PFtJQGh1dEci1IFmiH9RdNydORzamHdpjnEE8rUiCytn7JE0CbUL+PYWxDvsxhXl/LWmwQcNbFgyCNt7PG1kzy+sNJpZw7YCxKODzuNbzZ6iHR3rGUBVGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713622882; c=relaxed/simple;
	bh=yaNdXDK9Yp5By057+Zy5PNb7S5FUJy57g3MaeDIX6oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxSuWz5QZ1kSw8x7o2LGN9J7ycuMNmneAo5PFrHuq2loZJngF2XJwIBxzdJRVDKU8cCEtpV1AqVl2Swa9rqrOeqcke6k5HQ7d3VLzM6dt7g5RzgIntvaltqYswD6IYn4/Llm3BnLNuJlLLu+nPERLarpXDo0znd79SpnaV5mWzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcM0E2Cq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5f7fc45fe1bso1401491a12.0;
        Sat, 20 Apr 2024 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713622880; x=1714227680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljFMQI4P3kJd5go/oTpwHUMZ4+SWy6IG/LYlY9DuEf8=;
        b=dcM0E2CqXczmzsiAW4eeIcYitiZBabQwDHUdkswDXcRhJjnSMJ+8+ZXiS2WTP+EFvm
         XQMoF7qXhcRhCPjZ8i7lu8iX8L3+wx4+v2CdTxNZYU0dOiEQICIozUgX9xk9nfAb5xaG
         Ij+Bsa70s0txqG7h4rFypZJy3ACz1/Ek9wKpjrzz+QM9k4wKRB9r6b/h09s9Ldnh7qG/
         yB33DiadDu8VU8AVJYmMy+u1nrDlcvm330GxSdlk50D1Ci8+dKk5/q0xBcfPxqo586ed
         9aFjpC4XE+V8TPQe4lRZp/oKz31h2/AOzW4oIwyXJlX+FKoaPIfmcTSzhpCFevxN6J65
         w3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713622880; x=1714227680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljFMQI4P3kJd5go/oTpwHUMZ4+SWy6IG/LYlY9DuEf8=;
        b=aqTLUbadYGNrhOrM/6A03Y2BYC7Ywz6FnoJgZm7Slvsn33/xapq5a/I/juxLwcRLh6
         wfaM/g8a9orl0nn864XJnYSTrLp59ak44U3cB/iSUDyEeAXFLzmaq9hgPgAdacnD5+JA
         /0ocv7J9uBsbMzClCMgEBhkqiapIDCUupvPmbDB+wIRwSSENADS/kopl4LLPGxbwXDu9
         XLELa02GOoZVGSI73e+xxAGyr0mtx7dEYqUggaAWrwzNJzUu+UPIyoIVCw7ss467CoU2
         OVYNzRolbBgB/C7ZkhMEGmqWLWnlA19dKdqYe+/AMsb7q8j/F+CxVynxi+1LkUZEMv3K
         G8RA==
X-Forwarded-Encrypted: i=1; AJvYcCVZqjBbL8CF8h2LaeTeksJZgFuXSLE5vEbm/sGoAdIo/dx9w4jRU9aQYDrEYZcrFGa8hwgw5sXO6DKEVivH3Xfh07SV0GCK7A0FEHHuOXe6sVPdYEZ/8O3K5VrzI2kaPjz4X+J27ds+e6CL/B9wRavV/SLV7o2fNcrAC8bK3LRvkGdUaA==
X-Gm-Message-State: AOJu0YwozHFDnp1P2JpAxi4qzzImyoW7TcnZJT7khJdKFzn8cDUQGEOi
	vfsDEg7DzLtlmUs2MLBcTHsPieaWNm3YrcHEgRWIurOJ2XhTZ5fGME9nY46zfHg=
X-Google-Smtp-Source: AGHT+IHKrXeG/8eWAy6NhzmnP1CUfwJ0SrR7cs7Q8OWpDt4z1pLEouHQ3LzqQfznN0Bv43zEdk85hg==
X-Received: by 2002:a05:6a20:101a:b0:1a7:bb6d:6589 with SMTP id gs26-20020a056a20101a00b001a7bb6d6589mr4643061pzc.29.1713622879325;
        Sat, 20 Apr 2024 07:21:19 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id c18-20020a63d512000000b005dc49afed53sm4838934pgg.55.2024.04.20.07.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 07:21:19 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: uhci: convert to dt schema
Date: Sat, 20 Apr 2024 19:51:06 +0530
Message-ID: <20240420142108.76984-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert USB UHCI bindings to DT schema

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
 .../devicetree/bindings/usb/usb-uhci.txt      | 18 ---------
 .../devicetree/bindings/usb/usb-uhci.yaml     | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-uhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-uhci.yaml

diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.txt b/Documentation/devicetree/bindings/usb/usb-uhci.txt
deleted file mode 100644
index d1702eb2c8bd..000000000000
--- a/Documentation/devicetree/bindings/usb/usb-uhci.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Generic Platform UHCI Controller
------------------------------------------------------
-
-Required properties:
-- compatible : "generic-uhci" (deprecated: "platform-uhci")
-- reg : Should contain 1 register ranges(address and length)
-- interrupts : UHCI controller interrupt
-
-additionally the properties from usb-hcd.yaml (in the current directory) are
-supported.
-
-Example:
-
-	uhci@d8007b00 {
-		compatible = "generic-uhci";
-		reg = <0xd8007b00 0x200>;
-		interrupts = <43>;
-	};
diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.yaml b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
new file mode 100644
index 000000000000..511c3ecd8d53
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usb-uhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Platform UHCI Controller
+
+allOf:
+  - $ref: usb-hcd.yaml#
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+properties:
+  compatible:
+    const: generic-uhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+    usb@d8007b00 {
+            compatible = "generic-uhci";
+            reg = <0xd8007b00 0x200>;
+            interrupts = <43>;
+    };
+...
-- 
2.44.0


