Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9CD7925BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbjIEQHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353820AbjIEITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:19:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9971AE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=glV+PT1PSzJWEyCTcQ2AiufMU35o8KRN9m2n5Yof1BE=; b=H/JDHr3bfNICiU59mfHJ6MtCTG
        o7rLyk0aE4mXFKGn5htkZVqH8w1PwRM7wmP55jcpgBFaQu8UnEnqgPYGzwsH4LWDfKG4/LRK4eIwd
        oBy9QTMOHHckkU/WqbvhaLdbolOlgJXgAZHDQBP7CMt0+zmnpjLDJR5QAxP7o3c7bMKg2rzDf57PN
        arpE2bo8tvEMVs3UXMEkUyTg2O2AqPnkfxGFFGujs3bsAlW0ksF0F98VHt3iGZOIL/1tVOuFlPYi3
        MqA2hicdZMhG5WBralmTN++A6pJilS5gFOyRgYJv3DIG/DsjcmALxKM0s9i5tRMfdZ/s5AsZTAZkN
        nnmkO+ew==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdRH8-005Vd4-0i;
        Tue, 05 Sep 2023 08:19:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "printk: export symbols for debug modules"
Date:   Tue,  5 Sep 2023 10:19:02 +0200
Message-Id: <20230905081902.321778-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3e00123a13d824d63072b1824c9da59cd78356d9.

No, we never export random symbols for out of tree modules.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/printk/printk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 96fc38cb2e8415..7e0b4dd02398db 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -538,14 +538,12 @@ char *log_buf_addr_get(void)
 {
 	return log_buf;
 }
-EXPORT_SYMBOL_GPL(log_buf_addr_get);
 
 /* Return log buffer size */
 u32 log_buf_len_get(void)
 {
 	return log_buf_len;
 }
-EXPORT_SYMBOL_GPL(log_buf_len_get);
 
 /*
  * Define how much of the log buffer we could take at maximum. The value
-- 
2.39.2

