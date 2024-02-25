Return-Path: <linux-kernel+bounces-80261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37F862CAF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDEE1C21093
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F271B597;
	Sun, 25 Feb 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzoYYkPc"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A618AE0;
	Sun, 25 Feb 2024 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708891040; cv=none; b=f5Q/MpRZOLAgo/bo9+fQjLmnonFI8NBRlho/ORYre2CNQql5Tvb7zzEGV5aW6L1QVyReATSJWDjASEoiewfDTEO2TScHAJLEeH600uPqziECThqvozLYwVASz/DRLy8dY+Mci1PRuMD4+yGt7XKQghIbChTLKpFEuMu/lrLgacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708891040; c=relaxed/simple;
	bh=G1jXVbuSlQNeMx0BMysB4STmJo2Cc7LPE8Y6IOgNyQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBmIHA+76Ga9sSq9SQdD9h9LGwpzpcXP5//DvZV0ts8N/2SqUgmHXOB8u55pZI5xtx0aemo7aIST9IrXBRGyclT3tXsnDNTJ9W0Dg7VEjBfOXFnlqWsnU7AzcgaYcqZ2QrZ/RFsMBdzH+hTQCH+2CBbcMaRGSZhAXgGrXoizH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzoYYkPc; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68f41af71ebso28307916d6.1;
        Sun, 25 Feb 2024 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708891038; x=1709495838; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aRzFldjUJKdTod/xnCItYpt36dOpLR4cNre62s36xqo=;
        b=ZzoYYkPch94V/NrOKyomioH6VhKwjRohNH61ZU/Gh2qr4hBH4GaG06ZiZ0FuoZ9Le7
         5u8Hf0KQIbhK2M6pFRt+ohUf3US9HkHQUKPnNHHP6q/xYsdesWHu9n5BBMulQ7LwUR1w
         tU0A6Gbveonzwla/ZQtXzINHuZczsR8cJt+apCrUO2PTCEt6XhkcKXZ7FQd64a6kHvUX
         wZUV12gfsNrPfo2p1z/5PkG+H6gZvGqLIubGKTN1Vy0ZrCf5dZts4Js5gtYEOSp4oZrU
         WUSNu7m3vMwGq32e4O8a+nUGmUhIEfbxHfTQ6jBjr+Hl3AQsWt7lt7Ir0UtMFBMSalJf
         FSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708891038; x=1709495838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRzFldjUJKdTod/xnCItYpt36dOpLR4cNre62s36xqo=;
        b=v06FlqQ4Gw3A4jzGUdQzMcJPsLk/wbV/M5xBsqJjT3UCUeBCU1BcvonFRytjMrLFG1
         IdE+C+PzQUAcW53p0/9y3XLWA/EMISDkd+7RnlSew4tyQebsCdfIvJ/A/5D8Mutx9nG8
         bv0ko9dsGysRgERHg6korlC4ig4BZr5h18Lhf/l3U5MpuUc0FymU5JglL+EYKl1ND7+0
         OxijyfZQ9XYmYm5pHnUMek1D9HYA2YTshL0xOkPSneF17ahHjMVctepwu/RVmf6oddBs
         Q1p50+8OnNGmfgjuf/tt3hu2CsXmJh6CD3wlo9TfQlyjxkaU+/e68FgBZUuWEM5EwiJv
         10kA==
X-Forwarded-Encrypted: i=1; AJvYcCXIe9HyoYtJ7Ag+SpQ1HPOh9jSRFpAR/2GGRFqAad7qW/yvLnv65baxqVssMba8lry1Vfpl/SYx8IBpoIOM9269eNHZmDpXPL5L2/o5wruKhCGDvx1GePhJrDcMkGO8qnOmHSZNgaeNOoRVq4s=
X-Gm-Message-State: AOJu0Yz9aFNsmGRv3W2ZZpcqT97PcheYzcLLJT9ZiEzYDoNjbrKjF7ol
	Zk/i/dtD3yrooDRe8JAcqYeU+rCFzyJUYblF1fRvR6OrWC44eW4E
X-Google-Smtp-Source: AGHT+IHi6wRItoFxuKuOj164moQGZtEKP/ayHNGCnd8LA9zFwvglqD1tJT4xk/KYeGyQkqeec4ojdA==
X-Received: by 2002:a0c:ab58:0:b0:68f:ba43:2e6f with SMTP id i24-20020a0cab58000000b0068fba432e6fmr5963612qvb.42.1708891038359;
        Sun, 25 Feb 2024 11:57:18 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id qm12-20020a056214568c00b0068f11bec5desm2049853qvb.78.2024.02.25.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 11:57:17 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 34E951200043;
	Sun, 25 Feb 2024 14:57:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 25 Feb 2024 14:57:17 -0500
X-ME-Sender: <xms:nJvbZSuCb-UE-baonGsINSEEiOrtJEFD3VWvI8xCloYmXQbCtMyQKQ>
    <xme:nJvbZXcqB3EAGONm20jEfgV5BU21Kw_TtZy0V4vAUH8X1WSKWG4RIRLayEvvywDhk
    tOe5_G3EYZnF7DeJw>
X-ME-Received: <xmr:nJvbZdxWSN-FvR7Ieka-O1BUBaQrg9fyMlalzVK6waXKIGO721b2qOVhnHNP5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedtgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:nJvbZdMPii_LXXc1k0V36kPckEC5W2-6jvxsqEEnHD-Dn1Ft4bcD4Q>
    <xmx:nJvbZS8TyBQ-l8hQ3INn-DjKpUlEERzKQU-O6fgSO3XEBmP92MMB-g>
    <xmx:nJvbZVUBp4w9rFLvkP7EuBADhg4LIdRw9HXA4Y4NhQr6sEuNMmjfdQ>
    <xmx:nZvbZVUThL0M0iqf_6lFPqJCRdAIO1Bi2a9FKXU8jVZ-E31T166nMScNnj0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Feb 2024 14:57:16 -0500 (EST)
Date: Sun, 25 Feb 2024 11:56:42 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathys Gasnier <mathys35.gasnier@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: locks: Add `get_mut` method to `Lock`
Message-ID: <Zdubehd0Qsr96dgq@boqun-archlinux>
References: <20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com>
 <ZdgIVxrwBfTEjuEe@boqun-archlinux>
 <CAH5fLgj8g1d47u0eFD83topKg2d7FEG+cHS5+Be6+TLt06NmHg@mail.gmail.com>
 <CAAZKF4B_YKZg+S=e7jnWDvcKJOXEJ_E0MRNmzEzEa013XZrYzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAZKF4B_YKZg+S=e7jnWDvcKJOXEJ_E0MRNmzEzEa013XZrYzw@mail.gmail.com>

On Sun, Feb 25, 2024 at 10:21:23AM +0100, Mathys Gasnier wrote:
> Should i include this comment in this patch ?
> 

My suggestion is 1) in the comment of the `get_mut()` function, mention
that "`data` is not structurally pinned, so return a `&mut T` here" and
2) in the function body of `get_mut()`, at the safety comments, you only
need to put the reasoning explaining that `self` wouldn't get moved via
the return value of `self.get_unchecked_mut()`.

With these (along with the period and newline added), it'll be good to
me.

Regards,
Boqun

> Le ven. 23 févr. 2024 à 11:49, Alice Ryhl <aliceryhl@google.com> a écrit :
> 
> > On Fri, Feb 23, 2024 at 3:52 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > BTW, while we are at it, I think we should document the
> > > "structural/non-structural pinning" design decisions somewhere, for
> > > example in the struct definition:
> > >
> > >         #[pin_data]
> > >         pub struct Lock<T: ?Sized, B: Backend> {
> > >             ...
> > >             /// The data protected by the lock.
> > >             /// This field is non-structural pinned.
> > >             pub(crate) data: UnsafeCell<T>,
> > >         }
> > >
> > > Thoughts? Or do we think "non-structural pinned" should be the default
> > > case so no need to document it? I want to have a clear document for each
> > > field to avoid the accidental "everyone forgets what's the decision
> > > here" ;-)
> >
> > I would normally assume that "field is not marked #[pin]" implies that
> > it's not structurally pinned. But it could still be worth to call out
> > here.
> >
> > I prefer the wording "not structurally pinnned" over "non-structural
> > pinned".
> >
> > Alice
> >

