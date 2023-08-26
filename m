Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64207789634
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjHZLKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjHZLJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:09:29 -0400
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252431BC6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693048164;
        bh=6x9SthIipi5zMNzP+eLdpWxKQ9gTnEgpzpGWBsjqL1g=;
        h=From:To:Cc:Subject:Date;
        b=bs3hbKycXMa38l3VHP4M1EI917/z8bVE1meKEGOxsH+fvaaTw4hxKqjGHJ+7wvmaE
         nyqcnqnc/92j0D6fskgAym7LuUZCOhXuWO7VVnS5t9P2G6jyfPIDYSKXa/I9YjJMyQ
         PGJIRfXSyri6zePH6ZU7cWG2wiFh1wItfBAoDNP0=
Received: from KernelDevBox.byted.org ([180.184.51.142])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 2548824E; Sat, 26 Aug 2023 19:09:20 +0800
X-QQ-mid: xmsmtpt1693048160td7zgcac0
Message-ID: <tencent_A0D4966C4180DD7B582A20A06A49ECDD600A@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTCXLSPHqXFkNH78mfyeG4g0i+qvp7q1FQqDqlqD7Tk6YBI+NCWy
         NeyUuGjcQ/z84ydfd4fq+SCNKL4W2MTgkHKqtRM0tb0gOvhqXfRpKQg80XLrKz2a+mj+5F8Ox5ut
         eJlfvZzk7vbVqDON4qNqDO8Lc1SdH22EYKWoL2nr2LSo4AF9kX8uNQSu+P1jjup3vlSQ1R0oQHtE
         G6KiWUH5hVjLS1+lq0iSF6clxTvtMJ8nvqtzGd48qZXE8GTdAs2/KsXF1HaYqF4MMSONSV+hFTOc
         BHGAfUozUi86AKHqRlHzs6WUt5fO6sB424L8nzrKEyGJPvyQ+B7OzCSo9RBDuvgN2Cf/73imHxcN
         OYfWfHC9yvnX/ztp6R5OUSG2MYRUVaoYDtWmV1JQrM9ot+pn6swRQVCzSCkYfF96MMlzD9ksQG9r
         Bnjj4bzW0dXYXM5/RkVbU/erFPU3BCv5alKAU2Zaz0ZEcfKPjE8RSUE1ETmT0Ya9PnmZ9QfscZAa
         5wKacHnEephAO77BZq+w9Bglmxf8N82Pl+kTwYgaBkLK9APMO+V6bWZCvG+Sc3je5tyfBlYyItXc
         ZIITqbCs4qddUKIHUXFlDR/r8cQWumHyeaEUhFJ7NIA0/+GiJWJVlcqL0JStytWlqhoqwipwczWK
         Sr5CjhpjeBh5OMrOL2lLThFU+1rkQdGmUhgilUTRQnx5BGARMvUSgFenIxUhBueCA0+LbpM0D+3A
         fu/gg3ZIGNg9xkhWzkzCbc4rSPPCFpHwTZ6iFQ6eUp+Ds5Xs79Z0f32SpwrhVw0LhpDzfCBY2knz
         ODae7F0fSD6WbIpmFQZUt9d3nuziTVscorzrXVuxYwVZAj42hXHgywZLxR5ErbdkY0kMMRjWXlYo
         gusuAhgAYSNtjDqSksRcgIW9cY9iJfm+5kk0YtXkOpSxolQtukTLSFzacyFyZ7uQXogiR+M+KEuG
         mHQ6mffhzwlhXUeOiasn2A5abxXYhshyxVXyumTUEzGTfoDc19fywQUXyjsOrWG/1PnB71OT/8oZ
         j7ohdvYQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     amitk@kernel.org
Cc:     thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] thermal/drivers/qcom/lmh: Fix missing IRQ check in lmh_probe()
Date:   Sat, 26 Aug 2023 19:09:19 +0800
X-OQ-MSGID: <20230826110919.2334752-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.

Fix this by stop calling request_irq() with invalid IRQ #s.

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/thermal/qcom/lmh.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index f6edb12ec004..38aedb9a7c67 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -198,7 +198,11 @@ static int lmh_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	lmh_data->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	lmh_data->irq = ret;
 	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
 	if (!lmh_data->domain) {
 		dev_err(dev, "Error adding irq_domain\n");
-- 
2.30.2

