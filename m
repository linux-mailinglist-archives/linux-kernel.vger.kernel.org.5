Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391B478F6DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348117AbjIABvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348123AbjIABvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:51:33 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 939D310F2;
        Thu, 31 Aug 2023 18:51:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 0628260338E84;
        Fri,  1 Sep 2023 09:51:07 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?net/socket:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20used?=
Date:   Sun,  3 Sep 2023 02:22:28 +0800
Message-Id: <20230902182228.3124-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

used is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..743e54eba06f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -569,12 +569,12 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 				size_t size)
 {
 	ssize_t len;
-	ssize_t used = 0;
+	ssize_t used;
 
 	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
 	if (len < 0)
 		return len;
-	used += len;
+	used = len;
 	if (buffer) {
 		if (size < used)
 			return -ERANGE;
-- 
2.18.2

