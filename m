Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD17BABC8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjJEVG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjJEVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA193
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:06:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B725DC433C7;
        Thu,  5 Oct 2023 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696539982;
        bh=YfqyS9WxVzb/A7U5Hv72w/JQ1t032hVcAjgCKY/OijA=;
        h=From:To:Cc:Subject:Date:From;
        b=J8J9bDmXq6Qpu3XMq7WeDO2QKIQPlKmVeJwicR9dX8W6S12PoJQLIua4hcsU3a9Ni
         CcGuc3y+FUO8X1Dbtc2u+EkfDy6QUz17GTzit12/ni+1FdmdV9Wtxi7vvticZHzsWX
         GKlCTGSKRfwbcWzp8najiDtNjrIaRO+EcrS9Ok0KAHsenaPuNfdCp+ULU18IqWN6GA
         L+eMRqG9KeuSHGFg06o1R6Q+dV3YYFsQT3DThxT+IPa35CzGhfu5LaVUTLFfEBUOHc
         g12rZxNGyNsIFNC5oU5Y+VayW8apsnc8CbUB/AtMdr0z1tUoDH01bYTv2lICYqTAEE
         S5HSUN28p4kyw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 0/3] Rust 1.73.0 upgrade
Date:   Thu,  5 Oct 2023 23:05:52 +0200
Message-ID: <20231005210556.466856-1-ojeda@kernel.org>
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

This is the next upgrade to the Rust toolchain since the initial Rust
merge, from 1.72.1 to 1.73.0 (i.e. the latest, released today).

Please see the main patch message for a long explanation of the upgrade,
the policy for future upgrades and some indications on how to easily
review this.

The series is based on `rust-next`.

Miguel Ojeda (3):
  rust: task: remove redundant explicit link
  rust: print: use explicit link in documentation
  rust: upgrade to Rust 1.73.0

 Documentation/process/changes.rst |  2 +-
 rust/alloc/alloc.rs               | 22 --------------
 rust/alloc/boxed.rs               | 48 ++++++++++++++++++++-----------
 rust/alloc/lib.rs                 |  5 ++--
 rust/alloc/raw_vec.rs             | 30 ++++++++++++-------
 rust/alloc/vec/mod.rs             |  4 +--
 rust/alloc/vec/spec_extend.rs     |  8 +++---
 rust/compiler_builtins.rs         |  1 +
 rust/kernel/print.rs              |  1 +
 rust/kernel/task.rs               |  2 +-
 scripts/min-tool-version.sh       |  2 +-
 11 files changed, 65 insertions(+), 60 deletions(-)


base-commit: b2516f7af9d238ebc391bdbdae01ac9528f1109e
--
2.42.0
