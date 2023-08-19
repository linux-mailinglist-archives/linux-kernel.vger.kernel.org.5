Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72355781FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjHTUm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjHTUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 16:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2D46E170
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 12:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 250F960B5B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 19:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BDCC433C8;
        Sat, 19 Aug 2023 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692473817;
        bh=5TyeQjTLWSpiPjfMhus5haTkjykIBpujJRFZlCRb9xk=;
        h=From:To:Cc:Subject:Date:From;
        b=kC4JjgfI7hLYcOsAefmfrYG9ovyd1iuKPjzEEfi+jFdhOYGtUBptjOYx47rAtw+Gi
         Fi5lPfcaX0e6QJn6em9bM6on09NueyMLrGuoyvE+wHsb72o0gjRQYWUChT7Mwf+0Za
         FiOs7BpcqU1MiHuPeY93h+Ygyq/mGi8ycCo9bdhC8clPipGLgOvKmMLFNFO4r7NQd4
         LLpIJ5c/MEOzmg1QoTeZGm2gLif/L8e9oh6SInrR/1x/krrQ63t0fFI/8YbxCXm65z
         R7Yqua8k0jCshLGdP+JGrh9RQu/hp73AWa/JKI1OdCdnVRWnO5G01msI4i3Ca+EuH0
         KM3DA+HnWI/ug==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust fixes for 6.5-rc7
Date:   Sat, 19 Aug 2023 21:35:41 +0200
Message-ID: <20230819193541.290947-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this fix for Rust.

It has been in linux-next for 4 rounds (i.e. since the restart on Tuesday).

No conflicts expected. No changes to the C side.

Cheers,
Miguel

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.5-rc7

for you to fetch changes up to 3fa7187eceee11998f756481e45ce8c4f9d9dc48:

  rust: macros: vtable: fix `HAS_*` redefinition (`gen_const_name`) (2023-08-09 21:15:07 +0200)

----------------------------------------------------------------
Rust fixes for 6.5-rc7

 - Macros: fix 'HAS_*' redefinition by the '#[vtable]' macro
   under conditional compilation.

----------------------------------------------------------------
Qingsong Chen (1):
      rust: macros: vtable: fix `HAS_*` redefinition (`gen_const_name`)

 rust/macros/vtable.rs | 1 +
 1 file changed, 1 insertion(+)
