Return-Path: <linux-kernel+bounces-60368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2830850415
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9E41C21EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9636B1B;
	Sat, 10 Feb 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Fqn+q85q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGJX3AQm"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C024214;
	Sat, 10 Feb 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707563261; cv=none; b=uQTToMduUaFTG/urmxZwjTSnYZG/dGHmx2fMwtkB5mYla8ON1ucnhAxgYQQEBrfQ2zvU17VMDPcNhEarlGXKfz+435ORbqhwH6ow7ETCuWfovcvf6g45qEVVYi5XSKCK/upc1DovXg/C+pn2YCt03SnTQBgYrgkuxpt/uUw3/gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707563261; c=relaxed/simple;
	bh=V257+PDqi5+VBHKReknHO8ELYhcIYSMx2YycvhWf8dU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=t6MmIOB1F759VWNY4tTD4K9ClMLMxaPPklomWFj9PIPKm739hEgXUYHLicf+VzCDIW99kVfqhXoKMQ/4epCb5yMhB7NKwcyLvgp6CuZNb4k5nHoLui3qeVO6LAFZAobNvl+fBncJXijRhLZvvVKrS2CVWcWZ1JQ/B3Y4Cj8ukqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Fqn+q85q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGJX3AQm; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 0C7483200A5F;
	Sat, 10 Feb 2024 06:07:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 10 Feb 2024 06:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707563256; x=1707649656; bh=9uilVm3D/M
	Mbser1uZtQKDyGLwAzTQ8TW6+338pZ8yw=; b=Fqn+q85qMMTQgeeFDEsmpSIl2D
	X3wNRSmv45afnLiC/uz8FvyWsAnpz00Cz6lkz6/Qo+1U4GtPScr2zsY4S5Y/nyW8
	3kBnJO9nN5adabBnZPZYuHAkoVkeeW70nTYu6inc3Y8ocmZO3p3aFJ0gvP+JLAk4
	By+xNlMVc7JIAzzWClOinLWJqp/a+uxVbWPTMDHHv9cpf4fg8Hv47ZGQ4JtWInir
	mXsx3boylvQ8R75ePufpt3Em0Z2QnKzNG/JjNQc4V77/xNSrc1xkB9AFEnSgmRhe
	eGSY6f9/Q7uMi9iqv33H+k/oOnGy+lqSePzIXROCpjnTZj2v1gW/5JqYlrtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707563256; x=1707649656; bh=9uilVm3D/MMbser1uZtQKDyGLwAz
	TQ8TW6+338pZ8yw=; b=cGJX3AQm22MSYxwVTGgvL+mgcY4JAQMN0KbgVweiVAbs
	TVpoRaiY4GVG/HHa1pHNi3eQcdI5Zy1Hq3o8ko/AewZttye6TQSmzVoPDVMKz2os
	55W+wOUdwZwpjgiiS8Q6zmVGMU8S4CK1cGOh2RwN4bfAmvdcL9J30DTDg+LI+GPa
	++vToLjf6IOS6fLd6oGS9rft/KqjMveBHGcfsh1U+uY3e+VOFrCReP5b26OUrw0L
	PQVM/0zeulSDYmyxthLgv3sqn4HrENEuA8h9a9GhjIAixOHa/Bpi4kgpAbsyAEjG
	V0O4v0DyyUbB0iPyqTOpQbU2c/T8JrD4n3Gk8O2wQg==
X-ME-Sender: <xms:91jHZZyHoCprPvf4x45yC4a6Yjtx14hY3whrUarkrclAriDtYHFywA>
    <xme:91jHZZQB9vO3o2F9iB_N7qUlh9pXH9o-N4A-bySiNgzUf3Mdk1IeAvJM9h6TJ4RrL
    lLp1lO_ZZEsDgoYcF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdekgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:91jHZTX8-ag8N1lBgGiGUHJ8h95C2odBrVs-GDUgvdgngwVz7Xwoqg>
    <xmx:91jHZbhsx0Yx6UfJEo6P27knUhwPnVoHb-fC5cQuZ629_7wqnxHaPw>
    <xmx:91jHZbBeelQa3F2V7VZUfRDxTE_znH00nxalAS9KxgdKlpHd64gu4Q>
    <xmx:-FjHZZ5K-wwnea69aZ0UT8lCYw4q95jy73IL340a9VETyzE5kXJ8mg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BE585B6008D; Sat, 10 Feb 2024 06:07:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4f0eb08d-bb5d-4544-aeba-ac9d8a663005@app.fastmail.com>
In-Reply-To: <202402091606.A181673F0A@keescook>
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-2-d821250204a6@google.com>
 <202402091606.A181673F0A@keescook>
Date: Sat, 10 Feb 2024 12:07:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <keescook@chromium.org>, "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Content-Type: text/plain

On Sat, Feb 10, 2024, at 01:15, Kees Cook wrote:
> On Thu, Feb 08, 2024 at 03:47:52PM +0000, Alice Ryhl wrote:
>>  	unsigned long res = n;
>>  	might_fault();
>>  	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
>> +		/*
>> +		 * Ensure that bad access_ok() speculation will not
>> +		 * lead to nasty side effects *after* the copy is
>> +		 * finished:
>> +		 */
>> +		barrier_nospec();
>
> This means all callers just gained this barrier. That's a behavioral
> change -- is it intentional here? I don't see it mentioned in the commit
> log.

My bad, I probably should have explained it when I did the
patch as this is very subtle:

The barrier_nospec() definition is a nop on everything other
than x86 and powerpc, but those two were using the out-of-line
version that did in fact use it.

After this patch, the out-of-line function calls the inline
function, so it needs to be added here to keep the behavior
unchanged on the architectures that need it. For the rest,
this change has no effect.

     Arnd

