Return-Path: <linux-kernel+bounces-38577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C23283C279
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1031F24EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EEC46438;
	Thu, 25 Jan 2024 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Qhz3ZHCM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DI27VjsD"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6A1C69E;
	Thu, 25 Jan 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185634; cv=none; b=bxheK0zoy6+/GQ+5oCCpVZ9zDdYY0/3Ca1IBS0/C3hvH7uptapeK2fSf9Xayi+zWeyRHc+CYsnIELYRiFncPN5bRbTHDsYPj4PXo2dXMHO3evsWHCjLu6zwp0LPrQdXGvupP9cUNpmEcAatpBbu8YDkttF1l2Fk0PWnVri8kDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185634; c=relaxed/simple;
	bh=wW002LqBW9IbuYi/opDK+aD4T+xvFlR1R51XeVtO4cQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cvN3NZcufPzyb72/re+/+UL/zOxbGgwlHxS8EOkPqhuaO20FEkJQPtVKKtjbZJltmG8V6TybyKrebey+66YTtnFyvOcGJtqX4Hrbn5seCJdO7W+WKNL8he3sa0epHFljkoN5p9MdCFiFufzHP5aU7vYtXtJaBB+39Q4C8jsaxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Qhz3ZHCM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DI27VjsD; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 789225C0079;
	Thu, 25 Jan 2024 07:27:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 25 Jan 2024 07:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706185631; x=1706272031; bh=by9e17p4Sb
	OQuMUvw9yQVjRsSkMsUr3SrHfJ/laHRbg=; b=Qhz3ZHCM0A2MCUj+5XfxRhJVO3
	O2Ivz5XGXCxJd/BGx2BD0S6Dz9zUhxAk001fHtcPfbdXoIgRGiffEUPv4WQf1uCE
	1yS3fMhW4XheQxgr/ktuz8VKrtRrh/inpkDdLyEwXem5HNL6ioijwf92eW/nNK3G
	TUEpCwQabLXMp/sbcOK4bZ4l29mjNItBZXJMms6Z/PHChXO5/luLzJDEkSXGsbbh
	RQncUjAGZIaJ0aPPlfnUxutpL8YyfcqunSQp5tNO3EL6jY8U/NWvsOH5oBpPWaQ1
	fX1yYVuZTaMK6rXYRmtuMGgSnlb8c98bVtW09lwZ+eXrqWYl47l/zCpMqz7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706185631; x=1706272031; bh=by9e17p4SbOQuMUvw9yQVjRsSkMs
	Ur3SrHfJ/laHRbg=; b=DI27VjsDLadMVpQUkzwg04V8tTBEb6Xfbjm/Bs1CD+Yc
	fO6ul8hQgf7Xe86C5N8Wcr5/CMKgeMMxi/cb6I3bcQ6RHCRa6oIBRiRSvHA1xJgW
	A4pf1yE3Ko2mwJ+kQQSHuVCej/q0dFuzCC44FEpbSM/k66Ik65bTrcak57RYn1Qx
	bis+MfF9NlshGqjK84KSSHOMOcaU0THauJPhFuRWLOwPeYs7lm5BQ7rwUmctImGw
	pduXxxky5tQwpwl4POfNTW6mQmbdMR5mYG5r3YZxRb+meHirymyWLf64s8lq84VQ
	eYj7hLcH05B92V93iuYIyJjVn1WB2tTQm7ulMoSCtw==
X-ME-Sender: <xms:nlOyZXGMI8N8ZWOBhtL7oeFXQJttfL9RkTK2GmWUprag-RhGdIAwtg>
    <xme:nlOyZUVucsQbJ0mqhJK0Nb0Yv2N7HRTiqjbLVvUBlbcX4T-fLjqCZmUN3iIw0GIwE
    oC2FvfXxNJmiy5KurI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nlOyZZJJx-jVKypAgXlJUzS5aqwlJu1R77AXUxv9E6hSTZYgbjARdw>
    <xmx:nlOyZVHrbtxP77ZPLtfF8M1LG_vwDoOZskjfykZUn_VwOdM1DXfKfA>
    <xmx:nlOyZdW7lOtSICnQPZzoqAsLXdRISUCeQ7Jt--cd4AKVTXoe8rytHw>
    <xmx:n1OyZa3L1Ub_XhwHh_uUzRbfbdHgUqEOam3L-mVS1QZi1isVuA-Afw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7AA4CB6008D; Thu, 25 Jan 2024 07:27:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <070574cb-8d7f-4fe7-9826-cec6110168ff@app.fastmail.com>
In-Reply-To: <20240124-alice-mm-v1-2-d1abcec83c44@google.com>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-2-d1abcec83c44@google.com>
Date: Thu, 25 Jan 2024 13:26:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH 2/3] rust: add typed accessors for userspace pointers
Content-Type: text/plain

On Wed, Jan 24, 2024, at 12:20, Alice Ryhl wrote:
> +unsigned long 
> rust_helper_copy_from_user_unsafe_skip_check_object_size(void *to, 
> const void __user *from, unsigned long n)
> +{
> +	unsigned long res;
> +
> +	might_fault();
> +	instrument_copy_from_user_before(to, from, n);
> +	if (should_fail_usercopy())
> +		return n;
> +	res = raw_copy_from_user(to, from, n);
> +	instrument_copy_from_user_after(to, from, n, res);
> +	return res;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_copy_from_user_unsafe_skip_check_object_size);
> +
> +unsigned long 
> rust_helper_copy_to_user_unsafe_skip_check_object_size(void __user *to, 
> const void *from, unsigned long n)
> +{
> +	might_fault();
> +	if (should_fail_usercopy())
> +		return n;
> +	instrument_copy_to_user(to, from, n);
> +	return raw_copy_to_user(to, from, n);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_copy_to_user_unsafe_skip_check_object_size);

These functions are almost identical to the ones in
lib/usercopy.c for !defined(INLINE_COPY_TO_USER).

That version has an extra memset() after a partial
copy_from_user(), and you probably want to have the
same thing here for consistency.

I think ideally we should only have one out-of-line copy
of these two functions and have that one shared between
rust and architectures that want the C version out of line
as well.

     Arnd

