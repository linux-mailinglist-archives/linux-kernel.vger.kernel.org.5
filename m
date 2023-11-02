Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB77DEBAD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348430AbjKBEKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348323AbjKBEKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:10:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2057.outbound.protection.outlook.com [40.92.90.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9944D127;
        Wed,  1 Nov 2023 21:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLebc6O+aG/efxPzoplBZYbloa1qH+zMxHTtRceVl24kgEEvro8pRKPBWn4b73jwPtEUzxlvVDRr9aZcc0YhJmzoI3grtqWyuCauIvGQpRRDtccfpiIECe6GYYhS+905FCiCzgPTI6Br3Q6PErsptRGpnV2k4PB9+c9Pn+BcobjMsDd5IqO5nuxtURGl76Fzy9GRkhOo6nAaEVEDBt4EQRG9eV1DNE7PI+RykcZUhEdSOGBooJX5LacWO2B+/od385tbTvE4IDT/uW8v/leTEEfoRJCxBUmMqyrfXVQFiWmMXhpJovVhvCLP+26Pw8UXdXC4L6YO2LxCjVRx50mlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D9faqvwN7odn+OIaTCNqi3uJC5WdGKT0RVYNo+RheU=;
 b=LTnxyOB1GbQ7LJqtS1qGvaii/wqiW892+di/Jxw6S1rIJiqUpW51pL+xfWkVDL3xujsIoXQOYNPNryTfi+lZQKikcHNeXv6GOE0YRSsrXUVv6y3kM7D9Q7gz/DF/FOjPjzBThC2KxdAuSEZQ0dxzjtkYLImANU+Su5rsJPyZYeHO+PNuHtzPKXs6cEaMyNrsky0PAF9/xIChiKLOurgDK4tGKPqOm3ViuTjJWT1DGaeKc+wSVSIql4Eb3KOxsQ4FTaOrsM0UDbkawy49FtmARFBt2+2lTOiaNsF5tJuAG0EwbOXdeD7VR+ZLIpaI3Xn947dJFDOJTnkjS+DvD1dNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D9faqvwN7odn+OIaTCNqi3uJC5WdGKT0RVYNo+RheU=;
 b=Vqg8YbzPkLpGWC+sYI9gpSWo1JVJuPtN88I7PK/ZHepfNWCg/Rr6jA2kpHBfKDjHugAGVzu8l0SKKfQHRDDtVOPUZpDBIwxfApERp46EZApAzr9spy9xRSXgNj4WWqUSVFWeAVM7HmdSGT2aMH1mWpXytrWqWqShzUXvxWLf2wioPMfiUvuvzrDFAToXnqwGr6pIOJRrazFL3APRKm+tb/pUKuDfQqCEMG6I+6VOmyBH3lL9moXGR7hYePe9rKf2irhc2oCFB2DGyS/k2PNQInMhbgfYGFnMthw25/a0M8sVY8iXNsZ3XrZug/HaWIUvCJ+7CoPItP/QRZx6PS10rQ==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by GV1PR10MB5868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 04:10:16 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 04:10:16 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/7] crypto: Fixes uninitialized skcipher_walk use in des3_ede_glue
Date:   Thu,  2 Nov 2023 09:39:26 +0530
Message-ID: <DB3PR10MB6835EB64DD7E871C722184ACE8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102040931.1556061-1-yuran.pereira@hotmail.com>
References: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <20231102040931.1556061-1-yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qMMSgV97n9JMWg2pFVIDSB+D1ewAymla]
X-ClientProxiedBy: JN3P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::14)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231102040931.1556061-2-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|GV1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 133f025f-19b0-4b2a-315e-08dbdb599eb8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpJPBhiV5CkJadCdNBCrPkKY0uLyXJE9c9whtg77RKbgdCWAcGdi3RZH6StLEMoKlGNhyMQY4vpXyiQ3U+k0pnm0XFUjFjEQi5UQp+AIHlXXM1UEbjGxyClpxIGgQQ4yXQI9rDpZJ619CU00AFFWTd6GSeRLZRXt1tJ9+ZsEwVgeSWXcX50HhgI36JAfX8GJhuBKb3cqF5+hv8zYWx7DjNuGKm4f1R5ic5NCQg2xgfBgb0DihtgpCeoPcRulLRAjSlZUfiD77x/iHP8guXjRht09X/1D/vTLx21LZhTINseStExDQO9/5jXO3pVi7+zhbZX7BFSUE9m9doXkGCbg7qzlBizyNdI2+b9dg+9D4wgX7hfHTJ2RwSGJ6gkyS/m8CYewccpNFjyeWPwLyiU6DPFK4tOzWjtbXZV9V84Zeutm/YXEwRchXbo/m3GZuzzUbamM/JhKqIH+ZYkwPPCGeK9M/CBwCCMCr0mpXI2C6BVl57/rFbIZRWKkP2P5IBdwTevhZRVa/27ug8XU9s85W+jDCRYy/2NKR3jUNj6G09VlxHtjTVwFsoTCQwPJFYdQql71V8UxFHNEti2bhFZw0vC9l3dqC2ZET8du97IXMgiKmBLDZyJSD+24sZr8eDmG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9RkqZmRwxfsvzEA77eR8XLi8sCswBc6LiYSl1p7DKhzMXj+yCACLvpmyX9in?=
 =?us-ascii?Q?mN4TGtaNg+dVOYdmB6fSpfSR2VIxlRZhXgfbtFiELhcqaZRJY1gvFov1xYcu?=
 =?us-ascii?Q?yOQrscVVqkTwOegVrsYH/h3n5D3lLtO2YmP8dQ+bn0owPeFbS3CysECmOULz?=
 =?us-ascii?Q?fMf5GkGdKOnULIArzxORNQI7JPGOrDyJ3X1dW74PDOCdqgfFFyy3p14bx+jH?=
 =?us-ascii?Q?/7DDK34VbO7YHv5cJ0Wr8ajbcx/mSQc9nAHqUAtz4MzahatQ6ue8OY+wipFC?=
 =?us-ascii?Q?FsEBfEzbSVNuIMMNL8gr9sNOtcPg+6zJ83PlTwbqozZb0pkQ1wFCyY3ZlhY6?=
 =?us-ascii?Q?IJMIU6Eco+QrvKwbk0mtNh5Ji+shJxJfFZ4pRAOudafbxEXwgkOP7WenFMeX?=
 =?us-ascii?Q?opsdp1HETK5EvHrFR1v6TzUUxBX5ya8eqguX+fQwtLyfmSHhGKo0khVeY/r2?=
 =?us-ascii?Q?Ml5UmuegJGjpaZG8KlFPg6iEMdROOE96X9HsLBLffrFMdAn9OVj9yGGpkgRY?=
 =?us-ascii?Q?vJylAakxUYTOjBcg0yvECOYsD47C5CUJ/LacKFSJjE0NbIMJSADGYkt0G5Pi?=
 =?us-ascii?Q?uZ1Hf7XGXuDLU1AagrV94cMsY7S5jnGlM5g7BjzVNjqWfVaoJHGq7Yjgvp+X?=
 =?us-ascii?Q?9yYi3b0vzQFhwqmjyhEJ/XmbJVCennQ/1+0dnEn0QWio+Xl1Cgh02L7ydSiR?=
 =?us-ascii?Q?0q6R0HBsCvP2RrvovMboy2qo6Q3P0EGamY1m20zaIgC0lOhUjSp3Av3RTIoM?=
 =?us-ascii?Q?1+uKIyEPMzuxkey+vdVTfc/8fOGARlVwMuQX6yjq94wPXucPy4i6KXg1+y7A?=
 =?us-ascii?Q?sXhs2jVM70lDfbYPiBrf7ynNEqns8a3OTbv4Hgo9Q1YIa0pIWCZMEq+bKiS1?=
 =?us-ascii?Q?aiOWLgYnexujKh/s1Z9+4/OHGk4/+AqZ1yeDN+V2MsupR2QDk/gJUSLQ6Bv1?=
 =?us-ascii?Q?++xS9IX22Ovzf+2fyl9+0ZU/Zc1AMnjtWMdXu+q7eroQaLnFdkbB5YXo8GkO?=
 =?us-ascii?Q?reN8vAN5Vktz4cDocqJkvDmbgIJthYQuVzXMD/Q9BMK6+94GEw7rRUnRw0HK?=
 =?us-ascii?Q?rPtb6CxJKpdq6wjbLVi0PEEqKYei8Wvi+W0BjOmN0v1LGjVBbMrL5CCwLVW5?=
 =?us-ascii?Q?YdMcnLzLLK2wXNzDbb+YBfFURBK6BfLC3ohrQ6N1VesQN1KwDVaMAi7mZFoS?=
 =?us-ascii?Q?0lxSXjdO6sc9hPm09WB3XgKcw35Q2px2GfAhx6Rhbq5P/gBGulmFk0ZNT6k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 133f025f-19b0-4b2a-315e-08dbdb599eb8
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 04:10:16.7758
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

In the following functions:
 - `ecb_crypt`
 - `cbc_encrypt`
 - `cbc_decrypt`

`struct skcipher_walk *walk` is not fully initialized before its use.

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

Addresses-Coverity-IDs: 1434673 ("Unintialized scalar variable")
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 arch/x86/crypto/des3_ede_glue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index abb8b1fe123b..6f16b09b52fe 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/string.h>
 
 struct des3_ede_x86_ctx {
 	struct des3_ede_ctx enc;
@@ -70,6 +71,7 @@ static int ecb_crypt(struct skcipher_request *req, const u32 *expkey)
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes)) {
@@ -154,6 +156,7 @@ static int cbc_encrypt(struct skcipher_request *req)
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while (walk.nbytes) {
@@ -233,6 +236,7 @@ static int cbc_decrypt(struct skcipher_request *req)
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while (walk.nbytes) {
-- 
2.25.1

