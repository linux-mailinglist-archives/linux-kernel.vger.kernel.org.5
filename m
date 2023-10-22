Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB17D2535
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjJVSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjJVSWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:22:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB75114
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:22:45 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BBCBB3F63D
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697998959;
        bh=G21LvQrZs30vZixQb7qoXSrQRZ+ChOighJd9yL5njGg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=XnLrftOr4IzrIg6cLChua4GUyA7wkyQ1FEcZY+2hgAW5v6y0g2Kqf42SABbfzQg+X
         rODK3UdeUNWirZhNFaPwrAt6J3GiyQROkocFTYFiR/Gt1jgApA3tmMSmE8kIK0m59A
         is3d7xugP6mupXvo7unbGvzrpnNquVy586RRc1Qx5tRDib2wb9CECVwh2vPnNSx9PH
         Q8QNi5sTP2AkdoUe9ixAqglbwxC4cOJwoJJ8zJIJWenGZkLjrvm3OXGL7fX/TiDmBb
         dlCIACGlj9q5MuNZp5kErnJVTSDyN5ozNKlSlnoRmd/jyzOtqDphwqrPZnuZMlz7RN
         y6A4xcCfEKsdg==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32de90288d0so787250f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697998958; x=1698603758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G21LvQrZs30vZixQb7qoXSrQRZ+ChOighJd9yL5njGg=;
        b=Q+bXdPzELTIRiigEkVyKyT1h6LDpobC6AoHgHO4T08WGxudGdG/ULHqgyi1DkSS+a/
         +Ibh1SbV3MpK2T92p4zRXcUTwMFfWc3RVbAuZsWs8s7UkxSrLLlkYmMxMbLw/x8TCEsL
         V8XYNE6oApddiP7N5ERkYm+jxADNWzSunr8LX4GbNdnkFPSQbwCwIzHQ9LvhMAXruPen
         Qi0PQefPZbpbXyIhh/qwoUYy/dtpKhtxzKFRsbt37U9VRMGPlpg4q/L1S040ZdzrlgVj
         8Vfwodroz158F0I+2TGJIJTby3iHPKyDUtxG1gvwYJN7jGSyrV3FnG+t+Rz8HJGrQJoU
         1y4A==
X-Gm-Message-State: AOJu0YwDwMn0mBmUOOxXhmHg2i2T5VD1vN+fuBAn4U2/cTYpgIaYKBVV
        3h7rjIGSl22A8VZgzjDo2lF/J96pIdd9nLx+s/T8uqE3+mDybOZYL12whkvLJL7ftan0HkF7PFQ
        +QHEOGgWyVL60X1ETZMFBPbLVy9gqf05+qT+cyESO8A==
X-Received: by 2002:adf:e387:0:b0:321:6779:944d with SMTP id e7-20020adfe387000000b003216779944dmr5166507wrm.47.1697998958651;
        Sun, 22 Oct 2023 11:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAZvQT1bUdK5D86F47MwaUC8hGREbp8ZcoKdB+ACNOR56da1Ev4XH0crCuR05/TvtIF23FDw==
X-Received: by 2002:adf:e387:0:b0:321:6779:944d with SMTP id e7-20020adfe387000000b003216779944dmr5166502wrm.47.1697998958286;
        Sun, 22 Oct 2023 11:22:38 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b0032da87e32e2sm6143324wrq.4.2023.10.22.11.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:22:38 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     herbert@gondor.apana.org.au,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] crypto: rsa-pkcs1pad - Add FIPS 202 SHA-3 support
Date:   Sun, 22 Oct 2023 19:22:05 +0100
Message-Id: <20231022182208.188714-4-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
References: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support in rsa-pkcs1pad for FIPS 202 SHA-3 hashes, sizes 256 and
up. As 224 is too weak for any practical purposes.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 crypto/rsa-pkcs1pad.c | 25 ++++++++++++++++++++++++-
 crypto/testmgr.c      | 12 ++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index d2e5e104f8..e32e497d29 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -61,6 +61,24 @@ static const u8 rsa_digest_info_sha512[] = {
 	0x05, 0x00, 0x04, 0x40
 };
 
+static const u8 rsa_digest_info_sha3_256[] = {
+	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x08,
+	0x05, 0x00, 0x04, 0x20
+};
+
+static const u8 rsa_digest_info_sha3_384[] = {
+	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x09,
+	0x05, 0x00, 0x04, 0x30
+};
+
+static const u8 rsa_digest_info_sha3_512[] = {
+	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
+	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x0A,
+	0x05, 0x00, 0x04, 0x40
+};
+
 static const struct rsa_asn1_template {
 	const char	*name;
 	const u8	*data;
@@ -74,8 +92,13 @@ static const struct rsa_asn1_template {
 	_(sha384),
 	_(sha512),
 	_(sha224),
-	{ NULL }
 #undef _
+#define _(X) { "sha3-" #X, rsa_digest_info_sha3_##X, sizeof(rsa_digest_info_sha3_##X) }
+	_(256),
+	_(384),
+	_(512),
+#undef _
+	{ NULL }
 };
 
 static const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 54135c7610..a074430223 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5468,6 +5468,18 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "pkcs1pad(rsa,sha512)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
+	}, {
+		.alg = "pkcs1pad(rsa,sha3-256)",
+		.test = alg_test_null,
+		.fips_allowed = 1,
+	}, {
+		.alg = "pkcs1pad(rsa,sha3-384)",
+		.test = alg_test_null,
+		.fips_allowed = 1,
+	}, {
+		.alg = "pkcs1pad(rsa,sha3-512)",
+		.test = alg_test_null,
+		.fips_allowed = 1,
 	}, {
 		.alg = "poly1305",
 		.test = alg_test_hash,
-- 
2.34.1

