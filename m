Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96497D2531
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjJVSWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:22:23 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A1DD
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:22:18 -0700 (PDT)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D2673FA6A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697998937;
        bh=Tl2mFhMN0hrea9vAgi8pl3E5fM4js6s2Rqa0QUC5Vas=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=mxYoCgX+SSmBQlfN+aUey4jfoUIKDDuKFoiMoCzhoeE/2Ej/MnopRyzHlNQheF9JN
         ePoFnNZLXLlnvl4khA1TdE2q8JxX69bZ3tqsFwTIccBepWqskzgG7RtvhjyPDDy4Ui
         7C9kxgTu2iBFN1lD2ZFtC9nAkWEwZSIk6+6yQ6MjVIU7FFlaPx0odZE7APqdZJ58MO
         RiTq9VN/u05ay/pzqm1Zh3zcrP608L47/CBs4q3J1hQaAJ5/Gnn4FSZ4CX4XXcoOmj
         vhVjqoiSH5Cs+0GHo606iA4KLIxG+Mxll092xB91Ns8uHIsRI84xXbnVROTcCBASsu
         l4DxnSt5tDfGw==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ba1949656bso21151051fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697998936; x=1698603736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tl2mFhMN0hrea9vAgi8pl3E5fM4js6s2Rqa0QUC5Vas=;
        b=vrrwS8Tc9GaOzA6qJjnvjsB5ELAwTmzIyjfwik4EuDEDRPRyycSRy7gCDkoW1wX3w2
         bhmZgRrYQFrWPnGVlM1fL/k+a1uws8lBdiNlaxRCGxNYjCRwZkh0G9nIiPXG5gwdHOSr
         RJ7pWTCkAhDNZCArQ3Wjs8iaOKrgmvpCTYSruuAZg1t7xgfAv6uFSvqIl6kUMIGhCVvI
         O81/oPssnRT2HPSE8Qi3zVnZjWifGBhZ7nKpWQZdYooGIjmBEbtI28jf7MLs0vInMNDn
         1dcQiWu5cAnKpEyKbAPeI7qCjRPnFMelMuuomSV8wMXf9y7vJzhLyYg2bkQwM8kJQuB0
         0q8A==
X-Gm-Message-State: AOJu0YxyuFGn9ZXvGsx/V7d5UPGqNcblx7x6Huh8/7vzHmeiY/yFlTyo
        Ny/8pIbGCnGCX2PmeTid/UPgvDIntwcQwW8/ptoi1RB4IvOhbrcxjLx6EMoy/ELwfMWZZS8G+q5
        cKiBWECxUPwWQ6NWX8OMGZtrfN0SqJdHeY6ID6t3eVA==
X-Received: by 2002:a05:651c:14c:b0:2c5:9a5:a1c2 with SMTP id c12-20020a05651c014c00b002c509a5a1c2mr5064567ljd.30.1697998936190;
        Sun, 22 Oct 2023 11:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt+uxWT0Ko/rmy6kgwXvchSpLX67lOoo9KNw9wv4C/8E19DoFZxpm9xbReSkzB+eQRWBZDJQ==
X-Received: by 2002:a05:651c:14c:b0:2c5:9a5:a1c2 with SMTP id c12-20020a05651c014c00b002c509a5a1c2mr5064560ljd.30.1697998935791;
        Sun, 22 Oct 2023 11:22:15 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d6983000000b00326b8a0e817sm6140877wru.84.2023.10.22.11.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:22:15 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] crypto: pkcs7 x509 add FIPS 202 SHA-3 support
Date:   Sun, 22 Oct 2023 19:22:02 +0100
Message-Id: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Recent patches to cryptodev removed support for insecure, broken or
weak x509/pkcs7 signing hashes MD4, MD5, SHA1, SHA-224. This opens
room to add SHA-3 family of hashes, which are not yet broken.

Add support for FIPS 202 SHA-3 in x509 RSA & ECC certs, pkcs7
signatures, hash info structs. And adjust documentation.

This enables using SHA-3 family of hashes for kernel module signing.

For SHA3+ECC signing openssl with this patch [0] is needed, currently
in openssl development tip. SHA3+RSA signing is supported by stable
openssl.

kmod needs a patch to recognise SHA3 hash names [1], submitted
separately.

This patch series is on top of tip of cryptodev git repository commit
a2786e8bdd ("crypto: qcom-rng - Add missing dependency on hw_random")

[0] https://github.com/openssl/openssl/pull/22147/files
[1] https://lore.kernel.org/all/20231022180928.180437-1-dimitri.ledkov@canonical.com/

Dimitri John Ledkov (6):
  x509: Add OIDs for FIPS 202 SHA-3 hash and signatures
  crypto: FIPS 202 SHA-3 register in hash info for IMA
  crypto: rsa-pkcs1pad - Add FIPS 202 SHA-3 support
  crypto: x509 pkcs7 - allow FIPS 202 SHA-3 signatures
  crypto: enable automatic module signing with FIPS 202 SHA-3
  Documentation/module-signing.txt: bring up to date

 Documentation/admin-guide/module-signing.rst | 17 ++++++++-----
 certs/Kconfig                                |  2 +-
 crypto/asymmetric_keys/mscode_parser.c       |  9 +++++++
 crypto/asymmetric_keys/pkcs7_parser.c        | 12 ++++++++++
 crypto/asymmetric_keys/public_key.c          |  5 +++-
 crypto/asymmetric_keys/x509_cert_parser.c    | 24 +++++++++++++++++++
 crypto/hash_info.c                           |  6 +++++
 crypto/rsa-pkcs1pad.c                        | 25 +++++++++++++++++++-
 crypto/testmgr.c                             | 12 ++++++++++
 include/crypto/hash_info.h                   |  1 +
 include/linux/oid_registry.h                 | 11 +++++++++
 include/uapi/linux/hash_info.h               |  3 +++
 kernel/module/Kconfig                        | 15 ++++++++++++
 13 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.34.1

