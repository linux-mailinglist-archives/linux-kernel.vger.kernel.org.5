Return-Path: <linux-kernel+bounces-100597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D629E879A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC08284007
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF231386C9;
	Tue, 12 Mar 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ+qMHki"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFA137C47;
	Tue, 12 Mar 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264523; cv=none; b=piGPvrKXRwK9tkniZI/Ac6qF6dqrrw8CP0PSawI7RYoi7jIyC8SNe/mu2MHFudGsMi2AUQCImFFgqixDd4m3/F2XnN8J8fraUIBTvToxjpJKgRx18u5bMJj5Hfs3DeKeU7Q+sm/uBkQS+m2LEcbHQWcJMRBhCA0yALJKuK/jUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264523; c=relaxed/simple;
	bh=ENWZVIXjn4OnYxJnwCZ78rDryYycT8EGi01bNOWUlCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSrTS69drd/PwZx1qy3mrueCWU3qd0gfqwuLrq0WoeAbYq0s2qNzO7UkRCjiOME2Sfom+jp58fescW9BmBYOTlPyHWw94Q2/0LqSUfT7WoB0F3JVg8tuTiqL8QzAiK3vua8bIJNdpM84dpn1Iimmqxm6uTkUr4ej0undKGJ8KOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ+qMHki; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78852e1e923so154451085a.3;
        Tue, 12 Mar 2024 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710264520; x=1710869320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPzQSsfcXkQnGQoKE12c3XjHugzMxmObuJNN2m4hWcY=;
        b=ZJ+qMHki5v9Aj4NVpYlThPStf382I5nV5T9F4xc0i6kjaHVsQlh1Fg5WlHNzo4d8sA
         Gp9ohFAeSqnj4/RYpBUk/7O+s3It3WUDBC9qE06FO93PQNHcqH+QMGnpKeiWjS0L66gw
         oR7+Dlncb+wLhp9GFE/86EXjF+KcvrzIdDaAxrG4QU1UfyTsIOmsBiyjN5QviPvxNH8Z
         Y24T67oFExg3TMkAQXGgqpX52FmI92Cg3cZxEgC4X4YZLcGedHOKKdxskMQKk/xL3k5Y
         TtkomOcDqlJhNrPqWUm5+bxvQdjPGfGU+iiFf8p+JFIbMeHzBCPMEHeQkXxdBdnwXLep
         9peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710264520; x=1710869320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPzQSsfcXkQnGQoKE12c3XjHugzMxmObuJNN2m4hWcY=;
        b=EB8tQhRVU+EMjJ6971Ik+FGXOLbTGQs5Oy1POFuSpA4b4/CRXeBhPC+Iqay3aU/ToQ
         xbwQClVz0aqaJRCed5hYcG8IiqsQSpLRyW9s1PMUEZUxodwLwCEahA0jiqXGtO/f/eBG
         +lxhiKFqGbYhUSYFUuD0+MkApIPKQpQvODG6i1F+1trJM/O/AxfbCCyJ6SFiZ3/Jofrj
         NSBwrJDSLxoIKEcwoEO1sAa9AU73CUobe2gk72pjjY1Gk5NjISnV6ujTo/jeS8MUy76y
         bBuQTFgcxLU+N1kZVTbh5gSDL1aFxoUxvQ0IbMbHzS1Jz6ius71T906mxY+15BE1CYUg
         fyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxiRCHAgHpUhqhnDfmGJE52/dc8PitchUJyVC9jGMFkFdy/ZURVfw5CZ8dw6gF5Ut8tExyIIFBCDLiRsRuNCML8oYt3X66XLZLOqVS79Nz1Vzz0gLnhVJenqFmcSOZZ3PgifaloPEveLzGKgU=
X-Gm-Message-State: AOJu0YzP/i78EG/sM64l/yvReNbwBzYEWEEfPDzYknRtw725/LN/32Yd
	lqVpTmvfEa/9gUCtlUjeS994MptYbIVOgVYwyBZBwcuY3KV2o/k3
X-Google-Smtp-Source: AGHT+IG/a5EzG+Tv1QMXnMO72Wa4DdyPwE/Z4HBKV58KE81lyoiMZeza9vZ/1wOuZlXTUlg3KmykTA==
X-Received: by 2002:a05:620a:4691:b0:789:c68d:82d3 with SMTP id bq17-20020a05620a469100b00789c68d82d3mr233108qkb.33.1710264520538;
        Tue, 12 Mar 2024 10:28:40 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a125300b0078837b90db7sm3884187qkl.32.2024.03.12.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:28:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 4E2321200043;
	Tue, 12 Mar 2024 13:28:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Mar 2024 13:28:39 -0400
X-ME-Sender: <xms:x5DwZetE3kHEYW6zledBWF3vRFrB5iHdr4ox6ed8Xyw0xQQP-iQ6Qw>
    <xme:x5DwZTeWKFjvvlnO4PQ9yCXoAslLB1F7hFlz7ZK-3vui5wavuDloa1SJMmFd3MSNX
    CxUVmEnrjIv3w7p_Q>
X-ME-Received: <xmr:x5DwZZy3USTmVK_bsHX6T6ZVVDg0wAtCR-_gssj9dFXZnTJG7wv_MGLhQxz3Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhkeduhfefffdvhffhvdethfevfffhfedtfedvheejgeekfedtgefgveff
    hfevkeenucffohhmrghinhepphhtrhdrrghsnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:x5DwZZPBdLJTbm-Sz9nDmjUi9DIlUgxw3nvxnevQMzLgawkJ-BCbIA>
    <xmx:x5DwZe9BaAtNWMQCDis4Ul18tje-YoDorYzGbg34Vo72lPR2IzIc7g>
    <xmx:x5DwZRVp2xEvNSYS4hnvwr5s90Z4iLuTEnKMBT0s7i7LlHZ3QDyk8Q>
    <xmx:x5DwZXctzkKvAx_wXDslWOcUN0f2vytx1BpMzIOraITIj8evRSelEA>
    <xmx:x5DwZRXroftjil0D3pUSyB3BYc3Perud06XHSdGx488jl5AAirZ6NJI5TZs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 13:28:38 -0400 (EDT)
Date: Tue, 12 Mar 2024 10:28:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: sync: add `Arc::into_unique_or_drop`
Message-ID: <ZfCQuh-JrplKtbco@boqun-archlinux>
References: <20240311-arc-for-list-v3-0-cba1883c62eb@google.com>
 <20240311-arc-for-list-v3-2-cba1883c62eb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-arc-for-list-v3-2-cba1883c62eb@google.com>

On Mon, Mar 11, 2024 at 04:08:19PM +0000, Alice Ryhl wrote:
> Decrement the refcount of an `Arc`, but handle the case where it hits
> zero by taking ownership of the now-unique `Arc`, instead of destroying
> and deallocating it.
> 
> This is a dependency of the linked list that Rust Binder uses. The
> linked list uses this method as part of its `ListArc` abstraction.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/arc.rs | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 53addb8876c2..ef8b520f65a8 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -290,6 +290,36 @@ pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
>      pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>          core::ptr::eq(this.ptr.as_ptr(), other.ptr.as_ptr())
>      }
> +
> +    /// Converts this [`Arc`] into a [`UniqueArc`], or destroys it if it is not unique.
> +    ///
> +    /// When this destroys the `Arc`, it does so while properly avoiding races. This means that
> +    /// this method will never call the destructor of the value.
> +    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
> +        // We will manually manage the refcount in this method, so we disable the destructor.
> +        let me = ManuallyDrop::new(self);
> +        // SAFETY: We own a refcount, so the pointer is still valid.
> +        let refcount = unsafe { me.ptr.as_ref() }.refcount.get();
> +
> +        // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
> +        // return without further touching the `Arc`. If the refcount reaches zero, then there are
> +        // no other arcs, and we can create a `UniqueArc`.
> +        //
> +        // SAFETY: We own a refcount, so the pointer is not dangling.
> +        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
> +        if is_zero {
> +            // SAFETY: We have exclusive access to the arc, so we can perform unsynchronized
> +            // accesses to the refcount.
> +            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) };
> +
> +            // INVARIANT: We own the only refcount to this arc, so we may create a `UniqueArc`. We
> +            // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
> +            // their values.
> +            Some(Pin::from(UniqueArc { inner: ManuallyDrop::into_inner(me) }))
> +        } else {
> +            None
> +        }
> +    }
>  }
>  
>  impl<T: 'static> ForeignOwnable for Arc<T> {
> 

The code looks good, and FWIW, I added the Examples section for the
function since I at least need something to run when queuing it to
rust-dev branch ;-) And I think it's overall good to have examples for
every `pub` function. If there is a next version (which is unlikely),
feel free to fold it. I can also send it alone once Miguel put your
patches into the rust-next branch.

Regards,
Boqun

--------------------------------------------------->8
From 7d26d1177a2788ba96c607fd9dc45baf469fb439 Mon Sep 17 00:00:00 2001
From: Boqun Feng <boqun.feng@gmail.com>
Date: Tue, 12 Mar 2024 10:03:39 -0700
Subject: [PATCH] kernel: sync: Add "Examples" section for
 Arc::into_unique_or_drop()

These examples provide better documentation and can serve as unit tests
as well, so add them.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/arc.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index fda737f5b1e9..7cf066cfb321 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -295,6 +295,36 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     ///
     /// When this destroys the `Arc`, it does so while properly avoiding races. This means that
     /// this method will never call the destructor of the value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::{Arc, UniqueArc};
+    ///
+    /// let arc = Arc::try_new(42)?;
+    /// let unique_arc = arc.into_unique_or_drop();
+    ///
+    /// // The above conversion should succeed since refcount of `arc` is 1.
+    /// assert!(unique_arc.is_some());
+    ///
+    /// assert_eq!(*(unique_arc.unwrap()), 42);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    ///
+    /// ```
+    /// use kernel::sync::{Arc, UniqueArc};
+    ///
+    /// let arc = Arc::try_new(42)?;
+    /// let another = arc.clone();
+    ///
+    /// let unique_arc = arc.into_unique_or_drop();
+    ///
+    /// // The above conversion should fail since refcount of `arc` is >1.
+    /// assert!(unique_arc.is_none());
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
     pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
         // We will manually manage the refcount in this method, so we disable the destructor.
         let me = ManuallyDrop::new(self);
-- 
2.44.0


