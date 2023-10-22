Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA87D2538
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjJVSWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjJVSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:22:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF44126
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:22:28 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7534E3FA76
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697998947;
        bh=75g1uVytfAfB4G7pprF2u0HAHdd4i0yuLNQrH1gJqY8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=N4IVO7+6AVmBRHPpXKRjRyempzYd1AbHJ4ht+LsTdIZpY8QBsm88ClY8GSQLVZDJ4
         5Qx4uWw3GtkAwzkEjlvDblS3Wr+WRE7DXR/wJ1jHwyWFd7CYdk7C7S7ebA3LQTVLKC
         yl9bFsX433d7+eFqlysP198UYILkqUOJrToYs/Dng881suFfJbPBRKi9PRB2iwtwrl
         1DfR3Emg5V3x2JmIqx/uhd8r/nd7XUtYpdgJS2QbD1Q9zRWlyP/f36dE+tbbJKNy4c
         U2PospZBVkGVHw7j7dqHYlwFPE6WENCYrftLfgMdjzA4NL6glBG0HKcJrMSziIDPwW
         mL44wHM7D2Aww==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-408534c3ec7so12511995e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697998946; x=1698603746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75g1uVytfAfB4G7pprF2u0HAHdd4i0yuLNQrH1gJqY8=;
        b=kG+m3XAWSw8ciJ/XMcrBtsqzOhsCnCyyqvaQnbAwnvKldytnuMW3ZnfUeqI0NKL4xj
         JWSYNyheznBYXwxy85QdV3+jpExu5PAjqcwUvyvayxzhAtfA/QBmOCgRIeAvZPEISG/i
         f8g0xNHgIktJJPxs1HWCPtBJlXEGNk/Kn+bVVrpPd0Kro2Em87xm56O1ObqExH3kiSRn
         vfYNqdZzL+c+m2EXT2/bGZdHMfqZGH6xrshnrTmGwoS1slfSKBQYD6Hd6cV0T2843asp
         wSlMvJex3NnpMW1Kt0lLR3Q2pzKsuIxv19tX4NkjY67ejY4k1sG5cRrN8SDB9oTSkJAC
         wPTQ==
X-Gm-Message-State: AOJu0Yxc5CUJYv30sIOG/jngTDuah19omzSSKcgue1Qj6ZBXJ/4p86zi
        DXIeZBVXwweskRP3X4mg90RH76z2kGdTk72WdmyqA8xKxOr+Sl6YtTIBja2jizYRL0CKLPW2M6Q
        OrHoVJ4Rj4z+Shjy8sszwq2zAE4A4RejY2LxWtnfNAnYeIJOAjw==
X-Received: by 2002:adf:eb46:0:b0:319:6997:942e with SMTP id u6-20020adfeb46000000b003196997942emr4867520wrn.8.1697998946469;
        Sun, 22 Oct 2023 11:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkCnQiPm0AcaX3BXXR4mWgyDORPbAGUupIRssUsWEFx0Fo94HRnUYhw26PnU5ahgaRxLHjgQ==
X-Received: by 2002:adf:eb46:0:b0:319:6997:942e with SMTP id u6-20020adfeb46000000b003196997942emr4867511wrn.8.1697998946101;
        Sun, 22 Oct 2023 11:22:26 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b0031aef72a021sm6091289wrr.86.2023.10.22.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:22:25 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] x509: Add OIDs for FIPS 202 SHA-3 hash and signatures
Date:   Sun, 22 Oct 2023 19:22:03 +0100
Message-Id: <20231022182208.188714-2-dimitri.ledkov@canonical.com>
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

Add OID for FIPS 202 SHA-3 family of hash functions, RSA & ECDSA
signatures using those. Limit to 256 or larger sizes, for
interoperability reasons. 224 is too weak for any practical uses.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 include/linux/oid_registry.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 8b79e55cfc..3921fbed0b 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -129,6 +129,17 @@ enum OID {
 	OID_TPMImportableKey,		/* 2.23.133.10.1.4 */
 	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
 
+	/* CSOR FIPS-202 SHA-3 */
+	OID_sha3_256,                           /* 2.16.840.1.101.3.4.2.8 */
+	OID_sha3_384,                           /* 2.16.840.1.101.3.4.2.9 */
+	OID_sha3_512,                           /* 2.16.840.1.101.3.4.2.10 */
+	OID_id_ecdsa_with_sha3_256,             /* 2.16.840.1.101.3.4.3.10 */
+	OID_id_ecdsa_with_sha3_384,             /* 2.16.840.1.101.3.4.3.11 */
+	OID_id_ecdsa_with_sha3_512,             /* 2.16.840.1.101.3.4.3.12 */
+	OID_id_rsassa_pkcs1_v1_5_with_sha3_256, /* 2.16.840.1.101.3.4.3.14 */
+	OID_id_rsassa_pkcs1_v1_5_with_sha3_384, /* 2.16.840.1.101.3.4.3.15 */
+	OID_id_rsassa_pkcs1_v1_5_with_sha3_512, /* 2.16.840.1.101.3.4.3.16 */
+
 	OID__NR
 };
 
-- 
2.34.1

