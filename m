Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36C76092A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGYFXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGYFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:23:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA7A6;
        Mon, 24 Jul 2023 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=w1RQcZApJNcQIiOYko3MBN0wAf27FXEvpHj25/B9Tsw=; b=rE1E61PVdJWNEsWmfXuK5T1ovO
        5AUZlmGgeAu+Hpt/3i6QoDfcBzCy59P+qcU0ffxUhYP9jaovuutm04ey5xq3BiKb9109Rdt0I/id3
        GN/8GNJyGjgs1XAExNntJug/VHZ+mBpuSQe1eTJLYgLhrv5uosY9FvwOxAmNfyQj5nawe3Hvbfmc2
        vAuLgZHP5j60p8puNVuCgqL5iVbvzrcUDeYZFBNycK1tp39mbT+AHtcXuAXFQXsKl8F9OO0Fy6pMO
        bCFzekbFcI0AJsWezAKs4GeFKB5Fz5OXQnJAMnEYnivhPt8n5Gy7M2aSM0H5LgyCFRWH19hHEWF73
        5rporfmQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOAWE-006IGf-1w;
        Tue, 25 Jul 2023 05:23:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] tmpfs: fixup Docs table for huge mount options
Date:   Mon, 24 Jul 2023 22:23:33 -0700
Message-ID: <20230725052333.26857-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A table's header and footer lines must match its text columns in
width, so extend the header/footer for column 1 to match the text.

Fixes this documentation build error:
Documentation/filesystems/tmpfs.rst:116: ERROR: Malformed table.
Text in column margin in table line 4.

Fixes: a0ebb5aa2de3 ("tmpfs: fix Documentation of noswap and huge mount options")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/3084e97c-3a7d-ace8-2e9c-31642fd663df@google.com/T/#me28ed2124bca2e632eee86ff1d986e5c1f731a7c
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
I guess that Andrew will merge this since he merged the previous patch.

 Documentation/filesystems/tmpfs.rst |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -- a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -110,13 +110,13 @@ configured with CONFIG_TRANSPARENT_HUGEP
 your system (has_transparent_hugepage(), which is architecture specific).
 The mount options for this are:
 
-===========  ==============================================================
-huge=never   Do not allocate huge pages.  This is the default.
-huge=always  Attempt to allocate huge page every time a new page is needed.
+================ ==============================================================
+huge=never       Do not allocate huge pages.  This is the default.
+huge=always      Attempt to allocate huge page every time a new page is needed.
 huge=within_size Only allocate huge page if it will be fully within i_size.
-             Also respect madvise(2) hints.
-huge=advise  Only allocate huge page if requested with madvise(2).
-===========  ==============================================================
+                 Also respect madvise(2) hints.
+huge=advise      Only allocate huge page if requested with madvise(2).
+================ ==============================================================
 
 See also Documentation/admin-guide/mm/transhuge.rst, which describes the
 sysfs file /sys/kernel/mm/transparent_hugepage/shmem_enabled: which can
