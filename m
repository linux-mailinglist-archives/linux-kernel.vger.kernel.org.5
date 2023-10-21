Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704C27D1EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjJUSNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJUSNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:13:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E952BE0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:13:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74927C433C7;
        Sat, 21 Oct 2023 18:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697912009;
        bh=gzjUjx2WGvm2QpBdpcflVOOF+V0AaHW/vxI6GqWUntI=;
        h=From:To:Cc:Subject:Date:From;
        b=Smf8TAyxjlqJdoUn1ElF6enMEajnSOa+bkEiiO8kQOlWwF7MbLRMXH5zsyEyAWpmu
         EBiJMilevSYrwJVmkm0RANt2Aa4kbz2Oaws+njlUJncJ4N8du+ymC1853DC+c53aaH
         3/xJQk5jQzjxozIu417+eqsgTizPn05i7zA6uv8AyQbKW4yrtYU6aguyPZetWJfRhB
         KYpJ/aHXuS3Eo4v7Gu0LtSDHlEsP6R47f25oDhbNoN9tCpovk5A94aryzJ50l6EUGJ
         0673gb1Ggx9pXFr/9n2RtZR8xehyQvZMM7moNR+HDGmowN3TXEdT1Hz/idInnsEcxv
         BuatpBjipVbgg==
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
Subject: [GIT PULL] Rust fixes for 6.6
Date:   Sat, 21 Oct 2023 20:12:59 +0200
Message-ID: <20231021181259.10931-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these fixes for Rust.

The last three commits have been only a single round in linux-next, so
perhaps they should stay a few more days there, but I decided to send it
already since they are simple and do not touch anything critical.

No conflicts expected. No changes to the C side.

Cheers,
Miguel

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.6

for you to fetch changes up to cfd96726e61136e68a168813cedc4084f626208b:

  rust: docs: fix logo replacement (2023-10-19 16:40:00 +0200)

----------------------------------------------------------------
Rust fixes for 6.6

 - GCC build: fix bindgen build error with '-fstrict-flex-arrays'.

 - Error module: fix the description for 'ECHILD' and fix Markdown
   style nit.

 - Code docs: fix logo replacement.

 - Docs: update docs output path.

 - Kbuild: remove old docs output path in 'cleandocs' target.

----------------------------------------------------------------
Andrea Righi (1):
      rust: fix bindgen build error with fstrict-flex-arrays

Manmohan Shukla (1):
      rust: error: Markdown style nit

Miguel Ojeda (3):
      docs: rust: update Rust docs output path
      kbuild: remove old Rust docs output path
      rust: docs: fix logo replacement

Wedson Almeida Filho (1):
      rust: error: fix the description for `ECHILD`

 Documentation/rust/general-information.rst |  2 +-
 Makefile                                   |  2 +-
 rust/Makefile                              | 16 ++++++++--------
 rust/kernel/error.rs                       |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)
