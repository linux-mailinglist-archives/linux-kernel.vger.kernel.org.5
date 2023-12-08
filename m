Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57A780A840
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjLHQJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjLHQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:09:12 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E099173F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:09:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPe-00007v-FO; Fri, 08 Dec 2023 17:09:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPb-00ES0C-Vq; Fri, 08 Dec 2023 17:09:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPb-00GUa9-M7; Fri, 08 Dec 2023 17:09:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Kalle Valo <kvalo@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: [PATCH 0/7] pcmcia: Convert to platform remove callback returning void
Date:   Fri,  8 Dec 2023 17:08:05 +0100
Message-ID: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9Ictt+knkOJNuemGfNKrzIrsxzGbz53Oqm+O5mi6WaM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcz9lJGPbvoEMnqsl7Qr1SCKKD1A9y9zybWogF ImCGXNrY+yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXM/ZQAKCRCPgPtYfRL+ TnDuB/9J0A2E+LLI/05+w5rATQTPFLLeDNa/wCxpICyuyIXFGU5+AmThOLA3AqsYX2CEzIuTL2Y RTIDS5zEvN0wbWUWgiv5gYMzLIDLPUO8Kph1awKYAHfjG4UP9xJLnCU9435lrwH1b6Os58V88ds tuf3rkpYGRmXkkeRIvZsstelkW8oePt6WwWZVr2X4VW8zsWeAJwVsFU0n/z41JvyiYFSFM7w2wu UI8Fg8s1e/HQvX3n7T/hC5XwkzrZz0aIK8H1NqgJfboPHYIr1OG4POdJLLUDBu4WBhI+eGeXPq2 vSGwXsFJFC7I9PEbTOKiNR51SP4MAs6AWLSyOYmnLk/NbgGD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series changes all platform drivers in drivers/pcmcia to use the
.remove_new() callback. See commit 5c5a7680e67b ("platform: Provide a
remove callback that returns no value") for an extended explanation and
the eventual goal.

All conversations are trivial, because all .remove() callbacks returned
zero unconditionally already.

There are no interdependencies between these patches, so they could be
picked up individually. However I'd expect them to go in all together.
It's unclrear to me though, who will pick them up. Dominik? Greg?

Best regards
Uwe

Uwe Kleine-König (7):
  pcmcia: bcm63xx: Convert to platform remove callback returning void
  pcmcia: db1xxx_ss: Convert to platform remove callback returning void
  pcmcia: electra_cf: Convert to platform remove callback returning void
  pcmcia: omap_cf: Convert to platform remove callback returning void
  pcmcia: pxa2xx: Convert to platform remove callback returning void
  pcmcia: sa1100: Convert to platform remove callback returning void
  pcmcia: xxs1500_ss: Convert to platform remove callback returning void

 drivers/pcmcia/bcm63xx_pcmcia.c | 5 ++---
 drivers/pcmcia/db1xxx_ss.c      | 6 ++----
 drivers/pcmcia/electra_cf.c     | 6 ++----
 drivers/pcmcia/omap_cf.c        | 5 ++---
 drivers/pcmcia/pxa2xx_base.c    | 6 ++----
 drivers/pcmcia/sa1100_generic.c | 8 +++-----
 drivers/pcmcia/xxs1500_ss.c     | 6 ++----
 7 files changed, 15 insertions(+), 27 deletions(-)

base-commit: 8e00ce02066e8f6f1ad5eab49a2ede7bf7a5ef64
-- 
2.42.0

