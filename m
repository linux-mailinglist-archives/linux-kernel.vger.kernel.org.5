Return-Path: <linux-kernel+bounces-160953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE6F8B4505
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5341F22E90
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF5D45958;
	Sat, 27 Apr 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsz5e04k"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C544C8B;
	Sat, 27 Apr 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714204476; cv=none; b=TxicXPobDwxa3sOA7A3MqhpLxruEe8vTv7g2lXstohMu+UivMbdzYJHXbRWDFdQfdfqi0dCrqaU6T+ynkVsCcyKHs6jSmLRXfVbu+oVdKASaYyphRd26Fd7lZn83EvMsEUrCS/WXJBftrWAWTYSV6zcA+XWkl3gz/04KwIOGH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714204476; c=relaxed/simple;
	bh=L52iOq2amVn6/0FpT53d+wjZnImB3g/mhW7xND9TNys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qunXj069aXsyIRPeNuS8q6HegR4oScnq2lVzJvAshrZ4Xn2Cmjbp1MeRyhme6pgFiGHbXzSoagoaBtMp7V1vaG+NGli75ClynoKBuMp99axEI7/ubt2NZe8/NnwDdlwuvF2UqGy/gP54EJu/ZDCwiBpMbEp5MUzU2cJW4svXdN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsz5e04k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e86d56b3bcso27024565ad.1;
        Sat, 27 Apr 2024 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714204474; x=1714809274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzdiJIiSal23hNM9VSVNjie8VPHI8CKcECBGEHkYuNw=;
        b=fsz5e04kwRg84fZkA/6b2pfsaQJcXHh6FDpFDC6uRSB6PRJi/NK2YcDO5E3vt4hzl0
         oqNN1mULGPKiXqgP19L9qnD1MWli+tdOgNpjIEO2rEWn79Numr5nuIgznMJJuTyIePpI
         RdNBFsudvEXc3QLlJU9zW0SOiEHnmna6YjnDn8XeMnfzeAMvxMN7Nr59XcSzyPK4FlST
         IQcNT7uWS58eNUpxLDj6AzQLvNE95k4Xgwyb4bR1/z2MfJiGwzmdbcHjZ/u5F7dpbyQp
         BXVZuvfXA6gz3m3YPNHk2TZh9NWAQcSKsYijFhBoaSJm5KUZpMTe05QgOfb+TCeo2Lg3
         wLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714204474; x=1714809274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzdiJIiSal23hNM9VSVNjie8VPHI8CKcECBGEHkYuNw=;
        b=BabK+Vf20B86SJ2EcsawWWm6fRI5ILHFdXWK0BWGBghZ6EnASWvxo82vrkuqTQigYo
         NQf7eCWX4mQIwUEfbSEKEifxWkA2F6+wffWmcRnugv2MPqMUPps4iROSbQTEbFmW1en8
         U4Q30LxtSfMSjnDfvwfCRPBgtidx3xf0MrPasAjMKdPzmmFseEwLeE2s5jdGbw+pL/v3
         +jl+cRQRKhgxAAgqFiSwrMLOGdzmEKxnSNBlFRcdoCo0HzkvReI3lZnzDfp45lU2lZaW
         pgQeas6mSjxu4+s8ZSG6QxxZG6v2TZ8ATOz0pGRts7+I+UJMWPkCkzb8qTNpflAYgbJq
         NmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbtdQAzTbGDiy6Cumq7oX9Fq4UjOpujQ2hPFL7gVNHPzhsavQCQJsKk6SYtcaFfRqW7VfKn9yEPntTBpHhbFKOiX+drrUxqHzKevwL0CU6LG81+7yV1qmC+pyY2VApJ8uJN3CS0ypxeuEuYvZ7Xc0/rEy4ZAEjjcCPpxFmFBmdFZiFhQ==
X-Gm-Message-State: AOJu0YxXn98UKUd5up0jAyFRQRyquJBF6/w9s4/RVZkok7hoHy6AJYQ/
	Lf8KlgKRGJLXV2/hdz/XKZ0Pju+WtGoHsVYWkYIjTkxW22cowfWi
X-Google-Smtp-Source: AGHT+IEyqjcg0xf4O9f1j/+f7E+JPMyHXCWdgAqqIjfIROMh98X5xxCFrGvuOUcw3+Xnj7X0FWBBHQ==
X-Received: by 2002:a17:903:2342:b0:1eb:4c98:8b15 with SMTP id c2-20020a170903234200b001eb4c988b15mr1753750plh.61.1714204474253;
        Sat, 27 Apr 2024 00:54:34 -0700 (PDT)
Received: from localhost ([46.3.240.103])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001db66f3748fsm16595189plh.182.2024.04.27.00.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 00:54:34 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: dlan@gentoo.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: mtd: add sophgo spi-nor-controller
Date: Sat, 27 Apr 2024 15:54:25 +0800
Message-Id: <20240427075426.662671-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
References: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add YAML bindings for cv1800 spi nor controller.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/spi/sophgo,spi-cv1800-nor.yaml   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml

diff --git a/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml b/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml
new file mode 100644
index 000000000000..121a80fbf2d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/sophgo,spi-cv1800-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI controller for Sophgo RISC-V SoCs
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800b-nor
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@10000000 {
+      compatible = "sophgo,cv1800b-nor";
+      reg = <0x10000000 0x10000000>;
+    };
-- 
2.25.1


