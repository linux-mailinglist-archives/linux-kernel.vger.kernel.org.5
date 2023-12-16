Return-Path: <linux-kernel+bounces-2229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB108159F8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8306D1F23C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071E2F866;
	Sat, 16 Dec 2023 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RC4tbQ/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9D14A85
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbce9c6cd26so1542079276.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702740709; x=1703345509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cShlorMw8kWqKOf3zj1Y7K2yyj9kYaaJBBygnuYbW/A=;
        b=4RC4tbQ/sH9AGS9rXXs0+JLcBAbeQNthB68PJP8tXR7P7a1M3K37kR7SwUE2xQ0y6n
         x/aMQU1c5A4FynHzx3sp3j6sMaDO1OCaRTy4fWKGAu1zORsjkTNuIPbXT7SluGXgNE2h
         tip5ub6zBhTvAuyMS2g/AmfqSGRl9ZYisYRiSTIv9F8j2CtZWp6OJuBsLlXSj7zfycpQ
         i3KIOADuS6PBkWPj9RcB8BzQhylHKCdKKAZgWSoyjn1ffHojaPYpadp3JqfL2jmJqbnu
         Y1hkjFRrw4dCTPV+dmXeF2zeRXD2xWDN8dGY0fWhkcNNR4MExBjBGvlaO6BP+3bd+NBu
         WoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702740709; x=1703345509;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cShlorMw8kWqKOf3zj1Y7K2yyj9kYaaJBBygnuYbW/A=;
        b=mnbhHL2x/wHhb/iGhLFyqiIa22+y/xH1BsfKh6dzC9Ts900xq0lE0JLpBbyrxVdAkE
         oQIGX7VNHY5FKnPkpLkBg5u3FYKclbgJP71ZlYxaw+OauShoKmIq9wBSyEfi1H9xKzVV
         15FWX29DDhhsOL4cFMoHLjqNDe8YLAjDKX69XoEC+qsOenX6504qaHcodDbPEo1xElqy
         9brG18ZFHY1DCRtyVheoh2SxzaI1mJXWISotHq/krfaMcYmbShc0y6J9S4I7FjlMr5od
         3qJrSi+FHEVS4Dh9JiSYh8IriCsGl9HMrJegQuDKQt6CC7awqEYix1hWhJPnh61WiPQO
         xnlg==
X-Gm-Message-State: AOJu0YzaC1cCNNFqzT6Bhgf8tAY1rQ7+81LEV9Gbqclh3YyoMpYM5mTW
	Em5JEgDKKimmUSSappTSzXGOgpemx9JvtGI=
X-Google-Smtp-Source: AGHT+IEPOKAO2SCoPiLlIvEV2jbrdgVIUULnGyWnw2rW2jtaGD22VUk7aw7p6ScIw805MZhYN1NdZ0Sl0pF6T/Q=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:343:b0:db5:f536:17d4 with SMTP
 id e3-20020a056902034300b00db5f53617d4mr518542ybs.11.1702740708918; Sat, 16
 Dec 2023 07:31:48 -0800 (PST)
Date: Sat, 16 Dec 2023 15:31:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANvCfWUC/3WNQQ6CMBBFr0Jm7RhaQKIr72FYDO0ATaRjWlI1h
 LtbSVy6fC/5768QOTiOcClWCJxcdOIz6EMBZiI/MjqbGXSpK6XLBkOPnp9oxNtEAWdeJrERddv
 TubFDY2sFefwIPLjXHr51mScXFwnv/Sepr/0lT/+SSWGJVUW1ob4dLNF1FBnvfDQyQ7dt2wfB8 NhjvQAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HTy45/347Drn5hP7O0VpJSWU02XY86CTstQyaTmhs/4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlfcLe4OYhYNujNTzHwytf3JEYFtuVZVifc1MqW
 +jE3mGb3G+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZX3C3gAKCRAEWL7uWMY5
 RsdrD/98nB+Ly5U5uqjm5uXJOoSTNSBTCo4utRByUziEzuaeddFruRLfbergNLbE40DnUiPSsfh
 EBULuY4l+QqsXHV0S9zySvbsmZs0pUhseR6mO3GDatg9FXsAw+8HzY5arXNGe2jMad+0YKe1GpQ
 AgzG8cPyiHHRMc0/kPm+aQxjH6L40oaHWAz64AZaxb905D5gIEh8p/NImyCeBRJpwA4Wj+av5au
 YR2GYIWdIx6QZlTCiRsXp+SoGKrUsXeBUpH5UqnLso1CU0ooiJx6zGRkwuXxQPiM+iDs4/loc1t
 FgFYSmu9nru9ai9CIKS4+ZbxX4FakYgv/SWiExVVZ/nT4aNgB7viK6daw/UzzEJSqMmSGEdCwE6
 xha8NfwKS7NMuWL4zTm8dyTWrWSvAxiGpJY882xD7d0MSA6r1ZpHAdSeBfAoAow/H/tLRslZbdY
 Kb8EVy/RBvNeh8QOzq53XE5Zpn2uJRIcNB9WQa+B+mLzqeFwOpdlFs4wdjjOxDvfpts++z+E4mo
 pL3nTDhupJ0BWvQn/uZ0tdUAB2K0lOd7WGEL8OM0XOEBGqEYAgKXiv3SrK32Zn2VtEHaANv3X/M
 V7UaYCSr+dh6DKynY86u5hiIxsOf3XwlqnToyRsxy0GGcGHgI5VOtwLcMpexegmK7ooCKs3DDef nDWnGbxMZMc5acQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
Subject: [PATCH v2 0/4] Additional CondVar methods needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains some CondVar methods that Rust Binder needs.

The CondVar type implements a condition variable, and tries to mirror
the API of the CondVar type provided by the Rust standard library [2].
It is implemented using a `wait_queue_head`.

Please see the Rust Binder RFC for usage examples [1].

Users of rust: sync: add `CondVar::notify_sync`:
	[PATCH RFC 04/20] rust_binder: add work lists
	[PATCH RFC 07/20] rust_binder: add epoll support
	[PATCH RFC 08/20] rust_binder: add non-oneway transactions

Users of rust: time: add msecs to jiffies conversion:
	[PATCH v2 3/3] rust: sync: add `CondVar::wait_timeout`
	[PATCH RFC 15/20] rust_binder: add process freezing

Users of rust: sync: add `CondVar::wait_timeout`:
	[PATCH RFC 15/20] rust_binder: add process freezing

This patchset is based on top of Boqun's patch [3] that renames the
existing wait methods to follow the C convention of using the
_interruptable suffix.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://doc.rust-lang.org/stable/std/sync/struct.Condvar.html [2]
Link: https://lore.kernel.org/all/20231214200421.690629-1-boqun.feng@gmail.com/ [3]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Introduce "rust: time: add msecs to jiffies conversion" patch.
- Introduce "rust: sync: update integer types in CondVar" patch.
- Merge wait_internal and wait_internal_timeout.
- Use new Jiffies type alias instead of u64.
- Update names to use _interruptable suffix (and base patchset on top of [3]).
- Link to v1: https://lore.kernel.org/r/20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com

---
Alice Ryhl (4):
      rust: sync: add `CondVar::notify_sync`
      rust: time: add msecs to jiffies conversion
      rust: sync: add `CondVar::wait_timeout`
      rust: sync: update integer types in CondVar

 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/sync/condvar.rs     | 86 ++++++++++++++++++++++++++++++++---------
 rust/kernel/sync/lock.rs        |  4 +-
 rust/kernel/time.rs             | 17 ++++++++
 5 files changed, 89 insertions(+), 20 deletions(-)
---
base-commit: 2a76b6e08193d2997689011321bcf230f0c8d4fe
change-id: 20231205-rb-new-condvar-methods-27ba95df5d41

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


