Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3475B8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGTUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGTUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:40:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0256B12F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:40:43 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MaRzqTfmGqvVSMaRzqt4eq; Thu, 20 Jul 2023 22:40:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689885642;
        bh=0vihLSEijVc+4khiUaSyZhVfqYpVvrUyJvrv1+YFnyY=;
        h=From:To:Cc:Subject:Date;
        b=L1/KE4RS5R8t3saKi+2XLx1KQl9yxkPb6en+J7cXCGOTkVOxjiCkiOlcFJM1DbMV2
         Ud5Qyelj/+7XlrTzrUjyGE347aTDMyrCMN1jFi7yv3f46w0/MRM/OUe9zn9i9NwjGW
         E4PLCelbFpqwmtW38aT9znYVWK6WzvOJsyP9bhU5BBYQwPau6esWa3QQpTZPpLFTHF
         KKSKePVgxksUhw9XUltrInlib1WwyoAgYYMkTVZr9b2U6Hlo9sgR2GdXs7CHK7eHG/
         gIYP3ooy9KSzWiONuSSHZW+jjRZEgAsUB6PuOGXVy0TFGwHGyMyAF+9rpFwDNCh6nE
         3AnOicf7q2voQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Jul 2023 22:40:42 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] kstrtox: Remove strtobool()
Date:   Thu, 20 Jul 2023 22:40:35 +0200
Message-Id: <23d2ea6b90579207e87cc1bf64fc4eed1ed9f173.1689885328.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion from strtobool() to kstrtobool() is completed.
So strtobool() can now be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Unless I missed something, the last strtobool() calls have been removed
from -next just 1 or 2 days ago.

So it is maybe good to wait a few days or weeks to apply this patch in
order not to break something somewhere.

For now, see if build-bots agree with me :)


get_maintainer.pl is of now help here, so adding just Andrew Morton, and
Andy Shevchenko (who splitted out this file from kernel.h)
---
 include/linux/kstrtox.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 529974e22ea7..7fcf29a4e0de 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -147,9 +147,4 @@ extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
 extern long long simple_strtoll(const char *,char **,unsigned int);
 
-static inline int strtobool(const char *s, bool *res)
-{
-	return kstrtobool(s, res);
-}
-
 #endif	/* _LINUX_KSTRTOX_H */
-- 
2.34.1

