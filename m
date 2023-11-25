Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08467F8B30
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKYOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:04:21 -0500
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1E127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1700921061;
        bh=haA8ZA3bUtHrRInZOH4CK7VmgeCY+GzXaoTzwj6c4+M=;
        h=From:To:Cc:Subject:Date;
        b=ZuP544Li8pqsQcWhUQKXT4gVbAJdxnnwuGue06yPFmJFjOW8RsbDtSKw56ZnW5tTH
         4HR8JZEMa4zm2nEiNalkWmMq2g6JnNb44bb78WHJlbHKbl/tLUxBMWyKd7GNOSIZXB
         t8hMbfo0i5Tmg5GqZKYSQHehq8rAkE0GfHqeCjMI=
Received: from rtoax.lan ([120.245.114.155])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 1112666E; Sat, 25 Nov 2023 22:04:17 +0800
X-QQ-mid: xmsmtpt1700921057tfgnnm28u
Message-ID: <tencent_977CBF8E8CA6234A1B740A35655D5D7EAA0A@qq.com>
X-QQ-XMAILINFO: NgiXOM0lDIKdU0QGHyx1uC/Z9jFxiz/QNTe39lCbcSUXcYh5DlrVl1P8vGOyld
         ES3XX0SuYKhkm4TVFKqvRKiqwauLF7yke4h8ExwvSeYpm5i4IzxRa/riLKaSDtiU0s67qzZoW605
         VSg9oJX2/RgvJKZ245na46oNgjbhtouqKajj3AYytey0k09fAK7dwuojZR/SYZoL5Q0lLCB1AKmG
         DN6h1V5DZ2kpLTazenkXFWZv3qe4Hki+WXvIuNYJWDu9+yWf1GeBeROH+gHhMHMUlFuq1KqP1n6s
         IgQg2mZtlHa8+bdR6cBDvESj1rR+O66w6oHA+9MNwnmEw14ekCinlZ9qr/tmwrCq2ThXFZsP2lAJ
         yTvFQOPbvi0As+vs9qWY3vr36eyL9inYzIjungPKpAscgN236RIVKMFgBmO0UAN86YJOFQcJzdV8
         FbnQ0p4tIZNhXws4eDbidd80ukbotQhSqlTiTGe3RNWnCk4uGUW+YbBJfBwma/UQFWZpZUeW07d4
         PWRdaJOjpMSrASiKANhh22s9and5jduz1QUT9Uguj+DoqrRDMjubDagiXW9XAcy1qgz6SvOZ6g9u
         D0P0AtlRfXyibvZNBCjnFL0XVz1qwtD3qfZzzRe4cvE+mk8oGvVz8gl2OecmDOGyoOKUy1gvniBv
         ash+yw3kTwXr2gppxaHIkpuacIkWA3+k8wPlW20tARsbYxjR/ZpqQhCBrBu9ahr1OfrdM7HubIEp
         DiqtOO9i0yxUflPXWv2WdVQAOEI6U32Db1LsXSY2TpA1iFmRlClKBIA2oRY+TmEn77hP7wxOx7tq
         S3+5KqOJ6bhnGic+Y5fnOlFRmiyxx20GyWKEzlml+SvgbPUg67xEnzq23l1rRfYQed/W/V8B5BL1
         pXQk/3kGB1eF4HjA2vmd25xlfWL5bicV7jB//zU5bFmOx3lxdGjBV9zDXnfJXhGj67MXntbn8orU
         BdAhdaLazQj0j2b/muAP3Jx3DIm9j34SdvBFH2KOE4ca3M6QrYV/04/JfQzzQuWwihfVZ6ZTeoEz
         V/KQgN+w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Rong Tao <rtoax@foxmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florent Revest <revest@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Stefan Roesch <shr@devkernel.io>,
        Andy Chiu <andy.chiu@sifive.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Cc:     rtoax@foxmail.com, rongtao@cestc.cn
Subject: [PATCH] prctl: Get private anonymous memory region name
Date:   Sat, 25 Nov 2023 22:04:12 +0800
X-OQ-MSGID: <20231125140415.32964-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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
 include/linux/mm.h         |  7 ++++++
 include/uapi/linux/prctl.h |  3 +++
 kernel/sys.c               | 44 ++++++++++++++++++++++++++++++++++++++
 mm/madvise.c               | 18 ++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..2981c94c52f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4106,6 +4106,8 @@ static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
+const struct anon_vma_name *madvise_get_anon_name(struct mm_struct *mm,
+						  unsigned long start);
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in,
 			  struct anon_vma_name *anon_name);
@@ -4115,6 +4117,11 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 		      unsigned long len_in, struct anon_vma_name *anon_name) {
 	return 0;
 }
+static inline
+const struct anon_vma_name *madvise_get_anon_name(struct mm_struct *mm,
+						  unsigned long start) {
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
index e219fcfa112d..f11eadd666d0 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2359,12 +2359,53 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
 	return error;
 }
 
+static int prctl_get_vma(unsigned long opt, unsigned long addr,
+			 unsigned long buf, unsigned long arg)
+{
+	struct mm_struct *mm = current->mm;
+	const char __user *u_buf;
+	int error;
+
+	switch (opt) {
+	case PR_GET_VMA_ANON_NAME:
+		const struct anon_vma_name *anon_name = NULL;
+
+		u_buf = (const char __user *)buf;
+		error = 0;
+
+		mmap_read_lock(mm);
+		anon_name = madvise_get_anon_name(mm, addr);
+		if (!anon_name) {
+			mmap_read_unlock(mm);
+			error = -EFAULT;
+			break;
+		}
+
+		if (copy_to_user((char __user *)u_buf, anon_name->name,
+				 strlen(anon_name->name) + 1))
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
@@ -2712,6 +2753,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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
index cf4d694280e9..a68f7a7d6389 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1287,6 +1287,24 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 	return error;
 }
 
+const struct anon_vma_name *madvise_get_anon_name(struct mm_struct *mm,
+						  unsigned long start)
+{
+	struct vm_area_struct *vma;
+	struct anon_vma_name *anon_name;
+
+	vma = find_vma(mm, start);
+	if (vma) {
+		anon_name = anon_vma_name(vma);
+		if (anon_name) {
+			anon_vma_name_get(anon_name);
+			return anon_name;
+		}
+	}
+
+	return NULL;
+}
+
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in, struct anon_vma_name *anon_name)
 {
-- 
2.43.0

