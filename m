Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3D78DCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjH3Sqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243048AbjH3KJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:09:14 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE551B7;
        Wed, 30 Aug 2023 03:09:11 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qbI81-009BwB-Nx; Wed, 30 Aug 2023 18:08:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 30 Aug 2023 18:08:51 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Wed, 30 Aug 2023 18:08:51 +0800
Subject: [PATCH 4/4] crypto: testmgr - Remove zlib-deflate
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>, ardb@kernel.org,
        kees@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
        ebiggers@google.com, gpiccoli@igalia.com, willy@infradead.org,
        yunlong.xing@unisoc.com, yuxiaozhang@google.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        qat-linux@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Message-Id: <E1qbI81-009BwB-Nx@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove zlib-deflate test vectors as it no longer exists in the kernel.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/testmgr.c |   10 -------
 crypto/testmgr.h |   75 -------------------------------------------------------
 2 files changed, 85 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 216878c8bc3d..ac8c6fff76b3 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5772,16 +5772,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(xxhash64_tv_template)
 		}
-	}, {
-		.alg = "zlib-deflate",
-		.test = alg_test_comp,
-		.fips_allowed = 1,
-		.suite = {
-			.comp = {
-				.comp = __VECS(zlib_deflate_comp_tv_template),
-				.decomp = __VECS(zlib_deflate_decomp_tv_template)
-			}
-		}
 	}, {
 		.alg = "zstd",
 		.test = alg_test_comp,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 5ca7a412508f..0cd6e0600255 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -35754,81 +35754,6 @@ static const struct comp_testvec deflate_decomp_tv_template[] = {
 	},
 };
 
-static const struct comp_testvec zlib_deflate_comp_tv_template[] = {
-	{
-		.inlen	= 70,
-		.outlen	= 44,
-		.input	= "Join us now and share the software "
-			"Join us now and share the software ",
-		.output	= "\x78\x5e\xf3\xca\xcf\xcc\x53\x28"
-			  "\x2d\x56\xc8\xcb\x2f\x57\x48\xcc"
-			  "\x4b\x51\x28\xce\x48\x2c\x4a\x55"
-			  "\x28\xc9\x48\x55\x28\xce\x4f\x2b"
-			  "\x29\x07\x71\xbc\x08\x2b\x01\x00"
-			  "\x7c\x65\x19\x3d",
-	}, {
-		.inlen	= 191,
-		.outlen	= 129,
-		.input	= "This document describes a compression method based on the DEFLATE"
-			"compression algorithm.  This document defines the application of "
-			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
-		.output	= "\x78\x5e\x5d\xce\x41\x0a\xc3\x30"
-			  "\x0c\x04\xc0\xaf\xec\x0b\xf2\x87"
-			  "\xd2\xa6\x50\xe8\xc1\x07\x7f\x40"
-			  "\xb1\x95\x5a\x60\x5b\xc6\x56\x0f"
-			  "\xfd\x7d\x93\x1e\x42\xe8\x51\xec"
-			  "\xee\x20\x9f\x64\x20\x6a\x78\x17"
-			  "\xae\x86\xc8\x23\x74\x59\x78\x80"
-			  "\x10\xb4\xb4\xce\x63\x88\x56\x14"
-			  "\xb6\xa4\x11\x0b\x0d\x8e\xd8\x6e"
-			  "\x4b\x8c\xdb\x7c\x7f\x5e\xfc\x7c"
-			  "\xae\x51\x7e\x69\x17\x4b\x65\x02"
-			  "\xfc\x1f\xbc\x4a\xdd\xd8\x7d\x48"
-			  "\xad\x65\x09\x64\x3b\xac\xeb\xd9"
-			  "\xc2\x01\xc0\xf4\x17\x3c\x1c\x1c"
-			  "\x7d\xb2\x52\xc4\xf5\xf4\x8f\xeb"
-			  "\x6a\x1a\x34\x4f\x5f\x2e\x32\x45"
-			  "\x4e",
-	},
-};
-
-static const struct comp_testvec zlib_deflate_decomp_tv_template[] = {
-	{
-		.inlen	= 128,
-		.outlen	= 191,
-		.input	= "\x78\x9c\x5d\x8d\x31\x0e\xc2\x30"
-			  "\x10\x04\xbf\xb2\x2f\xc8\x1f\x10"
-			  "\x04\x09\x89\xc2\x85\x3f\x70\xb1"
-			  "\x2f\xf8\x24\xdb\x67\xd9\x47\xc1"
-			  "\xef\x49\x68\x12\x51\xae\x76\x67"
-			  "\xd6\x27\x19\x88\x1a\xde\x85\xab"
-			  "\x21\xf2\x08\x5d\x16\x1e\x20\x04"
-			  "\x2d\xad\xf3\x18\xa2\x15\x85\x2d"
-			  "\x69\xc4\x42\x83\x23\xb6\x6c\x89"
-			  "\x71\x9b\xef\xcf\x8b\x9f\xcf\x33"
-			  "\xca\x2f\xed\x62\xa9\x4c\x80\xff"
-			  "\x13\xaf\x52\x37\xed\x0e\x52\x6b"
-			  "\x59\x02\xd9\x4e\xe8\x7a\x76\x1d"
-			  "\x02\x98\xfe\x8a\x87\x83\xa3\x4f"
-			  "\x56\x8a\xb8\x9e\x8e\x5c\x57\xd3"
-			  "\xa0\x79\xfa\x02\x2e\x32\x45\x4e",
-		.output	= "This document describes a compression method based on the DEFLATE"
-			"compression algorithm.  This document defines the application of "
-			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
-	}, {
-		.inlen	= 44,
-		.outlen	= 70,
-		.input	= "\x78\x9c\xf3\xca\xcf\xcc\x53\x28"
-			  "\x2d\x56\xc8\xcb\x2f\x57\x48\xcc"
-			  "\x4b\x51\x28\xce\x48\x2c\x4a\x55"
-			  "\x28\xc9\x48\x55\x28\xce\x4f\x2b"
-			  "\x29\x07\x71\xbc\x08\x2b\x01\x00"
-			  "\x7c\x65\x19\x3d",
-		.output	= "Join us now and share the software "
-			"Join us now and share the software ",
-	},
-};
-
 /*
  * LZO test vectors (null-terminated strings).
  */
