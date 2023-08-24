Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE7786D77
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbjHXLKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjHXLK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:10:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0E110F3;
        Thu, 24 Aug 2023 04:10:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5007f3d3235so6963186e87.2;
        Thu, 24 Aug 2023 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692875424; x=1693480224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOqOGUu9XTpMby37J2/6NyuYZOYyXurniqTokuMhOjc=;
        b=M+ZdVGijwgF6EDYjuIa4KPI6rGuaBeF2uOMBDDa4zccLcLAbMc/XFmBKGBlZYLqPnK
         MpmxyILHpN4EohLUOiONW5ayd+bxYabRsixhhMsTRPFemanQUWr/xderFFq2rwx24tmU
         9IQBZn7/RF2Bqo2dy+2FhxnMrhXR8n7W/c0dIiSq1+mEif58WDN4fyZOfpIPavGZQSjP
         csExQjJSkrrJzuotfeE/+SBb+SKQBiSXIGjycTgLXq9jyOH04k2FoOfpSn6Ks46/lYr3
         GnaiYFhc1XVBTEY6F8VirYZNjeIyiozusv92fk/403/2dyo1Na99Jctu1LH5gMoMeKZI
         uqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875424; x=1693480224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOqOGUu9XTpMby37J2/6NyuYZOYyXurniqTokuMhOjc=;
        b=BbAT8tukKkAnJXGsXx1VOvhLaUa7iL/2XXMoQTM0PWH2jgE012S6wpREZlPkwGqs2a
         1N6bIAe/vcTDpANUIP5xCs7VtklCOlyZXbKXWq/e/y0Krh5W6pmmdccNyEson0qOAWKk
         vnE/1PjE9Foh5shl0jdd4AIyVB09c7tViGQvDkDDg/T2RzFRSXJmm5ia0qLKfQl/7lIG
         ntKFJxf8JAGZU4XQA1EAYcsKov3svxdO7EImYpDSVwGl1nbxrjxVwKegDrGAyKevZ24b
         Af0rf1OEQf694bQedOwKTBkesqjSdGuQPiO1GpDrdpYXjSSgWEZTBzbTVCB/hIgSFq8W
         uR3A==
X-Gm-Message-State: AOJu0Yz8mm3aRRII+DyyVSHtRk0GskmZuoptGYsFsgD/T7lr46paN5iY
        3H+Tzh28kO+guEYwn/Hnnk7pLyf/j3nHXw==
X-Google-Smtp-Source: AGHT+IFkgXnin4CVmaceoQG0UKn5UdMSGuy1/gC4FMXOoNcQgvU/eaGx1Qm/guMgT3XO8XeajCOYWg==
X-Received: by 2002:a05:6512:b05:b0:500:9026:a290 with SMTP id w5-20020a0565120b0500b005009026a290mr5938686lfu.9.1692875423457;
        Thu, 24 Aug 2023 04:10:23 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402028800b005232e637c24sm972876edv.84.2023.08.24.04.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:10:22 -0700 (PDT)
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
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCHv5 1/4] dt-bindings: wiegand: add Wiegand controller common properties
Date:   Thu, 24 Aug 2023 13:10:12 +0200
Message-Id: <20230824111015.57765-2-m.zatovic1@gmail.com>
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

Wiegand bus is defined by a Wiegand controller node. This node
can contain one or more device nodes for devices attached to
the controller(it is advised to only connect one device as Wiegand
is a point-to-point bus).

Wiegand controller needs to specify several attributes such as
the pulse length in order to function properly. These attributes
are documented here.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-controller.yaml  | 39 +++++++++++++++++++
 MAINTAINERS                                   |  5 +++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
new file mode 100644
index 000000000000..8f36287e4fed
--- /dev/null
+++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiegand Generic Controller Common Properties
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+description:
+  Wiegand busses can be described with a node for the Wiegand controller device
+  and a set of child nodes for each SPI slave on the bus.
+
+properties:
+  $nodename:
+    pattern: "^wiegand(@.*|-[0-9a-f])?$"
+
+  pulse-len-us:
+    description:
+      Length of the low pulse in microseconds.
+
+  interval-len-us:
+    description:
+      Length of a whole bit (both the pulse and the high phase) in microseconds.
+
+  frame-gap-us:
+    description:
+      Length of the last bit of a frame (both the pulse and the high phase) in
+      microseconds.
+
+required:
+  - compatible
+  - pulse-len-us
+  - interval-len-us
+  - frame-gap-us
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index d590ce31aa72..75462d3746ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22922,6 +22922,11 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-wiimote*
 
+WIEGAND BUS DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-- 
2.40.1

