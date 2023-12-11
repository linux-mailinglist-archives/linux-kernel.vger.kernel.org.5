Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15280C8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjLKMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjLKMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:02:17 -0500
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8865E172B;
        Mon, 11 Dec 2023 04:02:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Spfs82Rl8z1FDmK;
        Mon, 11 Dec 2023 19:38:52 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
        by mail.maildlp.com (Postfix) with ESMTPS id 5F4F91800DA;
        Mon, 11 Dec 2023 19:42:26 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.174.149.11) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 19:42:25 +0800
From:   Gonglei <arei.gonglei@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lixiao91@huawei.com>,
        wangyangxin <wangyangxin1@huawei.com>
Subject: [PATCH 0/2] crypto: virtio-crypto: Wait for tasklet to complete on device remove and fix warnings
Date:   Mon, 11 Dec 2023 19:42:14 +0800
Message-ID: <1702294936-61080-1-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.149.11]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangyangxin <wangyangxin1@huawei.com>

This serie wait for tasklet to complete on device remove and fix gcc check warnings.

wangyangxin (2):
  crypto: virtio-crypto: Wait for tasklet to complete on device remove
  crypto: virtio-crypto: Fix gcc check warnings

 drivers/crypto/virtio/virtio_crypto_common.h | 5 ++---
 drivers/crypto/virtio/virtio_crypto_core.c   | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.33.0

