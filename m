Return-Path: <linux-kernel+bounces-142738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422AF8A2F81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFCDB241AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B8A83CD4;
	Fri, 12 Apr 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY/IlpJN"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1D83CBA;
	Fri, 12 Apr 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928855; cv=none; b=F9LGXfMXzoz10MwybRY+Nnfl9Ll9X7aOcih68XXcK1WJ0HzXe8s1kyZmOEjRcjTjrjLe4gQYq4UMduq+DrNxGx+6t07/c6ASeQMuevuonXpk2uNltY8P2KeQQ71SmRolew2eOe397H7eQoDRZ+gNQxR/sGzOeYeGh4nlBJgbpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928855; c=relaxed/simple;
	bh=bXuJBsmh+9cSqT7Y0dmwOptaeFP94AwFcrF1Nc5BiuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUiuqKF1sfUS/0s0FM15N7ESTCNspY0Suw6upXM4qylEZputXdD0tJkfidDq3jtb6zxnku9QO0QHnDg+UmhVfZ91k93fnkO3GJNnhKzaEITtb2vS8W1bBr7zQXXq+hX2VPobPTNmo5ohT+4d/VrbrANo2HtkeNuwRioIlAtqJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY/IlpJN; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22e6b61d652so375897fac.0;
        Fri, 12 Apr 2024 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712928853; x=1713533653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KvnQBzgnQ9uzdcnNmTyAu4+OT66V0srgD7VC/MHPQzE=;
        b=jY/IlpJN+sJu/dLKO2vpnbnmb6X1sT+W9+UBJqpfpUSwnAKl57tDb0HwFIf5PQNSsE
         StgaWZZ1L2W2IDIDU0I4XMEQWbT9bjDnteOuGu5N1IPZbEpZFT9t4xtF0+Bce/Vwd/EU
         vVmM6RCsFOSfGbZR4sy80OqVkl1XWfPZUL36H7d7Yw1XViNwrFLrjDKQucPzxodJ/x7U
         za3I+k7QO4vAzlWip91jEC+EbXMHK6Lo0L6CDcDDd4GXADQizHU9M/JKea2c3Cdh5czg
         FTp6KVOb+CFNyOSzPFTrxKvKiXJ4EMHWxM6qShnXfrCd9eICNVTVFraKbq6viJk21Dvl
         K3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712928853; x=1713533653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvnQBzgnQ9uzdcnNmTyAu4+OT66V0srgD7VC/MHPQzE=;
        b=SVcdhzLP2Ha7kBrTiTv4rzQR3VbWtYSqWanVUqDAZMHtbs0DVM8G/Zo5kKrpIC4KPM
         uBzRELgRZcf+rFNDiFbD9U+RpU2j4bToErxKNVO8v5U/URly9o6Pdm4BD87cTze2ip+f
         93BzaE0ET5n+iLZEp8aWBcXCFukKNP54h4QNKJOv9JOU0GryAR9MOuEaJwI9zLRXN05j
         bxqIxpiJq9gsnk/TT72cTWglaWZXeRKPuKuwo3InJQpG5MFFtfc8BtcSVEIFi9YPbHLU
         Lwnh6yjBGEhxCSpchDR277loBHeMoOaosHdbSTM8NiY0L+N0WY93bA9PVXVav36KDcqk
         jP1w==
X-Forwarded-Encrypted: i=1; AJvYcCVKVqGH3Of0Mgo40jmK0LhbKoaJJdejUxQRDNTLVqxIc5B1cJ5GfSFRLsHalHCdSMTqNcUhdEZop3JfJI9qPfXx0ONz0TSIvezUx2zISiBsxFCoQXcECLR+hS+dkW9HTKulCg/5/qRojRcszK4=
X-Gm-Message-State: AOJu0Yz5/JPsvoRwa5uODaQb/19KBIn13yvP1v3XoaRa8r8wwr2BoCuJ
	ownQN/0Jc/eeyBk/A4hjt7psS8DqJUtBTDyn/R+rwAxcCDXM+wDh
X-Google-Smtp-Source: AGHT+IEkVEiOlsnwx7zwiEWGQXRD4FOqTaoslwquKyUNiezCxlBMBl7euy1yuc9DBbIHaY9eVZakjw==
X-Received: by 2002:a05:6870:4689:b0:22e:df68:ee7a with SMTP id a9-20020a056870468900b0022edf68ee7amr3006137oap.42.1712928853468;
        Fri, 12 Apr 2024 06:34:13 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id h13-20020ac8714d000000b00434ee466ea6sm2226084qtp.22.2024.04.12.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 06:34:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7799C1200066;
	Fri, 12 Apr 2024 09:34:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 12 Apr 2024 09:34:12 -0400
X-ME-Sender: <xms:VDgZZnw8m58zfDWAICVPSINpABCStGj9owgD0koi_5J3WhbMugTX2A>
    <xme:VDgZZvREtv-v7UFgfFK_9ynT1m5MReZZcukxuC89K6tycxzVW25QJAKZbYPwOXCr7
    B-3kPsBGqUePHKVBg>
X-ME-Received: <xmr:VDgZZhXs3sK4JcbIc0qob9KfgPyKNktLZii63NSIQ9LD8etloFo1y2Wjgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:VDgZZhjPRF8HpIK5wwWhT1hdRsTM-MG8UsK8_9wr_aCzSLDBqBsDkA>
    <xmx:VDgZZpCBv1glBUsQ2gZ2WtoWWu-h1sT4D7buVspeF887xnA3W6_r0g>
    <xmx:VDgZZqImmKn7-K5zlthz9EdadcifVY7WHQKcutmY3dZ7LtV-yJvUkw>
    <xmx:VDgZZoCQc3RdJ-ExBu7fGyGau8j-Kf6lGGC5Lw5pNACnpGXXQEptPg>
    <xmx:VDgZZlxTuKeUA2JTXZUoQLm_zNPYWTppxb23VIoIeHkgg4FlVS-hO47c>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 09:34:11 -0400 (EDT)
Date: Fri, 12 Apr 2024 06:34:10 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <Zhk4Uqc4LImR2n_r@Boquns-Mac-mini.home>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com>
 <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>

On Fri, Apr 12, 2024 at 09:14:03AM +0200, Miguel Ojeda wrote:
> On Fri, Apr 12, 2024 at 1:08 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Currently since Rust code is compiled with "-Coverflow-checks=y", so a
> 
> Nit: it is enabled by default, but configurable (`CONFIG_RUST_OVERFLOW_CHECKS`).
> 

Ok, I will change it accordingly.

> > although overflow detection is nice to have, however this makes
> > `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> > clear that the overflow checking is helpful, since for example, the
> > current binder usage[1] doesn't have the checking.
> >
> > Therefore make `Ktime::sub()` have the same semantics as `ktime_sub()`:
> > overflow behaves like 2s-complement wrapping sub.
> 
> If `ktime_sub()`'s callers rely on wrapping in some cases, then an
> alternative we should consider is having a method for explicitly
> wrapping, like the integers. This would allow callers to decide and it

That works for me, although I would prefer `Ktime::sub()` is wrapping
sub and we have another function doing a safe version of sub.

> would make the expected semantics clear since the beginning (which is
> the easiest time to add this kind of thing) for Rust code.
> 
> Otherwise, I agree we should at least document the preconditions clearly.
> 
> Having said that, I see a `ktime_add_unsafe()` too, which was added
> due to a UBSAN report for `ktime_add()` in commit 979515c56458 ("time:
> Avoid undefined behaviour in ktime_add_safe()"). There is also a
> private `ktime_add_safe()` too, which is a saturating one.
> 

Exactly, ktime_add_safe() doesn't panic if overflow happens, right?
I think that's pretty clear on how time subsystem wants to handle
overflow (saturating it, or zeroing it instead of panicing).

> So, given that, can callers actually rely on wrapping for these
> functions, or not? The documentation on the C side could perhaps be
> clarified here (including the mention of UB in `ktime_add_unsafe()` --
> we use `-fno-strict-overflow`) and perhaps using the `wrapping_*()` C
> functions too.
> 

I must defer this to Thomas.

> In addition, Binder calls `ktime_ms_delta()`, not `ktime_sub()`,
> right? In that case the arguments are called `later` and `earlier`,
> perhaps those have a different expectation even if `ktime_sub()` is
> allowed to overflow and thus it would make sense to check in that
> function only instead? (and document accordingly)
> 

Maybe, however neither of this function probably shouldn't have the
panic-on-overflow behavior. So I agree that overflow checking is not a
bad thing, but when to check and how to handle overflow should be
controlled by the users, and making the default behavior
panic-on-overflow doesn't look reasonable to me.

Regards,
Boqun

> Thanks!
> 
> Cheers,
> Miguel

