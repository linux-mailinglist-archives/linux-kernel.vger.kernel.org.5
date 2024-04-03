Return-Path: <linux-kernel+bounces-129554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF06896C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640BB289E62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386801386DC;
	Wed,  3 Apr 2024 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BQKDUtR0"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34C137933;
	Wed,  3 Apr 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140165; cv=none; b=UWC8IBR7jt1zAgCWH4vz/aVnMZqNel+Mf1k42KQYmIxz9/3oTjs+/MD0A3WMjY68++KsMHKoATuHdlihNjfpgRKG4ttb3uLImgCbEBlYydt+o82MA3SCl92liiOf2H8eeSExFWXDxBm7vG2pfe1cLo4wf2o5n1b5uN4KVav9SWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140165; c=relaxed/simple;
	bh=TRgmSCS47XmztYBTKUWIVfivwGiaA9pcBJdWmp920Y0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNTOrO7ICgMauK1uKZeJdW91nyOTtOBCfclAn6FS7tcKOvWgqfvTOWTTWgfd4UafifHo40CHlAdcCh8BSNIqW8T78nJSZnJK4vDpY9uROlPi9pl5L5DLxR1e28q/D5JkZYWP4VXou8Wx1i0WIK+9fhErdsh/OAT4ksx/8/VmFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BQKDUtR0; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712140160; x=1712399360;
	bh=0+ZIPpVWWwhVkx/Hb3rlBLHGyanMXDiQ9rN4MJdAnNY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BQKDUtR0/xH56lQmHK6WPW02i619kMS0v1m/KZwLkooNedsvp87IYuFRRdEYcMXTw
	 ZMy7A2R2AhFuAYLOH6L4O8u7SUboXHeRAqjsVONajAPWE3kyCgjfigxJA8wJymP0AD
	 lxkxtCcdjbyR9g4Q6Zb2BUQELlDRuYwAkBu2X6NblG/qs28i5ASZg34Dna1gv2U2Ph
	 Bp9dgw12Jk+Z0149K7A9oHZOqHscuzz8tSrGleGUNM8JOdGpEox7PbyvAxndkWDfPP
	 +mWbNWXi6NV8zff6vejQOma5AJx8adfyIjUE6nX/TebaZ5Rinc1gSoGxgrf9g/uCxN
	 GvvM82j0CjurQ==
Date: Wed, 03 Apr 2024 10:29:12 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 4/5] rust: block: add rnull, Rust null_blk implementation
Message-ID: <7e6874d0-786d-4e02-a203-a2524cf8ff9e@proton.me>
In-Reply-To: <87edbmsrq1.fsf@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk> <20240313110515.70088-5-nmi@metaspace.dk> <QqpNcEOxhslSB7-34znxmQK_prPJfe2GT0ejWLesj-Dlse1ueCacbzsJOM0LK3YmgQsUWAR58ZFPPh1MUCliionIXrvLNsOqTS_Ee3bXEuQ=@proton.me> <87msqc3p0e.fsf@metaspace.dk> <1e8a2a1f-abbf-44ba-8344-705a9cbb1627@proton.me> <87edbmsrq1.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.24 11:47, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
> [...]
>=20
>>
>>
>> So I did some digging and there are multiple things at play. I am going
>> to explain the second error first, since that one might be a problem
>> with `pin_init`:
>> - the `params` extension of the `module!` macro creates constants with
>>     snake case names.
>> - your `QueueData` struct has the same name as a field.
>> - `pin_init!` generates `let $field_name =3D ...` statements for each
>>     field you initialize
>>
>> Now when you define a constant in Rust, you are able to pattern-match
>> with that constant, eg:
>>
>>       const FOO: u8 =3D 0;
>>
>>       fn main() {
>>           match 10 {
>>               FOO =3D> println!("foo"),
>>               _ =3D> {}
>>           }
>>       }
>>
>> So when you do `let FOO =3D x;`, then it interprets `FOO` as the constan=
t.
>> This is still true if the constant has a snake case name.
>> Since the expression in the `pin_init!` macro has type
>> `DropGuard<$field_type>`, we get the error "expected
>> `DropGuard<IRQMode>`, found `__rnull_mod_irq_mode`".
>=20
> Thanks for the analysis!
>=20
> So in this expanded code:
>=20
> 1   {
> 2       unsafe { ::core::ptr::write(&raw mut ((*slot).irq_mode), irq_mode=
) };
> 3   }
> 4   let irq_mode =3D unsafe {
> 5       $crate::init::__internal::DropGuard::new(&raw mut ((*slot).irq_mo=
de))
> 6   };
>=20
> the `irq_mode` on line 2 will refer to the correct thing, but the one on
> line 6 will be a pattern match against a constant? That is really
> surprising to me. Can we make the let binding in line 6 be `let
> irq_mode_pin_init` or something similar?

The first occurrence of `irq_mode` in line 2 will refer to the field of
`QueueData`. The second one in line 2 will refer to the constant.
The one in line 4 is a pattern-match of the constant (since the type of
the constant is a fieldless struct, only one value exists. Thus making
the match irrefutable.) The occurrence in line 5 is again referring to
the field of `QueueData`.

If you have a constant `FOO`, you are unable to create a local binding
with the name `FOO`. So by creating the `irq_mode` constant, you cannot
create (AFAIK) a `irq_mode` local variable (if the constant is in-scope).

>=20
>>
>> Now to the first error, this is a problem with the parameter handling of
>> `module`. By the same argument above, your let binding in line 104:
>>
>>       let irq_mode =3D (*irq_mode.read()).try_into()?;
>>
>> Tries to pattern-match the `irq_mode` constant with the right
>> expression. Since you use the `try_into` function, it tries to search
>> for a `TryInto` implementation for the type of `irq_mode` which is
>> generated by the `module!` macro. The type is named
>> __rnull_mod_irq_mode.
>>
>>
>> Now what to do about this. For the second error (the one related to
>> `pin_init`), I could create a patch that fixes it by adding the suffix
>> `_guard` to those let bindings, preventing the issue. Not sure if we
>> need that though, since it will not get rid of the first issue.
>=20
> I think that is a good idea =F0=9F=91=8D

Will do that.

>=20
>>
>> For the first issue, I think there is no other way than to use a
>> different name for either the field or the constant. Since constants are
>> usually named using screaming snake case, I think it should be renamed.
>> I believe your reason for using a snake case name is that these names
>> are used directly as the names for the parameters when loading the
>> module and there the convention is to use snake case, right?
>> In that case I think we could expect people to write the screaming snake
>> case name in rust and have it automatically be lower-cased by the
>> `module!` macro when it creates the names that the parameters are shown
>> with.
>=20
> I was thinking about putting the parameters in a separate name space,
> but making them screaming snake case is also a good idea. So it would
> be `module_parameters::IRQ_MODE` to access the parameter with the name
> `irq_mode` exposed towards the user. Developers can always opt in to brin=
ging
> the symbols into scope with a `use`.

I really like the idea of putting them in a module. At the very first
glance at the usage, I thought "where does this come from?!". So having
`module_parameters` in front is really valuable.

--=20
Cheers,
Benno


