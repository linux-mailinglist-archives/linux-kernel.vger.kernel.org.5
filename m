Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F282B805417
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjLEM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjLEM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:26:32 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98DD7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:26:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVZ-0005XV-Aq; Tue, 05 Dec 2023 13:26:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVW-00Djul-Mr; Tue, 05 Dec 2023 13:26:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVW-00EhQX-DJ; Tue, 05 Dec 2023 13:26:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, kernel@pengutronix.de
Subject: [PATCH 0/8] regulator: Convert to platform remove callback returning void
Date:   Tue,  5 Dec 2023 13:26:15 +0100
Message-ID: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8all5/IHFXIAXqeYzLVd/ErOOyU8CBOkibjzWo7s07Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbxbmmD94bntqRzhdfRPibGRUIkQg4ZpUucl6c uy9sofkpFuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW8W5gAKCRCPgPtYfRL+ TkOmB/9/EmP6fTqC77VRMQD4r69MCOPkQ6Gf5bN+WCbkAhMPeVSdIhHxWbT7JUdXHtWiE+tgK2g cVCfMPenzVd+W+p8iesX9IQqsogSys3xirj6eb5v2y8h/gyIpDS8ajg+hiifRTEOzvNPEFOhBJ0 T+oX6QJvXAuQ+K3aQe33V6rdSQxamaOlGmcFGTrCDSgV0lCbeqqBPD5uzVYsGQ3sZ82MeNOfZ4e Ycb/rKiqxKt7kaV8Ladpk++mZ97UPqZlZjm0Z4Hjtrt442WQRT2BJj8IIbbImf1IwFj8beIuaL0 JrTaavDxcQJBZ10cOCLCQViDgatGMdhyxsI4HtD+2SO4UIa+
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

this series converts all drivers below drivers/regulator to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

All conversations are trivial, because all .remove() callbacks returned
zero unconditionally.

There are no interdependencies between these patches, so they could be
picked up individually. However I'd expect them to go in all together
via Mark's regulator tree.

Best regards
Uwe

Uwe Kleine-König (8):
  regulator: arizona-ldo1: Convert to platform remove callback returning
    void
  regulator: bd9571mwv: Convert to platform remove callback returning
    void
  regulator: db8500-prcmu: Convert to platform remove callback returning
    void
  regulator: stm32-vrefbuf: Convert to platform remove callback
    returning void
  regulator: uniphier: Convert to platform remove callback returning
    void
  regulator: userspace-consumer: Convert to platform remove callback
    returning void
  regulator: virtual: Convert to platform remove callback returning void
  regulator: wm8350: Convert to platform remove callback returning void

 drivers/regulator/arizona-ldo1.c        | 8 +++-----
 drivers/regulator/bd9571mwv-regulator.c | 5 ++---
 drivers/regulator/db8500-prcmu.c        | 6 ++----
 drivers/regulator/stm32-vrefbuf.c       | 6 ++----
 drivers/regulator/uniphier-regulator.c  | 6 ++----
 drivers/regulator/userspace-consumer.c  | 6 ++----
 drivers/regulator/virtual.c             | 6 ++----
 drivers/regulator/wm8350-regulator.c    | 6 ++----
 8 files changed, 17 insertions(+), 32 deletions(-)


base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
-- 
2.42.0

