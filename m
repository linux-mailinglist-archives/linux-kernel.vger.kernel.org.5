Return-Path: <linux-kernel+bounces-161282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3A8B4A13
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE721F21652
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75010A2C;
	Sun, 28 Apr 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1WepUO1"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67ED30B;
	Sun, 28 Apr 2024 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284542; cv=none; b=u9Am3s9Bncn6uA8938XwDecmS25ulyygicQ/SI835Z4Yli9fDsn9Ehz1OEOyVlKoT5kJcxAExaUepDzKQjqIZy7GDlraJBhyQSg/QeDkaRja1duaP3D3UIw9KOniVPGbeO8ghjqM1i0dvm1xaz1VHFdzg3bZrXBbrP0+TCruu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284542; c=relaxed/simple;
	bh=7ZLEr1ApXsNePqMUJXvZEVkV4+p5v/fZFJNxNfst4vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LOSAktinRoI9OcS0eQ5P9OZYOJ07OPPYbjsXZO7eL2LTQqWSplMThAoXuIqeLojDjni5sF6E5pWPfJqawddUbUBNnrod9zxSjpYAgjzywftvkFreclVMS+BJzPfUzn/WOYfgywlptkTFuLYv9Th/uoUD5jbXjeoMzGuOLuzDuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1WepUO1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d3907ff128so2796844a12.3;
        Sat, 27 Apr 2024 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714284540; x=1714889340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ifjH6savS/1chV5K8K3CSmBN/c/aBjrReSIKeDHfF4=;
        b=a1WepUO1N8V4aRJtbu51SebR1VRQpkGMHc1LadCiyEUx5rhEcEH+EFDHeOdfbp+mxE
         jIWMGZY/sdhHpDiKe26GNO8Y37frQis6COTlOAJ2IASElrkmw3T2ViGTJZ4dEh+Gn6PY
         f7QOPieTUnOj4BSxisLZWO62CnaKKd2imDBffcti1h2KDmoojAyXgHMrNflTl5beYaLs
         Zx5Rp3DKEEKR0Epxf61Mue4hXbCNyZPBI3rXxXiKZ2wDvXH+ls9YezEne1LcXnU1wzVC
         dOlB/fIYuI6Jqwm0IJK0rfg6Jp3R7GY5JzcqZIb49IGigeUS+/5AQ5+QaWBiE/g/kW2r
         RqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714284540; x=1714889340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ifjH6savS/1chV5K8K3CSmBN/c/aBjrReSIKeDHfF4=;
        b=GvRnOKyabiOR+4E5HClJ7+e+9Xvsipff3hlK83aWbXs0PAw0gwLUEo28JfpXpTmeFh
         Z1DnwQzoWhsXolcishqa0SQH/+a876Qy/6BHwE4C1yuTrrV45+r+ijnaKUdjG694OMo/
         m3QMtqDlo0RNic00RrU3tsupChPJ0Z5kkemK37WqWcfPi4Fpw8IJ0eKle7rxhjQ8XmMT
         zcfYdQm0xAOQMeTAMarKrr08izHZlSPaj4RTyvrGKse6Ig1wRN59j7OFzroxgu+jHaYI
         W3Az8sVQcBGG+vsAKpmR8ydu/RMqu1JiCmP/5qX+R8wN9BEjnGOnmmTyvcbtXsPvgh3z
         /hFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXez6GPQ0QsAYyUwaiH024g5s4BmqMtZieeeKL1tjgPIXS4feXWaAM2AvH+NH9CaJtWsFRVVK6wFmXPFoo5Htke61tObw8RztEvNLAB3500MILgphDgFq5yXdxlXImX12nWK+ZdYkj+Jrveqa8J8HueP23Dhppc0ya8CRJ8Au7BCpa3eA==
X-Gm-Message-State: AOJu0YyXBKSq1bpaXHqn7MAOq/YWvkyQNTfWWfWykx5eW0AfQp42B+pw
	25gQ00GvHgpGrPnvBlUPQLDW3w8mX7VaTiH4vzsKsKjkqT4LeqSM
X-Google-Smtp-Source: AGHT+IErYchcDyS/zzQK2mtLftKKhBou/yAJ6ABnnaa73CNUu4Ycb+zpwd3mrTiKR8YysLDapQdOtw==
X-Received: by 2002:a05:6a20:9147:b0:1aa:2285:2cd0 with SMTP id x7-20020a056a20914700b001aa22852cd0mr10992578pzc.23.1714284540114;
        Sat, 27 Apr 2024 23:09:00 -0700 (PDT)
Received: from localhost ([46.3.240.103])
        by smtp.gmail.com with ESMTPSA id gu27-20020a056a004e5b00b006ee25097c2csm14608325pfb.103.2024.04.27.23.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 23:08:59 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: dlan@gentoo.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Sun, 28 Apr 2024 14:08:47 +0800
Message-Id: <20240428060848.706573-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240428060848.706573-1-qiujingbao.dlmu@gmail.com>
References: <20240428060848.706573-1-qiujingbao.dlmu@gmail.com>
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
2.25.1


