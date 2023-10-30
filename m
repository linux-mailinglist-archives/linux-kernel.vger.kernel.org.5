Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC3C7DB975
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjJ3MF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjJ3MFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:05:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF3DE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:47 -0700 (PDT)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 732B73FADC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698667546;
        bh=4wJ5Tm/61E15gRGj85phh+y3C3KRS+lk2/KYpXu5K6Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=W/Q4n9W/NmSxaLgatHw0Bsf43yi4d1jVl81pjqLpDPJrMLtXDK1oZUnK5eFoBWfz3
         nNJl+xp6RZYyYDOMFBcMHY88k3P703DNTUgJ5ZVQhujVV7gHylWj2HqZiLzHF2vd5M
         IT/kWmfAPkm55jrbErlEc2a11iE0Q59n48gnZsKg8JCRicpd8yt5okLTL9PH0ag+IJ
         aupZQ7THKVtxfstbv4d6YfTd69ZZYRjSxzvA9qf8HECKU6XqNCXWnBRAVOglbwjpBe
         9m+GOTfX3zHA4Objnf2EhhKXNSXBuuuPY9CNNRFmoV2x+YtlwmF6UQUhafWTs2qrgC
         cl8aIpwG5oFBg==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c50255b905so46859451fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667545; x=1699272345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wJ5Tm/61E15gRGj85phh+y3C3KRS+lk2/KYpXu5K6Q=;
        b=LCXYNIiWIeRmyeM9yM4YrL4ol8m5DgxxSjD1+kymCdzb34Lguju8xfxxSF1vEwVanc
         di1KMVSgHHedy4svvi+H7gjXgXMK4CrIQb30qblcVAagi2bOP88MegdC4uub7OwbH8mb
         XcHJgGIFaRfD09WNyjvOlEv9oiZDv9qx0EniJ+BiUvtmugJcWzgWswcUmwfKUBvl5IWY
         5AJNs8T6iT/HUJ2nksX9iAYsZo4ohdy0dk59TqxuoYGEfHe4VQJ/dHxapIzQeK17nn5/
         b9StuV8pMjYKOomX1o5hFLeiEhx1oLMjExrKK+vpRAL17WbUj9EYHvLuNU8EV9AF9SWa
         OBfw==
X-Gm-Message-State: AOJu0YwLTCup7hQ8FFSdOQwyBMkX/0zG22ype3D4EO8BuF+trMxJbmre
        vhybvvYR9D5V35NJlKDT7ieA6Sz7jdKKD98c03wWCxpBFfHbZI14mc6wxCrMs8WwtbFqSfXgUbq
        h5eBq/AblbLICLN4ZbLQjgNiMJBRwIi+qbhO+ACIxcA==
X-Received: by 2002:ac2:4546:0:b0:507:9fe7:f321 with SMTP id j6-20020ac24546000000b005079fe7f321mr6505778lfm.54.1698667545669;
        Mon, 30 Oct 2023 05:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFjk4fuhPoH5Sw+MGTPAjK9r/p+eSXaiZ9oDTXTuXG2wBTG7Ty67wk54SY3GRoLzjpZWvuPQ==
X-Received: by 2002:ac2:4546:0:b0:507:9fe7:f321 with SMTP id j6-20020ac24546000000b005079fe7f321mr6505764lfm.54.1698667545433;
        Mon, 30 Oct 2023 05:05:45 -0700 (PDT)
Received: from localhost ([159.148.223.140])
        by smtp.gmail.com with ESMTPSA id er15-20020a05651248cf00b005031774a51fsm1418994lfb.225.2023.10.30.05.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:05:45 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     smueller@chronox.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] crypto: drbg - update FIPS CTR self-checks to aes256
Date:   Mon, 30 Oct 2023 14:05:14 +0200
Message-Id: <20231030120517.39424-3-dimitri.ledkov@canonical.com>
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

When originally drbg was introduced FIPS self-checks for all types but
CTR were using the most preferred parameters for each type of
DRBG. Update CTR self-check to use aes256.

This patch updates code from 541af946fe ("crypto: drbg - SP800-90A
Deterministic Random Bit Generator"), but is not interesting to
cherry-pick for stable updates, because it doesn't affect regular
builds, nor has any tangible effect on FIPS certifcation.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/drbg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 2cce18dcfc..b120e2866b 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1478,8 +1478,8 @@ static int drbg_generate(struct drbg_state *drbg,
 			err = alg_test("drbg_pr_hmac_sha256",
 				       "drbg_pr_hmac_sha256", 0, 0);
 		else if (drbg->core->flags & DRBG_CTR)
-			err = alg_test("drbg_pr_ctr_aes128",
-				       "drbg_pr_ctr_aes128", 0, 0);
+			err = alg_test("drbg_pr_ctr_aes256",
+				       "drbg_pr_ctr_aes256", 0, 0);
 		else
 			err = alg_test("drbg_pr_sha256",
 				       "drbg_pr_sha256", 0, 0);
@@ -2017,7 +2017,7 @@ static inline int __init drbg_healthcheck_sanity(void)
 		return 0;
 
 #ifdef CONFIG_CRYPTO_DRBG_CTR
-	drbg_convert_tfm_core("drbg_nopr_ctr_aes128", &coreref, &pr);
+	drbg_convert_tfm_core("drbg_nopr_ctr_aes256", &coreref, &pr);
 #endif
 #ifdef CONFIG_CRYPTO_DRBG_HASH
 	drbg_convert_tfm_core("drbg_nopr_sha256", &coreref, &pr);
-- 
2.34.1

