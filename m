Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882A47973EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbjIGPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245404AbjIGP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835EE45;
        Thu,  7 Sep 2023 08:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acWTaVculGuQlTXdM9SOlP78ulqOohCYuy7bqc3TB+AJC0sRs4mfTE2eVzG4f7/LJtBy8DcvoNuNBkcTLetcwbIzO6Z6LbOFv7/dVrtitwTWzJ0bPS3frrUcox5etGMGmvzZP1U3XJaWTvTWoVeulSeT7cS6HwBbg25PmZ3VOse8xFT38NEq3d8gmG0Xxf8WnQY1v3/pRV8vZ4r3+hvaYpW4UneDOcgJp+ww5j1MCT/KuufV+m9UaOFCtAnvIEk8F6I4DM1gNSeFWEu0TR9ukeZ9sAqan+6lMidvj0vbDPSOSrbJmC+XFsqhAGG1BsHlJQznMbeSDcl7DJGQWxrUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faOjCBJdWQfJRX8G8ytuAi5eQKQYP3K28p5x6ojyXHc=;
 b=eZOuaRIo+/tfOJGckC5mbhIJkeCCTgIW6RVIs0MaOkzP4ynqTXdVtfgYrkc/R6mwSHdAT8K0ZFy1Gmot+tDlWyPXNXvQoUBQQSyEw4L5ynGUB7Eqp/mGelq1emr7HbH8EICk8ft/h3w3JEdGlbaG2hoBKJEWxANnZzGeVCVh8xYZMYOwXH8qQ2s3BQJU0LfUDXWvCrejG42Np+s16YS1P6Vpjnjmx+4IauMy8KhhW9iVqfy9Pu5X2JmH+SYTBmcyF2Mcts+RxlVvfdyF6XoIbCUO9slVVSLwL8FfbwMyCTdz77/ftu9h9NkgTLdcdpn5ZHXN8k058cqGGFnh1F+sRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faOjCBJdWQfJRX8G8ytuAi5eQKQYP3K28p5x6ojyXHc=;
 b=kiU/8vOK8GnORMUhgA3UNGCMS19GXl12YSYi1KlCSw4nnmvqM5zYfsuTbBJnc44vj9k0tzj/0KtdjR0x1+Dygv5aeYOmhG5y40dr2QP3wOp7xDM+EFX/EyM306tyEVIPr+T5ytPufYrvPDCq9Yl6Ad5foskA73+lzeL98YFPMltKE0PokNmKdxINuvVf+xSRD3YX4d2/fRQdMzeZws3Zm1fsKfx4XFRdYez7LDztjvZ3HfNnAC3EEbof/Hfsy9YkW6TcjRf7M4heQjQjmykP/JXoC27fDga9DQ6Q81eWcEji8RhnLrBJMsZYQAYQZtUmx7raAI18vDFcIwNAMn2EHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by PSAPR06MB4229.apcprd06.prod.outlook.com (2603:1096:301:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 09:46:13 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 09:46:13 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bean Huo <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH 3/3] scsi: ufs: core: Add exception event handler to implicitly handle WB buffer resize event
Date:   Thu,  7 Sep 2023 17:44:29 +0800
Message-Id: <20230907094517.1961-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::6) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|PSAPR06MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7590d609-cc58-4c8b-7f5b-08dbaf8745a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MD4sFbh31m0SAOtFJAsOpSUQ/KRrQMNcNnmWvaJoe8lIWjyY4dQiQRI8qrY8o34fT42/jI5a8kAs2voHichuqO4ltQ4DG15xHdolIBtKSPtFmI4ucqSIpCEWwGtbqFkdB59O8H0MnuPJ7gAVglgq8ei5Qafz1vj1m5NvAn4XZsJXogqncJowbpmhYom5CY6WZVVPso6bSRuuvUf/SmlbpJvBLVIsXM6Q1EGr2Pt/2FRWJsYOD4BzBM0H8iEUnpu1cdz3mQNEFYCsd1FZ1ztczfqS0Uv+k1/RqcwhXe9kMd21VXX5GFZAXvsY/0qyt0ZC3bJMCP9e0HwoYYckI+kxDLUeTobJsNN/vroZoCti7uTw8X5zgYmLivSuCgc5sDvNNWsD4Mpgb1/TBw/9D2oLpiaW+iWir/KJRvj8iXY01zii95pqH44tcbWJtNBd2/1QUkXIBKeu5B09c4VdPfoG//rR6dSm9rFOrcIaTGLduBdFAHNukQBkC67syq+FlSkd1oZQ5v7gpSE9ZjVun6ZxO8UENQArpeI0UZ1RJEntEL7DU2UdePmC7qDXZbcB88SEDhzq8vRP7f0EGUPCmQ9sxj7uxlmp0PLn9KPl3cPZs4DrGCqGN6NF3q14k21Qukv3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(136003)(396003)(366004)(451199024)(186009)(1800799009)(36756003)(38100700002)(38350700002)(921005)(86362001)(52116002)(6486002)(6666004)(6506007)(478600001)(5660300002)(110136005)(66556008)(4326008)(8936002)(8676002)(2906002)(66946007)(6512007)(83380400001)(316002)(66476007)(7416002)(41300700001)(26005)(2616005)(1076003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bEXR00uv+1/LWiwVrBHgEv36EIPjLFc3oyIhgLxNzbnRt9nOneotovXwN8nL?=
 =?us-ascii?Q?eR1vfX+lY3mfeKP9KpkChTjOSHeflQHfCXIyCAVF1kNp5EYvXIO7PVl09Xq1?=
 =?us-ascii?Q?xwlMg0l1uv8eEytQi5UGkhtXMNN6qGMGTj1VappapSdTLIfU6pOcFXRf686A?=
 =?us-ascii?Q?GWWXoiVf+zl0gU8CQrq/e439xbi4ETDERAQD0ryEM2xjiZusNeiOYofTJHnN?=
 =?us-ascii?Q?Zhzz978Jmd16hl/JY6tKcj5SxPLzhA3nWgNGUV+MUQSxDuRaLi3fqFkxMTbU?=
 =?us-ascii?Q?UwN1hHOSdldX1mtBiFOLb5DO9QJDCDfJNVIcbGoCxcSKrXIlMPnMefGntABP?=
 =?us-ascii?Q?LNFQrXDdyxGi9jYCMmFD/vLLcS9sJNw7gZWig/7zkSzjW8a/SsJKsf/vWh/+?=
 =?us-ascii?Q?r/b0aBur1t7R66E0obfYWcyQid4MljBeb6GUCdlNnb5L1mOp1WHfVRqQQxss?=
 =?us-ascii?Q?UgECkUOIbZvsWd3vRH9iqsfX+Ynfpm94UvtoFMXFtNIkWOxtn4hS0lVJehc5?=
 =?us-ascii?Q?ZkxO3K5lxbN5xiinqlXJ+tm/ajI5H27+ELJ5R5qHQsl8ZURnSKaNVaX1f4Yt?=
 =?us-ascii?Q?tT+Z9l+zwfTCqg/XotZ/JplWGtFwcS4/aIwMJBpr4sNgPX2MnoZvjkpgj0wV?=
 =?us-ascii?Q?7+hiyMB/zB3HF/dzjNZvsaQwp6na0aKrzjXMylZxNAVbnidMvEcXSUgIWhkE?=
 =?us-ascii?Q?/QO3SotwPAwWtpJl+SRUvpliivtOWmVl6ndolQQHX0J8A2G8Lv35kdC04pFR?=
 =?us-ascii?Q?3hi/V8vTae8scQC/TyJDDs8dZBlewyESdWKx92mNe04WV0ypyz1A5UxI8rHN?=
 =?us-ascii?Q?0G+2ve+IaH0hcmqbaGFNdI7vNx3Vm+iQewjUMnBrbsUg25nMTUL9ulBkbW/l?=
 =?us-ascii?Q?xNWYczPIUVC4nZO76cphvEUdkGOeSxSXI5R41BXp+UMNf2axAPN0O91+lsbr?=
 =?us-ascii?Q?OXRmZ+Yw/yWcP0+uxeitbWdTdyOvNtPkdGtg3ihL9yI0Xi0Pq+ZvsPCPHvpz?=
 =?us-ascii?Q?C6fKS1rXzTf6f53NxjPl0INEKnyCNpZVQ95BhNZ30Yu98vrb6AcSz4Pasgwq?=
 =?us-ascii?Q?e8r7LOQnV5ihOy5XyXvHSpmD2/3WedvOza4NHzXWW3NUhRy3768X3pQTT/+h?=
 =?us-ascii?Q?G1EFSBifHqVjdV/xDFJcGsrMF6NawAJnUM4ivuSIUvf1x7glMiKPKc149W5S?=
 =?us-ascii?Q?RHj1CHss7/XHivdJHefGGTDzUe4kZODooegnqRZ501OpeJ1jSnPVv+YfQZkC?=
 =?us-ascii?Q?qo9C0qP/rUNGI4TVOKQSESjQ6y3KevoZITTnQGOQUmUkQkfR4tnqVpxom4l7?=
 =?us-ascii?Q?sv3w8b1PwBnALPvoFox90hchQHTpifFmcn8YsQ5k/aOJyY65OaP0wRRyZfHk?=
 =?us-ascii?Q?kSCq7sstMUqGAiU4QwoeYUu1ymZAddU0dhABCNtnLEVERmLUEz907PkfVZY2?=
 =?us-ascii?Q?4JXbHBhSfksuOhLjj+JmBpk7VZoO5fzU7ZE0/xfNtjCARJAK3kyHBTrXfJpm?=
 =?us-ascii?Q?tskfAIFtpb3U1oNNgh8ir+eIG8QJD9g3SIKkvivcMHjROCQJmY5GTOpxKGuc?=
 =?us-ascii?Q?7tryn5I05/4VVltq1RgbVJ4f7JyrC+XUw7rPO9OK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7590d609-cc58-4c8b-7f5b-08dbaf8745a2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 09:46:12.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oflF5XROjI5TAFXgmn1ArbLw/7NsFCi61TI5glhdgcCZ9RhdDbOryAHzwkyidBgseBtd0/kqXqwolF/7B0UYUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4229
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

