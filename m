Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC17B9FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjJEO1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjJEOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:25:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9027B0A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:33:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c61bde0b4bso7544465ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696512810; x=1697117610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rdJwxwbZqQ4I0O4A5YRp1pd8ZcaJivULLGhl6LhxxQE=;
        b=KxeJN24Nqn4SB6flKWBzUwOL1qceUEZyWxPoBDjilIEBobJIeaDNXAkcmV/T+z9SKl
         BrbsQuBMR3xg6VybWl5tEd/5KwRFDC5MgdYQArm79Ktm2wDK28Auijypoa1XlLxuTqIv
         cnC6oUeCb6Uwp+ZlGZ6Ez9EcypIAAxbYCYR0yUBCEhKbHX+kAersLCABNWg0gFsv+Mbb
         UAH9U+00PEM9ndapvTil37NhH3opjo7UQELGFG4KZ9AAh2aSGCs/mCQ8bln7tFj8Iqsm
         pJ5MRdodrPZsCEp0YZMhpzWvbxVwNKP+Ex4tIRi0kw3KbzJobDuHFo4ERLGNwPrc/OLH
         UKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696512810; x=1697117610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdJwxwbZqQ4I0O4A5YRp1pd8ZcaJivULLGhl6LhxxQE=;
        b=tG41OFifj7mtJGKSMu292oTNqYPlk3JzaRUsHB/MeX+jQamHp+nZGl689REv0HjH6N
         L4XcO8WmVse5TuNOZ3zNhAz6poLz15dZh/P0a/cy10K/pYw9CEWMo+KtT2P2L1Ey/w3E
         onFo9LMP22Qpe37jLyyqhwyctHVU0PHWFXdTMgbmBshxL3o5WyzvZw5tdDpP8486KCmU
         gSNTv+Fb1a8IlY/b2kuB3nWpuFxG9JcNRzEjv9Dcg5wSu6vVA9MMpCQ4oMmj3ZKr4sj9
         DdUS9Ti6mkYB5JsglBVvNMKwusy3W3PXOcMmyBu08KvWBTuk5FdxgMrsa7x5dlqCBnTF
         STuQ==
X-Gm-Message-State: AOJu0Yz81RKS7YTzlAkQfK3UeAcgHdKyew6eDqRM8kVwvS3cCbTusNKo
        iQI6z1CA+UvG3ZUIjrKlayz4PQ==
X-Google-Smtp-Source: AGHT+IEA4cLHqQcb+MIGG2dpWiFKleSqErzAWsk+2ZAO5zJgG2wamSV90gtm8PK1QSKzQmHiCELlAw==
X-Received: by 2002:a17:902:e84a:b0:1c2:218c:3754 with SMTP id t10-20020a170902e84a00b001c2218c3754mr5994686plg.53.1696512810281;
        Thu, 05 Oct 2023 06:33:30 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.23])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170903279600b001b80d399730sm1643640plb.242.2023.10.05.06.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:33:29 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     torvalds@linux-foundation.org, jarkko@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, zohar@linux.ibm.com, David.Kaplan@amd.com,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        regressions@leemhuis.info, Sumit Garg <sumit.garg@linaro.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH] KEYS: trusted: Remove redundant static calls usage
Date:   Thu,  5 Oct 2023 19:03:06 +0530
Message-Id: <20231005133306.379718-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static calls invocations aren't well supported from module __init and
__exit functions, especially the static call from cleanup_trusted() led
to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.

However, the usage of static call invocations for trusted_key_init()
and trusted_key_exit() doesn't adds any value neither from performance
point and nor there is any security benefit. Hence switch to use indirect
function calls instead.

Note here that although it will fix the current crash reported. But
ultimately we need fix up static calls infrastructure to either support
its future usage from module __init and __exit functions or not.

Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Closes: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t
Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 security/keys/trusted-keys/trusted_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..85fb5c22529a 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -44,13 +44,12 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #endif
 };
 
-DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
 DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
 DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
 			*trusted_key_sources[0].ops->unseal);
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
 			*trusted_key_sources[0].ops->get_random);
-DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+static void (*trusted_key_exit)(void);
 static unsigned char migratable;
 
 enum {
@@ -359,19 +358,16 @@ static int __init init_trusted(void)
 		if (!get_random)
 			get_random = kernel_get_random;
 
-		static_call_update(trusted_key_init,
-				   trusted_key_sources[i].ops->init);
 		static_call_update(trusted_key_seal,
 				   trusted_key_sources[i].ops->seal);
 		static_call_update(trusted_key_unseal,
 				   trusted_key_sources[i].ops->unseal);
 		static_call_update(trusted_key_get_random,
 				   get_random);
-		static_call_update(trusted_key_exit,
-				   trusted_key_sources[i].ops->exit);
+		trusted_key_exit = trusted_key_sources[i].ops->exit;
 		migratable = trusted_key_sources[i].ops->migratable;
 
-		ret = static_call(trusted_key_init)();
+		ret = trusted_key_sources[i].ops->init();
 		if (!ret)
 			break;
 	}
@@ -388,7 +384,8 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call_cond(trusted_key_exit)();
+	if (trusted_key_exit)
+		(*trusted_key_exit)();
 }
 
 late_initcall(init_trusted);
-- 
2.34.1

