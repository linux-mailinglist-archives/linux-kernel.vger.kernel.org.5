Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5241381132C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378933AbjLMNnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378905AbjLMNnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:43:16 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98017AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:43:22 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 740EA3F285
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702475001;
        bh=uM/Cfv1vwzgbhYkByR9B4hJJ+cVjQnEklsojPpuPdXQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VsHIRli2pTZ6iIHCW3eYbOklT6g0gh2Lmd/wP9FUSZ2MDM34SoQUaLr61X4oBJtE7
         TNj47ViVyI+OnRpNH4JSHiel6hRUn+hnZ1zA7ZAKKtMC4GF+RChKii5yuJRmX5WyVx
         7mNz0u+YYOTEVqPbV8SEwiNGEs9Uq1rpWbNwQFqA0gHQL2BV+7l/QGXV9a8hFZ+Yyo
         vXFOFxH8USjsIlUxq+B9/dDwyByPVgs2qGCDGMRRwlItjxnNaQkws+V5trYU8W2+k+
         6VfXGidyVkjQtoc5rBm9/kCKT9FAqow20BXDTunvP1UZm2ihM6bFIU2UtK96oIdsSO
         pWTG7pbdv3CZw==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c3826d6feso30999575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475000; x=1703079800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uM/Cfv1vwzgbhYkByR9B4hJJ+cVjQnEklsojPpuPdXQ=;
        b=Q57JX2mhQtHhG9965TqbQOZMVUaYUBXboUn25l2IpBfNKjQhdxmcvgKIIVCY/4i3Bt
         xA2BX+TVq1zHAal6pvzemrjtJPfWslx3NDRmuuf0n35+Zq88/A4woz54fgo34rtkob4Q
         6F3k3iLTLhjq9DdaWJNjXm6e0ZzqrjeGwKSqsxNwy722lscuGs+54St07+cipcG5pAtS
         T/Z4sqophiqBi8HgNOVmhFT5ZT3v1xPSb9OZu/AzC1zVeOvsP8Zh3/u2/6uyB4f1zogt
         5MbU0fkzwvVb1RnIKzTpmFqKWpjZPN1/CKgJmII5dhKbcYXkEu220hpmR+2E8JXdBacT
         bl4Q==
X-Gm-Message-State: AOJu0YxIAa/Z9dbNX/420LPZ7IsXJJBjg21oiXFHee93AgjHCqDGgEYb
        bJkuFeeoStMo3tYry4sC7iOBsxisJw0/W8i8Lg60jYtN9jqKCp5pry9YjF8Yls/tkVhCfOCsuCp
        ckBrbSIhlROUFsh3dyCYGUVzJJhHJ1aRXzswyGc3O5EOg3P5HfQ==
X-Received: by 2002:a05:600c:ac8:b0:40b:5e1b:549e with SMTP id c8-20020a05600c0ac800b0040b5e1b549emr4130203wmr.42.1702475000494;
        Wed, 13 Dec 2023 05:43:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmPEr7Z3kFY/NF51rYZjOi6a9Q9IPHT2Gf4VvypNk/xeA+fQczug64iJaowmGc5Ak7rHywwQ==
X-Received: by 2002:a05:600c:ac8:b0:40b:5e1b:549e with SMTP id c8-20020a05600c0ac800b0040b5e1b549emr4130191wmr.42.1702475000108;
        Wed, 13 Dec 2023 05:43:20 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0040c45cabc34sm12197042wmo.17.2023.12.13.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:43:19 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     jpoimboe@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] objtool: make objtool RETPOLINE validation fatal when building with CONFIG_RETPOLINE=y
Date:   Wed, 13 Dec 2023 13:43:02 +0000
Message-Id: <20231213134303.2302285-4-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make objtool RETPOLINE validation fatal when building with
CONFIG_RETPOLINE=y, currently it is a build.log warning only.

This is a standalone patch, such that if regressions are identified
(with any config or toolchain configuration) it can be reverted until
relevant identified code is fixed up or otherwise
ignored/silecned/marked as safe.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 tools/objtool/check.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9709f037f1..c21258e109 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3991,7 +3991,10 @@ static int validate_retpoline(struct objtool_file *file)
 		warnings++;
 	}
 
-	return warnings;
+	/* RETPOLINE is an optional security safety feature, make it
+	 * fatal to ensure no new code is introduced that fails
+	 * RETPOLINE */
+	return -warnings;
 }
 
 static bool is_kasan_insn(struct instruction *insn)
-- 
2.34.1

