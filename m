Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18467801BB2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjLBJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjLBJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:20:52 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993813D;
        Sat,  2 Dec 2023 01:20:57 -0800 (PST)
Received: from dggpeml500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sj46T4sdSzMnV2;
        Sat,  2 Dec 2023 17:16:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Dec 2023 17:20:55 +0800
From:   Zhiqi Song <songzhiqi1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <fanghao11@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <shenyang39@huawei.com>
Subject: [PATCH 0/5] crypto: hisilicon - fix the process to obtain capability register value
Date:   Sat, 2 Dec 2023 17:17:17 +0800
Message-ID: <20231202091722.1974582-1-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500005.china.huawei.com (7.185.36.59)
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

This patchset fixes the process to obtain the value of capability
registers related to irq and alg support info. Pre-store the valid
values of them.

Wenkai Lin (1):
  crypto: hisilicon/qm - add a function to set qm algs

Zhiqi Song (4):
  crypto: hisilicon/qm - save capability registers in qm init process
  crypto: hisilicon/hpre - save capability registers in probe process
  crypto: hisilicon/sec2 - save capability registers in probe process
  crypto: hisilicon/zip - save capability registers in probe process

 drivers/crypto/hisilicon/hpre/hpre_main.c  | 122 +++++++++++----------
 drivers/crypto/hisilicon/qm.c              |  98 +++++++++++++++--
 drivers/crypto/hisilicon/sec2/sec.h        |   7 ++
 drivers/crypto/hisilicon/sec2/sec_crypto.c |  10 +-
 drivers/crypto/hisilicon/sec2/sec_main.c   |  70 ++++++------
 drivers/crypto/hisilicon/zip/zip_main.c    | 120 +++++++++++---------
 include/linux/hisi_acc_qm.h                |  20 +++-
 7 files changed, 293 insertions(+), 154 deletions(-)

-- 
2.30.0

