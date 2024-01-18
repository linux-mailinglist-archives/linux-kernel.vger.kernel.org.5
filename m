Return-Path: <linux-kernel+bounces-29907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 145128314FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97847B27099
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DDF1B97E;
	Thu, 18 Jan 2024 08:41:59 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512313FEF;
	Thu, 18 Jan 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567319; cv=none; b=trdmi4uqRwYfK5Xsi7sQgPCIw+bV70UUvCKE/5HiryQpTVo1vbo+4A8EBzDmMFsoUG2Jv3W+3/KNGnSUkV/X/45dxX4lDfPJE/AdnNNXMQBonrHPiSRpyepFsU/72lQoSZt3N511HOjYIz4Sj6knstzBgFmPuod1kteG/OBtpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567319; c=relaxed/simple;
	bh=l1PjlL5e4MQAE4/Y2FMckoWQVMDVNwecD1FWAP5XIpU=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=rVWBulzEn0wVZlQgbG+teftF/jWX5agn7WypyCeiEog9uCIuE7KlJBS6RSMzUaA1TPdo9bkDnyTYENoIsdBK8dtVKKehAT0mpVUmSgqgPGB74nf7s7lYFPXZo/SLhJTcSGFFdpFF59SUxUerZ0zgNv8M2bByOXLrHG5WsTB3G+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MX0TX-1rbaFI2baz-00XMOM; Thu, 18 Jan 2024 09:41:25 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 10/13] rust: kernel: add doclinks
Date: Thu, 18 Jan 2024 09:41:09 +0100
Message-ID: <20240118084109.21400-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALNs47tWivxJhqjC-L8rLQKP420y1zCgCiHSZc5JPNbCVpwxgw@mail.gmail.com>
References: <CALNs47tWivxJhqjC-L8rLQKP420y1zCgCiHSZc5JPNbCVpwxgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QKWd6qtDxzAW4k18sUWFEXUEXuCo871OBeHjQxznK7aUdZnrHsi
 +J7LI4Bm9oMgXtYYrcygyrdqHY2WbdLh0iZMy8ryx1hLMtJG8A9dAEo7R5ZRz/wLjLaYjNx
 0EM6FzrJJpNccUVGCp35eEWFMOymGgCBf2cF+q++cKIo28xUcCe3IecoEmawIJUiZmgFo7v
 Rcwq19CMc5TnRpdSebLUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zI/P7vMDheI=;V8EodjK8E1xpKZ4NeALmkkDV3Cj
 HMbEqmAg5rWmV0xplS1ZzLbH9Bh5sL4MfA7QgoU/4zdzMUWBuy0xzVCyy2BihWyALvN7fQ87r
 KTuLYLDkEMl+O8HvawbougSD/UeDVgW4HVC3lk4bjXuFFzUd6NPQwEgUuSJD0cYvmnjpMpfQg
 URNtaHxbL/4ZejI6HkX4WbgHtgxrkey66VFGNvH2j+pH+vRbkwT3HDs0jFhziHRRApUI78PXe
 Sx0SFMbrXp8iqeQzBWz6gMW/TkHREvgYkdFS4KaLA60O1D44gHOnzJuqrRFAkHPvX73uQ/r27
 hXOHl4+6Asnvm03eXt3zUBsu2b+y3HPse790BqruhkzkblystWlicpr4Px6pHSQgm8c6wd9ti
 fnh6MxKA/Mb/NFSqIE4ord5RuqM/ONTNUfKSFSD58wPzWqkGm65LPAzC/LcbQQeCtOATvNfiQ
 my08RBahN7+cOwQq6lgTzHDCa7TWp18+rW7XBqP4fMj0pY0fs0RTf5Wn9P7KvaO7V8I+iTZ3x
 aQixfAinckUalF9Kdr6cyT+p/Ef/jAaJWTpB8MmCSJx9nxMOaW/Kt7oB3ZnDlHwzHtB/5mk8S
 F0FVSLlZ1/Wo/IzSV5a39C+nMW7uskj8tCmGOjNCLH1pJVP39yK4mgWtfqj8WvSUDbXqEXyk8
 Xur1FcR9rDptvKsrGUgsor3ehxNOcMmI5OIZOdXx7dyKCUfhzeNd1sBynVn52cxfwQdq5kb/Q
 FBBaj3YNW8pr8kvJTOVvrR7BlisBsuZst3IyssHaAqh0aoZZrtnGK7r+Cucx/V4lifLidomS1
 S2Ld/eVzQogQCzUla8Vm9OCDSxTtrFItAmaD53WSf50a2xyl/f9tegENmyVnaIy/gRDkC0gxj
 UgqrrvMszeg3AtA==

> >  /// # Invariants
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index 467249b39f71..f14179d19d4e 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -21,14 +21,21 @@
> >  /// # Safety
> >  ///
> >  /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
> > -/// is owned, that is, between calls to `lock` and `unlock`.
> > -/// - Implementers must also ensure that `relock` uses the same locking method as the original
> > +/// is owned, that is, between calls to [`lock`] and [`unlock`].
> > +/// - Implementers must also ensure that [`relock`] uses the same locking method as the original
> >  /// lock operation.

> The second lines of these list items should probably be indented
> (doesn't have to be in this patch).

Indeed. Will include it in the first commit in v2.

> > [...]
> > @@ -290,10 +294,11 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> >
> >  /// Defines the method that should be called directly when a work item is executed.
> >  ///
> > -/// This trait is implemented by `Pin<Box<T>>` and `Arc<T>`, and is mainly intended to be
> > +/// This trait is implemented by `Pin<Box<T>>` and [`Arc<T>`], and is mainly intended to be

> `Pin` could be linked too.

This requires the 'code' tags in the next commit and is done by linking
both `Pin` and `Box<T>`:

```rust
/// This trait is implemented by <code>[Pin]<[`Box<T>`]></code> and [`Arc<T>`], and is mainly
```

