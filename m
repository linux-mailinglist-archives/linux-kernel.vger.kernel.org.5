Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE17F911A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 04:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjKZC5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 21:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZC5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 21:57:09 -0500
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF160127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 18:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1700967423;
        bh=hciWXMie+hlfZgYrTGD3Ah6URKpNDGVm3+uON23ySYY=;
        h=From:To:Cc:Subject:Date;
        b=ZqTuYxCE+encs7HL0xIEZUNQsmaskGiy6owzCnqDpM9hi91YVxL4/NUO2PcVoMHul
         cIK7Kt8N6UbaP2Bv/jDz0Of1T09shQ9oXEZygijpCKp9nznkJ0BDpwb4cH4bxVUttM
         to5bFcCoP1AT1sDgvbX6p2I6v/YQPs2bI3HcA/sg=
Received: from rtoax.lan ([120.245.114.155])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id E3B1D45D; Sun, 26 Nov 2023 10:56:59 +0800
X-QQ-mid: xmsmtpt1700967419td0f4czeq
Message-ID: <tencent_77E0BC1E8E9A21CA1B9009DD66555C72A90A@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNodgBRTfRMcMMgwHvb2slM+/IRLpRJ6+WO9p5PwdrznpirQgIr/u
         ClaaUazvNLGG3aVQD4U7uPfOoq1sh60kOf693Xr2Zia9DAQE99Q2aBqOoeekXWyQZenBFa4oM5oC
         7cPmoEOp+LYacf8zwx9nN53m2UwJOHqQ9+hqS4a8awKatSOQtrZ8hkUjYhHfM6mbPO9dIBkA5dLK
         /TlPp7XdUZUlQQkupXeDGPi/jwNRIAu3XPSCp6K7TzXzOnoPZHYAlwg3QjdbBb4OlKsBiE5ku176
         qhajxJBQ5e/A9FSZcUdIG/+2dgEHHGERV9CYfqd/Hwi0NlOYd72ysndU8zi1YZRlz9DOmzXRpdYS
         8Si+0OIFC0drdGCYXpEcE+vi26MpIv0L3mOemFNLdA6mewqhacRrjrnPNM+8NZWBNMjOFJ0d2p9k
         1kU21qRo177pHjjy8DdcpkdHOsNQjGP8TIlerJx4EpouRXXuuSAYnkNngB9b+4k7TppUivjtA/yC
         QacMmILDUHOlxIdqKixwlQ30tzFOQJ12gUENdcv/6uYDK3eMtmEoAJ0WGUfzHDGzGf1IWqnOl/kz
         2WwtC/0Yjl1InOoeFdG0mSo8lS1Tonv3ijlw3aHbQb7gRwCEhL23VH2+N9IliRWhLBA5+3lAOQut
         S/67lI5vxrxWqAxOwVgaLbYjzPPMZXO9HYKKhODeigyA6hf9K6k+APHZdOFtJJaxI3+pzWWujXW2
         C+9rKssl+aVQfeCEC1JSQ9tjlfCldhOhDyazgORBEY/GjbcsVXs1YK07N674Zhpf6WqH8vf7sTzc
         hAYLRuHHrJkFISUmVbbAv1dyN2YVrs97sSSqKaqExi59pJCPqaI0Lk1vOKDPWIo2CjcNbuiC0VIo
         7KS3VFKyubzBsf/qbz9wlvD9AxBkAIqny5ZJExQArPtjXp8G14n5h2SQFG0A0+djp20zY0Aal3gE
         l3dD3dGjmIsM6UD8+9qC6I1YsaZWAEdLEgUyV5zLzZGDL7vJDgeXLlX/SL8EBmN+APIl65yZTCiz
         y1Y9agZA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Rong Tao <rtoax@foxmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Florent Revest <revest@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Stefan Roesch <shr@devkernel.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Cc:     rtoax@foxmail.com, rongtao@cestc.cn
Subject: [PATCH v2] prctl: Get private anonymous memory region name
Date:   Sun, 26 Nov 2023 10:56:53 +0800
X-OQ-MSGID: <20231126025657.10784-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

In commit 9a10064f5625 ("mm: add a field to store names for private anony-
mous memory") add PR_SET_VMA options and PR_SET_VMA_ANON_NAME for the prctl
system call, then the PR_GET_VMA interface should be provided accordingly,
which is necessary, as the userspace program usually wants to know what
VMA name it has configured for the anonymous page.

Userspace can set the name for a region of memory by calling:

    prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned long)name);

Then, Userspace can get the name of a memory region by calling:

    char buf[80];
    prctl(PR_GET_VMA, PR_GET_VMA_ANON_NAME, start, buf, 0);

Changes for prctl(2) manual page (in the options section):

PR_GET_VMA
        Gets an attribute specified in arg2 for virtual memory areas
        starting from the address specified in arg3 and spanning the
        size specified in arg4. arg5 specifies the value of the attribute
        to be set.

        Currently, arg2 must be one of:

        PR_GET_VMA_ANON_NAME
                Get name of anonymous virtual memory areas. arg4 should be
                a buffer in the user's program, and the size of the buffer
                should not be less than 80 bytes, otherwise it is possible
                that the prctl return will fail due to a copy failure
                (unless you know the length of the name you set through
                the PR_SET_VMA_ANON_NAME).

                This feature is available only if the kernel is built with
                the CONFIG_ANON_VMA_NAME option enabled.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Simplify code implementation.
v1: https://lore.kernel.org/all/tencent_977CBF8E8CA6234A1B740A35655D5D7EAA0A@qq.com/
---
 include/linux/mm.h         |  7 +++++++
 include/uapi/linux/prctl.h |  3 +++
 kernel/sys.c               | 39 ++++++++++++++++++++++++++++++++++++++
 mm/madvise.c               | 15 +++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..f7c242f1bceb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4106,6 +4106,8 @@ static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
+struct anon_vma_name *madvise_get_anon_name(struct mm_struct *mm,
+					    unsigned long start);
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in,
 			  struct anon_vma_name *anon_name);
@@ -4115,6 +4117,11 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 		      unsigned long len_in, struct anon_vma_name *anon_name) {
 	return 0;
 }
+static inline
+struct anon_vma_name *madvise_get_anon_name(struct mm_struct *mm,
+					    unsigned long start) {
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..8ba0016d77de 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -291,6 +291,9 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+#define PR_GET_VMA		0x53564d42
+# define PR_GET_VMA_ANON_NAME		0
+
 #define PR_GET_AUXV			0x41555856
 
 #define PR_SET_MEMORY_MERGE		67
diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..b1cbcb276e1a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2359,12 +2359,48 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
 	return error;
 }
 
+static int prctl_get_vma(unsigned long opt, unsigned long addr,
+			 unsigned long buf, unsigned long arg)
+{
+	struct mm_struct *mm = current->mm;
+	char __user *u_buf;
+	int error;
+
+	switch (opt) {
+	case PR_GET_VMA_ANON_NAME:
+		struct anon_vma_name *anon_name = NULL;
+
+		u_buf = (char __user *)buf;
+		error = 0;
+
+		mmap_read_lock(mm);
+		anon_name = madvise_get_anon_name(mm, addr);
+
+		if (!anon_name || copy_to_user(u_buf, anon_name->name,
+					       strlen(anon_name->name) + 1))
+			error = -EFAULT;
+
+		mmap_read_unlock(mm);
+		anon_vma_name_put(anon_name);
+		break;
+	default:
+		error = -EINVAL;
+	}
+	return error;
+}
+
 #else /* CONFIG_ANON_VMA_NAME */
 static int prctl_set_vma(unsigned long opt, unsigned long start,
 			 unsigned long size, unsigned long arg)
 {
 	return -EINVAL;
 }
+
+static int prctl_get_vma(unsigned long opt, unsigned long start,
+			 unsigned long u_buf, unsigned long arg)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_ANON_VMA_NAME */
 
 static inline unsigned long get_current_mdwe(void)
@@ -2712,6 +2748,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_GET_VMA:
+		error = prctl_get_vma(arg2, arg3, arg4, arg5);
+		break;
 	case PR_GET_AUXV:
 		if (arg4 || arg5)
 			return -EINVAL;
diff --git a/mm/madvise.c b/mm/madvise.c
index cf4d694280e9..bad7b4167d2c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1287,6 +1287,21 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 	return error;
 }
 
+struct anon_vma_name *madvise_get_anon_name(struct mm_struct *mm,
+						  unsigned long start)
+{
+	struct vm_area_struct *vma;
+	struct anon_vma_name *anon_name = NULL;
+
+	vma = find_vma(mm, start);
+	if (vma) {
+		anon_name = anon_vma_name(vma);
+		anon_vma_name_get(anon_name);
+	}
+
+	return anon_name;
+}
+
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in, struct anon_vma_name *anon_name)
 {
-- 
2.43.0

