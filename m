Return-Path: <linux-kernel+bounces-36744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A9983A5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB1290DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D618054;
	Wed, 24 Jan 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Df71+RvZ"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EC18035;
	Wed, 24 Jan 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089890; cv=none; b=NrrNcqVrfolGpElzQWHbBqv6wJbSrFH2ChJf3vUmXNnhfFrnliRt+Gl6016D2AN5ig7IjXI1MRmJKiH0UToVwSWiWWBCntPQQdt8dI3lsGHqZfeU+YOOnJDC7zgaK/ijm6MwhtVGpqFjJbgV/KP8/Jv9xDhhT+i21BiFxQRMkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089890; c=relaxed/simple;
	bh=m5NWx1gVYZIUYmyzn/p7lEktd7eDSEgX54vgwJR8lWI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK9N6CCpcpnu47nlOyoEq83izer3g/ERAuv1o4uyZsHSNgW9KTlsWpbL1EgyLABa4yrz7M80V2Tb88zektT9/hY1HYi4EpTjPCmwvJHV1rRhXjfbsSx/AruUFh165kYdAAuREVk86zV7B+k7RduFoZra2gyVWtuznHEufaqH71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Df71+RvZ; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=gfzwzs63c5bwpbfaoak7hqxbra.protonmail; t=1706089879; x=1706349079;
	bh=YRa7ixpHW2IRUtx3lwsiscFSpJb9lfgyIi3waMTLXrU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Df71+RvZH7zmdy2/Swc3ITCEGjhIrt/qwW2f2MNWphXeuBkg5IEX46Y7+5/rKlt7w
	 64AN2ZHNAFyeks3ZGw2Gaf1O57pKfekYF4kLzz1aA1kxbixP6trCgNsd7vpNrNHuiO
	 ZKTQmWCJ6BT8za6WiycUJOdAAQTR8uWvVyMeP2dGLarLOAdrGTr0H+YhS0n6Y8m9eC
	 Tnx0jrX3mHKwKlbAxMpZsuVh0SKX0WlHdXmh1lXIjelnsCQ/j/ZcQyEAy2OLXFj+RI
	 NstMSLrMjrnY1Ey0mhOu5M2k1bvwtaAm5hbaaBfF0Q3CKxaTwaRmw7uNKiJO1W0I8O
	 OtBOh+HGXPNbA==
Date: Wed, 24 Jan 2024 09:51:11 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <efde6f59-2467-4645-8846-ab42214164fa@proton.me>
In-Reply-To: <CAH5fLgjKVQoTNZAJienaJpDrAPHoC+bAJdCzHsjjzme36h6wBw@mail.gmail.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-2-9694b6f9580c@google.com> <67a9f08d-d551-4238-b02d-f1c7af3780ae@proton.me> <CAH5fLgjKVQoTNZAJienaJpDrAPHoC+bAJdCzHsjjzme36h6wBw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.01.24 10:52, Alice Ryhl wrote:
> On Fri, Jan 19, 2024 at 10:37=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> On 1/18/24 15:36, Alice Ryhl wrote:
>>> +    /// Returns the effective UID of the given credential.
>>> +    pub fn euid(&self) -> bindings::kuid_t {
>>> +        // SAFETY: By the type invariant, we know that `self.0` is val=
id.
>>
>> Is `euid` an immutable property, or why does this memory access not race
>> with something?
>=20
> Yes. These properties are changed by replacing the credential, so the
> credentials themselves are immutable.

I see that's good to know, I think that should be mentioned
on the docs of `Credential`.

--=20
Cheers,
Benno



