Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14FF7DEBAA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348455AbjKBELE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348466AbjKBEKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:10:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2041.outbound.protection.outlook.com [40.92.90.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B0187;
        Wed,  1 Nov 2023 21:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6YRdFrL6UzgfQvf9WNDZsm4wjYzJEB+1cwhTQgIQFtRcJOA6LEqaBfud4zsHoxeTDgnp5jotkEgQzbzJbxsvAN5amJb2VN099VVzNZngO6h8gAYDCL6V75ngP+N/n0tvJfw6m88KqMsCMpfbhjB4+B9QAfTYruEswDvRcSssXUCVZvkqDg/C4+l8OpSk2I2WyxnJ/bFYaTlu4nw3ClULCQQa+siDnWBZfBj394BM1cWoYD1io/Eey0FKzsAir0GbRSLedICj2eaVc3WBQzmdjSvun/Lmo+jtGh6Ex4NgnzlAJtiROdx5h/HSdVG+RVe7tiJ1EQDWcEd6mTfRGnTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfSBBLteRiuXdLAIFXKCCpZsImmreLdZ58Ml9IJhNw8=;
 b=FEtaXb94vw0zRqDpuBqADz3iMA6NPZCnjPIcJDf0VMKITKLzxZcdAzuCfQT/gExEqyy4IrzlduFoHm1rrSKp+XqhlKmqUnWR+FZ6SKt5cXVaf0hMLZmhrRfXw/5F9oneEBfxjAkHB9o44+mp1qh/QRWT0hnEtn1E4y4D44xCRn+WzR+sNaEH5yS8BdK4ZCbvM5QmfCyL8wBti1QqmMueP9pl3F88o7M4FdbtwbSB1nZgtkEvj+LFZ2A1FBVm8Sx+tfxLKDQUFGZsW1+K8r1ACUSXtRNF8JAMMgpEsIZzgyJ+ZE07sP+fT++D6DNC8g36dgywvdNu24SnT6iz0a8rVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfSBBLteRiuXdLAIFXKCCpZsImmreLdZ58Ml9IJhNw8=;
 b=TmnNVZaKJwA/TUpYY8XIY663mwoUHWrwo8++/1+nzZYahEuPNwilYIpeN0QAacVeBYaUdtQGDj6rhUlYb1MDj99CiWez+88sCJd/xPY2plfREMU8Vh40QMFJMZn0a3wJJg1LHUc7hV9GOwsz4n27JxKGTjhvZGZuCI1iUgF2a5NdJZSVR8sfWr5RcjGXjNaJ5xATDrg+MrrHhq5cxeEOyD27XwN3qKoD+flfJywRDzbrvi7rB8rnotDIAHuHoVrLcomHxVcoEySCoPi6hmBS477yp5j4Lfql5cKe/iYPUlfgrkKtfstOwcX3dCRu+8wWWrYCnwkEVtJQFIzUQ/VrxA==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by GV1PR10MB5868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 04:10:31 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 04:10:31 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 6/7] crypto: Fixes uninitialized skcipher_walk use in aria_aesni_avx_glue
Date:   Thu,  2 Nov 2023 09:39:30 +0530
Message-ID: <DB3PR10MB68351A58094544C38A0AEEA8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102040931.1556061-1-yuran.pereira@hotmail.com>
References: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <20231102040931.1556061-1-yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [/oigyYCK5XkWm9Rcjes4dPZobOVN6Puh]
X-ClientProxiedBy: JN3P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::14)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231102040931.1556061-6-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|GV1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: f78b361c-1da0-487e-e9c7-08dbdb59a725
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JxyLjrijro/XqjjJOUoU9gtU33fDRIH9X+KhREFrgastYrhqB3R6mmAznPl1T6U8jMor6YV/2P+wZ2GEllPo/jh6QUVQun3gJP9qIG02ZXYIjhcAikpTwDv/o1jjrCLYnNk5A7HCKFVfng7x1ezLi7yiPtRdb7H76rOU0IlPSzXFa7UltUD5hgTuCGPIb7XQTZ0vxFAwMyhdsxt8vr8wE1icdQVb3C1nImQQAf01AtFlyyQnEqKXe/urXNdYOLSergKJaVvBKddxlXxxeNsArqQpvbgO0LpKSrsYFTF4+sfWr0/gJUzA5yUdVn0/fT0zrSCTwvgxawFJuBVwckWfkQn0IHpLAyxOnkvap9CeqAc23dKd0K9m7IlCpPg3sOKP57IDdzNB0hgQj6LGH+3ulU0U2BjCiaJ3F4qIg1wtgQhRB1MjIZRtBLTT0uhJ0HuCu3P7N81CNO63u/cfN1dg9xRSD7vv6JBv5LKSKgSxszwqEuMh6snycExTpglPY7BrxlOEVdgbdrWP89F4B3khbmASfOWA9DZt7IrDrpkot2bw0qGD6r4fTnq/FhewJAnYCkEJZIhg2tjhAQUYWHa69oIGez7nT5nwbGEztxP3/GAeDo1z8fPok3pHeyI8sMj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rtCcf0xLTv7bddXkKuwZCy1vd6VAFTRpuO6lkUs747DYTn8D7f1osrI7m50K?=
 =?us-ascii?Q?Ru73lkM9FI7zz7zSaoeDvsOsXxHk8MN4hrm69l47Wz2wirOmQtWE5NwsvIHD?=
 =?us-ascii?Q?Nl0fcLO26hIn0VsxNArmEi3xIRIV8klNB7prrOL294gX193KG4PO77C3/Gro?=
 =?us-ascii?Q?BNgYRFoMugzURZAUr2rSFBMIoPZxRhvHd16klhYA9mgg3M2oK/IS1ww+Nyb0?=
 =?us-ascii?Q?8PNxh8hty1imP6VlF6fUuZKRnPsWq/sM7SffB9Ixya+dhnCWQ8lww6MaHtoG?=
 =?us-ascii?Q?/BEaHKSrwLks8Avs7ghXGjNovywRk8QJEj2XhTkGS+CZbsPhpsuwG22LtmgV?=
 =?us-ascii?Q?iWPgHAmMHaaP9H/BQC3RKS6w4CpLPIfSFFcnyGgG+m6UK2uY1crkblBkvfCF?=
 =?us-ascii?Q?fKNYTzVKiTWM30ybXfhhu+ZpEsAbH6syxJ/IfSLVp6t95Q8t+sOnJ9ydbmKz?=
 =?us-ascii?Q?z8+vVqx9nZNIzRv+uMovY7SH3JZiRe5aWKYVpZIiBJFTXJGcH9Dh/Hj8ROoq?=
 =?us-ascii?Q?3O+9AqBXfaEwjEHu3QwojhsPnc5oGzIYmzbzYe6iKvsd07Zl1IhpIcOEJmw8?=
 =?us-ascii?Q?IZa92e/nfSNYCxXOsLvI3MVN5GNELFQJXgjvuFxJi6XWV7nNEB8+x1Cmc2Ip?=
 =?us-ascii?Q?NNCdZjzm6hgcgq3HK4ma0kr7AC9etoPDmFwu7HwCedgb8mBbpShwYTiP4p3Z?=
 =?us-ascii?Q?nNe6byGmzJrBNc+haKAP3EyyUQNHbSNoC0u+sAtXozxzFeNnodzgQxHBGM1G?=
 =?us-ascii?Q?uN7JfHd3O7x0Wz8u7Z23tXqBNYsGPq0qf5XjZEnxnM5pQhyOfTkio7672nP2?=
 =?us-ascii?Q?3sJBEGta2HS23xNbBAsjsnenMNHK7SDIFVQeKVz4Eatu4N34wD1qlwNoZ2CJ?=
 =?us-ascii?Q?BQ3ISP8VXkgM3RwCDiYriP/5nmcGR42Jj8pkQH1YjZSQeSUj2XwVLxazDO3U?=
 =?us-ascii?Q?AQK9Hb724mfvc6ggErc/7h5fK/ASmnHmKPQ826/wnP5YN6xipO4/fjFZ9sHr?=
 =?us-ascii?Q?xfWjga6zJhg8bQWwW40M9zop52fCBU9mEXzEFsZdvg/eHSaubOBmlATClLMr?=
 =?us-ascii?Q?qprJsksCjNwy1yPzxHjmK1phyIlD8bFTw7qGgBM3Q5fwsb7EneiiD+5cO3Tr?=
 =?us-ascii?Q?vf5RHO1hUvWqueFRvcCLUx/2zv+EYxui38hpMxJUQ3wEtBJF7lwAPNcg8OsF?=
 =?us-ascii?Q?u7+H988PjLEVNCOJRuuEAjkTuxiLRbuvmW03yt8JaJyLuN8UBQ5n5v06ke0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f78b361c-1da0-487e-e9c7-08dbdb59a725
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 04:10:31.1214
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

In `aria_avx_ctr_encrypt`, `struct skcipher_walk *walk` is not fully
initialized before its use.

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

Addresses-Coverity-IDs: 1516269 ("Unintialized scalar variable")
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 arch/x86/crypto/aria_aesni_avx_glue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index 4e1516b76669..71589d58d0d3 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/string.h>
 
 #include "ecb_cbc_helpers.h"
 #include "aria-avx.h"
@@ -92,6 +93,7 @@ static int aria_avx_ctr_encrypt(struct skcipher_request *req)
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) > 0) {
-- 
2.25.1

