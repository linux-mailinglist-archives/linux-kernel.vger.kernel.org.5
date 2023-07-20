Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F202175B353
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjGTPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjGTPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:45:51 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B90210A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:45:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6H8N0bk8zBRDt1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:45:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689867939; x=1692459940; bh=rA3LsmEExDkifAC66xC/4ro3wIm
        UgiElngu8v2fP7bc=; b=GeGnFBr3UPUGMbCkutoI74G9Dhx58URTmn6PuybBRlk
        BGpbP5HIOyYYyly5N8qdLnq+OzZdUB3KMymF1WnvrWxeezxGI80pzpZlCVg9uJdA
        H/6yqrZS6EI0BUYN1Lj9GiDn6B9FQUxgQUL6FFrmsHWShwWWEZueDz4gcx2WxTNn
        gp+w6qJjqVGks4nLyyOGKrSiuBzIebz21TSTLEC9R8gjap6DRnOdwLSTRwvUh7ZI
        08/WJe41d0Uoyzf+Mhfj/0wEnvTIZ9Rw2Zvgp4myYuu3q4/kdHuQ8wMtAfCVVLiX
        QOng683HBTBMVoyNU5vDO0Q31XeBWv7Cq76arUkFBlA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZfZwQSYoXbyc for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 23:45:39 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6H8M4tCGzBHXgs;
        Thu, 20 Jul 2023 23:45:39 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 23:45:39 +0800
From:   pangzizhen001@208suo.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux: Fix typos in comments
In-Reply-To: <20230720154408.51494-1-wangjianli@cdjrlc.com>
References: <20230720154408.51494-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <70293ecd5bb7a1cd370fd4d95c35f936@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  include/linux/seqlock.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e9bd2f65d7f4..af518e4d0c6b 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -864,7 +864,7 @@ static inline unsigned read_seqretry(const seqlock_t 
*sl, unsigned start)
  }

  /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
   * do_write_seqcount_begin() instead of generic write_seqcount_begin().
   * This way, no redundant lockdep_assert_held() checks are added.
   */
