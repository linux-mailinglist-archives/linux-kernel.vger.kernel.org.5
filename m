Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8B1753294
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjGNHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjGNHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:09:14 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C132111D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:09:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2Mz65h5VzBJYck
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:09:06 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689318546; x=1691910547; bh=aEOjYlNpRSRGqj67rndtoqzSd6P
        6eexwN4h5qbJ2GYo=; b=gxsTLXBZ8QpbCB8CHGyQcfMoBuYk3evkDI9BJO4Nzy4
        o6zScSWeRjdiwAaq5Z6u2+UQOmtXjRmv+1x6HotcIl364WEhwVtTA/iubElZcrdL
        Ha6hFWQFBaoIjeTn345Tp4JncwoxbqiMwyzS6EhYMhK7NV55j7Ea1dne5bEBQV30
        j+ZHbXqgb6pkxD8Lr7Mby18be9MX1ZwJjxey1qGcuVm00yNIUdq1ZG8Hg7shoVgo
        f6HOZAmHacRqgvmm0iDHdF7B3CVERArTO/0d3W3o1jArpxf15mfUTAFixNwz2hn5
        q0U7enR7dpHmyTCDtaGj53jWBD7N1TRoxRlf3Roh6PA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A6jvvoLkkvH9 for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 15:09:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2Mz63hH8zBHXhl;
        Fri, 14 Jul 2023 15:09:06 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 15:09:06 +0800
From:   liubin001@208suo.com
To:     djwong@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] xfs:ERROR: "(foo*)" should be "(foo *)" changed "(foo*)" to
 "(foo *)"
In-Reply-To: <tencent_9C05655A70D8827032EDA951EDD15B41E50A@qq.com>
References: <tencent_9C05655A70D8827032EDA951EDD15B41E50A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <d869aea13b8aed932e44d9052773f214@208suo.com>
X-Sender: liubin001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs:changed "(foo*)" to "(foo *)"

Signed-off-by: Liu Bin <liubin001@208suo.com>
---
  fs/xfs/xfs_buf_item_recover.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf_item_recover.c 
b/fs/xfs/xfs_buf_item_recover.c
index 43167f543afc..db3e45ffceaf 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -232,7 +232,7 @@ xlog_recover_validate_buf_type(
          return;

      magic32 = be32_to_cpu(*(__be32 *)bp->b_addr);
-    magic16 = be16_to_cpu(*(__be16*)bp->b_addr);
+    magic16 = be16_to_cpu(*(__be16 *)bp->b_addr);
      magicda = be16_to_cpu(info->magic);
      switch (xfs_blft_from_flags(buf_f)) {
      case XFS_BLFT_BTREE_BUF:
