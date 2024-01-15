Return-Path: <linux-kernel+bounces-26215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC22D82DCE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E409282C82
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F817BB4;
	Mon, 15 Jan 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGpFg7WZ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71F17BA8;
	Mon, 15 Jan 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6db82a57c50so538634b3a.2;
        Mon, 15 Jan 2024 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705334771; x=1705939571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixPkXzb9IeR/hF0U1QATiBKY+/dWLZ8JkGr38j+7Zxk=;
        b=CGpFg7WZ7/20/GuFyRskIoAk/nC1hjutJaFRD6Zyy4SDi73bGFE9JuL/G+lLUrqxvU
         mFwgaNunsg+mi9KqmJrCespOXTHOao+WaCKZ1k3eTX/dhNnWrJdhyHb321EVNVUNeOlA
         0LOWVu4NYpvTbLBrKKBEjc/8fJCSKm4yl6qrOP2GpIf0HUjgFFtFFgfAcbLQnlR4C2jI
         lF7Lnx0dFfRUgXq9cRbgGUrfu3c3c5n4ItUANuCRb6OkLHvmx4vX1lKCYs4VUwP1rLIF
         w8X2xNXtubKFwBbibVClAXQGSXCN+Yx55Tke5KAQeXTWUUb9TE1sORZWI+Y29TEO2aBg
         yZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334771; x=1705939571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixPkXzb9IeR/hF0U1QATiBKY+/dWLZ8JkGr38j+7Zxk=;
        b=Uhg0fTJHWFnSiIhPNRTzi5aGsQtVq/8H2wiG025Qfc2S6R+CUBOUhX4ju5JY4Cpnzc
         FSheyUK/soS1zjSkBNw+x/iivT6DvS2j8vUxVtiCSIXEhl/79XOc30OJzDHv0pHyO+Fv
         aP0REoouBuFftmlv7CH8PRCyd0xTb38mYrA30aAYl6nvtUxdFWIiXEolkDuYCi5jTc1t
         VEn0VPocIcuWEbyVVtw60Lf/yWD419cdt61NZ0/FIEk7zzVEuQ/S1Fb97/gkfXkEnJ/5
         fGtH2Cf29TCXW81mWMu2hFBpQdL0sC4C5V0ntY0Y5zCImg5Q+c9Ip1/v0uD/OvSSpm11
         TTiw==
X-Gm-Message-State: AOJu0YzV2II8I/IvfAMvHsGFnDDL003QLPDgyNdAwZYZt0aW378upHKU
	NWUsg9rhPmf4nbGfHRmQ/tw=
X-Google-Smtp-Source: AGHT+IH0W4dSfXX9ssa/rcWuTJ0eDaTBQ1lZ27m+dBLNlKjQeBamp8WPXApwM06MMIgXGOwRZw4JtQ==
X-Received: by 2002:a05:6a20:2d29:b0:19a:bbd0:a314 with SMTP id g41-20020a056a202d2900b0019abbd0a314mr1679742pzl.23.1705334771009;
        Mon, 15 Jan 2024 08:06:11 -0800 (PST)
Received: from localhost ([124.131.233.112])
        by smtp.gmail.com with ESMTPSA id fb10-20020a056a002d8a00b006d9bb4400f0sm7755351pfb.88.2024.01.15.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:10 -0800 (PST)
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
	dlan@gentoo.org,
	inochiama@outlook.com
Subject: [PATCH v6 1/3] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Tue, 16 Jan 2024 00:05:58 +0800
Message-ID: <20240115160600.5444-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
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
 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
new file mode 100644
index 000000000000..e54abd59c193
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
@@ -0,0 +1,55 @@
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
+    items:
+      - const: sophgo,cv1800-rtc
+      - const: syscon
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
+        compatible = "sophgo,cv1800-rtc", "syscon";
+        reg = <0x5025000 0x2000>;
+        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&osc>;
+    };
-- 
2.43.0


