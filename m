Return-Path: <linux-kernel+bounces-150728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51E8AA3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008D91F25AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD4181BB2;
	Thu, 18 Apr 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAFMVr1+"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C117BB2C;
	Thu, 18 Apr 2024 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713470506; cv=none; b=qX6IoLnLLKogXoZWDHW/Np31Hd4AIGbQrH/1g1odFjunQpRQMMNiC04GjgNpOHb3T//02PwnP1w5Z0V+AUJxsrv679B7yHfWm4SqHiPsJrFn4c6PoVZsJkgqNre5V/xbLtr0MKt5EdCPdXrfCNy0+kVjXr6O0t/w+0+bGulBcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713470506; c=relaxed/simple;
	bh=KCTidw9vRB31lBRexx3e+unentIUwTOohcO9L341OtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsK+qCY+gAY70Xm+pvJTxnPxNCvDydR41didthA4qgM48Qr3Rz8Oafeier1KIZW4UkzkhPg+ij5+m41lIGrTMxQ6obhZBFf8zeBgsrQ3dgP84oOY0udxS46QR5Az6ESjT4wWW0NyHgWvRBOu9usELP+p46o2q+IvPSYUV+skt+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAFMVr1+; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69629b4ae2bso10852726d6.3;
        Thu, 18 Apr 2024 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713470504; x=1714075304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p5U2uM1qAfDBe46uPOXJfDBT1BwgCpqdYnUA213Koas=;
        b=GAFMVr1+56KkT2ugTlj3b3Wk+wJ8bgxz2MJBRUZq4liMOCIjvk9X5aVrpqmawoVYyi
         X7u7vVoV6hhdLPLgRXIvvvk+yCbfyzgZZ5bvJP3Nt694Uzh0xCryISuSWYlmzFSzcuZ6
         ukyWR+++/x+wECl1BVOQC21LQXwbDARFvrX2st9QidieK770WdznYSRpv6bjlxbliUjF
         /i+AxmKju5EsM1DM6f0xJn2bu0cEsAm2frg1HoHbdclAikwKlAZLjrSlM9mpFHE5S47H
         IspA1Ce99vw30tk9q3xzq85Gj9YFpbBJoMYlvZSmSaMWveGcj0Rtjc+JMdch/yHa1ywK
         CtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713470504; x=1714075304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5U2uM1qAfDBe46uPOXJfDBT1BwgCpqdYnUA213Koas=;
        b=SEpFXmSnkGNLaL6wFY2ESqRBLrN+eVvLsJk4XvLMbugCDUsG8AlpzguwWgxeGjR6tn
         FZ9g9F8tCVuZ2OUZtwms1RuyCZM+CvdV1pBqfRQciEld7mCgM1BRA5b2CI703di6i0SY
         KenAcs4U+TvXVFOWQgUDAepWBNdmM0LDmW6By0G6lyzH6wgyoS3+oduD1CYYJ3OZz1Zp
         29n4yI3h9Qp/gZGICU2TtaLphg1+6fbcGKy6eQjR022t4cXIGHtp9YEjKXB2uhxJisZy
         1tb/wUz+kyVqNtnyrVwD+QO8+kH3XWDW6Yi8+fJ9iJmSgVTBYw6xL2W1BkCdfp4KJPRR
         6/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4eIKv+PL6t82zsTumM3rEhvetI/QJFgZlpx2Li0h9uIo1OoXNwGKMynsTWEgfGN05cYm8OKTKoBrv1iGv379NeHjBUZrLOX2cZu3pNMlHqcasGdk/2j3BE5OdUnCKZvnrOOC/TWnAcO9q5tI=
X-Gm-Message-State: AOJu0YxmkKpugxz5LGRjb+N4xWSCr5kVVvOzUdiTBR+AurZrlHAGlhPV
	dgmR4EuUo1itN+7Rhmj0MGP1BX2QhbpmBP5p/WziZtgStn9HWCwa
X-Google-Smtp-Source: AGHT+IHHWzl1+nKVAwM7dNU7DNh/vXCt5ExjFummesJ4M9MCAmCraD0SqGCzuz7G5x0biMnpsT/nZw==
X-Received: by 2002:a05:6214:705:b0:69b:5576:49e7 with SMTP id c5-20020a056214070500b0069b557649e7mr40348qvz.45.1713470504285;
        Thu, 18 Apr 2024 13:01:44 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id w19-20020a0562140b3300b006a056736f10sm751933qvj.25.2024.04.18.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:01:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8DDF81200066;
	Thu, 18 Apr 2024 16:01:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 16:01:42 -0400
X-ME-Sender: <xms:JnwhZo6JFcXmaecT5V0xbj5igWyagTF6kv_Uvz5gC0YCjaZsSCH9wA>
    <xme:JnwhZp5Bn34z62aCWy1G820w1GzX7lqlSkp01FtiL9gs9aEz9XyIUm4b3LajeHmI_
    JdkZkuiKXqZbANUaQ>
X-ME-Received: <xmr:JnwhZnc8y3cQapL7gFvURoAr-p9nwtOgyztreTz3QVFvIeqsHXIVpvxsoPNPVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:JnwhZtIUc86mAUXKYgWqus_QUbqhxqhufDLM7O-NzrAJPZBT7jIIWQ>
    <xmx:JnwhZsJNkNVm1P_qOMK6mhFMEXaU7xA4tImED-Cb4tBiLvroQ9gWXw>
    <xmx:JnwhZuwDDAAnSYQ--k3pIOMLRYNSdhjFrPoJVV3oQEDmEMK_pHsGTQ>
    <xmx:JnwhZgJF0YgP5FtgWbmqaa6sl7QXXu8hiLAbmUlclPtqFvvCc3yDHQ>
    <xmx:JnwhZrb6oqd_5XldUxQBEsqTShozsedmuUzXrl3ibZG9_ou5fcBF8AKa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 16:01:41 -0400 (EDT)
Date: Thu, 18 Apr 2024 13:01:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace
 pointers
Message-ID: <ZiF8DcuGw1KgD4Tz@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com>
 <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me>
 <CAH5fLgiMLxmmm0AVX_5HQF61FzzN69GCKabrr-uM_oV-rRMuHw@mail.gmail.com>
 <c6239407-8410-49e2-a8a1-16be8468ab88@proton.me>
 <ZiFWIFMSBbU0i8JF@boqun-archlinux>
 <CAH5fLghTqbK-b4z_GJYJF9PFj8JkkKE+dNNpELFZspC2o9Oa1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghTqbK-b4z_GJYJF9PFj8JkkKE+dNNpELFZspC2o9Oa1A@mail.gmail.com>

On Thu, Apr 18, 2024 at 09:35:53PM +0200, Alice Ryhl wrote:
> On Thu, Apr 18, 2024 at 7:27 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 04:23:06PM +0000, Benno Lossin wrote:
> > > On 18.04.24 15:17, Alice Ryhl wrote:
> > > > On Thu, Apr 18, 2024 at 3:02 PM Benno Lossin <benno.lossin@proton.me> wrote:
> > > >>
> > > >> On 18.04.24 10:59, Alice Ryhl wrote:
> > > >>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > > >>> index 8fad61268465..9c57c6c75553 100644
> > > >>> --- a/rust/kernel/types.rs
> > > >>> +++ b/rust/kernel/types.rs
> > > >>> @@ -409,3 +409,67 @@ pub enum Either<L, R> {
> > > >>>       /// Constructs an instance of [`Either`] containing a value of type `R`.
> > > >>>       Right(R),
> > > >>>   }
> > > >>> +
> > > >>> +/// Types for which any bit pattern is valid.
> > > >>> +///
> > > >>> +/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
> > > >>> +/// reading arbitrary bytes into something that contains a `bool` is not okay.
> > > >>> +///
> > > >>> +/// It's okay for the type to have padding, as initializing those bytes has no effect.
> > > >>> +///
> > > >>> +/// # Safety
> > > >>> +///
> > > >>> +/// All bit-patterns must be valid for this type. This type must not have interior mutability.
> > > >>
> > > >> What is the reason for disallowing interior mutability here? I agree
> > > >> that it is necessary for `AsBytes`, but I don't think we need it here.
> >
> > Hmm.. technically, if the interior mutability behaves in a way that each
> > byte is still initialized during the modification, then it should be
> > fine for `AsBytes`, for example and `AtomicI32` (implemented by asm
> > blocks)? Not making any change suggestion, just checking my understand.
> 
> No, that's UB. When the type is not interior mutable, then any two
> loads from the same immutable reference may be assumed to return the
> same value. Changing it with an atomic would violate that since the
> value changes.
> 

Oh, that makes sense! Thanks!

Regards,
Boqun

> Alice

