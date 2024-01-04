Return-Path: <linux-kernel+bounces-16746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9032824340
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF9C1F250C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC92225CE;
	Thu,  4 Jan 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tC9ORHNy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F822EF6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2cd03f1b24bso5539481fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704377004; x=1704981804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pY0HtCQNVEDI/Vsc7JQzdf3b/zPkklUdbelm2DZN3NU=;
        b=tC9ORHNy6QoR6B4TYQt9gNqVlmQs1ACK4sGo09SZWQai8RvV7jScTv/UiPplMbzZNW
         7sYyu5sN3wjUTPNK9Czml5/Jh7qFo6TPTjU/CbWKhmL7DeveUlZVRn7xPEdYzctnbcg6
         IeBpuvpB3O3R49g4szniHihILXy6BuT2cGmwsDS02A3J8S/4IkCq+a0XMbenkcDoytML
         5xZMVOBl5WdiUC8Q6PF7QWvTD0UsutIXBDYpyfb4NTTT5E4punH6TfvA/DxKNz8h/s7X
         aGVgo1fD4Kmz/ZT3cnNhzuGJLzp5RaITCuAfwhORKdRrAWTGIhYc7UOjQh9w7FfcOK77
         F8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377004; x=1704981804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pY0HtCQNVEDI/Vsc7JQzdf3b/zPkklUdbelm2DZN3NU=;
        b=EQwckqWVzZK/7OtJ5HenRDGRhDnu24GtBh/8kQam1UpqxYfmXMCgOQ0N7ii8GNUZ7T
         RH/Hh9t5OhW40NZOuVjh+WOQ3Z2P1Ob5M4CL5ZUgg9JnYJlQfh2N+wfDbpMfom8hW+k1
         RrFo8crUHfKEt8ALThIAY6ktIoZCZGgCfYpMmgb0vBRH9MsqrzWDuGdJI6TK6kmI3Sfo
         /+BtV8v5vcDFVc+ZO495K53giUMa21x98I8+y+8wWRA4aesBxWUpb/AYo5rfb9WP2Lk5
         YXszu932Lg3IG4T3JpC9gHbqnVNXJoI0Wb91a+oSk0jkjY4N+zYNQ2y0i8vqGtqXbhMv
         r71w==
X-Gm-Message-State: AOJu0YwGrRj1IQxnpAbSVoiOSUHHIum3zDxQqCF2aD30E/PoPS80KRRM
	mL1GTz16HnMNYpapROZDXCyppZ9rkMFLtS9BkwdmSg==
X-Google-Smtp-Source: AGHT+IELjFaDM7ROjJaxp18Ms8IfQA7iRjeQ9qHX1i3T0MNVzQ4ejL88pbznMOE5OdBX0g7vTGq6MfKXN7GuOsI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:97ce:0:b0:2cc:e8cd:c15e with SMTP id
 m14-20020a2e97ce000000b002cce8cdc15emr1111ljj.4.1704377003781; Thu, 04 Jan
 2024 06:03:23 -0800 (PST)
Date: Thu, 04 Jan 2024 14:02:42 +0000
In-Reply-To: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=p9Hjc0DIm01aLLvHmXgxckf25tmtqAjiAqjiP2XhYzQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBllrqhTED+RqzR3DGEktEueQ+JDDTTkuSAC7YXM
 8GqPGpOWRWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZa6oQAKCRAEWL7uWMY5
 RvdLD/95YfRPjzU4C6ejj3MZZi1uOUQ5JEy8zAgsnwEwRg7KjRm41K7YtnKhlSKDOYCYd2ujRQ4
 MUQGC3KDpZeKiqZBSDvWBFGZ9f+5Drjm4BQm7zcvFKqgP/JGSQByEzvv8Tq1aqad8YBsHT1WNk1
 TmUtuWFY3bWmxQF8rcKksMmSo4sqipN+3nGMeKPHN4li4Ubq39P/mpYJ3BWPf7wpR4Lozvvtlkj
 UC4fvQIjxi7YketJEDrtJzOAPB7Og65RaakngKqBabtEzmH+gOl/mzowmbhmPV02CJ/WJ8/Q6m+
 xaPg10C0xKvwUjVvQDs/M95CX1RLjD92e6fGhaGOVVCbisqRJdSm3VPK6bjZKdctrfcfMNxHOxP
 wjS8H34nu+6R/c55v1aznjQXFXcFVZhLhZQjFXSOspWwzWxkChAT98aBCs7V8dTHcZKKm+bR4L4
 A8kEpD97vAx/c/bG25K3sNRP+wzenJfYLFjrSenTmXI9UkFHHF+07GdCR1Tb9SrVtHpTDHaVfvt
 Nh4/4q/lBojDMVaXNKHBMhcwhWnQYbddNNqX4QDk0fiYN6k0wHQhAhFN0y5F7W806x8VbXEV8lS
 /HJIell9u/uNHy8GHm8owOr3AksMeQRm1oXaLv2sMU1u/Rwoh7Egz3lKlB8Quupqpz8UHHi9/94 348GYEmm7Am6CDA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240104-rb-new-condvar-methods-v3-2-70b514fcbe52@google.com>
Subject: [PATCH v3 2/4] rust: time: add msecs to jiffies conversion
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


