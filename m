Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D659379A2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjIKF0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIKF0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:26:32 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A85C1AE;
        Sun, 10 Sep 2023 22:26:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 97A345C00CB;
        Mon, 11 Sep 2023 01:26:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Sep 2023 01:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1694409986; x=
        1694496386; bh=bnLTEENMoP7zGIZkcPERciYrqrfxHWq0c8MPE1NHsQY=; b=K
        kWMdAH5oztBO4eksVmbaAS5V/0rb5VxaWrSyPn1xBxL7VJe1yeRrQLVa37m9Rqt7
        2Q9uHyv++9/xl0Bee0HxwuyO2oPEtjkPEOR+AMRS3DNLoHCyUSmd2VBIKtZichdp
        +iPvy7AbXNyq/syJMvRR0/V3pegk+ZsMgyXJmSZ0EdujemTynmUaR5DALRBYx+10
        j8mVv5Ct//iI22+oyEDH//NhuI+w4BZtgRZ+VITiiIDx4nxW9NrHbHP3r1KZTXh1
        ttpMEhJwI8y03fx9RTJrF9+Ndg8lC7Whe6LvWfGai6MUbQCwwkTGk33HQrLZ88Vx
        EN87rPeKt6LhbOe/JDPmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694409986; x=
        1694496386; bh=bnLTEENMoP7zGIZkcPERciYrqrfxHWq0c8MPE1NHsQY=; b=J
        wS0Oy8+OsdBZ/kKIFx1+4MdqB8Bgv2lM0+jeTVYeVwRbk1PohvAr3cg0rU40DCUF
        3VNSVQpVpubiS2jHUIbA8EugeTNoTbrF5sKkKj6TDYR/vGsY5DAaNAGswDMpgbGT
        6on5qLdgbPpHq5KpJBiiCVb9fhjxA0sjGuupEDBlP8jMyy/qAI5hfwowwq7xYzCL
        r3o7mWJC5oWCvuPrQj08TmCBPCFf72SchzRBCVQEvwQAOwDhm95dwTDZCVDfXalC
        bQBezR9UYOgbbZGPXCpiUisdp6qLOtru/Peoj1kgDBt3sIl4/CHI0+ru7mNMMKAP
        RUZoUHTjhJKBX3OUeKh1g==
X-ME-Sender: <xms:AqX-ZNf8xKJIxOsUmHuMXE3Wu_d3V7sqJwN5F8U7kd7NQe8EuKaCug>
    <xme:AqX-ZLPtMhnU-h7JkzB7-XmKa5LSRFM1_tfokuK1H70SC0ktiz8DTyTs2S4LDqWqY
    22KBawjJo2rPM7CGmo>
X-ME-Received: <xmr:AqX-ZGhfos7d3Ln_rNLydbTWz056dqzwd8JApRKxpvufll2Dw8FdZXTyDPV2o_zgG0c2IEvkxJzWgQCxlMjmWZNwRGWV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeifedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfjvghnughrihhk
    ucfhrghrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpe
    egfeeliefggeeiiedtudevveevvddvvefguddtvdeitdejleejuefgueelieehteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlh
    esjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:AqX-ZG97nUXIi8SUUcnJDmR-Z9mnOhY27ILf3JpSYZAkGU6KOMbMfA>
    <xmx:AqX-ZJsMi2kg1ac-mw71xLNWa1BI5x2O4tzIFtn-vp-0Axf7Hiyn7w>
    <xmx:AqX-ZFE8UmeZ9x2ehFidqCcsSul028ce0uuEJl3YtM2einE4cL7S1w>
    <xmx:AqX-ZFEFpNMQDwLKS66UK-sGdsjDwktkskesXLwrfLMTIfiVzZY0bA>
Feedback-ID: i0fc947c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Sep 2023 01:26:24 -0400 (EDT)
From:   Jan Hendrik Farr <kernel@jfarr.cc>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        bluca@debian.org, lennart@poettering.net,
        Jan Hendrik Farr <kernel@jfarr.cc>
Subject: [PATCH v2 1/2] move pefile_parse_binary to its own file
Date:   Mon, 11 Sep 2023 07:25:34 +0200
Message-Id: <20230911052535.335770-2-kernel@jfarr.cc>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230911052535.335770-1-kernel@jfarr.cc>
References: <20230911052535.335770-1-kernel@jfarr.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
---
 crypto/asymmetric_keys/mscode_parser.c |   2 +-
 crypto/asymmetric_keys/verify_pefile.c |  99 +---------------------
 crypto/asymmetric_keys/verify_pefile.h |  16 ----
 include/linux/parse_pefile.h           |  32 +++++++
 lib/Makefile                           |   2 +
 lib/parse_pefile.c                     | 110 +++++++++++++++++++++++++
 6 files changed, 146 insertions(+), 115 deletions(-)
 create mode 100644 include/linux/parse_pefile.h
 create mode 100644 lib/parse_pefile.c

diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 839591ad21ac..996528b3f11c 100644
--- a/crypto/asymmetric_keys/mscode_parser.c
+++ b/crypto/asymmetric_keys/mscode_parser.c
@@ -11,7 +11,7 @@
 #include <linux/err.h>
 #include <linux/oid_registry.h>
 #include <crypto/pkcs7.h>
-#include "verify_pefile.h"
+#include <linux/parse_pefile.h>
 #include "mscode.asn1.h"
 
 /*
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index f440767bd727..68592a328db7 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -14,106 +14,9 @@
 #include <linux/asn1.h>
 #include <linux/verification.h>
 #include <crypto/hash.h>
+#include <linux/parse_pefile.h>
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
diff --git a/include/linux/parse_pefile.h b/include/linux/parse_pefile.h
new file mode 100644
index 000000000000..c29f8c98ee66
--- /dev/null
+++ b/include/linux/parse_pefile.h
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
diff --git a/lib/Makefile b/lib/Makefile
index 2e08397f6210..01a6c13565b6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -365,6 +365,8 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
 
 obj-$(CONFIG_PARMAN) += parman.o
 
+obj-$(CONFIG_SIGNED_PE_FILE_VERIFICATION) += parse_pefile.o
+
 obj-y += group_cpus.o
 
 # GCC library routines
diff --git a/lib/parse_pefile.c b/lib/parse_pefile.c
new file mode 100644
index 000000000000..9a8496b2588e
--- /dev/null
+++ b/lib/parse_pefile.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Parse a PE binary
+ *
+ * Copyright (C) 2014 Red Hat, Inc. All Rights Reserved.
+ *
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/parse_pefile.h>
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
+	if (!ddir->certs.virtual_address || !ddir->certs.size) {
+		pr_warn("Unsigned PE binary\n");
+		return -ENODATA;
+	}
+
+	chkaddr(ctx->header_size, ddir->certs.virtual_address,
+		ddir->certs.size);
+	ctx->sig_offset = ddir->certs.virtual_address;
+	ctx->sig_len = ddir->certs.size;
+	pr_debug("cert = %x @%x [%*ph]\n",
+		 ctx->sig_len, ctx->sig_offset,
+		 ctx->sig_len, pebuf + ctx->sig_offset);
+
+	ctx->n_sections = pe->sections;
+	if (ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
+		return -ELIBBAD;
+	ctx->secs = secs = pebuf + cursor;
+
+	return 0;
+}
-- 
2.40.1

