Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1B7DB97B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjJ3MGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjJ3MGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:06:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539721AA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:06:00 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 367E13F1D9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698667559;
        bh=euOHMKbk4HXdz0uT+/ZbQgWhVnv6TwkCQv8wxSBXEso=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VN/+/SoZd+s92QbdYMv3tJ3OcKS++Fc6m7K5FQK1tZJswxlEcln3Ta3o+hsLAa75Y
         RLt9tGFlP+LSbqNbmytLw286q/W96dzn73zxoLwUgZ9SWRLA7f5qYmGClZaoWyQx17
         D/s0K6AIqzqf+0bJgr43aIPqkWEC3ILHocCsCVffmkF5Hyc1UXQ364aryoYiGPxkoU
         mVLiFN/TdjmI2p925arm4fO8h4/B460Ki8lwyNvcSuKc3HVDKLVV4SdjIl+D2R9hT3
         LljluUJR90L2NTi11zKha9XWSKM7yFpeW+eomB4gyCb/K6X1hlPQnne0kuByb8RX67
         /XpOlcZ05QOBw==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50798a259c7so4737124e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667558; x=1699272358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euOHMKbk4HXdz0uT+/ZbQgWhVnv6TwkCQv8wxSBXEso=;
        b=aAFYAxFmQv1mT/wYaSrAAgPGZosRA+/J4UjZq/X1twp+C+CCJmTKR2C+LYL5A8pfaT
         5afDeW8LMbUzt4tWah61NO5rtC4aixeBMLk5QsMK4K8j+8BjJJxfzECKNlq/HknbO7GC
         c/4ekP4oLoeLyA+w/2bS98+QHArQoOMQ5SS1I56UG62kaMV0WRx2Ok8SwdsITsXZoQP9
         0CDgVHveHhszWvxCO7d9SwQ37xdQvdWKtqhkNLJK7+I5AzpMvChNw0h+LJqXozNOXcer
         lSjidtEGhExW2Kez8Vqkj/pafDzgNjF8ZG04jFyMi5UYMpXrryrXWsuIhpUhKK7k48q2
         kgJQ==
X-Gm-Message-State: AOJu0Yyjff4NmJKNLl4t05VoqW/9KHKGJ9deykj/i2EM/cGGsndh5P/z
        KxtHmnb5+N8GFa8KN3vleGJMtvsQeAapnPdtJBz9JoZwQwWgK8LB7KYMSYhZQi68l3naLQHp9JC
        X2bpi2cTaNK36PDHn+C7dUEZe7ItxRR5ZVGWhAiXUOA==
X-Received: by 2002:a05:6512:1116:b0:506:8d2a:5653 with SMTP id l22-20020a056512111600b005068d2a5653mr9066696lfg.47.1698667558568;
        Mon, 30 Oct 2023 05:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHobGoxATHBl1iHIySw8NC+ytmlfmxCTt4WgEOGt3ZVe5k5kQZ1w74gV7uAK8lEOt8it1GpZA==
X-Received: by 2002:a05:6512:1116:b0:506:8d2a:5653 with SMTP id l22-20020a056512111600b005068d2a5653mr9066667lfg.47.1698667558264;
        Mon, 30 Oct 2023 05:05:58 -0700 (PDT)
Received: from localhost ([159.148.223.140])
        by smtp.gmail.com with ESMTPSA id o19-20020ac24353000000b00507962dd2aesm1416736lfl.207.2023.10.30.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:05:57 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     smueller@chronox.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] crypto: drbg - Remove SHA1 from drbg
Date:   Mon, 30 Oct 2023 14:05:16 +0200
Message-Id: <20231030120517.39424-5-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030120517.39424-1-dimitri.ledkov@canonical.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
 <20231030120517.39424-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SP800-90C 3rd draft states that SHA-1 will be removed from all
specifications, including drbg by end of 2030. Given kernels built
today will be operating past that date, start complying with upcoming
requirements.

No functional change, as SHA-256 / SHA-512 based DRBG have always been
the preferred ones.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/drbg.c    | 16 ----------------
 crypto/testmgr.c | 25 ++++---------------------
 2 files changed, 4 insertions(+), 37 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 99666193d9..bccadaedcf 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -139,12 +139,6 @@ static const struct drbg_core drbg_cores[] = {
 #endif /* CONFIG_CRYPTO_DRBG_CTR */
 #ifdef CONFIG_CRYPTO_DRBG_HASH
 	{
-		.flags = DRBG_HASH | DRBG_STRENGTH128,
-		.statelen = 55, /* 440 bits */
-		.blocklen_bytes = 20,
-		.cra_name = "sha1",
-		.backend_cra_name = "sha1",
-	}, {
 		.flags = DRBG_HASH | DRBG_STRENGTH256,
 		.statelen = 111, /* 888 bits */
 		.blocklen_bytes = 48,
@@ -166,12 +160,6 @@ static const struct drbg_core drbg_cores[] = {
 #endif /* CONFIG_CRYPTO_DRBG_HASH */
 #ifdef CONFIG_CRYPTO_DRBG_HMAC
 	{
-		.flags = DRBG_HMAC | DRBG_STRENGTH128,
-		.statelen = 20, /* block length of cipher */
-		.blocklen_bytes = 20,
-		.cra_name = "hmac_sha1",
-		.backend_cra_name = "hmac(sha1)",
-	}, {
 		.flags = DRBG_HMAC | DRBG_STRENGTH256,
 		.statelen = 48, /* block length of cipher */
 		.blocklen_bytes = 48,
@@ -648,8 +636,6 @@ MODULE_ALIAS_CRYPTO("drbg_pr_hmac_sha384");
 MODULE_ALIAS_CRYPTO("drbg_nopr_hmac_sha384");
 MODULE_ALIAS_CRYPTO("drbg_pr_hmac_sha256");
 MODULE_ALIAS_CRYPTO("drbg_nopr_hmac_sha256");
-MODULE_ALIAS_CRYPTO("drbg_pr_hmac_sha1");
-MODULE_ALIAS_CRYPTO("drbg_nopr_hmac_sha1");
 
 /* update function of HMAC DRBG as defined in 10.1.2.2 */
 static int drbg_hmac_update(struct drbg_state *drbg, struct list_head *seed,
@@ -768,8 +754,6 @@ MODULE_ALIAS_CRYPTO("drbg_pr_sha384");
 MODULE_ALIAS_CRYPTO("drbg_nopr_sha384");
 MODULE_ALIAS_CRYPTO("drbg_pr_sha256");
 MODULE_ALIAS_CRYPTO("drbg_nopr_sha256");
-MODULE_ALIAS_CRYPTO("drbg_pr_sha1");
-MODULE_ALIAS_CRYPTO("drbg_nopr_sha1");
 
 /*
  * Increment buffer
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 216878c8bc..209b21ef79 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4849,14 +4849,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.drbg = __VECS(drbg_nopr_ctr_aes256_tv_template)
 		}
-	}, {
-		/*
-		 * There is no need to specifically test the DRBG with every
-		 * backend cipher -- covered by drbg_nopr_hmac_sha256 test
-		 */
-		.alg = "drbg_nopr_hmac_sha1",
-		.fips_allowed = 1,
-		.test = alg_test_null,
 	}, {
 		.alg = "drbg_nopr_hmac_sha256",
 		.test = alg_test_drbg,
@@ -4865,7 +4857,10 @@ static const struct alg_test_desc alg_test_descs[] = {
 			.drbg = __VECS(drbg_nopr_hmac_sha256_tv_template)
 		}
 	}, {
-		/* covered by drbg_nopr_hmac_sha256 test */
+		/*
+		 * There is no need to specifically test the DRBG with every
+		 * backend cipher -- covered by drbg_nopr_hmac_sha512 test
+		 */
 		.alg = "drbg_nopr_hmac_sha384",
 		.test = alg_test_null,
 	}, {
@@ -4875,10 +4870,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.drbg = __VECS(drbg_nopr_hmac_sha512_tv_template)
 		}
-	}, {
-		.alg = "drbg_nopr_sha1",
-		.fips_allowed = 1,
-		.test = alg_test_null,
 	}, {
 		.alg = "drbg_nopr_sha256",
 		.test = alg_test_drbg,
@@ -4910,10 +4901,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "drbg_pr_ctr_aes256",
 		.fips_allowed = 1,
 		.test = alg_test_null,
-	}, {
-		.alg = "drbg_pr_hmac_sha1",
-		.fips_allowed = 1,
-		.test = alg_test_null,
 	}, {
 		.alg = "drbg_pr_hmac_sha256",
 		.test = alg_test_drbg,
@@ -4929,10 +4916,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "drbg_pr_hmac_sha512",
 		.test = alg_test_null,
 		.fips_allowed = 1,
-	}, {
-		.alg = "drbg_pr_sha1",
-		.fips_allowed = 1,
-		.test = alg_test_null,
 	}, {
 		.alg = "drbg_pr_sha256",
 		.test = alg_test_drbg,
-- 
2.34.1

