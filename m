Return-Path: <linux-kernel+bounces-16744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B8082433E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AD4287AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E28224EB;
	Thu,  4 Jan 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxI2G6N9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAA224C0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2cceb983e83so4826881fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704376998; x=1704981798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p861dZ7utlCXeaj84qH7PmRti7kEXa8Us6HgL7ej558=;
        b=nxI2G6N9GMXaZqnE0CjiX6QrlEsNVqj/QLOyZXvco/LHzBS2KlYTzguNUIW24H9oP+
         O9aQUdT1rBRe50d4kB1CUYmcunqVenY11lJ+5i8axqgnmu2mh5/yv3Ub4CctTqp5biu6
         ZSWBukcdzV7bU13BIx0vnmwbt6qwplkBM+24Z54sp+Ta0ptke/DBXrhBg+gmvNDfwXKQ
         VlUcRUd/qg6tc3qssIkavCx4i5hDaFZApFVYkRxAW0Qe3F/xa6+8C6XMgATDd3rVNVv3
         /mOoaZ7FWpIbVP4G2BmNUszH8S8bulZK4JgSefCxSE8GktrssAJVIozOGDnGhbESnSkC
         ir/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376998; x=1704981798;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p861dZ7utlCXeaj84qH7PmRti7kEXa8Us6HgL7ej558=;
        b=NcpSPBsK1KcCDkdZ1V35U1LGClUHJ2GqtrkU7QQdbx45+Shs1yAE2MwgF/knLwVVjk
         Fqbz7aZ7EYcALZWNPTtraGj8kH6/48uevxeKtCD7CX/XnugYcKRS4onmq3t1ck978bja
         MsVn5YIP5RjprIDUmQuwPJj9q3E+pSlUIoMH0wshiFD4yHBvtzAR2kLHs4iP7dO6MPkH
         4qntinQbek51zCRfsvUhvroDvPRGvH2JWssizySxtEiPvNjc8nPBPEXoGaFEOqTAOOR1
         Zcc8/ES8ZpfiyYSSBXUwPf6mWHg6ZK0YytPg5Zoal7emD/jCG/StEE8wniK+VQ4o3btC
         1v9Q==
X-Gm-Message-State: AOJu0YxyTt2lDzyrVrw1/gmxQV/aKp+WjSUnnQpKltyDJN5OYlOdPFXx
	+E/oQOFdMyHH64geB4ciN7UWRVazFBDtcFjE6C0kTg==
X-Google-Smtp-Source: AGHT+IGxlnvBOMxUPF+y9OEledCEbIFJEuaGbRydXD7phGxip0EcCSQ+qCeIByTE1T874+Ax2EkMsuBlQLjbJWM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:e82:b0:50e:25d6:6da2 with SMTP
 id bi2-20020a0565120e8200b0050e25d66da2mr1120lfb.9.1704376997745; Thu, 04 Jan
 2024 06:03:17 -0800 (PST)
Date: Thu, 04 Jan 2024 14:02:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIC6lmUC/3XNywrCMBCF4VcpWTuSS9OiK99DXOQybQM2kaREp
 fTdTQuCLrr8D8w3M0kYHSZyrmYSMbvkgi8hDhUxg/I9grOlCadcME4lRA0en2CCt1lFGHEagk3
 AW61O0nbS1oyU40fEzr02+HorPbg0hfje/mS2rl+y2SMzAwpCqNoo3XZWqUsfQn/HowkjWc3Mf xy27/DiaCqVbhg2Vuo/Z1mWD71LCNsFAQAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xK1tIDUbtTh2fQy+rQikL6Aqn9bpKhDlca60a/9ixak=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBllrqPqSGz8L6eVRGjauMzdCiCKS3QofPHhINll
 51yv4HFgfCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZa6jwAKCRAEWL7uWMY5
 RsASEACGYcRqyFLSfwSAwsQ/qGyqdLC2hFVEZIdLS1LmJCq+dm0D8GFrnGPkPpEiYUqf+PMshci
 tG21lSjgN0VT0bGRC4gwH+7hUVdNUo6dy6BO728HkjfGKgHi3eVUP5DHhW06PjDCQnD4SFVuPUv
 qIVH8bkxhFOmiq8deq9tP4cZ/BK4DPmvor5uZurgb+FhWlKPze4ERB3WNc3ZYgG8lQx88dTFJR1
 z7qGBnXrFW1NHGT6APLqJsdj+bFiJg/8xOqIWJbF6z/0UmM0bIqmO9QAQl9HnVEkIcr8kOfeWAo
 QHxmcoD1CzaItVmk9De6891JqBA/ftYTecMlmzPrrkT7d107w70FkfaEetFM3ULhrDuaLYLsSGp
 LWN74WmGkRNItIG/YfZ0/HoeWCXeOUDIsaG/ZjQtZj7TD9VmV6d7yO0MHygCK4s+ThjTGI4ol/k
 JicArEfZeo3SAQC5xG5FHUsELwdyqjp0ua+BnVg3krRRLfhMj91P2Tkmtw0WH84x8rGcYkX4KMb
 aBmGWRydQQO+n1ld8ZrkKblRB9yogBtH/ZReQltQnm+ferz44V6uv8G+DnOilknF7N0pUK4svie
 2rv9wbgUFx0VL6UaXMKQWphKEUATMnTd5GWxDjdOED2mQF2PpmlEyj6MEioVniaEp+kn8IolO4g VyhupFWSZeYotGQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
Subject: [PATCH v3 0/4] Additional CondVar methods needed by Rust Binder
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
Changes in v3:
- Update module description for new `time` module.
- Move constants to `rust/kernel/task.rs`.
- Fix incorrect doc-comment on `CondVar::notify`.
- Rename c_long argument to `timeout_in_jiffies`.
- Link to v2: https://lore.kernel.org/r/20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com

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
 rust/kernel/sync/condvar.rs     | 90 ++++++++++++++++++++++++++++++++---------
 rust/kernel/sync/lock.rs        |  4 +-
 rust/kernel/task.rs             | 11 +++++
 rust/kernel/time.rs             | 20 +++++++++
 6 files changed, 106 insertions(+), 21 deletions(-)
---
base-commit: 711cbfc717650532624ca9f56fbaf191bed56e67
change-id: 20231205-rb-new-condvar-methods-27ba95df5d41

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


