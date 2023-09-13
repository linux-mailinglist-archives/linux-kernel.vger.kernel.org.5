Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F224C79C2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbjILCW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbjILCWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:22:43 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 81628171A36;
        Mon, 11 Sep 2023 18:46:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 8ADAD6059D7E7;
        Tue, 12 Sep 2023 09:46:07 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?crypto/api:=20Remove=20unnecessary=20=E2=80=98N?= =?UTF-8?q?ULL=E2=80=99=20values=20from=20tfm?=
Date:   Thu, 14 Sep 2023 02:17:27 +0800
Message-Id: <20230913181727.4004-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tfm is assigned first, so it does not need to initialize
the　assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 crypto/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/api.c b/crypto/api.c
index b9cc0c906efe..7f402107f0cc 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -389,7 +389,7 @@ EXPORT_SYMBOL_GPL(crypto_shoot_alg);
 struct crypto_tfm *__crypto_alloc_tfmgfp(struct crypto_alg *alg, u32 type,
 					 u32 mask, gfp_t gfp)
 {
-	struct crypto_tfm *tfm = NULL;
+	struct crypto_tfm *tfm;
 	unsigned int tfm_size;
 	int err = -ENOMEM;
 
-- 
2.18.2

