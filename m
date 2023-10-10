Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9557C4276
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbjJJV04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjJJV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:26:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B713F94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:26:52 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 010953F148
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 21:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696973210;
        bh=bbJL2SOs8ojKA5eoIkTwtjiwN0Y17d4pCBALcurYDbM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=MqO0pWN2TbYSY5U85a/qqr7W9FHeFerpMOrIppwBoSQZWKVY5lSV/QTXIJXKSFLfi
         AtptO05qrtGRZaYoX1opeERVPS3SEDu4elaYSH9LnR8NP7Vh1IiDGFAqF+13POkPE2
         6gMy+1NeOiqNY0m3HTCWANLpn8CdSrtW7nfNKmeJZDFvSp0dZbBmPt0iRn/l0MqTYW
         Jq7AdL20fY9LEkxjLMmxHb/8CPQZNAr2N+HH3TibQp/vNxkLlz/4+ETBO4wlgI7/Rm
         6K5BB96R+a1OPZbDqpN5sK8ynYonnRDMxTFmUHKblc8woYa2pe5dfGzlEwK2L9su2/
         Psza+nGlKowFw==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c9c943c94aso2692945ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973208; x=1697578008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbJL2SOs8ojKA5eoIkTwtjiwN0Y17d4pCBALcurYDbM=;
        b=mQIx2Nk80HIRYfQydh51NnfUmF1RGNl09LL48u7bCw46bN6i++vubvL91E4WJ+mW0D
         dP5ZRgkPaKefBsr3cUyxZq5tKx41xdDMo6b+lGEyQhkgUIx58m+rtuDx5+60jRuwuD06
         ux+l66Oe8WGFmGrqZ1cabtDrSQ55DvjUCoo048UI77XwebhD/P5+IIK2JdWutdagBgHz
         ruURtDnwa27Y5UMsCd1w3gJRir0tlykiWuSh0WVaMsuwqAncbnE1dEwIjlIq2+0RVoZ4
         Ss8hyIigt5z2656YKNKT5j8sJyGgpKNvGKFLCV/1Pm8oQWku8P6olOjOLgDv05ssIZiw
         g6Lg==
X-Gm-Message-State: AOJu0YwoyN2eFec1CXLcSDSVm+MgqYVLQMBmp+xAvLbZPRM7ZfLTnnVK
        X6IArs38wc4aMge8sclrHVNVt/8tzr3nHdeVhccuGp1cgBNVUQADffaAyvp5Pbhh3+0wgEZuuWV
        CBcO13LpetIQr/Dxr5eQdaOepk+yG1GEqSnvTiXLdZA==
X-Received: by 2002:a17:902:f546:b0:1bb:e74b:39ff with SMTP id h6-20020a170902f54600b001bbe74b39ffmr20923277plf.0.1696973207795;
        Tue, 10 Oct 2023 14:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhPNlPGDhB23VsV1NLFkLmOVxbRADLHq+9HPJKINV5zuYaaLs4kvapjxiGjBumVRZrSs0ziQ==
X-Received: by 2002:a17:902:f546:b0:1bb:e74b:39ff with SMTP id h6-20020a170902f54600b001bbe74b39ffmr20923258plf.0.1696973207428;
        Tue, 10 Oct 2023 14:26:47 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001bb9bc8d232sm12287028pld.61.2023.10.10.14.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:26:47 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module: Do not offer sha224 for built-in module signing
Date:   Tue, 10 Oct 2023 22:26:33 +0100
Message-Id: <20231010212633.64042-1-dimitri.ledkov@canonical.com>
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

sha224 does not provide enough security against collision attacks
relative to the default keys used for signing (RSA 4k & P-384). Also
sha224 never became popular, as sha256 got widely adopter ahead of
sha224 being introduced.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 kernel/module/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 19a53d5e77..9d7d45525f 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -236,10 +236,6 @@ choice
 	  possible to load a signed module containing the algorithm to check
 	  the signature on that module.
 
-config MODULE_SIG_SHA224
-	bool "Sign modules with SHA-224"
-	select CRYPTO_SHA256
-
 config MODULE_SIG_SHA256
 	bool "Sign modules with SHA-256"
 	select CRYPTO_SHA256
@@ -257,7 +253,6 @@ endchoice
 config MODULE_SIG_HASH
 	string
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
-	default "sha224" if MODULE_SIG_SHA224
 	default "sha256" if MODULE_SIG_SHA256
 	default "sha384" if MODULE_SIG_SHA384
 	default "sha512" if MODULE_SIG_SHA512
-- 
2.34.1

