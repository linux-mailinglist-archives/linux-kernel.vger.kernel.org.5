Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7182A7519E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGMH1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjGMH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:27:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC1269F;
        Thu, 13 Jul 2023 00:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8PkLW5GMEJ7RCABPDGrlmG1lndjDJ5pBTj6l+NNf86JoHlrrDJjfo4pkmAaz1si123CFQj8fsA1eAoF3Bud3yWuMkmuNeJMq0P2tbzwuVm3PtUc8YxC2w01vB87Jzmnm8wmSJ+h+IC+vOKH8OEz/ltC9OC1b5VFPg/KzQr9HJn+3O75/x0OJvZ+XLUfPVb4Kym8NAMlL6wo7W1i560fuCo+IdmtBwhoxWSyy/Of3GvArkLIbTPFyX/wasv+wqLifJwgez7+012oQ2qsUM2wPZ3RngnZPpauwTmNcQ6DK0Q2U50sJ4zZnAZsMTGXGy8P2ulz3Oo3Cq982gj4MjfXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxYzMH8N+1wKBiO/yJc9X/mhXJnA92XlG4e/hqDIl3c=;
 b=YsHU/MUSj2jbncOsCy3XOEvyjkvy5KjIMetvxeFL2/FMLyTWMeR7V0NUkDN0jCbwbk8b85jRR9sLUMpUctO61OctqwIiPwvq5PxNo7mktgs0iXi6eSgbapzIC31WsQ5MIaOCGFxYW9vqCnFqvm81fnDefmiWazc0XS83tORB3J8zgag9riwDQLmkFyA4IoEColYdUqolck5ZyZzmuo+fj/m0r6oWHBp8qGcShCU45AIm1vSmPN/ys4kmpdcSHTN8CpZv6zdO25s9l5tOyYTAlWVo8aN2MghDFFgeAxqzjA9twQF9jNgEaq1ljknd/KDrbtba80ONOHQ4gSPzd7KTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxYzMH8N+1wKBiO/yJc9X/mhXJnA92XlG4e/hqDIl3c=;
 b=j64kGn5Nz/h4iuP5lc5yCgFUaDanM/sExN0Tmcqx9dGsRtVdAw9qXQXsG4PgQbdLqaLg15ObFpbawWKXvE8R3rp/ytA69LQA1oR4VcLOWtDrqkFBwV6xmb6brsdhZ4wK3hqup+xiC9Dr0n4nT+5NVZSYR9YRHUtC8UnFMehqkmO4KRJrwbBZIP6WlH/XP7VZqBCYFa9ozn4xvLyaAmmFMiU+JLvUEcDVkmTh3nsCs1d1vftwO716uDoGrBSxSI42oOnQydIwX3/5HvKlaaxKbLrXydF9tcj7encpAr9x93zyHihJClQA+lJBmFdosEyZeTdoZ15saTYO1M2lgQu+3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYSPR06MB6503.apcprd06.prod.outlook.com (2603:1096:400:474::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 07:27:02 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:27:02 +0000
From:   Wang Ming <machel@vivo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, gregkh@linuxfoundation.org,
        error27@gmail.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] scsi: qla2xxx: Remove error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 15:26:25 +0800
Message-Id: <20230713072640.1587-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYSPR06MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: d36009a0-8c7a-4423-3f76-08db83728d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPVnDrPKeq8AOdCZ+NtcOc/goRZ2CXW8VH1Rnq/xG8G2xcsyx02NxFCGlwvuDWGHQQ3SU540w4mfOzz14dN9s3fFCo0/dbLM9w1U292QWcvCaxC7jyD2rnOrQxeJoej0lfHsvBt20C9NvuVt2lpK3LIngEzVxgKV98ZAGH+2xzfzRfz9oskzk1gyB8vWL89m/aGTUszdIqcqag0HLLfo8OjeSk6YEhJaxA/0zXOtWynSEYimAjhNdAt5VDgU9humW0UI3CFXJSCZHpOFBsNk2z6Fqd3V9rOcl8t7KVqlvIQXtsC95TWG18HPY4IgI5FLgi9mApbaI7K1OfElbExf2finzuTCXioVhDp3KRv1WIAtcH5rzPGppGsatOqChkBeh1iVwuosbSksDoAP2N5o29iP3/aX2zgoM2V20b9H56HGtq5pe+DS+VfYh7Q8O/vHSN2elopv1VHs/aZMsejIah4L2xpZ7hqKRaxpDITZbIv3WljwyBL1cyyuqD2p0hMDh8Tdt6sh6BQvp/jPADBAwGThXer80o7Nff5VAJugulB2Uxq6R8OszxgqoRe+Ob6QLlcEx0ze6VCH4Kx65R8z62PfoAODc3Nz85NqkP5S6O9cRuhZl7s9nKDUw39ohh6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(41300700001)(38350700002)(1076003)(83380400001)(38100700002)(26005)(6512007)(186003)(107886003)(2906002)(8676002)(2616005)(5660300002)(8936002)(478600001)(36756003)(66556008)(6666004)(66476007)(52116002)(6486002)(4326008)(66946007)(86362001)(110136005)(316002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ito6ZeeYs8mFPaYwf7C9KBUr88P7Dth029hk+24MjbB3O/6FLABOVnO4f11I?=
 =?us-ascii?Q?tDwdaRIY8QZZ6KXv3aMycvt5a5how1NxgckveYnuiSEjuClg1W+rRk3mGUc6?=
 =?us-ascii?Q?stDcGE6wqjEhHo6gOgMQcgQH7J1S0sNM1OTU9ujkluC1cDb6Fy4sdq+qMc0v?=
 =?us-ascii?Q?sJEs4+TnlKRCmIcsski4fB3Fd6a1/EboWtoYuQjYWHmAy3lXZn6/ZiwrM9lK?=
 =?us-ascii?Q?GO4tTH8uxf2G4eDUiOngpHF/d0ljzzjdlTY8BEB+akGXu5cjLN3rGkO8npNR?=
 =?us-ascii?Q?3PCn1Gls5hmLRhYcxIs1acV2w1mK2A4hmEBdVsHUIXgYqk0tWv5m4SVpiVT/?=
 =?us-ascii?Q?Zw0im4OjK8QYsRR/xJRLuL9e5OxKNX1CCKq3DgXo1HXXb8dRH9G/UVuMk+Cp?=
 =?us-ascii?Q?396Q0YgajUjvJqPTwpBphZRVVhGhB7Y4/+2S3zd8aU4L6hD7JnGMOrmEPcBS?=
 =?us-ascii?Q?PIdiWqlke0rWurWqDmNt4n4cnkuGsER+Dko/kdUNSbmD5Ckz7Dd0LXGHJnPr?=
 =?us-ascii?Q?OVZsK6WdkGlEXfkvrnAfRhaZuILEh1H694TZKruox8gwGwjg9DUrBhpapiyL?=
 =?us-ascii?Q?cXwByPmsVdJY280s2jNLfkz7D5TDDt9Ij+B6EPFGh+3Enw2CuJbGPxMOUYWD?=
 =?us-ascii?Q?/vQeHqQXPsZnrICUNN1UFCFIrjm0IAa8wtKi5aMnXO2SGI6JzfQHgmbRjJ1L?=
 =?us-ascii?Q?MfttwZVxbD9+qcdozYnmwXTdzPrF9eYkXRTq+MX/JhvrluD5kcQ34oiL2Ro/?=
 =?us-ascii?Q?XWPR2ApR4oW5WJT+1eHox9Ho77dqhAtuuYl3/dUhqDHy/v4XjlXtvH20stSj?=
 =?us-ascii?Q?iuUzpfRa1vi3ciX1foFQSdRcRjp9Ma6aMRqtxveda6+0rO+p+yrnhcje5tNL?=
 =?us-ascii?Q?CZWxboyi/J0LWUFYQHEXIeu1wOWAUrkbfO2Wl3ZwMkTQzszIOiRFtLcBOlf6?=
 =?us-ascii?Q?ZyzqO+K2y3RPTdFvAD8deXLkkI+mIcMEQfWMTMzMt4ziBugrh3CMxSTOXKxb?=
 =?us-ascii?Q?Gk/TJIowHq2ONG39CNADdKYi16TMFGNHZzIgIWskJpDeny9s/8xkZkLwWkey?=
 =?us-ascii?Q?rdRMTZjCwIp6tM6hWCEDVVpGAMK0oKrkSGC9mgVRIRUc7PYixhv7RFadGn3T?=
 =?us-ascii?Q?8HGws0y0q1kgdTMe4FzyREKYqi2MVX/ZypV2SJkrUuhPI92SS5DlNSnLH9Qy?=
 =?us-ascii?Q?8kmQtC3uIig+9OC8i2np/EQOQaoJYpQLyF6SqG0wemQRJQFOANWXBPg0CrfD?=
 =?us-ascii?Q?FoAQNzU4NshQmq/golpgMn8u3wSPIHYb0kVRpPQn7Xx1uzhcp6Uv4lOqI7Ek?=
 =?us-ascii?Q?pw3Z5hOOMKqaZnPh1fqWT3gPOlfcxOdnvIvZDTvyxRQCGjR4vyXTlD3tOrny?=
 =?us-ascii?Q?QIXbZ6fP5DiQY3PJmDnetnsJCT5YG8/fgMi1Og3uxFgk6BcryxN1fx72zaFf?=
 =?us-ascii?Q?DKCd/zIU2/mYEKJguxgHneNRU4QCitnN0RrdumJ5Oh0R+vsxRTSUYByaJNqd?=
 =?us-ascii?Q?IYJKC84EVQQJeq5ILPkmSXI0jNf/H4IviCKiX8TLiVuwDLQyx5J4r0OsvqSH?=
 =?us-ascii?Q?FTlJiYxMMQSLRxRJ3iKV9Cz7urvzQdsR3UC6ISux?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36009a0-8c7a-4423-3f76-08db83728d2d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:27:02.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr+GiwVHPwcISUDLSIM8rNmX64RgMmCF5GXVTGzM/GbGOv+IQh63AC7aqVR9p+qt/OoSwAV6OoQkexIVQfQTow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors
return by debugfs_create_dir() in qla2x00_dfs_create_rport()
and qla2x00_dfs_setup().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/scsi/qla2xxx/qla_dfs.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 1925cc6897b6..8cd67092aff4 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -111,13 +111,8 @@ qla2x00_dfs_create_rport(scsi_qla_host_t *vha, struct fc_port *fp)
 	debugfs_create_file(#_attr, 0400, fp->dfs_rport_dir,	\
 		fp, &qla_dfs_rport_field_##_attr##_fops)
 
-	if (!vha->dfs_rport_root || fp->dfs_rport_dir)
-		return;
-
 	sprintf(wwn, "pn-%016llx", wwn_to_u64(fp->port_name));
 	fp->dfs_rport_dir = debugfs_create_dir(wwn, vha->dfs_rport_root);
-	if (!fp->dfs_rport_dir)
-		return;
 	if (NVME_TARGET(vha->hw, fp))
 		debugfs_create_file("dev_loss_tmo", 0600, fp->dfs_rport_dir,
 				    fp, &qla_dfs_rport_dev_loss_tmo_fops);
@@ -139,8 +134,6 @@ qla2x00_dfs_create_rport(scsi_qla_host_t *vha, struct fc_port *fp)
 void
 qla2x00_dfs_remove_rport(scsi_qla_host_t *vha, struct fc_port *fp)
 {
-	if (!vha->dfs_rport_root || !fp->dfs_rport_dir)
-		return;
 	debugfs_remove_recursive(fp->dfs_rport_dir);
 	fp->dfs_rport_dir = NULL;
 }
@@ -705,11 +698,6 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 		}
 	}
 	vha->dfs_rport_root = debugfs_create_dir("rports", ha->dfs_dir);
-	if (!vha->dfs_rport_root) {
-		ql_log(ql_log_warn, vha, 0xd012,
-		       "Unable to create debugFS rports node.\n");
-		goto out;
-	}
 out:
 	return 0;
 }
-- 
2.25.1

