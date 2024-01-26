Return-Path: <linux-kernel+bounces-40486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D1B83E178
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AE21F27538
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1620DE1;
	Fri, 26 Jan 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0bmZRqe"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6CE20DC1;
	Fri, 26 Jan 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293721; cv=none; b=P5nrGzutZOodiOyjrCDjDweFy2ENc6LzivGkF7e9wXggwDNpce3ANFCrue2Z4i4N4iQ5II4Uiv6hqUMmpt8WL6PcVEd45+46GmBPRa8P4pgcUnnpdi6O5ni/7d74o8BaJYqHeOwwacsoISVl/Ym8TKkGRrcwYm12QttezkqcBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293721; c=relaxed/simple;
	bh=L0TwXYIMoB8HCqmSCtCkj3CR+JfXJCSmsRJ6JcGCjeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPnx56fdV/XNE9x/ShIqEMPWs8R2sGJ/MbUffaWv1F5HKFi8mSlxt2+GKsjwjycRod0Ub3y431Z7GJ84YINAWFqs35trojGTBmC/7zUTr7QQ8tzI/C6mb5jMpdPgimWOx5qpXzJbEY5TAflSx2la1HV0mn8NO8enjUvd2KvSI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0bmZRqe; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68192840641so3398536d6.1;
        Fri, 26 Jan 2024 10:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706293719; x=1706898519; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YY5QdlvejuRuBjd73iKQnUzWXn5ClKcYIkPwTdN2etU=;
        b=M0bmZRqeJZxPxpm7wySFK7C8JKkBl5PDASMJuQy/Hz3xrOKWMa5nv/9PZS6FwY/zks
         NrjM35A3BFNIU652VFlI/hgntMpBPZZajSnGpaB04HTPzmZrToU1t794elg54wJgr1ID
         TFwvvj2ZSwMrNeKqbugH1HOOReSFMNGes+unnVLClFpTmagHCusLaYzHQT4kKljbmXtN
         +CLLCwRVegKjf74rzncRy3MNb8x4raWPdYEvnI9aUtxxxXuTD9MlwSQypy2gSkK5QZza
         OlCkfshrTuHX56fJAo+oaIAjO7RE3XGH1HXwg5RFVS8fJ8Ow63l5gfBmb8oh9VhVEKKu
         9eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293719; x=1706898519;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YY5QdlvejuRuBjd73iKQnUzWXn5ClKcYIkPwTdN2etU=;
        b=lvx/gNE0cTGvntan/GjTNzmPk/KW8V5Zw11nb6RCAWlZuEhg+OPDjTcYzkWSrvHLKA
         emrfxjoLPMITRAwBdpyNdQFfSYHzdbgGLoWyvfdUEkngAxmyICVvBchNPSjg0sob9kEl
         OX5B+Co3wESc29XNSODxeDg7x7wXf4hCndGKRG3RGdfMkjIuLQMYM/WSLiNlx/0+B/y0
         NtxR/noNaZIERCwEPGjzOMIHWbdEvnFidRflvSvF1QDW74Jw/usV9lMgIZTXfhXlJ4Gp
         dGDEvs1vAnUfOxYuYj+fGt/tDm+E+w/NsakM569fGOzA/NCBfnsU1me5lP0XrATVrbmu
         uvOQ==
X-Gm-Message-State: AOJu0YwM4MEvrQhKm+U27gEN3bcJ6+XdC9EKlJBnvp2SJTATad7/k/AN
	tQRkwBo5nfhCaFyjLuP0IF3DUXBXAN5UVkEqThtQpbBmPvOV5r81
X-Google-Smtp-Source: AGHT+IH6n0MtA82eUbR2NQcDtgBlhpzE7yRCW+imkMycfhL7GRpxWMd1iCD41JMC6ewE/4q76tUJKg==
X-Received: by 2002:a05:6214:1316:b0:68c:34b0:aa18 with SMTP id pn22-20020a056214131600b0068c34b0aa18mr310315qvb.119.1706293718885;
        Fri, 26 Jan 2024 10:28:38 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id vu2-20020a05620a560200b00783142f946bsm779300qkn.99.2024.01.26.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 10:28:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 710B227C0066;
	Fri, 26 Jan 2024 13:28:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 26 Jan 2024 13:28:37 -0500
X-ME-Sender: <xms:1PmzZUZFjZWnOUgej_8rakwX8AeStjjoclJwYJvnCeTyQjjziIgA5A>
    <xme:1PmzZfZ-4XHi5yBmWKcFPrXvY9LS0b-bj4rv9PdpM_49EDswjaG05pi0QW5OwYXVv
    KqhdzJHBDKZQNxbZA>
X-ME-Received: <xmr:1PmzZe9qPGu4kPZk-0HQJo0P2Ps-BPHryt5zgNnMgW2iUOrc3l6mKPPt7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:1PmzZeqtAwy3jZm_B0eXyVvPRy45sRdPZNz5lhy1nudh-PvuvwpdTQ>
    <xmx:1PmzZfoMzecFTa7H4Obfvn4RZPWn6NH6GXErmXGk6chHMU8gge7ehw>
    <xmx:1PmzZcS-VS9N7ejqHke9MjkObUi249SvxkALyA3P58sNySL3Cz7GgQ>
    <xmx:1fmzZYZ6XE_xMJeFRUJpDTQ3_WwcVdmoRuXtRqrRaBqQmOFVSIb5bw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 13:28:36 -0500 (EST)
Date: Fri, 26 Jan 2024 10:28:34 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
Message-ID: <ZbP50nEIMqULfVuj@Boquns-Mac-mini.home>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
 <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
 <CAH5fLgiNphSebaG82XkQHGFPFp1Mf1egyaiX6MFzsU2X3-Ni8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiNphSebaG82XkQHGFPFp1Mf1egyaiX6MFzsU2X3-Ni8w@mail.gmail.com>

On Fri, Jan 26, 2024 at 01:33:46PM +0100, Alice Ryhl wrote:
> On Fri, Jan 26, 2024 at 1:47 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> > > +    /// Maps the page and reads from it into the given buffer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// Callers must ensure that `dest` is valid for writing `len` bytes.
> > > +    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize) -> Result {
> > > +        self.with_pointer_into_page(offset, len, move |from_ptr| {
> > > +            // SAFETY: If `with_pointer_into_page` calls into this closure, then
> > > +            // it has performed a bounds check and guarantees that `from_ptr` is
> > > +            // valid for `len` bytes.
> > > +            unsafe { ptr::copy(from_ptr, dest, len) };
> > > +            Ok(())
> > > +        })
> > > +    }
> > > +
> > > +    /// Maps the page and writes into it from the given buffer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// Callers must ensure that `src` is valid for reading `len` bytes.
> > > +    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize) -> Result {
> >
> > Use a slice like type as `src` maybe? Then the function can be safe:
> >
> >         pub fn write<S: AsRef<[u8]>>(&self, src: S, offset: usize) -> Result
> >
> > Besides, since `Page` impl `Sync`, shouldn't this `write` and the
> > `fill_zero` be a `&mut self` function? Or make them both `unsafe`
> > because of potential race and add some safety requirement?
> 
> Ideally, we don't want data races with these methods to be UB. They

I understand that, but in the current code, you can write:

	CPU 0			CPU 1
	=====			=====

	page.write(src1, 0, 8);
				page.write(src2, 0, 8);

and it's a data race at kernel end. So my question is more how we can
prevent the UB ;-)

Regards,
Boqun

> could be mapped into the address space of a userspace process.
> 
> Alice

