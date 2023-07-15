Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670D754775
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 10:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGOIRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGOIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:17:04 -0400
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD4A3A8E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 01:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689409019;
        bh=IYNA/T8SwiQPcz1b4CrLywjEfP8ocEm4NvLV8lNv8kw=;
        h=From:To:Cc:Subject:Date;
        b=a2KV8qJ/rZstBzEyA8bb5wjb0f/kT13+dgI0iua3ubOBo7RA1CjoioH4GaOW27rcS
         Ew7gvnsMvdGNTIZaO5sOnSb+TQyVDZ86L9HKPo5UbCTY2wqkgbefSKiuZIEVfm617t
         HeNlXEBpVuOGuwsreWcTX+zW6kzNyYqKHqtz+XxI=
Received: from KernelDevBox.byted.org ([180.184.51.40])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 4391A0B9; Sat, 15 Jul 2023 16:16:57 +0800
X-QQ-mid: xmsmtpt1689409017twy3nsj2q
Message-ID: <tencent_DB7525706E9A6B13B7E6C1C43C36145A5009@qq.com>
X-QQ-XMAILINFO: MRhkIe3mT0C6m1ATvlVQLha9jUu1RBv3lzuVv1YxAOKDB3WzREnvbushfWNJ4e
         TPizoQAkpPBgxOsIBCf1fJG9we38ZE0kvpkyObiG9DDQZJ+S/tRdcDNMJUn3ivMKfkSeGGJCd9Ep
         aOP52SiMeeYENmT8QbcdNN2wPIWxfdKryjv+29RPGpkVgv3hcoZ15umTZBE3iQMZOMVm09IEWv6j
         qj+tHb/0w6w0gPkbCbtEQv6xEBGtwDz4/0kMTvkhKyRAuDFnNaeqGz0ufSB3MLl3/sWHCTX/3Uu0
         IxW58m+Nch/pnUJDTGkzmDWDRIsNyPaJnZTnB8NO62aF0juZtNe+8+yVCs6TdPM/rGmbQ7Rh6vdL
         eTlj/7dCNVoi40r77ojn1DClMGlrda1uYoOpkYK3h3LU46B7TYro9kS3TpGBjCaNP40akCSmtqL2
         Mswu/kozly/H34ojBu1OEoO1pmlvfabOXsrX2HygpqSapV3f3w+KtprXJXuUDCzI+wOBZ90Mjfs9
         +p9kNMzJDLw5ptzsz7jpv6316AwOwA3ORm9oICVgMZx2+WnqH9qDRePh19RCaBMgtkQFrWKl7oJ9
         2bbx77sMkZe0sFVs3HtfwtpYlg1tMUE2i2ekWgaeS7l4D5YfkjoMUDh5uWkUDZcMTw5tYr4Rv/n1
         LZyZdfSACCvqfDPNCpdA/NuHNInwOU9HJyppB6SOXYhiPR3cH45lAZ5Lrua7i6qzctcEEKxcDR8r
         8VjhKVWm3P5Yf0ScRmg0jHrG2oebD3WrPe+S4cYTx99lFb9g0lYb0DyYtGYTa9vbFDOKbuiC07BL
         DI3tFvfuYn3WJOGdexsKemvDBJx3OT8CSD1VBQcKavH0+4F0tdGU1jykxEMslNrfFFx6pEEoiirZ
         ypOIfSBZgaQxkQuVE+/DAoTU+rexlAl3lZ6GhdX8bESitcRiU3q8TCvmNzK7FpxjyfTaazn0O7cH
         rMt6jxwjwpx1tZcomNVPgy+DQp7JoD/KQNO9TSG+cw9XZiI5jJs1TeNrciFOGJ2aO2nRmrL+NHM2
         OsFI/ZSA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe
Date:   Sat, 15 Jul 2023 16:16:56 +0800
X-OQ-MSGID: <20230715081656.1266601-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.

Fix this by stop calling request_irq() with invalid IRQ #s.

Fixes: 1630d85a8312 ("au1200fb: fix hardcoded IRQ")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/video/fbdev/au1200fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 5c232eb13724..c137d6afe484 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1732,6 +1732,9 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 	/* Now hook interrupt too */
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = request_irq(irq, au1200fb_handle_irq,
 			  IRQF_SHARED, "lcd", (void *)dev);
 	if (ret) {
-- 
2.30.2

