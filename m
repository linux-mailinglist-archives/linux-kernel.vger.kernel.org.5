Return-Path: <linux-kernel+bounces-85560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375486B7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A8F1C2339A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F257440A;
	Wed, 28 Feb 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQyV4vf4"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AD71EB3;
	Wed, 28 Feb 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146313; cv=none; b=hiJdAt397LS0CSHzsiVoWvi3nT2EyAY2hdx2O3ieTEVeJIttZYnGiXkpfIZTV3+KV6Ntxorfwxoaa5NnsJK1Iwb58mGGXHNHTiCzZv899TF6VH04e/gjv9oII4M89aBz8WgyJKOlFzSXjtF3UX1SCk2cM7VAoUSlfP4/3CO8hzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146313; c=relaxed/simple;
	bh=PcSdRbgwcOcuK3W1kpU42Akdd3/7NahCewrPceYtuUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq7yRPx2meU9Km9lFSemlAX+uG6LXvBPdvjtTi4wfQl9pL4OkHWMnPAsWLB7IUXEZ1Jq4ASU6w3vJRJqgQnOkjxNqqFHJ3+u/CKo/DzrVpxthm5XuiZFBIgRFEq6GnujB46FJqR03yW/Ca7bdXQ9aP21OonoIPO5H1nw+AgmtFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQyV4vf4; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc745927098so93130276.3;
        Wed, 28 Feb 2024 10:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709146310; x=1709751110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rfc86T7k5b0i963LoD1bGQIFebMJk/S7CVsLQAk4jg=;
        b=VQyV4vf49GoK7prnqdYclBeSiJJb9fJmEXIp54/jVxXzyqsDAWaOrvzvDt2J3Xn6wU
         /p2mIdlA5TuvQLwpvg5s5hXd79qP1Hf5aeO3fc8nMoDIL0qMy9kdvjI9qsqcNJg5JOU6
         oAmjJYNItKZwp63aaBK4X5+h+QAw8+uN2kxdCMi1IBGYD7wIdz6Rj2dD0uNeYTp51J5U
         ff/gxZQUguKiK/RAcEUig5cItvnHkVe1A35SUDViol6uFLRahrnzRQ77P853tI5XWp7n
         kidRDCnwopr8dgNBKyGQ5KNwHMbhtHqGjlzB1RNBpDN7FxWGMOH2OEXe4klLLUDEHDOM
         zsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146310; x=1709751110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rfc86T7k5b0i963LoD1bGQIFebMJk/S7CVsLQAk4jg=;
        b=fPqr6coCpQH6xn4+FulcK3i8owge4cafOePPNNIpjWdoQhyfN3bEH0d44mUENtUh5U
         86ecvdv7K8L0dUPqIOEeLwIFkHiLZZdF+jP5qs8ONtJGXyUwsoGrJW/p4eDGOPuNHDCl
         Q2IaGuASc4nuj+n5DBl/G20VEjgrpzSIKGHJuAebRn8GMwLHOomKl8JPu6/Rxe04csPn
         cd25OClDt4Yksz89WwNYLARtgaya7kbe3QPxRzE6YWxYfydzZyg/chLn4lPbmeceWAa2
         bOcMa8fkZZERde4mUz+xzVfYOvQPul+i0IHAP/nSAFB1OeK17sdHpH2ytcYHIRZL1/XM
         C5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrVod8e+EJuMIQFgAVV/WGCrisUn6YvHzBj+tT9FzQ/FMOdi9Fh6sMzX6exmfIRM/YyzY5CWIloKDGEHqvR3HOwDokfjAc7pnNwHAgN6MZR9A4LH2CYMAuuMiuWoCKktlAxxcoKt0JaeqmEo=
X-Gm-Message-State: AOJu0YxT168FSMF3voXpLW+9XyoID9fJxbNjPWE5kISEPlMnliSCYxJi
	jU7I8yJ92M1pdKKuxtlte1enZToR12FsKKFJnHJe4ZH9lzymKmpk6szC7ZFG
X-Google-Smtp-Source: AGHT+IEUbTbhXqor9GB2IUrfB04gIbmEw5mnzod5oYuygIT+NvslUwgcJ0OMeVqk1e8ZKtk6RbOXOg==
X-Received: by 2002:a5b:602:0:b0:dcc:383b:e48d with SMTP id d2-20020a5b0602000000b00dcc383be48dmr69471ybq.26.1709146310402;
        Wed, 28 Feb 2024 10:51:50 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x4-20020ac87a84000000b0042e390c9804sm25987qtr.6.2024.02.28.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:51:49 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 743A827C005B;
	Wed, 28 Feb 2024 13:51:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 28 Feb 2024 13:51:49 -0500
X-ME-Sender: <xms:xIDfZXC_6JXtVjMzmnTdMhQ32cG17X-9kF0KOApIMyUd6H9FnsOeGA>
    <xme:xIDfZdg-TtOYYwnn0Yjz6O5F5izjlK38qfly6nKGy8EMy45jGfICGOU2ht5JPWVmC
    khRk3Ge1MHHUt65iA>
X-ME-Received: <xmr:xIDfZSkqR3vhb-5j9Q_mZvuY8yQbeiIngZABTamHa8gmh3lMmMi7evcmGD54Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:xIDfZZw13R0vK2yzP_c6yatw2_SAqFSeeIKxlkAiMzQzYJ1vlY-66g>
    <xmx:xIDfZcS_bWVRYwOZY6NVI-WIUPRc-dixtGS7euvHnAYBBo599YpphA>
    <xmx:xIDfZcZamwshnHSYJNjWXMtIFa1yAzY11BwaKodnR4nufl7pelTZrg>
    <xmx:xYDfZTK5E0UmwO7rsCu1ZM2xRPyWSmhsWpibQ-K7mki7uOMmaL7h0g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 13:51:48 -0500 (EST)
Date: Wed, 28 Feb 2024 10:51:06 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: mathys35.gasnier@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4] rust: locks: Add `get_mut` method to `Lock`
Message-ID: <Zd-AmppAQtTXlOdo@boqun-archlinux>
References: <20240226-rust-locks-get-mut-v4-1-24abf57707a8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-rust-locks-get-mut-v4-1-24abf57707a8@gmail.com>

On Mon, Feb 26, 2024 at 02:55:47PM +0100, Mathys-Gasnier via B4 Relay wrote:
> From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> 
> Having a mutable reference guarantees that no other threads have
> access to the lock, so we can take advantage of that to grant callers
> access to the protected data without the the cost of acquiring and
> releasing the locks. Since the lifetime of the data is tied to the
> mutable reference, the borrow checker guarantees that the usage is safe.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> ---
> Changes in v4:
> - Improved documentation
> - Link to v3: https://lore.kernel.org/r/20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com
> 
> Changes in v3:
> - Changing the function to take a `Pin<&mut self>` instead of a `&mut self`
> - Removed reviewed-by's since big changes were made. Please take another
>   look.
> - Link to v2: https://lore.kernel.org/r/20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com
> 
> Changes in v2:
> - Improved doc comment. 
> - Link to v1: https://lore.kernel.org/r/20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com
> ---
>  rust/kernel/sync/lock.rs | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f12a684bc957..a563991bf851 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -7,7 +7,11 @@
>  
>  use super::LockClassKey;
>  use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
> +use core::{
> +    cell::UnsafeCell,
> +    marker::{PhantomData, PhantomPinned},
> +    pin::Pin,
> +};
>  use macros::pin_data;
>  
>  pub mod mutex;
> @@ -121,6 +125,17 @@ pub fn lock(&self) -> Guard<'_, T, B> {
>          // SAFETY: The lock was just acquired.
>          unsafe { Guard::new(self, state) }
>      }
> +
> +    /// Gets the data contained in the lock.
> +    ///
> +    /// Having a mutable reference to the lock guarantees that no other threads have access to the lock.
> +    /// And because `data` is not structurally pinned,
> +    /// it is safe to get a mutable reference to the lock content.

This looks good! But I forgot to mention this last time: it'll be good
to add an "# Example" session which would act as both a document and a
test. Do you mind to send a follow up patch?

Anyway,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +    pub fn get_mut(self: Pin<&mut Self>) -> &mut T {
> +        // SAFETY: The lock will only be used to get a reference to the data, therefore self won't get moved
> +        let lock = unsafe { self.get_unchecked_mut() };
> +        lock.data.get_mut()
> +    }
>  }
>  
>  /// A lock guard.
> 
> ---
> base-commit: 711cbfc717650532624ca9f56fbaf191bed56e67
> change-id: 20240118-rust-locks-get-mut-c42072101d7a
> 
> Best regards,
> -- 
> Mathys-Gasnier <mathys35.gasnier@gmail.com>
> 

