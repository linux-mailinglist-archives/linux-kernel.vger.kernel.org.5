Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C147E19CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKFF4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjKFF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:56:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0A81BC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 21:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DEejfhwXImBiGzcbo0qc6ToTtzflXskyiDMdckWzU8I=; b=PWMNNTxSQGk/qq9CDWArWxt9Aw
        NeJuj0uChyLTovkvhyvvv9nN4CBgl8mrchIDbn1D0hrPLkGm3jec2SYlJLFm7n60kGFDy8lPMP88L
        LEUTm3uYGuxebm4fFEpl76VJnd2d4/XmdQqnc+8scNJqTBQuHV5pznMunbMIsqu1UgJQrcHCiJga0
        m9FeJVV8GfDOO/R9pZpN5Q6KERVviEKStJYVg0QQ52KYPHdc2tEDWLK2klKIoj22pEB/DmOpFLRAM
        O8l/UeBa0hsjA0ovKK6SplIlS0zHNVZ+V3V8WVYFiOMIEiWI4Toxh0xs7TIWVp5gse0m4m5SjbRLP
        nTEapITw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qzsb9-00FujY-22;
        Mon, 06 Nov 2023 05:56:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] xen/shbuf: eliminate 17 kernel-doc warnings
Date:   Sun,  5 Nov 2023 21:56:31 -0800
Message-ID: <20231106055631.21520-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use kernel-doc markers ("/**") for comments that are not in
kernel-doc format. This prevents multiple kernel-doc warnings:

xen-front-pgdir-shbuf.c:25: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * This structure represents the structure of a shared page
xen-front-pgdir-shbuf.c:37: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Shared buffer ops which are differently implemented
xen-front-pgdir-shbuf.c:65: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Get granted reference to the very first page of the
xen-front-pgdir-shbuf.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Map granted references of the shared buffer.
xen-front-pgdir-shbuf.c:106: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Unmap granted references of the shared buffer.
xen-front-pgdir-shbuf.c:127: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Free all the resources of the shared buffer.
xen-front-pgdir-shbuf.c:154: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Get the number of pages the page directory consumes itself.
xen-front-pgdir-shbuf.c:164: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Calculate the number of grant references needed to share the buffer
xen-front-pgdir-shbuf.c:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Calculate the number of grant references needed to share the buffer
xen-front-pgdir-shbuf.c:194: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Unmap the buffer previously mapped with grant references
xen-front-pgdir-shbuf.c:242: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Map the buffer with grant references provided by the backend.
xen-front-pgdir-shbuf.c:324: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Fill page directory with grant references to the pages of the
xen-front-pgdir-shbuf.c:354: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Fill page directory with grant references to the pages of the
xen-front-pgdir-shbuf.c:393: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Grant references to the frontend's buffer pages.
xen-front-pgdir-shbuf.c:422: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Grant all the references needed to share the buffer.
xen-front-pgdir-shbuf.c:470: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Allocate all required structures to mange shared buffer.
xen-front-pgdir-shbuf.c:510: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Allocate a new instance of a shared buffer.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202311060203.yQrpPZhm-lkp@intel.com
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/xen-front-pgdir-shbuf.c |   34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff -- a/drivers/xen/xen-front-pgdir-shbuf.c b/drivers/xen/xen-front-pgdir-shbuf.c
--- a/drivers/xen/xen-front-pgdir-shbuf.c
+++ b/drivers/xen/xen-front-pgdir-shbuf.c
@@ -21,7 +21,7 @@
 
 #include <xen/xen-front-pgdir-shbuf.h>
 
-/**
+/*
  * This structure represents the structure of a shared page
  * that contains grant references to the pages of the shared
  * buffer. This structure is common to many Xen para-virtualized
@@ -33,7 +33,7 @@ struct xen_page_directory {
 	grant_ref_t gref[]; /* Variable length */
 };
 
-/**
+/*
  * Shared buffer ops which are differently implemented
  * depending on the allocation mode, e.g. if the buffer
  * is allocated by the corresponding backend or frontend.
@@ -61,7 +61,7 @@ struct xen_front_pgdir_shbuf_ops {
 	int (*unmap)(struct xen_front_pgdir_shbuf *buf);
 };
 
-/**
+/*
  * Get granted reference to the very first page of the
  * page directory. Usually this is passed to the backend,
  * so it can find/fill the grant references to the buffer's
@@ -81,7 +81,7 @@ xen_front_pgdir_shbuf_get_dir_start(stru
 }
 EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_get_dir_start);
 
-/**
+/*
  * Map granted references of the shared buffer.
  *
  * Depending on the shared buffer mode of allocation
@@ -102,7 +102,7 @@ int xen_front_pgdir_shbuf_map(struct xen
 }
 EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_map);
 
-/**
+/*
  * Unmap granted references of the shared buffer.
  *
  * Depending on the shared buffer mode of allocation
@@ -123,7 +123,7 @@ int xen_front_pgdir_shbuf_unmap(struct x
 }
 EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_unmap);
 
-/**
+/*
  * Free all the resources of the shared buffer.
  *
  * \param buf shared buffer which resources to be freed.
@@ -150,7 +150,7 @@ EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_
 				 offsetof(struct xen_page_directory, \
 					  gref)) / sizeof(grant_ref_t))
 
-/**
+/*
  * Get the number of pages the page directory consumes itself.
  *
  * \param buf shared buffer.
@@ -160,7 +160,7 @@ static int get_num_pages_dir(struct xen_
 	return DIV_ROUND_UP(buf->num_pages, XEN_NUM_GREFS_PER_PAGE);
 }
 
-/**
+/*
  * Calculate the number of grant references needed to share the buffer
  * and its pages when backend allocates the buffer.
  *
@@ -172,7 +172,7 @@ static void backend_calc_num_grefs(struc
 	buf->num_grefs = get_num_pages_dir(buf);
 }
 
-/**
+/*
  * Calculate the number of grant references needed to share the buffer
  * and its pages when frontend allocates the buffer.
  *
@@ -190,7 +190,7 @@ static void guest_calc_num_grefs(struct
 #define xen_page_to_vaddr(page) \
 	((uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
 
-/**
+/*
  * Unmap the buffer previously mapped with grant references
  * provided by the backend.
  *
@@ -238,7 +238,7 @@ static int backend_unmap(struct xen_fron
 	return ret;
 }
 
-/**
+/*
  * Map the buffer with grant references provided by the backend.
  *
  * \param buf shared buffer.
@@ -320,7 +320,7 @@ static int backend_map(struct xen_front_
 	return ret;
 }
 
-/**
+/*
  * Fill page directory with grant references to the pages of the
  * page directory itself.
  *
@@ -350,7 +350,7 @@ static void backend_fill_page_dir(struct
 	page_dir->gref_dir_next_page = XEN_GREF_LIST_END;
 }
 
-/**
+/*
  * Fill page directory with grant references to the pages of the
  * page directory and the buffer we share with the backend.
  *
@@ -389,7 +389,7 @@ static void guest_fill_page_dir(struct x
 	}
 }
 
-/**
+/*
  * Grant references to the frontend's buffer pages.
  *
  * These will be shared with the backend, so it can
@@ -418,7 +418,7 @@ static int guest_grant_refs_for_buffer(s
 	return 0;
 }
 
-/**
+/*
  * Grant all the references needed to share the buffer.
  *
  * Grant references to the page directory pages and, if
@@ -466,7 +466,7 @@ static int grant_references(struct xen_f
 	return 0;
 }
 
-/**
+/*
  * Allocate all required structures to mange shared buffer.
  *
  * \param buf shared buffer.
@@ -506,7 +506,7 @@ static const struct xen_front_pgdir_shbu
 	.grant_refs_for_buffer = guest_grant_refs_for_buffer,
 };
 
-/**
+/*
  * Allocate a new instance of a shared buffer.
  *
  * \param cfg configuration to be used while allocating a new shared buffer.
