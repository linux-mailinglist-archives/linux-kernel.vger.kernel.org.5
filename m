Return-Path: <linux-kernel+bounces-37795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD67983B577
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638781F232BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BDA13665B;
	Wed, 24 Jan 2024 23:13:41 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0CA135A40;
	Wed, 24 Jan 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138021; cv=none; b=oKvs2Tdhs1IEFVUKPyLJurhO7pqfz6ZI22PTN7u+hJu/Qok+tDFVdbWfwC6ln8fNP6OytFWRlK95AeiLTWPXAxHWaNLhdqAEB1fo20musEm1KE2t+GQw8gL5DnzntAYljJJq04qN4KzC1aVsm3NFyzJgt/YAo9z34psfeFNLBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138021; c=relaxed/simple;
	bh=EnAoG8PAQVNwEJgEMwMzFzSmFR/EUEE2tzGftMfXfrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXQQY1MJabe7UlFxW2vR0CJXeeI/k58Bw5Uo/t7Rn6lr1Q7/Dyd8Et4ujuu3HjiHNcusJEI1ShmrfOCB2kqCrksK8BKkg+iyhi5BPUcXMf6WpPiNAUoDP7IeZ2xR7UCBOv0DiMU8DIXqrts5qTjIt9DoM1dV/X5S21ET1EZfnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.249.70.154]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLi4W-1rkRnr1ROC-00Hfn9; Thu, 25 Jan 2024 00:13:03 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: aliceryhl@google.com
Cc: a.hindborg@samsung.com,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	arnd@arndb.de,
	arve@android.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	cmllamas@google.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joel@joelfernandes.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maco@android.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	surenb@google.com,
	tkjos@android.com,
	viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 1/3] rust: add userspace pointers
Date: Thu, 25 Jan 2024 00:12:35 +0100
Message-ID: <20240124231235.6183-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124-alice-mm-v1-1-d1abcec83c44@google.com>
References: <20240124-alice-mm-v1-1-d1abcec83c44@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/D0DIugkvM4W5K4pXdij6pnL4nCM/dMBAW6u0lFvqJIlZFWq8/Z
 +VAka/LYfL7oQ0ah5ro1H7CWmHT2JIrPBlg27r70PI2Cslt5bLl+1fF86b0Emh9r8ixIpsR
 9uxZ+xZZjzMkvNdFX9lQ8/nj+MG+rKTZXQsTTQgBcPLqKTNUgVjVdq9tm3ETJ7H/VTWp0k/
 wxck4tDToQnTmsH2xKm0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f29DWwXpfyE=;I1MCVoVH7iehyuAN6gh7kinA6E6
 zjgAy4XiAQLA6OLLraBfnkxJnnybDI9hU5PYprLRiQEt5kCLLKKfmafd6vmx9o4cuSPrERkjI
 IuB1J7gngdEebE+a9fQnbxCC/k3EeIs84qM9lfUCG52x4Vw1fRRrFH+Ys8QdopqxVz8wx0Kmx
 IzfO4vWPyL2cVWdabWJ+CuGDQZWQewpBmXuzPhFQFODC9nZNRt06i538Yz7TperCIXt1BrVPb
 QpCgpOMSBlZDwSAeDfIwRKuvDEt1P6cpu3EkGFvoIZaP71pYg0iB4mpJMDZ3f4qIrE84FdwLN
 BQ+tx6XAomHSQ+zy91x0lxW40h7BpPnZ6E9VwcrYg3/igunWFeVT7LXvpfOgLG7LwZAksCcgQ
 s7Mlx+TUdsUjuKqnIIh8CJ7ZM/p5zqDTF0YVG+dAPIYLwt+ovbLoleWUG55p8lSytJ4FYO1gp
 /BfIIMfpWgSLhHyKXo0WxtM8dEYE8bFTROgfTT0dYjcYoFNkxQyoiMw7ADGyQm0h0qZZ6gPN9
 sKBpHWTJjmSpibHSCUJVe5DpBFwBZEr92BnPjBEjjrse+ih+pXe4QGVYOB4yJ6h7MZNMj9I+p
 TrIjVTUnowSIniRPpr1E1I8avxUFbz+Pvk9/ItrFLivsBhvKvOUf/6g0qd/wGw3xHkZa23OVN
 fS97fzgJV9h9vYN9u+DP/jSm6uuhwkFZITe3lb6w0PVJFIZKKExDVDfBJSvjLbCUZbyh0o2CZ
 itM44KLUls6x5F1x6g5mkRS1x8L+5rP5hNvupATjJQBIEotaHDbCuSUclxXkwSvbE+OMUEPqs
 oNc+kYtCCqt8DwrStyDfKaoG/GjkC1gOXJbSD3P21LtRvDz1fys6Kk+KmShoGYjlE+RR4w6XF
 KxOFDSgJ2E8C8NWOQRKmoctRsER+QV/HNZNg=

> +//! User pointers.
> +//!
> +//! C header: [`include/linux/uaccess.h`](../../../../include/linux/uaccess.h)
> +

nit: could this be using srctree-relative links?

> +/// The maximum length of a operation using `copy_[from|to]_user`.

nit: 'a' -> 'an'

> +///
> +/// If a usize is not greater than this constant, then casting it to `c_ulong`
> +/// is guaranteed to be lossless.

nit: could this be `usize` or [`usize`]. Maybe would also be clearer to
say "... a value of type [`usize`] is smaller than ..."

> +///
> +/// These APIs are designed to make it difficult to accidentally write TOCTOU
> +/// bugs. Every time you read from a memory location, the pointer is advanced by

Maybe makes sense to also introduce the abbreviation TOCTOU in the type
documentation when it is first used.

> +    /// Reads the entirety of the user slice.
> +    ///
> +    /// Returns `EFAULT` if the address does not currently point to
> +    /// mapped, readable memory.
> +    pub fn read_all(self) -> Result<Vec<u8>> {
> +        self.reader().read_all()
> +    }

If I understand it correctly, the function will return `EFAULT` if _any_
address in the interval `[self.0, self.0 + self.1)` does not point to
mapped, readable memory. Maybe the docs could be more explicit.

> +        // Since this is not a pointer to a valid object in our program,
> +        // we cannot use `add`, which has C-style rules for defined
> +        // behavior.
> +        self.0 = self.0.wrapping_add(len);

If I understand it correctly, you are using 'valid object' to refer to
an 'allocated object' [1] as this is what the `add` method's docs
refer to [2]. In that case it might be better to use the latter term as
it has a defined meaning. Also see [3] and [4] which are about making it
more precise.

[1]: https://doc.rust-lang.org/core/ptr/index.html#allocated-object
[2]: https://doc.rust-lang.org/core/primitive.pointer.html#method.add
[3]: https://github.com/rust-lang/rust/pull/116675
[4]: https://github.com/rust-lang/unsafe-code-guidelines/issues/465

