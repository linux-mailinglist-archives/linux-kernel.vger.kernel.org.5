Return-Path: <linux-kernel+bounces-111018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90F8866FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769571F21A57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E3A10A3E;
	Fri, 22 Mar 2024 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX5bpek1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA6DF62;
	Fri, 22 Mar 2024 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089941; cv=none; b=A3odbMABEEn78IMZDJzw8yLxvE8yf1BHykwK4cO7CXNgj9kKjAe0LvArL8klH99mt0PjrGScszaB5onrT2yOew7IokVfeq2kAdhU4JDWY6WWXgOCkD6x8kcnPGx7PI4nGZfBqk5U9GPiTrxaJ+ZY3gHZODA79ZCqVCUF3qxwWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089941; c=relaxed/simple;
	bh=dydiCo7iI1NW4gSDYIevGCRXxnVvyAdCyQwXxWD9D14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RyP6GcipgY2yQnNUg9CEP8dNk89duieMy2vAWZSXSmv+p/NXCQ+EUP1/v6KTZgXn1r6/yYcF35BuQOCeSalpKSsv+esOtHvhYwtG3TV0D4F7Lvxq1VIaah5sVmk362SkPjk3ohUXjAJFU0G7A7+2bcsh5WnZQi183T+qpfh6FVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX5bpek1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4715991c32so175463266b.1;
        Thu, 21 Mar 2024 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711089938; x=1711694738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOSsKufZ/8yCjM1/hlvnqYOYaN3abG+vGfagOCNtt2o=;
        b=dX5bpek1VxQZXTQo/DJn8aLmcy40jTCDZ6KC15x0XtxYTCyOGySnTbTaHA7aWVbuPy
         N+B5qxxJ/aVZnjxITbGbHWfjEUMbZv0pSdK81xcS8FSfd3Ibog37+cERhqxgFG8Qwbp5
         V6qrymDcPvGE19a2X3Hj2JUKYa3gW2tUwEaD4i/b2zHdSZRqxMBfDUGsP2yLG3TK3jJo
         29+a9VnkGXXEhzpMfLoD5PBJH5i4asUhUjS2mvIfd8N1B9PsNOakkKli6ZwW2vBXoqDj
         NIYewcnrhmzGGqL7XTcCRz4VIqRRhKebZVXfCPsTq2kzwaYR1ZPpMs+ayrc022KyP/St
         dBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089938; x=1711694738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOSsKufZ/8yCjM1/hlvnqYOYaN3abG+vGfagOCNtt2o=;
        b=GmFdimtyzjvTGGPyUIGeWtc/TrBbwFSZk/CQxvlvH9Je2QzRBdsXCdc+YB9FRo/2uY
         zyi9YiABBOA9W3qWwVolAZD3DhWlm0fdOQ5UnlL4Z3f9HruJTxEiyo6oKlol6uo2z6eG
         cmNOKFqva2EG5dLEhaupe6LCbaj46uzONtgLsytmiX+sebczxz+zHmk045oIT0X7TZGh
         th31/eWe65XBN3L7Ld0g8Zq319hzIIHzOnrAxrsqdoFQzhLhut4tX/xfmyP07KK4UULU
         sZLR5rl/C4p+UNLvOoZMWn0p7ph2lchm5BAaYWIQfSRqVQiDbhU8LCDyxYi80JGgEDoE
         Mssg==
X-Forwarded-Encrypted: i=1; AJvYcCWFWdVONKeY7xJNt1DFTT5G5shY18vDThjwvDkQnsm4WgU+x7+0X0C5WkExlKWH7/VnfJWfyvyG7VehDszS3U/dQlQlUwYDwyDlaYYcal8Pak4hMDzfyBp3/B4rMj0b5RbTYscM3ZnkfA==
X-Gm-Message-State: AOJu0Yy724ZPWHWOI6sk/B2VEBnGLVE+GKljf3f7k9ZGDqdybVtoI5js
	gOBExdwgTNV31sPzhibSZ+31S+DmEz+j0giGtQC3vpc+wUzARfTG
X-Google-Smtp-Source: AGHT+IEKmV1pnUuAwpsoeuF5BAS3RVUv2sjWEX2KhGLMWJPvS465ZIZs2/H3FbqnkYNv5pNHwrmMaw==
X-Received: by 2002:a17:906:b818:b0:a46:206d:369b with SMTP id dv24-20020a170906b81800b00a46206d369bmr970238ejb.28.1711089937861;
        Thu, 21 Mar 2024 23:45:37 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906375300b00a46bb8a44cdsm679694ejc.198.2024.03.21.23.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:45:37 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 07:45:26 +0100
Subject: [PATCH v2 1/5] dt-bindings: hwmon: as370: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v2-1-570bee1acecb@gmail.com>
References: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
In-Reply-To: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711089934; l=1927;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=dydiCo7iI1NW4gSDYIevGCRXxnVvyAdCyQwXxWD9D14=;
 b=mjJW0wmKIE4uFauQh76CG+KkMvkmn4jNOfu3ARAqE1vXWCXBI7v4NH1AJAxudwdBY+/LWT6MG
 K4pY9WZVNHmCiv/UQr95sYpl4Pf53ojlW5qCWElxZkxK1rqahIK8M7w
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to support validation.

This is a straightforward conversion with now new properties.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/as370.txt  | 11 --------
 .../devicetree/bindings/hwmon/syna,as370.yaml      | 32 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/as370.txt b/Documentation/devicetree/bindings/hwmon/as370.txt
deleted file mode 100644
index d102fe765124..000000000000
--- a/Documentation/devicetree/bindings/hwmon/as370.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-Bindings for Synaptics AS370 PVT sensors
-
-Required properties:
-- compatible : "syna,as370-hwmon"
-- reg        : address and length of the register set.
-
-Example:
-	hwmon@ea0810 {
-		compatible = "syna,as370-hwmon";
-		reg = <0xea0810 0xc>;
-	};
diff --git a/Documentation/devicetree/bindings/hwmon/syna,as370.yaml b/Documentation/devicetree/bindings/hwmon/syna,as370.yaml
new file mode 100644
index 000000000000..1f7005f55247
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/syna,as370.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/syna,as370.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics AS370 PVT sensors
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: syna,as370-hwmon
+
+  reg:
+    description:
+      Address and length of the register set.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    sensor@ea0810 {
+        compatible = "syna,as370-hwmon";
+        reg = <0xea0810 0xc>;
+    };

-- 
2.40.1


