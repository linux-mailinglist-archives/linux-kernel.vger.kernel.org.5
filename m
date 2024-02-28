Return-Path: <linux-kernel+bounces-85097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3626486B066
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4461C22FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4486C73508;
	Wed, 28 Feb 2024 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzhQqs4V"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4D14D426;
	Wed, 28 Feb 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127174; cv=none; b=hbnGUWvlIn5XUueXtZKuOnr1KiJaBT18F6Bd2ZS2QfJfSudGZ1ePSo+9X7Xfzw9ArWq8wa6KQO3A96tAnsDcYWRjDPBQQBp6bw0mBfOmBtPEndzyzx/2YIswcymj7zkWZFR2b70VilCIvKHqvfvzBRMCYL1z9bmdMYgnEzIP9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127174; c=relaxed/simple;
	bh=rCU5g5F2BCVusNboLGIvYMJTZ2rlSycLIcxkBmi0yCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icXnGiZxhabYJWJ6UlHuO3YYLMbeYkeIuBhS75jIvOJPKf7zeBj73qx7cJ0sg66w6FgvR5RHyu8/KSSyCzVcNYB6SKRFO3oTPbv19OLig8xNYidOnoR2yMlJUjz6sV6L1aQaOAQCHiAfb8qYL5cXCYql+V36EYfumEK1WPrtI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzhQqs4V; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso684017966b.2;
        Wed, 28 Feb 2024 05:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709127171; x=1709731971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4lxyPaoqRvNSg6SFq02AUDkEnHT9gwaoI5W6JGTtvQ=;
        b=IzhQqs4VEfgh1YCfQrHPCtaspTbNrVkGb+HQ5+amT7k3vGdF/GUkBXCgKSn1uQazTT
         SL+BHn52VnJLYMWB2TNMXeHup2hvJnXcw97SrQ1SwDvNiTWUV75KdCGe2jqtPEWm5z5i
         UFjBAij/4lkbMAsVbO1zKBLbzMjPD5XlKOsOQm3/Ec0InvPyLKqaam7EA4G5y1tvwwiL
         PMLzd7I74TjIoTdMGyCnLsPw96m3XbnvhYa+yXSqmAK5rOV0ACrhedh6LxCgMjVkMJ9V
         rPH0nln24uNBrmlnyIYjNv0fDQtRNpUz1/BBv8msvuZVr+xuLPlUPxMs1WZGG9ExXIXk
         pTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127171; x=1709731971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4lxyPaoqRvNSg6SFq02AUDkEnHT9gwaoI5W6JGTtvQ=;
        b=qZiELcjiC7paDVMg70BZLz63fUVDt5Cnr5bZimF8tKptcyVTyQuj/DjilWGnLo7VbV
         yOSvhli7Kjh4WiHXcoCZv8P6th8b1xrbqwnivvat1LqBlI4E+r3McgIBwICq86yVuWew
         H0SV/r3JGd/vjvIG6Yc/d9LCLLaufKOn7gtb/0X/Cuz7HzrzbeDnxPFRm5+atwdvigt8
         w/4N06YuuP5GToBlBkpfUrv8y1ql/WFCGSBYNaP/qk1z1YR01hkKrLdLbKVopE2byeJ6
         HMAfWlFsblomcJqzbSDZ44nynG0yMQnJoCMa+76Em1P6hQeEnTn2S8L65zQ9n8zNjJT2
         VOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN2rV5FkRh/EXSmAF5dv7HLQLJ0QQn9Td3SLPuJYx2dIcBiloZrK/zK9vQpeYq8uzJfFB57QB/4RACIrYJvnyFaNUvjNXyXUK1nQcsuPFdTN0SiZ6MJqiVzwS3Lp4EDDhXeDAgF/HouI6xlP993V8V6Fd+HyYiPS8XjA+QIXr+yrV41A==
X-Gm-Message-State: AOJu0Ywk6kiFRi+pV8C3pomzXReRrkMVbawGOVAjNVwEvMOHfgoQltIX
	JDJNjmqEZuAkObxkHXkpOHj/SnVfIOxZIp7jhUgNzd4ah1emNw3WF/Gumb5C
X-Google-Smtp-Source: AGHT+IGnLungNAv0ZYzj8hkENB2u973aFJUB+oB/lJ2qSc8+PILh1uRY9vGn1xmHKwKif4szbTnaAw==
X-Received: by 2002:a17:906:4a55:b0:a43:6156:6e75 with SMTP id a21-20020a1709064a5500b00a4361566e75mr5651188ejv.43.1709127170959;
        Wed, 28 Feb 2024 05:32:50 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id vx5-20020a170907a78500b00a3f20a8d2f6sm1856952ejc.112.2024.02.28.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:32:50 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: pwm: add support for MC33XS2410
Date: Wed, 28 Feb 2024 14:32:33 +0100
Message-Id: <20240228133236.748225-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228133236.748225-1-dima.fedrau@gmail.com>
References: <20240228133236.748225-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation for MC33XS2410 pwm driver.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 .../bindings/pwm/nxp,mc33xs2410.yaml          | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
new file mode 100644
index 000000000000..bd387dbe69be
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,mc33xs2410.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MC33XS2410 PWM driver
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
+  pwms:
+    description:
+      Direct inputs(di0-3) are used to directly turn-on or turn-off the
+      outputs. The external PWM clock can be used if the internal clock
+      doesn't meet timing requirements.
+    maxItems: 5
+
+  pwm-names:
+    items:
+      - const: di0
+      - const: di1
+      - const: di2
+      - const: di3
+      - const: ext_clk
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
+  interrupts:
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
+    #include <dt-bindings/gpio/gpio.h>
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
+           vdd-supply = <&reg_3v3>;
+           vspi-supply = <&reg_3v3>;
+           vpwr-supply = <&reg_24v0>;
+       };
+    };
-- 
2.39.2


