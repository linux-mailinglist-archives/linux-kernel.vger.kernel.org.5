Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB1797427
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbjIGPgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344238AbjIGPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:44 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071b.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::71b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322731BF0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:32:20 -0700 (PDT)
Received: from SI2PR06MB4611.apcprd06.prod.outlook.com (2603:1096:4:144::14)
 by KL1PR06MB6621.apcprd06.prod.outlook.com (2603:1096:820:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 15:25:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB7LvAqrSB7JgxuOHSOL8zGVRS5H9IgHxFrq3xZqU4q0zFgvIGYaHJQYQ9hUpP35XZsoX7/MFy7SCOOSEq1/k7YIG9HS74mDXtoJdzAiE7E7bErMcqpEtFvyx0WkbV8zsF/aU46yLgVpVEGqTffF34nD43jogXLOB4pTRJ/newmHgXQ4UAkDgH2Rkg1/azdgIst7A0kA1+EKFrX7ggrXatIIcrV8qEk9Tq8A7DJrxN5HsOPbHw7OhtW/tSr7BCARNkkIAR2X7AT9LCduF350LWRTlvnZSV0I9oUtv8431C532KYlcyZTKvYPmHH4pP7WOLFvib0amcA+0hbIbb61xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJlUdLZHWLiINY4h+QshIeymsgrAoPH+3UZgJ4MDXZA=;
 b=hKPLoekMrM6f1WYr5E/dnNPg4d9MyAthYQTytRgUTztpMnrFNoRTpMz/X/eHUQTGPwE9muEJy9re4Waokv5dLpn6opQPbA/3l0Iz4fTIvvJ8AFPj0be0kxMGNnNyIZFYgITwLH07IIVbpnTlmT0+6h9JpJo2q2G728TKs4+n55hs3D4IzjS4GzT/zIpmJKkm6TRLo+J1zSE3PII+SHijMRUa82Nj38MEbYVaQ8LjhmSLcgt36whBeD7nlTWzPu+TPcAm1GgysidZYSRpy9D210bk+7B7bnO8hWy9k1dUCGW0fRafseX5Ik4sqctGEd764/SasvXmcL93tteViwru6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJlUdLZHWLiINY4h+QshIeymsgrAoPH+3UZgJ4MDXZA=;
 b=KkUD3sEfzLBX0fiNBckNT1yEtknM5L762it8XXe7fleiqPblKgG6pUjn/JLPrHzkCptlTyCWmZb3Y1OY6gcFNfRwbNvanzCo5lj8E72utKTkHDdD9AUi9ZDvfcydwvzahKT8qQ9UIQRlxW+fWvUKMHcWGsOE35fNBHjyCVhd7lyyHJ+v0/c+0m3QVtOY/llmhAUzhPF4k/DrCGoWlTRQZ0Ll7x6sb0hu9+J+IONY8ZBmlYgKmyifGfKr9plb7FQk8UDAW4ZUtWty4WGsuCUPo5b6ghc7TTf2kzCla9+unjwY8/gPEKZkMWFJipQQllydrPTupQunrOP+ydQnhKebkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB4611.apcprd06.prod.outlook.com (2603:1096:4:144::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 10:16:44 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 10:16:44 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Lu Hongfei <luhongfei@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH 1/3] ufs: add wb buffer resize related attr_idn and exception event mask values
Date:   Thu,  7 Sep 2023 18:13:59 +0800
Message-Id: <20230907101434.89-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB4611:EE_|KL1PR06MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5ea941-79bc-4d63-9f37-08dbaf8b890d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntTEpAl5Mn7WkGG5sWkv5JD45KYRUEMFPT+8/eFeiTTxjAYrO8c2hY4LZkX5nyecxIxul4wykDeS27jM6xfdXrKOCjTUxbKcW1a9QW7RPXU5T/fIiMTfRwq5T6n2hwN5tobrqNT9sBG8r9K2rgukVA1ZO1fCCkT/H0+KRz9bGKdQJhLJUzIcTf+d6LsxTB23OVueYG+PYkRHm0ccw/OE0csY9o1Ri9qsFCTh2csGapezkBqz2+S8SuQigN298a0bXU2u4BS/hFl++xC8Q2naOXM131ooQ00KpBVLS1qHWix2SCRZEQR8bjhy9r/wO6BJPA6zOXYlZzLnc4keEek5l46B3pF3iAHn5Z0lv8EY5sgtaoTDBPwHMt2if1h7sRsYRjdHCT84OOXdeBVt2ZOUCIUmeNBc3lTFCgXf986h3221lNwD2kIsSiETPsq23I3swW5IO+4BhaGm+XR42oVb3SXhZy2vPL/eOgg0DGnow1jwZj+l/M6DRMWhYQpaUc8y0NBRR2NzUjfYTCvctm0TbUEV3yBOnH3kkMQgQVP4gwm4kvzAOxvhIw93PCuh1/3m5+symZDF8uRhgMh29mHExVy4i12eKOQn89T+BFUTd+6N+ZS61PNLRTLEOysYjMKf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(1800799009)(186009)(451199024)(6512007)(6506007)(6486002)(6666004)(52116002)(107886003)(83380400001)(478600001)(2616005)(26005)(2906002)(66556008)(41300700001)(66946007)(110136005)(8676002)(66476007)(316002)(5660300002)(4326008)(8936002)(38100700002)(36756003)(1076003)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJe0TZdJUiOwhz7MtyOmmWcVNVzbmVzLY1r2dm8BAYAcL6k3eZ8n4ZZeJAXE?=
 =?us-ascii?Q?nejEmmsJkEqk0PjuDTgJLnaak7LscgJcO1zkJsNYawSqt4mfCQhpGUuT5I3h?=
 =?us-ascii?Q?t6x86T71Z61q4TIpOi8hzF7i8I7LjKwhryagB/kLi1gMZZsOZ9Tslz3JZ3q6?=
 =?us-ascii?Q?HdmPm7zuI3FfAAA9EwUlo80YZNAinpSp1CVW8SyZXFluQMZuBCeFaZmc9H7Q?=
 =?us-ascii?Q?rz1PD+ottLXG+XlTc7UW01075HmEoNU5qBYDYn3nVLU8Oyu9Vqh5r8t2eRoC?=
 =?us-ascii?Q?npYs+lVlmUpl/0a2w97wR5lFCIIOjsADkVV8YZUAozbOsNW2EubFSLhfNSZ2?=
 =?us-ascii?Q?PFPY/DxGQmZJrFo2tbFhCjrnuJiW/7pWgEaztc5qWPNdoCIernvqDo6t/rJw?=
 =?us-ascii?Q?Nm5RLi66nX0eNczAaQ88Nv6BeBqI79rAEN9CxtJ6Us4UkwWWgJOCJFC9Q7jQ?=
 =?us-ascii?Q?0Lkr2km729ZdNGmMt0HDbTY0VH0AA4C3OPo2syAHCXFlcejkmDIJf4BeGrxR?=
 =?us-ascii?Q?gkpVtFtAgBs3VatQISUu+yTc5h4l5m0i9qcwzzh4ThxPPOFqr7orgd0VWl/A?=
 =?us-ascii?Q?TvYoG08WKIXGZsoJz9I/RS4ifai6kEtK8OR820Y9rDEJOCK392bq4ernoXY+?=
 =?us-ascii?Q?l66W2ilpBmSEKAIVItQDckizvOqOYqkFzrqnUUrnNnQL0whzfDS9uTZX6UVc?=
 =?us-ascii?Q?NSnpcYi7Y+GgqWm/JJYP1JxJLcV6ylQSld/4lY30UB2ez1B//WF7wfXolvoa?=
 =?us-ascii?Q?gkAZwBwxsPwsWZrzWrHv4GIbZO9/wvvmr96D9y3+X3Wnk3+p2L4+wd6kum8V?=
 =?us-ascii?Q?ib2r088/J98yhRBHWpwzA1lnLmUEnuoVt7A+cBoZMT2jnR2GRWdWlumFhSvi?=
 =?us-ascii?Q?tiAFN5KVLMCiWQs658mMmKyCFAlTNaEBZ7hX7hVEPxF2id1sTJ3xd0czjuMS?=
 =?us-ascii?Q?zXLugY5OoPDViCMkY+dbk3HeF2tsP6/d3ghNk8EaE20aWljqyUSZ0JMOre32?=
 =?us-ascii?Q?jVKZifaO4HGBBiiKaGSlXxvVAeHJOr/aCn/YgBIxEyfc5lExU20ltuInjhEr?=
 =?us-ascii?Q?TZZpmuZL42Y/e1ToivH+XuzDpMfmCjYtrwyv/prUqeO8JrBJ6ahyOS2uqgbU?=
 =?us-ascii?Q?574VNMyrX7PlcD7mVw5p9lqdSGojhTwf2Syv+5IUoEglK4pXItiFMTqpF01K?=
 =?us-ascii?Q?+vJaiFrrngP5arTlRX+0y2Mp23RO5we//bRH+yTGXMKr3SU1vQke0oElkJiv?=
 =?us-ascii?Q?ssWKN9a2s793NzHWDEWLGVP6dxtfZlGJ/n/C3XZB0hjUVqiDCV2fbRwMNfN9?=
 =?us-ascii?Q?K6a5FzMB8idLEtdcF2U/xmv8JY2ew/zZsuc61PwerrrDKPIdt/ufh0FzpXDT?=
 =?us-ascii?Q?YxpXoD9W1x+R1E9KQcOoNzTzQn2gIfKS9rziI3rf2nSNbm4kTRQshPSnMi+i?=
 =?us-ascii?Q?P+cQzcKyGMP4jWhDHfyTKzeJW5phxBK/z1mXNFi/D8P2EpPgetHiun8upJ+H?=
 =?us-ascii?Q?cXedTqJGnAcEMKyEe4dYj1Zn4hXLG0wHFr/y0vR/iBkUv+Ojgh+uDeaUTveC?=
 =?us-ascii?Q?tDA+yItO+AROha6D53qG/jaESlMKZG1Ue5fL1F2K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5ea941-79bc-4d63-9f37-08dbaf8b890d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 10:16:43.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/t6z6DhbGf1/qwE5Sr2qLZwRVEbVBVwZd5DpU35+yOVdMaS+GgylSblvlgBoVQnRq+aff/MF4EyDnHESe25IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4611
X-OriginatorOrg: vivo.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS4.1 will support the WB buffer resize function, and UFS driver needs
to add definitions for attr_idn and exception event mask values related
to this function to support this feature.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 include/ufs/ufs.h | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 0cced88f4531..d9dca1b9eb08 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -179,7 +179,10 @@ enum attr_idn {
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
 	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
-	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
+	QUERY_ATTR_IDN_TIMESTAMP		= 0x30,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT	= 0x3C,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_EN		= 0x3D,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_STATUS	= 0x3E
 };
 
 /* Descriptor idn for Query requests */
@@ -411,14 +414,15 @@ enum power_desc_param_offset {
 
 /* Exception event mask values */
 enum {
-	MASK_EE_STATUS			= 0xFFFF,
-	MASK_EE_DYNCAP_EVENT		= BIT(0),
-	MASK_EE_SYSPOOL_EVENT		= BIT(1),
-	MASK_EE_URGENT_BKOPS		= BIT(2),
-	MASK_EE_TOO_HIGH_TEMP		= BIT(3),
-	MASK_EE_TOO_LOW_TEMP		= BIT(4),
-	MASK_EE_WRITEBOOSTER_EVENT	= BIT(5),
-	MASK_EE_PERFORMANCE_THROTTLING	= BIT(6),
+	MASK_EE_STATUS			 = 0xFFFF,
+	MASK_EE_DYNCAP_EVENT		 = BIT(0),
+	MASK_EE_SYSPOOL_EVENT		 = BIT(1),
+	MASK_EE_URGENT_BKOPS		 = BIT(2),
+	MASK_EE_TOO_HIGH_TEMP		 = BIT(3),
+	MASK_EE_TOO_LOW_TEMP		 = BIT(4),
+	MASK_EE_WRITEBOOSTER_EVENT	 = BIT(5),
+	MASK_EE_PERFORMANCE_THROTTLING	 = BIT(6),
+	MASK_EE_WRITEBOOSTER_RESIZE_HINT = BIT(8),
 };
 #define MASK_EE_URGENT_TEMP (MASK_EE_TOO_HIGH_TEMP | MASK_EE_TOO_LOW_TEMP)
 
-- 
2.39.0

