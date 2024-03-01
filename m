Return-Path: <linux-kernel+bounces-88317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2D86DFF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6728B222A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847236F06C;
	Fri,  1 Mar 2024 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpgMwL0k"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78B6CDA5;
	Fri,  1 Mar 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291563; cv=none; b=Vx+ZFj/GLaeA9I2cBQZjf0ethJcVAHaIo0lTUzVqm4WfZ8KebB7SjxhFgmsoexK1kBnrFIVhTW7mLj+KJXJWeofM/uy5hSN/SZIPpdrvCslDrTpqARTZ811GevRfgh6uhFUaLI69bqfP4aifWxGQEkH+QGQdOTwElRjeD83i1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291563; c=relaxed/simple;
	bh=ZcXh5FtON65IFFWLi8WCHoxgIUc/5UvzSJLTC0D+gNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCmjdcWnkpHSUwt5Vcg7egCcf9jSW/uwyAuGJeTA18p4XzXCgG6JLQOl2x6ej6BH59pqhQWYQJtzf9tMtH0CUziu0vrM63LlIAaS8iK2p8WC7eeZzphjWTS6DpU7IbfoT2dN62wa6d3o2/9zaNUcA2pt3qkvU72e049isjD6IbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpgMwL0k; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5094183a12.1;
        Fri, 01 Mar 2024 03:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291560; x=1709896360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFXpgh2dqrGyE1Rignr5uC/50XLP7JPOWIkkNnxbS/8=;
        b=jpgMwL0k29ruQU1wmWPgGaVhI+N0FsK8OyXMmbF8ELJFe0V2miHvHPEVNR+F4uq5OA
         BHtbcQaqdPEDW+NOS8thOur7RvB9wbd42uKsShqo5LbsvI7y4RlULKZTW8/xjAPRuPwn
         bSKc0nCjFZ7PPujcF7a0RJVtEjniaRQcgTzzyyQLisgVHPBs8DFq7c+p8ulH3dRyOFzu
         iJoXnAEGJYwiJxRdnG6iXWx88ZYkk/7bysZCVLFdfSNVuUAlvNEGsYGXc0AjmP4jN4HS
         V+Fv7Jc9/3eG4uRRyk5G5m+M3aCOiJb7kmt6DKfFC1ww4mq1l3w4S2lVgxQPUjrp8h7D
         KQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291560; x=1709896360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFXpgh2dqrGyE1Rignr5uC/50XLP7JPOWIkkNnxbS/8=;
        b=LucRiZ2wiLVp4Vb0iupHP7W7vAkqXDACzFn1I67D/EGxL1KSIEd4XPpW6riVRY29Ua
         QtUMEvnjWBRiqfhvMUHIDdSv3JPLKPtTqGYkazNFSb0mFkIKCc7Nxiy/2vo0d36I5vU8
         Xy4eMQyj3Xxxt12mkzK6n0M+2i6SpwkKj/CfjdJujJZmg/M0FC3zuWE5mUSPualYm5cA
         GmdkGh0aLZwC1E89OtyfMTCqSVKGJwxpIPJwHxER9ZCz3U+KhcyamemlWKN+0yJNIhbm
         IF7ozSC9rJncoWuE90XBdRrAc97Jic3TDEAs/thNU0C6U1Q9khU2NysUQ/GJn5zsA5u4
         kVvg==
X-Forwarded-Encrypted: i=1; AJvYcCXs8M/Mr26a3xxtfQarmAFImBDtiqybcSdQXRm71sdiZ5uGUePeUTX9o7rIeQ76kfougStsSWrxvFigKyVCiriQPqkkYGobp0ZYpT/eSgAFrXomXvXRf+nuDtwwoTIsJJ/9lQU7ZDcaCukyoHLAAHQ3LmidJM8vz+nrtPtpddWOOgSJxQ==
X-Gm-Message-State: AOJu0YzQybvoVuIIGRUHDywVbgvXgLdgFZK2Qc92bwdlhIDlP6Gq0x/6
	xv+wAv1vEA44Ng4D5yqYF9WvVgJzDZ5axD8olhK7hqCjwu5re7uV+zK1vPQh
X-Google-Smtp-Source: AGHT+IFpNSPUOypt4J8usVOyPInHeu7emdsC4RhR6Ja7jYBR8q8w5QCpCguspfiiSDa3D7c6OJ67eA==
X-Received: by 2002:a17:906:7f0f:b0:a3f:d260:4a72 with SMTP id d15-20020a1709067f0f00b00a3fd2604a72mr1197125ejr.27.1709291559560;
        Fri, 01 Mar 2024 03:12:39 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906089200b00a43a478e4f0sm1583254eje.180.2024.03.01.03.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:12:39 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: pwm: add support for MC33XS2410
Date: Fri,  1 Mar 2024 12:11:22 +0100
Message-Id: <20240301111124.29283-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301111124.29283-1-dima.fedrau@gmail.com>
References: <20240301111124.29283-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation for NXPs MC33XS2410 high side switch.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
new file mode 100644
index 000000000000..1729fe5c3dfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,mc33xs2410.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: High-side switch MC33XS2410
+
+maintainers:
+  - Dimitri Fedrau <dima.fedrau@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: nxp,mc33xs2410
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 10000000
+
+  spi-cpha: true
+
+  spi-cs-setup-delay-ns:
+    minimum: 100
+    default: 100
+
+  spi-cs-hold-delay-ns:
+    minimum: 10
+    default: 10
+
+  spi-cs-inactive-delay-ns:
+    minimum: 300
+    default: 300
+
+  reset-gpios:
+    description:
+      GPIO connected to the active low reset pin.
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  pwm-names:
+    items:
+      - const: di0
+      - const: di1
+      - const: di2
+      - const: di3
+
+  pwms:
+    description:
+      Direct inputs(di0-3) are used to directly turn-on or turn-off the
+      outputs.
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      The external clock can be used if the internal clock doesn't meet
+      timing requirements over temperature and voltage operating range.
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Logic supply voltage
+
+  vspi-supply:
+    description:
+      Supply voltage for SPI
+
+  vpwr-supply:
+    description:
+      Power switch supply
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+       pwm@0 {
+           compatible = "nxp,mc33xs2410";
+           reg = <0x0>;
+           spi-max-frequency = <4000000>;
+           spi-cpha;
+           spi-cs-setup-delay-ns = <100>;
+           spi-cs-hold-delay-ns = <10>;
+           spi-cs-inactive-delay-ns = <300>;
+           reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+           #pwm-cells = <3>;
+           pwm-names = "di0", "di1", "di2", "di3";
+           pwms = <&pwm0 0 1000000>,
+                  <&pwm1 0 1000000>,
+                  <&pwm2 0 1000000>,
+                  <&pwm3 0 1000000>;
+           interrupt-parent = <&gpio0>;
+           interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+           clocks = <&clk_ext_fixed>;
+           vdd-supply = <&reg_3v3>;
+           vspi-supply = <&reg_3v3>;
+           vpwr-supply = <&reg_24v0>;
+       };
+    };
-- 
2.39.2


