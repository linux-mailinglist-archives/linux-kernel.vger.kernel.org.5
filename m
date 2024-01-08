Return-Path: <linux-kernel+bounces-19718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E48271D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844A5283DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A94C3BB;
	Mon,  8 Jan 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npUwnaWH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E874779C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-db402e6f61dso2018074276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704725406; x=1705330206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnwJONZ3lqNGKjXAo9ka9hqMWO5IxVpynKJIV/pgiEE=;
        b=npUwnaWHdth44JfRUSJcmbfljZF4S2AeNXRi1PGjdxzN5m1OzFdhrASGJOi5uvTf8I
         R6b/I8uteGk/9dNYaqVYR8d7irj0riy0lEHrboDy8O7mb30aqFIDnRCDZbySmSZUsdc3
         Rqj+VzXI/bp7oKB/gsoONy5nS4FGvlHgrd5mkDJDS0sHwD4lq5GkpYV3b9Dzipo2SlDD
         aZqGqxbUn48+xLeUwC85fC1Brng8Q5f0msXGE1lP3sdZ80aX4+AOAxNEAJFnpglGa5Hc
         OK2cGXglh5qz243xInDz2YBeDuz3t6HNPb5hsDFGsFIjAPuPzyp8Cayg/rkK69Wydkt0
         yL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704725406; x=1705330206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnwJONZ3lqNGKjXAo9ka9hqMWO5IxVpynKJIV/pgiEE=;
        b=Eh9caIjVaAbvQ9dNJ/neOC5eHi+brYsGZv/RgZDvC4/BiTmPLZwsuD5qT6bQF5pP24
         8OlJm2QQZATBbX9P4p5chB3coQhM0Eqs7FeBJAU+aEAhcAnKESq5zsMeg/T/eJi5g8LZ
         hz9DF61YnOzqIPKb9bangpDqDhBXGy8ApjzM4cxisrZwqH+myi2E9D8CWi1yijO0yuh5
         B/njmF4NfdKnmE3oJJWv2Q8/ZEN1JBHkwALXgxhZhkHheZvFyAhmQL3fyab2+eJ8LIQH
         1vWptF5cXv354zDrQnbvujDL6s3l2qvmlq3uKRR2re3oyDnrNjwUx6mRFs+oBAU9HIc+
         XdjQ==
X-Gm-Message-State: AOJu0YyVH7KMp16NWsE2mLcr/dogsB/c6sLUx/U51b8nZj9uyzR5/Jkd
	4HZLAcCcWYWqihW5JqBeHPLefoiNJPr3SsDEceY1Aw==
X-Google-Smtp-Source: AGHT+IHmdP+w7bmx5EPMykFzlMsIrxFehhDztFE298PAMbn4SQjrtVVuX49AEZrgBveT4k9GTPZ7urGKfZDYpNQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:136d:b0:dbd:b756:983a with SMTP
 id bt13-20020a056902136d00b00dbdb756983amr1431440ybb.9.1704725406476; Mon, 08
 Jan 2024 06:50:06 -0800 (PST)
Date: Mon, 08 Jan 2024 14:49:57 +0000
In-Reply-To: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=V4luaNSyjxN/VywBe1xxHgUOl/JEebqcSaoMufGn4dg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlnAuWxfp8qMduMbMX2T2PGs8QR3xSAjwxXpgeG
 Dswbv5Jvq2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZwLlgAKCRAEWL7uWMY5
 Rp2qEACsiZji70Fyhw9whBLl/VPFPDVm+L+rmMqGgu3Ol3E8p/1zVOQPKcMarHJynTIkxIZ/BJz
 00x5mlOpb1UwU0miyhSRd7hvTGEV6vYMMpPxQmnt2ufAZHGec8IiSt+6T5UYIM4J+tJ7WVO4qlD
 /lkGVlBFrTu/HsXqslRm5yuPowIGMcT9Z4e79BqNQ138EVshyosAKB67z5Au+b3zdiHMB/eJu2y
 zWOWTnDqmqIW27Jomq+hI3WON7JltKkhEc9qnJacsSmXukGUlxrEnlv8xWfNMgB0JMRcFB4iRYP
 i9YwUTtPgHoJ5NcbHiK94AdUcmW8fmDAL1H6aotymo9E0/QHEo4kVPMNCZxwjVZdVgMVo+oBKuo
 FsYF+t/4HQfVZhxIu+FP+F2OPL/RRIRR8IsScNfY7EVId+5K92wS2bk/n2e0etBEvcq7Qrqa1l2
 QVhabtO9k+q1a9cbbZhoiy3b114SuXFe5CL6F+TWoKs6RE3oJIvNWJbBCmojtP5dlkxuhhLniWi
 +t5yvTS3o1OW8AHvWDGy+Wc2sABBPGMGCWw0Va/fYcYbG6vRke1xor8Dg4lcrJqtEcfj2ZfTupH
 bMq5O1WR21V4a6bCJ6QnQlBWjT7poRDxDAYwXNJbZ8ttEGRT+GvBEEjy83qmNERBam2nTqRYFVR 0D8lnfZ2ALcAPXQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240108-rb-new-condvar-methods-v4-1-88e0c871cc05@google.com>
Subject: [PATCH v4 1/4] rust: sync: add `CondVar::notify_sync`
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

Wake up another thread synchronously.

This method behaves like `notify_one`, except that it hints to the
scheduler that the current thread is about to go to sleep, so it should
schedule the target thread on the same CPU.

This is used by Rust Binder as a performance optimization. When sending
a transaction to a different process, we usually know which thread will
handle it, so we can schedule that thread for execution next on this
CPU for better cache locality.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Tiago Lam <tiagolam@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index f65e19d5a37c..b323a0c26513 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -155,6 +155,16 @@ fn notify(&self, count: i32, flags: u32) {
         };
     }
 
+    /// Calls the kernel function to notify one thread synchronously.
+    ///
+    /// This method behaves like `notify_one`, except that it hints to the scheduler that the
+    /// current thread is about to go to sleep, so it should schedule the target thread on the same
+    /// CPU.
+    pub fn notify_sync(&self) {
+        // SAFETY: `wait_list` points to valid memory.
+        unsafe { bindings::__wake_up_sync(self.wait_list.get(), bindings::TASK_NORMAL) };
+    }
+
     /// Wakes a single waiter up, if any.
     ///
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost

-- 
2.43.0.472.g3155946c3a-goog


