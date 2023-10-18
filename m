Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7B7CE457
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjJRRYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjJRQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:09:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A76123
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:09:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919F0C433C8;
        Wed, 18 Oct 2023 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645380;
        bh=NyxodQYdJN0bXaAwMa3qhqruplmUOckpXetLVK/mv+U=;
        h=From:To:Cc:Subject:Date:From;
        b=Z9CbGLM/xDgsJI+RiGEhkR5IrBIVA64HzatG1ofgD+AuTv2gqNlE0kqg16r/Trjml
         jQq0sGq/kL99bDSxXBM35tr6NoPr1/Jt3YLOjN2L/aA2Gnp80EWF1myFxMg52P83Ie
         +I0Emft9mPi98sXvu9/3n2bqwAZUBWtj7kXwZjACj5NzS52Aa8hIGiwf4UI1FC/61Y
         0dNmxtR4mJgxZdpraU0Eionu9ocgLYTv50XxFxgGyjJjpEpPj6R/HF2RkeSjfojMHJ
         wYQvgZagwrQctELg/zCV0Rgr3bGqjo2NKELiph0xLGwSLZB45wwm7yJRS2g1R/cst0
         Bw5sKw0UekQgQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH] docs: rust: add "The Rust experiment" section
Date:   Wed, 18 Oct 2023 18:09:22 +0200
Message-ID: <20231018160922.1018962-1-ojeda@kernel.org>
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

Clarify that the Rust experiment is still going on to avoid
confusion for both kernel maintainers and end users.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Andrew: I did not add a `Suggested-by` just in case, but please let me know
if you want it, of course.

 Documentation/rust/index.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index e599be2cec9b..aaed36af15ce 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -6,6 +6,23 @@ Rust
 Documentation related to Rust within the kernel. To start using Rust
 in the kernel, please read the quick-start.rst guide.

+
+The Rust experiment
+-------------------
+
+The Rust support was merged in v6.1 into mainline in order to help in
+determining whether Rust as a language was suitable for the kernel, i.e. worth
+the tradeoffs.
+
+Currently, the Rust support is primarily intended for kernel developers and
+maintainers interested in the Rust support, so that they can start working on
+abstractions and drivers, as well as helping the development of infrastructure
+and tools.
+
+In particular, if you are an end user, please note that there are no in-tree
+drivers/modules suitable or intended for production use yet.
+
+
 .. only:: rustdoc and html

 	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.

base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
--
2.42.0
