Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA977999E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjIIQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjIIQTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:19:33 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCB7197;
        Sat,  9 Sep 2023 09:19:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6A01C320091F;
        Sat,  9 Sep 2023 12:19:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 09 Sep 2023 12:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1694276365; x=
        1694362765; bh=uSTKvre5OkFD26Z/CNG6inepkxbO+yEbrMMhcke7UwM=; b=g
        pGG/MkX3PpVofz1FQ6lN1LB9wayD9XxcJsemnEm+HdmjoQJbDDYBLfHyUQAu/2Mk
        VAiBAB3YL5ON29AJsYxHINtwyuPzwZc8DHw28vWtOV80GCx+fK8GGBBEu5bHeSLo
        rfA8Xq2bGkhuVnyXipSivfAvZHXSpqUChGm6lQBWeI7OVrnRm7f/k5bSo17ZvSbY
        mzherSIM9xYPp71fe6cCHDREjslVKJqd9toC4fg8PxDB7XSXLNYDdLXGB7xoRZGx
        J7zpqHpMDAmCB4PVL/wzvhxiuvbAjEL8JTLmlv0NoC8Xw8TU1lYqFkV1xWicXZK9
        ljiQeItAgZTjTCmKarc0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694276365; x=
        1694362765; bh=uSTKvre5OkFD26Z/CNG6inepkxbO+yEbrMMhcke7UwM=; b=H
        vM2YxFihsRQKfJs8a0dZ2xVUqpTy0BxwM4TUQWxP9TmxNwWVny/PpvKnOBOPoNbZ
        jf9E77V5bgUJkNvxHq88WTU9rHeNzlJ2D9FD7GySVR+xVyeTLeKdj7vb7d4JVIh8
        RXv9h+ARJfy8/fMfrlZJb5T7aSr87uTW52YXM+4T+J8PoF8zWlWnLkr6LUGGcL6R
        GV0LMHiQee/zbpWPayvdL7QLJae8ZKcw7al/VkToeECO0ZEca7wdX29uJ0kvv1vJ
        9vD7YwxqhuJIKd4HvN68HZD/TxC1srGLKoYl6zNuulQZPM4PVnmBevqnAeyECrOy
        Yv6+RElxH8+pU/6clLm4Q==
X-ME-Sender: <xms:DZv8ZLa7v6hR5OQbZo0_1Gko7TBYdro1Titj08Rmrwj6ZGls8Qq3Ew>
    <xme:DZv8ZKaMBkTYcehvoeFGwEaecMGOABcwE18fnaRVUvjnzLEvRO1hpSENDxE0CuFRA
    4VD6WSPj6_QKum2hAM>
X-ME-Received: <xmr:DZv8ZN9ej21jNHV8bZPZEy3H3dy6WcCIQ3R5NfJirvIU1iZAhqL-eux3Yc1yWfY1P_sGIePWwLJRhyo8FOlPGtFQaOHe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfjvghnughrihhk
    ucfhrghrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpe
    egfeeliefggeeiiedtudevveevvddvvefguddtvdeitdejleejuefgueelieehteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlh
    esjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:DZv8ZBorv5Gu5RogBbPx5o2zHuLW-Q6978R5g28-FMO8BQyYnxit-w>
    <xmx:DZv8ZGp6WlMMVEdLGrPsjgLQZKFvDHm60ZPJIeNRXNoqHbRNbnrXmQ>
    <xmx:DZv8ZHT3Hw6mzMqzvqjt1sobjUNlkkT_c6d72ZDv8AMxnbu7Jb9Fkg>
    <xmx:DZv8ZMh0hdH0swdb-tDUj2vAJk2R2WdFwGzMxlNrAuq-jLNv70PaXw>
Feedback-ID: i0fc947c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 12:19:23 -0400 (EDT)
From:   Jan Hendrik Farr <kernel@jfarr.cc>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        lennart@poettering.net, bluca@debian.org,
        systemd-devel@lists.freedesktop.org, kernel@jfarr.cc
Subject: [PATCH 1/1] x86/kexec: UKI support
Date:   Sat,  9 Sep 2023 18:18:51 +0200
Message-Id: <20230909161851.223627-2-kernel@jfarr.cc>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909161851.223627-1-kernel@jfarr.cc>
References: <20230909161851.223627-1-kernel@jfarr.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the kernel accept UKIs (Unified Kernel Images) for kexec_file_load.

UKIs contain the kernel bzImage, initrd, and cmdline all packaged up as
one EFI application. The main advantage of this is that the whole
combination is signed together as a package for secure boot.

This implementation parses the UKI and passes the bzImage, initrd, and
cmdline to the normal bzImage loader.

Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
---
 arch/x86/include/asm/kexec-uki.h       |   7 ++
 arch/x86/include/asm/parse_pefile.h    |  32 +++++++
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c     |   2 +
 arch/x86/kernel/parse_pefile.c         | 110 ++++++++++++++++++++++++
 crypto/asymmetric_keys/mscode_parser.c |   2 +-
 crypto/asymmetric_keys/verify_pefile.c | 110 +++---------------------
 crypto/asymmetric_keys/verify_pefile.h |  16 ----
 9 files changed, 278 insertions(+), 116 deletions(-)
 create mode 100644 arch/x86/include/asm/kexec-uki.h
 create mode 100644 arch/x86/include/asm/parse_pefile.h
 create mode 100644 arch/x86/kernel/kexec-uki.c
 create mode 100644 arch/x86/kernel/parse_pefile.c

diff --git a/arch/x86/include/asm/kexec-uki.h b/arch/x86/include/asm/kexec-uki.h
new file mode 100644
index 000000000000..87fd2c6fb091
--- /dev/null
+++ b/arch/x86/include/asm/kexec-uki.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_KEXEC_UKI_H
+#define _ASM_KEXEC_UKI_H
+
+extern const struct kexec_file_ops kexec_uki_ops;
+
+#endif  /* _ASM_KEXEC_UKI_H */
diff --git a/arch/x86/include/asm/parse_pefile.h b/arch/x86/include/asm/parse_pefile.h
new file mode 100644
index 000000000000..c29f8c98ee66
--- /dev/null
+++ b/arch/x86/include/asm/parse_pefile.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2014 Red Hat, Inc. All Rights Reserved.
+ *
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _ASM_PARSE_PEFILE_H
+#define _ASM_PARSE_PEFILE_H
+
+#include <linux/pe.h>
+
+struct pefile_context {
+	unsigned	header_size;
+	unsigned	image_checksum_offset;
+	unsigned	cert_dirent_offset;
+	unsigned	n_data_dirents;
+	unsigned	n_sections;
+	unsigned	certs_size;
+	unsigned	sig_offset;
+	unsigned	sig_len;
+	const struct section_header *secs;
+
+	/* PKCS#7 MS Individual Code Signing content */
+	const void	*digest;		/* Digest */
+	unsigned	digest_len;		/* Digest length */
+	const char	*digest_algo;		/* Digest algorithm */
+};
+int pefile_parse_binary(const void *pebuf, unsigned int pelen,
+			       struct pefile_context *ctx);
+
+#endif // _ASM_PARSE_PEFILE_H
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3269a0e23d3a..8a37a977bf72 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -101,6 +101,8 @@ obj-$(CONFIG_CRASH_CORE)	+= crash_core_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
+obj-$(CONFIG_KEXEC_FILE)	+= kexec-uki.o
+obj-$(CONFIG_KEXEC_FILE)	+= parse_pefile.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/x86/kernel/kexec-uki.c b/arch/x86/kernel/kexec-uki.c
new file mode 100644
index 000000000000..9275196a6b71
--- /dev/null
+++ b/arch/x86/kernel/kexec-uki.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kexec UKI loader
+ *
+ * Copyright (C) 2023 Jan Hendrik Farr
+ *
+ * Authors:
+ *      Jan Hendrik Farr <kernel@jfarr.cc>
+ */
+
+#define pr_fmt(fmt)	"kexec-uki: " fmt
+
+#include <linux/kernel.h>
+#include "linux/pe.h"
+#include <linux/kexec.h>
+#include <linux/err.h>
+
+#include <asm/kexec-uki.h>
+#include <asm/kexec-bzimage64.h>
+#include <asm/parse_pefile.h>
+
+static int find_section(struct pefile_context *ctx, const char *name,
+			const struct section_header **sec)
+{
+	for (int i = 0; i < ctx->n_sections; i++) {
+		const struct section_header *cur_sec = &ctx->secs[i];
+
+		if (!strncmp(cur_sec->name, name, ARRAY_SIZE(cur_sec->name))) {
+			*sec = cur_sec;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int uki_probe(const char *buf, unsigned long len)
+{
+	int ret = -ENOEXEC;
+	struct pefile_context pe_ctx;
+
+	int r = pefile_parse_binary(buf, len, &pe_ctx);
+
+	if (r) {
+		pr_info("Not a UKI. Not a valid PE file\n");
+		return ret;
+	}
+
+	const struct section_header *_;
+
+	if (find_section(&pe_ctx, ".linux", &_) ||
+	    find_section(&pe_ctx, ".initrd", &_) ||
+	    find_section(&pe_ctx, ".cmdline", &_)) {
+		pr_info("Not a UKI. Missing .linux, .initrd, or .cmdline\n");
+		return ret;
+	}
+
+
+	pr_info("It's a UKI\n");
+	return 0;
+}
+
+static void *uki_load(struct kimage *image, char *kernel,
+		      unsigned long kernel_len, char *initrd,
+		      unsigned long initrd_len, char *cmdline,
+		      unsigned long cmdline_len)
+{
+	struct pefile_context pe_ctx;
+	int r = pefile_parse_binary(kernel, kernel_len, &pe_ctx);
+
+	if (r)
+		return ERR_PTR(r);
+
+	pr_debug("pefile_parse_binary return %d, number of sections: %d\n",
+		 r, pe_ctx.n_sections);
+
+	const struct section_header *sec_linux, *sec_initrd, *sec_cmdline;
+	int r_linux = find_section(&pe_ctx, ".linux", &sec_linux);
+	int r_initrd = find_section(&pe_ctx, ".initrd", &sec_initrd);
+	int r_cmdline = find_section(&pe_ctx, ".cmdline", &sec_cmdline);
+
+	if (r_linux || r_initrd || r_cmdline)
+		return ERR_PTR(-EINVAL);
+
+	void *ret = kexec_bzImage64_ops.load(
+		image,
+		kernel + sec_linux->data_addr,
+		sec_linux->raw_data_size,
+		kernel + sec_initrd->data_addr,
+		sec_initrd->raw_data_size,
+		kernel + sec_cmdline->data_addr,
+		sec_cmdline->raw_data_size
+	);
+
+	if (IS_ERR(ret))
+		pr_warn("bzImage64_load error\n");
+
+	return ret;
+}
+
+static int uki_cleanup(void *loader_data)
+{
+	return kexec_bzImage64_ops.cleanup(loader_data);
+}
+
+const struct kexec_file_ops kexec_uki_ops = {
+	.probe = uki_probe,
+	.load = uki_load,
+	.cleanup = uki_cleanup,
+#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
+	.verify_sig = kexec_kernel_verify_pe_sig,
+#endif
+};
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..072f5aac52b9 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -25,6 +25,7 @@
 #include <asm/io_apic.h>
 #include <asm/debugreg.h>
 #include <asm/kexec-bzimage64.h>
+#include <asm/kexec-uki.h>
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
@@ -81,6 +82,7 @@ static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { retu
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
+		&kexec_uki_ops,
 		NULL
 };
 #endif
diff --git a/arch/x86/kernel/parse_pefile.c b/arch/x86/kernel/parse_pefile.c
new file mode 100644
index 000000000000..7737c94a1848
--- /dev/null
+++ b/arch/x86/kernel/parse_pefile.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Parse a PE binary
+ *
+ * Copyright (C) 2014 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2023 Jan Hendrik Farr
+ *
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <asm/parse_pefile.h>
+#include <linux/err.h>
+
+#define pr_fmt(fmt)	"parse_pefile: " fmt
+#include <linux/module.h>
+/*
+ * Parse a PE binary.
+ */
+int pefile_parse_binary(const void *pebuf, unsigned int pelen,
+			       struct pefile_context *ctx)
+{
+	const struct mz_hdr *mz = pebuf;
+	const struct pe_hdr *pe;
+	const struct pe32_opt_hdr *pe32;
+	const struct pe32plus_opt_hdr *pe64;
+	const struct data_directory *ddir;
+	const struct data_dirent *dde;
+	const struct section_header *secs, *sec;
+	size_t cursor, datalen = pelen;
+
+
+#define chkaddr(base, x, s)						\
+	do {								\
+		if ((x) < base || (s) >= datalen || (x) > datalen - (s)) \
+			return -ELIBBAD;				\
+	} while (0)
+
+	chkaddr(0, 0, sizeof(*mz));
+	if (mz->magic != MZ_MAGIC)
+		return -ELIBBAD;
+	cursor = sizeof(*mz);
+
+	chkaddr(cursor, mz->peaddr, sizeof(*pe));
+	pe = pebuf + mz->peaddr;
+	if (pe->magic != PE_MAGIC)
+		return -ELIBBAD;
+	cursor = mz->peaddr + sizeof(*pe);
+
+	chkaddr(0, cursor, sizeof(pe32->magic));
+	pe32 = pebuf + cursor;
+	pe64 = pebuf + cursor;
+
+	switch (pe32->magic) {
+	case PE_OPT_MAGIC_PE32:
+		chkaddr(0, cursor, sizeof(*pe32));
+		ctx->image_checksum_offset =
+			(unsigned long)&pe32->csum - (unsigned long)pebuf;
+		ctx->header_size = pe32->header_size;
+		cursor += sizeof(*pe32);
+		ctx->n_data_dirents = pe32->data_dirs;
+		break;
+
+	case PE_OPT_MAGIC_PE32PLUS:
+		chkaddr(0, cursor, sizeof(*pe64));
+		ctx->image_checksum_offset =
+			(unsigned long)&pe64->csum - (unsigned long)pebuf;
+		ctx->header_size = pe64->header_size;
+		cursor += sizeof(*pe64);
+		ctx->n_data_dirents = pe64->data_dirs;
+		break;
+
+	default:
+		pr_warn("Unknown PEOPT magic = %04hx\n", pe32->magic);
+		return -ELIBBAD;
+	}
+
+	pr_debug("checksum @ %x\n", ctx->image_checksum_offset);
+	pr_debug("header size = %x\n", ctx->header_size);
+
+	if (cursor >= ctx->header_size || ctx->header_size >= datalen)
+		return -ELIBBAD;
+
+	if (ctx->n_data_dirents > (ctx->header_size - cursor) / sizeof(*dde))
+		return -ELIBBAD;
+
+	ddir = pebuf + cursor;
+	cursor += sizeof(*dde) * ctx->n_data_dirents;
+
+	ctx->cert_dirent_offset =
+		(unsigned long)&ddir->certs - (unsigned long)pebuf;
+	ctx->certs_size = ddir->certs.size;
+
+	if (ddir->certs.virtual_address && ddir->certs.size) {
+
+		chkaddr(ctx->header_size, ddir->certs.virtual_address,
+			ddir->certs.size);
+		ctx->sig_offset = ddir->certs.virtual_address;
+		ctx->sig_len = ddir->certs.size;
+		pr_debug("cert = %x @%x [%*ph]\n",
+			 ctx->sig_len, ctx->sig_offset,
+			 ctx->sig_len, pebuf + ctx->sig_offset);
+
+	}
+
+	ctx->n_sections = pe->sections;
+	if (ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
+		return -ELIBBAD;
+	ctx->secs = secs = pebuf + cursor;
+
+	return 0;
+}
diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 839591ad21ac..063b348bb4c3 100644
--- a/crypto/asymmetric_keys/mscode_parser.c
+++ b/crypto/asymmetric_keys/mscode_parser.c
@@ -11,7 +11,7 @@
 #include <linux/err.h>
 #include <linux/oid_registry.h>
 #include <crypto/pkcs7.h>
-#include "verify_pefile.h"
+#include <asm/parse_pefile.h>
 #include "mscode.asn1.h"
 
 /*
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index f440767bd727..fbb319094c0a 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -14,106 +14,9 @@
 #include <linux/asn1.h>
 #include <linux/verification.h>
 #include <crypto/hash.h>
+#include <asm/parse_pefile.h>
 #include "verify_pefile.h"
 
-/*
- * Parse a PE binary.
- */
-static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
-			       struct pefile_context *ctx)
-{
-	const struct mz_hdr *mz = pebuf;
-	const struct pe_hdr *pe;
-	const struct pe32_opt_hdr *pe32;
-	const struct pe32plus_opt_hdr *pe64;
-	const struct data_directory *ddir;
-	const struct data_dirent *dde;
-	const struct section_header *secs, *sec;
-	size_t cursor, datalen = pelen;
-
-	kenter("");
-
-#define chkaddr(base, x, s)						\
-	do {								\
-		if ((x) < base || (s) >= datalen || (x) > datalen - (s)) \
-			return -ELIBBAD;				\
-	} while (0)
-
-	chkaddr(0, 0, sizeof(*mz));
-	if (mz->magic != MZ_MAGIC)
-		return -ELIBBAD;
-	cursor = sizeof(*mz);
-
-	chkaddr(cursor, mz->peaddr, sizeof(*pe));
-	pe = pebuf + mz->peaddr;
-	if (pe->magic != PE_MAGIC)
-		return -ELIBBAD;
-	cursor = mz->peaddr + sizeof(*pe);
-
-	chkaddr(0, cursor, sizeof(pe32->magic));
-	pe32 = pebuf + cursor;
-	pe64 = pebuf + cursor;
-
-	switch (pe32->magic) {
-	case PE_OPT_MAGIC_PE32:
-		chkaddr(0, cursor, sizeof(*pe32));
-		ctx->image_checksum_offset =
-			(unsigned long)&pe32->csum - (unsigned long)pebuf;
-		ctx->header_size = pe32->header_size;
-		cursor += sizeof(*pe32);
-		ctx->n_data_dirents = pe32->data_dirs;
-		break;
-
-	case PE_OPT_MAGIC_PE32PLUS:
-		chkaddr(0, cursor, sizeof(*pe64));
-		ctx->image_checksum_offset =
-			(unsigned long)&pe64->csum - (unsigned long)pebuf;
-		ctx->header_size = pe64->header_size;
-		cursor += sizeof(*pe64);
-		ctx->n_data_dirents = pe64->data_dirs;
-		break;
-
-	default:
-		pr_warn("Unknown PEOPT magic = %04hx\n", pe32->magic);
-		return -ELIBBAD;
-	}
-
-	pr_debug("checksum @ %x\n", ctx->image_checksum_offset);
-	pr_debug("header size = %x\n", ctx->header_size);
-
-	if (cursor >= ctx->header_size || ctx->header_size >= datalen)
-		return -ELIBBAD;
-
-	if (ctx->n_data_dirents > (ctx->header_size - cursor) / sizeof(*dde))
-		return -ELIBBAD;
-
-	ddir = pebuf + cursor;
-	cursor += sizeof(*dde) * ctx->n_data_dirents;
-
-	ctx->cert_dirent_offset =
-		(unsigned long)&ddir->certs - (unsigned long)pebuf;
-	ctx->certs_size = ddir->certs.size;
-
-	if (!ddir->certs.virtual_address || !ddir->certs.size) {
-		pr_warn("Unsigned PE binary\n");
-		return -ENODATA;
-	}
-
-	chkaddr(ctx->header_size, ddir->certs.virtual_address,
-		ddir->certs.size);
-	ctx->sig_offset = ddir->certs.virtual_address;
-	ctx->sig_len = ddir->certs.size;
-	pr_debug("cert = %x @%x [%*ph]\n",
-		 ctx->sig_len, ctx->sig_offset,
-		 ctx->sig_len, pebuf + ctx->sig_offset);
-
-	ctx->n_sections = pe->sections;
-	if (ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
-		return -ELIBBAD;
-	ctx->secs = secs = pebuf + cursor;
-
-	return 0;
-}
 
 /*
  * Check and strip the PE wrapper from around the signature and check that the
@@ -431,6 +334,13 @@ int verify_pefile_signature(const void *pebuf, unsigned pelen,
 	if (ret < 0)
 		return ret;
 
+	const struct data_dirent *certs = pebuf + ctx.cert_dirent_offset;
+
+	if (!certs->virtual_address || !certs->size) {
+		pr_warn("Unsigned PE binary\n");
+		return -ENODATA;
+	}
+
 	ret = pefile_strip_sig_wrapper(pebuf, &ctx);
 	if (ret < 0)
 		return ret;
@@ -439,8 +349,10 @@ int verify_pefile_signature(const void *pebuf, unsigned pelen,
 				     pebuf + ctx.sig_offset, ctx.sig_len,
 				     trusted_keys, usage,
 				     mscode_parse, &ctx);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_warn("invalid PE file signature\n");
 		goto error;
+	}
 
 	pr_debug("Digest: %u [%*ph]\n",
 		 ctx.digest_len, ctx.digest_len, ctx.digest);
diff --git a/crypto/asymmetric_keys/verify_pefile.h b/crypto/asymmetric_keys/verify_pefile.h
index e1628e100cde..5ab2f9a5b2ef 100644
--- a/crypto/asymmetric_keys/verify_pefile.h
+++ b/crypto/asymmetric_keys/verify_pefile.h
@@ -8,22 +8,6 @@
 #include <crypto/pkcs7.h>
 #include <crypto/hash_info.h>
 
-struct pefile_context {
-	unsigned	header_size;
-	unsigned	image_checksum_offset;
-	unsigned	cert_dirent_offset;
-	unsigned	n_data_dirents;
-	unsigned	n_sections;
-	unsigned	certs_size;
-	unsigned	sig_offset;
-	unsigned	sig_len;
-	const struct section_header *secs;
-
-	/* PKCS#7 MS Individual Code Signing content */
-	const void	*digest;		/* Digest */
-	unsigned	digest_len;		/* Digest length */
-	const char	*digest_algo;		/* Digest algorithm */
-};
 
 #define kenter(FMT, ...)					\
 	pr_devel("==> %s("FMT")\n", __func__, ##__VA_ARGS__)
-- 
2.40.1

