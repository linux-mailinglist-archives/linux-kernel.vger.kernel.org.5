Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C77DEBAB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348443AbjKBEKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348417AbjKBEKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:10:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2015.outbound.protection.outlook.com [40.92.90.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E3E7;
        Wed,  1 Nov 2023 21:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViQnfXBjCLbcwAds1Lf54T9dg6oYnldCqp0+X32OXfIpOTpGyEC7E8OqqtMVU93J7CaWKLCbSE/3Ys5gGhUlMHzFuvo8UmV44z50wnuqwFC8NVGutmHjQFW/wYcP2N/MKVDuxPnhPMJqrwfJG9vlazsLkw1tK20QibYS47ZeyX4DhVX8MfMPYLqCNc1MUVsEngtHU2BgM2XeIufRz4n4WrEqZowiWsX9dIv3qMnnc8Z03va6VqjMlkSwdY1IVTHGuRrb0OCyLCSc+BvxeHAu7IPbKN5lV3lygPSy1qqUAUwlSw1pexbhTk9dNLZvUNfMBWo3G2qyzJc8N166rbSYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIu1e8gkymo0Mjuye5ETqHD4PRNOFa8JkqTLKQmZWKI=;
 b=ktgGkR97SPXTESlv//EaMjAXLsI0ha2VeSwTxydtRyc6GC9okWvQ+1/FrSOJ+yFD7cqUVUq54UiRAB2grPZXeen7Tspp5OPHhfSNeSO3+dbWCmbZnjudGBjdXgVIyjq6KPv6qk09oO7+5OH2RQ/lMGfcKSm2GzC9o+qvWzYYTGpndcFCdz3elxUrkjaJHyzI7s3ZPU+xlIOKdeOZfnHfdLGEq+2e7XzQDkEWjgXdwdIPWGDF2XRX287bdGMUhG4UczQ7W/Ac1gcLcTJQI86E59vN1NDf65LAScSJOcZM4kdZFUljLw0ifKUClSlDrW8ZgOAjvzsk2XSj+z9NO4V5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIu1e8gkymo0Mjuye5ETqHD4PRNOFa8JkqTLKQmZWKI=;
 b=iui/8T0nCc2cBudsBZAEu9q/0jBT40O59Hb5ldVOTco6bCYDNGrb9bubhHacW2FU+sZGxIDr9EwBFGh8bPkNqA69djRPV59PJ4BLdxSiPcC1M7VFs1pkBdt84fZt/2r0gWuyL0XtbltGInGJwiHpfaP4OdiERo+CraolrkaNtKgpovb5QLbOWPUz/siiK5XX8xNmDNChcWzOMhRCzaXICco9xZslPFYyV4+TekM0SosfMMSxBJOMGMN7Kirwi64ZeHbuF3sHxBZsngBj3dLTHWW5PJenZ2ARdn5nzE/TEaN5EJcoA7pGm8f/tB3f5KXViNhZNftQ4L3iaeQgGVjKuA==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by GV1PR10MB5868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 04:10:20 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 04:10:20 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 3/7] crypto: Fixes uninitialized skcipher_walk use in chacha_glue
Date:   Thu,  2 Nov 2023 09:39:27 +0530
Message-ID: <DB3PR10MB68353E2ABA0D6C1462385E6BE8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102040931.1556061-1-yuran.pereira@hotmail.com>
References: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <20231102040931.1556061-1-yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [aXHX50crGI1B+8V5f6WJd548W5WSNB2g]
X-ClientProxiedBy: JN3P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::14)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231102040931.1556061-3-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|GV1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fac163-5017-4033-0b5e-08dbdb59a0d3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1G76ybKfrAUrMoH8nOUosnKQggPtVX7magy1yHc6xbZPMOUNO9B1E1xgkt5MMgGxrvGx7sQVPSqRmPdNAWdVeMJvqQF22eEPIoYB59TluxTJBpkoeWc3whtFWu0Wo426wP52RydDDQp8aiSpbA9BSn2xTMurS+5f+tlOBNpsoSPpfELjildo24UNcao91hLc3QyE6y/M5K6UtVGSUNQWjqZzvXAkTubcG98uvlslGTcv1qHN+XtpKEgqhbVeMwUKqNZ0QLygqL8KWslgPOb2fmzuYL9mtc9N4FuGwIbq9Dl/alhgf1MDgqGmov9OiQ5FyV2kcFdTGk/lONN44DILObOO+T6f89sZUIkorh4zh10VO60KX8JjjsffERJHDEi45QDAaL4Y+tbGp1VDonz7teBvgwzxLXOfsWer00EnEjz0dRjDjs2W0cw5W2hVqbZycWG88Kk76TAoyz/6ArZMESCQMthVDq7fgtlgwIOIMDNoZqUGRIdppCpkLQ+3jvq/s3ljVca+L4z9cBPUOQs7j1tx5FDD99lOpJozpkL2VtjXSmCTOOTIE6Je9DH9yA0/2II8ot302aA0WD+TsPIJt4K8+NYu5RfBW5FcszPqUHO5LwHjMp71lMbCdw446rD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHL6xGGpys684XOThfHNsYJTN4jvWerIyG//4diq0MNa/Q2j8y04xvIwcEfB?=
 =?us-ascii?Q?Qyj5xHNPIOwyDADV3recGJV0qVX3JpWmApESo3cTV+h8MiQlm3f3bIPt3aD3?=
 =?us-ascii?Q?32NyGL9p1/d6BdCxYNu6tbVmc4UV3X5Q+tEhcGpAGvMIUnFgZEyyKRQtPeUP?=
 =?us-ascii?Q?+/dACWM2W4Wgc57bm+iJz2oWe2Kt49rcbnrYWxC+IVk9HvyYIzIc85xHl0xF?=
 =?us-ascii?Q?DdqJTlIO+sbWsoHaMbU1YyoANbRG4CjiISbUkLH23v3MN0Qxk47IoP+G/SIw?=
 =?us-ascii?Q?TPNLi7hUwFhcYIhcWALLfuxFN05YOIk8yNMXcUqwEPm2SiTgearh280c2XLX?=
 =?us-ascii?Q?wTyBptrlwJEZp+iUEOsCLHu/5E45jQIXZlz4k2809Aezvf5rVy6YMyulnl7/?=
 =?us-ascii?Q?firid+0jiGRM9nt3dCM6Wcmf8n6H1N1bDBIbTo6Wr3aNRy/0i7UppGIOrGf+?=
 =?us-ascii?Q?rWs1Tui0d7n1z9usIW6ya83xLoM+8HdGU4N09PmhPjiaWfrUItg29mnmxYnZ?=
 =?us-ascii?Q?1ok5Yni5G2XdRN4EHPfB3sksiafsP/D/7KM4p5r1JD7hGXrK9PiVHDl2QNE5?=
 =?us-ascii?Q?Q9QIFI2VL1rzvnT8a6Q5JWIRNRtVbAfjiCLf+MwOy0UF97eQI7dbIRky+qym?=
 =?us-ascii?Q?H+xtGs59V/bY7k2c3+83J8zSD2fNrRS+FsiPIgMtKodyz9tR/U9rb+Bwi5Mo?=
 =?us-ascii?Q?+AGFR9xZP6afD4GGPJ+lBoo/SdHCUnepUjdbATzcsq/S1IA2VLxWTzR6pyDi?=
 =?us-ascii?Q?DPT7nC5WTu5/aC/qDxGUaECys9Em7x+4FbPU/7XWoPSt+GCOFi3Wjh8F/Ugq?=
 =?us-ascii?Q?ECO5/DmjKAITzAUfL/xZP+MCZLnu7jwRpoEDnifDKtfZveD9S25XXp6jAiaI?=
 =?us-ascii?Q?Tkxipe8WWRUKxtlzRuzELsILlhqVeCTaFB5MAFlAjOQu5pnSWke3PnoCFG2d?=
 =?us-ascii?Q?e0NF07VB8AjZfcFoaA2VpcUvxaTAXN/dD5rubtwvNk/+HgXN/vJCB3yXpaBO?=
 =?us-ascii?Q?Xxa+V9gXiMITPE1Ry0yUjQOJE9lfrLl0Ulx4UxRBjVdtO9dq5QfHQPcuZ7Fx?=
 =?us-ascii?Q?xP75plUfDbaZ7Leq9z9SIT7recNKeT/CGJblq7mhuJdYPGrOB9IbSXPpyn9J?=
 =?us-ascii?Q?KtkCH0esZG6iDKPi/qPNX/Yy2iMaSjtJndUn0jidkRi3UjHg7Mj55/vnAsgG?=
 =?us-ascii?Q?L0ibnXivxn7Lv7evTbsF3r5EEQNFdnHqaQgRCNllaJ4y9vdZBER6N5S1lAc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fac163-5017-4033-0b5e-08dbdb59a0d3
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 04:10:20.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5868
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In `chacha_simd_stream_xor()`, `struct skcipher_walk *walk` is not
fully initialized before its use.

Although the call to `skcipher_walk_virt()` and subsequent functions
that this function calls seem to initialize some fields of this struct,

there is a chance that `skcipher_walk_virt()` returns
without fully clearing or properly initializing the `->flags` field
which means that the following flags:
`SKCIPHER_WALK_DIFF`, `SKCIPHER_WALK_COPY`, `SKCIPHER_WALK_SLOW`
could be storing junk values by the time `skcipher_walk_done()` is called.

This could lead to buggy or undefined behaviour since these flags
are checked in `skcipher_walk_done()`:

```C
int skcipher_walk_done(struct skcipher_walk *walk, int err)
{
	...
    if (likely(!(walk->flags & (SKCIPHER_WALK_PHYS |
        SKCIPHER_WALK_SLOW |
        SKCIPHER_WALK_COPY |
        SKCIPHER_WALK_DIFF)))) {
    ...
}
```

To prevent this, this patch ensures that instances of
`struct skcipher_walk` are correctly initialized prior to their use.

Addresses-Coverity-IDs: 1456799 ("Unintialized scalar variable")
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 arch/x86/crypto/chacha_glue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 7b3a1cf0984b..be8dc756d205 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 #include <asm/simd.h>
 
 asmlinkage void chacha_block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
@@ -167,6 +168,7 @@ static int chacha_simd_stream_xor(struct skcipher_request *req,
 	struct skcipher_walk walk;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	chacha_init_generic(state, ctx->key, iv);
-- 
2.25.1

