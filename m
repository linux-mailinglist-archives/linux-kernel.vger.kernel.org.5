Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2524786D72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbjHXLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbjHXLKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:10:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA86170C;
        Thu, 24 Aug 2023 04:10:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500a398cda5so90396e87.0;
        Thu, 24 Aug 2023 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692875428; x=1693480228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31bCEXmDXAJQ0gY++ElNzOZWxHPc79yuZ9Uvwsb2/Ew=;
        b=MZ/e9Hi8fWa745BDD29FtA/l8cF+6yUJcOLOrO1U/yNmfUWAspS0Ky7R09NYcSPphK
         hqzLtLRg7RqhuwOjRtk9VBcOJce3POH79UrAQ+ykjx7AZGYQnn/2cPrvctwERcdH86ww
         icvFvN4GB06yD1OuUkKvkOaqoMWta/rZI0pV0MWyv4wJtKWANfVeuQ84Nqu/QViZ/1h+
         wGlYAMxdOC6Z0qlRjSS88CNJOF/C0cMHNtA7N3MK6aFM/33t52OuDqG7wx0iiGigxkHI
         KlgQqrvrwjF0tM2IM+ZPEV+XFNxlD9dxAcD+GFsf1ZOrVlhM4vPfEzSu+KShbnRffY+f
         Nk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875428; x=1693480228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31bCEXmDXAJQ0gY++ElNzOZWxHPc79yuZ9Uvwsb2/Ew=;
        b=G3Jff2bluSuhE9COF5S0/txd1A1JJuuEfAXEgucVzj+4x/8eR3w0P8D9wSlTP7cUYp
         rbfqAkH6p9gFbvPJRDG2JbD1wJ8xQiMiXn7NvqeeJrpMOIn9xAmmwsfdgI9Qn9Ege3hT
         tjk2r8dGqQlmf/v0AE7Nn42Dj5zf0SsXTkBOUk35hAACVLzddWJa0T14IZ9oTf8G+l6C
         7yystLdych3pMPXudpSKsiHVW5nBpfmvBK+5rRCbU7ldbKlYDr8mWhLbbQSJxtfJXC3/
         agUOxtnknK7bq01YPBytIt/vVJv0wFBuqOPL5j6W8zljtUb3oq5S+mWQqtOp4FGfTL+I
         m1mg==
X-Gm-Message-State: AOJu0YwNOPvkLqkSUCkn4vY0xCM5bK2SYKahgpckyRwmudgznrk9HKee
        ZufGXB3A6gDmVyXc0SQ3muZR+iF9fCKfPA==
X-Google-Smtp-Source: AGHT+IGbyantVPiUOpRerZwnnJOgXoZjRWfuNk+iLwnCifvQpJ/NCiOTeiEOIFBjhSRk77RYXAqapA==
X-Received: by 2002:ac2:4db9:0:b0:500:8723:e457 with SMTP id h25-20020ac24db9000000b005008723e457mr6194863lfe.30.1692875427677;
        Thu, 24 Aug 2023 04:10:27 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402028800b005232e637c24sm972876edv.84.2023.08.24.04.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:10:27 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, quic_jhugo@quicinc.com,
        nipun.gupta@amd.com, tzimmermann@suse.de, ogabbay@kernel.org,
        mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv5 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand controller
Date:   Thu, 24 Aug 2023 13:10:14 +0200
Message-Id: <20230824111015.57765-4-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230824111015.57765-1-m.zatovic1@gmail.com>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO bitbanged Wiegand controller requires definitions of GPIO lines to be
used on top of the common Wiegand properties. Wiegand utilizes two such
lines - DATA0(low data line) and DATA1(high data line).

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-gpio.yaml        | 46 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
new file mode 100644
index 000000000000..cf2cb938de02
--- /dev/null
+++ b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/wiegand/wiegand-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO bitbanged Wiegand interface properties
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+description:
+  This represents the GPIO lines used for bit-banged Wiegand on dedicated GPIO
+  lines.
+
+allOf:
+  - $ref: /schemas/wiegand/wiegand-controller.yaml#
+
+properties:
+  compatible:
+    const: wiegand-gpio
+
+  data-gpios:
+    description: GPIOs used as Wiegand data lines, DATA0 and DATA1 respectivelly.
+    maxItems: 2
+
+required:
+  - compatible
+  - data-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    wiegand@f00 {
+        compatible = "wiegand-gpio";
+        pulse-len-us = <50>;
+        interval-len-us = <2000>;
+        frame-gap-us = <2000>;
+        data-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>,
+                     <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+        /* devices */
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0afcc88a38d2..fb158e74ca4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22929,6 +22929,11 @@ F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 F:	drivers/wiegand/wiegand.c
 F:	include/linux/wiegand.h
 
+WIEGAND GPIO BITBANG DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
+
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-- 
2.40.1

