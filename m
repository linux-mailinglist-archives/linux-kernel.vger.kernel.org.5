Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65167DDC32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbjKAERm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344653AbjKAERj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:17:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D0910D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh8EHb0hRlrSb8v1Flem9v+lvIcw4CqlHCSRLeitmQrGuxqITaIXagGGB0lHNbo7egs76kDO0He/ApRzavwxDlBbw/gMhztv2E3NGpak4xedHCoiwmuxw1N2GY+QGI0hd+V+RfZWIOoWtwtUgn4q4hN3LBugMB4AcU0yyHH+TXxukWDpEbV4DUEHMfR/mHpIErJv1Uk+LAweZ5+4AP+3L70xTCciARMQcKQryaOVIOkIMto4/z0nfh1Lo9a79nyf2cpIWCQidBeye6WhgBRyyO3GoPHqrp6/EcQX+hqLC22VsV4NaRFVqekUelNdbV8Ue+0XDSZEineyEnh6qwcoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKxPqIwRH/0UToZwAf5WSBo1aM7Z/qtyoABIMGpuuVY=;
 b=eLoxTFaPrUdZFiQqa0g1LqDulr25lViHn1MJ2gD+FLE2WRAnQ41ontgjn+dZoxXqGGJRHsBEfZ++m8KsIkZmHpHmAhK1GSQY1UmKfdY2bLlmBJSp5nwAWmyeyXHGJ4Yy7EZpdEkOKldmDOw3mOyISfoNivPwlmkUHpA5XksIMYuTQ5QuQ9oCUVdD/jW5CVs5soZMDmKCwEb4jZjNXJk0SN7cPJroOGDmdxo0iEAOtgXCLYwQrk/DSz2Cg/LJvjrpiNo2AI9lHmkCvFuRMa4QGXh0POHffLwNJXMprPn9rfzplL61hcDIQZRai1Qbwa49EXLo5/BjVWn3NUYWpT8C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKxPqIwRH/0UToZwAf5WSBo1aM7Z/qtyoABIMGpuuVY=;
 b=pQyLNSJRNO5L2xF28Js05cd2NAebIAud9hw/Z5TrBZuKoT7JeLeyoRu8Du7H8nbvoOAAFhrNynZEsPI23yjA+AZH9h5GqpU4ASUPt0yN/iWiAc2mdQ3mgzwn4IifUHEW44hn8nBDwYohm5ofctkENa3/YVALZyuGMMFlz6CJolMYYRj9+Y2gqQtMygWQHt2pPyUg4z7xyDS9GRm8zfQ8DFXBc30c5Mg4GCAc+GNVwjfp6ZV84ZcazkqRiXprQ396IlC/VbnZlm1PuwvsYw3ikMBzFK6UsQIWcYIFdTvtIzKRZTYyg4rHhBApyalc7HboAEVVDU3q35Tu08JgHH95WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3520.apcprd06.prod.outlook.com (2603:1096:404:100::22)
 by TY0PR06MB5594.apcprd06.prod.outlook.com (2603:1096:400:32b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 04:17:29 +0000
Received: from TY2PR06MB3520.apcprd06.prod.outlook.com
 ([fe80::e5e:d180:d199:47af]) by TY2PR06MB3520.apcprd06.prod.outlook.com
 ([fe80::e5e:d180:d199:47af%6]) with mapi id 15.20.6933.024; Wed, 1 Nov 2023
 04:17:29 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        Wu Bo <wubo.oduw@gmail.com>, Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 1/1] dm verity: don't verity if readahead failed
Date:   Tue, 31 Oct 2023 22:26:10 -0600
Message-Id: <20231101042610.606136-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To TY2PR06MB3520.apcprd06.prod.outlook.com
 (2603:1096:404:100::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3520:EE_|TY0PR06MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de90c4a-5df9-42cd-4307-08dbda9175d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1FMp7nUB21ClWP0Mr+GvWawoE76sEfgQnLiNseNaWI4loIlKdwIAa6GVxkNnToPCDwbJUkm4ZXF0v9NqVb8X5rrVLzcGPdIOs6Zh5QD+g3r1r5BJZr+yptsTsU9NvKtJgFDqUYxQ+ztGolUU3J71VBAUWIdcx64+9p2Hse87vRZ71SMHo+DSXZKQUBsGxmI0udiioeXmLRn7fY4ZZakTlA4aHf+Nwmm0zlMG72Wu2GK1s/l/ivlCUS3wZWCDfM6O3wyd/mNIe67fKtYxQyWWJyDVAkUCBXHBbfq4kHlhaiMddDAVgGJOELYyTvIADWy/VEAPdLkLyv2VKSocxLQhQYveHzG+nn4iS2SpAsW2DMSfgTsoObKVql9dec4CKujrH+SfRc56wLfgVobhfzZNVJfbvR+io6I3FkKAiSLygBJagkVZmQh1Yalu7b10LwQS11NQQGuzeZ4jJajaDG+v9XWRsagvhDkICOvDv0OljeePUnLLrnNAK0lCeV4OJkALu7MfX/ZG6SgbmgpXS8KrsWZ7rhuNaJHVlfWLgl6i0SzVZ7CT1ne0stqLG/5C6YEI8o+IXrJ56E6ihVX1JpHa25uHJLmdTq40/2pjmqoOcKiduBwYFDBARJTaoDai9ij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3520.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(52116002)(478600001)(6486002)(6506007)(6512007)(6666004)(2616005)(107886003)(66946007)(66556008)(66476007)(26005)(54906003)(316002)(6916009)(2906002)(86362001)(38100700002)(4326008)(1076003)(83380400001)(8676002)(38350700005)(8936002)(41300700001)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PzYBzm+JNiYZqowyWLEkIbeL4BFai12I2ezfcTEgDMlceN6p4QjBNRmMbq5f?=
 =?us-ascii?Q?J8bjH+t+EDeumpJAc9oujzstATr5qEnyF3d4D3ELVSdPUPWjZLMcZ9SVS6KV?=
 =?us-ascii?Q?SbAkUvTAzVx0se/AJBXcajwWGI0v17UUK47m/z4m0/vUSY7ptD/KWWlqmcjM?=
 =?us-ascii?Q?HlaNsfBzl6trHgcG+30aML5iCSv9oD/Y+Q6ItDM6trzwGLmg3UBbFke+nMn9?=
 =?us-ascii?Q?DWaCK6fxqcJW0EPaN3PNWjnqnRC14WZsRojTcmB5IU/ytSMzWVjhX8Ez8Mb4?=
 =?us-ascii?Q?M4+GXbefRA60mUSx7pMk3V/oZO8CvxVSs40RoEcGQOmROfsuLiooDBkH0eEx?=
 =?us-ascii?Q?uaAHSeYgsQXXUYC1At2PecQJdR/q5Ex5mOHRNMej+cQYxDy5mYhfdk5k4N1M?=
 =?us-ascii?Q?/zvLCCO5/R2XkhsXGhKskKyLm9W6YBr+faUgi5cZXyBtujfV3n3AvLeVsSaL?=
 =?us-ascii?Q?MbEwMbYQw3im7tHgZIzPIQolDgBU28C+fNVJYV2op939XvgPElfNwqIUgpgc?=
 =?us-ascii?Q?b9zX1KCuDXtnxdBpPOYuC3dKxzR2CKyDHejOoHg2ugR5oWlM7fYDrSmqBR0n?=
 =?us-ascii?Q?xpWUFPrYzvmIrPZ07ObdNIoPD12Itv2jgOCvB7oU1OJVBkyRCtE73i4RX3DT?=
 =?us-ascii?Q?Tj5ZC4EF2RZE9liaVNtplSx/OcN+HNcVIc4O4SzWlEfcVJB71SspMfwXvlty?=
 =?us-ascii?Q?MOiD/zDfhH90tCHlXteszAQL64dn4jedvg5HSIKDT9rbh7MYPbY/9aCV8J9T?=
 =?us-ascii?Q?BrpW5olnsHDFi/UosNFQJmlk4nGT5V1Hjrrku1sHm82KFxUvjXkE1AzT9KqG?=
 =?us-ascii?Q?DmlE+yQlMz7Wx3SYWDZVJv+fV2T2ue0t/A0XMsOnxuR0TDKFPiBVgpxTpoov?=
 =?us-ascii?Q?kCA9J82vOECTr2CbzTelT3E3yQm2bjiLUo/yQWfmqJoV4QPVT+TDWCCGH+zg?=
 =?us-ascii?Q?LvJoEkItpRz2+FFzGXxNiEwmiUw0/odl3gOX+7YHtLF+di9aIaDIzW60KdCf?=
 =?us-ascii?Q?Vc2KRgMWE0IzYMgw8jZTrAZpNvJMA3biAel4aMYuJKS7d8exqHN/BJRzr9L/?=
 =?us-ascii?Q?6iHyRyKLa/EM6X3J4d8kC8JJPTjZtMypCZOxmxfMW/15B4ZUlJjPtKB/Xlxt?=
 =?us-ascii?Q?YL3rBkxxHJEx+HosAwR2bQ3NEHwkBvJwgyyH+HIQI427+vKCloAo5UqIE4Tl?=
 =?us-ascii?Q?CIa/Ypgh1ja6fiNtIq0c+nJhx4X/wtmZT0fE4ZyBNn6lum3WHibWCrMVsDS+?=
 =?us-ascii?Q?K0u6BKH0XPTvRWyjUpEmUnu3jbgSvjmjtjv4cG1Wj9saOCVWDdTSQjrd0XAK?=
 =?us-ascii?Q?Nlw5t4TxBYr4WbJ4UycsrmzOajbIZIvYfufLyF6QZBYA5cmCQVt1Mq43YDQu?=
 =?us-ascii?Q?F9u68rcJkMDl524NoZyXSzzoa5tyB4hOyR3ej9WT20Ev/z07u0kEnWI6YutF?=
 =?us-ascii?Q?iVOY/bLFYnoHEx8kGQXONfjVj0ycfDUwQQncfQ9mIodF2EOhptYx67EoP4un?=
 =?us-ascii?Q?WD9jhe9Bt8weEk/8yoje3K2fmiDqlAGrGvSsRh0lrxTTXF/4TPlbIkqNTYMw?=
 =?us-ascii?Q?W/Z74CS+uALn71X5qjOSyzRRk0lrLnruHfZlIWDQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de90c4a-5df9-42cd-4307-08dbda9175d8
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3520.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:17:28.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSWgYGTB1VNuWhGeSnUM42/YjBfOFg5GK5/RpfdapoAD9sm46AtJETd/23qycsZrasc9N0f9xeyidtBx0yTcug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the IO is marked as readahead. When it is failed, it would better
to pass it to upper layer to handle it.

Consender the following situation:
dm-verity is built over a dm device.
'dm_submit_bio()' will return IO error when dm device is suspended.
And IO get nothing, but it will goto FEC, and trigger more IO on the
suspended device. It's a vicious circle.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/md/dm-verity-target.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 26adcfea0302..253e65b4160e 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -667,7 +667,9 @@ static void verity_end_io(struct bio *bio)
 	struct dm_verity_io *io = bio->bi_private;
 
 	if (bio->bi_status &&
-	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
+	    (!verity_fec_is_enabled(io->v) ||
+	     verity_is_system_shutting_down() ||
+	     (bio->bi_opf & REQ_RAHEAD))) {
 		verity_finish_io(io, bio->bi_status);
 		return;
 	}
-- 
2.25.1

