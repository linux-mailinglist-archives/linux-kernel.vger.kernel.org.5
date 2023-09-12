Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3409B79C694
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjILGJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjILGIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:08:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117510CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FSlbUZOPuNrJYLUqouC9Nz+xzhAFhpA8fnkS7AspK4M=; b=KETNeV7rPghRQmQwHTvVV9A9tl
        5P+Dd6Ug/MA+84BSMxqEAP8waTv3iWt7jMQ0U3TMsFJpiT/0b50U90LFZgEROW0acXhj2+pClq2cW
        C2sv3rb3SC0E0peACD4JD8+APhibdVaDapDS8F7dmeGhoWmYkzy+jJ9fdfnawzqmQwdRRqvy5Ja0z
        2EtH9Qq/rYWB0v6eZTuSHHmEQ+5BYNovW/CDcAz8x8Xvc4DqZ15cnZlbv8U6oSZMroGSK1Bk+R3RT
        LxWWfL/qcQI7Qp5bhkRIXyv6U8jQHp2yf39WzYQdhaue1RLJ3AVb3aiA6ISprZ6uWTf3iEY+yuQ/u
        GD9sIL1Q==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfwZt-002FmO-1S;
        Tue, 12 Sep 2023 06:08:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] scatterlist: add missing function params to kernel-doc
Date:   Mon, 11 Sep 2023 23:08:48 -0700
Message-ID: <20230912060848.4673-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe missing function parameters to prevent kernel-doc warnings:

lib/scatterlist.c:288: warning: Function parameter or member 'first_chunk' not described in '__sg_alloc_table'
lib/scatterlist.c:800: warning: Function parameter or member 'flags' not described in 'sg_miter_start'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/scatterlist.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -- a/lib/scatterlist.c b/lib/scatterlist.c
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -265,7 +265,8 @@ EXPORT_SYMBOL(sg_free_table);
  * @table:	The sg table header to use
  * @nents:	Number of entries in sg list
  * @max_ents:	The maximum number of entries the allocator returns per call
- * @nents_first_chunk: Number of entries int the (preallocated) first
+ * @first_chunk: first SGL if preallocated (may be %NULL)
+ * @nents_first_chunk: Number of entries in the (preallocated) first
  * 	scatterlist chunk, 0 means no such preallocated chunk provided by user
  * @gfp_mask:	GFP allocation mask
  * @alloc_fn:	Allocator to use
@@ -788,6 +789,7 @@ EXPORT_SYMBOL(__sg_page_iter_dma_next);
  * @miter: sg mapping iter to be started
  * @sgl: sg list to iterate over
  * @nents: number of sg entries
+ * @flags: sg iterator flags
  *
  * Description:
  *   Starts mapping iterator @miter.
