Return-Path: <linux-kernel+bounces-127123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70213894732
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935F91C21684
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F95646D;
	Mon,  1 Apr 2024 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG9IooGv"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB61EB37;
	Mon,  1 Apr 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009930; cv=none; b=oc1RzA5e9ZkLrVcG8lnx+rckPM191TQxzPTxXIHenZmoRZUWX25oU8vNPUQLbDOuGmMZdIG29o3YGkH0stNp7/+RgJ5MeE3i+y2yzMazqP3N1roQOYjpwUxC5dAmwHEggSy5TxRoXX8SCrRhCJOgx6Vtdbt4gBKCgqXOnKxNs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009930; c=relaxed/simple;
	bh=KmlHz2prIP16z1uToxCe2yLY9hH9ICWS/ieaQAc0sdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXwTP/6zct6zwfYFwMTokYSG2ZXtyDgvLCVi31ghnUSRMVvuynAKwb0M3Glg+n1oFS/1uYj2xuFWRpPKAn/66PY7WJpa8drWtCH0Of0Uy8eerDLieMl8Srwd4qaRM71XJi55e7VKpXW6JNsufT5xgv/v5AMqvF73kd9t63kvMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG9IooGv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-781753f52afso284041585a.2;
        Mon, 01 Apr 2024 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712009927; x=1712614727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGY/M77vgSLDNWJUc3/1xFRf0B6CgOe+o4qlVpHhZ+Y=;
        b=bG9IooGvbNZ+chtgKcFr5EZmPcuzbXwvCOFPvWC51bxf8S/z+Hx0vyBd6ObmSYp+zH
         E7bdK86ad6wWfQg3XNLO5Zl87DJA+BxhBuGS0VssdTw9/9ohIwKQNEmUbwURSeZU3CrS
         71X7OmIrHKguELFrscYM9VGokOnPygT0lFyDlSYnr2Ov50oMPq1l7vtwzac/u+sIExEF
         vha3jEWkaZ439B2TtEorZ7jaNXFPRN4FRfEKKa3imJeGvajwHLDKDh8OtDOzmSPAa/g6
         ePAQqghPMV3WlEWlvaenNsp7DQ19upxqb1KMQ/dIx3spNacYDmaDU0NMUd3+8+/5Uq8J
         4Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712009927; x=1712614727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGY/M77vgSLDNWJUc3/1xFRf0B6CgOe+o4qlVpHhZ+Y=;
        b=q5M+IpS3xSJND6pB1a9MRPuGLG1BUis2RrT/lkk5D7dJuUNiLviH94N2vrMtTvFmWo
         a6JyhxT4/7DUZKy+2RgSZ+wNk0DZvmJYgFYdNEoBD+ahTS5DQJf6a2nyulW+sIrcPq1Y
         ji3IDMh8kMl5efURsQH4cU7HGGG8CR/HwaHQkEKzboRKYbF8xCZdnzneDmQv6sNZIikK
         PF+08rPhtxkgIGHweeucdevWpZWaWavHViRxp1HNlqkG0vYVPASm2k0SmtELWQKPfT5S
         qbaq5Y+FEHxDt1bp3bgDQ67wT7rSzDZjNC5jUkq7+uTdSYTic7RukME2jX55LjL/WUhW
         4yGg==
X-Forwarded-Encrypted: i=1; AJvYcCU6zTIQyfUB3u9tNf0J/W1C3yrKE5zOPqUCKrmHSTiXkP8msChVlLCs/ZicDYQUBz+TGJSHtU8wACJTeZ5WHx5ibiC7BojYsmrjXJyyLQsAiZU21pob3meVV0zic7r5i3kX/r9xYyfZTu9JaZM3Uc0cpxxw42Vguu+DOTVQodwYfTlvpo4=
X-Gm-Message-State: AOJu0Yyx2/FsoepI5ySkrtyDpovAqzoYhN372lcYjlFjchzUpqQ8soxr
	4xMDyZfre0iipEsQwVeSEVk0t6dUwGnMVxK8/XZps42m5dvEEUZB
X-Google-Smtp-Source: AGHT+IGAxsVcoOQfRdEJH36mLW7a9UPYtw5D0KQBQWGbQfziZJdXYGWHG0XjZRwsSHpX8vTMhrtFDw==
X-Received: by 2002:ae9:e513:0:b0:78a:439d:7665 with SMTP id w19-20020ae9e513000000b0078a439d7665mr11875529qkf.36.1712009927451;
        Mon, 01 Apr 2024 15:18:47 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a0b8800b0078a0dda6d35sm3810718qkh.107.2024.04.01.15.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 15:18:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6E1411200032;
	Mon,  1 Apr 2024 18:18:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Apr 2024 18:18:46 -0400
X-ME-Sender: <xms:xTILZi0dWe-Rh08__bf_NdPI7Z_K1pJ9-05JloFPZ7SJtAm9uhno1Q>
    <xme:xTILZlH2mSzYJIPYidKJcn_3IEwv05uU3WD4fTW5jw3whhr9Kj8ziee6KOMU875-Y
    pTbeWliBbGFA8Y_Kg>
X-ME-Received: <xmr:xTILZq7-5phN7FqpdWXBZFnTQYb5QdsYVsyEaVYL_WrtZyHNSiL_8aoeXOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:xTILZj0wdpRzQKBuULAJJYAG45kzMRvfObgfJKIExo4Y2oRRbrtvyQ>
    <xmx:xTILZlEcKQBKOXjtZd9G67VaZ512uZVmNyjxjnqtP_cu7BXmp7JSkA>
    <xmx:xTILZs9whNoUHiYgz-BKah4vxt3dsNfexZ6r8Xiq31nD2TqpiViq1w>
    <xmx:xTILZqmTL_tDmaAZ9UBXerK4ZO5WPahP_q_hECEOZXi-YwnyM97m2Q>
    <xmx:xjILZslilXhCYe_-B0h9BelrCTvYU1qqz5XiYKKAjXEbxIn8OnEEYGG_K5k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 18:18:44 -0400 (EDT)
Date: Mon, 1 Apr 2024 15:17:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Asahi Lina <lina@asahilina.net>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	Neal Gompa <neal@gompa.dev>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	Matthew Bakhtiari <dev@mtbk.me>,
	Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wedson Almeida Filho <wedsonaf@google.com>,
	Finn Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: fix soundness issue in `module!` macro
Message-ID: <ZgsykVwMBsULtxce@boqun-archlinux>
References: <20240401185222.12015-1-benno.lossin@proton.me>
 <Zgsiumknfshjbi9J@boqun-archlinux>
 <20fcbbd0-4a7a-49b1-a383-f8b388153066@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fcbbd0-4a7a-49b1-a383-f8b388153066@proton.me>

On Mon, Apr 01, 2024 at 10:01:34PM +0000, Benno Lossin wrote:
> On 01.04.24 23:10, Boqun Feng wrote:
> > On Mon, Apr 01, 2024 at 06:52:50PM +0000, Benno Lossin wrote:
> > [...]
> >> +            // Double nested modules, since then nobody can access the public items inside.
> >> +            mod __module_init {{
> >> +                mod __module_init {{
> >> +                    use super::super::{type_};
> >> +
> >> +                    /// The \"Rust loadable module\" mark.
> >> +                    //
> >> +                    // This may be best done another way later on, e.g. as a new modinfo
> >> +                    // key or a new section. For the moment, keep it simple.
> >> +                    #[cfg(MODULE)]
> >> +                    #[doc(hidden)]
> >> +                    #[used]
> >> +                    static __IS_RUST_MODULE: () = ();
> >> +
> >> +                    static mut __MOD: Option<{type_}> = None;
> >> +
> >> +                    // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
> >> +                    // freed until the module is unloaded.
> >> +                    #[cfg(MODULE)]
> >> +                    static THIS_MODULE: kernel::ThisModule = unsafe {{
> >> +                        kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
> > 
> > While we're at it, probably we want the following as well? I.e. using
> > `Opaque` and extern block, because __this_module is certainly something
> > interior mutable and !Unpin.
> > 
> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> > index 293beca0a583..8aa4eed6578c 100644
> > --- a/rust/macros/module.rs
> > +++ b/rust/macros/module.rs
> > @@ -219,7 +219,11 @@ mod __module_init {{
> >                       // freed until the module is unloaded.
> >                       #[cfg(MODULE)]
> >                       static THIS_MODULE: kernel::ThisModule = unsafe {{
> > -                        kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
> > +                        extern \"C\" {{
> > +                            static __this_module: kernel::types::Opaque<kernel::bindings::module>;
> > +                        }}
> > +
> > +                        kernel::ThisModule::from_ptr(__this_module.get())
> >                       }};
> >                       #[cfg(not(MODULE))]
> >                       static THIS_MODULE: kernel::ThisModule = unsafe {{
> > 
> > Thoughts?
> 
> I am not sure we need it. Bindgen generates
> 
>      extern "C" {
>          pub static mut __this_module: module;
>      }
> 
> And the `mut` should take care of the "it might be modified by other
> threads".

Hmm.. but there could a C thread modifies some field of __this_module
while Rust code uses it, e.g. struct module has a list_head in it, which
could be used by C code to put another module next to it.

> The only thing that sticks out to me is the borrow, it should probably
> be using `addr_of_mut!` instead. Then we don't need to re-import it
> again manually.
> 
> I think it should be a separate patch though.
> 

Yes, agreed.

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> > 
> > Note this requires `Opaque::get` to be `const`, which I will send out
> > shortly, I think it's a good change regardless of the usage here.
> > 
> > Regards,
> > Boqun
> > 
> 

