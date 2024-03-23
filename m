Return-Path: <linux-kernel+bounces-112306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE99887823
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE31C20E4C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFCD14ABA;
	Sat, 23 Mar 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jJkd9oiZ"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090610957;
	Sat, 23 Mar 2024 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711191129; cv=none; b=es/pDlJFQ9eFtfuBQDMnu3vpBfwCZX0nVkjjwy9AbRWPmish6xVwZgWfAv2+OQ2niVIZ1MJj5xOy0xDvADJazvN2AfVwLxvjpcztw/ZpUOL71KO9/K/teFMa0WNZKI86zkjCP/8OgD2CLdMzsIXKCOs9IFbdK+U02tcoYRClr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711191129; c=relaxed/simple;
	bh=lDUbweLZTFKaO03LACvqE5G6z4ibhw1S8CeSImz9FQs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFIADQ0lxmb3HU/hS8PyPpJXq5E5JsiribH0EX9AUI1lVbgZSjfpu7GKSlL+cKSBBrv9YF6kBXYOOIF125g+ZdqXdcr1hdE3pfFMntJ9gy0UBmR02zsUeVwACZC8mstU8x7ls122ER8FMbTrccKWsDBFfpLbpD9HfcY/ik4QuTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jJkd9oiZ; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7jitdd4ym5b4jkxz7i33jwzxwm.protonmail; t=1711191123; x=1711450323;
	bh=pkgJxujshGHrdAmanmDwjDVhz1xUKbpjmGsOJY8+AlM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jJkd9oiZ69Ou2NS4nQHAOkC6/NYnkBCUOuAAFqkRAWVQIASX5+9jm5MmIO/EQ7bbc
	 x7yv2gVUReEe5+QKwt7X+hqhsiQ+yWHzze+J9JmS7wbKhRwMCSVXgPMODAcnWbkawT
	 hSw9d9h4yMFLpaz2YWeqocU9XCFYTQbEmKXl1aVsUE/fz9myzL8eUeIRgNFJeqS7Wo
	 CNBXT7exxSLPKNbRcRDBRWUKfJF6xyNox8H1/gj/QjAsAKxKvtzV5eYIbde40RwXLi
	 OpAym1nenCTvH+Sd0GsO/adsrrmghad3krGqQHOpHXnIPm2Z11V0rG/MofHSXH0wv2
	 4ZKVcdyA7fenA==
Date: Sat, 23 Mar 2024 10:51:57 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 3/5] rust: block: allow `hrtimer::Timer` in `RequestData`
Message-ID: <sHRsbsEAgQZOgBjItL1A-a1BOEGTeH4CWqZsrdny4vCI06o56pmKluCTbY_EwRDO1hCjEp9Cuq9_8S8Co2I9c8wquHWZH_KGjOpmbF1YiJc=@proton.me>
In-Reply-To: <20240313110515.70088-4-nmi@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk> <20240313110515.70088-4-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/13/24 12:05, Andreas Hindborg wrote:> From: Andreas Hindborg <a.hindbo=
rg@samsung.com>
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>   rust/kernel/block/mq/request.rs | 67 ++++++++++++++++++++++++++++++++-
>   1 file changed, 66 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/reque=
st.rs
> index cccffde45981..8b7f08f894be 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -4,13 +4,16 @@
>   //!
>   //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h=
)
>=20
> +use kernel::hrtimer::RawTimer;
> +
>   use crate::{
>       bindings,
>       block::mq::Operations,
>       error::{Error, Result},
> +    hrtimer::{HasTimer, TimerCallback},
>       types::{ARef, AlwaysRefCounted, Opaque},
>   };
> -use core::{ffi::c_void, marker::PhantomData, ops::Deref};
> +use core::{ffi::c_void, marker::PhantomData, ops::Deref, ptr::NonNull};
>=20
>   use crate::block::bio::Bio;
>   use crate::block::bio::BioIterator;
> @@ -175,6 +178,68 @@ fn deref(&self) -> &Self::Target {
>       }
>   }
>=20
> +impl<T> RawTimer for RequestDataRef<T>
> +where
> +    T: Operations,
> +    T::RequestData: HasTimer<T::RequestData>,
> +    T::RequestData: Sync,
> +{
> +    fn schedule(self, expires: u64) {
> +        let self_ptr =3D self.deref() as *const T::RequestData;
> +        core::mem::forget(self);
> +
> +        // SAFETY: `self_ptr` is a valid pointer to a `T::RequestData`
> +        let timer_ptr =3D unsafe { T::RequestData::raw_get_timer(self_pt=
r) };
> +
> +        // `Timer` is `repr(transparent)`
> +        let c_timer_ptr =3D timer_ptr.cast::<bindings::hrtimer>();
> +
> +        // Schedule the timer - if it is already scheduled it is removed=
 and
> +        // inserted
> +
> +        // SAFETY: c_timer_ptr points to a valid hrtimer instance that w=
as
> +        // initialized by `hrtimer_init`
> +        unsafe {
> +            bindings::hrtimer_start_range_ns(
> +                c_timer_ptr as *mut _,
> +                expires as i64,
> +                0,
> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +            );
> +        }
> +    }
> +}
> +
> +impl<T> kernel::hrtimer::RawTimerCallback for RequestDataRef<T>
> +where
> +    T: Operations,
> +    T: Sync,

Why is this needed? Shouldn't this be `T::RequestData: Sync`?

Is the `run` function below executed on a different thread compared to
the `schedule` function above?
If yes, then `T::RequestData` probably also needs to be `Send`.
You also would need to adjust the bounds in the impl above.

--=20
Cheers,
Benno

> +    T::RequestData: HasTimer<T::RequestData>,
> +    T::RequestData: TimerCallback<Receiver =3D Self>,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart {
> +        // `Timer` is `repr(transparent)`
> +        let timer_ptr =3D ptr.cast::<kernel::hrtimer::Timer<T::RequestDa=
ta>>();
> +
> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
> +        // enqueing the timer, so it is a `Timer<T::RequestData>` embedd=
ed in a `T::RequestData`
> +        let receiver_ptr =3D unsafe { T::RequestData::timer_container_of=
(timer_ptr) };
> +
> +        // SAFETY: The pointer was returned by `T::timer_container_of` s=
o it
> +        // points to a valid `T::RequestData`
> +        let request_ptr =3D unsafe { bindings::blk_mq_rq_from_pdu(receiv=
er_ptr.cast::<c_void>()) };
> +
> +        // SAFETY: We own a refcount that we leaked during `RawTimer::sc=
hedule()`
> +        let dref =3D RequestDataRef::new(unsafe {
> +            ARef::from_raw(NonNull::new_unchecked(request_ptr.cast::<Req=
uest<T>>()))
> +        });
> +
> +        T::RequestData::run(dref);
> +
> +        bindings::hrtimer_restart_HRTIMER_NORESTART
> +    }
> +}
> +
>   // SAFETY: All instances of `Request<T>` are reference counted. This
>   // implementation of `AlwaysRefCounted` ensure that increments to the r=
ef count
>   // keeps the object alive in memory at least until a matching reference=
 count
> --
> 2.44.0
> 

