Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DA79FFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjINJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjINJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:09:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA91FE6;
        Thu, 14 Sep 2023 02:09:12 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RmWck0g7HzGq1Q;
        Thu, 14 Sep 2023 17:05:26 +0800 (CST)
Received: from localhost.huawei.com (10.50.163.32) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 14 Sep 2023 17:09:09 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 0/2] crypto: hisilicon/zip - change support algorithms
Date:   Thu, 14 Sep 2023 17:09:06 +0800
Message-ID: <20230914090908.3849318-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add deflate algorithm. Remove zlib and gzip algorithms.
Tested with disable CONFIG_CRYPTO_MANAGER_DISABLE_TESTS.

Yang Shen (2):
  crypto: hisilicon/zip - support deflate algorithm
  crypto: hisilicon/zip - remove zlib and gzip

 drivers/crypto/hisilicon/zip/zip_crypto.c | 282 +++-------------------
 drivers/crypto/hisilicon/zip/zip_main.c   |   4 +-
 2 files changed, 37 insertions(+), 249 deletions(-)

--
2.33.0
