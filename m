Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F2C797378
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbjIGPYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbjIGPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F24199
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbAH34lEkUU2gqhg7WZEJJpPj7I8yTdV9RqcdUeakGWoDoU0kqvbNvpIFKAnA9i73kUstKaiEBfKYG4drwTeTOpBQ6tEG0EqHnHCfZ4kNoJ87/XxhF0DkuCaGy3gJgxdfrtN8fVb5teKm9ht1N7lx20KQLYeQKWCEhIs9oXM3/kSyBsYfW757/ZDaN9kcDampv5Nufi76sULRKZNnE53iTHQw50mW4tdxyUBCV1eME2k+Pht2DbtrK1otJwgaj/Bz56mgedg/1tacbm9gGpBvs98yAL6G2hK7s+25FHiNflemeLfZOo1TJMhcgV2S5rQMMRqvtHWmyTMt+3Zd1W86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urycavJNWHrFtl2JYr6wGmXqTAXWi2UuvkcmsWNun6g=;
 b=eI43EIwO/g0kei2Lm8ohDoIoWNa0Kea0rpszL7WJ8jVuN9UpDVYKA65QRDDBZY3tCJgiZmANxaL0/swK5FfEC8OJ78ErvMfutbSuJD8rH/aGuEk1wlJv6uTqOg+aAbFsj3cAojP8PVwUH6BKuePCAAhjs9Jqj7qauEnGN3jNZP3xwlONLiZAZHbvK9mLIAKMKncRsk+xA9YkHlpShWBLBHiL0URHEC7iMSNQHeiifIDFgp4TpanF2sYvWgWhOKOQqpU5nlKWJb8FVQXaHu043u7m7gZjwZVyX5ViXtRvCjO8m4ZLG0gK5wWZWd+GPaVnFPzn3j/1cSgsR8WIfs8few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urycavJNWHrFtl2JYr6wGmXqTAXWi2UuvkcmsWNun6g=;
 b=hb67Vb+8rfTMd4b4VVTn3P1mCq8bU2/16MDUDFkYhHAha+DCZWcStBuFde+rR/ZbMzJXs5OGNOLN+xSNof8t1nJgyA0EUPWAU1h6XB8ZnFLwXwn4uMGAW+Bu7rqmpHvQoQYIb6ifXd6qDQdhVxCUXZwAmvol9OmNYPaaWuGF5Kl5wU3tE97HbBMmBccfIvXmT4gO4AZ8VyclH0xVaYbqjGI473M1kabyu2gkII2qejAjCnWRjAB6bDaTKOta5ua6GaNnGGKYcH/P+xYL6CMZ6XL2O8/5RMdms2TzyK5ICOn7dDkr1HHomjRSeddoehLfywuyEhw8ZwrqQXH5Pm3AZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB5050.apcprd06.prod.outlook.com (2603:1096:400:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:36:41 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 07:36:41 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH 2/3] scsi: ufs: core: allow host driver to enable wb buffer resize function
Date:   Thu,  7 Sep 2023 15:35:48 +0800
Message-Id: <20230907073622.1731-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::17) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1677f69e-2d48-4671-4551-08dbaf752d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXrjMlxlw+2SVJfB+efHVWwCAQ2i6eJXv0o5rmLsO3C/XEWLL+cfLBhxCbFJKJoMpI9KxtBZw+zfQ7+YW7c0Ix66FYBeF9FJnQ+sJZBw81tvf7VIKqldxh9q9LUMkJXuSjWkZdqWWi0qjjZDM+B5WuMbXwLuGw/EXtV0JGbcXZ9f2f3IGDO6vt7JTHXYliW4BoFK8NYgRp3ykLwcSfKCvvQcJRPpj0bI9RWnjBzsGilB45MgfRV9305Pvda5JHvRUzYH4KA3c2nSOEN44R44sR5mDWWS8rTJhZijfhGJ3mQS5aCZtAiJbPFMs7ORit1/4T8kzTFoqQlUWPNQbaUNufnS43QJOOiV1Wp87UHEKoZWtnakbKMpG/5rjipZ9/odpnpahtBJBJOy/gprdP6sJ3pTMNxEKeTp1xE7csxONGXm1oMtA3ouBYpL103NL2CYpm69sr9KX4Bg3I+OaVR0YAW5iLIi0n09gMCW7eHhdVm+m53BUudxtcVU31/8OXZBZRWfSyssga8QBqRHVmQ1k6PA9M/sqXBLp5/XIXg1KO/rPyIW2En5ehnkE6aiXFmn5wk6Z+U7mLXoFnq8y5xTdxy/mwUSChmLaqNWAfziYiTOLtUFcxNV3td5VO/DZNRS7NISAbWI45DRCBGhvpX0Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(376002)(136003)(366004)(346002)(451199024)(186009)(1800799009)(5660300002)(4326008)(8676002)(8936002)(316002)(110136005)(2906002)(36756003)(66476007)(66946007)(66556008)(7416002)(41300700001)(52116002)(6486002)(107886003)(6506007)(1076003)(83380400001)(6512007)(38100700002)(921005)(478600001)(26005)(38350700002)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wiEKRV3MHzvaEjK+6gphrR8i+X1qtH2Sj3PqoKtBvlNRIz8mbk4DILvF8eUt?=
 =?us-ascii?Q?Iiz6d7SOs6U1PX6iG5ne8MPd6KJJ/rfzQ4ZxevHI8dFJavn7fHch9X+qYy0f?=
 =?us-ascii?Q?VvEkQUL1FYKNvMDEbPSe+w7k/NqD3rVrBZMv+8ktgPvKMkTKnmcs++olV50k?=
 =?us-ascii?Q?blorjVmhuyIXxoNVQv9qFHyD/VWj5DMLb/BTBxwHGPiaLku+kKIbRez5eow4?=
 =?us-ascii?Q?YsZMttrQW4Xl6LvhDWDx0OSgD2BZ0grP+RZA94Rfz+7RmsaffVjrfvkYM/GQ?=
 =?us-ascii?Q?5kJFRlp1nw1JzYXXijukoW/yWhYF4FrcQUthGuHS6OpgucwcmhcSbOepFIvB?=
 =?us-ascii?Q?Io54XlUc/8pEBpAifVEFmSAa/i14lNA/LHLTT8ufwwmoEoUdKkNlE+BOiu79?=
 =?us-ascii?Q?UEqBY6iEhiuR9I/tssGA69qLMAVMRpIEDxlIL8PXCQVm9HiBydq8thxyOw+q?=
 =?us-ascii?Q?Ima1p6CzCBiz+Ow/2Zo3XPZ1iMnm5ZxftZaj1BGQTAcLxM9jZz4wt8dd0m8H?=
 =?us-ascii?Q?Q/8VXD6uuaBtlCd5If43R7LIySJWYC7n84kDUGJDPXLy74R5ZWFribQRP7bE?=
 =?us-ascii?Q?kprtEnJvFxgY2AoY50RGcKgjsvTskIkim8YIYclxTLCfDU+Lykk5zlYBPK3w?=
 =?us-ascii?Q?jw0Bf2VGhF9i3Ru5xJvMiMUje+dn0lYtBP2tapCWF8xVeVkaKNCSL3VdHews?=
 =?us-ascii?Q?ORapQZo3Q3+BevRPqrN9hAaq028c3Ra3nHg0vUD/cgfFZvFO+nr7xSMLrFjo?=
 =?us-ascii?Q?Y4T4cff+HJGeh5r7iwL5WuYvwYwueNy3DW8I7pYDFYr0F+SLT0DOeKTPZO1k?=
 =?us-ascii?Q?sMc9iURkl1J91V5HauQFQjk3JjPZzcQB04mIVvALlZDufim0uH/d+qM2KHRl?=
 =?us-ascii?Q?hz2tYvXn6DQOEHbVK/gk/7p9xhqEh7aftIq2o1IBYGr+8x8wZ5V78+ak29ig?=
 =?us-ascii?Q?cB/FbHLzLp8tnJ1JSq01sVTYbHlhNyYeIqBQrmBCBqwdcqW/GFJrdblQVNQx?=
 =?us-ascii?Q?8s/rERV0Om1SorMPhSu5TtOHgyBjsA0BbinwJyD9QNEYabfdTjE2bOJbAtwN?=
 =?us-ascii?Q?kR5LNhsTVth9PxqmYQ5VSwVP85jZ/Xq/dFxvvuSjwCbEc9Izp8rDI0cmv5fl?=
 =?us-ascii?Q?6g7MBZl6D3FCU287tEL/l2n6SL4d44mAQ554Gll+8GObikLfBuPcZTxpqm7q?=
 =?us-ascii?Q?LfhCkxVRntIeAkEzfo+GIIszXEnQ7fakL6upaJSsxyedgt9fhK+q//n74akl?=
 =?us-ascii?Q?aGmwEwnhrMt2mJ116uy3q9QL+CrL06fqD+R3AEA78t2uSEn/AH+ZKS9FMGaf?=
 =?us-ascii?Q?cxtCLT/q1pvfXQCSBK5rgs09+KViSAeAjW6OlNrpQUsobuQxjACAYk99h7L1?=
 =?us-ascii?Q?uX3pCoWXYcOx8CZ6a/lwZ00AV1yH5tO5udAtUBHUtbxTU56k3I2oK39XJEdV?=
 =?us-ascii?Q?8l9Q2H6uwBssNZGgoyuLwKI7FUHw7WxktA9bV9XJcgDbxWvxcBEPw/4rZWSH?=
 =?us-ascii?Q?H845s1UOyH9RhDL7gZ1c1K4Pi+xQkEa+C1T14glfe9BjVcjdj5nyJQsh4MAZ?=
 =?us-ascii?Q?GfO6q5cwg/60r0K9ReFZeMHT1zo9CEbz83lVhXre?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1677f69e-2d48-4671-4551-08dbaf752d1f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:36:40.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZG13hBBHA3TD0z+77ocjYuXU0xFCHTF/kZotPa9euYXfiTCa7z2bsdXO8bOpUEeiSCRCZHS2nLfxtROqRgX04Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since UFS4.1 will support the WB buffer resize function, the host could
choose to enable or disable it as needed.

Introduce a flag UFSHCD_CAP_WB_BUF_RESIZE to provide the host with the
ability to enable or disable WB buffer resize function.

UFSHCD_CAP_WB_BUF_RESIZE is only valid when UFSHCD_CAP_WB_EN is set.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 include/ufs/ufshcd.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7d07b256e906..7ea226b69e79 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -720,6 +720,13 @@ enum ufshcd_caps {
 	 * WriteBooster when scaling the clock down.
 	 */
 	UFSHCD_CAP_WB_WITH_CLK_SCALING			= 1 << 12,
+
+	/*
+	 * This capability allows the host controller driver to
+	 * resize (increase or decrease) WriteBooster Buffer,
+	 * if the underlying device supports it and is provisioned to be used.
+	 */
+	UFSHCD_CAP_WB_BUF_RESIZE			= 1 << 13,
 };
 
 struct ufs_hba_variant_params {
@@ -1193,6 +1200,11 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_EN;
 }
 
+static inline bool ufshcd_is_wb_buf_resize_allowed(struct ufs_hba *hba)
+{
+	return hba->caps & UFSHCD_CAP_WB_BUF_RESIZE;
+}
+
 static inline bool ufshcd_enable_wb_if_scaling_up(struct ufs_hba *hba)
 {
 	return hba->caps & UFSHCD_CAP_WB_WITH_CLK_SCALING;
-- 
2.39.0

