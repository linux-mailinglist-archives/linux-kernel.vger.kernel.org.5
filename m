Return-Path: <linux-kernel+bounces-32487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F0835C44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C1F1F23F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE620DF4;
	Mon, 22 Jan 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTukmB88"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFF20DD2;
	Mon, 22 Jan 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910709; cv=none; b=qRcvqEIBMuO+CIqoIIzxTKz/y6weYw+Luz0poGxRfoTihhcsuzMPIwQSoHHVqZwvM1KkjP2PJr6tLRpr4bv3q1vE/zRoRvXOyrENi3Uyh50cFqh6GTJCH+4o64DkwoyuWbISfKsHpmpep0F7PkMuEzJEtTtCnb8GzErBzO9BO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910709; c=relaxed/simple;
	bh=z0e9ZZee1BZJ//V+y1fARNtdmcng7c2azTFKKmM4feM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkFMMp6aPAfYymoat9k2WHPJX81VFgVj3RN8MdH4b1YrtqiWIQXUWWoCrFrRdZJ1MnxJL3CvSPTrkHG/LwJ+FrE8QVemZFTGBj9zdeBIRsl7+u0fzhIvFCQE7ft1uTwkdpGrU2q52tH5+HKhNb8/WHmYDlD7ETZmWW196I+DrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTukmB88; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dbd21c6466so1256882b3a.3;
        Mon, 22 Jan 2024 00:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705910708; x=1706515508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VzQb+78mErpWHlkUlL4Km28JBu20sjS8OQqy5uchPM=;
        b=lTukmB88VYfH3FvSnjGeY8Te75sYE2i9ShuY7DFImMaOqlbDdS9WJfas4coYmQtMVZ
         YCZxemvZwTdJYIvJOjTvhu1rfX+Mm+apGkhV6P6FuyaPp9ALNF/6g13jBy/eXvo4ECZX
         ezChXxJMMlDrzyukTevotpX33VpCRK9clPsR14oUvLYvgiRjzEQ6e/BCAz5LE3JaPv/o
         gKXqHZbAy8T+PxrApqP3uq/1AX/ymljxagKNJl3KdW9S8jfwQ9CQ5IOoeMbRjNPnUtcR
         gzRYxkg6XClB2l5Mo8kl1ooxoLx3v7AefMSode+2/EU6XuvXnVCMMZo0C9zxPIWtEk1w
         NNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705910708; x=1706515508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VzQb+78mErpWHlkUlL4Km28JBu20sjS8OQqy5uchPM=;
        b=neY1MjIkmwmBhM4YfTk85X88p9didZBg5GZfS10OD/EY/RR4MKQnzyqr/BgMMmt85h
         OhTmocJiRnCrTkWEIC62pJztIMxfs0Om4Y/kg8Miebd/0VNIFLJxnHvjm+pLI9XkHec7
         qdIdO+xogKCJOXqUTt5pWxXvmlpoiMU1/ZL9WX1JEfC9Kw9gT81gF3H+c6TqT873cUYq
         ZaqkQNDfAjeFECFRsUwn1Rg6ZkUZgbkh15K3f568AZ/+B+9PNmGc74q0tAb28ijWlGrI
         F+wHsxeUEC8Ctkhqz5WKmTKqtrUDR+fC784u9gLEIW9UGUPu/UesZjlkN9yKWU3eMP0L
         UUKw==
X-Gm-Message-State: AOJu0YxTaaYsnKKJTMIhB17SNTmtp84Vt9+bqe2qA88XUvol8xGx/yjt
	Vc0jlymiwGD9aL3SeVazjrZGTiJYuiDCQEBalTsrM0oh0AcfFyxb
X-Google-Smtp-Source: AGHT+IFPmqfjE+LH1PjRwOedBBf9rGpKNqOBP361A/qQuNG31+HVCNCkO6XVUJn1u/MZxSl83p34fQ==
X-Received: by 2002:a05:6a20:2d25:b0:199:b9ad:5ccb with SMTP id g37-20020a056a202d2500b00199b9ad5ccbmr5940597pzl.113.1705910707528;
        Mon, 22 Jan 2024 00:05:07 -0800 (PST)
Received: from localhost ([46.3.240.108])
        by smtp.gmail.com with ESMTPSA id k9-20020aa792c9000000b006d9bf45436asm9137895pfa.48.2024.01.22.00.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:05:07 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org
Subject: [PATCH v7 1/3] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Mon, 22 Jan 2024 16:04:58 +0800
Message-ID: <20240122080500.2621-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122080500.2621-1-qiujingbao.dlmu@gmail.com>
References: <20240122080500.2621-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RTC devicetree binding for Sophgo CV1800 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
new file mode 100644
index 000000000000..b36b51a69166
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Real Time Clock of the Sophgo CV1800 SoC
+
+description:
+  Real Time Clock (RTC) is an independently powered module
+  within the chip, which includes a 32KHz oscillator and a
+  Power On Reset/POR submodule. It can be used for time display
+  and timed alarm generation. In addition, the hardware state
+  machine provides triggering and timing control for chip
+  power on, off, and reset.
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-rtc
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
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@5025000 {
+        compatible = "sophgo,cv1800-rtc";
+        reg = <0x5025000 0x2000>;
+        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&osc>;
+    };
-- 
2.43.0


