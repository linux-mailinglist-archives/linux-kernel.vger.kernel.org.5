Return-Path: <linux-kernel+bounces-117862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6A88B095
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21C42E7889
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D24C618;
	Mon, 25 Mar 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQxYp07q"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AC18AF4;
	Mon, 25 Mar 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396493; cv=none; b=UfgcBYEC0sUmhtxAxQDa7CitBJn+7asK4sP3dAHywdSQIRLobpDjUrs5eoj3gEDVkQDTNwa1oX/AGUna/dny9jMOR9dcYcCiociUiJ3bEniK6TaRVtydBjbwWsXz9E/cfvhHu1Qs+qWO/K1LKB0ieTn857NuC+A87B9Iww640qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396493; c=relaxed/simple;
	bh=bfOTbnixtHhC5VsxDkz9OVrGjslHLL+7UZtqMBMeX48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEmm/K7V3nhFb4Pg/u3/om6NkD+J0lJaZsBh64M74v6Kqs4TnOQtIV9/FaqW/s135Gz1pXb6O5bPZDybqxWaXBjbQIbmFAFaq5CQWxgrlAes/l9CthaNepHcvAOdubZ4EDGjIeToFeNH+HSiK6PdGheyH9KR8PTc8AifL2ODwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQxYp07q; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2603863a12.2;
        Mon, 25 Mar 2024 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396492; x=1712001292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgHz15mlWM4+DZVymxJpfr8CXeyi7j4eOLGjc7/vyUQ=;
        b=NQxYp07qhXmEzX6CCJw/ZVm217Sbe2tpZ+fsdvEmIPVGwwQqC7ro2+lng2Dw7QCRI+
         fVD+9d+acoaLUoLJw0Wys+0iLYXO4wb6zuI7VJiTpYi94Td4KJaVRlHaGJXscBXVXhr2
         GGx3jeNedqCEn1NqwwnMwnlop8qW4UMRZ/NupQaHWkbHiXLqpmXH0SQEjczqFxF6pWuF
         bvJmAI6gZ7N1wgnwRcHhf6WCGI8ZBLTZ0XAl/0fWK8hJh5fJIlRYrYS3yTXQPULQUiHB
         16iZRfoDBZlFl9EKl8FlkC6zheQbm43/ZXqH7Dv22SZrR+/UCmpG8I9E+B1i6notWQz/
         mmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396492; x=1712001292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgHz15mlWM4+DZVymxJpfr8CXeyi7j4eOLGjc7/vyUQ=;
        b=rE3FNI+FQ/VP1luzwpwHQ69v0jtQHrGwai17MPOtmBQYK8FnnEKJDQiiVQ0FMbk6PB
         4J0fCGmylJJxuaxi5nj/VHShIEuySZNeMXhm8LWXjJ65vWqEOObGd0q53b1Nscm5z3WG
         T1bRT4Rc975LrbCgSuPfRH9bQRkFFmYBNXtNz8oA3VOHPZ0dd6C53rfWLu3qS1v0YzTc
         1xLZ7lXwzhYbbGLiZ8RauVs1YiaTirxKQC5kQg2OMiQ3f551uFoh+cnx/fGBPW95vktC
         wcqu054wUqI6BuIFa53KeaeuHYvUdNGstmzHtJMJso9TlLnmr1Wc2j/AFYkvEplq05uw
         xnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/LgoKMyVGuaZy1hsyrHYLnuyIZpvTrNPrWU0mySwjS2AW+7zSJZ3So7MZm+Lq2gXoQ3fcrHAyBc95ByXzBjFWnNQXOtWJh43j7S9W
X-Gm-Message-State: AOJu0YyOC+fPjtAFhOITXHIVWmtw3/WuFSaik5ND5lp23T/omNd6IX4P
	5QAZbk1YEpLigTVrpoOUgLRq4EmAHFSnxQ2fAwWeL56s1u2uN7+GdYGguDFa
X-Google-Smtp-Source: AGHT+IH8BSyg8iQt6AGq7Uogcgb+M/afYig6pC0k9bSYjPjQmWe4t8xC7BAGP0uPGy3hG6pvcNkZJA==
X-Received: by 2002:a17:902:daca:b0:1e0:d9da:b126 with SMTP id q10-20020a170902daca00b001e0d9dab126mr1490031plx.15.1711396491576;
        Mon, 25 Mar 2024 12:54:51 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:54:51 -0700 (PDT)
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
Subject: [PATCH 01/10] rust: kernel: move `allocator` module under `alloc`
Date: Mon, 25 Mar 2024 16:54:09 -0300
Message-Id: <20240325195418.166013-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325195418.166013-1-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

We will add more to the `alloc` module in subsequent patches (e.g.,
allocation flags and extension traits).

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs                 | 7 +++++++
 rust/kernel/{ => alloc}/allocator.rs | 0
 rust/kernel/lib.rs                   | 4 +---
 3 files changed, 8 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/alloc.rs
 rename rust/kernel/{ => alloc}/allocator.rs (100%)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
new file mode 100644
index 000000000000..ccd4149932c3
--- /dev/null
+++ b/rust/kernel/alloc.rs
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Allocation support.
+
+#[cfg(not(test))]
+#[cfg(not(testlib))]
+mod allocator;
diff --git a/rust/kernel/allocator.rs b/rust/kernel/alloc/allocator.rs
similarity index 100%
rename from rust/kernel/allocator.rs
rename to rust/kernel/alloc/allocator.rs
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index be68d5e567b1..51f30e55bd00 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -28,9 +28,7 @@
 // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
 extern crate self as kernel;
 
-#[cfg(not(test))]
-#[cfg(not(testlib))]
-mod allocator;
+pub mod alloc;
 mod build_assert;
 pub mod error;
 pub mod init;
-- 
2.34.1


