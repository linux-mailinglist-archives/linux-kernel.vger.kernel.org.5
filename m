Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E55179A321
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjIKGA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIKGAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:00:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF3399;
        Sun, 10 Sep 2023 23:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CILRjZVoXfDmRXLB7/i5vXWUrkhTmrmXnCuht2UcY6tfVSpWRe+kMU46npN1ifGe2TjWLK8mP7Ko8Q2y9UbJAlK7sS6WPG7Vx4zz2yhlWuk/08rh/u/LUiwhxyO+Brzlv1Z1530qmL9nAn0S9bAl3mkPlIkxGfNHLPY1XZdsXt9XpbAsCSxv2HN01k2+mhD3cq+G55kPrwtsMxtmNivfer6HVWb685XwraVnM+fxxucVpmL2IWr4BIRdoINslpq0DTW5KF7zgfjVnquJ5NFv/6o86yAuKG8t7ey5hBt/rbOnmp6jo724Uc+coicqLAkEskA9k8CFQub2GNu44V4jZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJRKVmiD0MtObERPLQU2hd/h+fysb0CHXX2/ZLZAnLc=;
 b=W8bbMkvOwKudG+xn+YPDhlJXRPAEUrPhmMmW4+6eVaUrfte75GyMYkVcJbMqq8J8B3gBlhtAkkU9Kz6Pz/QIj6h6rTwNefvNMPIpxsj/A+E7B+lTvgmcjNg9rUAflnqeB3WTfzXgrR8wNfJTt5/VZn/Ig6fkGikXVlRys27PkEfT/2RMdvt3b6uodf6tAeb1yIG0OzuXEI3h81fjROSN/x31gziL0sX+3rPGJ8S99LY+LrDGiZ2uStcy2kFBuq0YQtQ7efKO7lFRmXvpxp8wD91kcpbHVsOEXqtEt8quBORfsH8ikmLOa6f76c8A1HsXt6S1IlOqDlR52WNmUpViKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJRKVmiD0MtObERPLQU2hd/h+fysb0CHXX2/ZLZAnLc=;
 b=Wjt2PT/iG92efqVz2qf2xoBIhGAuuSQ+pH7JE+frzzldgw8DoWFSuZvxIumY6kGpy5c9889Fsn1OzwM40R9rnCFKfDJAQq5dmi61d+AUtG7/ThBFir+6m0lt+J/stsJ4H3AK58ifmnbKqN73Bzyn9n8POhNvefQpWsMr8HuIP2y7qeC+Hbx95k9kt3iID9aj4yiKV1d//j0p1Wk8w/+v1zg7U5QSCiooQhFAgpWojh0kRYkGu5qwqc/RtFIZrQw+kQjPy+vTq6/kbMD4gVARoWkXCo68cogOYnQ+KMPrXMYhYvMxqWjNlkITRu+V5gh5Z0Mpqm0danDsLTBNymc9uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB5170.apcprd06.prod.outlook.com (2603:1096:4:1bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 06:00:09 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 06:00:09 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lu Hongfei <luhongfei@vivo.com>, Bean Huo <beanhuo@micron.com>,
        Can Guo <quic_cang@quicinc.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v3 2/3] scsi: ufs: core: Add sysfs attribute to control WB buffer resize function
Date:   Mon, 11 Sep 2023 13:57:07 +0800
Message-Id: <20230911055810.879-3-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20230911055810.879-1-luhongfei@vivo.com>
References: <20230911055810.879-1-luhongfei@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f5e34d-4ee8-4c7f-73b1-08dbb28c5ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsRbbuPrkK0A1ozbjeAdmeGRcXeromwugAW8DXI6WBiIvUUD8edT+3c/KI7uJd3Zmc7PAWvKUsPMdGVsQfsg5oXyxzpKYqxtWbH7USICz3U8oz/nLdahx4k2lhYEhgn2H6TxdzjhT25ogY9lImwFHjILqBDEJcss7+gfKtjbtZ85OwiM7O/lQDnRA0w2ws7Y6aYX9aEpm9IOLLbBDB+Z16VBbRUKb+TlfmDB+KoKJ3k0HlYUN/1phkeet5qPKakZV35T2YgPRpjvWC2Mkq4xUYNP1RyiI1W3XGtphiKdAs1I2NyqEXkGUpZxY/kbkRqPiAsBkB2pe5gijuTBDIOX09pMN3QaEFTvM9ztYPq/xmujNb0uqr2WIUC4Cx/zYZ10LkmY789nJnQi8oxjVoRwB+qN5wqGqyYmjljyIoHyU14GgFKuV6Rqi3jHA4YtZ/KHFk2rrV9xJtvXID951aBOf9baa1I/zcKI9VZpBkRRv5rg1LPQ4UEHYStx+eRAedzv6/8tujgdaOuiNQ0kkHwzDxl2YvdXnKbrKej1M4xeZW7bVPdpzH1Ao4eyUdYC8dzK92Ci1WPe5rrMmPn4aS2WnZqRiGUMXjDPRUESZFnMpRUQT7mTCZc5uALZzOvpYNw7tD1T/YE6WbgADwPWcw/wNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(186009)(451199024)(1800799009)(7416002)(110136005)(66946007)(66556008)(66476007)(478600001)(107886003)(5660300002)(8936002)(8676002)(6512007)(4326008)(26005)(1076003)(2616005)(83380400001)(41300700001)(316002)(2906002)(38350700002)(86362001)(38100700002)(6486002)(6506007)(52116002)(921005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KAH7qVt+/gg5BlnlU27h7taNu3SwLLQtFPq0glnPg4Ov1D4D9h+xuOlGouwc?=
 =?us-ascii?Q?GsjRa/SjBCIaI+Hp1In3fwloS3i0BCcXT7jGYOb0tOyWg7odRsXSiLDxy7nt?=
 =?us-ascii?Q?wBDOFe6yxUvrDfpBvsMe9zMRZXObiC0LjkewJcuUI8Jbv0OuWPocshG+n9D0?=
 =?us-ascii?Q?xRwtWAp31sPgmyp0Wq9dM/BLODh9ECd5E8Q8uZ9l7X0OEAuhG8nxTnaVNmFU?=
 =?us-ascii?Q?vvkC6doLIazs2TQGdnZ97JlfCbtHbggjrJNI6xKci3+nlhgqPtTDiFqiIePh?=
 =?us-ascii?Q?7NKog/y3LlOWIhf/36U5HJPaFyttMEfDVMVxuG0u4RUgpGusQQSSnBbYhpii?=
 =?us-ascii?Q?ogortj4cb66B/N/+Hqjk42z7eP3p/Q3ImgwtkAiy3yy7tzzMzEPjul/qX51G?=
 =?us-ascii?Q?jB0scju95s0mSq5v8om9S5BMHen1tA2IWkB/mwZG7q0905qLM1w/e5jQpFUn?=
 =?us-ascii?Q?84YbuDco3xUDA+iRQ9uOQuc1RwzzqQCKgx0vgGd4yeNz5HV2ameSFLKsfqYK?=
 =?us-ascii?Q?QCSuKvN9TywXTWxhc5uujwDT18V8V4rwEluo+BnP4V2YSm4G2RuiCLQzkURf?=
 =?us-ascii?Q?KvslAW9Y68rU+V2iIlP57ShD1H8LFTMMGLH8ATo2THwkzxHEYWTvyYMuJjjb?=
 =?us-ascii?Q?zGJhAw0lqCix7lrv7obL3GZstGiNzXaKSx/4KbcXXbB4vAsrUWZ3RpAvyJOu?=
 =?us-ascii?Q?XcHPiv+/+Hy46MFdT6cs1macqA4n8g+h7rAUroWk8PG7kSSgViNXpGggDnPg?=
 =?us-ascii?Q?8FZLx1mozo2XlHKT+DYfKKynIrf5A5pur2YuaCfnfMZ9TRKagz97DGTyY7rQ?=
 =?us-ascii?Q?jWImCxHkzHumZvgPHxv3P6gWntvbM+yTvU6/3uuIeQHBRcOUmr/EEInop7Tm?=
 =?us-ascii?Q?tMtew6KtTC063witf9CXLb1Px9qOCBnPXkN9P/J+PoTINJimYZNGjTG/IYVD?=
 =?us-ascii?Q?yBDPSxHD+1JxHQCnR4V5a1Kp7+4d4roaHLtwvJRVdGuIyTqpiph+CBfno22k?=
 =?us-ascii?Q?9UAFz1P/AcdjcRpb58YrL8udN7DkT/pEAqsMZRBRlgZaiKw3IUMeWhiEFgYy?=
 =?us-ascii?Q?LVECu1AzJGiwKscmgqK78VzLMXjPSHxqrOuBRezF2QFLq007nGpGVMIQ/AgQ?=
 =?us-ascii?Q?Pr0nsjb69cEdulJZpMCtiFIzhw9gXCz7ek3PrE4okmzDue9N5rbSWKoQvoa5?=
 =?us-ascii?Q?0h9BBf9E557RYrU+YFEGY6XmGV4yGRoNMT9pXuV6Mn6+Pdy3hlONPu5lLOnn?=
 =?us-ascii?Q?zIf6ivtjgdyEqw6RCWTLQm2HkGTCTA0HdVy2fY+mkrP7yrXPNR5gJ6aWaL2o?=
 =?us-ascii?Q?nq4Bw9C6lIBoNnbLJFra96eYsI7/Gj8OWZ3n8Xzlz+nff9E54Il7xoqGwjiz?=
 =?us-ascii?Q?PVsKB8DRBTNNoKF6e/uE78ilyqdZ4nYEI+oXUPhCZqDgWTBH3ghYnWfPMnxF?=
 =?us-ascii?Q?SjpETBVYljtkST8fD8RmOCdKLuve6qYe0HMNa1kO2DLHJPcbOZsMsTDaX7Ha?=
 =?us-ascii?Q?hpCyVdpNx8FTjrXmGXFP+1NkP02VoTHIfRS3UP/0i5qegZsqctdTAv1rZgcg?=
 =?us-ascii?Q?3gkgm+7cOzcY4M8OuL4VZI2SEvw8S9ioxpWaXfc2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f5e34d-4ee8-4c7f-73b1-08dbb28c5ac0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 06:00:09.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRVZIh2z4SmY83Zh4OgBq3ZBnJ9+TcpURRqGknJFeViFfJAvjqrO1geSAk19terbUZqUZFMJKYPRpzLkGx//vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wb_buf_resize_control sysfs node, which allows the host to control the
WB buffer resize function.

Add ufshcd_configure_wb_buf_resize() function which will write the
bWriteBoosterBufferResizeEn attribute to enable WB buffer resize.

The detailed definition of the this node can be found in the sysfs
documentation.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 17 ++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 32 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  | 15 ++++++++++
 include/ufs/ufshcd.h                       |  1 +
 4 files changed, 65 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 0c7efaf62de0..b8bd7e844cb0 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1437,6 +1437,23 @@ Description:
 		If avail_wb_buff < wb_flush_threshold, it indicates that WriteBooster buffer needs to
 		be flushed, otherwise it is not necessary.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_resize_control
+What:		/sys/bus/platform/devices/*.ufs/wb_buf_resize_control
+Date:		Sept 2023
+Contact:	Lu Hongfei <luhongfei@vivo.com>
+Description:
+		The host can decrease or increase the WriteBooster Buffer size by setting
+		this file.
+
+		======  ======================================
+		   00h  Idle (There is no resize operation)
+		   01h  Decrease WriteBooster Buffer Size
+		   02h  Increase WriteBooster Buffer Size
+		Others  Reserved
+		======  ======================================
+
+		The file is write only.
+
 Contact:	Daniil Lunev <dlunev@chromium.org>
 What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/
 What:		/sys/bus/platform/devices/*.ufs/capabilities/
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c95906443d5f..c14da6770316 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -329,6 +329,36 @@ static ssize_t wb_flush_threshold_store(struct device *dev,
 	return count;
 }
 
+static ssize_t wb_buf_resize_control_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int wb_buf_resize_op;
+
+	if (!ufshcd_is_wb_allowed(hba) || !hba->dev_info.wb_enabled) {
+		dev_err(dev, "The WB is not allowed or disabled!\n");
+		return -EINVAL;
+	}
+
+	if (!hba->dev_info.b_presrv_uspc_en) {
+		dev_err(dev, "The WB buf resize is not allowed!\n");
+		return -EINVAL;
+	}
+
+	if (kstrtouint(buf, 0, &wb_buf_resize_op))
+		return -EINVAL;
+
+	if (wb_buf_resize_op != 0x01 && wb_buf_resize_op != 0x02) {
+		dev_err(dev, "The operation %u is invalid!\n", wb_buf_resize_op);
+		return -EINVAL;
+	}
+
+	ufshcd_configure_wb_buf_resize(hba, wb_buf_resize_op);
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -339,6 +369,7 @@ static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
+static DEVICE_ATTR_WO(wb_buf_resize_control);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -351,6 +382,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
 	&dev_attr_wb_flush_threshold.attr,
+	&dev_attr_wb_buf_resize_control.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c2df07545f96..7a9b9d941155 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6046,6 +6046,21 @@ static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
 	return ufshcd_wb_presrv_usrspc_keep_vcc_on(hba, avail_buf);
 }
 
+int ufshcd_configure_wb_buf_resize(struct ufs_hba *hba, u32 resize_op)
+{
+	int ret;
+	u8 index;
+
+	index = ufshcd_wb_get_query_index(hba);
+	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+		QUERY_ATTR_IDN_WB_BUF_RESIZE_EN, index, 0, &resize_op);
+	if (ret)
+		dev_err(hba->dev,
+			"%s: Enable WB buf resize operation failed %d\n",
+			__func__, ret);
+	return ret;
+}
+
 static void ufshcd_rpm_dev_flush_recheck_work(struct work_struct *work)
 {
 	struct ufs_hba *hba = container_of(to_delayed_work(work),
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7d07b256e906..a2e5fddfc245 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1381,6 +1381,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 				     struct ufs_ehs *ehs_rsp, int sg_cnt,
 				     struct scatterlist *sg_list, enum dma_data_direction dir);
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
+int ufshcd_configure_wb_buf_resize(struct ufs_hba *hba, u32 resize_op);
 int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
 int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
-- 
2.39.0

