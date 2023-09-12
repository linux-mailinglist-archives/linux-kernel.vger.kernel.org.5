Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135E179C675
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjILGIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjILGIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:08:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F710D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=s2n5Z3RfaWN4dfWUUsczXNXAwP90GClfQqKVzYRyCYM=; b=UhvL+jfibBaJG6yTsr2aLooe32
        cfKTqsbSfkZ1e7UCJ8wYE1W3uTuvXBMoz96DXZtoM9RkKnKX8ZihPpQyBDMxW2gUtX0m/m4UuyZY4
        pHc05wp61oL9xpYYHWG05/zYTO249JNuiW+NeGmA/QsFBuAyk6vMrqvyHBHq3h3Er1ylw1EuYLsiQ
        TfbVdSwEZUBrDBOlYDlcPBvb7CiY8tI6znPlFRD3/W999Hia+5vGWEnuYzKL25OejQUrpuMui+SzP
        E1dwzlnAVtMsVlQxWVBZyk6jpDjq5Ko8mE4KSJYvAhfRGDKYZNYx77DKxUZYjQXZFnv0hWwMmSblj
        UGrc0SOQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfwZj-002FlQ-1Q;
        Tue, 12 Sep 2023 06:08:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] argv_split: fix kernel-doc warnings
Date:   Mon, 11 Sep 2023 23:08:38 -0700
Message-ID: <20230912060838.3794-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper kernel-doc notation to prevent build warnings:

lib/argv_split.c:36: warning: Function parameter or member 'argv' not described in 'argv_free'
lib/argv_split.c:61: warning: No description found for return value of 'argv_split'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/argv_split.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/lib/argv_split.c b/lib/argv_split.c
--- a/lib/argv_split.c
+++ b/lib/argv_split.c
@@ -28,7 +28,7 @@ static int count_argc(const char *str)
 
 /**
  * argv_free - free an argv
- * @argv - the argument vector to be freed
+ * @argv: the argument vector to be freed
  *
  * Frees an argv and the strings it points to.
  */
@@ -46,7 +46,7 @@ EXPORT_SYMBOL(argv_free);
  * @str: the string to be split
  * @argcp: returned argument count
  *
- * Returns an array of pointers to strings which are split out from
+ * Returns: an array of pointers to strings which are split out from
  * @str.  This is performed by strictly splitting on white-space; no
  * quote processing is performed.  Multiple whitespace characters are
  * considered to be a single argument separator.  The returned array
