Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F11B7DA071
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjJ0Sap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjJ0Saf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:30:35 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7149947B8;
        Fri, 27 Oct 2023 11:29:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 41DE532009B0;
        Fri, 27 Oct 2023 14:27:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 14:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698431221; x=
        1698517621; bh=Sq5it7B0rE/0Q3aU3yeL1Gvj43fO0gW92sFG+BSqBRU=; b=0
        /YF/0zO/M2M8ZcmGuacAkWrgjQ0Ki9W1y4n29R/UynDLNmhj+0LwW+ypVpEg2Rmh
        2XwI4wFZNrK6OLLtlvlhW7J76bVEJpdW3CXefTbNeRx9JcrWizFWqfRHYPmKklts
        3um3NM4b1saDYg+OgEZq9TAcqMhmdzyecRvisod0DbCSHa9REHG4HFnfvW+fkAoJ
        626UjPvQhvH4ckE6OgOoXkYCI8JU5RU179M436fCY92RTsp9iA8mGHC259zdVP5l
        1ld40iSbHWRRWGbO7WTZq1QfqXj6l/T+epgwSchK8E+Z+YWHVmnteCRk6QBeQcZk
        caNxvA/IB3Wb9rcir63mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698431221; x=
        1698517621; bh=Sq5it7B0rE/0Q3aU3yeL1Gvj43fO0gW92sFG+BSqBRU=; b=h
        oNUOCIPPLCXdwnIIXReYR4qQG85B58Tf70989S2hiZpIyKWkC1f10XnCAVIDYCdk
        3v1kCbZvMFjzLLZTfi+KJKHJXti18FZyN9/3k6HcQS3/Ly2WhTBUqheJJ7+nK6Bf
        i3fpHb1wqv2XnFE27pGh454Hyk5y5QJyBznuZJLuMtTB9Jyj+kcBOVhk2v7vienl
        QkKIzO1PZa7UYXNtoxz7msOwXAHvOwPNkHyzu5IOHVMv2LAY9ZJsdKqMVJBDMYzp
        OV8xHnJMU3bPyUTPT7kI2YxGKN24LoQ69hh9SDkJId4psTfueOG/+FED46HHOQyf
        L891pOjPqkRWcluKhjISQ==
X-ME-Sender: <xms:9QA8ZQxkEqARn2PXfN8cnmfwtrmRhFBR5xianbsTArHIQTVjB-m5Fw>
    <xme:9QA8ZUR9vZjZVCUI5YuZR3MH1TxK2LEXrJVaOP2J7J7gWJkE9rmeL-JQAgh_-CFMX
    YSRzfZshMD0wUBNIm4>
X-ME-Received: <xmr:9QA8ZSXGSbF8azLYI8dxOKdoIfefn_EkBy_VKXYrK6VGMMLUUtc-P7tPunsLmkarBRU9gAu6I9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:9QA8ZegHbsmVWludwHFkJXqLlwz-Z4uTQkLXDGzcu3uNiqZy-aItgg>
    <xmx:9QA8ZSCSF1WHx-f6N6AAX9EfRMM9QbbNseX37G_fqZ_ANNbgJVFnsA>
    <xmx:9QA8ZfKTuF45SUYhXauYTRD-AahJ9Pz38BKdER-AUlAt9iXE8FlZhA>
    <xmx:9QA8ZZ5002gBT-0cktMuz5jSRKQxoa9HlZ0SFE3F38APsG5hyovkLA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:27:00 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] MIPS: Add header for UHI semihosting defines
Date:   Fri, 27 Oct 2023 19:26:44 +0100
Message-Id: <20231027182650.281405-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027182650.281405-1-jiaxun.yang@flygoat.com>
References: <20231027182650.281405-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header for MIPS UHI semihosting defines.
Including calling number, data structures and functions
to do UHI calls.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/uhi.h | 309 ++++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)
 create mode 100644 arch/mips/include/asm/uhi.h

diff --git a/arch/mips/include/asm/uhi.h b/arch/mips/include/asm/uhi.h
new file mode 100644
index 000000000000..5e72fd5a67fb
--- /dev/null
+++ b/arch/mips/include/asm/uhi.h
@@ -0,0 +1,309 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * MIPS UHI semihosting define and helpers
+ *
+ * Based on MD01069 - Unified Hosting Interface Reference Manual
+ *
+ * Copyright (C) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+
+#ifndef _MIPS_UHI_H_
+#define _MIPS_UHI_H_
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#define UHI_NR_exit		1
+#define UHI_NR_open		2
+#define UHI_NR_close		3
+#define UHI_NR_read		4
+#define UHI_NR_write		5
+#define UHI_NR_lseek		6
+#define UHI_NR_unlink		7
+#define UHI_NR_fstat		8
+#define UHI_NR_argc		9
+#define UHI_NR_argnlen		10
+#define UHI_NR_argn		11
+#define UHI_NR_plog		13
+#define UHI_NR_assert		14
+#define UHI_NR_pread		19
+#define UHI_NR_pwrite		20
+#define UHI_NR_link		22
+#define UHI_NR_bootfailure	23
+
+/* For SDDBP code and R2 */
+#define UHI_CALL_CODE		"1"
+#define UHI_CALL_CODE_RAW	1
+
+struct uhi_stat {
+	int16_t st_dev;
+	uint16_t st_ino;
+	uint32_t st_mode;
+	uint16_t st_nlink;
+	uint16_t st_uid;
+	uint16_t st_gid;
+	int16_t st_rdev;
+	uint64_t st_size;
+	uint64_t st_atime;
+	uint64_t st_spare1;
+	uint64_t st_mtime;
+	uint64_t st_spare2;
+	uint64_t st_ctime;
+	uint64_t st_spare3;
+	uint64_t st_blksize;
+	uint64_t st_blocks;
+	uint64_t st_spare4[2];
+};
+
+#define UHI_O_RDONLY	0x0
+#define UHI_O_WRONLY	0x1
+#define UHI_O_RDWR	0x2
+#define UHI_O_APPEND	0x8
+#define UHI_O_CREAT	0x200
+#define UHI_O_TRUNC	0x400
+#define UHI_O_EXCL	0x800
+
+#define UHI_EACCESS		13
+#define UHI_EAGAIN		11
+#define UHI_EBADF		9
+#define UHI_EBADMSG		77
+#define UHI_EBUSY		16
+#define UHI_ECONNRESET		104
+#define UHI_EEXIST		17
+#define UHI_EFBIG		27
+#define UHI_EINTR		4
+#define UHI_EINVAL		22
+#define UHI_EIO			5
+#define UHI_EISDIR		21
+#define UHI_ELOOP		92
+#define UHI_EMFILE		24
+#define UHI_EMLINK		31
+#define UHI_ENAMETOOLONG	91
+#define UHI_ENETDOWN		115
+#define UHI_ENETUNREACH		114
+#define UHI_ENFILE		23
+#define UHI_ENOBUFS		105
+#define UHI_ENOENT		2
+#define UHI_ENOMEM		12
+#define UHI_ENOSPC		28
+#define UHI_ENOSR		63
+#define UHI_ENOTCONN		128
+#define UHI_ENOTDIR		20
+#define UHI_ENXIO		6
+#define UHI_EOVERFLOW		139
+#define UHI_EPERM		1
+#define UHI_EPIPE		32
+#define UHI_ERANGE		34
+#define UHI_EROFS		30
+#define UHI_ESPIPE		29
+#define UHI_ETIMEDOUT		116
+#define UHI_ETXTBSY		26
+#define UHI_EWOULDBLOCK		11
+#define UHI_EXDEV		18
+
+
+struct uhi_gpctx {
+	unsigned long r[31];
+	unsigned long epc;
+	unsigned long badvaddr;
+	unsigned long hi;
+	unsigned long lo;
+	void *link;
+	uint32_t status;
+	uint32_t cause;
+	uint32_t badinstr;
+	uint32_t badpinstr;
+};
+
+static inline long __uhi_call0(long n)
+{
+	register long r2 __asm__("$2");
+	register long r25 __asm__("$25") = n;
+	register long r3 __asm__("$3");
+
+	__asm__ __volatile__ (
+		".set	push   \n"
+		".set	" MIPS_ISA_LEVEL " \n"
+		"addu $2,$0,%2 \n"
+		"sdbbp " UHI_CALL_CODE "   \n"
+		".set	pop	\n"
+		: "=&r"(r2), "=r"(r3)
+		: "ir"(UHI_CALL_CODE_RAW), "0"(r2), "r"(r25)
+		: "memory");
+
+	return r2 == -1 ? -r3 : r2;
+}
+
+static inline long __uhi_call1(long n, long a)
+{
+	register long r2 __asm__("$2");
+	register long r25 __asm__("$25") = n;
+	register long r4 __asm__("$4") = a;
+	register long r3 __asm__("$3");
+
+	__asm__ __volatile__ (
+		".set	push   \n"
+		".set	" MIPS_ISA_LEVEL " \n"
+		"addu $2,$0,%2 \n"
+		"sdbbp " UHI_CALL_CODE "   \n"
+		".set	pop	\n"
+		: "=&r"(r2), "=r"(r3)
+		: "ir"(UHI_CALL_CODE_RAW), "0"(r2), "r"(r25), "r"(r4)
+		: "memory");
+
+	return r2 == -1 ? -r3 : r2;
+}
+
+static inline long __uhi_call2(long n, long a, long b)
+{
+	register long r2 __asm__("$2");
+	register long r25 __asm__("$25") = n;
+	register long r4 __asm__("$4") = a;
+	register long r5 __asm__("$5") = b;
+	register long r3 __asm__("$3");
+
+	__asm__ __volatile__ (
+		".set	push   \n"
+		".set	" MIPS_ISA_LEVEL " \n"
+		"addu $2,$0,%2 \n"
+		"sdbbp " UHI_CALL_CODE "   \n"
+		".set	pop	\n"
+		: "=&r"(r2), "=r"(r3)
+		: "ir"(UHI_CALL_CODE_RAW), "0"(r2), "r"(r25), "r"(r4), "r"(r5)
+		: "memory");
+
+	return r2 == -1 ? -r3 : r2;
+}
+
+static inline long __uhi_call3(long n, long a, long b, long c)
+{
+	register long r2 __asm__("$2");
+	register long r25 __asm__("$25") = n;
+	register long r4 __asm__("$4") = a;
+	register long r5 __asm__("$5") = b;
+	register long r6 __asm__("$6") = c;
+	register long r3 __asm__("$3");
+
+	__asm__ __volatile__ (
+		".set	push   \n"
+		".set	" MIPS_ISA_LEVEL " \n"
+		"addu $2,$0,%2 \n"
+		"sdbbp " UHI_CALL_CODE "   \n"
+		".set	pop	\n"
+		: "=&r"(r2), "=r"(r3)
+		: "ir"(UHI_CALL_CODE_RAW), "0"(r2), "r"(r25), "r"(r4), "r"(r5), "r"(r6)
+		: "memory");
+
+	return r2 == -1 ? -r3 : r2;
+}
+
+static inline long __uhi_call4(long n, long a, long b, long c, long d)
+{
+	register long r2 __asm__("$2");
+	register long r25 __asm__("$25") = n;
+	register long r4 __asm__("$4") = a;
+	register long r5 __asm__("$5") = b;
+	register long r6 __asm__("$6") = c;
+	register long r7 __asm__("$7") = d;
+	register long r3 __asm__("$3");
+
+	__asm__ __volatile__ (
+		".set	push   \n"
+		".set	" MIPS_ISA_LEVEL " \n"
+		"addu $2,$0,%2 \n"
+		"sdbbp " UHI_CALL_CODE "   \n"
+		".set	pop	\n"
+		: "=&r"(r2), "=r"(r3)
+		: "ir"(UHI_CALL_CODE_RAW), "0"(r2), "r"(r25), "r"(r4), "r"(r5), "r"(r6), "r"(r7)
+		: "memory");
+
+	return r2 == -1 ? -r3 : r2;
+}
+
+static inline int32_t uhi_exit(int32_t code)
+{
+	return __uhi_call1(UHI_NR_exit, code);
+}
+
+static inline int32_t uhi_open(const char *path, int32_t flags, int32_t mode)
+{
+	return __uhi_call3(UHI_NR_open, (long)path, flags, mode);
+}
+
+static inline int32_t uhi_close(int32_t fd)
+{
+	return __uhi_call1(UHI_NR_close, fd);
+}
+
+static inline int32_t uhi_read(int32_t fd, char *buf, long num)
+{
+	return __uhi_call3(UHI_NR_read, fd, (long)buf, num);
+}
+
+static inline long uhi_write(int32_t fd, const char *buf, long num)
+{
+	return __uhi_call3(UHI_NR_write, fd, (long)buf, num);
+}
+
+static inline int32_t uhi_lseek(int32_t fd, long offset, int32_t whence)
+{
+	return __uhi_call3(UHI_NR_lseek, fd, offset, whence);
+}
+
+static inline int32_t uhi_unlink(const char *path)
+{
+	return __uhi_call1(UHI_NR_unlink, (long)path);
+}
+
+static inline int32_t uhi_fstat(int32_t fd, struct uhi_stat *buf)
+{
+	return __uhi_call2(UHI_NR_fstat, fd, (long)buf);
+}
+
+static inline int32_t uhi_argc(void)
+{
+	return __uhi_call0(UHI_NR_argc);
+}
+
+static inline int32_t uhi_argnlen(int32_t n)
+{
+	return __uhi_call1(UHI_NR_argnlen, n);
+}
+
+static inline int32_t uhi_argn(int32_t n, char *buf, int32_t num)
+{
+	return __uhi_call3(UHI_NR_argn, n, (long)buf, num);
+}
+
+static inline int32_t uhi_plog(const char *buf, int32_t num)
+{
+	return __uhi_call2(UHI_NR_plog, (long)buf, num);
+}
+
+static inline void uhi_assert(const char *msg, const char *file, int32_t line)
+{
+	__uhi_call3(UHI_NR_assert, (long)msg, (long)file, line);
+}
+
+static inline int32_t uhi_link(const char *oldpath, const char *newpath)
+{
+	return __uhi_call2(UHI_NR_link, (long)oldpath, (long)newpath);
+}
+
+static inline int32_t uhi_pread(int32_t fd, char *buf, long num, long offset)
+{
+	return __uhi_call4(UHI_NR_pread, fd, (long)buf, num, offset);
+}
+
+static inline int32_t uhi_pwrite(int32_t fd, const char *buf, long num, long offset)
+{
+	return __uhi_call4(UHI_NR_pwrite, fd, (long)buf, num, offset);
+}
+
+static inline void uhi_bootfailure(int reason)
+{
+	__uhi_call1(UHI_NR_bootfailure, reason);
+}
+
+#endif
-- 
2.34.1

