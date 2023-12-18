Return-Path: <linux-kernel+bounces-4394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43575817C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C0E1C227B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6576081;
	Mon, 18 Dec 2023 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa4YFjyc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EC7409E;
	Mon, 18 Dec 2023 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4275b7eaa11so9873021cf.2;
        Mon, 18 Dec 2023 13:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702933662; x=1703538462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5h6hrI62ojLOpzwPeAY3F1dA9KLCwXHTZO6prPyeJE=;
        b=Aa4YFjycLVMMdu5VrJuJnqEX5AlruVyYSEFVnvXLS8ET91j5wmDce+YrkqKujOuX9M
         sOLjVgRZps5urqCjdP3Jrevb0D/kXNL1PkJKxkWLlNu7aNmOZuv7g0NIGDY/plytH6DP
         qtek0NFgeBwOmUuN1YFrktHSyNYvp14OlFqnirFcdYJ8a7ctwkiXvv1Z+anyp+3UTIw+
         V6aS0rVJcmftZ5F4jLyMoWJRiwQJOOr8vOkYlHM/Jf0rfwok9/hmbC5m7aFfXlG+90cZ
         gmvhsa9h9MQ6oNMEGqhdZxPbtr28+uWCDYJLAC8T9cjPev1bOm7tlsCCJaQamJ9uB4sv
         00oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702933662; x=1703538462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5h6hrI62ojLOpzwPeAY3F1dA9KLCwXHTZO6prPyeJE=;
        b=dD2roI9E4bBwkQXzu/frrZlGCjt/RgykdrfsBWt9A1LWpMy86tADIvLYYgsyBDcvx3
         np5Ur1jrb5KaYAhMDke9+IGYO+dZph/4bjJpasoUI1yJqZk/84b26Fl7PHNO7fHqvkRi
         /qh2wxxE33RX6O7vE9RaztKtR0cE9draJYHqsDZSsoSXyW6YS01IN5kJCxoBZ6egsUq/
         zFao6mybFfyyOKpnI2iCJM+YH/R4KhiWNq/Ocz0Jkij9Xfi6LTn50ila+djCrp9WbGV9
         n5C0bYl08iexWaHwYzgplLT0QLvIAJRjuPglgUbdDRgtWKdbz3vvGzuSm5Ob7BIgNWnF
         B0SQ==
X-Gm-Message-State: AOJu0Yzu5/fsYmeOQP3fR8sBFxGPfOvUuQzUVmEIOOTIi1MQPnaj3nUI
	8JFPSE+klQhF7GzGLJpeDLw=
X-Google-Smtp-Source: AGHT+IFzzzzdKO913OIdbEBwm5nuW1/cn+cN2FTsqMuUWx9WdDQvdBpbxlk+dWy0/8dPYnL9JsyOjw==
X-Received: by 2002:ad4:5f87:0:b0:67f:21f4:122 with SMTP id jp7-20020ad45f87000000b0067f21f40122mr6202149qvb.17.1702933662603;
        Mon, 18 Dec 2023 13:07:42 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dm11-20020ad44e2b000000b0067f486611fbsm1055766qvb.136.2023.12.18.13.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:07:42 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id CFCF927C005A;
	Mon, 18 Dec 2023 16:07:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Dec 2023 16:07:41 -0500
X-ME-Sender: <xms:nbSAZUCAfN5jwimL8GHc4LswcvF9VxpnYOOGLFqkdcQ7VprTeEZA5Q>
    <xme:nbSAZWg3MpkpaqudHzR37isMB82tDE0BxBQEXMMWB4HcN7WmaC4j2RIzfNKxgoyED
    4g5zKd_OvBHWWEhVQ>
X-ME-Received: <xmr:nbSAZXlfaZOXrcRZ-CGwcvxnKhUJAd-wjVkF3PeuehkKz7bVNWNgb_aRyJ4adA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:nbSAZazIE6bcoWdGio3_pNREw-xXfDpErnpJO6Ma0PaWYuemjCTCcw>
    <xmx:nbSAZZS9it9YCs8ivxKXwkI1J6ejYaW3D0xi_aCDc3aG0KDGsvA62A>
    <xmx:nbSAZVZMvHHPtZ8BJO59CFuMzJGSi0Q8h98A_FIy1429pYUtOQf7Fw>
    <xmx:nbSAZSjIMkysADa_nOPDVqst5Bjk5B3HQl69N6nzu9_CD33Lfs-6wQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 16:07:40 -0500 (EST)
Date: Mon, 18 Dec 2023 13:07:23 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] rust: time: add msecs to jiffies conversion
Message-ID: <ZYC0i875pOw4yjnK@boqun-archlinux>
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>

On Sat, Dec 16, 2023 at 03:31:40PM +0000, Alice Ryhl wrote:
[...]
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> new file mode 100644
> index 000000000000..23c4d1a74f68
> --- /dev/null
> +++ b/rust/kernel/time.rs
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Timers.
> +

Please consider the following mod level description:

//! Time related primitives.
//!
//! This module contains the kernel APIs related to time and timers that
//! have been ported or wrapped for usage by Rust code in the kernel.

Otherwise it looks fine to me.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +/// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
> +pub type Jiffies = core::ffi::c_ulong;
> +
> +/// The millisecond time unit.
> +pub type Msecs = core::ffi::c_uint;
> +
> +/// Converts milliseconds to jiffies.
> +#[inline]
> +pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
> +    // SAFETY: The `__msecs_to_jiffies` function is always safe to call no
> +    // matter what the argument is.
> +    unsafe { bindings::__msecs_to_jiffies(msecs) }
> +}
> 
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

