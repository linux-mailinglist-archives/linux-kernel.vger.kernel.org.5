Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B07D19DB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjJUARe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjJUARc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:17:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1ED6B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:17:27 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C4F303FD39
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 00:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697847445;
        bh=PuueNGchp+/Mt3jvaX6HDVjE2P5ULCrANke79lmr0h0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vAW6ACwYm/p5qfD4+DdDj++9EZsew0tHbK7Bb84CWNohgedzuy/u7vmyUdkSMW2xh
         exlH4p2BjDMA6s65HujKCx/L9u+7YDd00T2ZpmP9HvK3jZ0dhAiDmQGyDa2NUgET5k
         JF9xiy7OTiWQv0IH066gNQId85bMhc7bOoWutidO+1XtacPm5qcMBsqz9SMkUYtV2v
         TOKLwdbAnbEeC7U6BbkJ1NIiURAZPQjkijZBonKOJTQ8YIBsb+KDU+xsHxq0cxzJmp
         CAPb09zEXntfCGu8/Vzrv1LsoAJ8PaO/sztDQZoNWdqPDZlPmspLaYs3uxvDfoODmm
         XaILB2yNDUVhw==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408212415abso7933865e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697847445; x=1698452245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuueNGchp+/Mt3jvaX6HDVjE2P5ULCrANke79lmr0h0=;
        b=bQav1Ps6p6J2sU3w5NP4vjJmOUokV+AWYjneSjRo5nW89ehWVJ/iiRbSBxurbLy84C
         DaRCKog0Td08HYoPgoBAjJjK0GM3hvfdOIIrAZorzEMkH8mG1Ee6dFwHtqVm0hbzHIn8
         ZtU9KoAg6RdlEUx5P8ndnmK+T90+ERNwhdb37XX1R8rzcO1UMHrqrPKhr90duPUWJUE/
         iBUqRBvT1HR26x8BDbKNQqyo75cFcJfYAqYsuf5b+vTIU3lHMvkmH7HlulD25yp0NTqn
         gKd3eoJPlAT/WWZ1b5K9RDEEWErml55wZr8zgLCr59uFMVL5O7XlticzVpBoR4ou8g75
         sJmQ==
X-Gm-Message-State: AOJu0YzMhWKMY9GoWiukvvRewZHwrfDn7TyJb0B1GeCCQODrJaySfxwp
        bTAvEnIM44QzLO8kIgatsF6zakkBxdZ4zQ2b6FEFhoLzcahHsPF+TqYk97Gor/Jcd36EqiRIEKQ
        br8FMIKgebR32mnhnES1r6HTyD/v2JOmJHVGODWsAGQ==
X-Received: by 2002:a05:600c:4f12:b0:401:bdd7:49ae with SMTP id l18-20020a05600c4f1200b00401bdd749aemr2887982wmq.18.1697847445120;
        Fri, 20 Oct 2023 17:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMVZnMB+J/FgQa8VZj36mJZ4kpObp0cRp5CFimotrdvSauQhycWrR5IHWAFgVCgfAWTIETmQ==
X-Received: by 2002:a05:600c:4f12:b0:401:bdd7:49ae with SMTP id l18-20020a05600c4f1200b00401bdd749aemr2887969wmq.18.1697847444697;
        Fri, 20 Oct 2023 17:17:24 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c488600b004080f0376a0sm3207801wmp.42.2023.10.20.17.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 17:17:24 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: mscode_parser - remove sha224 authenticode support
Date:   Sat, 21 Oct 2023 01:16:58 +0100
Message-Id: <20231021001658.1602526-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010212530.63470-1-dimitri.ledkov@canonical.com>
References: <20231010212530.63470-1-dimitri.ledkov@canonical.com>
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

It is possible to stand up your own certificates and sign PE-COFF
binaries using SHA-224. However it never became popular or needed
since it has similar costs as SHA-256. Windows Authenticode
infrastructure never had support for SHA-224, and all secureboot keys
used for linux vmlinuz have always been using at least SHA-256.

Given the point of mscode_parser is to support interoperability with
typical de-facto hashes, remove support for SHA-224 to avoid the
possibility of creating interoperability issues with rhboot/shim,
grub, and non-linux systems trying to sign or verify vmlinux.

SHA-224 itself is not removed from the kernel, as it is truncated
SHA-256. If requested I can write patches to remove SHA-224 support
across all of the drivers.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

Changes since v1:

 * Correct spelling and grammatical mistakes in the commit
   message. This is a request to replace c1d760a471 ("crypto:
   mscode_parser - remove sha224 authenticode support") in cryptodev
   repository with this one.

 crypto/asymmetric_keys/mscode_parser.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 6416bded0e..855cbc46a9 100644
--- a/crypto/asymmetric_keys/mscode_parser.c
+++ b/crypto/asymmetric_keys/mscode_parser.c
@@ -84,9 +84,6 @@ int mscode_note_digest_algo(void *context, size_t hdrlen,
 	case OID_sha512:
 		ctx->digest_algo = "sha512";
 		break;
-	case OID_sha224:
-		ctx->digest_algo = "sha224";
-		break;
 
 	case OID__NR:
 		sprint_oid(value, vlen, buffer, sizeof(buffer));
-- 
2.34.1

