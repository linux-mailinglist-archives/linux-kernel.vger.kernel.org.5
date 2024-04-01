Return-Path: <linux-kernel+bounces-127133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44445894751
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA011C218C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A65647B;
	Mon,  1 Apr 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihGlFXol"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C156450;
	Mon,  1 Apr 2024 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010454; cv=none; b=R7HqRTBgnwzo3VtV9RqvhPXCljBfyZLMGdS7reMj9+0tewwh+zEYdetGukxbSJonDx8F71qyx0Y+qUIMjbHc2oY3xXYLOCXEQdg/m/Sc6q9HQkgXR2I9rruZFfPCygB2ZsJps9Y5lUx01cH/vpTenVytToJ/nJP5Dju32HSr/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010454; c=relaxed/simple;
	bh=qd7DeB+UKGgiHHgmFI7NeiZR0UBVUqW1EUS3QsOSWAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF0FiMV9LBhv/Ys4c77BUa75Wve9Qbz+lIPuQKafnVOhUKJEpBCQnRIj4qhUp6twOHEFjrhroUIJ3vr9rwfBXiJfIhudkKQJhiL9wScFSJwi4cXAcXerQLSeKdOTnwZFSTfm2Vvw8L6QkyQXSXE8LkC1PZ8D5janYK08Z7Llfoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihGlFXol; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso4654030276.1;
        Mon, 01 Apr 2024 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712010452; x=1712615252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fun6t9xjAHzzOFt7K8uuNDThfEvVvoMsgmIVU5DYRmw=;
        b=ihGlFXolIcaMgomowbbckWYe7cDig5ECNMPwjtEPl+MbqFw/Z67doXIVwUDyU/Jcfe
         TTsaANEZmuxRbhpBgOeSh0hraKGaZCJGzuTSD49kOflEFWjchOv41N+S+pA1zqiQdw9J
         RHQY5zDT/wr4Kn9WC0fyoXZfBlXpDkGcwDjH+kbRGJjPmpCl92Dkf15DAruMrQSvRvLa
         hexImL3b5DzCprCAIyZ9dwCdAvcuM8+GLMpEgBkPQRwgpa7ZnwJUdrCkO3A32en+nU59
         zDQ2m8t/h/t51lByv+vMpw1nhGxw86JVbFoxsdsZtkG5XVUQAXLf+7jbRNgR4BB7HDjs
         M0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712010452; x=1712615252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fun6t9xjAHzzOFt7K8uuNDThfEvVvoMsgmIVU5DYRmw=;
        b=k3UIyiibU57Q5/bnL6gkwdl14dFF1SMbSYobOr8XE3H8ctvV0zeSNBMT2aPCA/iSnO
         QkD4DCrka4O13L3q2S7RjSnb05wsbO6tN+XoeT/gMQEiXQpIYXlHlQ8JhFIN0qnkSQrv
         WghSzxOvEH3A14Oy6RlIP92Xx3VI/H1V8y2/39Mwq/Y7Z2pwrX0NOR9Dc3qhKZDJ3yMA
         lnzNLPfUIEUngtaLzVXdg/DALKsaqCXfbg4yDmy+jhVMjSVi5JO6lhzXLqQB1j/r82Kz
         p1YSqOCpJ3jmajPLsv2w7Gc99HNHKxwcxO8SU3UiBA0T3Ty7TF5k977PS5CHJlYzKtS6
         IKeg==
X-Forwarded-Encrypted: i=1; AJvYcCVObKfxfmwebkCM3HtnU7pOMvqJwakrZAzdMgjdGWIZl57NXoojND16/PFnzRm++tL/5B3iQyKzZQ30aYdLi47NM1Kr8coBvKEAaEGd8xsGtFMUiBgf/+JwidNtM2HePNIlgv50Gv8WsMrcc4Y=
X-Gm-Message-State: AOJu0YyRDn4I+OpNpgfxZmwSdQxPFAavDXJ1WOVe8eG1ez3CD6cUroum
	/kmwAle4pSjSjsNN6CAPxrZga+hHAIixWUckL5c7sHqvw21BOUAZ
X-Google-Smtp-Source: AGHT+IFxhtbrdEbRKIE5EhZin4tZI9VxuRYFo+PIISiS0eV20MlXsziELGLLI9eqZum2nn0VYt1ibg==
X-Received: by 2002:a25:fb05:0:b0:dc6:ff32:aaea with SMTP id j5-20020a25fb05000000b00dc6ff32aaeamr8588124ybe.24.1712010451861;
        Mon, 01 Apr 2024 15:27:31 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id jz9-20020a0562140e6900b00698f825b08csm3118580qvb.70.2024.04.01.15.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 15:27:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 75EFF1200066;
	Mon,  1 Apr 2024 18:27:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 01 Apr 2024 18:27:30 -0400
X-ME-Sender: <xms:0TQLZtL3ljYYEwGc0VpQY45AUnmJGMsx2NoDA5NA1muPJ9K47421Zw>
    <xme:0TQLZpJMfLopoSVxPvFUsDfORZSVoXTtz-JW8jzuQOomNci-wCgOxEIKOEpS5lGYT
    Yo3inYBobMD26dJvg>
X-ME-Received: <xmr:0TQLZlsesD1Dgb5AxvxqxrG-2cKiuQ1CG856xJW7pcymS9OyWcl-_6eEHGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdei
    geehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0TQLZuYaCqphaMkLywE96DjK7MReH3qMO1bfIYoaXp3R5jLG7u6G8Q>
    <xmx:0TQLZkbcw_a0xXUgheqQAxv0LhqSsSDbrbfs8wj5JRXFZWoVR_tNEw>
    <xmx:0TQLZiBKuk4r-z8sxXlfp1ULorCIm8rIbfKso9BrpUHIaNmR4cV46g>
    <xmx:0TQLZibhB2xuYgi-qX_-FfceUzCGdKBaEOzOxLAKDbhi5DPS53_ogw>
    <xmx:0jQLZgR3pml68a9uI2sUt5oDOy07nUflcOmFcUuPWF6uHm_ZWoziGlBObXM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 18:27:29 -0400 (EDT)
Date: Mon, 1 Apr 2024 15:26:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: sync: implement `Default` for `LockClassKey`
Message-ID: <Zgs0nRjuLz9BaJQb@boqun-archlinux>
References: <20240401212303.537355-1-ojeda@kernel.org>
 <20240401212303.537355-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401212303.537355-2-ojeda@kernel.org>

On Mon, Apr 01, 2024 at 11:23:01PM +0200, Miguel Ojeda wrote:
> In the upcoming Rust 1.78.0, Clippy suggests to implement `Default` even
> when `new()` is `const`, since `Default::default()` may call `const`
> functions even if it is not `const` itself [1]:
> 
>     error: you should consider adding a `Default` implementation for `LockClassKey`
>       --> rust/kernel/sync.rs:31:5
>        |
>     31 | /     pub const fn new() -> Self {
>     32 | |         Self(Opaque::uninit())
>     33 | |     }
>        | |_____^
> 
> Thus implement it.
> 
> Link: https://github.com/rust-lang/rust-clippy/pull/10903 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/sync.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index c983f63fd56e..0ab20975a3b5 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -37,6 +37,12 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>      }
>  }
>  
> +impl Default for LockClassKey {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
>  /// Defines a new static lock class and returns a pointer to it.
>  #[doc(hidden)]
>  #[macro_export]
> -- 
> 2.44.0
> 

