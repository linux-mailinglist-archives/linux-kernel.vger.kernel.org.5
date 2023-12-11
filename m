Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4380BF2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjLKCcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjLKCcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:32:07 -0500
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FF0BD;
        Sun, 10 Dec 2023 18:32:08 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SpQCk3H1Gz1FDhX;
        Mon, 11 Dec 2023 10:09:06 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id 138A41A016F;
        Mon, 11 Dec 2023 10:12:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:12:39 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 6/6] net: sfp: Synchronize some CMIS transceiver modules from ethtool
Date:   Mon, 11 Dec 2023 10:08:16 +0800
Message-ID: <20231211020816.69434-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231211020816.69434-1-shaojijie@huawei.com>
References: <20231211020816.69434-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Lan <lanhao@huawei.com>

Currently, the SFF-8024 Identifier Values that according to the standard
support for the Common Management Interface Specification (CMIS)
based on standard identifier values in the ethtool is more than in the
kernel. When the driver needs to use a newer Identifier Value, the kernel
interface does not support it. Therefore, we synchronize the CMIS mode
Identifier Values which supported by the ethtool to the kernel.

ethtool links:
Link:https://lore.kernel.org/all/1471959033-1053-3-git-send-email-vidya@cumulusnetworks.com/
Link:https://lore.kernel.org/all/20200813150826.16680-1-popadrian1996@gmail.com/
Link:https://lore.kernel.org/all/20220207091231.2047315-1-danieller@nvidia.com/
Link:https://lore.kernel.org/all/1623949504-51291-3-git-send-email-moshe@nvidia.com/
Link:https://lore.kernel.org/all/20231030072353.1031217-1-idosch@nvidia.com/
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 include/linux/sfp.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 9346cd44814d..e0b333d9e999 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -284,6 +284,18 @@ enum {
 	SFF8024_ID_QSFP_8438		= 0x0c,
 	SFF8024_ID_QSFP_8436_8636	= 0x0d,
 	SFF8024_ID_QSFP28_8636		= 0x11,
+	SFF8024_ID_CXP2			= 0x12,
+	SFF8024_ID_CDFP			= 0x13,
+	SFF8024_ID_HD4X_FANOUT		= 0x14,
+	SFF8024_ID_HD8X_FANOUT		= 0x15,
+	SFF8024_ID_CDFP_S3		= 0x16,
+	SFF8024_ID_MICRO_QSFP		= 0x17,
+	SFF8024_ID_QSFP_DD		= 0x18,
+	SFF8024_ID_OSFP			= 0x19,
+	SFF8024_ID_DSFP			= 0x1B,
+	SFF8024_ID_QSFP_PLUS_CMIS	= 0x1E,
+	SFF8024_ID_SFP_DD_CMIS		= 0x1F,
+	SFF8024_ID_SFP_PLUS_CMIS	= 0x20,
 
 	SFF8024_ENCODING_UNSPEC		= 0x00,
 	SFF8024_ENCODING_8B10B		= 0x01,
-- 
2.30.0

