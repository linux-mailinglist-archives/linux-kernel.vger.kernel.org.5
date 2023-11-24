Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADC7F764D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjKXO0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXO0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:26:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F3199B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:26:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F411DC433CD;
        Fri, 24 Nov 2023 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700835985;
        bh=E7iTdKu4fn1Ymumq/Ib66iyMm8jI92wsu47IFm8eWg8=;
        h=From:To:Cc:Subject:Date:From;
        b=QQn8bLdOcSteKKI4NoxTvR1kXBkQiIFnmnQfkvqFiTC35sbPSgGlsFkbwZJGoJC6H
         eV67CPPIYP6ETHFZjCkemDsMvmYV0HlmNbzguszrB+bkC6JK1o306y0i6OnOu0JMHN
         2bepf+TBMBQi0mO9wJ6Mf4/o249odpT0t89kCoG7j9c7AhtXjfgLpNtq8ciPHNnAPI
         IYtScnGAg7RUFe6o4lUv0AMzx1Oxgv93pQFxWD58u8XsCpglvAVxiU7Myw4Hcg0+4+
         6T6VuRKCHg0J+kvueF5ePAptcHH8WjxzldJmaFuUywewcW08RFKeAZr2EADTG3Dtok
         cWEVVIa+aixmg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH] rust: replace <linux/module.h> with <linux/export.h> in rust/exports.c
Date:   Fri, 24 Nov 2023 23:26:17 +0900
Message-Id: <20231124142617.713096-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
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

<linux/export.h> is the right header to include for using
EXPORT_SYMBOL_GPL. <linux/module.h> includes much more bloat.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 rust/exports.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/exports.c b/rust/exports.c
index 83e2a7070cae..3803c21d1403 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -11,7 +11,7 @@
  * accidentally exposed.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 
 #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
 
-- 
2.40.1

