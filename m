Return-Path: <linux-kernel+bounces-117966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6C88B2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48937B39761
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D17173A;
	Mon, 25 Mar 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOYJ9sBi"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBBC5D725;
	Mon, 25 Mar 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399498; cv=none; b=ddX9yq3l/XwVcz0VuLr6APj32dbUtCO5lHKTQkxPu5Si02izTi1HfWtBsWEK16IrqbeTeKLIoYbbkqDlJNJYAKxKTD8lUkEG4jBV2d/4ksefTrPVWQcfhPBMtd7tJWFFwZdk/s7/vPnY5z8VQWNMmqbmBKoDd/ySbS63tq4X/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399498; c=relaxed/simple;
	bh=SZAzcMIK7i3P4s4qLrG+0au4O9rvfOdsoCETN86sg8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hds7TfgzBX3V3ypy87JTT+i1tpniau0/FH2jvLdIg7Uh9ztJWkF0wGEU0rrSyl3JAwaCw3FgbECUrdj20LQs0l9kwUO6cnTEzk62pG8rKAZhTwsyvZ5b/GAJxZWrpRdUaMFHnnPUuZc6gNR+MT4iAybeXkCs5M/iAnDvWJTQWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOYJ9sBi; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7db44846727so1030366241.0;
        Mon, 25 Mar 2024 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399496; x=1712004296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DEZYFsrrJ3tXkcdN4NmU+Au67F0Ql9JXSFSSgEu1ho=;
        b=bOYJ9sBiCVMBgeppLoLHCOXf3wVSmonTPF5apo0FCFjze0HdJNFIO3pJVsEAZMOl7v
         tXFi32d3pHjj4ydp6I5PbodxWFz/yIz1IIr9yEXFw33dxln7ATsRx1s3B4EQKmBxDGjS
         cOgsYqvt+GO8RW8gPjEaz0du3YDe6oIJvdwAOpUhOOou10BWeuExxrxxXrvbl+2RTrG6
         819mpzFsiM5A/ZugHjsQxm1outZs9XcW1Y7fzYegxhbY2+fU1YP1kzsKayvDCwLAgn1l
         tqSkPN4zu605dKJ3jB68zuXMxYTHGnyjYbV47ySpGlv1E5p/1QLx/gUa3LTLEvtLHk+g
         +/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399496; x=1712004296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DEZYFsrrJ3tXkcdN4NmU+Au67F0Ql9JXSFSSgEu1ho=;
        b=WXK6T9YN4utyK0wLcMAzXniqwhIzPrYc0phJ51ldtNhPFnTh1I1c9s8Y+XPwGWmy98
         V3mbIfGPrAz/DOkOK3U4yvqcTHHNJ9Moi6Opb8OcNVpjoaFZ4X4X9f9DCZjZqYlGXMYg
         nI60HICNdBI7/B06h6m1Byr1QW6SW1G8CxeOHb7t3YuLdzUT20VBEPAQwOSDMvOfQghv
         PVd/ThzwKugVWwbQ0+cDxGayD1HbFvqHDzG6FNL2ErprqlUGtPRT7cdhzHa970n/EN2/
         YKQ03ZDgFTw2nlwvlPM+cQWWn41KpiZrvrDkvySRmiOUHlV90MhxCQDfLZeWQyF8T8E7
         CaIw==
X-Forwarded-Encrypted: i=1; AJvYcCVGzT3YRzu2/hq1DyEBuT4AVtisyWz+m1q+PG1+rcHa79x4g7ZI82Y6YlCBu8c5eidGDxBmiZH5IaxHb9TjIAJBdElmFPDY5GBZMmtR
X-Gm-Message-State: AOJu0YyDmCc0cr2whVluImlu0H5hRNIo6oEKrZ9IPuONxi7tVM7z/mJK
	fg0nvWjav0PKNKY+r2SgrreBul1G6sgmhlKPtail6IY0YYqanKTm
X-Google-Smtp-Source: AGHT+IEWYnFxZLLkDrEyIi/t2Q5S4gSo26mW90rdu9+xogc74glHDUYiwZXSXl46l2pV13sKjDwMJA==
X-Received: by 2002:a05:6102:3561:b0:476:e1f5:43b8 with SMTP id bh1-20020a056102356100b00476e1f543b8mr4071235vsb.25.1711399495737;
        Mon, 25 Mar 2024 13:44:55 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id v26-20020a05620a091a00b007887583762csm2423631qkv.94.2024.03.25.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:44:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id ABB561200066;
	Mon, 25 Mar 2024 16:44:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 16:44:54 -0400
X-ME-Sender: <xms:RuIBZlakNYXySYRQ_KiIPQJqSrUHe6-ONcckjEfiaeJpIjmkKiy6bQ>
    <xme:RuIBZsZYukQJB8BNEducDLT4LOvzn5Uh3pMwc4ZTAb6n-jiwczvXQJYSSOfW2bcJB
    tv4KromCPrhQ9MNVQ>
X-ME-Received: <xmr:RuIBZn8IAjEN5_OOKZtocdSGVUeRIm4VGvTmzo6wx4kkuWSeW6LSmKwzRLx0WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeduveeijeehvdekjeeffeethefhgeevvdeuvdekueeileeuleehleeuledt
    hfdthfenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghdpshhprghrvggptggrph
    grtghithihpghmuhhtrdgrshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:RuIBZjokd-02NW17Y5RVkrmPAr76oZRlBMrM_z7l1hqzc-1FiXOR-Q>
    <xmx:RuIBZgpNAhQe1_k1op2-vJ5-TOb4V6bn7oFzofrBYFkd_h6LS0oMaQ>
    <xmx:RuIBZpRlUMgojKBKEOZsVwu2brF6SPzUb3yFFVpUDq_frOhhLafekw>
    <xmx:RuIBZorJi_QEhoeSDfuC708eTUfKZ0MSZUAcUywaULUNImwfcNQggg>
    <xmx:RuIBZmhARegcYcjy0jFaPm6VwhctnZNga5jkSuc2XIU9p9H-BaXsSuQa8Qo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 16:44:54 -0400 (EDT)
Date: Mon, 25 Mar 2024 13:44:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 07/10] rust: alloc: update `VecExt` to take allocation
 flags
Message-ID: <ZgHiJ23TdOmnSGe9@boqun-archlinux>
References: <20240325195418.166013-1-wedsonaf@gmail.com>
 <20240325195418.166013-8-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325195418.166013-8-wedsonaf@gmail.com>

On Mon, Mar 25, 2024 at 04:54:15PM -0300, Wedson Almeida Filho wrote:
[...]
> +    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> +        <Self as VecExt<_>>::reserve(self, 1, flags)?;
> +        let (ptr, len, cap) = destructure(self);
> +        // SAFETY: ptr is valid for `cap` elements. And `cap` is greater (by at least 1) than
> +        // `len` because of the call to `reserve` above. So the pointer after offsetting by `len`
> +        // elements is valid for write.
> +        unsafe { ptr.wrapping_add(len).write(v) };
> +
> +        // SAFETY: The only difference from the values returned by `destructure` is that `length`
> +        // is incremented by 1, which is fine because we have just initialised the element at
> +        // offset `length`.
> +        unsafe { rebuild(self, ptr, len + 1, cap) };

probably use spare_capacity_mut() here to avoid `destructure` and
`rebuild`?
	
	https://doc.rust-lang.org/std/vec/struct.Vec.html#method.spare_capacity_mut

	// .. after reserve succeed.
	// there must be room for adding one more.
	self.spare_capacity_mut()[0].write(v);
	// or unsafe { self.spare_capacity_mut().as_mut_ptr().cast().write(v); }

	unsafe {
		self.set_len(self.len() + 1);
	}

Thoughts?

Regards,
Boqun

>          Ok(())
>      }
>  
[...]

