Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D87E4141
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjKGNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjKGNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:53:30 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE91B2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:52:54 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SPqMp2Rz3z1P7mb;
        Tue,  7 Nov 2023 21:49:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 21:52:51 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/6] mm: cleanup and use more folio in page fault
Date:   Tue, 7 Nov 2023 21:52:10 +0800
Message-ID: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename page_copy_prealloc() to folio_prealloc(), which is used by
more functions, also do more folio conversion in page fault.

Kefeng Wang (6):
  mm: ksm: use more folio api in ksm_might_need_to_copy()
  mm: memory: use a folio in validate_page_before_insert()
  mm: memory: rename page_copy_prealloc() to folio_prealloc()
  mm: memory: use a folio in do_cow_page()
  mm: memory: use folio_prealloc() in wp_page_copy()
  mm: memory: use folio_prealloc() in do_anonymous_page()

 include/linux/ksm.h |  4 +--
 mm/ksm.c            | 36 +++++++++++------------
 mm/memory.c         | 72 +++++++++++++++++++--------------------------
 3 files changed, 50 insertions(+), 62 deletions(-)

-- 
2.27.0

