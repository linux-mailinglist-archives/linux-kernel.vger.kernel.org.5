Return-Path: <linux-kernel+bounces-106995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B487F671
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C81B2203A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170838F99;
	Tue, 19 Mar 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmxJF6JK"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CD2744B;
	Tue, 19 Mar 2024 04:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710823160; cv=none; b=bltRnzgclthUccmZc4jQp0bMYTh4OEjzuCw7N8n8LXvHUrgroHxteFrmBXJp+JgdqTcc6iEgQfh+vfrjXrvSRs0pxu5NaiAiK664SdIKPGPQijQKBIOgGg55et387YMu4E8vC2hfE6i1QdNK1/3SEQwJ4td2F4SMkXIJ7kY0008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710823160; c=relaxed/simple;
	bh=EX6GHgLPuSo2ubcFe0HUyPHI95YPFIuR96s31sKY5WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPHV4yc2OKNusOh6qrkGO+MVg/p2x9D/hZF0Vq04PjoPPX6vOceNQSk0yHUnIoFKm+BFMuFdPDcO78Exja0AgFMOXTz1A8EIkl/qLRQb4wxz9Wwh9qHyCeuD17ekiuKDZ2U0paoTytunbsJpvh2K9ZCCu3uSMYMNrsvSbwSpfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmxJF6JK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-789e5021703so188729885a.0;
        Mon, 18 Mar 2024 21:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710823157; x=1711427957; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TCcPcWRQCvkbSDI9YFfpJrZ4gRBUtJwDb7Mt4FY2BYo=;
        b=VmxJF6JKEYKGeVdz3E7CS2rN+xSq6gVFFgm0jkklQTq7F0mpZ4wJXHyZlUIRlbpVOx
         dKYyV6BOf9I4xGDJSjekeOzFsiu3uPcM0CRKe/LYo//lmOMuyPsj2u8a9OdbovVb7Tax
         wdDMLDTo/Cs7JpHGXntoLpC+vs/KM18gcBsI/Yq2TuNI0ZJx9V9mW1Upd7miLnl6ZD70
         aq6B+ZrDEdV7053YnioEsqp3weGeavFR5ty7ZU0KW4PJNjIgvHu/8wQK6KyXSKqUcoqa
         dmqTgHFbvR88n1OW/o1GHDJ1BHRtHkiR2+yuWbMe8jYpzTy21Rg/FHJzr0s0ryeHk9F4
         r7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710823157; x=1711427957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCcPcWRQCvkbSDI9YFfpJrZ4gRBUtJwDb7Mt4FY2BYo=;
        b=ny+20ERWjR2tdWUyN810sasfe8/naMf3ePBVl343SQm7r8vA+hEpLfqroSjLDIlV0J
         rnFmfElw/HKE4ESWpC6+mItpU4+B6En7w/VOWpplshyjz9EY6lu1orpop0Xe+M631aJp
         gFDghhnf2X5aKJ7fYn3yBRVUy3hhcWb7ZQFPI/Bp2bUFMx+Pa70bgNH+M67HIBkQV7FA
         mJ/N1AtNPpIYNZqgU/AK3UTbYltVebKDlgEoMk8iZfpFphYJ8rEIKyhmJc6f4O06eQS1
         v3cI9O/7eevmTYXXKzNhUCSv74VkCo7OhwpWf2CaBe/++0B9OmuehmgfHYoeQadyAjlZ
         w8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXTWTk0bsoBQ0BVu6+xPorMRC4se55vBtGTTkbABCRBnbpLj0gcN1GFMfAcznFFuuFh2xC0anEUWsVoKabOEqdhhvzHcqI42LEOCAdMrWzxcLWlXXrcJKqGTAZ+u/HD5bQDVv0UVqbdJoMkByos05FH3t98wtp2YCGnm6JDFbVah2FcID8=
X-Gm-Message-State: AOJu0YzafC/gRAG7/YPUBOSFfDVfwAV/grJmPHvX8zQoROhXX4L54knZ
	kro6Z81819hFTUUd0aizvkbNCnBAWH6AFKFMJw48UeIkJcFpjore
X-Google-Smtp-Source: AGHT+IFN1Yhduoy7Ie2uRd11YLexgCfD2/7uYVkisBsxlA44/RQ6lr2E8lvsgj2r9j+5kmdSkL2/Og==
X-Received: by 2002:a05:620a:44d1:b0:789:f2fe:4ca1 with SMTP id y17-20020a05620a44d100b00789f2fe4ca1mr2543239qkp.52.1710823157671;
        Mon, 18 Mar 2024 21:39:17 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id m22-20020ae9e016000000b00789fa326156sm1925414qkk.82.2024.03.18.21.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 21:39:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 823F71200032;
	Tue, 19 Mar 2024 00:39:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 19 Mar 2024 00:39:16 -0400
X-ME-Sender: <xms:9Bb5ZY2gYHUNG-AMsxEIH3VwjZmSOCsCt36qxDkOyUDGWJ8K64Ptlw>
    <xme:9Bb5ZTEmVVrq-OVRmBS2z0n581-oLepe_HrnrXKBt6BQ7Ci0muJsp7CYFxMabOwuw
    Vt5u6xRII3U4Hy-LA>
X-ME-Received: <xmr:9Bb5ZQ6hHaFMLbhxogjK_If0JA6q9-6C92e_XwxxUJ3jNdHWmgg8up-Iag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegkeegtedtleffkeeftdevleeuieduveejgeeikedvgeekudefteefieei
    vdeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:9Bb5ZR2TGxoUSVfk1k2XO7_F9l23_E_UDVlB9x6olUio9nbg4h5L-Q>
    <xmx:9Bb5ZbF16eStfC4V9sIuNvVBDFTwq49shkqy5N_k17_4aYBZaqVoyg>
    <xmx:9Bb5Za--NrVfdEfOMuNbKhaZ4AVZxEZSL30hhU1_psuUikPIztq2HQ>
    <xmx:9Bb5ZQn8kVXudi_cblD-mlZgOMnhfuOULQaFFJ7bcXJNGev4YcSDgA>
    <xmx:9Bb5ZYc-Ip2tGNzZQPwStrhXJiboDfqlPz1P8nePjWbIK9tIvNTQ7PEmGcM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 00:39:15 -0400 (EDT)
Date: Mon, 18 Mar 2024 21:39:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Laine Taffin Altman <alexanderaltman@me.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	stable@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
Message-ID: <ZfkW8rwpdRc_hJBU@Boquns-Mac-mini.home>
References: <20240313230713.987124-1-benno.lossin@proton.me>
 <Zfh5DYkxNAm-mY_9@boqun-archlinux>
 <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com>

On Mon, Mar 18, 2024 at 08:17:07PM -0700, Laine Taffin Altman wrote:
> On Mar 18, 2024, at 10:25 AM, Boqun Feng <boqun.feng@gmail.com> wrote:
> > On Wed, Mar 13, 2024 at 11:09:37PM +0000, Benno Lossin wrote:
> >> From: Laine Taffin Altman <alexanderaltman@me.com>
> >> 
> >> It is not enough for a type to be a ZST to guarantee that zeroed memory
> >> is a valid value for it; it must also be inhabited. Creating a value of
> >> an uninhabited type, ZST or no, is immediate UB.
> >> Thus remove the implementation of `Zeroable` for `Infallible`, since
> >> that type is not inhabited.
> >> 
> >> Cc: stable@vger.kernel.org
> >> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed` function")
> >> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
> >> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> > 
> > I think either in the commit log or in the code comment, there better be
> > a link or explanation on "(un)inhabited type". The rest looks good to
> > me.
> 
> Would the following be okay for that purpose?
> 
> A type is inhabited if at least one valid value of that type exists; a
> type is uninhabited if no valid values of that type exist.  The terms
> "inhabited" and "uninhabited" in this sense originate in type theory,
> a branch of mathematics.
> 
> In Rust, producing an invalid value of any type is immediate undefined
> behavior (UB); this includes via zeroing memory.  Therefore, since an
> uninhabited type has no valid values, producing any values at all for
> it is UB.
> 
> The Rust standard library type `core::convert::Infallible` is
> uninhabited, by virtue of having been declared as an enum with no
> cases, which always produces uninhabited types in Rust.  Thus, remove
> the implementation of `Zeroable` for `Infallible`, thereby avoiding
> the UB.
> 

Yeah, this works for me. Thanks!

Regards,
Boqun

> Thanks,
> Laine
> 
> > 
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > 
> > Regards,
> > Boqun
> > 
> >> ---
> >> rust/kernel/init.rs | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> >> index 424257284d16..538e03cfc84a 100644
> >> --- a/rust/kernel/init.rs
> >> +++ b/rust/kernel/init.rs
> >> @@ -1292,8 +1292,8 @@ macro_rules! impl_zeroable {
> >>     i8, i16, i32, i64, i128, isize,
> >>     f32, f64,
> >> 
> >> -    // SAFETY: These are ZSTs, there is nothing to zero.
> >> -    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, Infallible, (),
> >> +    // SAFETY: These are inhabited ZSTs, there is nothing to zero and a valid value exists.
> >> +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
> >> 
> >>     // SAFETY: Type is allowed to take any value, including all zeros.
> >>     {<T>} MaybeUninit<T>,
> >> 
> >> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
> >> -- 
> >> 2.42.0
> >> 
> >> 
> >> 
> 

