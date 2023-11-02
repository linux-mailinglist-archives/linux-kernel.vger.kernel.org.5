Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7B7DEBB1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348389AbjKBEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBEKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:10:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2057.outbound.protection.outlook.com [40.92.90.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E90AA6;
        Wed,  1 Nov 2023 21:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0zb98I4ce7KaR+UVf71qO4ZgwLzhL6uDAiL59EZogcUTfkcEdpWZA0Y9Iiq6+/53sIC03p6Q7HhD4iUlnDLu9fmpv4gDRS2Kyq62OPhcEDUEDMxzZAU2WJJPuT9+osvCCoY9a5fTriTj7HmyVK/gu2+kW1rhz02GDoET+Zdh6/sx1q2076vX/UE7Xh45E9gJOg8GoY8VR91+DQGnqNIICncEnkqcN7c9WM7IVH2ncYY5db8UumbJdkliKMYdm/paOGMvBPXRwkE53CgsWsEnPsIKQ4ThnB3qlQyaEVqEWZgBv7NxVwDREcaiw7RUgouuoAZ2YzlIziuAL1jgxK2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wcOa+tsOZyxZpZEhWPM6+CTfXxj2CHGNX0aaU09gog=;
 b=jgYoddlUUOAT8CGwhCK9vWTEnGT0r1H99r3EHIquHdzON/jxwvLXVXMuWGLu9Q0tO6/FcNYNPF3yInXLiQperYDRrFdJSHvA5OqvUYjlBk7G3NWC06vw7EXGjxlZ2EXlecL+i3d5bxT8uYt4YhG4pw1/GImE7gxn2NgyiiUzjtF22mgus3kPEsXLML4VpwTbGddVakQOxNlck90dxQ5oN+hQsm2coOKBlBEZKAbE62VHG5qc9HuxH+vNTK44mQX+/b6fyvY7f4NGT/xIIW9Jt7WA+E1ljGGCzyt8Y3YrhRe1wRuQrlxMfgtIwjOaoYkRI/Tkk/+AaeDfyjWEChyXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wcOa+tsOZyxZpZEhWPM6+CTfXxj2CHGNX0aaU09gog=;
 b=Bzwg34ioafKrS0/hs+f2yLAU4Ye/8jqDkahNLdFPWy5qISPNbMbOxdR5XHWdcTEEh9JhxkzQZEY8QK0Ap2G/h2LvyECi0UmzjIt3zFEsjwZ7ctFoueDrN+t5cm1yP4GAISQdDHl39i0uC6VhA/dDZsumARhdVMhKvOTWRw/FQAQ3zgle0Ulnr5zh44nge1JDDj+jdIYwItdTSC5LarKYwG6mRzTkCdtDFwPoMeDw2xjNUU2yG6t1iuU5LUXxyY/h2WoIG780m8JG2gJoRVo+pGNhVQv3rJu2bA5l41GCmgh8YBZs9ysxWzkPjwnzQQOqFy7mItLX9XDsfbuvzOTBvw==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by GV1PR10MB5868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 04:10:13 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 04:10:13 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/7] crypto: Fixes uninitialized skcipher_walk use in sm4_aesni_avx_glue
Date:   Thu,  2 Nov 2023 09:39:25 +0530
Message-ID: <DB3PR10MB683563927062940224A92AA3E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [w6Syl30sjH5NK25I8YCUT1AkXkhAvwIu]
X-ClientProxiedBy: JN3P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::14)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231102040931.1556061-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|GV1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: db7faf61-55ca-461c-bf97-08dbdb599c80
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FljDe8Yq3hSPZXikv7PwhCQDD/eECjeYoepF9TC7B6/8dSZFhH5uOCQ+C/wkHhq+he/sr9DoFQJUNgWjUp5DWfp79LSIlsJZMw8gOtK70yfhoacdZAADQaKnjLz93rP+vDvVSJwx3TAnTluqxttXgJ9JjEDvUFIV6QweiHOC0fXMwSrOUMcCsb1CCivUywTa9aBz909tX/R0+e8hbPQXg3jM1kpdk41p+fhsH6g4ARZk4Esi2Q0oB/wyRzFjs9hdy/XjQn42ttA0x2SKheKn38pqLnWoxaDnHmJc+zIOi0osb7rbzxR+S4rzrqfQ3BFaLGfX/hK92jA7Ei5rppInAFcZqLTH2gMVT4f4+A4MmTDtH13QKepBvX0jflKnxrLa6mxfpikvZHrLTvEhfG5oLVVcqJBBbbw1ItU9HAnC1Jdy5n3vPG9hyA/b13EyWP7RxAMAIROPBfq9T0IgNP+8zfKlF3bhVXAWsCzLKBaj6JZ3E6f8j95wizqCMgcgki5C+zrIimzvNPeuzyM8toK1XiO0qp176hsCHdifrlIJF9EuG67HbEa6L+fpewAGjxaloQKyWGfe1UH6zcfsdDAcJ0gDvNXGLIGi107FcpcgHCLitRX2btXQVwAc4VERXDAY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPrxYWE/6lN1hFzYvbF6PaKvmr7LAZ+ygmEEGytO8lCs0Rb5JppVVZYwFIl4?=
 =?us-ascii?Q?oMy1SjOtiOaWxIZWc4p6cUjZGcMp/8DyHCInGBxe7ZIlheBooWBNN+YdcNTG?=
 =?us-ascii?Q?jXo4TDqpi6uP7xpUgutkDP9OyKzC/L5d3UjhPihxDgox6s/la6CoKpOHM/xA?=
 =?us-ascii?Q?Q6urHzajqGz7uEcC/wfdTKl/Y7Brt9Vn47ff74eR/w0Y0fpugk6KriNwxov/?=
 =?us-ascii?Q?uwZ3y+p9gKJxjoGavlYFpqPNGPI/vTgAdmWtdPklEQvlBwk/Gfihj3Yh2wwL?=
 =?us-ascii?Q?mBVHUcSag6hJSwY+dUkPyw7xE9Qrouwo+X/+cbYoGaLOI2R/qSJ2aMeZdBqI?=
 =?us-ascii?Q?jk11TwaNJ2fsdnVbN+gSdGlmmSk5uUMVuzTMrJZPI5oP062BpZJSsRsJ1EMz?=
 =?us-ascii?Q?agwIdnQUshPYKiapStwvXxg+/SgRqdRYPfzJAJw/7lBSsM3EsqslT1drQVlC?=
 =?us-ascii?Q?8vKHwfCUO2Ku7/Z2k2LrLvd+JjY4EehLPq7LB8b09BFDeI6PQjSVFFcwZDeC?=
 =?us-ascii?Q?TVITo/W6/saBZvS8ziF6LZzAlS80cN5/qLi4hSAO6ZspI47imiRU5p8+mQDY?=
 =?us-ascii?Q?EUcZJeiAPVJktMl7SExB/oyEYiVjlNVQdpfe4Q/lVUn9tInzLP1BGe6rVhXS?=
 =?us-ascii?Q?fKz9b3V/hZho4CAtHA23+D6wrMKB/yzqfmUMzgBOQVYRVoeCc3oaVHr7ipD0?=
 =?us-ascii?Q?6dAnnrKhEPMpZn4nc7zlvd1jyyun0T3VGb4HgDW6pvMpHtzg5llgj8TE85Lv?=
 =?us-ascii?Q?kVbpkySJ1l1SOgNGxgp6BBW5i9XlJyzTPXBrqQ1cN/QZCA83UC1BcjbZATa2?=
 =?us-ascii?Q?oNm+YD22nHN9R+4fTPSA7DdAvZ7u96qf61a/i163mzo/ZqMh2Dv5Tr0XYZ/k?=
 =?us-ascii?Q?H1heF391liB47RTKl6bvwHMtzWsM9mdYed+IchXob6Ja5KWN5EnltjHUMLNM?=
 =?us-ascii?Q?vKatWR4osOxLW0lsuvoXdXbTQd3y+TXgmj8IQXEILCnqyJNW4ZIO8Os3egD2?=
 =?us-ascii?Q?bQrnmjAJH60TpaBhAVvuzkFGXk8YSXYHtmJLRLERiWxaYqtJyLTRKjxqTXpD?=
 =?us-ascii?Q?UIifUz9Xjllqhxn66TBMvfwou1dR7bS8+7CLZtHR4sntnv6i6JfuSH6Warhl?=
 =?us-ascii?Q?Q9UpQauiIibplTwhHhqZBg4Plukx9ycqN/c/OYSpsczrIzV8jGHTgSE7Mnd/?=
 =?us-ascii?Q?mWPy8+fgZqV5zGUwm+wbqfQdzWefCl8eJ4n5aW7bidBJ2VzeErANAUCpdHM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: db7faf61-55ca-461c-bf97-08dbdb599c80
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 04:10:13.2634
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
 - `sm4_avx_ctr_crypt`
 - `sm4_avx_cfb_decrypt`
 - `sm4_cfb_encrypt`
 - `sm4_cbc_encrypt`
 - `sm4_avx_cbc_decrypt`
 - `ecb_do_crypt`

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

To prevent this, this patch ensures that instances of `struct skcipher_walk`
are correctly initialized prior to their use.

Addresses-Coverity-IDs: 1491520, 1491533, 1491610, 1491651, 1491715,
                        1491774 ("Unintialized scalar variable")
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 arch/x86/crypto/sm4_aesni_avx_glue.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 7800f77d68ad..4117c6f787e2 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <asm/simd.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
@@ -44,6 +45,7 @@ static int ecb_do_crypt(struct skcipher_request *req, const u32 *rkey)
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) > 0) {
@@ -98,6 +100,7 @@ int sm4_cbc_encrypt(struct skcipher_request *req)
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) > 0) {
@@ -132,6 +135,7 @@ int sm4_avx_cbc_decrypt(struct skcipher_request *req,
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) > 0) {
@@ -196,6 +200,7 @@ int sm4_cfb_encrypt(struct skcipher_request *req)
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) > 0) {
@@ -238,6 +243,7 @@ int sm4_avx_cfb_decrypt(struct skcipher_request *req,
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) > 0) {
@@ -307,6 +313,7 @@ int sm4_avx_ctr_crypt(struct skcipher_request *req,
 	unsigned int nbytes;
 	int err;
 
+	memset(&walk, 0, sizeof(walk));
 	err = skcipher_walk_virt(&walk, req, false);
 
 	while ((nbytes = walk.nbytes) > 0) {
-- 
2.25.1

