Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAAD7974F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjIGPm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjIGPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:39:18 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20730.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA02268D;
        Thu,  7 Sep 2023 08:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPBLwRZBTo1I2chT+lzT/w9JZU3jKtHNfkHFVzatVaESqVqS8m2W6GtUiaX9ebgzgWON0A6uMWFoKrbZe1AD94IjSQREweMH7hLaEz6iLbcOoLqTN72cuapYJ26Wf0xoogYxNhdv3t9wGUsPSRm58tE5jIl686RdWGlRYUGLwkcTYaTi3xH90+zAzuwifUvOxskrdclfNFJqm+L8El7rNj55sZP7zjKKwB3RenCZKNXSy4W9Rb0959/m34R/zjhAG5oe23sLuCCKgVLBht6MtXFcIUKEptL7jEPWP0fp0OXL2QsxmLpjp0xRLTjTnRGeQIOLJV6UcHh1O512CA3ifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faOjCBJdWQfJRX8G8ytuAi5eQKQYP3K28p5x6ojyXHc=;
 b=Dq51P2QWjfhwiV94pEAkgOmr2IN/56fY8GrN+AX3Pu35nEUX/h3cSiEwiWfCuTSEJKxgim8/AUKCZEWQJx3BiStcg3SzAlkdGeNjd2KS9O5FeifPG5bfa2nOvybe9VxyScBoXz/aHOLbHqsdpeXDyhfI/TrMEkahTfUilpXZPG/94UY8pOZzlRReqIadahs1aQO82ZwGKbFFQzQTHl2QwTUP1HfYorQqxHoqUZ2x2YBfhv16y7ujHDCgwwiuE1WVt1fSaHPnn7wr2AXAdTTejTpHGvZkyQI5AyYw7CNdH83DR2G86KEZoP0Yy4FfZUiBTw2XZdxu6j2k0beZFp8DMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faOjCBJdWQfJRX8G8ytuAi5eQKQYP3K28p5x6ojyXHc=;
 b=VmRiEB2oj48Cw/KTMkIYz9McQ3xdZ0b+R+x4qrBgOPsj3PSvyrdaZwKzRLcuEgD84mlXCfFgCT4t3ZaF+txg4KGLzJWKmJyQOoS+G6mDAVoNnu/MVvrqe9GyrOy2cvbcxsGXHE18KByBmdXto/WHou+NEdbomhvCFCNm/kHcKYMzGQmS15gyDVVy5u8ofEcFYk5XBZ4jKF2kkO5taGK0kQQni/fzZn/64X8O6onu2PojjJiBqs27POBN72/VBwf3gUHhB4oI6ti5L5MkDm09I8Mq2inTXDxkOCpwPYcwBdJMUiUxvHXrucaLxUFoKTPfRtQ9xBgizG8BsO6XE+2cBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEZPR06MB5342.apcprd06.prod.outlook.com (2603:1096:101:7e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 08:20:27 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 08:20:26 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH 3/3] scsi: ufs: core: Add exception event handler to implicitly handle WB buffer resize event
Date:   Thu,  7 Sep 2023 16:19:38 +0800
Message-Id: <20230907082012.1870-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEZPR06MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bc42b7-48e5-48f4-6860-08dbaf7b4a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8tCvCRxDbCTzg0o5DuZ9NzbjXLgXwkF2bgvE6+MxMXEx9EuYf4eKNgkRfERRoC86fpUXg1GGND6uTD+EgijD5LA/VVhDaSLBE1V8NKGgie6G7AExX7NuKGquuVD9MCCTK1eXh5URU9QPwO3uDFPDxfL7RVnnRjmznUPeyrwqd577z+QuY301et0OVdoH0Dd/Mnpga3ngh5Kbpb2e2yBaISMp3USEYXUFsNA2Kq1yWI3209OT+Qs+8KiVcAhQQwjYwYykqp3XiAIRzf9AGwcx6GQFrDV26BLV+xGOuKdxl8z/lilFdy6GNdb8zU96k3gNpRB28wsAKZ+ag1A9H+nUqcAEYP9lMw/pmIawiZTpn0VtGSqU10dJNIXLCPKL7myYr7v4LaMBBkI8pq+dCjiBweuUA2vw6M/64ioRMYfJO0mXbt777S4pb9hGxGz+jUM2bxelLWo0U49JrTBhkfhuaTuV20B01fqB4T43rYqEMT5EJV8vwpVCbQEF7HAfcm2f3ryb9Ku1Uk4McRe0v9100nEkStTyTB1DpA/xglmyAw4xAix7I6JnMRsYvqM0IsRjqfpvJlhlL3t1GxNcJaMG8IVLeIt9TIWwbnA0EYDknxw2y7P4EvWFVFVks0Gf4NA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(8676002)(66946007)(6506007)(6486002)(8936002)(4326008)(6666004)(7416002)(110136005)(66556008)(66476007)(5660300002)(41300700001)(478600001)(52116002)(6512007)(2906002)(316002)(1076003)(26005)(2616005)(107886003)(83380400001)(38350700002)(38100700002)(921005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wz9Nz52sNdzR1Y29YZN8K0XhgcSY0jKHRlfiwQAr/qrEeY7jdCaCVaRPtvNo?=
 =?us-ascii?Q?P00a+j4oAE7x8p7zQ09mrE22DZc0+uVQ+1PYCc76vXEISaEp2CksxKxEuFiI?=
 =?us-ascii?Q?FoY9sRPT3CJUVw+N5HpxC6lmGBD5tBGM766IBdiT1ZbMREgJTifJu64T8mfp?=
 =?us-ascii?Q?l6lw4DpmsmHciZOd46p4gklfLbJX2E/blH9SU0T1gHMB1poxKXkoWve47C2c?=
 =?us-ascii?Q?aMRRxufomyW2i/tR5rFKMvPMEUF2+9zNFqgpSuie/YYWISiuREHxy0xWZJn1?=
 =?us-ascii?Q?XAkHxqrcg8FFLIdMeJfpIXMqKDaz1unRFmNWlfUqGYjIv2xxvAQnWdoGt0/h?=
 =?us-ascii?Q?1bpmLIGuHvw0NttIyRFzQR8FS0kzOII6w7aduNCPPAAuD3QhuO1jVO31wkiw?=
 =?us-ascii?Q?sbbyh/9AVDJoFYMQMo0yQAMwUayoejUL2wCYThMKBCY9d+j3udtshGxCkrFr?=
 =?us-ascii?Q?29LiT9hpAHa8pRvr0RxSo/GMcd9f2I3Nui4kOKBrTzlofj3m2gAOSFrdOxt3?=
 =?us-ascii?Q?PBe4jJJZ7+OxEkJHfHNLkmU6qDq+kxpJ9NXRjZTWF+fvoz+65b+kiHrikNTm?=
 =?us-ascii?Q?XCIv07YrdbXgxiLFwNe35ladiLfyMQmNTL5St5f8sKbMTE1bpw1w/IOSTh3N?=
 =?us-ascii?Q?n0Kl0iOd34Ut0oABGmDiJ2BW573iwUyjKWtvNiLTm/GAHjzAJ+hb0NtohB3k?=
 =?us-ascii?Q?S2qog8IeQtishoM63TpLmyGEW1T4taGcVM7VdT9pCswKzYQCenDDQAXnp6cw?=
 =?us-ascii?Q?FfilbEooTvwVY7WaARgUwNNzmyv+Edl+GOP2Dl5rWjWDNZtfjvM+SR5qTjuA?=
 =?us-ascii?Q?q/MAwF80NqQRGRc9LYZ3VPzKRV2edviMxZ0+Hqe0vD7rDokmlLr+KPY/zJ6D?=
 =?us-ascii?Q?nxC9zir59B2HuO/JwAU7LQ2yr2lFqSVrq9/CsKWTVq4Yi1XvqzPQ5rNuc55F?=
 =?us-ascii?Q?5N0cOyXAiBDRkYHU3aU+TvoLQknN6JZb24JsE54NnRkA9CYf8fL9lVyPvxEF?=
 =?us-ascii?Q?gDhfyJdc8SlyUDtty3Mot2rLFb5dBpGzpY7GfVRoz/CpH7zpZYxbGqQpeY5K?=
 =?us-ascii?Q?N86CpTyXGidASJ/yQT5N6nlZWWPipKjk2j8ca7YBnYUeVRsWichBWif3+rtE?=
 =?us-ascii?Q?NxyjtHJEXwG+wJeaSG85UKSBJLNkqVS6CiRqjnGMpHIn+74RNu/bclkN9gee?=
 =?us-ascii?Q?eH3WxwLIZlIogeMD7SlRtZKapfJSYcYLOG52GNM0k76jlikNEeotNzxGgpft?=
 =?us-ascii?Q?pFmLz5t7vUU/xha8/0RIto87XqRuRAZONCNtQc4/iR37ZZ/plzNXoUkzxB9C?=
 =?us-ascii?Q?FsMUtfcmdI2VnaNlZQiPjtRAwmvBpD+DzcStuTqprWm7z7iuFiQRWyqiw12I?=
 =?us-ascii?Q?GQK2wB69jg8cnD/acf5EmZCXaeJr2gY5x91VNhN0DXAMbmLvVt5plhwg2+o/?=
 =?us-ascii?Q?xj4KwtffDDDErrgdGsVvkCcaZkbcNZNwt1wsISCP5sZD5jc6g8idZbzZgdog?=
 =?us-ascii?Q?9EAoS5X7kfDfrU/Ga4PE8jd+1uEbqBPJuYZvZXAR2LKO40vyv4cA76Vqq6Yr?=
 =?us-ascii?Q?VLJDoUR5zptX/ie0dj6s3YTgQPV0H5PQZDjDqK0m?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bc42b7-48e5-48f4-6860-08dbaf7b4a53
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 08:20:26.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zzzX0OQbuMEbo0/gs9Qnu9qujotidYeCYdmkosk3wm097XaJ9EI1R+C0CJodTOY3k2UIc1G39NOLkat2oRJMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WRITEBOOSTER_RESIZE_HINT event mechanism is enabled by
setting the WRITEBOOSTER_RESIZE_HINT_EN bit of the
wExceptionEventControl attribute.

The pre-conditions for enabling it include:
    1. WB enable
    2. Wb is in preserving user space mode
    3. UFS version not less than 4.1
    4. Host driver allows it to be opened

After enabled, when there is a recommendation about resize
for the WB Buffer, the device inform the host by the
WRITEBOOSTER_RESIZE_HINT exception mechanism.

Host driver will call ufshcd_wb_resize_exception_event_handler
to handle the exception event.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/ufs/core/ufshcd.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 mode change 100644 => 100755 drivers/ufs/core/ufshcd.c

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c2df07545f96..f15d14c46789
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -306,6 +306,8 @@ static inline void ufshcd_disable_irq(struct ufs_hba *hba)
 
 static void ufshcd_configure_wb(struct ufs_hba *hba)
 {
+	u16 mask = 0;
+
 	if (!ufshcd_is_wb_allowed(hba))
 		return;
 
@@ -315,6 +317,14 @@ static void ufshcd_configure_wb(struct ufs_hba *hba)
 
 	if (ufshcd_is_wb_buf_flush_allowed(hba))
 		ufshcd_wb_toggle_buf_flush(hba, true);
+
+	/* Enable the WRITEBOOSTER_RESIZE_HINT exception mechanism. */
+	if (hba->dev_info->wspecversion >= 0x410
+	    && hba->dev_info->b_presrv_uspc_en
+	    && ufshcd_is_wb_buf_resize_allowed(hba)) {
+		mask |= MASK_EE_WRITEBOOSTER_RESIZE_HINT;
+		ufshcd_enable_ee(hba, mask);
+	}
 }
 
 static void ufshcd_scsi_unblock_requests(struct ufs_hba *hba)
@@ -5868,6 +5878,34 @@ static void ufshcd_temp_exception_event_handler(struct ufs_hba *hba, u16 status)
 	 */
 }
 
+static void ufshcd_wb_resize_exception_event_handler(struct ufs_hba *hba, u16 status)
+{
+	u32 value;
+	int err;
+
+	if (!(status | MASK_EE_WRITEBOOSTER_RESIZE_HINT))
+		return;
+
+	if (ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT, 0, 0, &value))
+		return;
+
+	dev_info(hba->dev, "WB Buffer Resize Hint info %u\n", value);
+	if (value != 0x01 && value != 0x02)
+		return;
+
+	if (ufshcd_wait_for_doorbell_clr(hba, 1 * USEC_PER_SEC))
+		return;
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+		QUERY_ATTR_IDN_WB_BUF_RESIZE_EN, 0, 0, &value);
+
+	if (err) {
+		dev_err(hba->dev, "Issue %s WB buffer size cmd failed\n",
+				value == 0x01 ? "Decrease" : "Increase");
+	}
+}
+
 static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn idn)
 {
 	u8 index;
@@ -6091,6 +6129,9 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 	if (status & hba->ee_drv_mask & MASK_EE_URGENT_TEMP)
 		ufshcd_temp_exception_event_handler(hba, status);
 
+	if (status & hba->ee_drv_mask & MASK_EE_WRITEBOOSTER_RESIZE_HINT)
+		ufshcd_wb_resize_exception_event_handler(hba, status);
+
 	ufs_debugfs_exception_event(hba, status);
 out:
 	ufshcd_scsi_unblock_requests(hba);
-- 
2.39.0

