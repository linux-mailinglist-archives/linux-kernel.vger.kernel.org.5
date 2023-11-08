Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3AA7E5036
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjKHGFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:05:19 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782FC1AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:05:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1r0bgb-0000RT-J7; Wed, 08 Nov 2023 07:05:09 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1r0bgZ-007SxL-TZ; Wed, 08 Nov 2023 07:05:07 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <sha@pengutronix.de>)
        id 1r0bgZ-00CUHU-2k;
        Wed, 08 Nov 2023 07:05:07 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ubifs: describe function parameters
Date:   Wed,  8 Nov 2023 07:05:06 +0100
Message-Id: <20231108060506.2976328-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 16a26b20d2afd ("ubifs: authentication: Add hashes to index nodes")
insert_node() and insert_dent() got a new function parameter 'hash'. Add
a description for this new parameter.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311051618.D7YUE1Rr-lkp@intel.com/
---
 fs/ubifs/replay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index c59d47fe79396..17da28d6247ac 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -365,6 +365,7 @@ static void destroy_replay_list(struct ubifs_info *c)
  * @lnum: node logical eraseblock number
  * @offs: node offset
  * @len: node length
+ * @hash: node hash
  * @key: node key
  * @sqnum: sequence number
  * @deletion: non-zero if this is a deletion
@@ -417,6 +418,7 @@ static int insert_node(struct ubifs_info *c, int lnum, int offs, int len,
  * @lnum: node logical eraseblock number
  * @offs: node offset
  * @len: node length
+ * @hash: node hash
  * @key: node key
  * @name: directory entry name
  * @nlen: directory entry name length
-- 
2.39.2

