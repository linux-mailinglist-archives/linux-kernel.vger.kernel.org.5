Return-Path: <linux-kernel+bounces-1578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B773C815060
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF37287913
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781541866;
	Fri, 15 Dec 2023 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcXDDDyV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CF41851
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e03f0ede64so11612817b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702669711; x=1703274511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jxvKbXwjbAGX6GdbkcWO53h3I4l2PzRLmBMsIoNBpj0=;
        b=kcXDDDyVEmycAM/0KvjpEtkST2WOdUKg5csGN94SL7JukLSc5zlJmRvPzWxj671fYT
         YjaygWkNXOixZ5qsQqAuUwAuDte3S8hWq+PM+aJUxNdQNqK8u4mVk26Av5g4hLiKj2xl
         qouDeoGFUkGtoaJCjghsnxjqYfaipnTzR5repaeqn1DpxutrBUxQ13Bs4PZ7wABQeM6K
         3p+aRyZ3hdphACyaxIIuaw1ypYdnNz4fYqbYr/6nhxmMblRj27Eop+CE+jNiNlWUJC33
         zTPzxqTjDoTrKsuMmdWukOZwjWLxnDfBwf5Tbk3o7ATgD8IH7o4HU8/iBJhDzsJ9R4WB
         KC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702669711; x=1703274511;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxvKbXwjbAGX6GdbkcWO53h3I4l2PzRLmBMsIoNBpj0=;
        b=At5iRVB16mHJ2GuMD3QLzw7A2jGUDuG6mRMibrCYScANGw8STPZlXc2XBZYBuJEJl1
         Aqz6E752lyAEiW2Lnq+42KGEDl4rtmNo7gOTDY4RNb0MMijPF7vvRXvLQBKqHDeMkw3h
         N5G2/W+iK5dSKfrDTgGLTposEExK/tI8GsjP8a/YwBKeqzF3UD1SaDlgTSZfhD1xpEC2
         6Fk6EIxo0YqAoTAYigwtXhzh3h1b8r5PLzrsUF4iqRy+LynYOhVt4eizaqY3VYVVXLh4
         b+pzB+yW+LNoxmJspxJsuXtAMY4v1pAH1ywxvXx4r+cyl11ryt2wRKMdDELE+WhUo3m4
         84MQ==
X-Gm-Message-State: AOJu0Yzob13d8XxmZdVCACfihjMmp8h/YSNsgIjCLvmqWUO3Dc7QcZL8
	1I6c3I4ejzRyDAaeN60BD43+r9dpuWGO
X-Google-Smtp-Source: AGHT+IHC4TnKySuHLFy1qU6pY4sY2mdSNqJv+Lq+o7C1yfLFhEnIjpAoToLT14qb3uuo1AeTCXhR7qVVyJzo
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:3381:b0:5d5:5183:ebdb with SMTP
 id fl1-20020a05690c338100b005d55183ebdbmr143624ywb.10.1702669711738; Fri, 15
 Dec 2023 11:48:31 -0800 (PST)
Date: Fri, 15 Dec 2023 19:39:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231215194828.2611213-1-mmaurer@google.com>
Subject: [PATCH] x86: rust: Disable entry padding with Rust
From: Matthew Maurer <mmaurer@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

rustc-1.73.0 used by Linux does not support entry padding. Mark entry
padding support as explicitly incompatible with Rust.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---

This is temporary - upstream in the Rust compiler, I have:

* A MCP[1] to enable the feature as an unstable flag
* A RFC[2] to stabilize it and add the attribute
* An initial implementation[3] for the MCP and RFC once accepted

Once at least unstable support is merged, we can detect this in a future
patch.

Even once those are merged and Linux is using a newer rustc, we will
still want a separate HAVE_ENTRY_PADDING config, as Rust's gcc backend
will not initially support it.

While this is a temporary patch, I still think it's worth carrying
because it prevents us from selecting build configurations that will
fail at runtime.

[1]: https://github.com/rust-lang/compiler-team/issues/704
[2]: https://github.com/rust-lang/rfcs/pull/3543
[3]: https://github.com/maurer/rust/tree/patchable-function-entries
 arch/x86/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 18b9fb7df95b..a9d48709f7db 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2452,6 +2452,9 @@ config CC_HAS_RETURN_THUNK
 config CC_HAS_ENTRY_PADDING
 	def_bool $(cc-option,-fpatchable-function-entry=16,16)
 
+config HAVE_ENTRY_PADDING
+	def_bool CC_HAS_ENTRY_PADDING && !RUST
+
 config FUNCTION_PADDING_CFI
 	int
 	default 59 if FUNCTION_ALIGNMENT_64B
@@ -2469,17 +2472,17 @@ config FUNCTION_PADDING_BYTES
 
 config CALL_PADDING
 	def_bool n
-	depends on CC_HAS_ENTRY_PADDING && OBJTOOL
+	depends on HAVE_ENTRY_PADDING && OBJTOOL
 	select FUNCTION_ALIGNMENT_16B
 
 config FINEIBT
 	def_bool y
-	depends on X86_KERNEL_IBT && CFI_CLANG && RETPOLINE
+	depends on X86_KERNEL_IBT && CFI_CLANG && RETPOLINE && HAVE_ENTRY_PADDING
 	select CALL_PADDING
 
 config HAVE_CALL_THUNKS
 	def_bool y
-	depends on CC_HAS_ENTRY_PADDING && RETHUNK && OBJTOOL
+	depends on HAVE_ENTRY_PADDING && RETHUNK && OBJTOOL
 
 config CALL_THUNKS
 	def_bool n
-- 
2.43.0.472.g3155946c3a-goog


