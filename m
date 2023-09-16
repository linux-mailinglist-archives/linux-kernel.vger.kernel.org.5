Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A57A313A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjIPPup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjIPPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:50:25 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326B9CEA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 08:50:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hXYkq3WSEUbVihXYkqPVvW; Sat, 16 Sep 2023 17:50:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694879416;
        bh=Apgbf+4k5j0y245gUGakuZZxFJFzdZ6jheOh94UyP3g=;
        h=From:To:Cc:Subject:Date;
        b=Q8rWoivz63vNREMgi47qen5kKm5KBYmXPC9+wiTnsNU0BR0L0+5jxXf7PDZasaVnz
         8ohvQ7QiIGvPMW7oM6UDkEz1UoiUCfSztkHA56sK2HS+d3pcOXzwY6WGVKSPGG6i3W
         IzrpVvt9n8Ta9/PI3VF/yAoYXDNO/ikh/c1ZAnmobGbo9w2nsG6bVnazxgw/YWdzbH
         hEIZkK/glw1ZBa267LkMf41OzHQuaYxUEnrCGUFre8TBfQp8N2nxPjRaDHrk51PRoX
         6GliQedPc22O89AzjZFflbhY6HcsYGwCiU5/U6KJC4GUnwmiknrThu+hXSQ9wzCLdN
         3CKIA3VQ5geEQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Sep 2023 17:50:16 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH resend] kstrtox: Remove strtobool()
Date:   Sat, 16 Sep 2023 17:50:11 +0200
Message-Id: <87e3cc2547df174cd5af1fadbf866be4ef9e8e45.1694878151.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion from strtobool() to kstrtobool() is completed.
So strtobool() can now be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v6.6-rc1 has no more reference to strtobool() (except a version local to
tools/)

The previous post is:
    https://lore.kernel.org/all/23d2ea6b90579207e87cc1bf64fc4eed1ed9f173.1689885328.git.christophe.jaillet@wanadoo.fr/
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

