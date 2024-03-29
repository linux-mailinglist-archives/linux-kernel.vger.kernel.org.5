Return-Path: <linux-kernel+bounces-125278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D511989234E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C56BB22500
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5040C139CE7;
	Fri, 29 Mar 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a71SplzU"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169F130E3B;
	Fri, 29 Mar 2024 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736747; cv=none; b=p/1/CzbOpc7oadqmwZTe3dpu7S+yzNjBw+/WW2b+HDwjEhRvKDU4XmsQRVYrY/wwFdkZBWe4nAsHa0CBZ+N5i0o5YJuMImeURKntsmJC7sq3nTB7m2n0NU5VgAkxuwGMfL4jm65rvQjsntUIilIAjd4Py3Jl9rYZ2Ba/zkKcjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736747; c=relaxed/simple;
	bh=L44G5NOXTJTjz4j02H7V1y2UkLg5V3rNiYe+z02hJbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nnur8nyJXI7khThN72eVE3OHQ9O/MW1819hjjCzcXhzLfkqew+3MlZ8uUOqr6KHLIgn51fksm6dU5fXOx6XAvwQuwDZA4Axg+k+Cs0YghQek+y82te2SVbT4KzJI5s+v959js2dL+fOClKGucq0EfNYeI2AaGtfaVwGqolB1TB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a71SplzU; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7e096ab9287so764677241.2;
        Fri, 29 Mar 2024 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711736745; x=1712341545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHyn1w/hon/8DJXlFdIFNu42gMo+vemxakPS23A2btA=;
        b=a71SplzUekke9CqYyRqqvMkjJdllQ1uKO1XMAX6JyuLq/fThuyo58BGL4JRV3afsGQ
         bKX/k/AOP8vh/4+KpmKkO56773cGzNwqeF6w4cLlSl6TKBjcluZu4N9qAhGpZF7BJkyk
         8QMIBStuGAK5SadALChfMZImRlqM9U5TWtZfF4gi2FBI+aaFDsoSPw7YVr5Ujak2tqaE
         f3TCpfuTRNv8pqxx1E8KHiSSUCqJE3YKN4FzkCdHyJBon2LQR9TpU+sQCEL/QbbwDuht
         +T0Lgnx/j+8S8SuKByk1iryWlBGSgkpjJhX+/hyURXXcStkG4PDc3OX5jgViQJMg5DED
         nmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711736745; x=1712341545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHyn1w/hon/8DJXlFdIFNu42gMo+vemxakPS23A2btA=;
        b=KYO8sSpsiN3Lam5QDnRlMUGVfp8kET8R5op644wBOx1DT7Cz6suMkq69NRxcTWorrI
         xZREnpwVThM4kwQtY/eFPLwhx5pIeWLhwD3mlplVOrMJPZIoEfhAGYVjZN15LaO/Hj2t
         qtlBvGVu4amXe845Ni6w10AeIXf2uWJ0/JU9Vo5Wv6ivISPMgr/CjnjJO9/VL9bfcvym
         PMnhfumBR/a3c3ba0YHMNWZa3JbzCU7J+44+PCOqBLicnPJDD05eQiiVmbVzzxPlr4aG
         8c2wohKktGxIe/mK+sy5c+qC75z08W2JaA6L733aNdbhhJcy7GaWxldsYC1Y9bXU/h3Z
         PbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXWBXV1CEw1JZYbWfDSl/t5VtaZ0qzxfR9TFWbsYzcajQvGa3BaJlPy232u4AQEBpXbMSjXujJLuxalHrOxFUEPuu+LmlZMx+O/4B8
X-Gm-Message-State: AOJu0Ywm5rwpttI+Gxvn0T2PRQlguf8BGE1TXuHtrhCgo/dLCk6HumMn
	xUYO30MKAp1jnbIhlBiaxc6q+33/N4Ek74W9AjcCSyI11bnNGppT
X-Google-Smtp-Source: AGHT+IHYNDotgL3o5scMfXRHtkwKiesykdzS6RMMv1DikxudemLWsY+rG/aauLAv76PaLTxTcD63ZQ==
X-Received: by 2002:a05:6122:16aa:b0:4d3:3446:6bcb with SMTP id 42-20020a05612216aa00b004d334466bcbmr2757078vkl.16.1711736744677;
        Fri, 29 Mar 2024 11:25:44 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b00696b31e6cbfsm1874727qvb.127.2024.03.29.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:25:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A994A1200032;
	Fri, 29 Mar 2024 14:25:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 29 Mar 2024 14:25:43 -0400
X-ME-Sender: <xms:pwcHZj1zY6L8X_MtvQImqjT8zyV663TNjbXffXQ3nNnzSRdgMnqq1g>
    <xme:pwcHZiH7Eui6NWCLhCT6QYZr1nM5hC3LGaxWt4zEctOTEhzQkQMVzv-KIIr2M94H1
    yo9e0eZ93gdTp6V_g>
X-ME-Received: <xmr:pwcHZj7rgPXMx_5jSNQTym6jFZFbkk7C8fL5osZWtw3Lo6a_XPlIII-_hnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepffdtiefhieegtddvueeuffeiteevtdegjeeuhffhgfdugfefgefgfedt
    ieeghedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:pwcHZo1JSUHB-vue6lhT9w3-IteWzkoa20SNgUsVxE_W9axz7CQYsg>
    <xmx:pwcHZmHDiPQoHERVCut3xzw1XBVRHo6QOvPic4wH84XB3hqVun8cpw>
    <xmx:pwcHZp_yFrrCZ3uMuuL06NV-Nu8rlLtaNoezpK57lz8offmbPr053Q>
    <xmx:pwcHZjm58djlwM-N-wVQI3P42AJIHn9hz6X5qFEO1kvP2JUXDPEspA>
    <xmx:pwcHZtd5Uu0gcjTR7hDEgSKq8j3WROK0LtSL7xfEmi77mAJtTpB_9kRJ7hQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 14:25:42 -0400 (EDT)
Date: Fri, 29 Mar 2024 11:25:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <ZgcHfG5Hdhv39SLU@boqun-archlinux>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>

On Wed, Mar 27, 2024 at 10:35:53PM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Revamp how we use the `alloc` crate.
> 
> We currently have a fork of the crate with changes to `Vec`; other
> changes have been upstreamed (to the Rust project). This series removes
> the fork and exposes all the functionality as extension traits.
> 
> Additionally, it also introduces allocation flag parameters to all
> functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
> `Vec::push`, etc.) without the `try_` prefix -- the names are available
> because we build `alloc` with `no_global_oom_handling`.
> 
> Lastly, the series also removes our reliance on the `allocator_api`
> unstable feature.
> 
> Long term, we still want to make such functionality available in
> upstream Rust, but this allows us to make progress now and reduces our
> maintainance burden.
> 
> In summary:
> 1. Removes `alloc` fork
> 2. Removes use of `allocator_api` unstable feature
> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
> 
> ---
> 

FWIW, I've put this into rust-dev:

	https://github.com/Rust-for-Linux/linux rust-dev

a few adjustments are needed to work with other commits that have been
queued in rust-dev, so I add an commit on the top for everyone's
reference. (Besides this commit, I also removed all updates to our own
alloc in Miguel's 1.77.0 compiler version bump patch)

Regards,
Boqun

---------------------------------------------------->8
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 8902f490ccc8..a5930f0f2bc5 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -6,13 +6,15 @@
 //! [`include/linux/file.h`](srctree/include/linux/file.h)
 
 use crate::{
+    alloc::AllocError,
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
+    prelude::*,
     types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use alloc::boxed::Box;
-use core::{alloc::AllocError, mem, ptr};
+use core::{mem, ptr};
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -348,10 +350,13 @@ impl DeferredFdCloser {
     pub fn new() -> Result<Self, AllocError> {
         Ok(Self {
             // INVARIANT: The `file` pointer is null, so the type invariant does not apply.
-            inner: Box::try_new(DeferredFdCloserInner {
-                twork: mem::MaybeUninit::uninit(),
-                file: core::ptr::null_mut(),
-            })?,
+            inner: Box::new(
+                DeferredFdCloserInner {
+                    twork: mem::MaybeUninit::uninit(),
+                    file: core::ptr::null_mut(),
+                },
+                GFP_KERNEL,
+            )?,
         })
     }
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index c4a5e175b574..13a2166c4f41 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -302,7 +302,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     /// ```
     /// use kernel::sync::{Arc, UniqueArc};
     ///
-    /// let arc = Arc::try_new(42)?;
+    /// let arc = Arc::new(42, GFP_KERNEL)?;
     /// let unique_arc = arc.into_unique_or_drop();
     ///
     /// // The above conversion should succeed since refcount of `arc` is 1.
@@ -316,7 +316,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     /// ```
     /// use kernel::sync::{Arc, UniqueArc};
     ///
-    /// let arc = Arc::try_new(42)?;
+    /// let arc = Arc::new(42, GFP_KERNEL)?;
     /// let another = arc.clone();
     ///
     /// let unique_arc = arc.into_unique_or_drop();

