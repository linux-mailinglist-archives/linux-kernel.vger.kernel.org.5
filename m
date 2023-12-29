Return-Path: <linux-kernel+bounces-13074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1081FF59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991EF1C22292
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD00111A8;
	Fri, 29 Dec 2023 12:16:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2060.outbound.protection.outlook.com [40.107.222.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDF11193;
	Fri, 29 Dec 2023 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqdHWnFBsxfOmykj9yvKMigv8uGfxeUfS1VZNhs3mwVpDvbqxdVZJV+PNqLhFeAap0+r+NnN4muyWvXtgSeQAFRem6hj8KtHqz/zpLhImfHIZnGGStECF3PWuMQDsZA5Xgh1zfWjQCGi+WYdImsnGeViac1YDkPCyIjzr+2l7Bw1qYl4B39H7Z/jPrjk1Ucd7fvj6OuR+XhgNDjNE0kg8KF9N9OnBhUufHsvh5BZk5oqhIVuV4Ml54PvEMkfjD/EdNbGW8UnW6IEqIvkl4PHgCFcsI7fqqSz5jVwaJFKibSBGwHqz3W1A/wWElR7Rb6U8PGULTQTmN/vGdSj3aaEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6Q4MoHWzfJ+/LnfE+sBWsslpOJXWVQZW2adOZSBdew=;
 b=iWlvK3A7uJLlJO4Gkr0ey5XQWXHtDTk7uoFLk3zM9E3h7K5WH/VruLL20Si9n7m8VR5rUSeXLJNbo+XAaollOlXaD1rk2EEbRXnJnGi0ZKV5YYW7kPvKENlL56MOpVcmA+H4gJsk/bIo436aDT73TvMIxPC4S6tCRbwSiI9xjRvywE8yh0JmtEb0pAjbd0IXZxZ74IxqCx1uDJwg15c1JA5nJbFVxwNjenlEyZUfsjtDsRvpXUuW0IW4Ib21pJtFo0E5lCNdWS95zjVPiaqoNFeSQ/SwZTRMrgLM+hQUm1asRBlNjUB/X/O52qYmH+poyVZxGCFAEGuG2wogehxMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PN3PR01MB10228.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:16:13 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::54b6:4ebc:13fb:818c]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::54b6:4ebc:13fb:818c%6]) with mapi id 15.20.7113.028; Fri, 29 Dec 2023
 12:16:13 +0000
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To: stanimir.k.varbanov@gmail.com,
	quic_vgarodia@quicinc.com,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mchehab@kernel.org
Cc: himanshu.bhavani@siliconsignals.io,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: venus: use div64_u64() instead of do_div()
Date: Fri, 29 Dec 2023 17:45:04 +0530
Message-Id: <20231229121504.3479594-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PN3PR01MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfa8341-305b-4d75-64b3-08dc0867f2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uSuboL+RWE81VpzvinLomqv6+kRs7R5a2vh3RcvLjJutCtrWV4hCtDF8fhV8Du15Jl4iFXqSV/nsNk8W2hjSR5Ko9Igh/+Xx7jXQ8FcebMN+u5FASsb0V8xTHDWcywRa5di37GNOwkpDVTZ8O5rub4rVfiqXbn2jUAKWeXz69Fb8CrCakR2u2i62wqAUKNDuZkZtxLAga21/WYZGgd1aCxP6Yxhyzky/Zwb8qljipixT6b/6Vk37lMqFvc9byrTexyQvgziG4e336XEdy8Yyhl9v8SDi7cPr0Vy04G/ide12OTxyJaX876+0jj6R9m1SjhkLIsuNZ9RdmnssTntmXbkSkIRCn3uSXhNRUSj47sFls1XxYX8hHda9kxWEpniKDsJkQ53skdbz5Tr6xtY7oDh2CoIpfp/d81S9jMUczUfNTgqVd5XN/uiPqKpZXtY2yh6t/kJ8inoWnxIkGeXbhWrOOaZe+XvsZ8brchPffg65E2Lw6/Mh3cCd84rSgHHMG1Ro6Dkk//1J53f3Cz4X/fPZStVhhZ8eb6HKUYURxmNUH1TZet4irYpWMLuJliEuQ26QbvVmIoHIp0svMS+BFLPq2yk8bckbvfYJiU+rKzj5sHO0DPuZbsys42mULls45NgkLR2iW/3n1OnveSznTIezrI3b06yub0Hzd226TLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(136003)(376002)(396003)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(26005)(41300700001)(83380400001)(2616005)(1076003)(38100700002)(8936002)(316002)(8676002)(5660300002)(4326008)(2906002)(7416002)(44832011)(478600001)(6506007)(6512007)(66476007)(66556008)(52116002)(6486002)(6666004)(66946007)(86362001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jZYRekuezD1HakyZEMEQFUBT7rf+0X7n5E9FPekgm0HwuhXpKxsKqYbmEVWM?=
 =?us-ascii?Q?si/AA0/Jz1SKCBtGQ3Y8uz/2g995FkHk/AVK2H078wFLS5e8yhDFvvXefwqJ?=
 =?us-ascii?Q?xbCOJXJ+744VqMBiqe3Batrh5yQZmk7WsZU/HW7/wfiKK//aD6V5fd92N+Am?=
 =?us-ascii?Q?UpIJxZhrcmEhEhESEMXjxbAdHZm9gtp18afUbnTdCYmCezuXNg0MuPWJzh4I?=
 =?us-ascii?Q?grs7F7lIUGvrebFsXtOmWs4qTCXYzLkZnMPRlUCO5LYu95YFi3/kFSys8Pid?=
 =?us-ascii?Q?F1hmiTrERwvyo2cF8KMKK5o//t4c9mgO2NlN5rJjpQVImzFuxE22zFjFYXKu?=
 =?us-ascii?Q?642niYbCU4Mk0s/z9apLbPgdtE7cO6l4nVusGyUubbh04ZcaEi4+PVW0OZ5B?=
 =?us-ascii?Q?QUfqLJ/ZKaDOx5YLoagFrx2RrsC8ebQ5NVeSWQgi23A+NlOOFNTzY8Gw/6Eg?=
 =?us-ascii?Q?VEM2gtKYDSmecbqEgPt9q6tdtJtOC+z3gjyZH+erOfFvv6r/kaORTeCiIneu?=
 =?us-ascii?Q?VCm0WZP8VdqIjSYvBDrWwHDs2VvsTAr7FwIBRdySMGlsF2UuPcoo5KYNiYhe?=
 =?us-ascii?Q?kIa8+MjyIzw7u5D52MBAbFazQf/pMjFe3HlLmpfK79kq/Wi5IdwKmfpzQua8?=
 =?us-ascii?Q?OywTsGpoaYXAH8znBiIOxdirB36wa+EcyFWhHe8u7ceD/wZ4F+9xj7Ti92nJ?=
 =?us-ascii?Q?csVfsvy73+K71+b6DG2Rit7KQTyN9N9LzpX9nz/RZv7rcQ6Zab4eUGB1Zedb?=
 =?us-ascii?Q?avqydvgRMqJwnGglz4jrf3YbMLr1+fazn7/3if+UJWf1Ivoqbu0JZ6LUz2dR?=
 =?us-ascii?Q?QfFQInhH2jhlk7ENXjxbAq4PARKTqaUvG4OPfH5Jl8ytrw2a8ot8u4ZKTKVZ?=
 =?us-ascii?Q?i4h1BdM0DB0gyAWw3I4Q3VTMo0K4N99hV5LXDqIdsACzvq05Zzr0E1MBUDTl?=
 =?us-ascii?Q?KY9oUZwlg5AhHC3pt9RDeVgydTBN0PxbwFRL3kttFaRam/jRRXpUJPuRsTNv?=
 =?us-ascii?Q?IV5rRFgQ97dvrX3Q6Tm3TIC9WKHWP1UxyV3KCzq/9N6sXRvMbUbZDXpAeJOh?=
 =?us-ascii?Q?I3yvXVMvF72RkGsLWP430Ske0iDwcX4t+fipoL1czrJ44Y7p2Y3e9KPeU36u?=
 =?us-ascii?Q?cA2dktQwE1vJO9sNc76xTrdvKir3oTaezI+vazaC7JwhvcxjDvMwD+gjQdp+?=
 =?us-ascii?Q?mHf8MPIVcvoqHvQP1Sqt984/WRO40JTidIOqvBJWpftxob3oafzvVKexTZod?=
 =?us-ascii?Q?hdoh//MQfAYU+ySQCNMIozPqG26CP0HwFc1DLpplzoAeXyJJvqxTRUtf89kA?=
 =?us-ascii?Q?BsT3eIrpzPopnG8eq+2LqsaRy6+jaNoBbo8WqXqhuwq9w4k/ZV1lEb2eNp0S?=
 =?us-ascii?Q?KPV/SRZLJHMAazq+YD75FLLEbiPfK036T1UKTW9oAtrR1K8I55s9qX3j9XxS?=
 =?us-ascii?Q?W2VgZRBoTyZQsVsml9Yiq9slhQ3t3WnCwd4t7RGtNZ5VvUjwbCPzOiTcXx3r?=
 =?us-ascii?Q?7suBaESFbM1bbS0J/BfuNqTJ54djR7SVvBV/fB5VsxQS0kk2tgmbVSoFoWKQ?=
 =?us-ascii?Q?2K/b/+TbenAuS/QzWjpMQFX3C3i2ghzfifhzOQW/ND5RjD2Yd8ORm54RwKyi?=
 =?us-ascii?Q?8VRdk6hfSpyab+1ShZvv/fE=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfa8341-305b-4d75-64b3-08dc0867f2f1
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:16:13.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0oioEHDNwtb/rrr0+nlwQUX209fcOUmGiNi1sqIjnQEHhI1xRxUjRxJAeR77afHk8nm/J09z0ptjqt2ETw0IMwwSMZbwnKLMSFQTP/VtKu1pYZ9+e2WDdynVdkSlrzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10228

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.

fix do_div.cocci warning:
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 44b13696cf82..81853eb2993a 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -409,13 +409,13 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	out->capability = V4L2_CAP_TIMEPERFRAME;
 
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
-	do_div(us_per_frame, timeperframe->denominator);
+	div64_u64(us_per_frame, timeperframe->denominator);
 
 	if (!us_per_frame)
 		return -EINVAL;
 
 	fps = (u64)USEC_PER_SEC;
-	do_div(fps, us_per_frame);
+	div64_u64(fps, us_per_frame);
 
 	inst->timeperframe = *timeperframe;
 	inst->fps = fps;
-- 
2.25.1


