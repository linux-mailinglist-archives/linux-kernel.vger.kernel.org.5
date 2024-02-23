Return-Path: <linux-kernel+bounces-77690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E5C86090B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55931C21BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403C10A28;
	Fri, 23 Feb 2024 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWn1nc70"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0410A01;
	Fri, 23 Feb 2024 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656757; cv=none; b=SZsYlxEVzRBhAcMZr9j97Yi6PrLKE5q1GFuKH7LzOiDt5eUUqmnYJ8R74PahcLg91OT5/LWgXh5l355H8k8W5X7Z7ErxkMB0hsBEbijyVB8jL1EaFgpNJWVmVF/pfqvaZf3rSY7pfHQ9n7me9IWRzvwpPsgqfYWyi34lNNYRmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656757; c=relaxed/simple;
	bh=TfybdcReKVCu8Nr8of0e/2MKxRmQIWLYTlRmYoEr4hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eec0A34V8p6O+JOCvGSn+ghBOkFLJU3jqIANlRXqMc24oKf3Q04SZPh1xlz8qfEvl+BSS5sDGUucOBmSTPW0pogtv4RMDtvGfDESX5DozazllxFU4p8/7RNzOgMG2vWPTgn8ffkNSIuZtZzkVRig+lDUYCoXbfpuvWxbuCteWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWn1nc70; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68fb730fdd5so1675946d6.2;
        Thu, 22 Feb 2024 18:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708656754; x=1709261554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9SZzLUiOA87PykE+ejNjUZsTIjTBY/yJ+IqYjxPnOM=;
        b=ZWn1nc70TMHm9sNhtlxzi+3KFDLekwD4MHuO5N0al6GAMWch7IWI4fqKDz7owobr8L
         xzO/6xI4z3SgJtyzDXAxkbVmp5jHlE22oCXV/9ebOmoe+pXs1++z8yrMLU8HMp/LBy9q
         /KGfmbgBEbHRCcXKZB0VGC7oBGLnC6fjUECdA5HkA33NWvfl8SoZN4Uk5lhgDPIMMXVy
         JxKK/dHfCqeVsUJalnusXeot6sSkLw0NV6N/PehQ+HzJ7OJHyM5S59Sz18o780Ai6wlf
         G2w+WfDZhR1Mxd5/cKtTyKhwP0r4EF3pUfpBZchIF9hr0ZrCkLzv/lpuiBaXjqOhWfkm
         VWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708656754; x=1709261554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9SZzLUiOA87PykE+ejNjUZsTIjTBY/yJ+IqYjxPnOM=;
        b=vLLM2fWVe1aM0PPtuc9dRviBkgk4YlpLzlJ9eeIwU+f5Xbri4EPrNv7Ar6Uic/cvAH
         U/wMNusPekoDmqNEhFenx7mexlxIEN/AgJZ058YOrqjFILm6ygeX3LiBXNdqEtBJAzZZ
         4eCOnMjijZEOU+jUnUmVH6XAwQl8UDlEZN6H7Ypa4C3SmgcDZ+ldDt0JXH5btpfmvbbn
         mjnrI3y+0dMZoof9BnVqKk+h8BnWaeXNw6xKQPvFw3L9xrNuF1SAXv58g4645ShfYHJB
         VZJgdWg7YvGVRiSpSKpypTKvLn/8SNs7xEYYNbEmEmqRza8kP7LfPpnkIKDjusS7uBdI
         XJrg==
X-Forwarded-Encrypted: i=1; AJvYcCVG+yBfU7VrwYJWtfOOmMDLfTNdyR4MYMe3onZqL829S26JpQ0xWosVsIoOM3jJLLl6GR0w/Q+n1W+sJTAq4CJfCqQA9OtcQk4F4ttsZiUGwscP8n4mf3KsxlqN6lGeFOG+XuY5CEXQ6B3mmhg=
X-Gm-Message-State: AOJu0Yx+r2X3jgnt+9msiDcMEZ5IIg7dUB2KlVzV3N8E5yC6R3A5YOR0
	vu13Dw65SwMJBzU9vBV5Ke8jFOU4cqYHRLiHejNuKf3abVk3ADroqCC5IR8I
X-Google-Smtp-Source: AGHT+IFs9a00E1QUmBPdXOJwbk3bSv7Q9A7POtQa+T8xUohaOeZ+JBQCDnUfqqLuLvtnM6HrZuDU2A==
X-Received: by 2002:a0c:f0cd:0:b0:68f:43f6:4843 with SMTP id d13-20020a0cf0cd000000b0068f43f64843mr1056571qvl.29.1708656754398;
        Thu, 22 Feb 2024 18:52:34 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d1-20020a0cf0c1000000b0068f71daf86bsm5423618qvl.43.2024.02.22.18.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 18:52:33 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id 4BD7B27C005B;
	Thu, 22 Feb 2024 21:52:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 22 Feb 2024 21:52:33 -0500
X-ME-Sender: <xms:cQjYZemQK_0zlmXI2OXoex_mv1Baby1Dmx3qgBUXFuN0ywCpItb8zA>
    <xme:cQjYZV0lgNxqR3xwPL98gMnhYeJGBG-Hjy0No8umlfATz9tMtFssMSBkp6diWIvCG
    K0f_7Du24cN9b5SoQ>
X-ME-Received: <xmr:cQjYZcrOPRMnYFE6R6fRH2apLP7DL7HgtUzIkIG8Sp_xPCbVA-a_GebITehw3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeehgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeffgeeijedvtdfgkeekhfejgeejveeuudfgheeftdekffejtdelieeuhfdv
    feegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:cQjYZSn0Nczr7Xm3JhRQ-6EF26N-6--rPKBNaAeqgqEI6wg4ziQ5vw>
    <xmx:cQjYZc2PZUx2W8Hx3ktTswFWi3WGx5BYMH8zA2j_K1Zdlp-oHLMjTA>
    <xmx:cQjYZZsEU56yUwXBoMdC5d0ndq0xjVQyhuFIDRf8o3zYQ0rrBrfVPg>
    <xmx:cQjYZRt0701-tD9zBy6rXs3t0KtIZsW0hXVu2x_cog-_vVcVno7J4w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 21:52:32 -0500 (EST)
Date: Thu, 22 Feb 2024 18:52:07 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: mathys35.gasnier@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: locks: Add `get_mut` method to `Lock`
Message-ID: <ZdgIVxrwBfTEjuEe@boqun-archlinux>
References: <20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com>

Hi,

Thanks for the patch! Please see a few comments below.

On Thu, Feb 22, 2024 at 05:26:44PM +0100, Mathys-Gasnier via B4 Relay wrote:
> From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> 
> Having a mutable reference guarantees that no other threads have
> access to the lock, so we can take advantage of that to grant callers
> access to the protected data without the the cost of acquiring and
> releasing the locks. Since the lifetime of the data is tied to the
> mutable reference, the borrow checker guarantees that the usage is safe.
> 
> Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> ---
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
>  rust/kernel/sync/lock.rs | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f12a684bc957..0c8faf36d654 100644
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
> @@ -121,6 +125,16 @@ pub fn lock(&self) -> Guard<'_, T, B> {
>          // SAFETY: The lock was just acquired.
>          unsafe { Guard::new(self, state) }
>      }
> +
> +    /// Gets the data contained in the lock

This above line could use a period and a new line.

> +    /// Having a mutable reference to the lock guarantees that no other threads have access to the lock.
> +    /// Making it safe to get a mutable reference to the lock content.
> +    pub fn get_mut(self: Pin<&mut Self>) -> &mut T {
> +        // SAFETY: Since the data is not pinned (No structural pinning for data).
> +        // It is safe to get a mutable reference to the data and we never move the state.

Compare to "never move the state", a more accurate safety guarantee is
"the `&mut Self` is only used to get the reference of the `data` field,
therefore `self` won't get moved", I think.

BTW, while we are at it, I think we should document the
"structural/non-structural pinning" design decisions somewhere, for
example in the struct definition:

	#[pin_data]
	pub struct Lock<T: ?Sized, B: Backend> {
	    ...
	    /// The data protected by the lock.
	    /// This field is non-structural pinned.
	    pub(crate) data: UnsafeCell<T>,
	}

Thoughts? Or do we think "non-structural pinned" should be the default
case so no need to document it? I want to have a clear document for each
field to avoid the accidental "everyone forgets what's the decision
here" ;-)

Regards,
Boqun

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

