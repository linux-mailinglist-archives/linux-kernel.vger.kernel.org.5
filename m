Return-Path: <linux-kernel+bounces-123533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042DD890A66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5545CB236F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF113BC35;
	Thu, 28 Mar 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3QhY6pb"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC113BC27;
	Thu, 28 Mar 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655737; cv=none; b=fMSqC8J6cpltg8xUHnI7b2zNNtLWL6Zi4GzqqugNvkNg6IHnAhXGNwzDeXvr/CixSSgn4ZQl9T5TGnbuH2KSML+JLYNboPNc/LcZoDuxz7l6MpXcJCMU6ogKuRpu+vHvMW0y7TTJW5isxFcobIZzGpYFKcHU6Le/pTBoPdU4bok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655737; c=relaxed/simple;
	bh=wWj//ZRkBbl8k60DprtNUbePyBaev0Or6IZeN9Y0ZaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZIvUr8Ft/KcqoEXfePbU/oC7L7pb5vXuAak7Moopg0u8DYRpf2OhKbqBQoZDHk5OSbaFcFKCk60ZcfZc0o8I5TWlVdbth4OPavhLW5DzI0hDW0AqSG1HWy44ILy3LRK2mpjP4agd7atnh2NzCNM2xMNl9ZoMxz3W6UGCfWhgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3QhY6pb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dddbe47ac1so16416315ad.1;
        Thu, 28 Mar 2024 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655735; x=1712260535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSb8eKkSmpgApznHJ4AQVQvwhW2C0OCmaJRtnqePdn0=;
        b=D3QhY6pbNoh936GluYPFBXQN+gzC+/IFa3A75000ODAywdMBJiQT+U42SxvtTuMDFb
         Uyc/xjuyo22P6jsAtp0ie356IfQXK4oGD6R7zJSodh5D9VC5R67ElIZJU9H731ZoK4VG
         91drqQ4dM73wssfGwr8oKI2K4HfjXb724LO+axkabUIDo7JjhjqSuj9K0HY5+CGnRWXN
         VnuzTzfKLSfizfF2Rq8Evq7YWiSRcUzaRHTP7j+ydrgmCOCn/pq585tJ+3UUuDfQxGmH
         t5mJfWVcvmX6EGreoQFxwL77RA43EVIunyZuURHt5vVWGOI3amCTVtf+ZzACv3ykypIC
         LN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655736; x=1712260536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSb8eKkSmpgApznHJ4AQVQvwhW2C0OCmaJRtnqePdn0=;
        b=NMNsHNwAiSfWSPrQGzGriecta0S7n5TjTjJIgUZD6c4VBgRDrlzLPVVOdyKPwpgMWG
         4AahqgOw+RNm5ht/5lekvoiAWazv9rTCiVq9qxo7N8hI4ch1oHLNLkQP7fzFWSuph1m3
         P0ZB2m/mKLBvGl82yqCqg/H/PO0J7n/2uHXaQfMyZehtVWvxsbtdPnnC4pB+7fNxP/Gg
         DUpLiZmvN86Nn1xuh1qQ51S4FyELzDV0lM1eywYtoeO0ql12Q3X9e2Vh8/bTsHoyKIsy
         5dU5SLoZmpBguGusQGdZVxJbXm6bDhMX/VcS4Z+uEAdGbG5gPLEIwUGgq4NriqkBCVqn
         LJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCUmYaXS3HbbHxuOnQ0hwWb1NaR0B20EYjD7hqV/rI0HWTRW3n0cVyviqgmrOAVMrEIWFhfYNsna5+Cf+p4CM/5SJAckxYVTyHadxTVr
X-Gm-Message-State: AOJu0Ywlnoiy4SEiFcLyiUMZtUdZkZNhPKRXEwfdjzw5lIPEczX3sshI
	6tBU2Gp8Ci7IoxJpXrtycu2xlBipnQ0Ns8Kh7e2weyBzu5Wq173VmRwbEdFI
X-Google-Smtp-Source: AGHT+IEYlLJemolUcBMlceKN++uY05ZJZtrov0oZFQWPSostxpmZPLoRzERpdQ0s6Sky87FcZRHvVg==
X-Received: by 2002:a17:903:1c7:b0:1e0:115c:e05a with SMTP id e7-20020a17090301c700b001e0115ce05amr5392991plh.12.1711655735653;
        Thu, 28 Mar 2024 12:55:35 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm2006520plf.282.2024.03.28.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:55:35 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 5/5] samples: rust: add in-place initialisation sample
Date: Thu, 28 Mar 2024 16:54:57 -0300
Message-Id: <20240328195457.225001-6-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195457.225001-1-wedsonaf@gmail.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

This is a modified version of rust_minimal that is initialised in-place
and has a mutex.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 samples/rust/Kconfig         | 11 +++++++++
 samples/rust/Makefile        |  1 +
 samples/rust/rust_inplace.rs | 44 ++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 samples/rust/rust_inplace.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..59f44a8b6958 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -20,6 +20,17 @@ config SAMPLE_RUST_MINIMAL
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_INPLACE
+	tristate "Minimal in-place"
+	help
+	  This option builds the Rust minimal module with in-place
+	  initialisation.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_inplace.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_PRINT
 	tristate "Printing macros"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..791fc18180e9 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
+obj-$(CONFIG_SAMPLE_RUST_INPLACE)		+= rust_inplace.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_inplace.rs b/samples/rust/rust_inplace.rs
new file mode 100644
index 000000000000..0410e97a689f
--- /dev/null
+++ b/samples/rust/rust_inplace.rs
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust minimal in-place sample.
+
+use kernel::prelude::*;
+use kernel::{new_mutex, sync::Mutex};
+
+module! {
+    type: RustInPlace,
+    name: "rust_inplace",
+    author: "Rust for Linux Contributors",
+    description: "Rust minimal in-place sample",
+    license: "GPL",
+}
+
+#[pin_data(PinnedDrop)]
+struct RustInPlace {
+    #[pin]
+    numbers: Mutex<Vec<i32>>,
+}
+
+impl kernel::InPlaceModule for RustInPlace {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pr_info!("Rust in-place minimal sample (init)\n");
+        pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
+        try_pin_init!(Self {
+            numbers <- {
+                let mut numbers = Vec::new();
+                numbers.push(72, GFP_KERNEL)?;
+                numbers.push(108, GFP_KERNEL)?;
+                numbers.push(200, GFP_KERNEL)?;
+                new_mutex!(numbers)
+            },
+        })
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for RustInPlace {
+    fn drop(self: Pin<&mut Self>) {
+        pr_info!("My numbers are {:?}\n", *self.numbers.lock());
+        pr_info!("Rust minimal inplace sample (exit)\n");
+    }
+}
-- 
2.34.1


