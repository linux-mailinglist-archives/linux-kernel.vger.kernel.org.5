Return-Path: <linux-kernel+bounces-2231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D98159FA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC6A285D53
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE130FA8;
	Sat, 16 Dec 2023 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFK+QRWX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F830677
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-50be5bdae9fso1422176e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702740715; x=1703345515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XdxQEaIrLyM2shqQ86h8R9r1OVkGiHgwK8DLLX+9PM=;
        b=zFK+QRWXtRe2wERG8G50NQvXPYv05St1zsnKjVU4S6dYvFqPZf7CHiBO4Cc5+sM1WB
         uKhIQLt2wNPjwkv1RpRfRD49stc/4VZE+yoZyGdrT8ms7lIlLHLoUT7Q1RAs9IpYoKbh
         rnP9XAvnckJ2g+CjGR84rI+Bamd3YWXbhqEz016xJ2BVLkppldBg16k2r/sE0uaVfgxN
         g2lKNN5JcDK6Q4jsA84S/NAH9XvWBMQUzOdTHnhHuaJH08VmXnF4+O/QSpxjt1KH6WZE
         nx2v+IcESJU7EN7G3RwASBtaBQcwuivzgoOC2+HfzTVqY/itiio2KzDRLvev5vA8a9un
         ad2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702740715; x=1703345515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XdxQEaIrLyM2shqQ86h8R9r1OVkGiHgwK8DLLX+9PM=;
        b=KuKQLfFs9nxDkEjvLfTbiEugKo9lVEY8t76ygGHUxaZJN5NBFrrkR62fOxKo35zcXp
         g1TE9xz3Uhe48g70NekmrL+/qa6JU+ZPqPw3JhvmuiP12qVhjjZQBLwiS14dtO3asnGt
         0SUGsNYDwWJ3g2DVgDoEa5LeCF8gy0slcjP5T59dJqgYHUXKlwgYQ4z2CP+crV2Cfqua
         FJbFim2/IZGdQ6amZSNFYdPcIKdHToXdVfIM5/NzTUR18ZEzaHRJHUvNuxmWMg9VkyFZ
         rwgncW5nuQl8gFtuswq6OBKaMYq8dB70OBbV7GkAQVB7/7wHRnhve79P0us5DZBDdk78
         u6pA==
X-Gm-Message-State: AOJu0YwxULy1S9e8+Vd2+L6zb7AWBnvjgMwI8WfEQ0nuuNFZuEps2aSO
	gUj0TWscv6OxKfshxTu7433sQkVgXAjpO+M=
X-Google-Smtp-Source: AGHT+IEthAYpaHDCMjYR8nUdZ+/YnPDTYSr6eCrXIphwuuiveREFJUiTzweZakr2KUYW/17OoW2BModVj1nx+Sw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3ba8:b0:50b:e73f:da50 with SMTP
 id g40-20020a0565123ba800b0050be73fda50mr120667lfv.1.1702740714659; Sat, 16
 Dec 2023 07:31:54 -0800 (PST)
Date: Sat, 16 Dec 2023 15:31:40 +0000
In-Reply-To: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=TlYeKLnmj5lAoBU99t4m6Fy/w/vV4RiIS0XGhAp4JT4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlfcLgl4BrfTd4DVnj7BHnDlDKdqC79XAmSxNM+
 8SzFF0LZ0+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZX3C4AAKCRAEWL7uWMY5
 RmufD/4/uTwFp1pjkeBY8c/cz9iCxJLYt+glC3U5xg6hjNcM0khejVJBGTqPetTD2JgWYkqWfy6
 vXCxpFAgeSdTRH4+ChLY+DmfKlp+V3rUKRN4gNEgzKgIK6tovaHzx3ooH7Q5V+Jqb+jH6aRR8gX
 2s8VGYTDnLT8r2ahWai+tHJCuqr4gEt8rn/DMJgpIJCDA8XreDpDGwmvW1Esc3aLL9OJlHV2d1x
 Jpx67gsRo8Y9xRZLTXV+qQEQe31fP+BjWdRsuyKiQjWJc9hh31QhtpbxpYjeSl7yFg9J/XoAXXw
 3KO22adl2WDRbfTPlw+zL/S01N4EVTxe+nS9BcQdE7aMCigLwOJWFq3D6uewR1Uj+fW3WSy7Bgk
 C82NwBXOe6iJz1BsfF2n+iaVquFpXURwlfUJDkbk/s60IpjZ8/XovZOdZ2s4ArxrZTxBSvv6yjk
 97XvPnZXeC4T2cwp/pxZDl/okOpGj5ylmt0ozU5bs6Ks45cX3Q0vFhonlbJwa4eLx8raLkF9ttX
 OI2jp3S6PJA3KnUiNNNsMZdl1kDQkxq9xc4Frm9no4K9iH1/0uhAinxYqUJJg5aH3ct+mj0s3GV
 9X0p4FSoXpLwUj21QJBj52KSO8TogltLSmZZUX520Mm0J15waUfpjGq5MlLQAvALZTBov2yt4k1 nQRtMKZRz2kiilw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>
Subject: [PATCH v2 2/4] rust: time: add msecs to jiffies conversion
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/time.rs             | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 85f013ed4ca4..c482c8018f3d 100644
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
index 000000000000..23c4d1a74f68
--- /dev/null
+++ b/rust/kernel/time.rs
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Timers.
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


