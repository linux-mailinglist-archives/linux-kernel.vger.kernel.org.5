Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1827F58C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbjKWHAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjKWHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:00:39 -0500
Received: from out0-201.mail.aliyun.com (out0-201.mail.aliyun.com [140.205.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F12C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:00:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.VU5T8VK_1700722841;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.VU5T8VK_1700722841)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 15:00:42 +0800
From:   "=?UTF-8?B?6buE6Z2WKOm7hOmdlik=?=" <henry.hj@antgroup.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
        <akpm@linux-foundation.org>,
        "=?UTF-8?B?6buE6Z2WKOm7hOmdlik=?=" <henry.hj@antgroup.com>
Subject: [RFC] mm: Multi-gen LRU: fix use of mm/page_idle/bitmap
Date:   Thu, 23 Nov 2023 14:58:10 +0800
Message-ID: <cover.1700719508.git.henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Multi-Gen LRU is enabled, we can't use /sys/kernel/mm/page_idle/bitmap
to track memory which is actually been used.
Unfortunately we didn't find anyone report this problem, or it just
by design ?
Detail information, how-to-reproduct and our way to fix are written in our
fix patch.

Henry Huang (1):
  mm: Multi-Gen LRU: fix use mm/page_idle/bitmap

 mm/swap.c   |  3 +++
 mm/vmscan.c | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.43.0

