Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA51F7C426D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjJJVZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjJJVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:25:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C236294
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:25:40 -0700 (PDT)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D50DD40342
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696973138;
        bh=4UvItTACB+h7HBV2ug6VBd/ji6l7lMzN70Cv1HLypsg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=sm5He0OYV60PLj3ngvt0TcDQmF1CYL/mjpsimEJpizp+e/tirBGPuuznwTbZhcl9b
         DhttDb1SOY8bpLFYun3cUteYb3+IZrt8/e7vr1C96NqDp17yV1bhsYIG1QSFg5ahsO
         a0x/cLyZHKWCy9dIwe/BRLru3Vkf7z3iRwI96xLlWcpRuRfurhBBytUuHV7BibgW/6
         Pj1fcyBaheQCJNW09vVN3ghl6bsjLl8/GcrDUijfk7iV4GVVAUfMvtU7FTp3bLdpOi
         lZ8wahns1UUwEhTDnFf03tfs+aeRYT4dufZZI2xfkal3FpXA6AzyYNnFdkzyDitqi4
         i7tYZWeo35C/w==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c9c92c4aaeso2852495ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973137; x=1697577937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UvItTACB+h7HBV2ug6VBd/ji6l7lMzN70Cv1HLypsg=;
        b=xF6AZZ2YcnqLp8C8xI+nshch+AzwPP2Qjrnb5DLyNUCsyQ/xatQTNugYWp9JPg1vVM
         inq4U9Zjs27Eq0rGrj02p1bmDfd12m1WkWgYpMJ9VeYt/ACUigYRbM5gvNYJ1npzhuat
         yzfR01zBUCJsX/9o47qFwGqVVKqqVVCplmyX7iQnFpfvqvKxCokX2OHfzTKzhehZDogx
         vlcKt613IKWipstxbDwLhakEGc/SJjFbRRl965TArtmjTxtd6Abmlkg+0zfm8higbcSz
         jZzrXOrvn8SuIl4RDjKt7N3DLgzuWY3O6RXuuLs2sX00gdyw0Vx2Xd0ynQ6bWUPhrqcg
         xozg==
X-Gm-Message-State: AOJu0Yw1p8XtEloBJVoN3SiGUUGe9Jiob68DYnY7ycqJiWdScZigNtDW
        +aK7TA3eZQAxcgpNEAhuTj80t2S6gcl/740xFG2RzU/9NOFONd77qUdlkxu4mH9HQ+uhx1fs9kO
        suhherYx7xEhj5JAjMnqDkmTWTqCrYP6bgQZgdJDyCQ==
X-Received: by 2002:a17:902:e549:b0:1c5:70d3:f193 with SMTP id n9-20020a170902e54900b001c570d3f193mr22210208plf.10.1696973137449;
        Tue, 10 Oct 2023 14:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHEguQ4N7lg7aridkHxtyB/VfYcw1MjO95tRaY7miJA3ybH/DJ6WxOMs1XQBczR1JDzMvAWA==
X-Received: by 2002:a17:902:e549:b0:1c5:70d3:f193 with SMTP id n9-20020a170902e54900b001c570d3f193mr22210195plf.10.1696973137142;
        Tue, 10 Oct 2023 14:25:37 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001bdc3768ca5sm12222073plh.254.2023.10.10.14.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:25:36 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: mscode_parser: remove sha224 authenticode support
Date:   Tue, 10 Oct 2023 22:25:29 +0100
Message-Id: <20231010212530.63470-1-dimitri.ledkov@canonical.com>
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

It is possible to stand up own certificates and sign PE-COFF binaries
using SHA-224. However it never became popular or needed since it has
similar costs as SHA-256. Windows Authenticode infrastructure never
had support for SHA-224, and all secureboot keys used fro linux
vmlinuz have always been using at least SHA-256.

Given the point of mscode_parser is to support interoperatiblity with
typical de-facto hashes, remove support for SHA-224 to avoid
posibility of creating interoperatibility issues with rhboot/shim,
grub, and non-linux systems trying to sign or verify vmlinux.

SHA-224 itself is not removed from the kernel, as it is truncated
SHA-256. If requested I can write patches to remove SHA-224 support
across all of the drivers.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
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

