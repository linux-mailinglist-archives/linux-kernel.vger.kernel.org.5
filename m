Return-Path: <linux-kernel+bounces-17505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C955C824E8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDF4B2255A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129186134;
	Fri,  5 Jan 2024 06:20:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D06121;
	Fri,  5 Jan 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.43.30])
	by APP-05 (Coremail) with SMTP id zQCowAAXKD2Yn5dlRx3EAw--.57384S2;
	Fri, 05 Jan 2024 14:20:08 +0800 (CST)
From: Jingzi Meng <mengjingzi@iie.ac.cn>
To: gregkh@linuxfoundation.org
Cc: gpiccoli@igalia.com,
	john.ogness@linutronix.de,
	keescook@chromium.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmladek@suse.com,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	tony.luck@intel.com
Subject: [PATCH] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
Date: Fri,  5 Jan 2024 14:20:07 +0800
Message-Id: <20240105062007.26965-1-mengjingzi@iie.ac.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2024010306-tweezers-skinhead-083e@gregkh>
References: <2024010306-tweezers-skinhead-083e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXKD2Yn5dlRx3EAw--.57384S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13Zr47KFW7Aw1DKF45Wrg_yoW8ArW5p3
	4fCr1Utw4DJr17CF4xtayDuFW5WrnFkrWDJa9Y9a1Sv3ZIkw4Iv34qyr18XF1UKrZ3Kr43
	ta4qvF4DtF10kwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F
	4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5dC7UUUUUU==
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/

CAP_SYSLOG was separated from CAP_SYS_ADMIN and introduced in Linux
2.6.37 (2010-11). For a long time, certain syslog actions required
CAP_SYS_ADMIN or CAP_SYSLOG. Maybe it’s time to officially remove
CAP_SYS_ADMIN for more fine-grained control.

CAP_SYS_ADMIN was once removed but added back for backwards
compatibility reasons. In commit 38ef4c2e437d ("syslog: check cap_syslog
when dmesg_restrict") (2010-12), CAP_SYS_ADMIN was no longer needed. And
in commit ee24aebffb75 ("cap_syslog: accept CAP_SYS_ADMIN for now")
(2011-02), it was accepted again. Since then, CAP_SYS_ADMIN has been
preserved.

Now that almost 13 years have passed, the legacy application may have
had enough time to be updated.

Signed-off-by: Jingzi Meng <mengjingzi@iie.ac.cn>
---

In addition, we examined the kernel code and identified that the user api
affected by this change is the syslog system call, which we tested on
the patched kernel to make sure the effect is as expected.

 kernel/printk/printk.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index be95a6851164..6e1153d7de21 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -598,17 +598,6 @@ static int check_syslog_permissions(int type, int source)
 	if (syslog_action_restricted(type)) {
 		if (capable(CAP_SYSLOG))
 			goto ok;
-		/*
-		 * For historical reasons, accept CAP_SYS_ADMIN too, with
-		 * a warning.
-		 */
-		if (capable(CAP_SYS_ADMIN)) {
-			pr_warn_once("%s (%d): Attempt to access syslog with "
-				     "CAP_SYS_ADMIN but no CAP_SYSLOG "
-				     "(deprecated).\n",
-				 current->comm, task_pid_nr(current));
-			goto ok;
-		}
 		return -EPERM;
 	}
 ok:
-- 
2.20.1


