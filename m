Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4539D7D9416
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbjJ0Jqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0Jqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:46:43 -0400
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705669D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:46:41 -0700 (PDT)
Received: (qmail 28645 invoked from network); 27 Oct 2023 09:46:39 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 27 Oct 2023 09:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=2018; bh=Bwdf/hXtE2z1yTkhneNd8f2BY
        QKrt7drzyCFHrjxjtw=; b=qxscFcUTB5Qwi7tQsy24z5rDPnCWiFulXa165hUpJ
        HzL+/8ak1Kj4Iuf44tIyV6YXIVQyWh7qO4lDKoicRJKyhxW2XJvU3U2VqrNtEI2G
        pysRjciBWXEsO7Nhu0C6TyP/onZxlm1ZoH4qqpnU7TP/6wbSvdJfJd4prRI5W20S
        qQ=
Received: (qmail 19359 invoked from network); 27 Oct 2023 09:46:39 -0000
Received: by simscan 1.4.0 ppid: 19049, pid: 19318, t: 0.5371s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 27 Oct 2023 09:46:38 -0000
From:   Edward Chow <equu@openmail.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Edward Chow <equu@openmail.cc>
Subject: [PATCH v2 1/2] dt-bindings: mtd: partitions: Export special values
Date:   Fri, 27 Oct 2023 17:46:09 +0800
Message-ID: <20231027094610.1022114-2-equu@openmail.cc>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027094610.1022114-1-equu@openmail.cc>
References: <20231025052937.830813-1-equu@openmail.cc>
 <20231027094610.1022114-1-equu@openmail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export special "offset" and "size" values defined and documented in
linux/mtd/partitions.h to dt-bindings/mtd/partitions.h.

Signed-off-by: Edward Chow <equu@openmail.cc>
---
 MAINTAINERS                          |  2 ++
 include/dt-bindings/mtd/partitions.h | 15 +++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 include/dt-bindings/mtd/partitions.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 668d1e24452d..7d6beadc8b36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13771,9 +13771,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
 F:	Documentation/devicetree/bindings/mtd/
 F:	drivers/mtd/
+F:	include/dt-bindings/mtd/
 F:	include/linux/mtd/
 F:	include/uapi/mtd/
 
+
 MEMSENSING MICROSYSTEMS MSA311 DRIVER
 M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
 L:	linux-iio@vger.kernel.org
diff --git a/include/dt-bindings/mtd/partitions.h b/include/dt-bindings/mtd/partitions.h
new file mode 100644
index 000000000000..b7f622fe458c
--- /dev/null
+++ b/include/dt-bindings/mtd/partitions.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Device Tree constants identical to those in include/linux/mtd/partitions.h
+ */
+
+#ifndef _DT_BINDINGS_MTD_PARTITIONS_H
+#define _DT_BINDINGS_MTD_PARTITIONS_H
+
+#define MTDPART_OFS_SPECIAL	(-1)
+#define MTDPART_OFS_RETAIN	(-3)
+#define MTDPART_OFS_NXTBLK	(-2)
+#define MTDPART_OFS_APPEND	(-1)
+#define MTDPART_SIZ_FULL	(0)
+
+#endif
-- 
2.42.0

