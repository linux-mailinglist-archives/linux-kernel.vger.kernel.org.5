Return-Path: <linux-kernel+bounces-1227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A95E814C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CD8284184
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C2381D5;
	Fri, 15 Dec 2023 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ksG1Sl4s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC2374EA;
	Fri, 15 Dec 2023 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 97B042ED;
	Fri, 15 Dec 2023 15:47:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 97B042ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702655222; bh=0nKLy+C+Dxd4dV6a82Y8vBIP/FvDDIhCHJp2NX784xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ksG1Sl4s68T1Y3oIgMpq9BKv5Fqi0jdFmzW6JnmG1yCeZR9DjTwhrjVHAOrHwNdiZ
	 jnPOTDQjMy7S1btfqExKjdmasQMH5jn3DftAsLvsXbDgl8EzL+ZG7BDhxm7YCaySnh
	 wlVFbL0bB670lSovu168Z3zhBCjz7yZemI/BPSKTt3zPb/UZNITzLPqq8ZI0ehGU6z
	 msqMf4ucw+4sZgcs8Glz9jx/KuBXHVQjRtXj1CpX/z8/Imz2k3tYpJbgnXlc+FfHbn
	 uJVUSB2I3W8SbZEmqaahskV61lLjYhiDSnnnVFbqE5DiVpsKPfM7nBeIpPAu3VS0Ro
	 yh1ttZgyHuMTg==
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <bilbao@vt.edu>, Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg
 <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Carlos Bilbao <bilbao@vt.edu>
Subject: Re: [PATCH 0/1] docs: Include simplified link titles in main page's
 index
In-Reply-To: <20231211005442.95457-1-bilbao@vt.edu>
References: <20231211005442.95457-1-bilbao@vt.edu>
Date: Fri, 15 Dec 2023 08:47:01 -0700
Message-ID: <87o7erqxhm.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Bilbao <bilbao@vt.edu> writes:

> The general consensus is that the documentation's website main entry point
> and its sidebar leave room for improvement.
>
> Something we can easily fix is that there's too much duplicated text.
>
> To that point, consider the titles "The Linux kernel user's and
> administrator's guide" and "The Linux kernel user-space API guide." We get
> it, it's the Linux kernel. It's assumed that everything listed pertains to
> the Linux kernel, given the overarching title, "The Linux Kernel
> documentation." Constant repetition of "Linux" and "kernel" (45 times
> each), "documentation" (21 times), and "guide" (18 times) are excessive and
> affect UX.
>
> I propose simplifying without altering actual document titles, the text
> linking to these documents on the main page ("link titles"). For example,
> "The Linux kernel user's and administrator's guide" could become "User's
> and Administrator's Guide," and "A guide to the Kernel Development Process"
> could be "Development Process". This is what my patch does.

So I totally agree that the sidebar can use improvement, and I agree
that this patch makes it better.

I'm less convinced about the changes to the page itself, which I
consider to be somewhat more important.  There, I think, the more terse
titles are likely to be less useful for readers.  (OTOH, I think the
result is an improvement for those reading the RST files).

I spent some time a little while back understanding how the sidebar is
generated, and feel that we can make it into what we want it to be.  But
I don't think we've decided what we really want it to be.  I think there
is simply too much stuff there in general; it's never going to be
manageable that way.

There was a suggestion at the kernel-summit session to just put the
top-level books there:

	Kernel documentation
        Development-process guide
        Core API manual
        Driver API manual
        User-space API manual
        Maintainer guide
        Documentation guide

Then perhaps add one level for whichever book is open (if any) at the
time.

I'm sure there are other, better ideas as well.

Meanwhile, I'm pondering on this patch, would like to know what others
think.  Carlos nicely put up some comparison images for us:

  https://github.com/Zildj1an/linux-kernel-docs-compare/blob/main/comparison.png

...so it's not necessary to build the docs to see the results.

Thanks,

jon

