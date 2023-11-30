Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE67FF088
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbjK3Npt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345646AbjK3Npr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:45:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42833DD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:45:53 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sgy9s3m4PzWj0l;
        Thu, 30 Nov 2023 21:45:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 21:45:50 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Jonathan.Cameron@Huawei.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v2 1/4] soc: hisilicon: kunpeng_hccs: Fix some incorrect format strings
Date:   Thu, 30 Nov 2023 21:45:47 +0800
Message-ID: <20231130134550.33398-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231130134550.33398-1-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
 <20231130134550.33398-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some incorrect format strings.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index e31791659560..dad6235dbf1a 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -155,7 +155,7 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 		cl_info->pcc_comm_addr = ioremap(pcc_chan->shmem_base_addr,
 						 pcc_chan->shmem_size);
 		if (!cl_info->pcc_comm_addr) {
-			dev_err(dev, "Failed to ioremap PCC communication region for channel-%d.\n",
+			dev_err(dev, "Failed to ioremap PCC communication region for channel-%u.\n",
 				hdev->chan_id);
 			rc = -ENOMEM;
 			goto err_mbx_channel_free;
@@ -1097,7 +1097,7 @@ static int hccs_create_hccs_dir(struct hccs_dev *hdev,
 	int ret;
 
 	ret = kobject_init_and_add(&port->kobj, &hccs_port_type,
-				   &die->kobj, "hccs%d", port->port_id);
+				   &die->kobj, "hccs%u", port->port_id);
 	if (ret) {
 		kobject_put(&port->kobj);
 		return ret;
@@ -1115,7 +1115,7 @@ static int hccs_create_die_dir(struct hccs_dev *hdev,
 	u16 i;
 
 	ret = kobject_init_and_add(&die->kobj, &hccs_die_type,
-				   &chip->kobj, "die%d", die->die_id);
+				   &chip->kobj, "die%u", die->die_id);
 	if (ret) {
 		kobject_put(&die->kobj);
 		return ret;
@@ -1125,7 +1125,7 @@ static int hccs_create_die_dir(struct hccs_dev *hdev,
 		port = &die->ports[i];
 		ret = hccs_create_hccs_dir(hdev, die, port);
 		if (ret) {
-			dev_err(hdev->dev, "create hccs%d dir failed.\n",
+			dev_err(hdev->dev, "create hccs%u dir failed.\n",
 				port->port_id);
 			goto err;
 		}
@@ -1147,7 +1147,7 @@ static int hccs_create_chip_dir(struct hccs_dev *hdev,
 	u16 id;
 
 	ret = kobject_init_and_add(&chip->kobj, &hccs_chip_type,
-				   &hdev->dev->kobj, "chip%d", chip->chip_id);
+				   &hdev->dev->kobj, "chip%u", chip->chip_id);
 	if (ret) {
 		kobject_put(&chip->kobj);
 		return ret;
@@ -1178,7 +1178,7 @@ static int hccs_create_topo_dirs(struct hccs_dev *hdev)
 		chip = &hdev->chips[id];
 		ret = hccs_create_chip_dir(hdev, chip);
 		if (ret) {
-			dev_err(hdev->dev, "init chip%d dir failed!\n", id);
+			dev_err(hdev->dev, "init chip%u dir failed!\n", id);
 			goto err;
 		}
 	}
-- 
2.33.0

