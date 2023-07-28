Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94AB7664E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjG1HKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjG1HJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:09:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9A2129
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:09:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPHbS-00018F-IQ; Fri, 28 Jul 2023 09:09:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPHbR-002ei5-8p; Fri, 28 Jul 2023 09:09:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPHbQ-008RT5-Jr; Fri, 28 Jul 2023 09:09:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] binderfs: Drop unused #include <linux/radix-tree.h>
Date:   Fri, 28 Jul 2023 09:09:31 +0200
Message-Id: <20230728070931.589823-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=K6NughCM2B9a1iPV9D5TeiIuxR9U+AM+XqEi/wIkVYU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkw2mqedOLmxicD/Lc5KrYS7zm4c+jxUID5KHqe skUbqcVqYeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMNpqgAKCRCPgPtYfRL+ Th//B/0dgWJxlOnGVR0AGpyATdLyePwVU9hQj+RoDbyHzn3FFZaD6yA/WsM4cmJnu+Pj5huyUxx 3M2CXRM7HfDQ/olFrVOlJfHYlmgM+SYlyw7U7ijENM+nio2Rk0+8irwtPI8jl6cJzy4s2/eXCL9 EMKiKHWxouehbXtzKeQUnBTkYmtO2Y6MD++Z71irnKzlfwFW0842ogXA/pKP45R+OhnNOcdxO6B Ww5XNuM7mJnkfzzYOvHYwVs+n52LAKtW1GfUjGV04n08bS/nJtStrVYUOh+3zREq4KyVCCNj+tO ase4oCpHPnj0gj4FOrRUwlqqIoFas/n/dhOjAmR9Fqt76NE1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binderfs.c doens't use any of the symbols provided by linux/radix-tree.h
and compiles just fine without this include. So drop the #include.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/android/binderfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 76e7d6676657..90f497c3ff06 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -19,7 +19,6 @@
 #include <linux/mutex.h>
 #include <linux/mount.h>
 #include <linux/fs_parser.h>
-#include <linux/radix-tree.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

