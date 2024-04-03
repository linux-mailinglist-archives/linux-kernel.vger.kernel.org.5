Return-Path: <linux-kernel+bounces-130614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF86897A92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6981C245F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E3156864;
	Wed,  3 Apr 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGMQG/4V"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F512C683;
	Wed,  3 Apr 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179293; cv=none; b=kSW1PJeuaxszeO8Zdg8BlfyUUV0VrLYfagoMu95oj+o3IJLjrijieHhLTg99glfxj4gLIGYbBKflv7PMtb91dIVKVWCIt/VE4pqbLWfGtkdVoja0PxTOAmX1y7eCaluBuP9HyfI4PE44MJuYtrDVbV6bXKfctyFOBPx0xpddzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179293; c=relaxed/simple;
	bh=pHedwJ02tuqxgOwaae637BdCbJIBZjwoubdKjUsH4nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STTNhf0KhCHQFpfJ1nU7csMn6KNk4NF3YeOj4bahktkixKtK4DuNiBQdnt+a0Xu09yHOSr9AKgLHFusrBzPRqs0XDp/P1/VzCU6eaPih78sOpzS/o7AxkgXIh0Df6gH4XHUSAIIXq+DZO+Ytzcv27+RzBoSByMLpNMoJXe1jx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGMQG/4V; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c3e67fd552so108086b6e.3;
        Wed, 03 Apr 2024 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712179290; x=1712784090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmpB/z2gJc3FNiFKYDU+JCxW+LpIlT5gVHp7aI7deT4=;
        b=OGMQG/4VaOsBGrgKqAu0AO666+3KzNF2DuzNBKOqvBxYJAZefqwFuZu0jUJdtoky+A
         2wYgyGKtJs4FkTi3lSLyr4vlHTNL4uDQjJzFpku5tFy/zZhWIi08KaV9PIAwWt4N+GD1
         xzO/k7d/cAsDCgy+PMVTcOoPL9ykpXHqeo2eNoasfOZaBSuMhABXvWO4fHBtsYWlYSsl
         cDSH871DTzU+j9lXhkf52qmhF7Y72F0nnb6oZXXRYNfabQOxcRZlWjxGJ/jxXh/dWlc3
         ErCQ/ihbfNMM4I6UmU6uPO2aEtP0BoQfcYSVZKlQBbOD4VjIsssh1x2GZ3DXTh3aOnJj
         DLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712179290; x=1712784090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmpB/z2gJc3FNiFKYDU+JCxW+LpIlT5gVHp7aI7deT4=;
        b=Ddl5utxENBI9oUvT1sZYJh3dwccMEM+iaraGpUJHSlaNDr9yVpXxpp3PwhOD82xUpy
         kSmOF+4vBaVNJmTJvEGs84hjv4oT5LAZMZYkM/VaDxP7vDlt8visUBZhJGk6GzU3eX8/
         B9vh96hg+HpQ1Q/0NoABgCto4y7LzJRTwQVDI+knVDTr8zNrRnAsc/+Zwp2cYNY0srLm
         9C4B9l1ZUfvZbL0dVguSrj1TDV3Iaf85/Aec79erHyUCKD0oWf7rBhC21j6IbLxzD0MD
         46p+IqO0r8AKdOkC/Z3mAATTMmy2PgeVpPM+7OmFUMqe6cH1L97vg639JJ0G6rtQa8eI
         ieKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXZ12gQgeYr/3oPKCH5BNho5CYSet8+s3oZ8HxM5kC5FpdAL56UU7dtLVcXRp86Ai+ijKZGJfvyk65XbrwD5LDQF3Tse5BtSPQSssLELRdPvKHmOdvSyqrvg1ySVHrjZQ0rlJ2dzW3NpKYQiQ=
X-Gm-Message-State: AOJu0YzviN2bzikwwSHjtPWSRjW582w3CHEKz1tiusPmy8uanY3Sj5YG
	sm9EQ9/U6LNTxVs9zeLkOim3PWMP9oYY5OH5G2qjYShrmjKiS5Pv
X-Google-Smtp-Source: AGHT+IHq1NGwE3dkTvk5FXmP7pUa3PuT8uPh6e9VzJr/IOXzZiQsbUJ4J+pSBWaSkWhciyL54FqS3g==
X-Received: by 2002:a05:6808:2019:b0:3c3:9cd9:c2b5 with SMTP id q25-20020a056808201900b003c39cd9c2b5mr598315oiw.10.1712179289006;
        Wed, 03 Apr 2024 14:21:29 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id os39-20020a05620a812700b0078a2b5faab7sm5343907qkn.50.2024.04.03.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:21:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 247111200066;
	Wed,  3 Apr 2024 17:21:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Apr 2024 17:21:28 -0400
X-ME-Sender: <xms:V8gNZs4ln5fFspcocdevwQ5dYMLxbbSubyQO9eooEJdG-nPxwS3fkw>
    <xme:V8gNZt5ImFDaLGt7PuTRya4eyV4w22D_PWWF29ZCSZfRcK_xDmjfw5UNWvd3QitEs
    x_S5jTWVVhreb3WGg>
X-ME-Received: <xmr:V8gNZrfSVsroD9yR-j643vIPdRTIubqhLWpcpRucE-ClqE9JVEbrzid6hI8Nxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:V8gNZhKO31_FgnWK87nPBEeE-ie-bC-VLkZT3jHj9JoNmWGNr8MI3Q>
    <xmx:V8gNZgJur3wvEikrtR8Bx76XSHWsgvybMrvEHQkRa0QGm_ghx_6jbA>
    <xmx:V8gNZiw_RlqdYakBYJaNMMv2oem_WWrO-hlc8xugc_uJQJD17tALuA>
    <xmx:V8gNZkL_12Nt-8uulO3L98r9zsh10l8b6giB9-ksPYFqr5Hlr7U4sw>
    <xmx:WMgNZtCEtTC-E6aTkdDuc77Il9Gk7tA5hKNwDiBF3SHi5ena-sQJvqYy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 17:21:27 -0400 (EDT)
Date: Wed, 3 Apr 2024 14:20:29 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: change the generated name of guard variables
Message-ID: <Zg3IHZfYVEOh7nc4@boqun-archlinux>
References: <20240403194321.88716-1-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403194321.88716-1-benno.lossin@proton.me>

On Wed, Apr 03, 2024 at 07:43:37PM +0000, Benno Lossin wrote:
> The initializers created by the `[try_][pin_]init!` macros utilize the
> guard pattern to drop already initialized fields, when initialization
> fails mid-way. These guards are generated to have the same name as the
> field that they handle. To prevent namespacing issues when the field

Do you have an example of this kind of issues?

Regards,
Boqun

> name is the same as e.g. a constant name, add `__` as a prefix and
> `_guard` as the suffix.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/init/macros.rs | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index cb6e61b6c50b..93bf4c3080f9 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -250,7 +250,7 @@
>  //!                     // error type is `Infallible`) we will need to drop this field if there
>  //!                     // is an error later. This `DropGuard` will drop the field when it gets
>  //!                     // dropped and has not yet been forgotten.
> -//!                     let t = unsafe {
> +//!                     let __t_guard = unsafe {
>  //!                         ::pinned_init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).t))
>  //!                     };
>  //!                     // Expansion of `x: 0,`:
> @@ -261,14 +261,14 @@
>  //!                         unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).x), x) };
>  //!                     }
>  //!                     // We again create a `DropGuard`.
> -//!                     let x = unsafe {
> +//!                     let __x_guard = unsafe {
>  //!                         ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).x))
>  //!                     };
>  //!                     // Since initialization has successfully completed, we can now forget
>  //!                     // the guards. This is not `mem::forget`, since we only have
>  //!                     // `&DropGuard`.
> -//!                     ::core::mem::forget(x);
> -//!                     ::core::mem::forget(t);
> +//!                     ::core::mem::forget(__x_guard);
> +//!                     ::core::mem::forget(__t_guard);
>  //!                     // Here we use the type checker to ensure that every field has been
>  //!                     // initialized exactly once, since this is `if false` it will never get
>  //!                     // executed, but still type-checked.
> @@ -461,16 +461,16 @@
>  //!             {
>  //!                 unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).a), a) };
>  //!             }
> -//!             let a = unsafe {
> +//!             let __a_guard = unsafe {
>  //!                 ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).a))
>  //!             };
>  //!             let init = Bar::new(36);
>  //!             unsafe { data.b(::core::addr_of_mut!((*slot).b), b)? };
> -//!             let b = unsafe {
> +//!             let __b_guard = unsafe {
>  //!                 ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).b))
>  //!             };
> -//!             ::core::mem::forget(b);
> -//!             ::core::mem::forget(a);
> +//!             ::core::mem::forget(__b_guard);
> +//!             ::core::mem::forget(__a_guard);
>  //!             #[allow(unreachable_code, clippy::diverging_sub_expression)]
>  //!             let _ = || {
>  //!                 unsafe {
> @@ -1192,14 +1192,14 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
>          // We use `paste!` to create new hygiene for `$field`.
>          ::kernel::macros::paste! {
>              // SAFETY: We forget the guard later when initialization has succeeded.
> -            let [<$field>] = unsafe {
> +            let [< __ $field _guard >] = unsafe {
>                  $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
>              };
>  
>              $crate::__init_internal!(init_slot($use_data):
>                  @data($data),
>                  @slot($slot),
> -                @guards([<$field>], $($guards,)*),
> +                @guards([< __ $field _guard >], $($guards,)*),
>                  @munch_fields($($rest)*),
>              );
>          }
> @@ -1223,14 +1223,14 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
>          // We use `paste!` to create new hygiene for `$field`.
>          ::kernel::macros::paste! {
>              // SAFETY: We forget the guard later when initialization has succeeded.
> -            let [<$field>] = unsafe {
> +            let [< __ $field _guard >] = unsafe {
>                  $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
>              };
>  
>              $crate::__init_internal!(init_slot():
>                  @data($data),
>                  @slot($slot),
> -                @guards([<$field>], $($guards,)*),
> +                @guards([< __ $field _guard >], $($guards,)*),
>                  @munch_fields($($rest)*),
>              );
>          }
> @@ -1255,14 +1255,14 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
>          // We use `paste!` to create new hygiene for `$field`.
>          ::kernel::macros::paste! {
>              // SAFETY: We forget the guard later when initialization has succeeded.
> -            let [<$field>] = unsafe {
> +            let [< __ $field _guard >] = unsafe {
>                  $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
>              };
>  
>              $crate::__init_internal!(init_slot($($use_data)?):
>                  @data($data),
>                  @slot($slot),
> -                @guards([<$field>], $($guards,)*),
> +                @guards([< __ $field _guard >], $($guards,)*),
>                  @munch_fields($($rest)*),
>              );
>          }
> 
> base-commit: 9ffe2a730313f27cebd0859ea856247ac59c576c
> -- 
> 2.44.0
> 
> 
> 

