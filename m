Return-Path: <linux-kernel+bounces-106684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C72187F1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147131F2231B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5458AB6;
	Mon, 18 Mar 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvdQ02Mz"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05B58224;
	Mon, 18 Mar 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796597; cv=none; b=p9in9BwL7Qf/sVT4Kmv4HScHJwrsViqPomkxIxciT/eaJXasQa6AsG0e6vShYFPjsGWr5xIISYYJZsixHT/pe2hINsEjy+XmjNG1ZGG+RFj+c+k4I9W7UWv5HTlwrHXIbM73hM0te4n48wAuooVjnv2WuYRaTFrxtxLPA05PUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796597; c=relaxed/simple;
	bh=Yt0f+dVHrji/FGnjmFC58DJf7pxYkZrEgSIp3AfMov8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsInghL3AoncXztpGWOitkGWKYy1oCR4ji8iBxcrNgjnExBMGTtTdvf8QQxAE+yIud7MZ6uE8FkJugdAgsoJA8jQsFabkJ7eRvWEmMFfZdA/0hWFnGnJ92paY4sjJdSdrLes54lE2ZmblNkCKnHvCY8HgSLOuwnRGuocOI0n7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvdQ02Mz; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2297d0d6013so98653fac.0;
        Mon, 18 Mar 2024 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710796594; x=1711401394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QJWxTmIJrEhWMzXrfsFzOSKGe8edB69jBc3Ml/9B9o=;
        b=PvdQ02MzLXob0fpaxEA6zwTIGl4vXGeL76+vQS6ac3/ilsLcBMWrqC1XPDe+mQVgJL
         Ni7mQX0t7TWspGmTU+PoA3e6t/EonMkanQ2NSNTHFobpwidLy7rx2vdnb6gHcjXV0wwX
         a2HubcDGA9CyYXwzRu5vfradQ/CwK9l4evvaVpcCESa//pAWq1iqWDppmn7M++TTSCEd
         SPJwbx1S4ONjDuf7JRKgg/It6HZbdSUmt2OgIXLWQ3UFxIFdkMjUgNVvxyd2nOcgyZWh
         2vX5xVHqJ6r/H3qmhUvTIIJW0eKMBr2FPkEh5NSBmgjFWX+VkZe709/M2LwfMg+yOVFs
         eANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796594; x=1711401394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QJWxTmIJrEhWMzXrfsFzOSKGe8edB69jBc3Ml/9B9o=;
        b=ZI5X9cwmgUW4SOpXUxsyVBE2OdYFmcNHUGEtahJhbzOvFKEVkVPJ3t5bss3icxyV6a
         lRIjSTwu6ScRazyBz6e96aUkUfEYFOht354vt8HF1270jE5/dHZ2IKrc5WdXyHiv20Vk
         NgWIaLqokPp12hQFD1umc4XAcPbq3wE58hW7CGp0JViMF2ovsEuNPLPMcKY79BttXGFZ
         QgN+pB2OfDISZZMcj52ssennJgeFgiMdgOpMLNtqQuU90RPA2hu2+h3JrJTeKvva7g+3
         dZllJhNIxr6r75HN+ye6xm35/rL/v1EgD3atsAlKnyCeIi3cNzcMZtNdNrgv0b6US9bB
         BFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTJrPvl7A2qF2X1IRnvvFibvKLtnqh3A07PG7AKvrKX1EcUcgiRteZaTc4YQGdCJ29OP+I4swrVl4rfgj+s8a6BwkwOTe+U+tQAhn98o1FIyjkotvZfYiW/UncYgB3m0xcu4Jq6JwJPH/+4dU=
X-Gm-Message-State: AOJu0YyVJvfmiM3ejBQ+W7t2mRXtNEyjHPrkK6O6aB/BXQ60e0jvXrR/
	AT9U5L6f29m4pHAfU/7j8O5ERdPb3zr8mhKJJmd2s5oa2gsanvRM
X-Google-Smtp-Source: AGHT+IEVxMBj1ySrAZy1h4aIv0Q09QPCGofkuXyjet6GfgHFvDWyvLhUpyruY9PUdSMRW22egpzpKQ==
X-Received: by 2002:a05:6870:2315:b0:221:5c49:5d02 with SMTP id w21-20020a056870231500b002215c495d02mr12691764oao.51.1710796594664;
        Mon, 18 Mar 2024 14:16:34 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056214260f00b006905c8b37bbsm5715590qvb.133.2024.03.18.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:16:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 5A5AF1200043;
	Mon, 18 Mar 2024 17:16:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Mar 2024 17:16:33 -0400
X-ME-Sender: <xms:MK_4ZUnSqbuoSRdN51SKopiueOmcf8Mn61jAh1cN7rIqsC9wUN-XRw>
    <xme:MK_4ZT07futncp-PmqIfIMgcC2BMxLJM_sosJWX_MLyhQLlhSbdPR-WC91Q8ABoG-
    kERW7r0M3fk5UCMGw>
X-ME-Received: <xmr:MK_4ZSpflCeIuYa30osxDA6pUFQ1nflaFs41mpjrGCHz6QSB6bluVC88q-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:MK_4ZQmtR5N5La4Q6xWKLUwfz9qab6ckAYBkEKwxAxugKvA5HwBqOA>
    <xmx:MK_4ZS2HiqmNAhg5XqImeHmaTPX5MkzWk6TBp29w7eI34CwLhm0ZLQ>
    <xmx:MK_4ZXuY0MlJl1TU9idc_DKtiMOyrMARh_yx8jlLc6woBLHjA4wC2g>
    <xmx:MK_4ZeX_0ATj5D4kM6Oaw-uJ0MzoKbn4iA97BWxnhLvD28YMcdGuHw>
    <xmx:Ma_4ZXdrV0oXuSVF9Z8dgDwh5Gqu1bppYJnNCRHQXBt6tzc09J84bAXUhB0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 17:16:32 -0400 (EDT)
Date: Mon, 18 Mar 2024 14:16:17 -0700
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
Subject: Re: [PATCH v3 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Message-ID: <ZfivIRxNmjaljsuP@boqun-archlinux>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
 <20240311-alice-mm-v3-2-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-alice-mm-v3-2-cdf7b3a2049c@google.com>

On Mon, Mar 11, 2024 at 10:47:14AM +0000, Alice Ryhl wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Rust code needs to be able to access _copy_from_user and _copy_to_user
> so that it can skip the check_copy_size check in cases where the length
> is known at compile-time, mirroring the logic for when C code will skip
> check_copy_size. To do this, we ensure that exported versions of these
> methods are available when CONFIG_RUST is enabled.
> 
> Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
> on x86 using the Android cuttlefish emulator.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

