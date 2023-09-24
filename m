Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F67AC7C1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIXLih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXLie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:38:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAFDFF;
        Sun, 24 Sep 2023 04:38:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2773f2e599cso204879a91.1;
        Sun, 24 Sep 2023 04:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695555508; x=1696160308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygmequM6X8SVeyJvfoY8+sWP6RwI5iKR0zSHbF+Gqd0=;
        b=dThGO9pqSVwZqfKGqysQQO8FfzYPzNKztBepck+LnMxqxHQda2beOvH0cQ3b3ffk6V
         5Xg9j4prdVgHdi8PEiPmH/newzvxY7D3Y7ZK9MwRxU6C8jmoihzaGBIPBIxGeStIjGpx
         zTQurP+EH6u4zSlGRwqLytByg6HI3zItPJNMNpJi9U+NCmo9GYS67/rhfcFTCyxr3MmN
         blAkM4S5E517e4oChPeI/8UOiyHvhuljyCE7q1MBxj8+lFSmWSfvNLV5rgfJ8DXk75ii
         xnu747vMBmBdf+Wwq4hnMr7qwUd4sh2SVB0n2BiQcV31SN1hB6tzUtZARqTIn0ul67nA
         wHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695555508; x=1696160308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygmequM6X8SVeyJvfoY8+sWP6RwI5iKR0zSHbF+Gqd0=;
        b=dkttI1Bjq6Nl2b4HHGqx+1/52OrwPjFmAwe02FCnFtTYOa2Y9xBfUiT5AUjyThaTbG
         0prC4TWakEv8ec31/mexkXXQ6K6cDTaMCh94hUHm0emfrbVnTvYbzDU723zDrZwzYlE8
         Ud2xRviu+mPXSitboyqQKUDqQ+ERk1Pdgd/xVmwY0O6ZTbxilUsc/ayyM32mTo83hgnd
         sUYeOX4O90aS4zfPgCzCBMhg05T50qm7FCGsjjAUgE/oQHlp29uin8vLsw5IM4hWL6xn
         Buc21a8wra9iL9GOYErd0SPwarfAkgMoits8xz7WyroJSJNLkNTf/QEbVSGBYVQz0Yor
         URSw==
X-Gm-Message-State: AOJu0YyHQ27BO8IJCSL+NCYxxDCkl64bAvqacDaJLsm45zN5/DocLpUj
        lxdsi9Ts2KZNlA+gE9UNaE4=
X-Google-Smtp-Source: AGHT+IEI7URBA4Skcmsfr5ChZP0QUxE8WRwEVkgD/HieECpdU+fz8NVZK1v0TuVCOT/kIFwJODK5hA==
X-Received: by 2002:a17:90a:f182:b0:274:c2b2:7bb7 with SMTP id bv2-20020a17090af18200b00274c2b27bb7mr2246863pjb.27.1695555508165;
        Sun, 24 Sep 2023 04:38:28 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a6e4200b002775281b9easm422376pjm.50.2023.09.24.04.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 04:38:27 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/3] dt-bindings: Add beagleplaycc1352
Date:   Sun, 24 Sep 2023 17:06:57 +0530
Message-ID: <20230924113725.164948-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924113725.164948-1-ayushdevel1325@gmail.com>
References: <20230924113725.164948-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds DT bindings for BeaglePlay CC1352 co-processor.

BeaglePlay has a CC1352 co-processor connected to the main AM62 (running
Linux) over UART. In the BeagleConnect Technology, CC1352 is responsible
for handling 6LoWPAN communication with beagleconnect freedom nodes as
well as their discovery.

It is used by gb-beagleplay greybus driver.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 .../bindings/net/beagle,play-cc1352.yaml      | 25 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++++
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/beagle,play-cc1352.yaml

diff --git a/Documentation/devicetree/bindings/net/beagle,play-cc1352.yaml b/Documentation/devicetree/bindings/net/beagle,play-cc1352.yaml
new file mode 100644
index 000000000000..f8536d1a6765
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/beagle,play-cc1352.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/beagle,play-cc1352.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BeaglePlay CC1352 co-processor
+
+maintainers:
+  - Ayush Singh <ayushdevel1325@gmail.com>
+
+properties:
+  compatible:
+    const: beagle,play-cc1352
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    mcu {
+      compatible = "beagle,play-cc1352";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 37b9626ee654..9d1b49a6dfad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8969,6 +8969,12 @@ F:	drivers/staging/greybus/sdio.c
 F:	drivers/staging/greybus/spi.c
 F:	drivers/staging/greybus/spilib.c
 
+GREYBUS BEAGLEPLAY DRIVERS
+M:	Ayush Singh <ayushdevel1325@gmail.com>
+L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/beaglecc1352.yaml
+
 GREYBUS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 M:	Alex Elder <elder@kernel.org>
-- 
2.41.0

