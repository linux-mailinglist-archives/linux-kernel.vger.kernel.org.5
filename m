Return-Path: <linux-kernel+bounces-19719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60E8271D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439AF1C22A07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D82851019;
	Mon,  8 Jan 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Js7/DtjJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3A84C605
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbedaa77289so2050479276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704725409; x=1705330209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pY0HtCQNVEDI/Vsc7JQzdf3b/zPkklUdbelm2DZN3NU=;
        b=Js7/DtjJn/lEf+e0KOJvJaR1gnYra8NEte72OZ0xpzZuTnOmRwj4jdLCZ5Seq0SkMj
         vhYZ0ruLLi7X2e+ffeKIixZlLGR/RQbWTAMvcM7dBpKhj+Wm0thBU3jISSQxbDXNrtFx
         oSdCzFDODBh+Nl1kPVypMryDQEffplmNGzbtJ2g7Mjrc8migeLrGYUDJcXXjz1DD22Dl
         Q33nfx/d03h0ro8TBnxJtTIcDg+NNt03WD1DXtMJZyiuh8ZvBlLdn/P9UM9qnHuoMy/v
         6NQ1Bb6w7bZLoBREAifwKjG8kIZL1qEtowfP9WR2v4UrI1fVxAKj4vQWSaHQbg/Zbfm1
         w8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704725409; x=1705330209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pY0HtCQNVEDI/Vsc7JQzdf3b/zPkklUdbelm2DZN3NU=;
        b=DL5YDJrm2vfrrepHgCHQYQyD6Vs9PvGKNUiaCpUf047Bi7ECWCZbxLcrP6GIxUXzNM
         C+FZDfN2b8QgK7h9kfgYee+KzHvbLBujKFf4SguRsAW7wuz8qQ5OkLh59+EeAl1j5WAg
         7zBfEH4vlahHjTGcsHH6v12+Glw0cclRlMwvYk3Go59K83gThlosz4FsXJ+Dq7ua4w6s
         Tc/hFtOO6EOnxwHXtiAuWO5OKagMwSIEquGZuE9fCljTnOVClSksp0AfjX3277LOvR2Z
         1wUmbFJBRW9CInwU1AygKWRKj5ZKkFIAifCXdxq81xEEWDSu0csvQ/JCKyBuUm/Ke9NM
         Cniw==
X-Gm-Message-State: AOJu0Yxtdermj/qaeil96OxypHtos9K2H0VQgMH6w5CnGUPh0DxbY5vA
	PEGwXII10T7KwhOmfjw9Xp25hfBdDBDu7DcfAJdtVg==
X-Google-Smtp-Source: AGHT+IGJxJ4El1SsQB80UHGXIn9YKxGgM1kwSFmA8mPeiF1/Xo3RC3FFCXswDhgV7dN1lUchDF9BZnUagANvItQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:27c1:b0:dbe:d5b3:89dc with SMTP
 id ec1-20020a05690227c100b00dbed5b389dcmr1610560ybb.0.1704725409310; Mon, 08
 Jan 2024 06:50:09 -0800 (PST)
Date: Mon, 08 Jan 2024 14:49:58 +0000
In-Reply-To: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=p9Hjc0DIm01aLLvHmXgxckf25tmtqAjiAqjiP2XhYzQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlnAuX80giaQX0FdHju3XER/Jm5Yh4IO0sNQLTH
 UnHUWhw7CaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZwLlwAKCRAEWL7uWMY5
 Rp36D/49UpNyjSWnCBZWXnLo//R/VePqgsn8LBRMySFdg2Qi64hzXFpIHq0tyOYcvQXY21Bx3bU
 Z/W02lSB30fuwDsu588yG1fHBp/AxV0xSCZeVQHNoCUX5pBGU8sdiNhpEgYGDOkqRHCAwWqOzmO
 2hM80yeIQRRVmcpW7PmgDhy9yzM5rTRnvteUpN1hTuijKmSr45grtQqflfjBfIRNQCx7TxN5Cy1
 FMqM8v/Ver+FZJa+QphOOPfaL+/logcJTIJXikudNVlAs9HLSFc6dGWEEF0ImNpJbHEOzMcZ4Bi
 J4Z81+wgcHW22R3S3U95p2PM+cbzcm1qR1jYIsuyAKghgYHJEY/VjWdsdxoOcKDUkOyGvqcHsXQ
 fUmpOP4Wlo42JB+/OYUp1b5G+sYxOgcyxKfTpIVDDtZwGCzOMfEL9/15UOd70g2hd9FMvKvX3J3
 XGfhGTlAxagLlanFXkQeeQZk7QOYNVeLgqLVXI4SqyGYoE/djtRUmnROBuo3g8dEOaY+7oUtqfS
 umAlMShmZ3uBnBcNrynYe0x/AaEff9hi31fY2fz5qJaUNtHk9+KY/eOq40gmpoyfZD3FofMo1/4
 T7LIrDVY5lhYfzBOfApioNDE7a50A/n7LNwlz9PiBoK9pcoMch9hOL6KTC8Fv0ZG72tbHQbcE8f p1fAOZcQ5GN1iQA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240108-rb-new-condvar-methods-v4-2-88e0c871cc05@google.com>
Subject: [PATCH v4 2/4] rust: time: add msecs to jiffies conversion
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Defines type aliases and conversions for msecs and jiffies.

This is used by Rust Binder for process freezing. There, we want to
sleep until the freeze operation completes, but we want to be able to
abort the process freezing if it doesn't complete within some timeout.
The freeze timeout is supplied in msecs.

Note that we need to convert to jiffies in Binder. It is not enough to
introduce a variant of `CondVar::wait_timeout` that takes the timeout in
msecs because we need to be able to restart the sleep with the remaining
sleep duration if it is interrupted, and if the API takes msecs rather
than jiffies, then that would require a conversion roundtrip jiffies->
msecs->jiffies that is best avoided.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Tiago Lam <tiagolam@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/time.rs             | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b5714fb69fe3..227dc9240f3f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,7 @@
 
 #include <kunit/test.h>
 #include <linux/errname.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e6aff80b521f..d4f90acdd517 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -46,6 +46,7 @@
 pub mod str;
 pub mod sync;
 pub mod task;
+pub mod time;
 pub mod types;
 pub mod workqueue;
 
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
new file mode 100644
index 000000000000..25a896eed468
--- /dev/null
+++ b/rust/kernel/time.rs
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Time related primitives.
+//!
+//! This module contains the kernel APIs related to time and timers that
+//! have been ported or wrapped for usage by Rust code in the kernel.
+
+/// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
+pub type Jiffies = core::ffi::c_ulong;
+
+/// The millisecond time unit.
+pub type Msecs = core::ffi::c_uint;
+
+/// Converts milliseconds to jiffies.
+#[inline]
+pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
+    // SAFETY: The `__msecs_to_jiffies` function is always safe to call no
+    // matter what the argument is.
+    unsafe { bindings::__msecs_to_jiffies(msecs) }
+}

-- 
2.43.0.472.g3155946c3a-goog


