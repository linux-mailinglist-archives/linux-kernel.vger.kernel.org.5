Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3AE78DBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbjH3Skl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjH3RKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:10:10 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 10:10:02 PDT
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFC619A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71AEBCE1E17
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8F3C433C7;
        Wed, 30 Aug 2023 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693414833;
        bh=kX3mbHSLmaQyCEL60tmf9cx9ZOhGXkKv6MDHN2D63vs=;
        h=From:To:Cc:Subject:Date:From;
        b=jF6UcKfH/Ijm8BSR75OyktOFykk2hCPJ+WW84zdAuI8LFdEyqrl7Ohkei3L30Y2Zf
         otGqyih898gvIjejvVAGC+2UKXeyYWmcj4nuzrttxOPrf501BtbrB52+eHOSe4FLlN
         E6ZWRiupNKoNyYHHoG1E7LuOKn+ttvWkzJc9yNHXyNqO4YEW1F8XVCbxkysmVJUGmw
         6RQ+ZBT+fjuN4hpd2o6TfbTudgzRL4P1EWVCayRjSKcchD7A4Bg85EejZqw7bpLxtM
         581+8pz6W3QmP+knhYUvvdmVvIV3LAhGRlWFXmjh4BkrCyDYQmTjy7r9Yo9iISD/Hd
         r+A9OD4DZg+aQ==
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
Subject: [PATCH 1/2] MAINTAINERS: update Rust webpage
Date:   Wed, 30 Aug 2023 18:59:48 +0200
Message-ID: <20230830165949.127475-1-ojeda@kernel.org>
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

A few months ago we started a webpage for the Rust subsystem and
the overall Rust for Linux project [1].

The current `W:` field of the Rust entry points to the GitHub
repository, since originally we kept information in a `README.md`
file that got rendered by GitHub when visiting that URL.

That information was moved into the webpage and got expanded.
The webpage is also nowadays the entry point to the project,
and we pointed the "Website" GitHub metadata field to it.

Thus update the `W:` field to point to the actual webpage.

Link: https://rust-for-linux.com [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12601a47c839..7c8088e9a11b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18558,7 +18558,7 @@ R:	Andreas Hindborg <a.hindborg@samsung.com>
 R:	Alice Ryhl <aliceryhl@google.com>
 L:	rust-for-linux@vger.kernel.org
 S:	Supported
-W:	https://github.com/Rust-for-Linux/linux
+W:	https://rust-for-linux.com
 B:	https://github.com/Rust-for-Linux/linux/issues
 C:	zulip://rust-for-linux.zulipchat.com
 T:	git https://github.com/Rust-for-Linux/linux.git rust-next

base-commit: 4af84c6a85c63bec24611e46bb3de2c0a6602a51
-- 
2.42.0

