Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE17D2534
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjJVSWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjJVSWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:22:38 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F681126
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:22:36 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0A3FE3FA6A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697998955;
        bh=v25xpGQ1lcp0WolL3qlcYpnQcJP+olpr2/Zrc8cdKEA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PFgajOYFJj7SnhTbzmYxzlrpb/jF6FM9z0twH3/HkUtRHXTqVJERDbUPvC25hUovV
         ynVP3pjbsjeqIuUNkWn6m6Bgfgxn+KmJDuJYJMFSoFxjWTbd2wfeaMEwfNqfX/LRz+
         ZEvJO0Kan7dI8NfDWvGfz7FCmYXSda6KKkENBDbYQ2dbKnk2rNM28GOPX8l/sEfJLQ
         PhVYlyCJkrGsX8UPVB53CPiehG8GSy+NzGC0Lkli1RsZ6mMDh+zdcUdi/W7D/3W2GU
         QM2FlFf9XfZjvvUduupPqLBciuhFti95Flxb/u8LigG6wy5Ie4x0J7NxwubehA52Md
         yCL2kLN1SsyIA==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4090181eec2so1519745e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697998954; x=1698603754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v25xpGQ1lcp0WolL3qlcYpnQcJP+olpr2/Zrc8cdKEA=;
        b=kNbHQqGdZ27j0xN0P0WK+UnqFoCZ3T8vatts6+lvF7kT4ehhe0Mj5SkOV0SNAFoyLP
         HpkQNd+lrSXB+NyRq7HGrzmMu4v8MrWWhk/1+TYe0zhvTjdRTrQytNI+dggIP7N4aBe9
         sJFo3rT10O/Ya8a7KXlKeSPpDNVz5NiYzPHOukRowQt77anIfSFals32tXLo7YE0dbkP
         /FEWBFv6KrsHgkQldbN7yvTkCQdQbcDGikBN8UKXV4wEVqzefmGyFUZuQr2158GsElu+
         4fjyl1vwXo0GEXnMRnRzFgJsLF1c/Iq5nINAV+sYK8RGYe00IDYed7JntSk4JF3+OxsE
         S/RA==
X-Gm-Message-State: AOJu0YwhuIW6vrEoGcRi4x1McDEwAHR3H68oC0jWAzyuZh62o+C2XYrJ
        ngy4SeplvLfXXIaRXVMy4WZ7ZpEKibr7paKQ8i+Cb/yvoi9fi0jbIabq0saKbYmb9Lb75nDwW9y
        tvPyZtAeGFcl8vJiBvLujDVH93wSScfy9dO2Rr3U3nzEaWqZyVA==
X-Received: by 2002:a05:600c:45cb:b0:406:5359:769f with SMTP id s11-20020a05600c45cb00b004065359769fmr5412420wmo.0.1697998954546;
        Sun, 22 Oct 2023 11:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJRk6v/Kip0y7ky2CFzShxEF6DyZqvAtQEhOY9yenoeKL7OxepYzTya0RYNEnKa1exiBJGbA==
X-Received: by 2002:a05:600c:45cb:b0:406:5359:769f with SMTP id s11-20020a05600c45cb00b004065359769fmr5412409wmo.0.1697998953990;
        Sun, 22 Oct 2023 11:22:33 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id l23-20020a1c7917000000b004063cced50bsm7408148wme.23.2023.10.22.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:22:33 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     herbert@gondor.apana.org.au,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] crypto: FIPS 202 SHA-3 register in hash info for IMA
Date:   Sun, 22 Oct 2023 19:22:04 +0100
Message-Id: <20231022182208.188714-3-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
References: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register FIPS 202 SHA-3 hashes in hash info for IMA and other
users. Sizes 256 and up, as 224 is too weak for any practical
purposes.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 crypto/hash_info.c             | 6 ++++++
 include/crypto/hash_info.h     | 1 +
 include/uapi/linux/hash_info.h | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/crypto/hash_info.c b/crypto/hash_info.c
index a49ff96bde..9a467638c9 100644
--- a/crypto/hash_info.c
+++ b/crypto/hash_info.c
@@ -29,6 +29,9 @@ const char *const hash_algo_name[HASH_ALGO__LAST] = {
 	[HASH_ALGO_SM3_256]	= "sm3",
 	[HASH_ALGO_STREEBOG_256] = "streebog256",
 	[HASH_ALGO_STREEBOG_512] = "streebog512",
+	[HASH_ALGO_SHA3_256]    = "sha3-256",
+	[HASH_ALGO_SHA3_384]    = "sha3-384",
+	[HASH_ALGO_SHA3_512]    = "sha3-512",
 };
 EXPORT_SYMBOL_GPL(hash_algo_name);
 
@@ -53,5 +56,8 @@ const int hash_digest_size[HASH_ALGO__LAST] = {
 	[HASH_ALGO_SM3_256]	= SM3256_DIGEST_SIZE,
 	[HASH_ALGO_STREEBOG_256] = STREEBOG256_DIGEST_SIZE,
 	[HASH_ALGO_STREEBOG_512] = STREEBOG512_DIGEST_SIZE,
+	[HASH_ALGO_SHA3_256]    = SHA3_256_DIGEST_SIZE,
+	[HASH_ALGO_SHA3_384]    = SHA3_384_DIGEST_SIZE,
+	[HASH_ALGO_SHA3_512]    = SHA3_512_DIGEST_SIZE,
 };
 EXPORT_SYMBOL_GPL(hash_digest_size);
diff --git a/include/crypto/hash_info.h b/include/crypto/hash_info.h
index dd4f067850..d6927739f8 100644
--- a/include/crypto/hash_info.h
+++ b/include/crypto/hash_info.h
@@ -10,6 +10,7 @@
 
 #include <crypto/sha1.h>
 #include <crypto/sha2.h>
+#include <crypto/sha3.h>
 #include <crypto/md5.h>
 #include <crypto/streebog.h>
 
diff --git a/include/uapi/linux/hash_info.h b/include/uapi/linux/hash_info.h
index 74a8609fcb..0af23ec196 100644
--- a/include/uapi/linux/hash_info.h
+++ b/include/uapi/linux/hash_info.h
@@ -35,6 +35,9 @@ enum hash_algo {
 	HASH_ALGO_SM3_256,
 	HASH_ALGO_STREEBOG_256,
 	HASH_ALGO_STREEBOG_512,
+	HASH_ALGO_SHA3_256,
+	HASH_ALGO_SHA3_384,
+	HASH_ALGO_SHA3_512,
 	HASH_ALGO__LAST
 };
 
-- 
2.34.1

