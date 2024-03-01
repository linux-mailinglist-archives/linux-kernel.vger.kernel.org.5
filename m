Return-Path: <linux-kernel+bounces-89209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED686EC0E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD87B23649
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7D5EE7B;
	Fri,  1 Mar 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLyuAiXb"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C185EE64;
	Fri,  1 Mar 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333636; cv=none; b=fLRIe6f64ouck171ElVQh6+xr5nTeGxDmVQ1LiY78C+KTsk2AHIMgHo8mdDhGmPtJZM6Eazzhkol7wwWEsWBYfArJ3Tmti3yvdLApW/5zl3zpWwTigACILaXGGu69fKQRgE2ATdKJxOrWvFFEC38lQmLoIs8JYRisQYvmKg+CBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333636; c=relaxed/simple;
	bh=VsZMdjYHywpaXWli5LwKAYdq01wqqIHubkBZDVKzvis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4sZIIGjJHAH+aCbJnU2Fy0YYFG6kxmT+tExm3yMnBZc3Eujlp9ucnjgr2PdcLelzBVZJD39TO+7X9JoMPT34P1uvjV5iUumU6+f4i0LQp7eGXYCxeC80+m/5QhMEdCrAfHrXCb2kVoBmUbo5VX9wdMd/9I9jfynxJhBQSMjMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLyuAiXb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6901114742bso9115406d6.2;
        Fri, 01 Mar 2024 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709333634; x=1709938434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpIP2vZ3D1DN449Uvv4oePTKmqkMaAo4lO0G7OfiEqk=;
        b=VLyuAiXbRVFqUxFCstT26D6ZpWFV5JV1vUl2IP8BbfYwtnOXtDVWG3/t6PPTWAzyFH
         aDbh98d/lgWSB7PV943TyWOwaeLPoA6C3lufPnaAV6TPuF4ba40O5k44wxJORIki8g0D
         ztCH+GT4U3YUIEOQkQxRN0MbiWGCTfx1mqHCftSn623tqS7UfYbPtHUVqizzlyKUEylM
         pQEjqHJGMhV3cH1lRnl7CYhTYW0OUftRABU0qyHQNP96UTyBeH72FBKAV9SnZFIFPmaZ
         JzAmWYZI2juykBzp0DxktXIBrC0AEm+ed/U4kPnc2FVid5QZle1N67XG+OA7WWbxw3Oh
         Kddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709333634; x=1709938434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpIP2vZ3D1DN449Uvv4oePTKmqkMaAo4lO0G7OfiEqk=;
        b=APHNFSjIbx16U60a0wvJnyrW0yJsVOYhLRbPvRLjErcOrLyIDHpxwBiHa0tmoY18aR
         /oOaIGhAaO/T/KHiRMkb/Rp0oiwF5gm65okh0kQOEc4ep+Z2a5qBJYQWoh+fQIkS9YNY
         zu53tueF4HdGlqJJeGWXyBSWrnD2blLHFhWv9FxWnMXlqKBIqQc5wzwkCHMMLucsOMe4
         JDop7l0QNSuAheD9nmPd73JXHUmR7d1OurZGd61mhNc5vtC0OAkUra/J5p/0H6PTjNHN
         k17NYDmIv4W0YLfUnxNYnBqPOmYcYhSOqqqpb9zLAJHiv4iZj+CYT/dUmgaqTgOWP87M
         Vi4A==
X-Forwarded-Encrypted: i=1; AJvYcCXZeyNxrxxKFu10xL8DijSuKaCj2Xjgc5SOs/EeDEaSf66OipO7i8LIsI1K4m8FZirL5GCe58qS33g+Y6UAm2C+SgL20QNYyaIdbxyqOHmYPw6/E8EKkca6W1DPhhWjRY/gnX9nlJq4bRbF1qY=
X-Gm-Message-State: AOJu0YwPZW/iKrSqzKFTTX0iHisWipqZk50U5oHhL+6n5/+vopflZUJA
	+OxlVWI0T2cBx0FlPDbu5qHZ6TZOFJ3PGXn7tZ5Zsl2koaq4qJcc
X-Google-Smtp-Source: AGHT+IGj6jPG6jcQnZG1k9X2UX7L2kmlRX6WTEmz0wmFKnsdm9oLiCDD0IL3XuFh267mc0MhPAipfQ==
X-Received: by 2002:a0c:ef50:0:b0:690:49a9:15d4 with SMTP id t16-20020a0cef50000000b0069049a915d4mr3001314qvs.7.1709333633736;
        Fri, 01 Mar 2024 14:53:53 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id ma6-20020a0562145b0600b0068ff983299fsm2343200qvb.45.2024.03.01.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:53:53 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8635C1200043;
	Fri,  1 Mar 2024 17:53:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 01 Mar 2024 17:53:52 -0500
X-ME-Sender: <xms:f1ziZTGXN9Nide4bqcmEUbLxT7zRHyZDEHtSIzBhH4Eodfxi9YY-QA>
    <xme:f1ziZQWCowdi2Xggyps9f_Z134Coz2OunOf9qRqigkvH4aCpTq_IFyuORHn3-JyOF
    6miuWDy29kL-gmhJQ>
X-ME-Received: <xmr:f1ziZVIya1Eppz1hq5rcLuDQcu-sMamWkMPGroQK5Gn60FjD0pkapMW9yCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepkeehfeeltdfgkeelleeukeduiedukeffveelhfekleeuieethfegiefgfeej
    kefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprhhushhtqdhlrghnghdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:f1ziZRGFVb6LYWoQFaiX5rK9Y5gbMFgUl4wM1aOTDv6GeMJ8pDyCEg>
    <xmx:f1ziZZWy5oUMXmDue2emH8gZyYUMb27FLnlHeKUv81XFBuI6txoLsw>
    <xmx:f1ziZcOD7p9PHnxz3v1XJF9FDyK8zZI547E8ut0kt2CFBDFBSWW1Ng>
    <xmx:gFziZStb08ey6y0-0671QAoj6NRbSvr-AR2icF8nZ_-x3hMlT0ENx-o7ErM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Mar 2024 17:53:51 -0500 (EST)
Date: Fri, 1 Mar 2024 14:53:02 -0800
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
Subject: Re: [PATCH v5] rust: locks: Add `get_mut` method to `Lock`
Message-ID: <ZeJcTl0WuegYHe2h@boqun-archlinux>
References: <20240301-rust-locks-get-mut-v5-1-c5131dbbd3c4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-rust-locks-get-mut-v5-1-c5131dbbd3c4@gmail.com>

On Fri, Mar 01, 2024 at 06:33:23PM +0100, Mathys-Gasnier via B4 Relay wrote:
> From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> 
> Having a mutable reference guarantees that no other threads have
> access to the lock, so we can take advantage of that to grant callers
> access to the protected data without the cost of acquiring and
> releasing the locks. Since the lifetime of the data is tied to the
> mutable reference, the borrow checker guarantees that the usage is safe.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> ---
> Changes in v5:
> - Adding example
> - Link to v4: https://lore.kernel.org/r/20240226-rust-locks-get-mut-v4-1-24abf57707a8@gmail.com
> 
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
>  rust/kernel/sync/lock.rs | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f12a684bc957..345ca7be9d9f 100644
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
> @@ -121,6 +125,38 @@ pub fn lock(&self) -> Guard<'_, T, B> {
>          // SAFETY: The lock was just acquired.
>          unsafe { Guard::new(self, state) }
>      }
> +
> +    /// Gets the data contained in the lock.
> +    ///
> +    /// Having a mutable reference to the lock guarantees that no other threads have access to the
> +    /// lock. And because `data` is not structurally pinned, it is safe to get a mutable reference
> +    /// to the lock content.
> +    ///
> +    /// # Example
> +    ///

Thanks! But please see below:

> +    /// Using `get_mut` with a mutex.
> +    ///
> +    /// ```

The example looks good, however, I was thinking about something like:

    /// ```
    /// use kernel::sync::{new_mutex, Mutex};
    ///
    /// let mut m = Box::pin_init(new_mutex!(None))?;
    ///
    /// assert_eq!(*(m.lock()), None);
    ///
    /// Mutex::get_mut(m.as_mut()).replace(42i32);
    ///
    /// assert_eq!(*(m.lock()), Some(42));
    ///
    /// # Ok::<(), Error>(())
    /// ```

because, this will also run something instead of just compiling a
function.

> +    /// use kernel::sync::Mutex;
> +    ///
> +    /// struct Example {
> +    ///     a: u32,
> +    ///     b: u32,
> +    /// }
> +    ///
> +    /// fn example(m: Pin<&mut Mutex<Example>>) {
> +    ///     // Calling from Mutex to avoid conflict with Pin::get_mut().
> +    ///     let mut data = Mutex::get_mut(m);

The other thing I notice when I try to make the above example work is:
`Pin` also has a `get_mut`[1] function, so seems we have to use
`Mutex::get_mut` to invoke the correct function, I personally want the
following just works:

	m.as_mut().get_mut().replace(42i32);

and looks to me the simplest way is to change the function's name (for
example `get_data_mut`), and we can do:

	m.as_mut().get_data_mut().replace(42i32);

Thoughts?

Regards,
Boqun


[1]: https://doc.rust-lang.org/core/pin/struct.Pin.html#method.get_mut



> +    ///     data.a += 10;
> +    ///     data.b += 20;
> +    /// }
> +    /// ```
> +    pub fn get_mut(self: Pin<&mut Self>) -> &mut T {
> +        // SAFETY: The lock will only be used to get a reference to the data, therefore self won't
> +        // get moved.
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
> 

