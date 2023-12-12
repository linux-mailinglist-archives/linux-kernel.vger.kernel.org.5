Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EEE80F798
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377236AbjLLULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377231AbjLLULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:11:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18145CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:11:51 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 083593F15B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702411910;
        bh=XCa0E1lAm2n9GmItdGOx9YyxXLG2EmQaxBESWwE/rt4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=A3DENhALaSHjG3+ns+t3Jeg2d4JveqSt9KKxZE2KWPp9c6nZ5KZ3uq2ohJHGgdgRz
         AuquBg3ihjtE54p8OgvBjNL++2s3NzUey8X0fE2IToc5GQo9Qb9iZQ28ZdqXxg0jyc
         J11phO7V0XjJ8SYWqO5oCYv6i62lwWwnAnUaTvKOaUyYm6TqFc0UJZzwVKkGEhsmgd
         OuyZle5xK9QLDPLAFqZG94cuo3MlN4P49QW9HaIr/j1fgqYjvuVxan669SF/ytj1Lg
         0ZTWT+QDIKI+58JBAX4+k1uDhWHB50z/CyT/EM0STYG9Mw+4vQ++DIMujLkEC843uM
         +TGP3849tMIcw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3335df64539so5093108f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411909; x=1703016709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCa0E1lAm2n9GmItdGOx9YyxXLG2EmQaxBESWwE/rt4=;
        b=Kb96KjCL+9zeDiWyeKk0Xq2iE/YsDeJMnvRRBLDX7cIi8CzWRuwJZ6DwHYE22EsjEu
         c9ZkS321qnD7678ieTalcl0uMs7D23OhWNfI57CoicTSULnoWHHbDR1Vx78KaK9M1vZI
         fv71g2oPMdCZQbVNVJ25/nF78Jt2oNmdYCWAHUcxhmxo0d7xr5zYvs50tSrvxsL+2dRt
         FgsN0X8kJeOlEDWyUgBzij4iuXzBpMYmDu/9yeu1LJjGjt7MnHdxnbnxZtKZvhsNhWsx
         piNOSr4GMtQAuv/VGieR9hoHZMfmjke2Yj9rZWs2xRgcHBzU6QCWaK0SWsQmMYO/o//b
         g2Jg==
X-Gm-Message-State: AOJu0Yxn617iXXjvGW7LTCIv1lIleA+YoqRo7TeVeZjBl9cyUSQIEfr6
        2ALvHdskCTc0zyqYCrW2n29M8n0yZHFLigmXX+AHMZNqxEwr9D3W1W3NsYvBWII7H78bMcSw3gO
        p6DN6LbsCB5KJJu3BmQevwIh0rSSwmZL0EaYdIB18Eb520kS44CLbGHD6oC0qUZGgis7k
X-Received: by 2002:adf:a187:0:b0:333:5eea:9217 with SMTP id u7-20020adfa187000000b003335eea9217mr2212527wru.15.1702411909530;
        Tue, 12 Dec 2023 12:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhmKIpLxUdgrrQ7WvAqj9XuAH88VskEZ2vXPeTEaBOCGCHJeypSS9MRtj/seSY7yK88LhhXhmDW9DzgkLYMMQ=
X-Received: by 2002:adf:a187:0:b0:333:5eea:9217 with SMTP id
 u7-20020adfa187000000b003335eea9217mr2212524wru.15.1702411909255; Tue, 12 Dec
 2023 12:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20231022180928.180437-1-dimitri.ledkov@canonical.com> <ltdfl4l32ht2oimlppyml22q7dst35i6m4foklamapoykkl3ql@u7qmh2aa4abh>
In-Reply-To: <ltdfl4l32ht2oimlppyml22q7dst35i6m4foklamapoykkl3ql@u7qmh2aa4abh>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Tue, 12 Dec 2023 20:11:13 +0000
Message-ID: <CADWks+b+wVxjE4XL750V9qFWN7PPn0pE_1-sex-ZSHYdcUQJ2Q@mail.gmail.com>
Subject: Re: [PATCH] kmod: Add FIPS 202 SHA-3 support
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 15:26, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Sun, Oct 22, 2023 at 07:09:28PM +0100, Dimitri John Ledkov wrote:
> >Add support for parsing FIPS 202 SHA-3 signature hashes. Separately,
> >it is not clear why explicit hashes are re-encoded here, instead of
> >trying to generically show any digest openssl supports.
> >
> >Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

NACK

> >---
> > libkmod/libkmod-signature.c | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >
> >diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
> >index b749a818f9..a39059cd7c 100644
> >--- a/libkmod/libkmod-signature.c
> >+++ b/libkmod/libkmod-signature.c
> >@@ -57,6 +57,9 @@ enum pkey_hash_algo {
> >       PKEY_HASH_SHA512,
> >       PKEY_HASH_SHA224,
> >       PKEY_HASH_SM3,
> >+      PKEY_HASH_SHA3_256,
> >+      PKEY_HASH_SHA3_384,
> >+      PKEY_HASH_SHA3_512,
> >       PKEY_HASH__LAST
> > };
> >
> >@@ -70,6 +73,9 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> >       [PKEY_HASH_SHA512]      = "sha512",
> >       [PKEY_HASH_SHA224]      = "sha224",
> >       [PKEY_HASH_SM3]         = "sm3",
> >+      [PKEY_HASH_SHA3_256]    = "sha3-256",
> >+      [PKEY_HASH_SHA3_384]    = "sha3-384",
> >+      [PKEY_HASH_SHA3_512]    = "sha3-512",
> > };
> >
> > enum pkey_id_type {
> >@@ -167,6 +173,12 @@ static int obj_to_hash_algo(const ASN1_OBJECT *o)
> >       case NID_sm3:
> >               return PKEY_HASH_SM3;
> > # endif
> >+      case NID_sha3_256:
> >+              return PKEY_HASH_SHA3_256;
> >+      case NID_sha3_384:
> >+              return PKEY_HASH_SHA3_384;
> >+      case NID_sha3_512:
> >+              return PKEY_HASH_SHA3_512;
>
>
> with your other patch, libkmod: remove pkcs7 obj_to_hash_algo(), this
> hunk is not needed anymore. Do you want to send a new version of this
> patch?

This patch is no longer required, given that
https://lore.kernel.org/all/20231029010319.157390-1-dimitri.ledkov@canonical.com/
is applied. Upgrade kmod to the one that has at least that patch
applied, and then pkcs7 signatures are parsed correctly with
everything that a runtime OpenSSL supports. Thus if you want to see
SHA3 signatures, ensure your runtime libssl has SHA3 support.

>
> thanks
> Lucas De Marchi
>
> >       default:
> >               return -1;
> >       }
> >--
> >2.34.1
> >
> >

-- 
Dimitri

Sent from Ubuntu Pro
https://ubuntu.com/pro
