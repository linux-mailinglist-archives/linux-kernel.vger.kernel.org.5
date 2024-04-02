Return-Path: <linux-kernel+bounces-128817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD5895FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E0F28383D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5524206E;
	Tue,  2 Apr 2024 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Hm+6z5W0"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115F2260B;
	Tue,  2 Apr 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099397; cv=none; b=mtR6/02H1ZFSJgWPWRtPQ2aSHrp2dd/Ua+4e4h7IneOFdNnAwaI2PCgbU/rf4ZcauYEA6udAzrJABajjZg8mmOKMVQWC5hPh2RabGs0QgOgfJtXseOt+9taYIRj73vpvJCYnL4DoPp0Y9nTORlPPLNw64HlDoKF801c/6+hADTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099397; c=relaxed/simple;
	bh=zTNnWCsplfyp5T2nWgn8oJWZzr3uiuiOLHN2o/GFkwI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjM/oh1p4yx5Yq6SOjpfypoCtqMA/hSz3Di83iuwSUDRqB0hNC8CyD8zeJXP5WlfXmr102V+5dDIJ6rDQx6AhZkooNZtrumyUI+F5bOgXYLaKxGcuXd/5PqZAUsjnpGjrSobal4zH7/UWRyQYnSiVNd+hGeebIkmwD3V9Fl8erk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Hm+6z5W0; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712099393; x=1712358593;
	bh=BwgrpotDzagmgWcu+/Ta2cDFG0k8Ub+uczrR9L3a+SM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Hm+6z5W0XCTQzxG2hgNVqDN4l5wIcESAC+yGWiBo+D23KLk/IzuDXJdtVKuz5Iojy
	 WQWi7fF+4z+QblXHDa1kYZ5f2Cu07vffSRhyv6PU/yRnarmWYAf29en3TpGwGsiDrX
	 /nAlwoz6+ObdcnhSSBjdWSL4SYdJ+iS82Onom7XgVMaP5lTo/fekdAuTMlPpLkPUxT
	 SVoNMLSCgpABTMGlsCbH09H4QfXVVgEFrx8l3rM+q3Zu+4WwMgZKPrCuAvCkJvFC+L
	 25BMpu2Bo4SOwUi52YT31oYfQ85VJHeVFDo1z+pljh6Cr2rOgtp19+wHBFpL0KnvI1
	 RJgdZHXLSuFjQ==
Date: Tue, 02 Apr 2024 23:09:49 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me>
In-Reply-To: <871q7o54el.fsf@metaspace.dk>
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me> <871q7o54el.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.03.24 07:32, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>> +//! implementations of the `Operations` trait.
>>> +//!
>>> +//! IO requests are passed to the driver as [`Request`] references. Th=
e
>>> +//! `Request` type is a wrapper around the C `struct request`. The dri=
ver must
>>> +//! mark start of request processing by calling [`Request::start`] and=
 end of
>>> +//! processing by calling one of the [`Request::end`], methods. Failur=
e to do so
>>> +//! can lead to IO failures.
>>
>> I am unfamiliar with this, what are "IO failures"?
>> Do you think that it might be better to change the API to use a
>> callback? So instead of calling start and end, you would do
>>
>>       request.handle(|req| {
>>           // do the stuff that would be done between start and end
>>       });
>>
>> I took a quick look at the rnull driver and there you are calling
>> `Request::end_ok` from a different function. So my suggestion might not
>> be possible, since you really need the freedom.
>>
>> Do you think that a guard approach might work better? ie `start` returns
>> a guard that when dropped will call `end` and you need the guard to
>> operate on the request.
>=20
> I don't think that would fit, since the driver might not complete the
> request immediately. We might be able to call `start` on behalf of the
> driver.
>=20
> At any rate, since the request is reference counted now, we can
> automatically fail a request when the last reference is dropped and it
> was not marked successfully completed. I would need to measure the
> performance implications of such a feature.

Are there cases where you still need access to the request after you
have called `end`? If no, I think it would be better for the request to
be consumed by the `end` function.
This is a bit difficult with `ARef`, since the user can just clone it
though... Do you think that it might be necessary to clone requests?

Also what happens if I call `end_ok` and then `end_err` or vice versa?

>>> +    pub fn data_ref(&self) -> &T::RequestData {
>>> +        let request_ptr =3D self.0.get().cast::<bindings::request>();
>>> +
>>> +        // SAFETY: `request_ptr` is a valid `struct request` because `=
ARef` is
>>> +        // `repr(transparent)`
>>> +        let p: *mut c_void =3D unsafe { bindings::blk_mq_rq_to_pdu(req=
uest_ptr) };
>>> +
>>> +        let p =3D p.cast::<T::RequestData>();
>>> +
>>> +        // SAFETY: By C API contract, `p` is initialized by a call to
>>> +        // `OperationsVTable::init_request_callback()`. By existence o=
f `&self`
>>> +        // it must be valid for use as a shared reference.
>>> +        unsafe { &*p }
>>> +    }
>>> +}
>>> +
>>> +// SAFETY: It is impossible to obtain an owned or mutable `Request`, s=
o we can
>>
>> What do you mean by "mutable `Request`"? There is the function to obtain
>> a `&mut Request`.
>=20
> The idea behind this comment is that it is not possible to have an owned
> `Request` instance. You can only ever have something that will deref
> (shared) to `Request`. Construction of the `Request` type is not
> possible in safe driver code. At least that is the intention.
>=20
> The `from_ptr_mut` is unsafe, and could be downgraded to
> `from_ptr`, since `Operations::complete` takes a shared reference
> anyway. Bottom line is that user code does not handle `&mut Request`.

Ah I see what you mean. But the user is able to have an `ARef<Request>`.
Which you own, if it is the only refcount currently held on that
request. When you drop it, you will run the destructor of the request.

A more suitable safety comment would be "SAFETY: A `struct request` may
be destroyed from any thread.".

--=20
Cheers,
Benno


