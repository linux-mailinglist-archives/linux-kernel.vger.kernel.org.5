Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7AE7593F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGSLK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjGSLK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:10:27 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD82189
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:10:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5Y5D29nXzBRDrb
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:10:24 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689765024; x=1692357025; bh=mhF1ILjox9N5+ynKfNrAuyFUxiw
        hKqI6nL3g6Yq0YZI=; b=p5je57100OQ9j4vXSocxpSwAw0jWZpXybJzAh34nmSI
        wEKVHjBGJ08P1ZRQ8tiKbDoSxTjt9jXnHPF+p+/ROu9vbbCQ/cWi+nZeVdtfSR72
        kVSqZSX9rQKxqHbiB+Ob3L+0MGI5xz0eXHQWbBw8g/mL4Am2JvpfN9pCmQAwbupg
        7o9PZ3qOZSEIJa65a8A0pNPnUGiPlFQhSeXvEZy3+O/XDi0/RpZQv4kolnW2abFf
        5VoNk5Q49ZU+PhyZ/w0DYQw5DXpjFf09co8xh/keLKCRsQpJXBfZ6N1RTB4ENMNi
        m2wKEgY19/M/1KH19g5U7oIz7fWc5FHvbBBnAbdtvBA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vJkKwA5ihFCF for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 19:10:24 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5Y5C6yvRzBR7Zc;
        Wed, 19 Jul 2023 19:10:23 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 19:10:23 +0800
From:   huzhi001@208suo.com
To:     xiubli@redhat.com, idryomov@gmail.com
Cc:     jlayton@kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix errors in cache.h The following checkpatch errors
 are removed: ERROR: "foo* bar" should be "foo *bar" ERROR: "foo* bar" should
 be "foo *bar" ERROR: "foo* bar" should be "foo *bar" ERROR: "foo* bar" should
 be "foo *bar" ERROR: "foo* bar" should be "foo *bar"
In-Reply-To: <tencent_4A53697595E9D930D4AE5727D5913360DB0A@qq.com>
References: <tencent_4A53697595E9D930D4AE5727D5913360DB0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <071ee91b1fade5bc4de45f3e33f45f5c@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  fs/ceph/cache.h | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index dc502daac49a..b9fb1d1b21a1 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -14,11 +14,11 @@
  #ifdef CONFIG_CEPH_FSCACHE
  #include <linux/fscache.h>

-int ceph_fscache_register_fs(struct ceph_fs_client* fsc, struct 
fs_context *fc);
-void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc);
+int ceph_fscache_register_fs(struct ceph_fs_client *fsc, struct 
fs_context *fc);
+void ceph_fscache_unregister_fs(struct ceph_fs_client *fsc);

  void ceph_fscache_register_inode_cookie(struct inode *inode);
-void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci);
+void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info *ci);

  void ceph_fscache_use_cookie(struct inode *inode, bool will_modify);
  void ceph_fscache_unuse_cookie(struct inode *inode, bool update);
@@ -76,13 +76,13 @@ static inline void 
ceph_fscache_note_page_release(struct inode *inode)
      fscache_note_page_release(ceph_fscache_cookie(ci));
  }
  #else /* CONFIG_CEPH_FSCACHE */
-static inline int ceph_fscache_register_fs(struct ceph_fs_client* fsc,
+static inline int ceph_fscache_register_fs(struct ceph_fs_client *fsc,
                         struct fs_context *fc)
  {
      return 0;
  }

-static inline void ceph_fscache_unregister_fs(struct ceph_fs_client* 
fsc)
+static inline void ceph_fscache_unregister_fs(struct ceph_fs_client 
*fsc)
  {
  }

@@ -90,7 +90,7 @@ static inline void 
ceph_fscache_register_inode_cookie(struct inode *inode)
  {
  }

-static inline void ceph_fscache_unregister_inode_cookie(struct 
ceph_inode_info* ci)
+static inline void ceph_fscache_unregister_inode_cookie(struct 
ceph_inode_info *ci)
  {
  }
