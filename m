Return-Path: <linux-kernel+bounces-150569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E98AA10C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A001F22822
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F62174EED;
	Thu, 18 Apr 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg0GAjAm"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37B172790;
	Thu, 18 Apr 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461228; cv=none; b=ahjXVxWmlThKI5qQPgHz2u1eGhs32VIrnBBGTgCc8p61j8INWN95jzb81zWUzdivTtk0t0/+FHWq8GvsYwiY6PD+6xmMLy8SBlDYOXeRko7dIVsrUfRmBCWI0DYAaHyHFXjfu6CX1B6VvkisLuOZP6FAM5XmyU+NauiEe2Ecu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461228; c=relaxed/simple;
	bh=rP0Xkz7LY/9paQcIY9KIgH2ieBP45u1ZxnYsJw7BSs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcFbfS+FM/cKCeGYRppAbmiaaRwHe4AmhwCJ1Mt1rqlhGJiChBmcStW3k61+UkuGL0Hcnffr9Pf1iOGPerWnS2RJr/7rqT3Sk0WfEuY7mQ3rTMoVQtZNCkpK42Y08P9WwvFXNvXqvI3B+yhUl9OaObGGMyKV+0NBatS6HGafEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg0GAjAm; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78f049ddd7dso74104485a.1;
        Thu, 18 Apr 2024 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713461226; x=1714066026; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lKzOdELtr17UxT9sbgBt88s9IxuTCx7orfaIApRzVA8=;
        b=lg0GAjAmQzQeMPryoqa2Sa0BbFcbTt82hSNl50zMplaIioPdXtyGzEN2IW7/7Q4Cu/
         eXcyyhcSC80o2bzYHEDAfaZQVHRHS9QyYht6VkHKeYPm52Qijl2LVjeXLUBDIEBcTqIj
         /nbr8KGa3eYTG+XCe0wbT45pMoKyFojnxNuQEl0t61/lmd2/3vrhDbJXRAsJh43CO4i1
         lw/m0Ydx5QSd5MjL9r7jJPipATkiEDPss9S3dKG81LtZKG2nTofx8DAEg/+phQzmghD6
         u3Fwv+wXC8xVPtSxIuaEjobcKOE1ky/NT6+g8ajqETrLe6D3DJju5xMh/uU5Sy86ZYz2
         odaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713461226; x=1714066026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKzOdELtr17UxT9sbgBt88s9IxuTCx7orfaIApRzVA8=;
        b=RvhAH5ie6MqzarIigxopb44VbcPdnfBIatZvDoLW6UOt8BOBLia8vLsVwImwR8mNsS
         zTM3IyeAy5z/HDP/sGdJy9lhFn52L8YrpU5ylMdpJs/GgAqTvD3dbFQ2KNYXc8HpjgN+
         rMCbuQz0xKycxbKqfefxnIhyixnHOhTuZmVkuHVYSi0ajLliRdOaP9Cv9kz9VFFKihKI
         /LOPF3ng+cCOA5ngfCvqkdeoxtwgzMxOA2L6D6h0N9fijtNmEDlwRUSo/rD7GD1lH9t/
         iyBeCODRtBYeJqVHmvbvSfkekJlsh+8gyLbQOL5xFSsR8aAGIGYbxQnDHowEb3IznFdF
         QyRg==
X-Forwarded-Encrypted: i=1; AJvYcCXGvKE+C3ykYg+W2kcLiUooISvfeCfhV1eVji+TQZjj85AsDndw+bypDWVn1uFTki3XBaBEyHPgjsntaOEPtwKk/7aAYQ5wI5G8y259i5T1q2riB1/m+smMnUQWjbtB3t2ZHcyrVCq98srEgvU=
X-Gm-Message-State: AOJu0YxCRbTLYC7Dzlab6p0AyKMQen49vGs7+tNsyzgVb6AJ5WFRmJhx
	HDuVWEN0VrqUuRg0q5tP15/E6LUIoPP9ZiPU7XPWB5yK7p8xFQLZ
X-Google-Smtp-Source: AGHT+IEyP13rku9EoBhl3GBbdeEvkFMwjRN2G8cKqPKJDutUNj7zCLBRGGi8Q5ZNqInv4TdRcVurtw==
X-Received: by 2002:a05:6214:b05:b0:6a0:583b:8cc5 with SMTP id u5-20020a0562140b0500b006a0583b8cc5mr1986476qvj.33.1713461226239;
        Thu, 18 Apr 2024 10:27:06 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d27-20020a0caa1b000000b0069b1db7b0f8sm819856qvb.23.2024.04.18.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:27:05 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id EEB73120007D;
	Thu, 18 Apr 2024 13:19:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 13:19:52 -0400
X-ME-Sender: <xms:OFYhZoPVSGZr4ThZoIZ-o8InQS79beav4r0k2k2VvyRWYlKC4jacpQ>
    <xme:OFYhZu-2kLOiTCv3xz8gwRBYI_xIyVYcr2IfMJHq-AkJent6R8LIS8BA-GieNR1s9
    uAl4n-ReCbxX3z0zA>
X-ME-Received: <xmr:OFYhZvT1rFYbaA-BETvn9NP-8lkDvKYrbcEsKzN6FejMnvA4Z2WEroQkizbuhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:OFYhZgtdceZ7od9uw63rtZ8CY7Dl3E6h2fpD7GOpMBjjJxT56m49hg>
    <xmx:OFYhZgdERIQaB_Lbi4DH4osqkOv0rpAgOytWR8rTKFZEprMzYjP1qA>
    <xmx:OFYhZk3die_i5r4BHdy1zVIIf4Wb2Z5HqhuU_gg9t4NfKWbGCPFurA>
    <xmx:OFYhZk_5HxYH4MVHXayPgfbTl2Jzj3dkfO0ymJ18tTtYUrgbUc5bVw>
    <xmx:OFYhZn_tHoWAw4caBBPumKl71b-rQK3jJpUPzua1q-GlJGkIgN6xy9-U>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 13:19:52 -0400 (EDT)
Date: Thu, 18 Apr 2024 10:19:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <ZiFWIFMSBbU0i8JF@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com>
 <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me>
 <CAH5fLgiMLxmmm0AVX_5HQF61FzzN69GCKabrr-uM_oV-rRMuHw@mail.gmail.com>
 <c6239407-8410-49e2-a8a1-16be8468ab88@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6239407-8410-49e2-a8a1-16be8468ab88@proton.me>

On Thu, Apr 18, 2024 at 04:23:06PM +0000, Benno Lossin wrote:
> On 18.04.24 15:17, Alice Ryhl wrote:
> > On Thu, Apr 18, 2024 at 3:02 PM Benno Lossin <benno.lossin@proton.me> wrote:
> >>
> >> On 18.04.24 10:59, Alice Ryhl wrote:
> >>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> >>> index 8fad61268465..9c57c6c75553 100644
> >>> --- a/rust/kernel/types.rs
> >>> +++ b/rust/kernel/types.rs
> >>> @@ -409,3 +409,67 @@ pub enum Either<L, R> {
> >>>       /// Constructs an instance of [`Either`] containing a value of type `R`.
> >>>       Right(R),
> >>>   }
> >>> +
> >>> +/// Types for which any bit pattern is valid.
> >>> +///
> >>> +/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
> >>> +/// reading arbitrary bytes into something that contains a `bool` is not okay.
> >>> +///
> >>> +/// It's okay for the type to have padding, as initializing those bytes has no effect.
> >>> +///
> >>> +/// # Safety
> >>> +///
> >>> +/// All bit-patterns must be valid for this type. This type must not have interior mutability.
> >>
> >> What is the reason for disallowing interior mutability here? I agree
> >> that it is necessary for `AsBytes`, but I don't think we need it here.

Hmm.. technically, if the interior mutability behaves in a way that each
byte is still initialized during the modification, then it should be
fine for `AsBytes`, for example and `AtomicI32` (implemented by asm
blocks)? Not making any change suggestion, just checking my understand.

Regards,
Boqun

> >> For example it is fine to convert `u8` to `UnsafeCell<u8>`. Niches also
> >> should not be a problem, since eg `Option<UnsafeCell<NonNull<u8>>>`
> >> already fails the "All bit-patterns must be valid for this type".
> > 
> > If T: FromBytes allows transmuting &[u8; size_of::<T>] into &T, then
> > it would be a problem as you could then use it to modify the original
> > &[u8].
> 
> Ahh that makes a lot of sense.
> 
> -- 
> Cheers,
> Benno
> 
> 

