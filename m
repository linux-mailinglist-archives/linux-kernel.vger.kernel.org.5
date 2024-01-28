Return-Path: <linux-kernel+bounces-41926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FC483F9A9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018B9B20940
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD33BB55;
	Sun, 28 Jan 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYryKuyl"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64033CD6;
	Sun, 28 Jan 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472258; cv=none; b=EH4/ruTUmorDn31uhTE2F0LresCscmL34Pyb0FNGmNybjxCzQlvEmIpWSEha2+gvxn9IkAvTzsRTIkNuighLzXZcWlMPKgIKzIUfC3UBQuzU5+ItfkLxLE/FbNmefu3pSCWcqZDXNKhIBE7KzD9VFRpNP7F6EycwB3ddiHWkvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472258; c=relaxed/simple;
	bh=9S3wfQZkihmike9xgBCv7o3FsGpq1FyElKHqMnPKnfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2NX01/cUIKlQW22w9M+9iFli3oX7y68ExesK9bhbGXHIxJcMeFK8wQz4hytJ4MAdxs9oF5s7E7e81Lg7TftXiAB2lSldQe5KXRsG17QLmwxAu1S5MWYwZ3PQVyHV+sAWT8cfnvSr0bppWTMmWAZJKBlVouSHTww2CK938swZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYryKuyl; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6029e069e08so28483187b3.0;
        Sun, 28 Jan 2024 12:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706472256; x=1707077056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S3wfQZkihmike9xgBCv7o3FsGpq1FyElKHqMnPKnfA=;
        b=PYryKuylj0e5Vwgo5z1RVjrHywzRSVOU5BxL6UUejB3Sw1YSr2xMwZY77zQke6dkAp
         heNjysT8dRcZZV4GcM83n+83obmhok34buAwbnXFIIsECLjymgYxYpmSI+F//LNv/ulr
         Fr92TATYawz3EES7XFAWYW3zltwfXZAAEga0zWhhycJwodte/L2alZPLK4s3oM5JeJnr
         sKLJ0kbHI6tZ9SK9awMJJ6KT7UMCKWy+oMTvzQpJtwvo349XLd5GgxeMDjr99+X4JZHR
         kTM/oI6P0arDESJhvlGF++msQZTsSynK7ofUU7k3EDN+EkQjr5CqS7hgY7U2PQ4ivva2
         0Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706472256; x=1707077056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S3wfQZkihmike9xgBCv7o3FsGpq1FyElKHqMnPKnfA=;
        b=sbo5zyKGVK6ZwQ3lsUdEKCdUuzUZ+vvpTSZ+72k28cgtWiYkXFkMyZlHQuepqPXkJt
         zTC8UAHoeeb4W5fDkXSinqho+Qt0ulpUodQYvGdEfMHQarOuhQHmASxx9BSeHVFhowUO
         e+hqROTT5bNSImqSW/Mhmx9yGcOXpd/IJxfTGG8hwUpouzkk3FawQvAVUCMMSxSzMBxy
         fp+aQd75TXeSTPrXCv1s2H69fL950LQGR56XetXUFFXfytCIkMYx6BGSr1aJx71X3X36
         hfR4JuTXLYAV8w++k6c6v1+8Oe/AdzPUiFaaumtxeQJEHOpu2TtFwXL8J1408/PXCuyz
         I68Q==
X-Gm-Message-State: AOJu0YxxnJ9vn64cHCxMrQX1MKRbpjIRW+IF2SahWmnxyFD3hFqyI5t3
	jFDBHJFDiA+gj4EYbDVfdXM50JnhNIsjJQHS8+DuirN2MRdX+WyzakE9FAF/jfLl5H8glx6Tfle
	ohc5tSGx9tt1Um4FB8nAUN7jwCSI=
X-Google-Smtp-Source: AGHT+IEyKJdkMN/kf7/gqXc3y+MmKAwmeLzIw6JXklbGpM3d02BOESQBvIGtxP5qvDNS880qNhJVxNuMxY6sffQyHHI=
X-Received: by 2002:a0d:d8d2:0:b0:5ff:9b2a:d0b9 with SMTP id
 a201-20020a0dd8d2000000b005ff9b2ad0b9mr2486371ywe.97.1706472255731; Sun, 28
 Jan 2024 12:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
In-Reply-To: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 28 Jan 2024 21:04:04 +0100
Message-ID: <CANiq72kx8oBO_oFZqfKdC2U9R+je1UiA+nVAAwZAEivqvfiZQA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Additional CondVar methods needed by Rust Binder
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 3:50=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This patchset contains some CondVar methods that Rust Binder needs.

Applied to `rust-next` with conflicts resolved after the `wait_list`
rename, added `CondVarTimeoutResult` re-export, fixed typo and added
note on the `sizeof(int)` being unlikely to change.

Alice: please double-check if I missed something.

Thanks everyone!

Cheers,
Miguel

