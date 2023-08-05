Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9A977130D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjHEX6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 19:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEX6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 19:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FAA128
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 16:58:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8339C60DE1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 23:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF8FC433C7;
        Sat,  5 Aug 2023 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691279887;
        bh=fs4x6PeHwicN8FTsqkY06qC8SCDDAnU0rMG7AHf+rjw=;
        h=From:To:Cc:Subject:Date:From;
        b=Yn7s93IO+w2baPotkwDuOiqsj9MbRC11d10rg62BYBreUuDHhNWdQhcX3R6LscCbs
         c92PEplaUEGIv3VjAInEY7ihjcmShP/e09QkVMvLGsHOJZ+6RCxSQ+kh/UWMU7gxsj
         UZWXIs+t+/PwdYmoqtb7BmCNmKKN4uUmZO3fGXeyYspOGG562UsS4oYvon1Af+8/Pt
         1eFkTkB437NVcAurn2lJfb2Ett+B/u3C3pTo4cw2WZrxPAkXXR9j5LcnTByw4yr53C
         yrhQPrbG8/5bM8VUu1M1klMwrw5TeUQoq5mNhqQiiZUL/PRTvzO9/K41MWlFf+cVfp
         LLwm4SpcAHEsA==
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
Subject: [GIT PULL] Rust fixes for 6.5-rc5
Date:   Sun,  6 Aug 2023 01:57:50 +0200
Message-ID: <20230805235750.54075-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these fixes for Rust.

The oldest is a bit involved, and the other two are straightforward.
The complex one has been in linux-next for 4 days and the others for
2 days, but I reworded yesterday the complex one to add a couple tags
(no changes otherwise -- you can find the previous version of e.g. the
oldest in linux-next at cf222ce8477c).

No conflicts expected. No changes to the C side.

Cheers,
Miguel

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.5-rc5

for you to fetch changes up to b05544884300e98512964103b33f8f87650ce887:

  rust: fix bindgen build error with UBSAN_BOUNDS_STRICT (2023-08-04 17:10:50 +0200)

----------------------------------------------------------------
Rust fixes for 6.5-rc5

 - Allocator: prevent mis-aligned allocation.

 - Types: delete 'ForeignOwnable::borrow_mut'. A sound replacement is
   planned for the merge window.

 - Build: fix bindgen error with UBSAN_BOUNDS_STRICT.

----------------------------------------------------------------
Alice Ryhl (1):
      rust: delete `ForeignOwnable::borrow_mut`

Andrea Righi (1):
      rust: fix bindgen build error with UBSAN_BOUNDS_STRICT

Boqun Feng (1):
      rust: allocator: Prevent mis-aligned allocation

 rust/Makefile                   |  2 +-
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/allocator.rs        | 74 ++++++++++++++++++++++++++++++++---------
 rust/kernel/sync/arc.rs         |  3 +-
 rust/kernel/types.rs            | 22 ++----------
 5 files changed, 64 insertions(+), 38 deletions(-)
