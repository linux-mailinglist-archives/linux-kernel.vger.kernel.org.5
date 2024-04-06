Return-Path: <linux-kernel+bounces-133829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 176AC89A961
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490E51C21536
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329425761;
	Sat,  6 Apr 2024 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOY7Bs6M"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A322616;
	Sat,  6 Apr 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712385275; cv=none; b=Hym+gnPBc7ceq6/V4aaIypTcF6vFq9U6JCsm1SXHWmnnEfdVDOICwzzLH223+rdXpSMloSPFAaAl5ZzRlvoeswCH4dVsSFceGcWRfMhHuo3Ru06kA5dL1y/RZTOVjwR/GNTgR2Idc94nRCl8kNosLfrEQkCLkeR3I7guNT8ZGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712385275; c=relaxed/simple;
	bh=5n7Ca93sgt2C4nvaRXiYy2nhqL3iHW3hsRzfzicQJdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HImXfCXe+zqRInSrqQ/ZvXTvM9/5ZZU6DIc8ehEED3xmnxIv907/7oQfkOro5z0HuvGBZDMwGO5VYKWDzUhooVwjsiss9TNnSi7poE14tZC+Jqz2oOpXsBXLLTWSAibYXRY6YprpqDRiq9VIik165Agqh7OHW6zWkIeLDSfmr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOY7Bs6M; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2099144a12.2;
        Fri, 05 Apr 2024 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712385273; x=1712990073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=eOY7Bs6M6570BwFvpiY7MbP2R9aBuyjNhCjDLUy1bIi2vC1Sl1rGpNOrhuFzyIx/57
         FBaIvBagYYFzD4xjFwmAXQ4rjAn2jZkK5tkpBItBz0lMSwrjD2yGMCWC9Nh26YvMzBIS
         cppjj4EvQ4cUr+FmGe2J/lcrPKqrKoHPTil9iQMvgUJKvIbdBZRs7JdZP1Iir8KV8Q5r
         LFg8PTirO4JSgGA2ZDamQUNn605U+ArrYWnqUn+rfPsc1LOIKTt4gEKg4L5T3z6wmqMd
         Y6tPTxIcvSuebCosDit3rh4y4x3fpxqaY9uzhGsjfZR7NVmqjwH5YGy7rJSZ8Ou0tQke
         r4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712385273; x=1712990073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=K1NeJlIJ81ej0wJmutFkPJAG21zrWJ1yeQ9ZRUEt1S+p9vbiLf5lMrYIeJhpt89Ecn
         t5SenO6LW5bvuu+OxZhMbhLvF6yEBBDbF66gJf1D3YgSfQhi/o6isKrXskWi39hZUBRC
         p0z/q80aSWVv7LNnhYFi+r7IwxCEofEL/gm5wO2aubCJFSkz4bwu7Y0lHmLFGoyUGhhh
         gIRUTGOk5Wo/wiEKFVrouZBEqtISeZwSIGINv5jHhU2ajUKObZwXO6jAak3fOeoKxmUI
         5WzMhul3t9CYt4+xMF0r2wjSWa6U98BPPuGJOsk7CHQTvgUYfpGQwRbLd7wupAHaX3Yg
         Hp9g==
X-Forwarded-Encrypted: i=1; AJvYcCV93n3+WoxxaSRHTfZQIJSUOBmbAEyVP0X1oNxY3zegQIgb7H22+DkOwoJYEiPjIjUkXfZo0egS7rOVRc4Lxw+XJXC770yNKBwl6wMbGXhhCBACMT25fyhrep7yoj21ptjYKUp6AxdJmq2xbMU3OkaGYYJAQ2+uMpQL1p7+suEC4fSaOQ==
X-Gm-Message-State: AOJu0YxsSC0T4xlmgx6G2o2ZdLD+Gfv/W6NaajN53Xb1WS+0YRwKjZJp
	p2sKALduayYINhG+9RKBOgbmcaXXfXbwpEbnfNDi2RtYt6Gi0mWb
X-Google-Smtp-Source: AGHT+IEkhUnvLKGeF3uP5MmaOYLwHO1IwGsLYRIwjWRy0HclbnrxCQBB9OCSC7tCJac/aWgKMwcjFw==
X-Received: by 2002:a17:90a:df85:b0:2a1:fb5e:6028 with SMTP id p5-20020a17090adf8500b002a1fb5e6028mr3176652pjv.20.1712385273310;
        Fri, 05 Apr 2024 23:34:33 -0700 (PDT)
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a590400b002a09c114d7esm4322673pji.45.2024.04.05.23.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 23:34:33 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
Date: Sat,  6 Apr 2024 14:34:12 +0800
Message-Id: <20240406063413.3334639-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
References: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding to describe the PWM for Sophgo CV1800 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/pwm/sophgo,cv1800-pwm.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
new file mode 100644
index 000000000000..b5b819d780f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sophgo,cv1800-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 PWM controller
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  The chip provides a set of four independent PWM channel outputs.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm0: pwm@3060000 {
+        compatible = "sophgo,cv1800-pwm";
+        reg = <0x3060000 0x1000>;
+        clocks = <&clk 60>;
+        #pwm-cells = <3>;
+    };
-- 
2.25.1


