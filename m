Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8090D7747AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjHHTRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbjHHTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:17:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567A3FD10
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:39:53 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKtWP6Q3yztRpq;
        Tue,  8 Aug 2023 20:57:21 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 21:00:50 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <lee@kernel.org>, <thor.thayer@linux.intel.com>,
        <ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next 0/8] mfd: remove redundant of_match_ptr()
Date:   Tue, 8 Aug 2023 21:00:15 +0800
Message-ID: <20230808130023.202700-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr() here.

Zhu Wang (8):
  mfd: rsmu_i2c: remove redundant of_match_ptr()
  mfd: altera-a10sr: remove redundant of_match_ptr()
  mfd: rsmu_spi: remove redundant of_match_ptr()
  mfd: act8945a: remove redundant of_match_ptr()
  mfd: stpmic1: remove redundant of_match_ptr()
  mfd: hi655x-pmic: remove redundant of_match_ptr()
  mfd: lochnagar-i2c: remove redundant of_match_ptr()
  mfd: rn5t618: remove redundant of_match_ptr()

 drivers/mfd/act8945a.c      | 2 +-
 drivers/mfd/altera-a10sr.c  | 2 +-
 drivers/mfd/hi655x-pmic.c   | 2 +-
 drivers/mfd/lochnagar-i2c.c | 2 +-
 drivers/mfd/rn5t618.c       | 2 +-
 drivers/mfd/rsmu_i2c.c      | 2 +-
 drivers/mfd/rsmu_spi.c      | 2 +-
 drivers/mfd/stpmic1.c       | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.1

