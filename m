Return-Path: <linux-kernel+bounces-73212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458985BF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10240281ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF6873166;
	Tue, 20 Feb 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDngkQcj"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CD6F53C;
	Tue, 20 Feb 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441475; cv=none; b=kTZg1Z4yu2PJU4x21N88QEhCEGoUg3wRa0jVX8TOmThnreK624ffSVbLG/QP8ivL9mSFLPcOhdWwypkfftkd4dfdoDlGwj4L54DDkvbIZRTwUdthOD8KWyff+4WXsGKqRS2jTBOn8ArH1pz+TSyn3YvXsikqBnuZtIVlGmXsh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441475; c=relaxed/simple;
	bh=KumKsn8sehZfu7Vu0oDRvilmtG+UWuW2duPuRG3CRg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFwj7uzmCixv3Ey4txuA3rEEVgxSsXQNJNtwXf6jM+C+NCdBhBqzKa41poTI5xUnR15bUP8pTQRGTJC517wjMGgXJ7A/vA01SmeQfkMErb2Ig2jrjz1lGv7X2qt1UhTKAw46now/gB0aHGJyfxI0EWyxKwcTMfRpqk2C8ZFi8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDngkQcj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-290ec261a61so3340862a91.0;
        Tue, 20 Feb 2024 07:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708441473; x=1709046273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C7PqnJ3IjMaFo87Yysu/rmUmxBBQU3uMR0rjaQTEpA=;
        b=FDngkQcjBokRqF+DGGwy+VhHKuIqUGUvBK2PRnkuqmsAp0I2Ur2Vl7i8jRoV8Ic32u
         dNAyO5HPZRb8aiBlkNBsHdMKUdJ9g6G4JaCOlRa1V0yE5KItkubLaPJH4lrO4pSLOBQi
         99DnifUKZqyrJCKNCx7RakHAfqVdbjjgLDDsFjtw7VmS4WKrSLSDhUgqDSy9KrddHR+/
         259wMWa7dz1sSBTIbf4pJfuT8Vmhxrw1s9mcSkguuQgqvJnve44K6saRNHcxcGofdeHu
         bvE9vKnUVSGIprkmlkA0iYAjXTrX89Vz3TiUdIi71UZcLr7u0uDXqFQPieAgFaZ+B99k
         JwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441473; x=1709046273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C7PqnJ3IjMaFo87Yysu/rmUmxBBQU3uMR0rjaQTEpA=;
        b=LwyNDDPgZu11P+1dhn2GExzuScGKsw0ijQnlj6erJDNbw/zkJVOGry77+4Ue+9pGo/
         QeG9gFhVORRsLEFKNXEP7CXzLYFeTZUeEgn/SrzzICSqigA0dgWhIA5x8R2Y/mOI08xb
         8M09p2KfqKv7IBI8v50YhgchqtxQGapAjpSxoXhQuK7xh6RD/fz2f+QX+vgQi1lVBkCk
         G58j0GrksTpnqjujIbJXJnntxMglZI8ut6rgF36ppBPppdSfUnHAvU66LAvSDeCxEVUw
         +993j3hBj70yGvd9iN+ochXpKlhDK6FSaRU2snZVfwUjW2DhQyNNxBCfJYaLaiUDYMKn
         ry0g==
X-Forwarded-Encrypted: i=1; AJvYcCXfJnERkfx1Da7Fzpy1HXMAwpaK9w2w7+l1+sRyhm15vp5j8ysVlvNQIG9KQARkBRy5ffwVlX9WMp8QeHDyINP8uhOMHhC3lGBlji07yZznLoClfdxF51kROScyp77MbxvoiCyuTiOZgMCXbSw=
X-Gm-Message-State: AOJu0YzRkRFo4BMSkbQGKHSbtqxSG8YDkJglkl1CmdCVKb5FG30U9GtN
	3i7rfrfBcTHeNuRUu/tHYSsJHm969sdOAZJiPHBmNot7Q1nZ+tZ1wEl603ygRyGVJkDjvdlqaB3
	Wts5uSwSoitvC2QSMYmKfByKJ9ppv2fcumL4=
X-Google-Smtp-Source: AGHT+IFmmR7zC5AVfoTKhpWj9/FTpbwi1sLa5aQCxn+YcY6uu5abjjySLYRSJ9wmhmn9orU0xP0GxYztyxSBmGgkmdk=
X-Received: by 2002:a17:90a:4414:b0:298:eacc:682f with SMTP id
 s20-20020a17090a441400b00298eacc682fmr15106856pjg.34.1708441473290; Tue, 20
 Feb 2024 07:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219163915.2705-1-dakr@redhat.com> <20240220093541.280140-1-aliceryhl@google.com>
 <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com>
In-Reply-To: <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Feb 2024 16:04:20 +0100
Message-ID: <CANiq72nVkV3+1rt4Mi+Own6KGAzmvR2jf8fFsp9NBu_gy_ob5g@mail.gmail.com>
Subject: Re: [PATCH v4] rust: str: add {make,to}_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 1:03=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> That's the worst rationale I could think of. Without further rationale wh=
at that
> should mean and why this would be good, it's entirely meaningless.

Probably whoever wrote that did not feel the need to explain further
because it is the convention, but please feel free to open an issue/PR
to Clippy about improving the wording of that text.

The convention itself, however, you will find way harder to change
everywhere else.

> Instead, I'd argue that keeping it gives kernel people, who necessarily n=
eed to
> deal with both, Rust *and* C, more consistency in kernel code.

That sounds to me like trying to keep consistency in style/formatting
between two languages, which is something we have discussed quite a
few times in the past.

We are keeping Rust code as idiomatic as possible, except where it may
actually make sense to diverge for kernel reasons.

But this one does not seem to be the case:

  - It is inconsistent with most Rust code out there.
  - It is inconsistent with all Rust kernel code.
  - It is inconsistent with learning material, which kernel developers use =
too.
  - It introduces 2 ways for writing the same trivial thing.
  - Rust is a more expression-oriented language than C.

And, by the way, your patch does use both ways. Why aren't you
explicit when it is a single expression too?

> At least, this shouldn't be fatal IMHO.

For some of the compiler-based (i.e. not Clippy) and that may make
prototyping a bad experience, I could agree (e.g. like missing
documentation is already a warning).

But please note that patches must be warning free anyway, so it is not
like this patch would have been OK.

> Similar story here. Why is it bad, and even *fatal*, to be explicit?

This one is more arguable, and could be discussed. In fact, we planned
going through some of the lints in a meeting to see, mostly, what
extra lints could be enabled etc. You are welcome to join if that
happens (I think Trevor wanted to drive that discussion).

> Again, not a great rationale, this is entirely subjective and might even =
depend
> on the context of the project. Again, for kernel people who need to deal =
with Rust
> *and* C continuously it might be better to be explicit.

That is fine, but to decide on this like this, we need better examples
and rationale than just "it might be better" (and please note that
whatever Clippy says is not important, so complaining about their docs
being lacking is not really an argument to change kernel code).

Cheers,
Miguel

