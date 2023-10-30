Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5C7DB973
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjJ3MFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjJ3MFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:05:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF9C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:45 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9402D3FADC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698667543;
        bh=goPlhkL/xzNb2R4OkDT742TxqiPYA+4C52wqVnxeTeU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ViAmbB4aptfuB10K4nwvaQsoxkNVtCrGfGQb5NO4WQ9w8DkqCJLsiM10Vb9mZ0FtJ
         09QB1iEKbnOdPSZBBlOsHF17sos+B4KHLHzDxCBWJ1cIZ4n57H6e+jD9BCvxVSnold
         EWC7h6nQZ3CIg5Nw7oVQeU+H4GFAhHqYycdAi09NtxCVqSXJVmgnH3Z3Z0/3WTODd6
         fDFasvU1DdQi8RUna1RAhOQtCw13VcgkTtEVLKVZHEk0g7cf+ZkRAqnUTFSRKV714Q
         hJ1yl6jWylmc4oMSk/LMIxBvz64rxJ25CJoI5i3gCHb31h2U+a7S6N5tVDEgPvIqdK
         leSoP3s4qjuqA==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c53ea92642so44311401fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667543; x=1699272343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goPlhkL/xzNb2R4OkDT742TxqiPYA+4C52wqVnxeTeU=;
        b=uPH/g6juV6mqioSo91mni508UnPP8EVnGn0+9uv41SIqpO6IZierNWYP1aNNRQbihu
         Qzacy0CRf8WbISyk8ca8sh+d+2M9svgt1Cg6AghNh0WSuz7G4cidv9FFaLr9CVGYmTMX
         2WWxMEydcUPifmJ1kSBWotRLjnZQnFc0kubtafVUVEjIXQljt0RdVhAQ18dVP/0WMTdP
         umGNLFs4aJMxQb9apB2w/xdW5M7LfGabFUpNlm6v6vxeesZCGMfluo36VfcAE/gZmvcy
         Bj5nvhdh6TMk3UV1ipxyAxqYr6h/6blgxI2Kid07iJb9Hri31rtWiqRloefr6RDJj3nu
         bhEg==
X-Gm-Message-State: AOJu0Ywq9ozKlnG4qW9y5M6H0SuNm+BreKkrXES8ATK4yftEsW9DMwEw
        BbGDiToiYAhOQLiMl/Fqpp9V073A1box9zyrRl4D5WpYyPCcx56vXsmrOrCJMC/r0i6S7wwnO0s
        PaZAlcWUMYWInOuZCv8nS/IgZJRsMynnYZXYMRtTxzA==
X-Received: by 2002:a05:6512:3b97:b0:507:9777:a34a with SMTP id g23-20020a0565123b9700b005079777a34amr9719637lfv.39.1698667543043;
        Mon, 30 Oct 2023 05:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoJXGtoW+Yqd/RvASlxF5C9PTbciLZsCRzR68/fGUZamt97cY67cCfeewUQXDLtQyX5xXHTg==
X-Received: by 2002:a05:6512:3b97:b0:507:9777:a34a with SMTP id g23-20020a0565123b9700b005079777a34amr9719602lfv.39.1698667542331;
        Mon, 30 Oct 2023 05:05:42 -0700 (PDT)
Received: from localhost ([159.148.223.140])
        by smtp.gmail.com with ESMTPSA id n18-20020a056512311200b005056ccb222asm1418808lfb.105.2023.10.30.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:05:42 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     smueller@chronox.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] crypto: drbg - ensure most preferred type is FIPS health checked
Date:   Mon, 30 Oct 2023 14:05:13 +0200
Message-Id: <20231030120517.39424-2-dimitri.ledkov@canonical.com>
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

drbg supports multiple types of drbg, and multiple parameters of
each. Health check sanity only checks one drbg of a single type. One
can enable all three types of drbg. And instead of checking the most
preferred algorithm (last one wins), it is currently checking first
one instead.

Update ifdef to ensure that healthcheck prefers HMAC, over HASH, over
CTR, last one wins, like all other code and functions.

This patch updates code from 541af946fe ("crypto: drbg - SP800-90A
Deterministic Random Bit Generator"), but is not interesting to
cherry-pick for stable updates, because it doesn't affect regular
builds, nor has any tangible effect on FIPS certifcation.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
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

