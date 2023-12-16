Return-Path: <linux-kernel+bounces-2118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FD815817
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9751286F32
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC78134AF;
	Sat, 16 Dec 2023 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HWt07bWH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2070.outbound.protection.outlook.com [40.92.23.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD412B79
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQp5M2q6073ImiQ+aAsMk/0Qdgp65eI8YmC9QWqWCOHoCyE+CVIQq2eIRlkBUL753LeFdc7Hv43h6kKKbPHvnIxETiY18cXBq9yFXP9q4391X2yfnb6rfXoACZ1G8Rio/xGJQ4StIlaXYdFspBpXmuhLHgGHEooFr0X8rPDmpD2emk6l5H7qgKKpKQZXuWXNyl4eu5AeIFqKThfsIRNRimDu+f/nPvt/8B1dZjtwEzIfc+GEbDJfbVwPYAAKWTwggeVJ3X/1+fTCX+ivwOx1TlNqTb02NCLUZyG+ed/P1OCJY0HVzFHm/iXOHdXVLwmsAb572Ma726DwCAbDGNDpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abAJ5kPmTCKSkPlTNRUH9LBbaGMSWSbCDFVeXVjm3gQ=;
 b=cGH768K7qRgO0mxQYi99HHNzexfJaJM2yp+YZU2LXiUHkFpvikobKyu/hGE3HgznwXAIXZNSd1PcYXg4OETDbmYC9QeLLbet5zSFw0kETpmoeOd9YgW9ErSjn5XjAOUGRKzobk4Lb942rOaOh/zf6aTrTyRP85vXK0c8RBqqo7zCwok/rh+7pj9BEg3QuDjPobUd0BkGUeaTCjODQ90rVzFgkcX2awNkMk2MVIFEwgZW9f/BJei8PP4TxJUWGOmuNZ7IJGpxwZ7sLbbmjtBxXGlAcJPS+wc+MK8QN0ZMJ1z6QLMsBfCSnRWLXBLYf6wNugV0zffCz4stRDAHwhbdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abAJ5kPmTCKSkPlTNRUH9LBbaGMSWSbCDFVeXVjm3gQ=;
 b=HWt07bWHF+Qyz6S4jrdfk8d6E8OjK7BW9I9e/b1WIw2oaMefcb+brMnhRNP55H0OMqVz7HeVDdOdI/3gonRyB+RXHytYxMQLYispLNW6CnQGfbXHKBf6WdLq8nXBvHMr9gLzZ5LRxSvR9iCK+zaxPjx1+aDONItjYVSZH4Y/TsUO0/ukwAmd6dvWdlgLKkomg3hn6XalqCgeL1PJ4Bu2L+tX5alutaczQ6IV5um1v6yhC2f4wBS5o7pIPSrJHlkJx4lEIxOCgHzs6YJVcBcDwuVVFunAeVLzbqGd4uNIdPJX35zc1uY2wEnaKv8H/fYsOWlHQ/JYVxhg0rwcMAllGw==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by CH3PR84MB3446.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Sat, 16 Dec
 2023 06:58:10 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%4]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 06:58:10 +0000
From: Youling Tang <youling.tang@outlook.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] scripts/decodecode: Add support for LoongArch
Date: Sat, 16 Dec 2023 14:51:28 +0800
Message-ID:
 <MW4PR84MB3145B99B9677BB7887BB26CD8192A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [+HyFnpBF9Ct8ndhMDd3urKf1zhJaSGLxEUg2xNBT3jQ=]
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <20231216065128.24664-1-youling.tang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|CH3PR84MB3446:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e095ec-338e-43bc-2adb-08dbfe045cde
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bartCEEs3gtx0GZRT+6jt1pUAIHjhoHWKmfRvzSMZigfJY0WV4d+iudKCsWMIsWa8xslBqR5wQO+xtxrtbzQxaPLoa5cArLiNsft3JtOv2j9FIRTeKr2E3rezuZzSSWzA/KY/y17VAnkobZdl/w40pkyZ6rfmenQs/mwuQu8Da4Rf2K8LbTTPF7RQL87IA3cflu72zNZz3NJddF9RnZ1giuMLpWaptrWHgMqHQTUrVTIKIiembrEOY3xIvgf/hSoZ6ZhWP0en3rqAKS1vKbsqRmHhmexSavzI0h8ZbMIXtt6L3qkJB5OxFtlh91AblYosUdmpcTgxkabu6VqN+h1hUBPEDUAtDBijVYJo2szS3PPitZO1eT0ynFdnVkzdNJXvwqgjn3NtgXwNjIeLtwlCgpjzRdMw5WeWWNw52zOV5yNj9mX6wGKROq1dDVfZkpZnz8RYDRn7k5yJ7hPvA/ADd7eGk5QvYM2vDA4EQc/q4Gp3NPeXxRFR6DC61FPX7bZ79elGZBE8HanLpnrjUFc8VC+gulXrlf4yJArSo2Hr2m8Ev89sShAbKmy93cnEQJZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jxpLDn+2q5z+LXcKeYjOSj8GSqe8LJ/BCWObEMkJIuzA5otML6NaJYnbHUG5?=
 =?us-ascii?Q?jT3kgIFJOhoMveqMwxpuK7nipKuyHLAf9WD/NnnN6yK4xIYArXitFcNDXwUP?=
 =?us-ascii?Q?3Pv/3ApuMAEoKtzuzJhAR4zeRAquBaAhH5IdcUajlvnP6JVXgkUYuRp6DfYE?=
 =?us-ascii?Q?taC1RylJ8K8bAelu8Bnjy8VgU4zouqG1WpBk4+Dl5NWdS4s6M6NJ7sa+GGmP?=
 =?us-ascii?Q?BTceIKu4bzRk2RcQUFSM5WkwkiiXmNpUU90oSyu3nLqdyz0BseCv7Q1Kwmjw?=
 =?us-ascii?Q?xDIUOyIvasosqJj3pfSHdLbvVI33UlsS/eM8MYPFT/Ng7S7dEg52eUCpYZF1?=
 =?us-ascii?Q?wu8h3VFdapTz/ax2F+qEkMwoZEMSPZqqkXAJyxOumPIzSUB8KXpfSr1olfym?=
 =?us-ascii?Q?R9hGjppXddzPtR09KsuvCUD9ZG6k9gsUj7kFYFMY057Xki0xCYVCYECYLh7N?=
 =?us-ascii?Q?kjAMhBusNNjrmelq/SJQ5ZAYT5LW25DQf9f+9RceK/pBfkQDwh16PpT4MNik?=
 =?us-ascii?Q?UOKL2Alb9LbLHHjBkjA2jC30MIiB3bVp2H5lvY3Npgek/W0r6s7L9CK2pk6G?=
 =?us-ascii?Q?gMvYmdXcoecKtuO7d/Q8x8BezqOnuVTf44CBXADCY7BjCZkn/EppjcfUxNJf?=
 =?us-ascii?Q?FYWHpgF1Y4PIYrc3DpCmnJ5ZPLhY/3byjc072qNMW5CaHUqE4d584U3I/S9C?=
 =?us-ascii?Q?k2oM0jjGRF/TqBq+y6ZCUP9u0JMvuSBkiuslYGxSAxefYsX1CrDXOGho484x?=
 =?us-ascii?Q?+F2e0s3LhuiUV5VdoalpN813CDotsDbHnKaclKEjL2nJeaJe8j+416P21bEf?=
 =?us-ascii?Q?At8z+1RIt0KkJg4UoHbQJBrR55+IXJmJoYULXzS8OA9oaOwvdQqPyQBdyZQz?=
 =?us-ascii?Q?bkr5WrxMUgrKJpgp4zSP+HPc7Zut8YEF+cNXi05WJsZnmgrNsFdhnFoR4xKx?=
 =?us-ascii?Q?nSA8qLb/5svzi6201Yfsqf4rvnMoXoWONsW5oT9J01E0udBzsVpVg0cNAMvl?=
 =?us-ascii?Q?9cr49Zb4MKTfAn7IOfnJMyrxAR/TBcYCe1L9YXMSCkpdLwUT4yI2zOeZYN9Z?=
 =?us-ascii?Q?+qEA2dPtiqM7sX4hPoc3xmwGTKx73dvZtUcmX4oXyczFFxuW8B58SIMqlAtK?=
 =?us-ascii?Q?8oCpp4ZopoirEiIj3CX7oNmHl7Nx3vZ5gDor7/JS0wJOrJenlfpToyuF9WQx?=
 =?us-ascii?Q?zifCEnAd+gglSHMSELXx75I0bsx3HmoX/M0jeGX1IKo+G1b7D3la3OrvgiE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e095ec-338e-43bc-2adb-08dbfe045cde
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 06:58:09.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3446

From: Youling Tang <tangyouling@kylinos.cn>

An example how to invoke decodecode for loongarch64:
$ echo 'Code: 380839f6  380831f9  28412bae  <24000ca6>
  004081ad  0014cb50  004083e8  02bff34c  58008e91' | \
  ARCH=loongarch CROSS_COMPILE=loongarch64-linux-gnu- \
  ./scripts/decodecode
Code: 380839f6 380831f9 28412bae <24000ca6> 004081ad 0014cb50 004083e8 02bff34c 58008e91
All code
========
   0:	380839f6 	ldx.w       	$fp, $t3, $t2
   4:	380831f9 	ldx.w       	$s2, $t3, $t0
   8:	28412bae 	ld.h        	$t2, $s6, 74(0x4a)
   c:*	24000ca6 	ldptr.w     	$a2, $a1, 12(0xc)		<-- trapping instruction
  10:	004081ad 	slli.w      	$t1, $t1, 0x0
  14:	0014cb50 	and         	$t4, $s3, $t6
  18:	004083e8 	slli.w      	$a4, $s8, 0x0
  1c:	02bff34c 	addi.w      	$t0, $s3, -4(0xffc)
  20:	58008e91 	beq         	$t8, $t5, 140(0x8c)	# 0xac

Code starting with the faulting instruction
===========================================
   0:	24000ca6 	ldptr.w     	$a2, $a1, 12(0xc)
   4:	004081ad 	slli.w      	$t1, $t1, 0x0
   8:	0014cb50 	and         	$t4, $s3, $t6
   c:	004083e8 	slli.w      	$a4, $s8, 0x0
  10:	02bff34c 	addi.w      	$t0, $s3, -4(0xffc)
  14:	58008e91 	beq         	$t8, $t5, 140(0x8c)	# 0xa0

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 scripts/decodecode | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/decodecode b/scripts/decodecode
index 8fe71c292381..6364218b2178 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -67,6 +67,7 @@ if [ -z "$ARCH" ]; then
     case `uname -m` in
 	aarch64*) ARCH=arm64 ;;
 	arm*) ARCH=arm ;;
+	loongarch*) ARCH=loongarch ;;
     esac
 fi
 
@@ -98,6 +99,10 @@ disas() {
 		${CROSS_COMPILE}strip $t.o
 	fi
 
+	if [ "$ARCH" = "loongarch" ]; then
+		${CROSS_COMPILE}strip $t.o
+	fi
+
 	if [ $pc_sub -ne 0 ]; then
 		if [ $PC ]; then
 			adj_vma=$(( $PC - $pc_sub ))
-- 
2.40.0


