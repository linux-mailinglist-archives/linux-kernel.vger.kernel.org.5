Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D007DAE52
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 21:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjJ2UtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 16:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjJ2Ust (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 16:48:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB4FD9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 13:48:43 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A05F420BF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698612522;
        bh=CZ05zwSbIcchFahU+bSausQMNazT3la51HxfbHwy+5I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ier4G94AnYhfTlDAHRKNE2GKW7x+MPhU/zOeUXgPJQkWo5yRVEN9AytyXB6v64aWa
         n4I/kVvy98gGB78fYXJJfNfCUVO9oFC9hrk+8JlkmFZYdvYdIx83N7LJsTquKkh/V8
         BDLWB9Gc+OYby84N5DaTBGvlDZ5h4G9Ap5i6DpYTMzgsPLeXPyW3Z+MVgUtkjWyp7b
         BmtQmW7Yq3QyNh7fqzmnm1VV/aRQWxIKzp7m3jC/bMmUec4h9YSaBJ/30B0IUW0b2a
         ybh2QproHXFsfwGQSSRGO/4EYbsV2FbvfOzuNKbiNmWq5t+KJAXIT1uGyuK5i4Gb4q
         VpqhB2q5VigtA==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso1805962f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 13:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698612520; x=1699217320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ05zwSbIcchFahU+bSausQMNazT3la51HxfbHwy+5I=;
        b=IMK4Xwq9fesMgwhW9ElZS3TEbuMxmPhLAYgEcb1NsVZS3MdxRsF6qowugvlwm/PooN
         cO3W3KCMPu9li0VtttsN3W+YyNEZ+SEs8fwDukLc+6yO0dzmKnaPJLfCEyhZN+z7ivlN
         QaS3z7IxYnluIN2s7W0ItE65bZYbSZdx3GQI3Z+uUAWkNIJA0/xk7Aaj87BtiZwzkoCR
         jrdZ6CCEChJlbBKbcNHGYxK4l/Vkz4q2A+nKHeWJQf6dr4E3oC/WiiZs9uuDmjihB2AV
         usrkLSH3T+Q+fv6JxsOXmUB6Z6FvryWb2V0I44ASJqBIHja1kWiAjA/yCeq0zcliXONo
         lNiQ==
X-Gm-Message-State: AOJu0YwT01lPIRWuDa5PzCjOEUa75v1Fnh3kS2itPdjr9DUC9sNsWZZV
        uOkTeDCWOy3vQC3A1lOu22T3zGmkFf8qFCn+D6+Mdwiyw/pcd0/wCFdEATUP4FcFaN2JrAgkdW6
        2N3CqOiKr7uRmHEl8NDw1R0+pgK4F/0whqde3MqTDpQ==
X-Received: by 2002:adf:e881:0:b0:32d:7162:7ffe with SMTP id d1-20020adfe881000000b0032d71627ffemr6439300wrm.69.1698612520289;
        Sun, 29 Oct 2023 13:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3296prb3EpPU46aNfWMI+tY2ZtonmUuq5do3RPO8Q2CMxhHwePLbXIh9Z2jhDbnqlm9vTAg==
X-Received: by 2002:adf:e881:0:b0:32d:7162:7ffe with SMTP id d1-20020adfe881000000b0032d71627ffemr6439283wrm.69.1698612520054;
        Sun, 29 Oct 2023 13:48:40 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id d2-20020adff842000000b0032d9a1f2ec3sm6661495wrq.27.2023.10.29.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 13:48:39 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     simo@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] crypto: drbg - Remove SHA1 from drbg
Date:   Sun, 29 Oct 2023 22:48:23 +0200
Message-Id: <20231029204823.663930-4-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

