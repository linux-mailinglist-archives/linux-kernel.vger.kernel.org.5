Return-Path: <linux-kernel+bounces-111701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E7C886FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669CC1C226F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA27524DF;
	Fri, 22 Mar 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrnAdmDh"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E14D137;
	Fri, 22 Mar 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121148; cv=none; b=qQbCAKcKopUCufIPa1CysauU9lNL0x+A2K40W2kYthdmDgWxrZ2cvJHmDcB+EYyzdXL10ZZIFKlB2uABqzARB6YYakpltcKbzQmlhBO5Ih8x5tqCXTlUO/H7gAoJ1HglrtQmjdaltpUmH3qmF9hg9OM+KPhYoWbmnQP4/vZEklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121148; c=relaxed/simple;
	bh=6bSwHxIng+Vkb43xeUl9q3Lz9EPeHyyRDC+bhUpmH/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQQHYgi+gz6P3lyBbxUGdkfqGeK7gimQkwcMShlmSuSPtkf9+pcgkmy7z6JRLnhve7a1I7+bkJVmTUE8h/rV/3z3a5oHS7zTBGM/VlrOKDm5CTOr2WrfWF+kzvbzmrH3m2/l6a/1xxNlVt+ARa8cF5y8CKijQRHGLuU8KJPESfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrnAdmDh; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69625f89aa2so19039086d6.3;
        Fri, 22 Mar 2024 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711121145; x=1711725945; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mIOmF60Rb86w4+w2jglrFD/Lg9na+Rxq9LbforhHtzA=;
        b=hrnAdmDhbgbKprzwTelemHfNYjrBXVgGj7Ud/kz4F6PBRSlcXhJ3FrBPo2eqVZ12ff
         8CnnJc6jnAsKCLr3CSDt+vnHhWCCJd8PMjsikMgqYfDBCAu0NtXv7LhrNfiFbsuDaEWt
         dzqPItL71AFaK9WbHa/1WvEqaQYojyC68N3Yyt4bBRCh72WmPGT8kxQy2obA8cd3AbXK
         uZpbWHr/d4XLSC+jOxe+Cj62RL9ULG1z2IQJftfjzrnlYBp7PbD3gQ9OhRzXe2Surxbe
         cNfi4jcAf+hur61egNefZVcrKFBkYbMWnVrV6tU/G6+jrZ7+m+OK4OHQ9oTAdqfrqORO
         5MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711121145; x=1711725945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIOmF60Rb86w4+w2jglrFD/Lg9na+Rxq9LbforhHtzA=;
        b=Xjm+wDMwF1UrywjQM6Wux9mc6vxmuGqXhae4Ez0GP/UCBi9FchwuTabP6pW0EJ9K70
         bcMHX7HWfPt2nU6aEd6Ve9+bFLYxunVEz8jDTheP+ff2rnpcRgZ1lmvAaHOlfAxeAB0L
         BE4ygpGWFr3pFrBBbZBtyO2n2jAw2KcTDCD88NsZ6D6dUby9K0e2wi2XdqiY4N+//DMx
         46Dckqk7V9DkU4MiuL0FPzSrbDzysyMRcHNlqD62EXLFhAFXbO2VMNctnC7SOPEvmaQU
         qYMJst1xT/DV4s0MJi69vHmE3jDTkEAZhpzDQjOHrBNN0s+bVXua8gwJjRteQEPDoRWc
         /80g==
X-Forwarded-Encrypted: i=1; AJvYcCXrviLEEdzHjssPyKcqTtyGTQgWFn29klvp3l0keN9Z3KH/q/Btux9o2Qrcq6QBOY6P63J756js4zhs8njHKiheDIFVXnuq+MXFBezDYJ0pJxMQkXp24095kfoLwRZRAu+oOgtmvrNg93n3Zcs=
X-Gm-Message-State: AOJu0Yy1w/NOo3jcaY3yt3trI1z13Ensk0mWFyH4OUlZwdoJZRux/17z
	0xhKmJ9TWE91MnYu2LZflF6k5IJ0v1sVatSHAjiLPjYaQQsLGTjA
X-Google-Smtp-Source: AGHT+IFnlML4ohoPgPDicvWsIiY1t2T6pp5KwtLN525HMHWY25ipqB4MVXRUzZr8pYr9PPFBpmPuyw==
X-Received: by 2002:a05:6214:4008:b0:690:d5bc:c20a with SMTP id kd8-20020a056214400800b00690d5bcc20amr2053886qvb.4.1711121144929;
        Fri, 22 Mar 2024 08:25:44 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id fq9-20020a056214258900b00690d5310c55sm1157262qvb.114.2024.03.22.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:25:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B39911200066;
	Fri, 22 Mar 2024 11:25:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 22 Mar 2024 11:25:43 -0400
X-ME-Sender: <xms:96L9ZUKTBiCr37awcUW1cf7r32NFIEDQwPnx_nL6bZ3t2pMYUpoQuA>
    <xme:96L9ZUIb6M_aYVnhJZB3SG_dNvqB1APsI3oyLdzRcQUK7UbhktTPGZobVtZ69uLB5
    eKxwTfMQmiNhTALIw>
X-ME-Received: <xmr:96L9ZUs_iWI_ueKMU5cj82sF8ONElx_a53BI61W-u3R-y-OJeYd3Wpr4eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepfedtvdfgudfftdfffeejvdegtddvvdfhkedugfegkeeftdffledtueet
    gfevkeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:96L9ZRbBVOuMA-j3nRVng3_OH5kzRafpoxb8WS2Xu3GU_JOKx1fgag>
    <xmx:96L9Zba-G6mksvz1gZp5JrYGkucn1zFBrFOcVcKzaymyXwfM_XetDA>
    <xmx:96L9ZdBT1hIaTy4GkC10fTi2iC6QDBUm8woQ1YH_ye2m7ihPtYUwNw>
    <xmx:96L9ZRYh7Kq4WX2nzjMc-QtZQeVFC9a8XlfZHFWfRYusn0SklKH6qw>
    <xmx:96L9ZRyyR25zP4ANe3ih00oH6MxJ4SnTNcRTJyBs-VsmLZXd7f4zxuYTIMA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 11:25:42 -0400 (EDT)
Date: Fri, 22 Mar 2024 08:25:40 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: time: add Ktime
Message-ID: <Zf2i9JJO7gmlhl_K@tardis>
References: <20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com>
 <ZfsBADaYHz1FG8ie@Boquns-Mac-mini.home>
 <CAH5fLgjd0hJzHbwM3bMZ9DUvDZ0OSf-btnebN0UG9GE9gKFfGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAH5fLgjd0hJzHbwM3bMZ9DUvDZ0OSf-btnebN0UG9GE9gKFfGA@mail.gmail.com>

On Fri, Mar 22, 2024 at 08:50:18AM +0100, Alice Ryhl wrote:
> On Wed, Mar 20, 2024 at 4:30=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
> >
> > Hi,
> >
> > On Wed, Mar 20, 2024 at 10:08:45AM +0000, Alice Ryhl wrote:
> > > Introduce a wrapper around `ktime_t` with a few different useful
> > > methods.
> > >
> > > Rust Binder will use these bindings to compute how many milliseconds a
> > > transaction has been active for when dumping the current state of the
> > > Binder driver. This replicates the logic in C Binder [1].
> > >
> >
> > I wonder whether Lina's previous patch also works for your case?
> >
> >         https://lore.kernel.org/rust-for-linux/20230714-rust-time-v2-1-=
f5aed84218c4@asahilina.net/
> >
> > You don't need to implement all the `Clock`s since you only need
> > MONOTONIC time. But maybe `Duration::as_nanos` and `Duration::as_millis`
> > return `u128` is problematic?
>=20
> It would work for me too, but adds more than what I need. As for
> `u128`, I don't really know what the status on that is. I need to be
> able to print it as a base-10 integer.
>=20
> Adding an API with separate types that distinguish between Instant and
> Duration and different clock sources so that you don't mix them up is
> reasonable, but a bit overkill for my needs. I am spending enough API
> design cycles on my uaccess, file, and linked list patchsets. Someone

I totally understand that! But the requirement was brought up a while
ago by Thomas:

	https://lore.kernel.org/rust-for-linux/87h6vfnh0f.ffs@tglx/

> else can submit patches to add a more well-typed time API in the
> future.
>=20

Would it work, if I create a new patch based on yours? The work for me
won't be too much since you, Lina and Heghedus already did the hard work
along with some feedback from Thomas.

Regards,
Boqun

> Alice

