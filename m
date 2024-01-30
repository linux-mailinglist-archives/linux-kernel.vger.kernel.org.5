Return-Path: <linux-kernel+bounces-45242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB5842D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6360B21137
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212071B3D;
	Tue, 30 Jan 2024 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNPvgPga"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8771B2A;
	Tue, 30 Jan 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645212; cv=none; b=IehqBLDH2yx8dwQfkzOPGiJNqdo19Imt23QhOeIUNPL9isYPzN8zQLA4iAdRBLD9XnvxOGO7JWIzntRZySq4BrdHuJ5zRJlLp8ve+K1CFaEW7EHPi9iNAADa6JKsgtvrFbQgwBE0+D6T/qXCYcvg1m14eXEq1uQxh4mh99UfkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645212; c=relaxed/simple;
	bh=G9OaR0GMf+4lWq/t/oaDuxd4nKkWm1wjxX3StkF/eNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCv7tKzAUEy46Rb6Wz303/t/GtPgAUKce5TSS7Qq7Ajv9rBb+bdFS7dDCUYfQizfnYrraCAc5o99TgSXN3hSN37Ws+4MkktCjXp85HQY6AdK9FCyC0YOrotDxbcr2KYce56MzypOYKme2VCU/nhs3Nm1aAGm5Q5DFrfZJGG4zjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNPvgPga; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c41c070efso1349576d6.0;
        Tue, 30 Jan 2024 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706645209; x=1707250009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J9W2L2Pq9xQtdL6IzEhGAdfnP5SCD+fFmXgNFPIUBY=;
        b=nNPvgPgawFPGVaUezKKX8ywWYZDH41dr6kxxSIYsFqiGS0Kjo98Qu2hfmc9rFOsNAu
         r8vbaBtef9Z0+3rB4QCc8JfcY9ZDnjrEFy/cql9sUviRMQqWMi09gBXp9+wKtPIO7tbO
         xi0XzD27f+MlnjJEVCMPWMdzWpAkvsd3zWMxHZRYlMt8Z1jSnzELOlNxh5mKnQ567KLe
         G6Oi0zZpt7RETV02V60O5TtFBUH9TJkQSaQmzWqGtH+plCU9jVVVpndlcMaWLKvGB8UX
         jDkJ4MJQwlKtGN1y5AtEpw98WykWr/BXFWIg+MBRwdG7iHfZt3Fn3CvTY2yHN4LzejzA
         rAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645209; x=1707250009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J9W2L2Pq9xQtdL6IzEhGAdfnP5SCD+fFmXgNFPIUBY=;
        b=ZNQ2Pcv+8ChQ5rHELBv/L03hfpuzvO7u/X4x/6ks9TXhdWfF6Itizqsk726ceQsHfR
         B9cIZkpbhssbADCWjmFxXqXPWfMyGmIlMIMNEDDLXxxrGIp8/4MawRFo4/KKLU0wosfn
         lWhkPeeNdAxdiX9g3u+qW+C+p0OA7hmErY2AQ8Eox7w7uP6UwJtf8zAN+JuQjEQUFdOD
         7PCxRZ9tHMa1t4X6hZy6SbkFxR9B59LCgk1wuht6tyrEmVMy5/RYhxXEe+vtxNIU43mY
         SXvkVDbhXDCfx/0dp48SKjpmk3H3GU1KKG0IMRW6PvIj5pOCI17FJXQA5G9j4VCMWAnD
         R2Mg==
X-Gm-Message-State: AOJu0Yxip8iYsUek8qBVNX1YvCIyt9rk7f+DEYTPnDPoJBnnDl2YHc9U
	rl8sHJtqFS6aJI5DNS/zKhfyMklWl+1H1OgwGJ6dlqWESPWdg5ch
X-Google-Smtp-Source: AGHT+IH2MTNpVka7bQiHrIl1PjqvTQ2P8nW1uyTMdxFcCm4DZaOo1hkx9sYCCPDCG0Hd6WH1TDrEVg==
X-Received: by 2002:ad4:5ce8:0:b0:68c:5583:a817 with SMTP id iv8-20020ad45ce8000000b0068c5583a817mr2936453qvb.53.1706645209611;
        Tue, 30 Jan 2024 12:06:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWyjqCoT6qtnIarANG5iAqVUHjkwYEDnpcShRSE9lPH74VPABpzNRl17IhMQXdYGFuogwfjf6U46/nwgQI25ahTfd84vAQ0VYPVvO4nBLYOMEWeOM4jgb2rMHgQ5rqj5e4cL4QkvDpZpRtN1mvkqqBE4nbpg8VM5L+d5VsemZ2CBhBzTf4lg+Z458UGax/SGXNiqvP6VRgkoM1ESEtZMG0+gGqeY5ZDtf2BkXwfjd5JEx1iKKC3jbC0F8C7fd3gsOHbo1obn9/szmZX+qPR600BG1K6v+McoTyFFAxy1mEgGyfEBfjJlDvPi1lkBEzCsZXB4szm1pw30i3p++brgOdlWFDwD0m58hnblbjg1lN/5YgFSjonH1pLhQ==
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g28-20020a05620a13dc00b00784046b7862sm1386630qkl.113.2024.01.30.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:06:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id A57A727C005B;
	Tue, 30 Jan 2024 15:06:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Jan 2024 15:06:48 -0500
X-ME-Sender: <xms:2Fa5ZRtdX57Ih5XdS3cj_jtpNea7VUIzD0z7kvRFCcLymElCTIIVqA>
    <xme:2Fa5ZacCG6Ov3nTKFZVHMBuwOiQm8_eu08sqZyupys-Ft4eJqvz6hYLzjDyKzAwAJ
    q-YIi5R4P4xORvs2w>
X-ME-Received: <xmr:2Fa5ZUyDNvKrol8EJiidxpGUyTApCKb2qTqRI3pwi8y9os1APc5qjPO1ZAE7dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtjedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtudffgeelfeehffekvdegtedugeduffefgfffhfdvkeeghfffhfehvdev
    ffekueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhthihpvghsrdhrshenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vg
X-ME-Proxy: <xmx:2Fa5ZYObH1KdyHvaSZKKQ9X6mQqJZo8aoOjUFRl9otjhxOFYQcfCjQ>
    <xmx:2Fa5ZR-tNJAJckhFNINsYV0JYre__ie6K7g_cPh3myptuKqXjbgWCg>
    <xmx:2Fa5ZYUscrXxQ7-cxKDz1Hmq51PnQZaCFRapeNGsjN0KNRQbCLhgFA>
    <xmx:2Fa5ZYVqMEEqnrfdMUKD1MLQZ0YgiLI17lvSJ2DEwfjhEC6HIa_AHA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 15:06:47 -0500 (EST)
Date: Tue, 30 Jan 2024 12:05:47 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Christina Quast <contact@christina-quast.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: prelude: add bit function
Message-ID: <ZblWm9hklyd71aaj@boqun-archlinux>
References: <20240130-rust-bit-v1-1-ed2ed6389a58@christina-quast.de>
 <CANeycqror72LmGW2NVL3+Yk+GAx+i-9FdS3GxNmW8sXxSeHFig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqror72LmGW2NVL3+Yk+GAx+i-9FdS3GxNmW8sXxSeHFig@mail.gmail.com>

On Tue, Jan 30, 2024 at 05:04:15PM -0300, Wedson Almeida Filho wrote:
> On Tue, 30 Jan 2024 at 16:48, Christina Quast
> <contact@christina-quast.de> wrote:
> >
> > In order to create masks easily, the define BIT() is used in C code.
> > This commit adds the same functionality to the rust kernel.
> 
> The `rust` branch has a generic `bit` function that allows the
> returned bit to be used with or converted to several numeric types.
> 
> https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/types.rs#L344

Plus, I think it's better to put the implementation at somewhere like:

	kernel::type::bitops

Of course, it's OK to prelude it, but we shouldn't put implementation in
prelude.rs

Regards,
Boqun

