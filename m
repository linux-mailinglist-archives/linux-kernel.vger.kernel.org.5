Return-Path: <linux-kernel+bounces-11724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9581EACB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAEAB22197
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C98EAFD;
	Tue, 26 Dec 2023 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BICecrIz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2092.outbound.protection.outlook.com [40.92.15.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8D6130
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhW0GETb/LESvJa0ZAYCS+2cBOMNwmI7TnkDZ9XTw1t7fk85HoZIbxLDjiNEAbNzAFASAYSUfVYhzfI6TxO7O2c+wR9uKZlPfHPx27j3SXKN/3y9Qyg8seBCena+p9H9lrFikHKSeDSSSo6JrNSo93GwdBqFTM1S3I7n6zwT979ULOs3Vnw24/trd4zcnNs++wTM6I6ptYG/SN2XLnWcGSVwFbPJjlHpnw2FO3RTiUziS9oOzap5pxaOc7LVOYL4ggmiOIveVn58W9q39oMUSiliiZhzGHICGXD1FW6CG8kFB7h4eLYCFwKtdwcESLBDzpFFTIba7QfSGpQT98mVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBX9QKoNpdYAVbPh6Pn5Tr05SjLNSnmYgcs+6h8SzlE=;
 b=dH8ALZUbXi1nOf2ICKWyGSlORebhGFQyYd32LFvO93thkpIvgl5ggug2BxW1o43noCV7jVOeSg92I2YTAw8XRYXAINSbzUYHFjTYDAAwZs+fu2YURfQDyJMKN9baT2eNGz682NcFfXTHoklrfwoJlTHTxd9+QXIjJJTNjnfJQDJiFNi3d0XMnI7Gq2w/sCVIG2kL8wahz5uPLXsGXqoUbZWHFsKlBzz/cGU3nU4egsyCeL9FJ19Mc090oO2mTh51S3fE2gIHt9iEY+tK6MOFICnG1M5UB60Hg3g0E1yzOr6INDYOc64TZximOOe7N4y+faUkhx1xurh8Agva9FAQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBX9QKoNpdYAVbPh6Pn5Tr05SjLNSnmYgcs+6h8SzlE=;
 b=BICecrIz9B+OlcXC+6ugWXq1QQaHdv4gDRMs8rSFp8/ygpCTwCfQ4Bu1c5vlvYIP5CzNQsMGfPdkpKCUqjMRt93MtKacSWkd15hOUmFUXbFb6hdlUnOw9o/ITsXpfSKRL6Kp9RIMslq5VluXb9hRwkQ0bk2hD5b1Wd726JQJARRVf/EmMCPTjz9do4eOcLEmUvnKudEinvSOHt7gf2hFaih+PIbKxgxIegOaDOinHMn2EYbpje2HPFL0L7RUEMDixVmItApJN6cP+PaK79uhQgQic05q1SOjKd+T7qLDSnWaPtMdnPR1TaWar6zeRGum/XON/HKhXHuol/Trw3ZAQQ==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by MW4PR84MB3294.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 23:52:51 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%4]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 23:52:51 +0000
From: Youling Tang <youling.tang@outlook.com>
To: Baoquan He <bhe@redhat.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2] kdump: Remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE
Date: Wed, 27 Dec 2023 07:46:25 +0800
Message-ID:
 <MW4PR84MB3145459ADC7EB38BBB36955B8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Sy9jaD86H6QFFruIh/1VyHfmCWl75EINnwEH0FOe6II=]
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <20231226234625.6708-1-youling.tang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|MW4PR84MB3294:EE_
X-MS-Office365-Filtering-Correlation-Id: c89b3f4f-54f0-4a37-a3e4-08dc066dc4f6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HqMO1AjWKDPCQvfQc6Drd10obva9PgmSDmBG2QJO5E8B9yUS4/0ARpHBmUNZKCiHQwujfAhcI7DsnzZ1xt+z7yhimms4FWCkmK+w5vJfFpdVREcbLacX3vRQy2NdLwmSdm4nKDO51wizg+Xn0iVkcXNniIjskY7qL9S3bPp1sgqVN6XuXtuIduwCtrWugChPQr8aNlHBDFg2t+PUAkLAPTa3wDAo3VXEMImY2ZBDbFT9rjJscd6hoC5JMOTiBO3yNRN2BaOZ7XRkGNeKeI+tcsjfgvkvtX+Qrr3A8Gu9NTZqRSt0qg/PdG4nDKUmiMxaANB0dioxz1J9opXxJ+v2lJzjWgIke/Vury47l4CPrTDM+DXXnrR6pvT6LzomqqVcgrqm3D0C1fKhdBSQ7bhWK7udsyxMz8WRhNua7fMef+4Ou6UuydBTEQQe/qnxj2RBFyoFn8u89RHJJy08zhwzPGxlCOeSXfO5w463xeNmRRZhbEC50RO2rgXRVOZcyj+ACuX37N0KpsHJ2/vYCTMxDuYn7CIm3cItDae2mC3epGCvmI++XP0kLLYdJusbL3ue
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nuam3VqfgyVtC8QeX/3jG+qXMYWCdRK952tVz8p/1rnBjL7tGK4SlUnKwrWo?=
 =?us-ascii?Q?Vak2dVktF2ZHibWDrL2wMXa9IJs7F5ZizVySo0YiHF4ju+5w5HCNycKFKPXu?=
 =?us-ascii?Q?nkTzy6OhUjTiGf7G6O8t1zaKIc+yWthbbmmFCEk8LhEfOCgLMGTIXH7F4EEF?=
 =?us-ascii?Q?ClvHkFDhEXCjK99TarUGnhZ3xDuPzO/2swtbrujgpSCLzzdOGUtDcWBR0T+r?=
 =?us-ascii?Q?EIPlGqtmEBmRGay72zIJvrWWd7bYgUxCnB6dLzJ5giO+dyY/vEITM8p6hawb?=
 =?us-ascii?Q?oVdcELPE5h45+AJQLD8Sjl179Puz0b0h0rGFup4hai3PGpwDyRUHmyI1rZPB?=
 =?us-ascii?Q?VoWJ38pxgtRyDz3NlmgjAqfcIuAwjJZOxPDiowX3tA+Ar5nG2qu+Cp+kviGZ?=
 =?us-ascii?Q?X9WAjwEBwPzjab6siJb/8PMz7w/IfnVPimKXej9Bh0jh+Cr6nbYvhQwhxCOy?=
 =?us-ascii?Q?x8acoRVPM9Z8rJHyaHKcp5DsV7/o3FDGvWDrlL0T5lZNOOaerufCYm38KGiW?=
 =?us-ascii?Q?g9AqK3AitE4/9ABQfJ0SffLCeEiJsvq2JF1+yr9lHDe/+3YyTVlouQCtoZlJ?=
 =?us-ascii?Q?CL7LVilbz8BbWooTAiQ30NIR8R3Za+odau5BltE45w05yyMEkby+ksVRuxbi?=
 =?us-ascii?Q?iO1JkmrMv49v1yfwftHr0p3uXhdtTv3bcWjWZYOZ1dS2gVaDJazGzTTTtDDY?=
 =?us-ascii?Q?hQhI/N22uiaeaQ2MvMRTULgh2ngSkVmGCuVqmjqXjoJlqn5Vt0jjIj76qK1f?=
 =?us-ascii?Q?6NdLhprJnKTA0apOKOSSyDVlguMoCYM+SnTPKkagHTBcFOfqfr/r7yLGLXdu?=
 =?us-ascii?Q?mtXJLgzUpmECqyBS4cFGcMMgqBZ7CdIpb9CZ++P4/09JIrbe8/kzUHzQtBSz?=
 =?us-ascii?Q?4cWvW87sOuEGXPVVK8eXYbJIKHCG/nPLnnxzwtks2ruBZDJrniHxyYEHD7LI?=
 =?us-ascii?Q?fku8A7hnlR+J4NJR1erIKQeIBVAWuy7sjqWZq7Mye4CYlA6vTII3VfQh/TwT?=
 =?us-ascii?Q?7Oa+ls1XxkKJoXY3r2mH5m+oG7m0U9/GWy1gBPhqNjUBIzHt4Omj9imSnL/H?=
 =?us-ascii?Q?BcRUpBo3iSjMOFBw5+MX91OIVddbDbCMVoIky4WehhUedC7R7DZuXI7psGE1?=
 =?us-ascii?Q?yp/YNzpTgjZ0EgCPiG9PuEX+W4QKmeSXa9VR4XodSfnfnCc7xkGJBKAErPTv?=
 =?us-ascii?Q?+rLCIFQbdFGvZvnXF1irr8rVD0OOMhjxnVEpJQV5E58SR8G3oMktkjZUuvw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89b3f4f-54f0-4a37-a3e4-08dc066dc4f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 23:52:51.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB3294

From: Youling Tang <tangyouling@kylinos.cn>

Remove duplicate definitions, no functional changes.

Reported-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 include/linux/crash_core.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 5126a4fecb44..9eaeaafe0cad 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -87,12 +87,6 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
 
-#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
-#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
-#endif
-#endif
-
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, bool *high);
-- 
2.40.0


