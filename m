Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A413175A368
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGTAZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGTAZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:25:27 -0400
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE261123
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689812723;
        bh=XDRuLIHkJfQQZemCigyLqfDZFz49CdHiP3pF+50Mh4Y=;
        h=From:To:Cc:Subject:Date;
        b=aM3mQ7HIau0bNNDGHkZNJ5A+inNsISE5aAmm2BmBcRyl5iLUB8tT4QUKJyyZCm1fV
         9uhd8MKDJ4Cts5mYUWjV0M6F6mMJX6RnyEwmcApK/BLVfYvR833b0m4e5ecTbxswZJ
         BdJ9AzK8RvS28IikHuBrYac9L+YcwYmF0hamScBA=
Received: from localhost ([101.224.148.235])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 5FB3E47E; Thu, 20 Jul 2023 08:23:59 +0800
X-QQ-mid: xmsmtpt1689812639tblmroxam
Message-ID: <tencent_B931BF1864B6AE8C674686ED9852ACFA0609@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjyoRLlB1WdJIvKEZ+uXLTVV6mobk6OIzYcsk9NcixTRI+09csj6
         A6Yso/kzi3FrJfhROjQ3VF/tdNNQJf0/gMKVus8ZxYR3irBaDnNyINv8rziCQUriDNs3t38ZC31z
         G9ovwpjDqNp9cp2eR/EeE3zEVziqloAzv3z4bSsh4aprnUjOWJpFFcG4qC/P21cRNX1P+ZiKx+m1
         IlxhI2lJc20BuZKnUm6/wFDQnfNhFrH6Aq1RfJQJGMSmH+/5/C9DJVtU61l9xKRlmHvJ0FTvVqyJ
         ek1ciGmIHfgINhAM2puKYK2ayzTy0QnRVdl3tGMnGp1JXL+hisra5Bh/OAux8w9sK6lEURusk52M
         rzqtUisrZOIXwqzyjeHXh6V3wJ4IhhAzwQbqoZoFcsNt/WBYECzzOcGGRJF8hjT/GDT6GFCkj3SR
         +zV71ZPMwBRZdmOLDJq14Ry4Kvh00/Fv1H8bN3eduUH0sEUGaDCKB4xbumOLti8An1OrqyXTi1vf
         YL/b/4OeSOO1Ri+TCnl6QqgkllPIPYktfM6BVUBVgvw2xyWxeJzyvVdrN0aK682CqWmI0Qj8vvVf
         alemCeYCVuUbETBDLwCOhv2JYvr5eIEgPIRv8ZR5Hfz733fY01jrKxbWQ7gn0eFjV7KRdzgKOtxI
         M/yFOeUaX9CRKoeM7OLhZi6VxKsXkrBUPOwYcqqUxmysg+edwrTLmAGI6ZwcsZAMfGzbSmHQrjAk
         KsVl7BRsxTrfx6oxAT/zOzQxGp1ZtHjuPcxjN49Wiv4xkMIY8ZvqCvQu9zGMyZ/VkBD+cucoJn4N
         Uc81tG0T473Y13dDXyZWGTqKI0iU3JZnEJ4UExl9GcScjhvVArdnsPx7r2kPcERauwfTqm2zgxyK
         taoEiAfO1PMlrSd8cqMtbgRbKzJJrK4FYVwzxaiLejsrKiHW7EjxKGofgZI+tz/XeY2lYCeRgqFw
         rVSG/V7eFueGunGRujUJoaDcPr+bP+qbSm2MEWMexLG77UC1uC9g==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Woody Zhang <woodylab@foxmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Woody Zhang <woodylab@foxmail.com>
Subject: [PATCH] riscv: add SBI SUSP extension support
Date:   Thu, 20 Jul 2023 08:23:19 +0800
X-OQ-MSGID: <20230720002318.2543822-1-woodylab@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V SBI spec 2.0 [1] introduces System Suspend Extension which can be
used to suspend the platform via SBI firmware.

This patch can be tested on Qemu with recent OpenSBI with
`system-suspend-test` enabled like [2] in DTB.

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://github.com/woodyzhang666/qemu/commit/e4a5120133c1dc354e6ac437ec1f870f6c0f6d05

Signed-off-by: Woody Zhang <woodylab@foxmail.com>
---
 arch/riscv/include/asm/sbi.h | 10 ++++++++++
 arch/riscv/kernel/sbi.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5b4a1bf5f439..3b04016da671 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -30,6 +30,7 @@ enum sbi_ext_id {
 	SBI_EXT_HSM = 0x48534D,
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
+	SBI_EXT_SUSP = 0x53555350,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -236,6 +237,15 @@ enum sbi_pmu_ctr_type {
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
 
+enum sbi_ext_susp_fid {
+	SBI_EXT_SUSP_SYSTEM_SUSPEND = 0,
+};
+
+/* SBI suspend sleep types */
+enum sbi_susp_sleep_type {
+	SBI_SUSP_SLEEP_TYPE_SUSPEND = 0x0,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index c672c8ba9a2a..9a68959f9f18 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -9,8 +9,10 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
+#include <linux/suspend.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
+#include <asm/suspend.h>
 
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
@@ -520,6 +522,26 @@ static void sbi_srst_power_off(void)
 		       SBI_SRST_RESET_REASON_NONE);
 }
 
+static int sbi_system_suspend(unsigned long arg,
+		unsigned long resume_entry, unsigned long context)
+{
+	struct sbiret ret = {0};
+
+	ret = sbi_ecall(SBI_EXT_SUSP, SBI_EXT_SUSP_SYSTEM_SUSPEND,
+			SBI_SUSP_SLEEP_TYPE_SUSPEND, resume_entry, context, 0, 0, 0);
+	return ret.error;
+}
+
+static int sbi_system_suspend_enter(suspend_state_t state)
+{
+	return cpu_suspend(0, sbi_system_suspend);
+}
+
+static const struct platform_suspend_ops sbi_suspend_ops = {
+	.valid          = suspend_valid_only_mem,
+	.enter          = sbi_system_suspend_enter,
+};
+
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
@@ -624,6 +646,10 @@ void __init sbi_init(void)
 			sbi_srst_reboot_nb.priority = 192;
 			register_restart_handler(&sbi_srst_reboot_nb);
 		}
+		if (sbi_probe_extension(SBI_EXT_SUSP)) {
+			pr_info("SBI SUSP extension detected\n");
+			suspend_set_ops(&sbi_suspend_ops);
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.39.2

