Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5E7546D9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGOEYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjGOEYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:24:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B13AB7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EduZ7W0Le6I35LYB/u+YcVvsoSvotZ94k7H+d8Z5G54=; b=MLPY15+33nuOpVVoVVRORpp6nI
        B/2U1S0zN4gQDRRyF+TgPm/ye6qNmKTmUuBjdlI85g70rDYYLl3wpIXeJ1w8A6iUGsGwLcd3iWRjT
        zInEVcnDaflgUwfAOt/su4CbibIVXpgzO+dj/HHhsqU1P3IIRaW4P7dsE4QKSsLqO6Z5mcMFmSFvO
        ljBj8CiLgN1MYIu3xDFDnuCRCFSotXCiHiKZsatJ85Ev1IcZf4YTiuuksfEXUC7qPbieXKqY3JRqV
        N/UzhHm4NXg1D/1kAewieLPSG58JipVtcLTXMn6Psdx4SAvEQjzsGCe55itdzotsD6bmw9e4fXlCG
        7rMY+5zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWos-001p3o-B3; Sat, 15 Jul 2023 04:23:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vitaly.wool@konsulko.com, cerasuolodomenico@gmail.com,
        nphamcs@gmail.com, hch@infradead.org, yosryahmed@google.com,
        akpm@linux-foundation.org
Subject: [PATCH 1/5] fix-frontswap
Date:   Sat, 15 Jul 2023 05:23:39 +0100
Message-Id: <20230715042343.434588-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230715042343.434588-1-willy@infradead.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <20230715042343.434588-1-willy@infradead.org>
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

---
 mm/zswap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1b0128060792..f6a78e085479 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -26,6 +26,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mempool.h>
 #include <linux/zpool.h>
+#include <linux/zswap.h>
 #include <crypto/acompress.h>
 
 #include <linux/mm_types.h>
-- 
2.39.2

