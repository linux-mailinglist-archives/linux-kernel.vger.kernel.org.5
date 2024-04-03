Return-Path: <linux-kernel+bounces-130691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4A897BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736941F236F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78E156234;
	Wed,  3 Apr 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD93/V57"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B596139D;
	Wed,  3 Apr 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183954; cv=none; b=j5hd3EySgu5oF5H8N6UZJoCeCfcGgACBLXCaxsbw66wmm2nXnfcdR/jE4c+RC03B8RLvruTUKc0V1cAF1Q52ky76MlS7296p4M6PAlEPzEtN/KYt+psNeiuu9qUMfBz0UI5H/3eGRsjT6ThxmBDBj4J/2z0xp1cl+2DkpZTczpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183954; c=relaxed/simple;
	bh=6RRNO8tHGPyVuBWqXC6p54ck9E+UFQ4pHjzqX4Kv410=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGNChqjaZVXoMBTVYZOAJSLnmAnz84mWeuEJnUO9/l9CTxF7D/YZugDfIStUtNTq4zMcA3rHjqKlru8d5u/QFn4gWtrLwf4nfokLpzPRjWRFwhqa+zJVpa6BMVhTtXaDzhWVYo5hcKu3d23j72YbRkTeEM4KUTAhmQZIKebak2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD93/V57; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-696315c9da5so1835196d6.2;
        Wed, 03 Apr 2024 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712183952; x=1712788752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB1/wBBkZIgyMqKIcB1OutaUx9UujRieCF/3v3a0obA=;
        b=LD93/V57XNKKLi6f9u+YX1ABD3Iojls1OS+pBORSb/KFFqQU1DBSEn98uWEfpM+vwW
         QCstzOPu3YIhEVidYyc3b5aw7zfhs7L9zxDiJPMeAqm45LoSEO1NEjZS8IAKVpcR2C02
         FVKetIWiC3OOgBnQgbggfSWMaWZdkN5osCPzY8uW0F4LK44hhZYmA1+/btQTtQ2TL5RR
         ZF872Zy16i3ByhhwaC5D/qPExKH4OtgekfuwvXHyH82WiyFdkV9spb4GdecNYRk0gSR9
         Sq4zZU5Po5e4BN6ShLVpvOuTNlvk19gaW/QUdcZBe7EY+szbDwcn6NTrF8Zk4tuHxTX5
         PtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712183952; x=1712788752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB1/wBBkZIgyMqKIcB1OutaUx9UujRieCF/3v3a0obA=;
        b=q5XIfQYr+MkcVMApHluLDbIuSlgy1nvcZes04elzoK/j93/ssdPXXAoN5CMACwUZeR
         JEwGnzmCysF/pQERnvdxdV2NZerJU64htVSqbHrsxHaY4DS+Nhaq1AUKFm5XIX328IFA
         Vj78AdRoYhsS7qmWdFVeTjuR3ZgL5YUWg/e2+EwyEXlEhz6DYYhs5scXQmWY5Yj647Vf
         at8QaLVKyLXYMZQOEwjxTj1My1q+cUH2DKuHiB3476aroAX7nybBvI4SZwVlXhft7KgC
         CEMKW1oaeTYYMlXXLOnU6ZKYifDtQP4TutgdwHTdmQ0UGooxQa4l+Mf6RT8k0YV8tcxf
         4xIw==
X-Forwarded-Encrypted: i=1; AJvYcCUdWWill5HlhHeo5seXDxbzPU5KXpqC3nLG21LL7fWID9umLsRObDn2BuGUo8SBqNMrz02mGJYRYNz3D3Occ8zAet+9o4xPfXkrq5EAxxj2to1r5JZCN+CiJI9Gai2bica5N471scJpvvuqWaE=
X-Gm-Message-State: AOJu0Yw039sK+8fIHu0sSkhajCrO4ojojTsrpVJ9lo2mO3d4WxMqSop9
	FPzsHcwlBjdgg+Tr0j1fWQEKZO9JC3S8va6m9GZxz9Mi93dDaIbU
X-Google-Smtp-Source: AGHT+IFSCKhW0cIxupCH566ZIVho47xlz678JQLYPVmoCKqz+9xOYncqog3+/rjliVDv/OTv3CJvkw==
X-Received: by 2002:a05:622a:4ca:b0:434:3358:8a11 with SMTP id q10-20020a05622a04ca00b0043433588a11mr883268qtx.55.1712183952244;
        Wed, 03 Apr 2024 15:39:12 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id bb15-20020a05622a1b0f00b004344c996355sm225420qtb.79.2024.04.03.15.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:39:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AC64A1200032;
	Wed,  3 Apr 2024 18:39:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 18:39:10 -0400
X-ME-Sender: <xms:jtoNZky7J7qldx-vBxKRJBwOVWp7pn7JVxO88289PdgTI03JbMANBA>
    <xme:jtoNZoQjN89m6n9U1-TrbNzDXO9pIQmuXMm0cbukWPiY55Im3z7mc7XxtAtVAWp_g
    XRdGxV2bcn5KYEAiA>
X-ME-Received: <xmr:jtoNZmUPc_H387EpF7BmfDUNoqyH1RSH0eTDNSLlfZEPtVo7HXcJpn-xCjFAZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:jtoNZii40TllaKwFkPJItANmD4ldzIrLpQNhr1zjnQX5tyimtG2ecA>
    <xmx:jtoNZmAd47rjah6nx4j-CGJr17hiSgMFzE4nOOs8B4m7zjIqHTIC6A>
    <xmx:jtoNZjJefnRzrE_YDtE49Q16tKeORAqGNUcQLq__j_-vuQVy6MEtgw>
    <xmx:jtoNZtCYJMfDGkOyi5NgKEuXfbXJU8Wb_6Dxwg6_mFEHfwju0xBPGA>
    <xmx:jtoNZq7HyxmpDgsABE7i0YqEjjLBRHoI23bZXq-4j9F1JY1TSVibrl7I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 18:39:10 -0400 (EDT)
Date: Wed, 3 Apr 2024 15:38:12 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: change the generated name of guard variables
Message-ID: <Zg3aVLUHkRFxqAh3@boqun-archlinux>
References: <20240403194321.88716-1-benno.lossin@proton.me>
 <Zg3IHZfYVEOh7nc4@boqun-archlinux>
 <ef1400ae-ba9e-4656-98db-a882ac720c1e@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1400ae-ba9e-4656-98db-a882ac720c1e@proton.me>

On Wed, Apr 03, 2024 at 10:09:49PM +0000, Benno Lossin wrote:
> On 03.04.24 23:20, Boqun Feng wrote:
> > On Wed, Apr 03, 2024 at 07:43:37PM +0000, Benno Lossin wrote:
> >> The initializers created by the `[try_][pin_]init!` macros utilize the
> >> guard pattern to drop already initialized fields, when initialization
> >> fails mid-way. These guards are generated to have the same name as the
> >> field that they handle. To prevent namespacing issues when the field
> > 
> > Do you have an example of this kind of issues?
> 
> https://lore.kernel.org/rust-for-linux/1e8a2a1f-abbf-44ba-8344-705a9cbb1627@proton.me/
> 

Ok, so a new binding cannot shadow the name of a constant, that's a bit
surprising, but seems makes sense.

The solution is not ideal (for example, a constant can have the name
"__something_guard"), but nothing better we could I guess.

FWIW:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> 

