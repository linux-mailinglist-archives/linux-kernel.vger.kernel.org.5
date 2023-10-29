Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ABB7DAE51
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 21:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjJ2Us7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 16:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjJ2Ust (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 16:48:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEFBD3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 13:48:43 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EE2A13FB55
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698612519;
        bh=D+t9WK33ZVldEiPiicjGvkN9bUf9a57a5jRCbansvZI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=c07/edfiEaEi4fICDlTO2MFm46LEO1mbir3n97LwlBCLUS5ihJwoCCVMjzO+AChLK
         brh8ZIDE8WwqnpNHKg6svh8QH4SGzyeepgRgIPUYZaq6hDVGAb6PaT+m+/qPwPlDjM
         qKGcSSgJBiwoiQPdSwnbbxnx31A1iegL8cEwEO8NKIiym3sVuPlPCPHjqUKt4b46m/
         lXUtPyn1ZHM1nXckMHk0cMU+h5ZUi8DUQhZDLk2oUQ1dAOdPGi2OvNmutmxseUz7ut
         AiXxo4tiNnQ63o6U7KNnk906R4EznoJXvTodatL2i3XK7Ziz2XJhdQukmdVLYBh5Yq
         KtQnG9jx8j2zQ==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40920512cd3so27733725e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 13:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698612517; x=1699217317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+t9WK33ZVldEiPiicjGvkN9bUf9a57a5jRCbansvZI=;
        b=ZvZmAFKzfbFJO6fdjpj+IiQbVvfK6YohlJTxkm1+FXAi/uD4XVlVjQPlsK0TJ9MAqM
         pg88tjUBCrzjhwj17qP4cAzH56xy5kbCrHPHh6/KWDPaFM8Tdt1R8BzPYTMckpOFLdtG
         ElirchjcHsRk2atiUAzG6lEthmU10mrQyDLqKpTjmbWCVTtYFucWApo5PzLiswzpSfCw
         HmjqvIIOcg1o9eLn+PVgZj6J+vEvlag+GdRboCHOAlmFLGNOCYeelBkuws+VQh3MzyTs
         PSNOuN+Y/ZQkpcDG4X5lJQSPb+48U7XA6jhXIdYgQzfPKuGkhe0Px5SM+54hkatywoKV
         XaUw==
X-Gm-Message-State: AOJu0YwrVYtt52cgjFWEWJgciSipiOF5wfLsQJPsfPIbDBJhQ32Gug7i
        hQnK5YJ5bn9h3t2bhzYig/bNLD464HYkK78T5yq5lxmVlj1FW4b1OPySdhIyFOZNs+VjOqxUg2u
        nDi+iZSIQ/CclfL7RMlq0ySEFUXc8W5kbcKFnnPeADQ==
X-Received: by 2002:a05:6000:186c:b0:32f:7c4a:4f28 with SMTP id d12-20020a056000186c00b0032f7c4a4f28mr3694528wri.65.1698612517404;
        Sun, 29 Oct 2023 13:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsHenVmm1UaPVZaYRrLCgir8dk0xL3UaoH6fChxyf4x2jNAP6txXUbdB0H3Py4ubLecZFXcQ==
X-Received: by 2002:a05:6000:186c:b0:32f:7c4a:4f28 with SMTP id d12-20020a056000186c00b0032f7c4a4f28mr3694518wri.65.1698612517100;
        Sun, 29 Oct 2023 13:48:37 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id y2-20020adffa42000000b0032f7f4089b7sm3382079wrr.43.2023.10.29.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 13:48:36 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        simo Sorce <simo@redhat.com>,
        =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] crypto: drbg - ensure drbg hmac sha512 is used in FIPS selftests
Date:   Sun, 29 Oct 2023 22:48:22 +0200
Message-Id: <20231029204823.663930-3-dimitri.ledkov@canonical.com>
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

Update code comment, self test & healthcheck to use HMAC SHA512,
instead of HMAC SHA256. These changes are in dead-code, or FIPS
enabled code-paths only and have not effect on usual kernel builds.

On systems booting in FIPS mode that has the effect of switch sanity
selftest to HMAC sha512 based (which has been the default DRBG).

Fixes: 9b7b94683a ("crypto: DRBG - switch to HMAC SHA512 DRBG as default DRBG")
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 crypto/drbg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index b120e2866b..99666193d9 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -111,9 +111,9 @@
  * as stdrng. Each DRBG receives an increasing cra_priority values the later
  * they are defined in this array (see drbg_fill_array).
  *
- * HMAC DRBGs are favored over Hash DRBGs over CTR DRBGs, and
- * the SHA256 / AES 256 over other ciphers. Thus, the favored
- * DRBGs are the latest entries in this array.
+ * HMAC DRBGs are favored over Hash DRBGs over CTR DRBGs, and the
+ * HMAC-SHA512 / SHA256 / AES 256 over other ciphers. Thus, the
+ * favored DRBGs are the latest entries in this array.
  */
 static const struct drbg_core drbg_cores[] = {
 #ifdef CONFIG_CRYPTO_DRBG_CTR
@@ -1475,8 +1475,8 @@ static int drbg_generate(struct drbg_state *drbg,
 		int err = 0;
 		pr_devel("DRBG: start to perform self test\n");
 		if (drbg->core->flags & DRBG_HMAC)
-			err = alg_test("drbg_pr_hmac_sha256",
-				       "drbg_pr_hmac_sha256", 0, 0);
+			err = alg_test("drbg_pr_hmac_sha512",
+				       "drbg_pr_hmac_sha512", 0, 0);
 		else if (drbg->core->flags & DRBG_CTR)
 			err = alg_test("drbg_pr_ctr_aes256",
 				       "drbg_pr_ctr_aes256", 0, 0);
@@ -2023,7 +2023,7 @@ static inline int __init drbg_healthcheck_sanity(void)
 	drbg_convert_tfm_core("drbg_nopr_sha256", &coreref, &pr);
 #endif
 #ifdef CONFIG_CRYPTO_DRBG_HMAC
-	drbg_convert_tfm_core("drbg_nopr_hmac_sha256", &coreref, &pr);
+	drbg_convert_tfm_core("drbg_nopr_hmac_sha512", &coreref, &pr);
 #endif
 
 	drbg = kzalloc(sizeof(struct drbg_state), GFP_KERNEL);
-- 
2.34.1

