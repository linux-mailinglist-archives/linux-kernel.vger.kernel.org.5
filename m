Return-Path: <linux-kernel+bounces-120209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D391E88D47D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604E11F2E96A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE2208CE;
	Wed, 27 Mar 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7lyagN9"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088A21350;
	Wed, 27 Mar 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505864; cv=none; b=Td7ND/kQFEWvilQLgflFqz0MofqViYko8Fk28Y0ECAYOgniyAr7M1CO9fzPxAa8YMnjz6zne/wyDyWqKbFK188USnnZF3xD3qTInRpFRg2F38xT7jCJMTMm2zECYtmHP0qwZvU5+M4Nsp0o7/sUU3KkGp7QyaQnu4fuAX1hjlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505864; c=relaxed/simple;
	bh=iaw4baeHrINu60FiqZnVfwkVeJ/VbHfr6pS5CI6bXfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlQbL/YQLWYdlGn8UWcRrU30fl5PGkqGRRZhMJrvOSVcOqaIgLCxl4VMqctsX3mppuIQfXadmhRJ85BFm7tsEPwsLtmHRawmaa5UNFLxi+mOphsCT4cN6JDhExINyGL7o2N4aQYQXIEL98cvWjUdb2QUvtrt4FuJbGo5i6350ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7lyagN9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a104601dcso69612897b3.2;
        Tue, 26 Mar 2024 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711505862; x=1712110662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/ONsFU9nxQvS8X3SSqcN2WZie/AcsRGqQejcrWJvLg=;
        b=S7lyagN9vUalAei0exvpQCugWtSHj9K8kFZtLrX5BmAktEy6imPCPVPGLVhw0Y/xAW
         yWRE/Ng1dMrqx8eIrCFmLbwPrjaZCqQ5kUOEsby2UFRICvp0oiP5CqaTZPFiWcvlm0VR
         h5TYAQsz7iXbdMZJGoM4WvXW3Neoe+tjwhnQec5e85Aj8fyO4BJ832tlVD0fda+krvVr
         m0rzIxS53mquCwkz5oI/Qk+P21bve9a1SNtvjrXI13C9JxQuhOOkZ9b0deQM6FXuPSu7
         3nIivIOVcDhRFBQQbtxOttsd84pAdcY+pSBj/7uAj8r1FolMKxehXqWe6WdvBkygJpxN
         yV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711505862; x=1712110662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/ONsFU9nxQvS8X3SSqcN2WZie/AcsRGqQejcrWJvLg=;
        b=nDo/MFrppTcb9nG/7k9u0TbRYTaQvEeh1h/NkL1ier7q7ktPPfIHo1XHoatSpZt9ba
         AD1VddQAOGJ/b7Yep5M4P59L4vYwZU8v9+uZOJ6WoLQVOpwZnx02DbdAujvnBtwn8kko
         +3OcYcyE1Bbt8E8kGMufWdsNE3LjHbe3GGrgE32ogNPU2axL0EH+h7jwV+yETBGsDM0b
         m+slrJOKbC07Gvl8frT5LxU3RRSX7Tx5wCCkkiubkMVZTRY82OlMu0OjNyymMzBtnL1U
         PZeGQU7qhm0TVrc4dNzDXMB9eTqJXXxWIj3or9vDGgiRnv6dX/8uDDCYelbOKkwrR/PW
         9Ciw==
X-Forwarded-Encrypted: i=1; AJvYcCWiIHIabLGti/9kNf4H+3I23IA/gqFfq8R1GahjS2EN0mo2de1fOocPehPGLBsOhci0pE9tYYZMtbNICq3hyv4JJz3LpChmXjSZcpl2
X-Gm-Message-State: AOJu0Yz2nW6A7VtNFSCP3XujE2UssCwg9hHooc4PA5iUm2UfTHu0KE92
	6sTLqf2bg9ry9xBU7muuAohuWEda9NA5+roqOw5OmquqpnlK4d1Rv1usCroVglZMnIaHaZInwag
	8AmDmNBLpmXBCyYnsIZHecF6AX68=
X-Google-Smtp-Source: AGHT+IFp5xMs9OLotiXTVcggVeHAjT8BFY5vV/Sf2uZ2e51bFIHIq7aSAoLewahgcUPNSA5cr5WISCO/bZg8yKvAFqg=
X-Received: by 2002:a0d:f006:0:b0:611:242e:4116 with SMTP id
 z6-20020a0df006000000b00611242e4116mr4418566ywe.34.1711505861969; Tue, 26 Mar
 2024 19:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-10-wedsonaf@gmail.com>
 <kiqpEglPExNZBB0TsooPwQsQTwFfYadAnVfztU9sFzYJ5CU_Rg0PC_KYEQF4duxv7qOo6gOBUFVnR-GfuEsIEYqgBSWnOGEZAcl3t06cB2s=@proton.me>
In-Reply-To: <kiqpEglPExNZBB0TsooPwQsQTwFfYadAnVfztU9sFzYJ5CU_Rg0PC_KYEQF4duxv7qOo6gOBUFVnR-GfuEsIEYqgBSWnOGEZAcl3t06cB2s=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 26 Mar 2024 23:17:31 -0300
Message-ID: <CANeycqou9AT6BzxdNKrT_B2eRs4htjJx3dq-mKBByMOAj-8qiw@mail.gmail.com>
Subject: Re: [PATCH 09/10] rust: init: update `init` module to take allocation flags
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 11:08, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 25.03.24 20:54, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This is the last component in the conversion for allocators to take
> > allocation flags as parameters.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> >   rust/kernel/init.rs               | 49 ++++++++++++++++---------------
> >   rust/kernel/sync/arc.rs           | 17 ++++++-----
> >   rust/kernel/sync/condvar.rs       |  2 +-
> >   rust/kernel/sync/lock/mutex.rs    |  2 +-
> >   rust/kernel/sync/lock/spinlock.rs |  2 +-
> >   rust/kernel/workqueue.rs          | 13 +++++---
> >   6 files changed, 47 insertions(+), 38 deletions(-)
>
> One formatting issue below, with that fixed:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index 077200f5350b..af539c5eb4bc 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -565,13 +565,16 @@ pub fn new(value: T, flags: Flags) -> Result<Self, AllocError> {
> >       }
> >
> >       /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
> > -    pub fn new_uninit(_flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
> > +    pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
> >           // INVARIANT: The refcount is initialised to a non-zero value.
> > -        let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
> > +        let inner = Box::try_init::<AllocError>(
> > +            try_init!(ArcInner {
> >               // SAFETY: There are no safety requirements for this FFI call.
> >               refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> >               data <- init::uninit::<T, AllocError>(),
> > -        }? AllocError))?;
> > +        }? AllocError),
> > +            flags,
> > +        )?;
>
> The indentation looks wrong, rustfmt sadly cannot handle the pin-init
> macros. This looks better to me:
>
>         let inner = Box::try_init::<AllocError>(
>             try_init!(ArcInner {
>                 // SAFETY: There are no safety requirements for this FFI call.
>                 refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
>                 data <- init::uninit::<T, AllocError>(),
>             }? AllocError),
>             flags,
>         )?;

I remember trying to rearrange this and `rustfmtcheck` not liking it
but it seems to be happy with your suggestion.

Applying it in v2.

> --
> Cheers,
> Benno
>
> >           Ok(UniqueArc {
> >               // INVARIANT: The newly-created object has a refcount of 1.
> >               // SAFETY: The pointer from the `Box` is valid.

