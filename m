Return-Path: <linux-kernel+bounces-159288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F58B2CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8FC1F283D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C681598F5;
	Thu, 25 Apr 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SiqyAVSj"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58198152526
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082224; cv=none; b=gZ6fuIiImhTaVuGw2MwcGX0VzpeFOxP2bFoICJKbffE22vqNQSUloausbJ8iZkWxUzdWChXPmByA3T2eb+K3QsAUfFcOGoqIbZmwbBKFuUica8NIx+UpK1hys2vPC+ssrTPAgf55jm94vVxhmnJWamJUj13gx/Lb1EX+va1uHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082224; c=relaxed/simple;
	bh=2AC9sknLoDsBrHZj6JPOUgXsHl0ckGSbKEILsuBcFn8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0zGLi1eOxaaZ0BRQBMHfa87MPtEs5pYqP6CyVjDSmCpIZ+M56+Mnbd9iMkyCpt4Zo3wn8YtLcx9klPRgsvHl+5dCYd50olm2kMbyJs8UzZrCDRpziA8JYKNTbS9m2bK0oWxm/W/Vl3Pu6vMjFUM4K9JFa83R7nBF4e2Z2Aidfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SiqyAVSj; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xoici6hpxjgnho75p7nsvwzjhm.protonmail; t=1714082219; x=1714341419;
	bh=ssR1QDbWXYl4zvVV2r1hbcZe90jbbir7db4PC/qkIxw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SiqyAVSjPIZTVEUW7Y+8oEW/BRlMJBDBE86ccDZJeHaExhb9IPkM8YozY6go0x13h
	 W/s9+m85Ibcwodaw/VIWgzEj51Y5I2Eu9YqSzdZsyjcbI/0gy3Pa1EBEroAW3FkeEf
	 u9Qg4hMbMnzpj9xP7GzoHCTOCSXfwodJpDFfuC3RC9wl4AEcOPWoKVUL8SE+XU+1p6
	 2KLmWzqMDSbaDctlxAyDQlPmuqmlKetc7JvI9wU2HvLlNddQ956r9EGyzgy17numSU
	 ldE6nEkbebDpV+WZSoL4NoYfoj2Aw7KEzpsz6iPE6r6JkAN5sWftXBuqLLH2fP4uzi
	 bEva6PwM7ZNMg==
Date: Thu, 25 Apr 2024 21:56:54 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] rust: rbtree: add `RBTreeIterator`
Message-ID: <85fdf6ae-3838-46ff-828f-3179cbad1d30@proton.me>
In-Reply-To: <ba946689-d10b-4752-989f-4c6404d7ee55@proton.me>
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com> <20240418-b4-rbtree-v3-2-323e134390ce@google.com> <ba946689-d10b-4752-989f-4c6404d7ee55@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8f60004c9bd63e1dddb642f104a09560ba8a6505
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.04.24 23:45, Benno Lossin wrote:
> On 18.04.24 16:15, Matt Gilbride wrote:
>> @@ -373,6 +416,56 @@ fn drop(&mut self) {
>>       }
>>   }
>>
>> +impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
>> +    type Item =3D (&'a K, &'a V);
>> +    type IntoIter =3D RBTreeIterator<'a, K, V>;
>> +
>> +    fn into_iter(self) -> Self::IntoIter {
>> +        self.iter()
>> +    }
>> +}
>> +
>> +/// An iterator over the nodes of a [`RBTree`].
>> +///
>> +/// Instances are created by calling [`RBTree::iter`].
>> +///
>> +/// # Invariants
>> +/// - `self.next` is a valid pointer.
>> +/// - `self.next` points to a node stored inside of a valid `RBTree`.
>> +pub struct RBTreeIterator<'a, K, V> {
>> +    _tree: PhantomData<&'a RBTree<K, V>>,
>> +    next: *mut bindings::rb_node,
>> +}
>> +
>> +// SAFETY: The [`RBTreeIterator`] gives out immutable references to K a=
nd V, so it has the same
>> +// thread safety requirements as immutable references.
>> +unsafe impl<'a, K: Sync, V: Sync> Send for RBTreeIterator<'a, K, V> {}
>=20
> The bounds on `K` and `V` look like typos to me. They should be `Send`
> instead.

Oops, scratch this comment, what you wrote is correct, since we treat
`RBTreeIterator` as `(&K, &V)`.

--=20
Cheers,
Benno


