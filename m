Return-Path: <linux-kernel+bounces-106445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A150E87EEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE441F25EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A45578E;
	Mon, 18 Mar 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUmmzffP"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E155C04;
	Mon, 18 Mar 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782748; cv=none; b=EeWBhh0wYhopE9Ns1JmT6w15wj/sAgm3NEFPEAvcZ1P2AQQvszMbed9nRxl3TgAAVtedrMRqysJLaz32jKRQ3UKvFZGVOop6ycx8m3hlAJzM8LZ8gKLlWfobJ9dMd+/NfxThjMmSjX3uj1O9aAec/J4KhVvu7OhopVYtbQ7tvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782748; c=relaxed/simple;
	bh=Dk+lxLvzQSII1ppuHMsEumUyr1mLcNQ5PwAlccWM90g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8KQ3ObQNE0IFzzecGnTVZMuaGD2aWEjSwn9Q1s96lIEeB3n5nQAS7HkpZrVOoiFWPaHkJrMNhxbSEtF9b6j6skUsvQOs6mgGSx7/srUzP6Whj7UMoiR1lEvdp6zA9EcI255e8pKhZJsdmKQVxAJiR9k4gDFUraBYESloTPpd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUmmzffP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789d76ad270so270850585a.0;
        Mon, 18 Mar 2024 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782745; x=1711387545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQhFqM2G7K5yM3U5uFeeKMlWbC2wWAcsOMDgWC/Z7yA=;
        b=lUmmzffPOjyroloiK3BOHxDcVFnA0XyKc9IzrZsT+Agn2nYXOymptZhKrQZ5WTwkzr
         1k2bn2/zW7T8cbaJildca3kHmtRi0jDzcEopitXfhUdSyfewx0lYrpnTAx/+12g0ADAh
         HB5ZUSf2bbxT/0bGCbnZ46CKa0ldrIoF9UA/AqMiaGejzirI0SSBWzaW/iPDq0RX52L7
         lwNp9/na0MvD7oHzrfMf2BTauIg0Mi4Das16YsHYRtDOJj8fnyiI+Amdr7fC3wx74SnV
         +s/P41wFOY/b5isDcxgsFdv5E6OLIl7bGnQeWWh3cbW+cLFwraEQKykVIvyi6/2jdfCR
         5PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782745; x=1711387545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQhFqM2G7K5yM3U5uFeeKMlWbC2wWAcsOMDgWC/Z7yA=;
        b=TljsqgU/xjWAOd4fY1KSd2HfhYnF/iopBP/SUJgB0ipXhelF3qom2oskvfGmN2k/a8
         oykJJ/d1gCqZBqtK+VxLlpOBkoEt8XgwhAYY0u5fW357AVbV4OHSmOTqYIazksM3zvGg
         IrOAP6VjpmC7lcJoVhpk7qwlROKYpBWPXgMEhCU/c8TJ4UcLM3RGsfluk90CFoIzzJg4
         zoQvkQgUVfgyp0PtLBLUtB+DQUUiDzDNglcvFINZOEjJiMbXgcdxwDUqOihhtBbyyMeo
         66RsNOUU9yOUJUm93q3fvytGhP/6tl8NGoFiKzrFiqYf4PMFLvjQeklxVUCdCSj/Jj/a
         W9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW5DL8kkNd6MWtWc1P88PZB4+nCQzl/GMB0/r2XrvbjAQd95RxetIUwXnfro7ZKZCxV3bNriETKBgWTOxAxX08mk64CnENMZiAnkZi/4ipAopwDcO6IXiFpwX3Y0nKLUQfcH/owAENl5K0aDUSrXjNsnGo81jbASErZwfnU96yH8OGqip8=
X-Gm-Message-State: AOJu0YzCylmEhl9PUApSd3lBsQfZGxqBGrzXFVGJ3STMV26dBgezFLJw
	s7Av2+M+a0X1LSX5EbF5vbp7pcTa91dYA0ZQitgZex1L+tgdoZD1
X-Google-Smtp-Source: AGHT+IEPT8GvefrCTp798ktoahhI5AJuc5hiLB3HfAozxROwS2MHMatSMVTJs5f7/vuo+To/3ULX0w==
X-Received: by 2002:ae9:e41a:0:b0:789:d55a:d10c with SMTP id q26-20020ae9e41a000000b00789d55ad10cmr13094036qkc.48.1710782745104;
        Mon, 18 Mar 2024 10:25:45 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id x14-20020ae9e90e000000b00789ea3555acsm2675665qkf.19.2024.03.18.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:25:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F103E1200043;
	Mon, 18 Mar 2024 13:25:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Mar 2024 13:25:43 -0400
X-ME-Sender: <xms:F3n4ZbqyCB61jkAPBWwCYwo_k1FczXkV48XlQOCHTW3zlIAUQ9LkDw>
    <xme:F3n4ZVpRtfF9fdd1LPjfYstBCf282bVh8Msgwz4mobDc4MR9Z_OO4aFv8D-1VqabA
    XL-PfXvyTuHgtoVBg>
X-ME-Received: <xmr:F3n4ZYPXotOwLwJryqTRd-cL7hPcEbvYiiBOkGEe3lUH4ctGoX8hXSJxGSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdei
    geehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:F3n4Ze7gnPUXITE4fm_q1Pk2mYRUt-4ZNqUNHZr3T6ipOPRzhkN0BQ>
    <xmx:F3n4Za5djYFmIZtqGnGxK5Dg386fyzvqQrwBc898_OSqNzaQcUAbbw>
    <xmx:F3n4ZWjTqey9DNhVypXLcvZiuVWleukdi4ExrEuUQH-yd60Tn9Z9pw>
    <xmx:F3n4Zc4EvN4VSjR61ET_VGrOsp0xN8zyxUo0wH--LXQxkiizpQf2xg>
    <xmx:F3n4ZZTWYx5NVjmGjx7WZlPxgK0fdB-64TXAQ-KBvPa2njxUpU5N8rrpGLQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 13:25:42 -0400 (EDT)
Date: Mon, 18 Mar 2024 10:25:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Laine Taffin Altman <alexanderaltman@me.com>,
	stable@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
Message-ID: <Zfh5DYkxNAm-mY_9@boqun-archlinux>
References: <20240313230713.987124-1-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313230713.987124-1-benno.lossin@proton.me>

On Wed, Mar 13, 2024 at 11:09:37PM +0000, Benno Lossin wrote:
> From: Laine Taffin Altman <alexanderaltman@me.com>
> 
> It is not enough for a type to be a ZST to guarantee that zeroed memory
> is a valid value for it; it must also be inhabited. Creating a value of
> an uninhabited type, ZST or no, is immediate UB.
> Thus remove the implementation of `Zeroable` for `Infallible`, since
> that type is not inhabited.
> 
> Cc: stable@vger.kernel.org
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed` function")
> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

I think either in the commit log or in the code comment, there better be
a link or explanation on "(un)inhabited type". The rest looks good to
me.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/init.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 424257284d16..538e03cfc84a 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1292,8 +1292,8 @@ macro_rules! impl_zeroable {
>      i8, i16, i32, i64, i128, isize,
>      f32, f64,
>  
> -    // SAFETY: These are ZSTs, there is nothing to zero.
> -    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, Infallible, (),
> +    // SAFETY: These are inhabited ZSTs, there is nothing to zero and a valid value exists.
> +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
>  
>      // SAFETY: Type is allowed to take any value, including all zeros.
>      {<T>} MaybeUninit<T>,
> 
> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
> -- 
> 2.42.0
> 
> 
> 

