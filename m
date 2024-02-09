Return-Path: <linux-kernel+bounces-59484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9E84F7BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AA51C23069
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9DA69966;
	Fri,  9 Feb 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="S3/XM1R9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v6EPGKHY"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56E44C83;
	Fri,  9 Feb 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489704; cv=none; b=s4tsOZxZIKR+ddrXroVeYgnox46VeCMnSR5yUqrIRCbHdg3oSXOZIdpRcm9PqfinCvKnlPm4ubi3N8jkfSB4RKDZNoIkvKLrd3Hyx8irkjPrlIXBfpMl1neuIDhzrBRVG4EDv76sOePsWbiuQ8DNtAYqLHeizhsneD15LlkXg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489704; c=relaxed/simple;
	bh=MdgKh1QKbxz534VY+pTpXg0oSXnXmtnExQPKXVZLegg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Y1sOVDPlnfHLNN3nh0pBwGEhBQkQZ7DJB/CEXm6RAQuTAtyImmfo8PA/bKDp+inl9v8Sbnzq5mmeVXhPsQ8Ebm78qIjyUObvlzj2SKps1BkrFK+htjGmJh1WgGKLEMvxHRoymjAl5ygca1VzekTeu6hIVTS47BJcjfrvYYmH1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=S3/XM1R9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v6EPGKHY; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D10021C00085;
	Fri,  9 Feb 2024 09:41:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 09 Feb 2024 09:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707489689; x=1707576089; bh=RfpXrOgPMB
	uIAQYXOAV94jbrpi1e3bUYrcbdSK52a14=; b=S3/XM1R937Zow+EapKrmWrZWju
	diAdGAnkld0Pkg5Y3H5ta2KRc32i3bs6UHmWXjJ6NtqaG15M4eO8F4QEPDxa1/8j
	Fg27pEJJzRJrhNVYwlb+ieC8wA82ig5CA1unleV78rWuBtffnAikF3WENDrb3Atc
	yn2eqXaKNOMugVWSp6mfMKMgo4gm/ACus56pQocWfQRro/Y+Rhi1q6HiIGeW4AZ+
	81jJr1mUz4oAT7010oseOisWz03m2xn60LRs/V2xsPFsqq9eyO8BAQdJYA+TiDz4
	+42zSDXqWF5sRpegf4i5/Yz5gZ2UHbX/sgxgn5vSHTRN+oI8RzfMnXzKAHHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707489689; x=1707576089; bh=RfpXrOgPMBuIAQYXOAV94jbrpi1e
	3bUYrcbdSK52a14=; b=v6EPGKHY+rqQ4ZeZt2i1OZF5oPBc/x3vybijI4oM5RGT
	eTIzOUUchqL6HX1MilRT/Z1ZRvlucEMX9ZiRND8XMsbyXrFC4mEgz+QlrE2fjVj2
	MTS/Se9MuD73i4derA5n9T+lXGZraTa8/5j6fZkqNZd4BBJGyapd/M/bwJ42N4IN
	8e84WiKF95alnZae1PsL+Qs+O1HM36k2J1pHpa/Ta4qyNYpPP5ch1yBpCavfC1Vp
	FlpSKlPWoHcIqmdG3tL263GTmEV1D7qejeHkNRO3xsjQt2G2ZM5zr31ea4BeAa7R
	XOS3lhVxVZAx5+1IUOgq6oeEtIs28FI9qZjiStrxww==
X-ME-Sender: <xms:mDnGZZycIJ_u9fGEWzfYdWfbUtAAEqg9I6YPD7f6NWY8n2yAMU70wA>
    <xme:mDnGZZTyXP19Jbxt2Z_1QNldMFudbWss85x1h9WWxUVK-YXYnssnchPSQJlCM6zGp
    woykBg3N1AiBPpu2pY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:mDnGZTWZVFKny5MPZ0tPuhRY-XkAfEByWCI4ovjcT4eZPIQRpXkq1A>
    <xmx:mDnGZbhFaocVMS__xRXFvrUpK8cqxuzWFj3TF0rVaLF2oHt4SzZ-tg>
    <xmx:mDnGZbDDxjRwr39Be1fcb32WjXAtB8gX4F0lgBvh-rT9L2Xl-qh5NQ>
    <xmx:mTnGZYy8kk7UouiAYf1aEHgnl6GVc1Z4BxsUFlmPxxG_3UJOZWy9oU9gxwA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 88BFEB6008D; Fri,  9 Feb 2024 09:41:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6eeba3ce-d66c-45e2-8c34-ad0109ec2ef0@app.fastmail.com>
In-Reply-To: <20240208225608.11987-1-kernel@valentinobst.de>
References: <20240208-alice-mm-v2-2-d821250204a6@google.com>
 <20240208225608.11987-1-kernel@valentinobst.de>
Date: Fri, 09 Feb 2024 15:41:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Valentin Obst" <kernel@valentinobst.de>,
 "Alice Ryhl" <aliceryhl@google.com>
Cc: "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Carlos Llamas" <cmllamas@google.com>, "Gary Guo" <gary@garyguo.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Kees Cook" <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Martijn Coenen" <maco@android.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 "Suren Baghdasaryan" <surenb@google.com>, "Todd Kjos" <tkjos@android.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>
Subject: Re: [PATCH v2 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Content-Type: text/plain

On Thu, Feb 8, 2024, at 23:56, Valentin Obst wrote:
>> -#else
>>  extern __must_check unsigned long
>>  _copy_from_user(void *, const void __user *, unsigned long);
>> -#endif
>
> This function is now unconditionally declared, but only defined if
> `!defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)`, i.e., in the
> common case where it is inlined and Rust is disabled this can lead to
> link-time problems if someone decides to use it.

Yes, that is intentional.

If someone tries to use it when the declaration is not there,
they just get a compile-time error, which is not all that
different from a link-time error in practice.

It's unlikely to make a difference here, but enclosing
declarations in an #ifdef is annoying when you want to
reference it from somewhere that is parsed by the compiler
but not called without the respective options.

The if(IS_ENABLED()) and PTR_IF() constructs in particular
only work when the unused functions are still declared.

       Arnd

