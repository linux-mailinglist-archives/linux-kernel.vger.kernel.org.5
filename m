Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6F80B2B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjLIHFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIHFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:05:30 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336010D2;
        Fri,  8 Dec 2023 23:05:36 -0800 (PST)
Received: from dggpemd200003.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SnJtF75c5z14LyH;
        Sat,  9 Dec 2023 15:05:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 9 Dec 2023 15:05:12 +0800
From:   Chenghai Huang <huangchenghai2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <shenyang39@huawei.com>, <liulongfang@huawei.com>,
        <qianweili@huawei.com>
Subject: [PATCH 0/2] crypto: hisilicon - optimize the processing of qm and sec functions
Date:   Sat, 9 Dec 2023 15:01:33 +0800
Message-ID: <20231209070135.555110-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd200003.china.huawei.com (7.185.36.122)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seires patch optimize the process of ret, and delete risky redundant
functions.

*** BLURB HERE ***

Chenghai Huang (2):
  crypto: hisilicon/qm - delete a dbg function
  crypto: hisilicon/sec2 - optimize the error return process

 drivers/crypto/hisilicon/qm.c              | 3 ---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 7 +++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.30.0

