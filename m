Return-Path: <linux-kernel+bounces-91413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6587112F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A279E1F22A1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6097D09C;
	Mon,  4 Mar 2024 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="mScccQtL"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59671E4A2;
	Mon,  4 Mar 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595552; cv=none; b=L1UeDemOg3KiwZndJluHIcbedUvd3rwj/34auNInOqS3VAFhz/Pi57WfM/lpd+1Ik1dpF0oiw1jJJPEO9j4cq/zZ7P/qsAZqWOhh/irCAhaZFUFpsxCrIFIys/4hmyTzsfE5jVfVyjFR/Bj+SwNq94n+BgliwZdRfwX8El/eZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595552; c=relaxed/simple;
	bh=3o8JX74qCDA51a+Kvn176uBKDeXH9cfTcdIi9xS8xcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSL7Gdyg+IGleQ7nklXQcYoruOJyYA1ukHChUBUscpeOOuqSV5SmolDpFohK3QHRnXvn/n9MXxet4COh8CagV+HulceD7tskb2aGXoRQuL55llswIL/z+6ClvloeKzrzHrkhF8feSZ9leZoJ8wcY2DtEFrkRYCICB/yUiYxBPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=mScccQtL; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1709595532; x=1710200332; i=kernel@valentinobst.de;
	bh=3o8JX74qCDA51a+Kvn176uBKDeXH9cfTcdIi9xS8xcI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=mScccQtLTZ9FCbxylw1z3xNApffFNwC9ll2WraVeAVa6ORHSVJSBuYfszM4WqvtV
	 7fa6zrIzfnrHjKGW1ktuO+aLbzpBPOS+nRb+1Pwdd01L/h1XK+icpMTubctvBkVkZ
	 KjsNSTGGt2e/lWoDRrb8oKWD91YPp6YCmPppbQasHdgtSx1k3bPLfmhpyVwpz4rAJ
	 g1LQc3MtHS0t9o37xuMvjriVINGLpQB71xnVvkvW2r9R8vRMIfx64OdQ9fvP25PYt
	 vdyaz+ark3TOM4lDNQVRakK/WBCWky4mNDkU7//EzK7ulzEqIx8TgjoqZcbYDGE4l
	 K6E3BBvDA4H7yLLWPQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.fritz.box ([217.249.70.154]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1qbm-1rjTeb3vTs-002H3B; Tue, 05 Mar 2024 00:32:42 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: samitolvanen@google.com,
	aliceryhl@google.com
Cc: Jamie.Cunliffe@arm.com,
	a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	ardb@kernel.org,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	gary@garyguo.net,
	keescook@chromium.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	wedsonaf@gmail.com,
	will@kernel.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH] rust: add flags for shadow call stack sanitizer
Date: Tue,  5 Mar 2024 00:31:51 +0100
Message-ID: <20240304233151.248925-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CABCJKuem3GbLO-G7+wi8LPA8rFgNzFVjNof7zcAO1UGJR4u44Q@mail.gmail.com>
References: <CABCJKuem3GbLO-G7+wi8LPA8rFgNzFVjNof7zcAO1UGJR4u44Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:lMesWN2+nwzOhaR31bjDdybINENheJaYKFD+YnF4H8qbr/dYcfe
 4E5r+D1MYjQIOG0M1tU6jnlVWDDSKLBC+LmzTyesRy/eCaXXasg2FX26NrNerjZ/9qwlYgx
 1LNS1pDly8BPzVNfcznBzg1OzrPSEJgaa4LUCYmO7dS4MIU2oskeBFbGCpLDN3pyc/SJK6D
 ynFGCBVQgbOf+cybyHFgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ru6A4YDERCw=;+bZWKXS1YRbH7TB3hkKFx2wddro
 Yp7mUqdCPFrvVq360nLeRonyxaMf/ejvKrPM8HAfGJOGqu+Hbp/whpdY2qVYRx9lBqJhZnE1E
 6w0fSZOBM2RogHQChGIB71pB8yczl+BvZIrruW4Zzww7FUK5JKuk5GHwnCNWb+eq8KJEQ8JEE
 xFkuS3d04MhlorRAYlqANMX8ooWytWe3nOoVywEv5apGNyZHTCWaUgnsW4pDJoS6x6EO1CwhH
 jlpbSIR9al35VmO7hmU/NdT2EJQkqSpqQqXkRtTcNqpNl5HX/ux07bRvsgfLLD9ej6io+jzth
 EGBCL+bFYryPrZjql/I6y22bZR14tDzEVESGyKOFBWip3nr+MRjygEQeOuoouGa6Wzo8lFsDs
 CH8++7MSr8mITtBfrWdI8JzPTztIdikxX7caBu1rqAAzRQ70slZ/Xps/MZhv8kgr3fR8P9wHe
 V3heKZh6KFBPFmg4uMAWLcKmc7y6jEoup9IifXpPYaaQ2PK6l6/mUjWUSoSsziP6Vhcs+4cph
 HW3gWwUxUXL31CjgJxfftk8Lr7XYnmghHGbbDtkHUj392N5OssVNZ7tXNAyiwQs7GgIY1KcWw
 VF7YeeBtwLmB+Uy4mXGBaW0e8eOoe9dtwsnX2+snl2xP1S7jG1/yZbDZ5IqRVjWtMFtm1+elO
 3DnzZEZqDfLLEuKxJkncsOA8xKwHILPnJ8jj64jZVhDlT8sSIP8UgaalgdskJEDDGTE6VLmB2
 xyzVHsefUn3LQet3Mm9twRsRZ+Fm5hJNDFJStEPwx6nDFx5cFRJHfA=

> >
> > Add flags to support the shadow call stack sanitizer, both in the
> > dynamic and non-dynamic modes.
> >
> > Right now, the compiler will emit the warning "unknown feature specified
> > for `-Ctarget-feature`: `reserve-x18`". However, the compiler still
> > passes it to the codegen backend, so the flag will work just fine. Once
> > rustc starts recognizing the flag (or provides another way to enable the
> > feature), it will stop emitting this warning. See [1] for the relevant
> > issue.
> >
> > Currently, the compiler thinks that the aarch64-unknown-none target
> > doesn't support -Zsanitizer=shadow-call-stack, so the build will fail if
> > you enable shadow call stack in non-dynamic mode. However, I still think
> > it is reasonable to add the flag now, as it will at least fail the build
> > when using an invalid configuration, until the Rust compiler is fixed to
> > list -Zsanitizer=shadow-call-stack as supported for the target. See [2]
> > for the feature request to add this.
> >
> > I have tested this change with Rust Binder on an Android device using
> > CONFIG_DYNAMIC_SCS. Without the -Ctarget-feature=+reserve-x18 flag, the
> > phone crashes immediately on boot, and with the flag, the phone appears
> > to work normally.
> >
> > Link: https://github.com/rust-lang/rust/issues/121970 [1]
> > Link: https://github.com/rust-lang/rust/issues/121972 [2]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > It's not 100% clear to me whether this patch is enough for full SCS
> > support in Rust. If there is some issue where this makes things compile
> > and work without actually applying SCS to the Rust code, please let me
> > know. Is there some way to verify that it is actually working?
>
> Perhaps you could write a Rust version of the CFI_BACKWARD test in LKDTM?
>
> Alternatively, the simplest way to verify this is to look at the
> disassembly and verify that shadow stack instructions are emitted to
> Rust functions too. In case of dynamic SCS, you might need to dump
> function memory in a debugger to verify that PAC instructions were
> patched correctly. If they're not, the code will just quietly continue
> working without using shadow stacks.

Was just in the process of doing that:

- `paciasp`/`autiasp` pairs are emitted for functions in Rust modules.
- Rust modules have no `.init.eh_frame` section, which implies that
  `module_finalize` is _not_ rewriting the pac insns when SCS is dynamic.
  - Confirmed that behavior in the debugger (C modules and the C part of the
    kernel are correctly rewritten, Rust modules execute with
    `paciasp`/`autiasp` still in place).
- Kernel boots just fine with Rust kunit tests, tested with and without dynamic
  SCS, i.e., on a CPU that supports PAC/BTI and one that does not.
- Rust sample modules load and unload without problems as well.
- `x18` is indeed not used in the codegen.

I guess we might be able to get this working when we tweak the build system
to emit the missing section for Rust modules.

    - Best Valentin

>
> > This patch raises the question of whether we should change the Rust
> > aarch64 support to use a custom target.json specification. If we do
> > that, then we can fix both the warning for dynamic SCS and the
> > build-failure for non-dynamic SCS without waiting for a new version of
> > rustc with the mentioned issues fixed.
>
> Sure, having a custom target description for the kernel might be
> useful for other purposes too. In the meantime:
>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
>
> Sami
>
>

