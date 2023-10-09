Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF67BD3B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbjJIGnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbjJIGnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:43:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D0A3;
        Sun,  8 Oct 2023 23:43:40 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S3qCb6dwxzVlVJ;
        Mon,  9 Oct 2023 14:40:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 14:43:38 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jose.exposito89@gmail.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2 0/2] HID: uclogic: Fix two bugs in uclogic
Date:   Mon, 9 Oct 2023 14:42:43 +0800
Message-ID: <20231009064245.3573397-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HID_UCLOGIC=y and CONFIG_KUNIT_ALL_TESTS=y, launch
kernel and then there are a user-memory-access bug and a work->entry
not empty bug. This patchset fix these issues.

Changes in v2:
- Use kunit_kzalloc() instead of kzalloc().
- Add KUNIT_ASSERT_NOT_ERR_OR_NULL() for kunit_kzalloc().
- Add Reviewed-by.

Jinjie Ruan (2):
  HID: uclogic: Fix user-memory-access bug in
    uclogic_params_ugee_v2_init_event_hooks()
  HID: uclogic: Fix a work->entry not empty bug in __queue_work()

 drivers/hid/hid-uclogic-core-test.c   |  7 +++++++
 drivers/hid/hid-uclogic-params-test.c | 16 +++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.34.1

