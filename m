Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52779092C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjIBS3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjIBS3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:29:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD8FE54;
        Sat,  2 Sep 2023 11:29:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdf4752c3cso650335ad.2;
        Sat, 02 Sep 2023 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693679370; x=1694284170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV45jbupLFx2TG+9F8H1M507c169iOaYL5EH+k/ISNQ=;
        b=b57UZ3FlyFHEQLVUacAPzoi2SbGk7j0H39K2qdRqk2M6Ae03NSoanidOVapHAtc1xh
         ywzpo/TpmdNpk2Mci+WqgbEA8JRtZ8X77do0LuxvYlY+vyFY7rVHjU8/VGbRK5sBVFPC
         BhlSEH0jAezc1CbLb2Bww47CRyyFzQaq4EEtcxZMNKR/9cuxRaHD75fbWYyllQBx/Q+v
         YWMu/V4Gq/C8w/RvB5rs0eAvKdiJtFyWX0uKd6VzZqZrEFUtBINpVgaF8/E6p8pzojbe
         yJ0V5l/PZHKv+NxuLrqVaNdKKbgWhIt+rDoyKPIfEMlZ8y7O3+fjxsz+Dad04vwHG/gy
         mynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693679370; x=1694284170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV45jbupLFx2TG+9F8H1M507c169iOaYL5EH+k/ISNQ=;
        b=RXt8CYadxfMzKDCi6YEKvsNWqoyS7BL8/DG68kDJsxhDV28G3ksY7Ej/HEWEn7ny/k
         qMCDQKIlbxessx/qGLtcolol11q+UhbGyrd5F0eSjG5IqWOo6iWsTEUuze8kLINcRfwV
         cNswANMPXjTI+fQGEJoEIF9a91Xx+Fdr/2mR06FKv2dJZ/oAIcMKK/CEnHZBZmdZ7vbj
         pTwACsidD8LMMPuPV6uEuCMuGpvjAAm6NqYAqAW2R6WUT+rRPLXJvbiupNguZJcf0urR
         kljmaKeaPdOXu5+JlqZcG3TB6Wi/lIM2sk33d48jSTIso9PE2oRV3rUkORaeFtjgD9Dv
         wB4w==
X-Gm-Message-State: AOJu0Yx4IFWxM/XdR5YOwPhhO27T7fvneLe/2sfDY4l64biYsXi0tpfk
        9FdfJmgedN0R1XDHUy3TtMk=
X-Google-Smtp-Source: AGHT+IHPRUuIj1BKSj0LtnsNRNydQthbMqyTlX8mU4BFRpAG81lwjVcjG4Gude2PnINdpETkwpBLfg==
X-Received: by 2002:a17:902:f54a:b0:1be:e851:c070 with SMTP id h10-20020a170902f54a00b001bee851c070mr6497245plf.22.1693679369900;
        Sat, 02 Sep 2023 11:29:29 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001bf846dd2d0sm4918970pli.13.2023.09.02.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 11:29:29 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH v4 1/3] dt-bindings: Add beaglecc1352
Date:   Sat,  2 Sep 2023 23:58:41 +0530
Message-ID: <20230902182845.1840620-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
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

Add DT bindings for BeagleCC1352 co-processor UART.

The BeaglePlay has a CC1352 co-processor. This co-processor is connected
to the main AM62 (running Linux) over UART. The CC1352 can run Zephyr
and other embedded OS. This commit adds DT bindings for the BeagleCC1352
UART, which will allow Linux platform drivers to identify and access this
device.

This commit adds serial/beaglecc1352 for identifying this UART. It is
used by an upcoming gb-beagleplay greybus driver.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 .../bindings/serial/beaglecc1352.yaml         | 25 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++++
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/beaglecc1352.yaml

diff --git a/Documentation/devicetree/bindings/serial/beaglecc1352.yaml b/Documentation/devicetree/bindings/serial/beaglecc1352.yaml
new file mode 100644
index 000000000000..54db630a2a50
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/beaglecc1352.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/beaglecc1352.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BeaglePlay CC1352 serial UART
+
+maintainers:
+  - Ayush Singh <ayushdevel1325@gmail.com>
+
+properties:
+  compatible:
+    const: beagle,cc1352
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    beaglecc1352 {
+      compatible = "beagle,cc1352";
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

