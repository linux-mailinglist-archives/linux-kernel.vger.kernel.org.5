Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434877F889
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351778AbjHQORm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351783AbjHQORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:17:15 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE512D5F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:17:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RRRsJ0Vv8z4f3q2y
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:17:08 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP1 (Coremail) with SMTP id cCh0CgB38S3OK95kF+6GAw--.40006S2;
        Thu, 17 Aug 2023 22:17:08 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     gongruiqi1@huawei.com
Subject: [PATCH] lkdtm: use the return value of strim()
Date:   Thu, 17 Aug 2023 22:21:17 +0800
Message-Id: <20230817142117.972418-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgB38S3OK95kF+6GAw--.40006S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw48JF17Jr4kCryDKFyfZwb_yoWktrX_Cw
        4Yqr18CFsxu3WfAw1q93WUZr45ua1DWFsY9r4aqrW3ZFy7Wrs5JFyFgrn5Xw43Cr4Dur9r
        Kr95W3yIqw42kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

Make use of the return value of strim() to achieve left-trim as well as
right-trim, which prevents the following unusual fail case:

 # echo " EXCEPTION" > /sys/kernel/debug/provoke-crash/DIRECT
 sh: write error: Invalid argument

Link: https://github.com/KSPP/linux/issues/337
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 drivers/misc/lkdtm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 0772e4a4757e..812c96461ab2 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -242,7 +242,7 @@ static ssize_t lkdtm_debugfs_entry(struct file *f,
 	}
 	/* NULL-terminate and remove enter */
 	buf[count] = '\0';
-	strim(buf);
+	buf = strim(buf);
 
 	crashtype = find_crashtype(buf);
 	free_page((unsigned long)buf);
@@ -318,7 +318,7 @@ static ssize_t direct_entry(struct file *f, const char __user *user_buf,
 	}
 	/* NULL-terminate and remove enter */
 	buf[count] = '\0';
-	strim(buf);
+	buf = strim(buf);
 
 	crashtype = find_crashtype(buf);
 	free_page((unsigned long) buf);
-- 
2.25.1

