Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26476AB54
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjHAIwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjHAIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:52:07 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5CA170D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690879925; x=1722415925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lim7+a33GYXp9HPQqoWL4hM7BJ8Bjctjt2wu1w10eT0=;
  b=CBJZlF10VdMpU46D2sa+ZH67xqeoDBWJiAWM9YJZx6AekGx0SEm8tUv+
   nXA49zEFJb86yvveLOBCEvwWHso9hMR3T8iIEY/OMj4LYOAVOgbtIXSqX
   BfZ8IGv4KRf/Z+ywx0WV0l+OMu175BaIXgJl6BVBpBBHo4THVs0qqYy5s
   1LAU/F7HIeb8Wk4IAPiaa1T3Ot55Jwxi75ilzBz6EOT7HXtDlF+EITo8R
   VLiTtKidOjMarJUt8ePymph52c0BRh+s1aR7ff6pwXragS39DMChobjK1
   5C4MOSYcAYXQJtHbi0xsxgNWq+brDdjKw4xyJW1M9CQ8hRwY/OlETj949
   g==;
X-IronPort-AV: E=Sophos;i="6.01,246,1684792800"; 
   d="scan'208";a="32223153"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Aug 2023 10:52:03 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id BF7FE280075;
        Tue,  1 Aug 2023 10:52:03 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [RESEND v2 1/1] MAINTAINERS: Add entry for TQ-Systems device trees and drivers
Date:   Tue,  1 Aug 2023 10:51:58 +0200
Message-Id: <20230801085158.87735-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes the arm & arm64 module + board DT files as well as x86
platform GPIO drivers.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This is a resend with only recipients changed, compared to the mail from 2023/04/17

Changes in v2:
* rebase to next-20230413
* Explicitely add corresponding maintainers

 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dd9ad3892ad..a6d06a9bdcc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21707,6 +21707,20 @@ S:	Maintained
 F:	Documentation/hwmon/tps546d24.rst
 F:	drivers/hwmon/pmbus/tps546d24.c
 
+TQ SYSTEMS BOARD & DRIVER SUPPORT
+L:	linux@ew.tq-group.com
+S:	Supported
+W:	https://www.tq-group.com/en/products/tq-embedded/
+F:	arch/arm/boot/dts/imx*mba*.dts*
+F:	arch/arm/boot/dts/imx*tqma*.dts*
+F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
+F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
+F:	arch/arm64/boot/dts/freescale/mba*.dtsi
+F:	drivers/gpio/gpio-tqmx86.c
+F:	drivers/mfd/tqmx86.c
+F:	drivers/watchdog/tqmx86_wdt.c
+
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
-- 
2.34.1

