Return-Path: <linux-kernel+bounces-102230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4D387AF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF9288F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F256612CD;
	Wed, 13 Mar 2024 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPOI76tY"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390241A38E7;
	Wed, 13 Mar 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349719; cv=none; b=FWtVfDNMw1fZdweU0GI/UqvDA8ZPkfMiSP/RKuVOBcp5Kl3IZ+bDqWh0dgLQ+xm+B0siBmNWgzlceUPFGgqQAPYWFoMJnygsOelsU2NTsnKO3AXYMFowqZqB39yhfe78CB5DSsuJ/KPK15JroheA0G1dSbBE0fzCLGLn+ipwPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349719; c=relaxed/simple;
	bh=iR4rrgnspB8K7zSxyqEsmpQYGzBigUTvAURU0uKdVWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuONDHSWrCROa0ZNdl+TY2NBcdqryiZKd8MZ0f1yFoFLJynxHlfEEBU+EI3TkC7NNrWq7ResTZyn9XyEBGTA+YqCy3dVvgpknIg+V+HWM5bsWbraZJn3jcvcfAFTX626a58YxX4AHk9ZTfz43szUWyh3I0SlB+K4blibgvfE7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPOI76tY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690be84583fso748546d6.1;
        Wed, 13 Mar 2024 10:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710349717; x=1710954517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rw4WYHE6w3+yrD7ysvFm8I/0T+XNiawVhUxQiwrSS4=;
        b=NPOI76tYgZG60zAPjELJvJa1gv/z8k0F1lze9fTIi2frsaQPZPnU9MJrcaioSgigwv
         YXvPpF2ohPMI/2A6VcPLOhYopJxu/EoiBNHn8AWpR2XFnK/6PSgEoNrGohAUrjxmyO+R
         pwEN3aHbQPg8z2ZldxKlPAArFCnv9d8cFS1E9xgRWNm4UTYGszOEOJVdVtnTTeP2+nYM
         76E8Yuq8lRpsAb9cKkCtbLb9JtirTyaJRy8NNrYB1J3au97Jvv/sC8Zci9a7/K5bf6Cp
         Xcf541jlglEL8MphAXHIjeTHvjvwzEERm/0W3Lv7Rmxn1Q3INQyPWbbg6N5lpB6RCgpK
         0enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349717; x=1710954517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rw4WYHE6w3+yrD7ysvFm8I/0T+XNiawVhUxQiwrSS4=;
        b=xUMXsPy9KILY5nap7TJsbhIGsVQU77MlfPD8svIi9dcHIYhPyUEiCOjXvOcK6vfB55
         CUcGba+nclk1Tx/vS+PYPfxCoWW0o0y/iCBYcen1xghQylp0mZ+vy0oc27V0A9ISo4i+
         vhkYX8RSSMbg7gPhLTFjHQzwDcjnAn8A2ZltuL51H06LFuXRZEHttLEaZBPi3i7mYMp4
         m50lFYjVwXk2ePVh0b+zouwTpBlddkyQm3i//8N4DFy6XILC3fXbJs3jTs3HnJ3sRqeT
         L7VCAG+ZEAlY9T6SplDrYTsX4KXhZUji+3D8htmwRJCgRWxWLpRc15rOfsuv2XjFRTqb
         nstQ==
X-Forwarded-Encrypted: i=1; AJvYcCVerC3t3uyOtUy2jdwHlR+GDW5YKCmX3fJk4RJ4avEUkdnNLsySKZuY+gCmUzb3Fc9Vg1DZEdPTkco8a3cg+GPHRRlA7le+uqvr15I1AS7fqHi7NfpcZT/oh6ZSb82RF3ttRGeiJQwATBahB3k=
X-Gm-Message-State: AOJu0YzNMK3GanxHetHo5YzT8hqOlbRQ8ZkAAaNOpVS1pW8pdT/41anu
	tkR7sqQA/7jidoa44D3rFDNXpwQt1bdh7AbE0CkyNOB1C769ziHQ29MK8HCJ
X-Google-Smtp-Source: AGHT+IF4pVSjBWYic+Loe2Hisw20VYkQDVCxBhnYqTIhpB0QqVTlxLDx2mqXTkW8QQNVFzTLFRspHg==
X-Received: by 2002:a05:6214:5587:b0:691:193a:370c with SMTP id mi7-20020a056214558700b00691193a370cmr494070qvb.23.1710349717005;
        Wed, 13 Mar 2024 10:08:37 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dd8-20020ad45808000000b00690db447fb7sm2576495qvb.69.2024.03.13.10.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:08:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1705727C005B;
	Wed, 13 Mar 2024 13:08:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 13:08:36 -0400
X-ME-Sender: <xms:k93xZRY9S3GK5dTXaxQYZUPh8wxDkv76maV4rJ2kcJ5T3EO75THOeA>
    <xme:k93xZYbiKIK8GQBxYUad5vXvi922UUoekPvFTPJSm1BAMkUETbnzVVLR1qmZEDBVs
    oxgJhGsiHGrg5Qmcg>
X-ME-Received: <xmr:k93xZT8v1SXKliDKM3Zf_nGuL1D2HivFDQjwMGR8ZDGKD1UcrUUzhoUSrHNGvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:k93xZfojLxmcv4CTd7hbjL7aVh43Gnr94AOzdyF6J84cARplM9i-DA>
    <xmx:k93xZcqxIEZJ97XJijOa0aP3bSy14hLDdTw6h1shUw7ihCXPCQ_fNg>
    <xmx:k93xZVTLxc4wU4u8euEyENt_bGb-MFQNVgAKoqUK1KSBV1x7Go91dQ>
    <xmx:k93xZUqc8noXxs1bkLk0q21iyk9gWN-BRRrzF8n4mfu3rB6NTkpNaA>
    <xmx:lN3xZRRbdexzCa1dc_ShLmNzXkQR-8Lqg4ad51yf7MuQAZscl0TOLA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 13:08:35 -0400 (EDT)
Date: Wed, 13 Mar 2024 10:08:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Arc methods for linked list
Message-ID: <ZfHdkNBzhn0hc7z7@boqun-archlinux>
References: <20240311-arc-for-list-v3-0-cba1883c62eb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-arc-for-list-v3-0-cba1883c62eb@google.com>

On Mon, Mar 11, 2024 at 04:08:17PM +0000, Alice Ryhl wrote:
> This patchset contains two useful methods for the Arc type. They will be
> used in my Rust linked list implementation, which Rust Binder uses. See
> the Rust Binder RFC [1] for more information. Both these commits and
> the linked list that uses them are present in the branch referenced by
> the RFC.
> 
> I will send the linked list to the mailing list soon.
> 

For the whole series:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Note there's a nit for rustfmt fix of patch #2 (which is reported by
Miguel):

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 7cf066cfb321..c9773d0050c2 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -345,7 +345,9 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
             // INVARIANT: We own the only refcount to this arc, so we may create a `UniqueArc`. We
             // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
             // their values.
-            Some(Pin::from(UniqueArc { inner: ManuallyDrop::into_inner(me) }))
+            Some(Pin::from(UniqueArc {
+                inner: ManuallyDrop::into_inner(me),
+            }))
         } else {
             None
         }

Regards,
Boqun

> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v3:
> - No changes to `ArcBorrow::from_raw`, or than adding a Reviewed-by.
> - Update SAFETY comment on `refcount_dec_and_test` call.
> - Simplify the creation of the `UniqueArc` in `into_unique_or_drop`.
> - Link to v2: https://lore.kernel.org/r/20240228-arc-for-list-v2-0-ae93201426b4@google.com
> 
> Changes in v2:
> - Move raw_to_inner_ptr to ArcInner and rename to container_of.
> - Reword safety conditions for raw_to_inner_ptr to match its users.
> - Link to v1: https://lore.kernel.org/r/20240219-arc-for-list-v1-0-d98cd92c760b@google.com
> 
> ---
> Alice Ryhl (2):
>       rust: sync: add `ArcBorrow::from_raw`
>       rust: sync: add `Arc::into_unique_or_drop`
> 
>  rust/kernel/sync/arc.rs | 106 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 88 insertions(+), 18 deletions(-)
> ---
> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
> change-id: 20240209-arc-for-list-a2c126c2ad5c
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

