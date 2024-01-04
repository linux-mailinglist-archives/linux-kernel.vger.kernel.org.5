Return-Path: <linux-kernel+bounces-16745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A74B82433F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8F71F24F35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02831225CB;
	Thu,  4 Jan 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqnZVKpq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D4224E5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f53b4554b6so7868797b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704377001; x=1704981801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nl5Laek/JeiZg0YNg3sqHOoYp0ay3yEIwnurgk1eRc=;
        b=IqnZVKpqUiv4a36hQho72wHsmN/A2nmYPZrihEr74aZ4Ea7svlPWa0YdLzRIkBQnMx
         XJmWGcFJKttADMlRxkwN2aCmZdicoH3iSdn1AdLJKE7nhkoZt6BJtGeD0qsR2rUYr+TL
         ftQeJmMfqFZWSqzMkPXt6OAoJNJYoOmMUsGJDn+ahBO9629G9LKlgQ7zD1YeZbvNdQCI
         LgsA3D99PpbqaYy57cVxZ8IUOoDP6lDyAv9eg2lX4Hw5aULlMf0j0G3Sv8tQtFjP4DnZ
         3tB43mUBEFylsmTU11BFqdQLlwgq2puGQVEfdtOba/FaVaPld4jWHMi+0lf78otrHO9U
         Wsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377001; x=1704981801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nl5Laek/JeiZg0YNg3sqHOoYp0ay3yEIwnurgk1eRc=;
        b=bH1aSgdVQjZIKR5uE9SAh+jTpQNe96lX2uJqkTpW2WcHmIt1uZ6Ts/fZK14HacENeD
         LGfvAZWyJzi4Z9G5vzZX3NyOxhpuat6kaafELaMyoK/PtNWLM3uwIJPbvsCLGRV3Nikm
         F9Y9TpiIUKyoaxgjj6mjz6BSd9117vgQO50XFTVEOE3ubZZwyXoBb4vOvFxm/oX16LEP
         txysg8n3vb5VImlchkQ/5JVjtXoB7B4TXO5H5x7kWsFVV4gvvlUiFo+XwjSp4Bd5iJYV
         hjuxokf7Z12IuD52YB7Y/PshcywlpNbW70tvx1Y1JY4svSon93lXBo3pP6tuG02cLUwC
         mBQw==
X-Gm-Message-State: AOJu0YxaGBYPhDGlRfrSXFMMHKHLs7SDz3+NuXMGG42IfVBCe8v2Xxpn
	il+JseAo3TIHdcMC6725Q1mdoe3OhGDOoschE+c4mg==
X-Google-Smtp-Source: AGHT+IFCnEuWSYcZWrzrOXwmm/NSIujkJ0d97NZXEeul8y+RyFZTh/7iS2+ieRyAOMuskBkMJEe5L0fwKdlbUYk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:3505:b0:5e6:1070:44e0 with SMTP
 id fq5-20020a05690c350500b005e6107044e0mr232456ywb.5.1704377001008; Thu, 04
 Jan 2024 06:03:21 -0800 (PST)
Date: Thu, 04 Jan 2024 14:02:41 +0000
In-Reply-To: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=AT+BWoH+O+fDVD5OmEd/gQgAkotIyd1eZrCsi0lUVI8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBllrqgh7qNEkMwomO40RdnkMaEmWiZlj97O2VAw
 KuwHwb/tveJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZa6oAAKCRAEWL7uWMY5
 RgadD/9vwDNTS6iwH8e2XVzK5UYrNoHqg15+9X7+1OrMmdn3IlNLu0r7TIEzRcW4ZPfUtOkh92a
 XxI82/EtpEdPqm3h/OGdMjlEhaDn7vgmUyjQ9jqSQxqThOJGQ3VyIVP2PGO5m3F0dPYvYZPxmdq
 Vavfv4g208DOFcFXGLQCkwEDsxoeSzfysBO14wkzGvEgSkmqimDDN/b5mWvjUXJVcoZ+Qv9f5l9
 jDi8JY0ys/OKrLMnAEry0/HHd+J+S5RVAyaCO8Az5IaVZh1dnKR5JcHncg7Qb55JUOdyKWMvqkp
 GQqajBg8cHRkORAcqPttcZLmjEc6hXnVQc+AQ1eMAqd59FzIAQjKr3NpLYexyHlj2dSEzMv8U9G
 Ck5fYS+kRO7tx6QlefDOWkK4MyQvVmVrSijMg7KMItapUH/BsGsrkrSOkhnN35g+jR89ZScyKs+
 3WV2HsvOIkMJjwH8wFBSMH0X0OJxUQ5iBtGbM+W2Peu8vCR5W87U8sqt3L/g7akymLzuWxwt4kd
 1dg11wG6sOpWpj1N2TJkCOHSVICkhgfv0G/j8hY4s/rmF1GX3AfPbBuoKtZaUBLYYqCsCDf1TWJ
 jU7Q3Kt4Qiqktw6ES/Nkf6JqiZneVcYDKOONOmDAHzZfCv4r2j4WuQPy37dPFI9qC00BO9IF2z9 G33ogm6qgGBCSPA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240104-rb-new-condvar-methods-v3-1-70b514fcbe52@google.com>
Subject: [PATCH v3 1/4] rust: sync: add `CondVar::notify_sync`
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index f65e19d5a37c..1a3f7b8e03dc 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -155,6 +155,12 @@ fn notify(&self, count: i32, flags: u32) {
         };
     }
 
+    /// Calls the kernel function to notify one thread synchronously.
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


