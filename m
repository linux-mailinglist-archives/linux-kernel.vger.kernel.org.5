Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA48C75DD38
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjGVPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGVPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:30:09 -0400
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98911A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690039805;
        bh=Lb98OPtC0pJodNaiFuaz8C9OCJfXJAzplXHmVh8yQwc=;
        h=From:To:Cc:Subject:Date;
        b=KNn5Pgw/jBLHBOJDuR6P0D8J+lURa5D1wCiLUMurdmRc3LBormGjKWJjU02aY38Wk
         ImypIcb9Qj94PwfUSzXZQja91oz7lsJUb39fdNnWhFd5exj2hZPeVQ+d4w0MATCqw0
         zaFXWAp2A+YOoVRKhQ6gDRC+6fAVWNxfPQu7aS+o=
Received: from localhost.localdomain ([220.243.131.5])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 77B36465; Sat, 22 Jul 2023 23:29:59 +0800
X-QQ-mid: xmsmtpt1690039799t48281i7e
Message-ID: <tencent_8E383752B54E5BF860711E500AD8A8971208@qq.com>
X-QQ-XMAILINFO: N7g0nZ7nOFxRstsA0O+R9jSvDqjXPocuYT/bL+kI5YKZmJnQhV5RqOcel6u1tY
         GtCw/WnSDQotshdkI4Y/VvZWQQc1ix9lFaTTuWCg6v4OL0XBU0JKo1MW/7Urx/2BhMZ+NwokBgnL
         MHf7y3kA55TnbMzYxn4JAHBJpdRp9RwYNa6BytZ0T/wccwY4bW/etwTih24jfl35NhvWLuC26r2x
         UpgWD2r8YRg+pOFYdRwV+bwm8ZTrvsiCvfaQ0sSQeaGMzKWYqTWRg8uUas+XaxyCwOiR9sk/CwHo
         EAba0NyH/wcigR5e+F4uSgW9p0GULkTnzCBLmLZ8k3+Nhf93JA43reFbcgRYhjwLdGNH7UWi9MbX
         OWQl7+hetK1oO4dxPRMyT7wzMr/gFH4hMXRLlsNFe33gC9Fg2FPjJBmAcWcr5F56MvEabXP3QwEv
         G7jKtpsdph5FiElmL16SlTZ4KTSyajIW/01fLu8bPE+c1EsarKwA+SVe5+2q/h0feluCfdzyM0Ay
         ekSt5H7hh1eZm48ZNohirCcEhukQZc5xh215eVyZq9lYRyBag+3+73tkKqc8U+blfT1vPIgU+jLf
         MKsjx7PGZeUN/ooCt+c+w36YI8DbSzfmRm3L9diEMCpzhhshbGVPnkKRWgDF2KNzHrUGHE/2lSWK
         UfX7UCsnSju9rdTvkSZyQyvzJEKYr0gPOts3TFlP4lKbKZpBXiIaSG88ZoW2beImMZeOTSE03nwr
         wNIAgUiqoWCLnWemfRKnoYfT7GKdw2peP/nnSDCHkKim11p8kRN2HIyxHnF6FD2w+czSKnVqWTMt
         QgT7dMsUOWugW2vqdbAcArvN710/yR8MA12QlIPtadS/1PmbS+esT1yKhxmD/DvawQZRUtP9BqOn
         mH0BmhZ5ONn2om/UXkd8IZrwMj4BGCHg+bYPS4evWaOGKwdtmcGqb04KPDvlvlwKDYDUSbRKbGPK
         aUQxbKjoU0cLGcc86Fj0LEhcuLF/T6s7QWku/MIMlsSAZuKI5Jqhdd7+TqktDgqrhOllqrgDoKUW
         T83/uU+EtuK/UWq9SblUUf/WqTVcA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] uio: pruss: fix to check return value of platform_get_irq() in pruss_probe()
Date:   Sat, 22 Jul 2023 23:29:51 +0800
X-OQ-MSGID: <20230722152951.11879-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq might be failed and return a negative result. So
there should have an error handling code.

Fixed this by adding an error handling code.

Fixes: f1a304e7941c ("UIO: add PRUSS UIO driver support")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/uio/uio_pruss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 83966dbd3bbf..122c38e2fbbd 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -175,8 +175,12 @@ static int pruss_probe(struct platform_device *pdev)
 		goto err_free_ddr_vaddr;
 	}
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto err_free_ddr_vaddr;
+
+	gdev->hostirq_start = ret;
 	gdev->pintc_base = pdata->pintc_base;
-	gdev->hostirq_start = platform_get_irq(pdev, 0);
 
 	for (cnt = 0, p = gdev->info; cnt < MAX_PRUSS_EVT; cnt++, p++) {
 		p->mem[0].addr = regs_prussio->start;
-- 
2.41.0

