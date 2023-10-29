Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9333F7DAE4B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjJ2Usl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjJ2Usi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 16:48:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9554AF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 13:48:35 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B2D533F36A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698612513;
        bh=kX0qGSlIN+myPQHKGzUHfDf+7TPtp+Gi684hQoqwER0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=lA1yE/m/IX92nKIvDWfudyyeKUxBo2Jk6w3EOgQkfIG4K6PmWel0488/KGUAv69zH
         2mksmBH+EClxKsUF/IVZN8qpZqUR0Mg1o0hxzeHa/x0pKUBLM3ObtO0pTRuBZFTNIk
         GDLm4bKvddXH8STbKCpLK4Qm+MlDKG7SKE3ViKiMtitaYDronwY/7LwvUpEyh0B2ul
         vTt/JXhkaAXXuDbM/b57Uln44K1MeX8s+6AMm8xaCyNEUqb2Pz7p35lXEwfGY8Q1Rc
         eN7bTqyW567kukqt2+ysWYkdacEsoykIo+n0eOggEKqCTf31XE49/K8xD/kYVyRbqK
         N6vbshIn1m6qg==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32f7943913aso752499f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 13:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698612512; x=1699217312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kX0qGSlIN+myPQHKGzUHfDf+7TPtp+Gi684hQoqwER0=;
        b=chuTyyszSF9s0Inwi65v8bIBh6kQf9I/GfcZsBb1zaf/K2nvaVLeSeZuwfRa5vIDlh
         9KYGTZuntRh9SIhU1cLjjIkCn3qE5NGHrmBE2pmt8sPANY9djz99JMmHue66PnNWDOfa
         SZgcXkrTBAHiT4VuUhO1TaE4MdcLkH3ywcDJuvqnNXbBIfLQJ0XgbzdYxfpY3xqLm1Qr
         Ks9YNZ3Ey6DY8M+5h7wgOPuBt2RYB3k8frY0wfJO6fxkX9eFTnRJdP2H62/EyZVi5FvC
         d0zstDZelb7lWNmrkwdQza66zLvsXEiT18tYG+ZlJwWGGz4pLRGeqMcvgv6zemjR40XH
         Vl3w==
X-Gm-Message-State: AOJu0Yxw4owpuSgvaVQG6QDqYCW6aLjxwnowZEUybZ9UzXxtsosoGOJG
        p1+/cCxeEy+u6Bl8YmTOjNupclvgbP1y96GuC7tqm/rQepyCO7p2AdJjqBMSpDKsl70fx5Gph8S
        v4XJEXoSiIbnOrpR7Al/DcrPpkxJK9Au3FqFaLOaJLHxMTwX26Kge+Ag=
X-Received: by 2002:a5d:6051:0:b0:32d:a4c4:f700 with SMTP id j17-20020a5d6051000000b0032da4c4f700mr5575135wrt.38.1698612512450;
        Sun, 29 Oct 2023 13:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjfCBiBEk+QucpwQLyHGqr1cR+Dvm3Yy3IgwtdHlACLwzb9JDkKDgf7RgNPULwzHs69RsgQw==
X-Received: by 2002:a5d:6051:0:b0:32d:a4c4:f700 with SMTP id j17-20020a5d6051000000b0032da4c4f700mr5575127wrt.38.1698612512143;
        Sun, 29 Oct 2023 13:48:32 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d6ac9000000b0032d687fd9d0sm6599715wrw.19.2023.10.29.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 13:48:31 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan Mueller <smueller@chronox.de>
Cc:     simo@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] crypto: drbg - ensure most preferred type is FIPS health checked
Date:   Sun, 29 Oct 2023 22:48:20 +0200
Message-Id: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drbg supports multiple types of drbg, and multiple parameters of
each. Health check sanity only checks one drbg of a single type. One
can enable all three types of drbg. And instead of checking the most
preferred algorithm (last one wins), it is currently checking first
one instead.

Update ifdef to ensure that healthcheck prefers HMAC, over HASH, over
CTR, last one wins, like all other code and functions.

Fixes: 541af946fe ("crypto: drbg - SP800-90A Deterministic Random Bit Generator")

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 crypto/drbg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index ff4ebbc68e..2cce18dcfc 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -2018,9 +2018,11 @@ static inline int __init drbg_healthcheck_sanity(void)
 
 #ifdef CONFIG_CRYPTO_DRBG_CTR
 	drbg_convert_tfm_core("drbg_nopr_ctr_aes128", &coreref, &pr);
-#elif defined CONFIG_CRYPTO_DRBG_HASH
+#endif
+#ifdef CONFIG_CRYPTO_DRBG_HASH
 	drbg_convert_tfm_core("drbg_nopr_sha256", &coreref, &pr);
-#else
+#endif
+#ifdef CONFIG_CRYPTO_DRBG_HMAC
 	drbg_convert_tfm_core("drbg_nopr_hmac_sha256", &coreref, &pr);
 #endif
 
-- 
2.34.1

