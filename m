Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F07A71E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjITFWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjITFVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA94F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F5img2w0CqZkSGbVt3g9ub4mLFP6v/5RAYKtgYB2Q/E=; b=L5aRGlqFa0BvSIX4FQsXuUtGBp
        OZUaS/a7pAbNJRizkQA+IW8AHtukiTmXqXfH/EtK/njEP92In8td/Floa4GhTFj0xDDTd4brC+Dff
        CDarIkb/srH2GyDq0H5AV/P+EBKbj6gVZ8SVF7ilaSlg17tZuuM4KFS7E5Wk31XdPrfmTU2QzW5jX
        EpgIZ0ChsKZ/vgSlAE/KFSiNVSA9RUh2tHpn9Ut/pwOkcWu5EJw1MAXMKV/62Xhz6mO0r80f2jQhg
        A1gXt817fUpvuggYMfoBmwxJWDdw3kZXkqvZDrHXRJ0YWfN3ZQvgUmZQD9S6fzf1zvQ8R+OPuQIO7
        Mccgg5Nw==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipek-001tym-2K;
        Wed, 20 Sep 2023 05:21:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 16/16] xtensa: boot/lib: add missing prototypes for functions
Date:   Tue, 19 Sep 2023 22:21:39 -0700
Message-ID: <20230920052139.10570-17-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function prototypes for exit(), zalloc(), and gunzip() to the
boot library code.

arch/xtensa/boot/lib/zmem.c:8:6: warning: no previous prototype for 'exit' [-Wmissing-prototypes]
    8 | void exit (void)
arch/xtensa/boot/lib/zmem.c:13:7: warning: no previous prototype for 'zalloc' [-Wmissing-prototypes]
   13 | void *zalloc(unsigned size)
arch/xtensa/boot/lib/zmem.c:35:6: warning: no previous prototype for 'gunzip' [-Wmissing-prototypes]
   35 | void gunzip (void *dst, int dstlen, unsigned char *src, int *lenp)

Fixes: 4bedea945451 ("xtensa: Architecture support for Tensilica Xtensa Part 2")
Fixes: e7d163f76665 ("xtensa: Removed local copy of zlib and fixed O= support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/boot/lib/zmem.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -- a/arch/xtensa/boot/lib/zmem.c b/arch/xtensa/boot/lib/zmem.c
--- a/arch/xtensa/boot/lib/zmem.c
+++ b/arch/xtensa/boot/lib/zmem.c
@@ -5,6 +5,10 @@
 
 extern void *avail_ram, *end_avail;
 
+void exit (void);
+void *zalloc(unsigned size);
+void gunzip (void *dst, int dstlen, unsigned char *src, int *lenp);
+
 void exit (void)
 {
   for (;;);
