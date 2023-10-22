Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569E57D251E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjJVSJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:09:46 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7DEE
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:09:44 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B9E313F21F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697998180;
        bh=2u2G7y1eDVG1qOgEBPqskI7dFs5YVWHnKqB6hLgPtS0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JnYWFfzP+HA5L1TWW2gZjveET43ndzN2pKVA93AP3tzmBYg5xHBnrX/IcxePU3Ibf
         YOSVTDQGZz5r1m7otgBhdw5EL8d9uwsB3A75iyOFleacq62Na9Tj5zNhucpRTA0rNe
         VL6qBTk++6PogL2SVzrSERIHF3aU8N2/Q4iqo2n2cJvlDqvflmq5ZZ6J+QrOOwZG0m
         PESXMj/ao+FVES2PunVUzbbrUi39V3n7feQ1jfrpgYBCADsbY5OpW2/3uRHggw6eJn
         uJ3GrUD8KRXopFmNrG53TCQVHChzgoUQLVuLTS4PsSxsNzoycITP2OT1E1Fh+IKxvv
         tUdVJkwMBlvrw==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32da47641b5so1114227f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697998180; x=1698602980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2u2G7y1eDVG1qOgEBPqskI7dFs5YVWHnKqB6hLgPtS0=;
        b=LbsKeD72Vy1xr4XV6UjO35Butlm0LGC93mmDJonkzBl44NaTnnMcx0ms+TazFGN2jV
         Wxkhmc0b8XsxnpV/82bP2Ppjd8tQ/bbDqWL01EqdSluRz9AJsbaRsfXHSowgvYKgpTzi
         bOp4uTK4ZbybntPo825x12CThw/552GD8JsWQRBpzzWEbSaPVSyX8RBxbW7/LKEIB2r1
         uJo96L8HTstZL0E4dmlVbLQQ3wr3ZCiiOuOUjvqTKEPy91r6nXTnQbGCvGjcVM9UhuTV
         MzRdBYr7HK9w3QCODNjzPkjahyIwmcmoK6rFSpIjkKZuC3f6HZRGVpHd11zHKnBT49V1
         NTQw==
X-Gm-Message-State: AOJu0YzZZSeaku3Ow/FMJPbekMRuQa1ypU+i4eJAk7LpUAszXukmJp2m
        ao4pomhlaw0Kl+vRMWaDoAbpamRL6gcqxgPD5Jp2SVjjQsQ1YdI84G+LYGb58sO80jzmuYgkoWV
        //sHeqB2XUYtbl6U11cxKXFTdLMV1cTbf4NOlNz+y7d3y3u1ODw==
X-Received: by 2002:adf:eec8:0:b0:32d:a28b:da08 with SMTP id a8-20020adfeec8000000b0032da28bda08mr5061042wrp.62.1697998179941;
        Sun, 22 Oct 2023 11:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF6+fuKen5t5aCjEjZgy3qEXEYuodjcpENvkNYyWtlK+AEuZVgqjuYUoLyugX/fuwWz8XLxA==
X-Received: by 2002:adf:eec8:0:b0:32d:a28b:da08 with SMTP id a8-20020adfeec8000000b0032da28bda08mr5061031wrp.62.1697998179549;
        Sun, 22 Oct 2023 11:09:39 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b003232d122dbfsm6039011wrx.66.2023.10.22.11.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:09:39 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kmod: Add FIPS 202 SHA-3 support
Date:   Sun, 22 Oct 2023 19:09:28 +0100
Message-Id: <20231022180928.180437-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Add support for parsing FIPS 202 SHA-3 signature hashes. Separately,
it is not clear why explicit hashes are re-encoded here, instead of
trying to generically show any digest openssl supports.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 libkmod/libkmod-signature.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index b749a818f9..a39059cd7c 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -57,6 +57,9 @@ enum pkey_hash_algo {
 	PKEY_HASH_SHA512,
 	PKEY_HASH_SHA224,
 	PKEY_HASH_SM3,
+	PKEY_HASH_SHA3_256,
+	PKEY_HASH_SHA3_384,
+	PKEY_HASH_SHA3_512,
 	PKEY_HASH__LAST
 };
 
@@ -70,6 +73,9 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
 	[PKEY_HASH_SM3]		= "sm3",
+	[PKEY_HASH_SHA3_256]	= "sha3-256",
+	[PKEY_HASH_SHA3_384]	= "sha3-384",
+	[PKEY_HASH_SHA3_512]	= "sha3-512",
 };
 
 enum pkey_id_type {
@@ -167,6 +173,12 @@ static int obj_to_hash_algo(const ASN1_OBJECT *o)
 	case NID_sm3:
 		return PKEY_HASH_SM3;
 # endif
+	case NID_sha3_256:
+		return PKEY_HASH_SHA3_256;
+	case NID_sha3_384:
+		return PKEY_HASH_SHA3_384;
+	case NID_sha3_512:
+		return PKEY_HASH_SHA3_512;
 	default:
 		return -1;
 	}
-- 
2.34.1

