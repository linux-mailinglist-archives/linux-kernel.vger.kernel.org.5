Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2198479A339
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjIKGDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIKGDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:03:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA71BCCA;
        Sun, 10 Sep 2023 23:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd1ZHP+kvQBcybqhsdI2o1cIrY5CKQAhbf4YaIAru/6+exUFg7lxSDbSwizY6tADQJs5wORb4v2T4p2+dGWylqkz310YCMnIQ5Eidw8yEmf2mid9qdbWwqjXbTLvIo3fz275YFeYMSIBdtxh27I9jS7tu8IOkTzoizHeqR33GaLQ+ao/J9mR6ZTCGhk5UvGUfB6R5xB0SojPlLunN20p/E05uyEZFNEn0Edvu47j7Wpm1zINU+Y255E8H4Kija2rRNuIuqxzRtnjiwlJHzka6SluAleGtkGAu4/bFX/rSx2YhjB0/wI+fV8NDUwHuwF8AUDMNS9bERDU0FhfhbpxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7Dj6MV8nNkR1UwpIiC2lqwGABf+zapLZechNgC9OU0=;
 b=W3rBzst0F4iy7Yu2D53arJHnIvpV5vQDZf8Ocd1hi4DeegOxdJxVkXuI2s6ZPF7jbQ6CGryOVGHkGEMvX1TnTCI/JOHiD7Ve/1Dd3zOYmtujSP9ioriH3BlNJyom/VTWpBM1nwxZ6ZJtlGOkBqUEyKadnotJDJa3/+tpO1QpzinGLxAfRuLdHEGRtZkJkpdw8Zh3ZDxPlnzS1bGc9AymbS84p5qOR2cuC+wViiRtHpEWjHNk3uJZiDQ9fJsl10qMoNza3HmQbY9L2SKK7UZgo6j7fU8V8ysjT0RtzNRZ0pExM7SshxXJo7cEZrQdVGFBOm9DGDXxNIfBX+U7yjz8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7Dj6MV8nNkR1UwpIiC2lqwGABf+zapLZechNgC9OU0=;
 b=UuRhQ8H4B3neongWRGGxh46e7gsTA+3Cw/Exk+yCpS7dI+xYvjX2KgrANzqXSXG4lCiuUp+JXV18noa642noGnyBlLPwhHjPD1vu8HxwCQCKWfc5wf38We1JtY67f18RQ5AeqyATutlztGVBo2+muoSxTf5FURMYBC6bhczRIFOyt3x7ZUWffP598JZ5b8vPreSpni0lmMxBxfQFh58YS/4C2ldspdzifaKvFwzYisPNWjHUnWUS4EG46F1veFKvkfg7ArmjzkPmiATAd7E0yOXchbooH/jmC3bDx1n96bJEPkGkBKA1DKhgSyA9Jx7kJ3FbE6ZuFc8w+J8yO1xH3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB5645.apcprd06.prod.outlook.com (2603:1096:101:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Mon, 11 Sep
 2023 06:02:13 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 06:02:12 +0000
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
Subject: [PATCH v3 3/3] scsi: ufs: core: Add sysfs attributes to get the hint information and status of WB buffer resize
Date:   Mon, 11 Sep 2023 13:57:08 +0800
Message-Id: <20230911055810.879-4-luhongfei@vivo.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEYPR06MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f983df7-6569-4a2b-58ce-08dbb28ca415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyDfhisxoLncAJZSjxdCoXN5nBppd+COQ0u4jqQdKvskga0wlncKusuzgKimj73KkikwbAA5h6JxGK9LHCO8Vh+7xRZe+6hA9rpq4q1pk7qcv+Pd/4Q3LVyvzyEyghk7pFwyCSxCLDFdGkkIuSKALCDQ25FLfJD6mNuxh7wn7463G5HKBu2GP4u7cDXIDD7cx4V54oAbnahhynY3NS+mZ7jto58/3/jRAD+1rbfOBiy2tLRpmzVPHUQLseImGuun1svOcMvCg3b1gGqqusT4k7YIQ2dVD91/lw3m/DRxPRmsVvmHxMG6hZYjAypYhIxFunlhNCWOcSjNFRG0+pmmC9yyU6D0MO89dqcTBCgOpZSsJph2Z/H/M8tT7TkEC6la7nlJa5iFKKmYQBQ3esSl/5hkLUxY+jzJCIuVUEtIGJ3M5YjhYGM8gF30ahrklTx0L4r6aZpuKTQXz8hw8N9Y3slzkMr6GDLl8jiZgq8z2J8im/SCTM/nDhp0mABBhbXJKGlDpOTWjj8D6jrjj4FatoCboj2vo3pSaLoVpGSXekCXKijzWtgX1sbaDx2WAQHbbPtfoZiNmFkS6OvMfuFsAhVVlOitZbfQnthUf6i2q4Kjc21vEBthLXTIk/17dEG4xSZeE9Cg5zu8hpW10ByTY94fTqv5mFzWBaZACU/dFBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(2616005)(1076003)(36756003)(107886003)(41300700001)(6486002)(86362001)(6512007)(26005)(83380400001)(6506007)(52116002)(6666004)(921005)(4326008)(5660300002)(66476007)(66946007)(66556008)(316002)(7416002)(110136005)(8936002)(2906002)(38100700002)(38350700002)(478600001)(8676002)(15583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGg05Jzwza/XAbnlREVDF2tTGP554Mvd2TvUKb+wyAb9NAEZDuo+j3OkAj5S?=
 =?us-ascii?Q?HyXM6iao3FGtk4L8m/1Wda+7X37/NgL+tLkEt57YtRbGr6y/fOqbZa2Oo8hJ?=
 =?us-ascii?Q?cVvnoPLWVe7JG8TMOAt2SIwSIOQhzWKSqsfxfxOEpsrXqMtycOCEe/mnHkix?=
 =?us-ascii?Q?JHI8XBTsnaYl5bT7KW+mxxNcyxmPi2Q+2qewpquSeFVarSpDXTcWFQuoLeFl?=
 =?us-ascii?Q?t+BSobFLIhplaK6QW07W+UlY2LUCixbbvWSXRTDdKmNfnB3e5yUOgXYA1MxQ?=
 =?us-ascii?Q?aSytLcaRRfA5KGVMWVPNIhWcSugwAfvAZuxZBwHZyBX+BI6U8Az+UCO9XLxe?=
 =?us-ascii?Q?l7YGhtLZrVPP8rQ6iPdIA3mQgcbXNZvBHJcpv+tmN2V02DfLPiB8oWmRWI1y?=
 =?us-ascii?Q?yzal0XFzzy3vJfLAKS/2lGRj5ZH/EDgWgPNEMsMvDoqVg0xM+yHRy2HEEgFS?=
 =?us-ascii?Q?m+yQYc7n/MeyYYJXTwTuhtoRYIgS89ixrwYqVF2UxFuejrxa65wDmQbZAe8d?=
 =?us-ascii?Q?X19plveQFbttLDxkMYNWZw/nYLyupzcF90I+dd8tfqUofvj49wQc20gt8MGW?=
 =?us-ascii?Q?HGYWfR5/diVaXNZTkXULZT30jNOMPLqn28CTCmd9yz20hKGhgESPujl8vDKf?=
 =?us-ascii?Q?h+TOvFCCpZYrDpychhm2C1GOPq67y6pgESf1+S6ocT0ZmmHrqjct0/eYl4U5?=
 =?us-ascii?Q?UondgjlJKvYWOuUw3wwzAE2XlQyKQdDWKGCo2Y5f5rTpyiofBh3BATTRACRo?=
 =?us-ascii?Q?W1WP8IkRHsWBJOe3KAKjsQicwebf0dzMWXRhZjNPheoHAukdc//xiLls06M0?=
 =?us-ascii?Q?mwOBMYpNKXoHvIzZgO2p8Pt6aMK/F4MLv1ZpXLStOY3ihRLpAJIC8A71njrz?=
 =?us-ascii?Q?MLOwRBZeVdiWeeqGFmQTgZ5BAYQmIsVzWAOiPdGeXxEBb1VJQxAzw9MGRJR2?=
 =?us-ascii?Q?j4nExU2qkliF0gQNpxNKlTcpJbJXoes2T55r+oc/GwJx0gYvmjdB6D8Phdab?=
 =?us-ascii?Q?TBYC23nZGwG5FxX5BcdlPSCOdrKFUUbfpSNJ1Y6+5f8F3oN+j+B8IjFM8D+A?=
 =?us-ascii?Q?3uvUgk+EtP18rP0kw22GFl5LsU29keSQiW1Gx2ul6GAXztwFIlaWdyuIB1Xd?=
 =?us-ascii?Q?nCCdSUzY8lFR7+2JvUnwrZZxGpodCMLO9J9XcUgb0W3XHEIy6oJqzJtqSE1k?=
 =?us-ascii?Q?AJ0Sli9fbcP+y+PrnoC8rT6xNKLVLmBQGe9Zv2rrP/zofnewnqaF38fqUaP5?=
 =?us-ascii?Q?rDNrvIX2af2lC4RAYydkbTIXVrwXly+wRXX0IVv1A1oe/OpDvllBmwihcgjG?=
 =?us-ascii?Q?X0is3NTQanJX/MZqUA1+8POmEthPAlpuoZGOzMuzQah6EqYHRyKU2k970AoX?=
 =?us-ascii?Q?vR7c5Pc5ytW3xfe9R3YzbRHV04cZHlzlj6+q1QGAwbed8cB/K1khhiGGE3Wb?=
 =?us-ascii?Q?PV6bIJD2MlKYZLX4rfyRAMbRGAyTaPVATz9ZBy3FNWytjXYJ0m+CnOZsS59N?=
 =?us-ascii?Q?vH0zdnmEuSMYGU/lpXeoR23g41pI+7DdZxrwB3PbBe4KRVsKpRCBGSRV4U93?=
 =?us-ascii?Q?a0QSOmpSGWWmmLu8VE5YsnQfuTZsuv5f+4pA3YMB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f983df7-6569-4a2b-58ce-08dbb28ca415
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 06:02:12.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpahU8NAtvsmxVdAVYRhxDfObr0/lZho1oTq09DqO8DY5DoT4teFGPqH/tv0tzhq7J437bHXLEeQtaUQd0Erow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host can get the hint information and status of WB buffer resize
through sysfs. To achieve this goal, two sysfs nodes have been added:
    1. wb_buf_resize_hint
    2. wb_buf_resize_status

The host can read wb_buf_resize_hint, obtain the hint information about
which type of resize for wb buffer, and enable wb buffer resize based on
the hint information. Considering that this process may take a long time,
the host can confirm the resize status by reading wb_buf_resize_status.

The detailed definition of the two nodes can be found in the sysfs
documentation.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 35 ++++++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 38 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index b8bd7e844cb0..4b03f4b8cd49 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1454,6 +1454,41 @@ Description:
 
 		The file is write only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_resize_hint
+What:		/sys/bus/platform/devices/*.ufs/wb_buf_resize_hint
+Date:		Sept 2023
+Contact:	Lu Hongfei <luhongfei@vivo.com>
+Description:
+		wb_buf_resize_hint indicates hint information about which type of resize for
+		WriteBooster Buffer is recommended by the device.
+
+		======  ======================================
+		   00h  Recommend keep the buffer size
+		   01h  Recommend to decrease the buffer size
+		   02h  Recommend to increase the buffer size
+		Others: Reserved
+		======  ======================================
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_resize_status
+What:		/sys/bus/platform/devices/*.ufs/wb_buf_resize_status
+Date:		Sept 2023
+Contact:	Lu Hongfei <luhongfei@vivo.com>
+Description:
+		The host can check the Resize operation status of the WriteBooster Buffer
+		by reading this file.
+
+		======  ========================================
+		   00h  Idle (resize operation is not issued)
+		   01h  Resize operation in progress
+		   02h  Resize operation completed successfully
+		   03h  Resize operation general failure
+		Others  Reserved
+		======  ========================================
+
+		The file is read only.
+
 Contact:	Daniil Lunev <dlunev@chromium.org>
 What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/
 What:		/sys/bus/platform/devices/*.ufs/capabilities/
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c14da6770316..e416b9802ad3 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -359,6 +359,40 @@ static ssize_t wb_buf_resize_control_store(struct device *dev,
 	return count;
 }
 
+static ssize_t wb_buf_resize_hint_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 value;
+	u8 index = ufshcd_wb_get_query_index(hba);
+
+	if (ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT, index, 0, &value)) {
+		dev_err(hba->dev, "Read WB Buffer Resize Hint info failed\n");
+		return  -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", value);
+}
+
+static ssize_t wb_buf_resize_status_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 value;
+	u8 index = ufshcd_wb_get_query_index(hba);
+
+	if (ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_WB_BUF_RESIZE_STATUS, index, 0, &value)) {
+		dev_err(hba->dev, "Read WB Buffer Resize Status info failed\n");
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", value);
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -370,6 +404,8 @@ static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
 static DEVICE_ATTR_WO(wb_buf_resize_control);
+static DEVICE_ATTR_RO(wb_buf_resize_hint);
+static DEVICE_ATTR_RO(wb_buf_resize_status);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -383,6 +419,8 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_enable_wb_buf_flush.attr,
 	&dev_attr_wb_flush_threshold.attr,
 	&dev_attr_wb_buf_resize_control.attr,
+	&dev_attr_wb_buf_resize_hint.attr,
+	&dev_attr_wb_buf_resize_status.attr,
 	NULL
 };
 
-- 
2.39.0

