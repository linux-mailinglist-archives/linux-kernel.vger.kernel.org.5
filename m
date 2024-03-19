Return-Path: <linux-kernel+bounces-108182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE088072E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846DB1F224C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3961151C5B;
	Tue, 19 Mar 2024 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfcy594L"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BF3C00;
	Tue, 19 Mar 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886632; cv=none; b=aE7SHyggrjhrj4PDB6+NiAEZu0Pexm+WaKXLwh5NqJddsw2C5/Ot86r5+YVSolakC2S2DYgUuUfHUjkfs5ykJXbhOWPeySHPybnng/Qp3bZ/Opoal5kzXkucFVUMUhVkxKISBVDP+X58VKKzy2VNKmbIBZ+WBB7a51t2RbtAFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886632; c=relaxed/simple;
	bh=zIT8Wfgemy9DaAZc5faN7nuYrZ5y5Mh4VfnUshKlkaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owOwkskAQZTs8ZbeTixLyp8xyJJATRqsPrcVT1nG5np20P/xvSkLciVkIK5OXsTfb053xLMjngLmZBoKE9NUpJOQLJ+UFLFAIFUahSzkdgeODTP9RJqz9rJxh/LzwPxLN78pUMx2/LG9l1Tn0B6IpfU22abBKJ8p3USsPCk4DUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfcy594L; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69145fc4265so42065686d6.1;
        Tue, 19 Mar 2024 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710886630; x=1711491430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mKF14OWHZkkElq0bOodAxiF/Zp1dq4sueaSM4wOt9E=;
        b=Jfcy594Lf/DZCzPvMCgnjIut56CrS//mMOIYQWXk1ElUSkN67e/al2GR3GdjWDCnHQ
         gDhp4ev4VymzpWviMTY07rKb4V5TdSt8IqysXamoy9KudHGL2AEoZJNCIvbNUsoTROkT
         HCccZKhfDRr8gKCQzpC0r1nulreW8QuyghDY5GUKfvXJx2RUlQlZ4mYZQDXBjfJyusF1
         MQY13wqhMNDrUHqAqRhQUrRdwzQD7rH/yzCgL7tqhrT17GLxx1xhzntI5+4zmORspR+1
         A+EcA1Jepqd+rUUlziMoHb0Cgn9vsLzFhFu4K++QjMhuvb3rIsFZY0sQ8sSfb06g6S/T
         MH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710886630; x=1711491430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mKF14OWHZkkElq0bOodAxiF/Zp1dq4sueaSM4wOt9E=;
        b=OIfp/zPLlhCL3+OhRwrzARfE1fvx5JZ16Y4/0MG/wTO7LYLDlUIwWH/onyLahrCYzw
         +ESjuGrfUxWQqs9mJ3mcn/+HWfa4k/iOXZtUGKo508YYWlZM2oAA/iEklaFu0ncimSI7
         oCkHHwc1l1CZ5cvV8DXnFp4P96iuJCwx+bSHCWJqbeVUHtuX+cSLmoQ9nx6KB2QXTX2k
         F4xFyJ1jsT2gvDCLmPi/ZgSgOgsyU24YFxScF8CCfjo2onwvRhsCth/Ne0PAl4E1hG40
         ODlGfsd5D74AW13rQZP9bA3uz3o2E0C87mbKoPhtNFnWEcH2srVGu3gFF0r3wi20CV+p
         4tzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy002H7PjDZc/oSsNfELI8lDRayOZiZ84/f2f2sqzmq5dWCSVLZXLs9EzWdIM5SKte0HdGATMXbZ8+iWswnnRxcLPvenWSo078N3Fb/g4OijMrt3Yh0UwZFcVtlfMkGrOMYqL4YI+JzcF3FTk=
X-Gm-Message-State: AOJu0Yz6FODeM6QjL//Qc/7qzkHinyJ7gC5zCUnPKMqJ8e2NEYIQdnyD
	b2YZ/8S33ZPTZWSnbMA6lIWlAOiGRk3Da0i+VOtteEIwKZlyeG7z
X-Google-Smtp-Source: AGHT+IFgcZi0l7LPJvcopa2SKXhsTMMmijH0zolxqJkPFZ+cvmw30Nbu2wYxGYeecQxYVOmJXFly9A==
X-Received: by 2002:ad4:4d53:0:b0:696:25e9:92e3 with SMTP id m19-20020ad44d53000000b0069625e992e3mr3689993qvm.57.1710886629980;
        Tue, 19 Mar 2024 15:17:09 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id im14-20020a056214246e00b0069049298fccsm6952366qvb.65.2024.03.19.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 15:17:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A448F1200066;
	Tue, 19 Mar 2024 18:17:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 19 Mar 2024 18:17:08 -0400
X-ME-Sender: <xms:4w76ZRdEwreDqNILDtfTl1jTvfIPze8mOBIiei9YBgNx26u1HrcRwA>
    <xme:4w76ZfPDDcZ4PNKIG5IAcnnNWCX4K3tT5tr_D9jP5D42H6rLVUKx02VqtYgTm7fCC
    GHi-UXFuJWDKNW26g>
X-ME-Received: <xmr:4w76ZagYTQfrIggh3KQMb-jNH5xcgikEYtA53oC4BXH4drSOeo8YYITquoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4w76Za_bvQ94Vsny740UBsJkJcbhWCP4Ngf30x_piKG_bfjBx7vPoA>
    <xmx:4w76ZduHzcqgWRUjd1VSM8R42w-mW01s2qPm2YjBcXtApT2wqFhfZQ>
    <xmx:4w76ZZE2XKp01y4qK3OcL8_AE-olVYamzNskAELZ1f0t9LfOKf7yHA>
    <xmx:4w76ZUMTk-B6Evl0_vJBk2hz5X8hJqktK-1uvXP-EhWbeSUsLpOczA>
    <xmx:5A76ZR3lN2k7zPsI7sQYNeEgt5UeW-z46pJRFPKkkj-_bJnbpvVmDNvuk3I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 18:17:07 -0400 (EDT)
Date: Tue, 19 Mar 2024 15:16:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
Message-ID: <ZfoO1h0Kzdz4ln26@boqun-archlinux>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
 <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>

On Mon, Mar 11, 2024 at 10:47:16AM +0000, Alice Ryhl wrote:
[...]
>  /* `bindgen` gets confused at certain things. */
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
> +const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
> +const size_t RUST_CONST_HELPER_PAGE_MASK = PAGE_MASK;

At least for me, bindgen couldn't work out the macro expansion, and I
got:

	pub const PAGE_SIZE: usize = 4096;
	extern "C" {
	    pub static RUST_CONST_HELPER_PAGE_MASK: usize;
	}

in rust/bindings/bindings_generated.rs, which will eventually cause the
code cannot compile.

I'm using bindgen-cli 0.65.1, libclang (16 or 17), rustc (1.76 or 1.77).

Anyone else sees the same thing?

Regards,
Boqun

>  const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
>  const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
> +const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
[...]

