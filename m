Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E467F0ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjKTDTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKTDTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:19:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9EEC1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:19:49 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SYXmP3cn8zQnVD;
        Mon, 20 Nov 2023 11:19:17 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 Nov
 2023 11:19:46 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <Carson.Li1@unisoc.com>,
        <s.hauer@pengutronix.de>, <houtao1@huawei.com>,
        <ext-adrian.hunter@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] ubifs: Fixed several low-probability issues.
Date:   Mon, 20 Nov 2023 19:13:44 +0800
Message-ID: <20231120111347.2254153-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These filesystem problems are found in stress tests from
https://lore.kernel.org/linux-mtd/935504729.4822.1697398448017.JavaMail.zimbra@nod.at/.

Zhihao Cheng (3):
  ubifs: Check @c->dirty_[n|p]n_cnt and @c->nroot state under
    @c->lp_mutex
  ubifs: ubifs_tnc_locate: Drop TNC mutex lockless reading path
  ubifs: Don't stop retrying even if committing times exceeds two

 fs/ubifs/commit.c  | 13 ++++++++++++-
 fs/ubifs/journal.c | 26 ++++++++++----------------
 fs/ubifs/tnc.c     | 31 +++----------------------------
 3 files changed, 25 insertions(+), 45 deletions(-)

-- 
2.39.2

