Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D76761B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGYOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjGYOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734E211C;
        Tue, 25 Jul 2023 07:16:05 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9JvB2F3fz1GDJD;
        Tue, 25 Jul 2023 22:14:46 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 22:15:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lduncan@suse.com>, <cleech@redhat.com>,
        <michael.christie@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <haowenchao@huawei.com>,
        <yuehaibing@huawei.com>
CC:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scsi: iscsi: Remove unused extern declaration iscsi_lookup_iface()
Date:   Tue, 25 Jul 2023 22:15:31 +0800
Message-ID: <20230725141531.10424-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not used anymore, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/scsi/scsi_transport_iscsi.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index 34c03707fb6e..fb3399e4cd29 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -472,7 +472,6 @@ extern struct iscsi_iface *iscsi_create_iface(struct Scsi_Host *shost,
 					      uint32_t iface_type,
 					      uint32_t iface_num, int dd_size);
 extern void iscsi_destroy_iface(struct iscsi_iface *iface);
-extern struct iscsi_iface *iscsi_lookup_iface(int handle);
 extern char *iscsi_get_port_speed_name(struct Scsi_Host *shost);
 extern char *iscsi_get_port_state_name(struct Scsi_Host *shost);
 extern int iscsi_is_session_dev(const struct device *dev);
-- 
2.34.1

