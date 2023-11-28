Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891277FB40E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbjK1I1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjK1I1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:27:37 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6444B91
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:27:42 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C5FE0240103
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1701160059; bh=s126nyyeqAhDr0wZnrkk/1Osln9ka5MImtMch8+JwkM=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Disposition:From;
        b=IYe0JnYyQ02t/4R4+25zF1oQujUUwJQTcTd1mny7PWZZ/qaxsIwx0dW00TY6HIhR6
         BsXJMOdHmX+WsS3SwhZatheLnLav9jcREISi/Qko8x0n34aPEHOjzDa4YAQs5j7cCV
         aSucv1OjuN3/qbD3Iyx+M4y1yw7PChPi1i7lMCoMkYEm4aXYCC0xk1MwepSbhnTr2/
         JRqYNCdwM3zmvtom8GSEBR80eBZzkifZomWqsR67mAjvAqlwclztkOI8n7sruMDUeS
         3J+kHyGRRZra8xe1wGSp2TTq4fm8EBrwF2lfPnuRApZwwS9uNgfYml0qVfxX3fNxil
         BNSXiULjCOzWg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SfbDW113Bz6twS;
        Tue, 28 Nov 2023 09:27:39 +0100 (CET)
Date:   Tue, 28 Nov 2023 08:27:37 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib: kstrtox: fix typo in comment
Message-ID: <ZWWkeVTvDBQDA_SF@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete one of the double f's in "iff".

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 lib/kstrtox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index d586e6af5e5a..b0a9fdce15b3 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -340,7 +340,7 @@ EXPORT_SYMBOL(kstrtos8);
  * @s: input string
  * @res: result
  *
- * This routine returns 0 iff the first character is one of 'YyTt1NnFf0', or
+ * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or
  * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
  * pointed to by res is updated upon finding a match.
  */
-- 
2.43.0

