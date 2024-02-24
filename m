Return-Path: <linux-kernel+bounces-79555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B92862413
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8364A1F22E0C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D893318EAF;
	Sat, 24 Feb 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbTWJhpj"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A51B96E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708769718; cv=none; b=Ap+EGl2ApnjkT7qlb6pWm/1O48fhaIC05neQF/gEyWrDhgQopwfjiA3+qMeYgDFw9gAcwe6Qe+7r87y6fjMBR1zmaxxA57Z11bAfVGpZ5QUrWO8jeq+4vs3ljFRBiQBwt7GqBqO+FRtVKso8lakoJbXL7pU+fmXca6vzY7lqgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708769718; c=relaxed/simple;
	bh=b4z6PcGKaAJfc3AuLePfjOUzLtz9bdfMX2xHlkhOMyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mxu4wxzajG5eLLsmAnwqx3NemDkvYVSK19YTy5vkdkulqIXq5hOvPB9nyX/FNpdCxWqL3sbrq7bnMSrYX/3DP58ZSp0cxcUG1zpyWBXfzVXCT7tRwrMmr8HBtFaoUw2DIYApkWTlytgsSAxfPADrWeSej0Z2EHS1fAG01heAooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CbTWJhpj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565b86c9943so82440a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708769715; x=1709374515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akOZ+Etv/crirPuIpt8FIJQFJ0/ZKt/kX9vyEh8RWUU=;
        b=CbTWJhpjNQTR81IkU2G1kKwxhkaAr5MNzBt+RwNYlaJ/xj6R5NwPq1GP0SHtfJnquu
         PhEI3QjsX58qIkI2lQ64TAD1GbwZKI2PlLV7+xM+iVYyjxk7ldlRSAmxbZCY2oUuGMnN
         iDLu0oI1Uk7WKUy/brM2faVmTdOnPsVxWz6Z6W2V2yev4ALQ0YjVBPtnIjOG6QPe7FCn
         3DTldsAb5y+2UOjznXvOtQ+4nNPI2V9eF0WhQfZrehky63R6g6IH4ccxA+SImHTfkS9r
         dXvBtUfyyB78p9H2kFslJH5dWMie9tXesUFlaXNtDUZ9d8I3w28Jx42sFsM+BJZWcsgZ
         VKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708769715; x=1709374515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akOZ+Etv/crirPuIpt8FIJQFJ0/ZKt/kX9vyEh8RWUU=;
        b=tF5jYdJDdnrjcpyIYQx25oFv6UZlADWWd528rI3TCpDjw7IQjO8HhLq5WqF2xrYpji
         M82LTKJ2JWfcVrntzbw871G+5rcgULle4F9766eIIYRzECFo4wcXel02/STt7L48mKbR
         1D4iOxk9nSTspGRoAJ4LC4tEIpzZsF7rNmsuVnZWcfR7fAArw5ivAhABbKI4LzXu7hh4
         cNopW5NwZcTaf6GOh5P65Tq5Tm2pyTrMk6KfLaqIzrbnsmxipm/7Kew7EtBJLdtASxzG
         QajW12Gqo6Sz1cJYehu5Hgr95FHQySCkDXMPfkv5QcD30loa/fGTOWxbg7maoDG3GrC+
         +nPA==
X-Forwarded-Encrypted: i=1; AJvYcCVbe6zixKlWRUsmH9MmG+mvnRSwGpDAIcuUwS7tZ3EbpTtKXk9/mfA6MUg543Kd/WRuJ2E/WGuNRJgIUvD2ybbfAJhaONy8/ZuslU5G
X-Gm-Message-State: AOJu0YyzYqG2CB7pSJ7lkrS4KZW+gxZYY5feKlK7Z3VO2AMgFNJSXJwQ
	3R3CBR23M8bpiMCrnM0Loyyn9Gy6umJEG0obRWoYpLF95i68IkI+0BWbxgMNYIg=
X-Google-Smtp-Source: AGHT+IEQkkgmNZcrnS6PKnhLfh9Q9KajTYDqiFmuPq0DUD3CeYTp2cuohA1UxwuoTh0gCUUayDI25Q==
X-Received: by 2002:a17:906:354d:b0:a3e:b57f:2b8a with SMTP id s13-20020a170906354d00b00a3eb57f2b8amr1785296eja.10.1708769714998;
        Sat, 24 Feb 2024 02:15:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906140a00b00a3fb4d11809sm446545ejc.204.2024.02.24.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 02:15:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 24 Feb 2024 11:14:52 +0100
Subject: [PATCH v2 3/5] dt-bindings: hwmon: adi,adm1275: use common hwmon
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-dt-bindings-hwmon-common-v2-3-b446eecf5480@linaro.org>
References: <20240224-dt-bindings-hwmon-common-v2-0-b446eecf5480@linaro.org>
In-Reply-To: <20240224-dt-bindings-hwmon-common-v2-0-b446eecf5480@linaro.org>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, Zev Weiss <zev@bewilderbeest.net>, 
 Eric Tremblay <etremblay@distech-controls.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-i2c@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=b4z6PcGKaAJfc3AuLePfjOUzLtz9bdfMX2xHlkhOMyo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl2cGmJS3cc23ffavegFg3/laqnuPoh6k8wxCnZ
 jb5M+RGOwmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZdnBpgAKCRDBN2bmhouD
 1/00D/4qSBs8hO4WNlYP/GyQfTw3qDcEdVvwsLg6OFXkqYeZPsDgbhGnAcca78eLHOONkrm3XCd
 fTjSERa2iOcIu67Fk0rhrRt1dz1H4JL0kEOEOPt7z26XxiKK2zVYNH31dcnwr5mVWzO3v1H3fVa
 Q2mHeQ2Q/aQESAF5NyePCTLv6gXheagVlEB9o3h4djPCnqTq7qmg3pt+zyJCPrTP32w4FVjqAxz
 VBUh5KJD+5d9fquaPAdlJtPxVp4qQCSVReoROwbzjO4Xottwqvbh3tbnvoOuhdvGiOGARMHCRBB
 +JmBIyCtLd4JkVVz0CBnLmY/WCkQ7btK8m1a3Ruf2RRyhKyccaQmtmh0001K5SwbZMK2Qr/vCI/
 6BuVR4il7zDnN2pxzFrpWmTaD87r8s+VrPPNB+KEPqvoR+bzi8bYQLs13qgbgwdf08OwvFj8pgT
 RPfcT8x/tF5BSLoRuoz4UJGkwoOi5K+O1MDjaLpcxF9cPqznziUEl4BQ0LMpZLBKk9srSlqyr5C
 PHz5eJLd53KNmtRGOkVi9LgRfQifTt4PLCPlkfTQmLe8kZX0eSgFOPj8nHAxNd5W5YHNZjKPe72
 M+CXRDDtF6U0RK+T9ijDc2UbunYDdxOSjQ461w4m2dy0IqcqEuW3bqvkF4+nKW+BR6vzUXcunMy
 m5BVg/CZOJ5MFCw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Reference common hwmon schema which allows to drop the
"shunt-resistor-micro-ohms" property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
- New patches
---
 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index ab87f51c5aef..b68061294964 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -33,10 +33,6 @@ properties:
   reg:
     maxItems: 1
 
-  shunt-resistor-micro-ohms:
-    description:
-      Shunt resistor value in micro-Ohm.
-
   adi,volt-curr-sample-average:
     description: |
       Number of samples to be used to report voltage and current values.
@@ -50,6 +46,7 @@ properties:
     enum: [1, 2, 4, 8, 16, 32, 64, 128]
 
 allOf:
+  - $ref: hwmon-common.yaml#
   - if:
       properties:
         compatible:
@@ -107,7 +104,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.34.1


