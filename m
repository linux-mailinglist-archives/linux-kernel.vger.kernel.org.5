Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647D57C4284
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjJJV2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjJJV2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:28:11 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2660DA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:28:06 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CC3B23FA63
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 21:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696973284;
        bh=kGYTzfoZ1kv7weJtQlok3IlvagfJw5eAGxwX3/sR+4o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=OeNDxuEbraKLdn8fn3ZrQoCYuPU5iyGy0YtNUbOWhJqcwBcrH6zo1u1Gq0AbmNzYs
         VTcMExs6ry5gnr0oRz+234O18qLbryZJJxGqkKjKzOAdu5/ohMGPQSK2LHUuHmo+rW
         l/csA7C8rMso8+yUqEhu6r+8xEQFaMN8ALC2QAPnrKd6Yit8SMBOUr3EjAX29mR4Di
         82wMI2LEeVH2mgI0v6UVwScqXGVZm6B1DViwslKgrsZx5AowZEgIwfUYro5Y2vS50P
         CG9rsGgmdPZO343EYJbXjzxG6306bUtpd/E6f4idImuWqIkxrkVIKlSSy91XwKQDCk
         v+Hnz7sec8SyQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-27731a63481so5994849a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973283; x=1697578083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGYTzfoZ1kv7weJtQlok3IlvagfJw5eAGxwX3/sR+4o=;
        b=IFeoC18GBK7zCmsP4rSsxoGlScRpjGaCQBJKP2juaeT/hMQrzrvQwPI8K3FMvwnz4q
         Pm/rohHizhH5+pWp1iuciguxscENhCeMvSWaBNh9bEX6G/Yx3+CAF8uQYaFl4taImzC3
         M0dxpmqgwYQmj0c3KalddUuap2QifIfz9te+YxwJCpI6ym/Wh0IiphRzYZ659otSseuw
         ae8umfpZXl3gStpg3S9Nerj8c+R1X637kvh5wrGL++5tsOXOmoYWm9E3jdJvn8Yr8Tuv
         4L9DvYuV0Nht27uw2zfInqTgAe44TsduucXVtT1WAj+n89njUw+ZnjPOSgvYAm78bmEB
         OrHw==
X-Gm-Message-State: AOJu0YwxgRrqOoQ12UluXaAlMJDOq8KPq0fBzq6yaANjhZtpr6OFg4Vl
        96plz9fTC3wAHU46VHdz/a4t0Ndj/MxBtoxsgEbcPCReF2Oqx0UQQn6I+s1TWgDJM3qzAJEwG7P
        aOUAxiopgWg4Gv5/z2Wj9Yt0qVUp6Rc6Nps5k6qh13MkbMBnFSbCUYqo=
X-Received: by 2002:a17:90a:d994:b0:27c:f305:cf82 with SMTP id d20-20020a17090ad99400b0027cf305cf82mr2076215pjv.24.1696973283199;
        Tue, 10 Oct 2023 14:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHTGkfR5o6XjzlsdIQU0gFnvfe+TOn1Qjq6XWUx1g5sYVOL098jMoAxrBFmurn6Bm/1uScZw==
X-Received: by 2002:a17:90a:d994:b0:27c:f305:cf82 with SMTP id d20-20020a17090ad99400b0027cf305cf82mr2076207pjv.24.1696973282882;
        Tue, 10 Oct 2023 14:28:02 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id 24-20020a17090a001800b002791d5a3e29sm369949pja.6.2023.10.10.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:28:02 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, mcgrof@kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: Limit MODULE_SIG_KEY_TYPE_ECDSA to SHA384 or SHA512
Date:   Tue, 10 Oct 2023 22:27:55 +0100
Message-Id: <20231010212755.64744-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NIST FIPS 186-5 states that it is recommended that the security
strength associated with the bit length of n and the security strength
of the hash function be the same, or higher upon agreement. Given NIST
P384 curve is used, force using either SHA384 or SHA512.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 certs/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 1f109b0708..84582de66b 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -30,9 +30,11 @@ config MODULE_SIG_KEY_TYPE_RSA
 config MODULE_SIG_KEY_TYPE_ECDSA
 	bool "ECDSA"
 	select CRYPTO_ECDSA
+	depends on MODULE_SIG_SHA384 || MODULE_SIG_SHA512
 	help
-	 Use an elliptic curve key (NIST P384) for module signing. Consider
-	 using a strong hash like sha256 or sha384 for hashing modules.
+	 Use an elliptic curve key (NIST P384) for module signing. Use
+	 a strong hash of same or higher bit length, i.e. sha384 or
+	 sha512 for hashing modules.
 
 	 Note: Remove all ECDSA signing keys, e.g. certs/signing_key.pem,
 	 when falling back to building Linux 5.14 and older kernels.
-- 
2.34.1

