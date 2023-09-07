Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3C7973B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbjIGP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbjIGP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:27:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1381BFA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j254ytJJ6fgU7vjs++BAa8VdmgqMqSADKaTR96ii2GvDUQ+mN+tXUsXnXR3qgnoyPimCmUf0Y0qYvCMLFLqtf09bfyeItogOvZoUtw+K6xmha9Fik1qfYnZIK9rEPvcLXWgfXdlSU6JKibAvHzvpZ2n+1BdZbLHeOSvMqHDelo/rb5uQfF2GCfbU1S6/2mqQMCCQWHEuor23Rp+QiaphsXO1hSHj5Gcr4Ro4FseXd9KNgtB3z2ecsS3ruen4w5qKhAPbOuiXXVcK+0yGYj8oWN1N3wp5x8E9n2WOdDNep8DIjWzi7i8Bm/bjJKCEbGrFyMMHRv2xF8w27ii8oubRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJlUdLZHWLiINY4h+QshIeymsgrAoPH+3UZgJ4MDXZA=;
 b=g5727MSniTsUuJeE88mnvmq6FrMIHuztL2qMQqfT3xboTzTyCJ/ad/8+ehiGbCfaH4Yh937AkQua7E0fcj6hG7NOZxNaLCApx3YYZPNleM2DE9iC3xf2O9rugB/KifHv0ax23ycImtrTbaS6V67cN+9Nx7aZkrJVQDYA4qtxIRnr5gO04o8iWsy17+o7KhjTtXS8qaaeHrQH438uAadxw50/D8UKhZALJp/V7jsvh8TqHJMM8LzJlQVccnALFmN6RhGlQOlShX7EE4OlfnAKmiOyAbAqWCk0tHS+Ghd/hK+1xjQrrefpeSLL6mN04gUTxOiPsahrI/gdtNjFzPOe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJlUdLZHWLiINY4h+QshIeymsgrAoPH+3UZgJ4MDXZA=;
 b=DOc/c3DzxkA5lTI3t4MOKrPj9ZucGcWpbPGUB14UVyLve3AaTfbGRMW9cQjGKHgqmjsj90TrJOnQQWLwaU97QAdkEeqHsoHBKeAocw84Wu5ChJBvpUDIniQzkJ8wmct+nIVW46bl4Tv31JvYuynlEf8eAHa8yXhWZUOEzKOmG0FhSntxHzex/DsljpQ82rrj+70zSYnSduy/ic3Onr0ZSpjfKEEJaC9OQguV1XiGlLOLyTYcUO7x/CEXR6TBL58e+fQTfzJNvKhueIyr3dtfjivcWu0zbBwUcriEwuJO+Ex85S1Olzooe2nH5Jja0FIJf+hDunCXD4OBfZ6qqmIIRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR0601MB4243.apcprd06.prod.outlook.com (2603:1096:820:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:04:52 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 07:04:52 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Lu Hongfei <luhongfei@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH 1/3] scsi: ufs: core: add wb buffer resize related attr_idn and exception event mask values
Date:   Thu,  7 Sep 2023 15:04:06 +0800
Message-Id: <20230907070439.1546-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR0601MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 228bfacb-8449-494e-db78-08dbaf70bbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6azwq5NNTiUgXqeX38UuR0n1RCigRDn0igBCWn1s5+Yz6cyPC42hR3piQtrh4a8sNZPQSvs2ew3xieHsq5PB+bayWxOLmTJsiT1Rmme6798KJ461hVeu7n5BieNHVuerZzw2/S0MGXJwP/XVdF20QtBMK3UAgs+pdAOOjROFuQW6vbbrO+1JDySwu2DYRGxuVGlvR97ITHAdgiv8nz1s6sUiPCGhSk/hD8vUhfm0HhxSYRTTo7M5pXH1pWKnex4M9oxg3Voo4QTxMU05Sji539252diixykL290XjwQ32R50pKvp1u+rWOn/vVqHlQ3zyYMHFjwwkV3LdaMhcgxT738Rr3FyltYksLk4RVoIPA0KdUqwM1V+r71UGGxJkCjvJpvGi2LcosWjPdk8peLhReJcf1tS0Eo4Ned7auxftHjg5ChHRzm9GgBq/MdsnlZBRDFXxJNoXQ3zwFi5Gq8fbVmWYyfqa8P/VFgj1rkzofTytvZCdXQ/1yLT0lzDsrYxKtY9FHMooL4iXHl6+xl77XOAzSHCmGW+HF55VID1gUL+G/sTdgRdlG118v3kKsKW4korU1uN0CrZBPR95zdk7tbyXs3havaJktvOgrPBPywYtSzBR101HjoRaykBAUz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(6666004)(6506007)(6486002)(52116002)(6512007)(110136005)(83380400001)(2616005)(2906002)(26005)(478600001)(107886003)(66556008)(66476007)(41300700001)(4326008)(8676002)(66946007)(316002)(5660300002)(8936002)(38350700002)(36756003)(1076003)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lA96GXAKhgkXI4qCKL0+BShFb6ZcNxOU4gm/rSgHBGEFUIC1bACvnoN/3wQ4?=
 =?us-ascii?Q?OuwnC90gEzwea86T/hn32UGXoHU21Ir01T2AtjpofCGeRNqEevCvi508Vj2X?=
 =?us-ascii?Q?uZlOccuJ3fuqXdA0q9HtsQlAUL9XVP+n3BD5ZIz0GNjIfwKuzkpKYl6P2w8O?=
 =?us-ascii?Q?Dm6ynAN0vNZFToBes9FTMXZV8HAwv6UpJFCsD/p42e64Ns1bHN081ZluSGvs?=
 =?us-ascii?Q?KIn+oXl+MC2/vP7hNsSbZi9vRIF0CCO61C+d9RJjWsq0kSKyjHt5Wu1lJFAy?=
 =?us-ascii?Q?gIFLSyxbPGVNpkDm0xZwUJEAZL66zR4dB7sVM7pLJkmnmQ/GXNghXwQvBgXT?=
 =?us-ascii?Q?lZT9DRcYjumI3hOruVaOhRuf4RPjzGRH4inLJB5tcBLU4hKE1YXmYL5/zCR6?=
 =?us-ascii?Q?txHZ5o6BML4P1971Mw4m3vCtY95lhHdzw5wpqow0WzIVcqcpDbP+70TJ7FlU?=
 =?us-ascii?Q?GFaquWFcnoJbBNmrG4Trf8kEFh1662MelX2US2gU8Q+zRuB0JQ4aGuUyxck4?=
 =?us-ascii?Q?u8PPzI97AvA8FiIgNIZORWD5WBcG8kIW3KFYMRQd/4okoOc6rviSTve5HGOU?=
 =?us-ascii?Q?+yLiTeAycm0P2tvdZvhvCk0XhDEN/c3SXJDhIelKleYborsDcxbONCM4UUL9?=
 =?us-ascii?Q?drQKUoL7kuda+369cPWOiA54PVn9Wh83okKoggwaL+zpLjNs0hHRWjaoG4JR?=
 =?us-ascii?Q?FIhqUNNUQFT9PmuGdDEKsu34J3RPSlg+CPhwFU7sO123HGBPeH+EFW8mTs/8?=
 =?us-ascii?Q?An1pv+eHnJo5Yh3/zUhLJ+P9dSGjD8X5QNkFcMqobSI3OavHMbFH7C8Ptxrw?=
 =?us-ascii?Q?zG/mzSLBL06w9VS+zzt5yqQWyAthf5GdBYbedSb4zenPbRW9e9AokfugZY4L?=
 =?us-ascii?Q?ud+1pxi0t6XX08zIafzbERS+0neOu9TV4OC+lFogIsfKt2vuiSVDKN/rrVh6?=
 =?us-ascii?Q?oKs0rnGQrJ46zfyIzcpaaDdTKhg8RQDXxdJsN1wEoIiWJAS596vbSeGfo/i/?=
 =?us-ascii?Q?Qg/nRm60R4RcSzh28+PXLhfc/jhCrCZuEwyY3I41GQ9N8LtewJG/Sbj9cKK0?=
 =?us-ascii?Q?dAhukaYXARSOe3lJ+2O/e/Q2QDGrKhXMfxLUZEHRxgByLk4O0+VreRMtCwwj?=
 =?us-ascii?Q?6iHDLHIj8IOr99yjiVW/wM/N2G8Wuca880Om/GRxbf8VVbHZO67cyN8FBZzA?=
 =?us-ascii?Q?AwOzKcwf/c91pKpejESFC78x2UCFupeLkybWrADuIqZ6DiPPtLh6hOsog3R/?=
 =?us-ascii?Q?3v0J8ZPQWL13bnznswmhy6g4p/FTrh3mGTgIT1B73zHM7nTYnVSIZlqEwUpN?=
 =?us-ascii?Q?quWaEWZWR9eJ4saxkDg9KdwHL4wO4+Ti0nZF2TjfRMXZbP+YEfV8N318AJmL?=
 =?us-ascii?Q?9UY3O4aODxLNFm7h5O/K5F8BJl6tLu16qjxkj8rA/uJcE524GSW+TPk42ZOP?=
 =?us-ascii?Q?ZQ2+WMjYluqm7WrnmZTx4FDyU/fm/iDsy8LH2PGpLxR8WtKGgYXo48Nw5iwd?=
 =?us-ascii?Q?toCxF739o2Cd8IYSwuduCiBQ+YrprvWqS0Cu7OhGBC17oFERzUwdQgHQQjaX?=
 =?us-ascii?Q?QNuiJVQQIhXh5/7AmM57WThmAbjZe0oLpce5acJ+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 228bfacb-8449-494e-db78-08dbaf70bbac
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:04:52.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spNludLJ8pUkuZ2Ibqi57EtXy2CP1Z5c7TIT/zIsU4Mko/PASA1jAUgplz2FMJ8cCPMFs+vN45OyrX0rQPpMyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4243
X-OriginatorOrg: vivo.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
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

