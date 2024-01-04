Return-Path: <linux-kernel+bounces-16732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22882430F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D21F1C21F18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D1B224D4;
	Thu,  4 Jan 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4AW5NZAO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8A224D3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7cd5ab5d5bbso170296241.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704376136; x=1704980936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMDVMQujU84yMnm6nGs6lmfbP0leDvmtuXFBPjTVJb4=;
        b=4AW5NZAOA2XXKN9zE3aGrLmr64RI7vAGWhTgyn0RL+IOduUXxmkbR4+kzSAb42QPFV
         ckeevFQAM9A8Ski/W2J7FOXatbUf0HYpSgmK5XK3DxMbql6AovV/nKyZBouWh57JJeQY
         W0hsOE1Hi9AzKFqIqnf4MyQmQzguXIOmEue/MCE+cdtJFGH4Qfd8sDvCvdSe8dnhcdmO
         8TLXPdaIzBC7efigLtI9+E9kne4FTNGUntNkmO3g/DOIorMsRfwUmKKbEPgBGzF9fgVt
         LFhDruQejqS6MJQCuRs/pKrzrisnDAv1hDnOBA4ETrjaKmJG8bP5rM5akNJrSYc0SGG5
         Sa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376136; x=1704980936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMDVMQujU84yMnm6nGs6lmfbP0leDvmtuXFBPjTVJb4=;
        b=hllgcoCZYSY9UebPfHRZFJqlmHGkJu1I+BmqJZbUT6xW3m5WOXEQesQjaTGnoXfU68
         pyk8SAwdt5v00wFeXo6iqfgzvveXlojRUtX3A8s4T2yHytZ4fwMDX0fZzGYIIcAeEcnK
         247ET/9XxEHYhaFuSWl5r7kXBgwn4p+k/djfIk4ENzAyLa5VxSxpnXwsN6qyho/n4EZf
         wNzYYbAXdKMSPQQhXxV46FNCIVrZnBwEndfwDLlAop6HmWlHqdi9769hR+2h09YYyhIl
         N+EElwU81GqgipwI7gYnrOgumhYOd0a5Kl227/GiADuxoJ9ptwJtbAcN4wlklMP5MK/Z
         NGdQ==
X-Gm-Message-State: AOJu0YyH0INSJnn0v/RkVfyleF+wy8UQDcTngC5VVTQR/7V2R0Y46q7P
	EsoQJyeHK5tNfAqbO+3CWZex0ZUzpooQA53lSlrKmZz09NmV
X-Google-Smtp-Source: AGHT+IH47FmuyfTmRVFeXPOqqDNbtmVdCsHNqrvFBlVRhnrPJIaMHV7+5pPWivmai2Px+Q47+cEV48pgmwOQWxdGXrM=
X-Received: by 2002:a05:6102:f86:b0:466:bdef:478c with SMTP id
 e6-20020a0561020f8600b00466bdef478cmr419685vsv.13.1704376136134; Thu, 04 Jan
 2024 05:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com> <ZYC2W5Rzdrsr2KKv@boqun-archlinux>
In-Reply-To: <ZYC2W5Rzdrsr2KKv@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 14:48:44 +0100
Message-ID: <CAH5fLggOxwx4+qDjP8WV_e1Nw3oxAxXDDJuQ30uSVEcA_yn55w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rust: sync: add `CondVar::wait_timeout`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:15=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Sat, Dec 16, 2023 at 03:31:41PM +0000, Alice Ryhl wrote:
> > +const MAX_SCHEDULE_TIMEOUT: c_long =3D c_long::MAX;
> > +
>
> I'd like to put this in rust/kernel/time.rs or rust/kernel/task.rs, but
> it's not a blocker.

I'll move it to task.rs.

> > -    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, gu=
ard: &mut Guard<'_, T, B>) {
> > +    fn wait_internal<T: ?Sized, B: Backend>(
> > +        &self,
> > +        wait_state: u32,
> > +        guard: &mut Guard<'_, T, B>,
> > +        timeout: c_long,
>
> Nit: maybe `timeout_in_jiffies` instead of `timeout`? Or we have another
> data type:
>
>         pub type DeltaJiffies =3D c_long;
>
> or
>
>         pub type JiffyDelta =3D c_long;
>
> because a "c_long timeout" really hurts the readability.

I will rename this to timeout_in_jiffies.

Alice

