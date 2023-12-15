Return-Path: <linux-kernel+bounces-1835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791088154A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA741C24260
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0349F70;
	Fri, 15 Dec 2023 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuxCINZe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0448CF2;
	Fri, 15 Dec 2023 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ba084395d9so880462b6e.0;
        Fri, 15 Dec 2023 15:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702683939; x=1703288739; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qc4z/39BVksBkr0WR/MXxrqt9kwDpSLSTQX7fRWhbuQ=;
        b=BuxCINZexjfF7sKnRrBewr2kypMuMZflDWiNBSIR/ikJM7gwqli/DrWLfsW3saU5bU
         ag5l6/v/8j/28HlVzaMxXXqQA66DNAUOqDCUY0b8QZiryTOGnBQZE6arIDWObyMejK3R
         s0JjEmSoiQ4vwP9EIUCzGk01DeT0euL5Cd912D0ANlLrw1VNafrQ18qAp/9AsJt77MyW
         v/kKtx2knZWuc/AlHEmgbbYU0G7hKcq/jByIj4yaD+lNfwERnDic0rq0b4VofDVBM4H/
         jkJeZdJ4SUrfr1AbtinTqp+K5mOe7d22gYgpyo0/lAuqzQM4QGC61dmrG+5fx2MOWIQX
         ip6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702683939; x=1703288739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qc4z/39BVksBkr0WR/MXxrqt9kwDpSLSTQX7fRWhbuQ=;
        b=TaILzolKcvpui0UJhk+H/ob412QzFme1i+EwJbXEINRBbjOYTirXT91W8Yp9SIVlwo
         UA6DbROFWH4XQipBO3mf+K1qRqnqgjgSze2G5G1EfRBt2C/oAvat/XkP8h1tRVhK/3uS
         3e60RRtAQllrN59+hOwTwdYcCNNr8IPD9nv4Onpi0bdXz7pLJpyD8VXBEs4u+F5T30iy
         7FqDjV4AUE+9clSvuQkFRK1LTGl05RkVZzcYusgqTBx1IWfDZaDEz95AVgjZd08f7sI3
         0lmTWt3/KNuGfaYggKJ9PV11m0tfKuMHxgMdrXzeDX9GtmRHG0pe72DdLjLABdiD+xJ+
         Wgww==
X-Gm-Message-State: AOJu0YzissWVmkp3UAmzo+9wJiHuOYBsm6GxUT1qJdWhdXW1DgQnGw9O
	xPJ5G/Lja7UZmWmUOwalozc=
X-Google-Smtp-Source: AGHT+IGxISurWf572M0Wzue4BvusNE7/OQCRxh1YbVkx9QD5kgfDGObmilDAZ7814m9RD76rCV+8wA==
X-Received: by 2002:a05:6808:189b:b0:3b8:b6f6:4f7c with SMTP id bi27-20020a056808189b00b003b8b6f64f7cmr15846936oib.54.1702683939169;
        Fri, 15 Dec 2023 15:45:39 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w13-20020a0562140b2d00b0067f27d24cfbsm88758qvj.91.2023.12.15.15.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 15:45:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2910C27C005B;
	Fri, 15 Dec 2023 18:45:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Dec 2023 18:45:38 -0500
X-ME-Sender: <xms:IeV8ZcwMAk6HE-P42RBGDKt6eXT9JzdaFGb9T0cQuIwVrDitgL010g>
    <xme:IeV8ZQTXZAqDQGlk88h8GM5UlrWA_56ItPBqsb9A4dPkMdXAoQMziFll5g3OYGyp3
    hSzVOprdrjUEncQ1g>
X-ME-Received: <xmr:IeV8ZeV8La0N4WeTfTdyhej3ONo2mz_LCiM5yXqyJDUNr-b7yEcaD5e6F3NC7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:IeV8ZahXk5g_Mh_TXMTwpMAJudOPuCDR1SCaLhLX_edv9jApJ8--6Q>
    <xmx:IeV8ZeAGoRJTfXa8FQMU_49Z6R1hyPHM0WDfiL9E7qGcL9rm8k42aw>
    <xmx:IeV8ZbLJI7IPJObY_bTUW0gFWTweY8327kDE5HFG3emvIeb8TsLGeQ>
    <xmx:IuV8ZUQ-I7l2kNATohS5pzpvO-C9k3wpSjh0IkWfJhxs82y_ELTltg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 18:45:36 -0500 (EST)
Date: Fri, 15 Dec 2023 15:45:28 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tiago Lam <tiagolam@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH] rust: sync: Makes `CondVar::wait()` an uninterruptible
 wait
Message-ID: <ZXzlGM1xV-VlUkeh@boqun-archlinux>
References: <ZXtebif2S1CyJRik@boqun-archlinux>
 <20231214200421.690629-1-boqun.feng@gmail.com>
 <CAH5fLggriMBLWVx5i1efHdiNveVutvRfcA6mydNV9egzEFnnxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggriMBLWVx5i1efHdiNveVutvRfcA6mydNV9egzEFnnxw@mail.gmail.com>

On Fri, Dec 15, 2023 at 11:27:56AM +0100, Alice Ryhl wrote:
> On Thu, Dec 14, 2023 at 9:04 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Currently, `CondVar::wait()` is an interruptible wait, and this is
> > different than `wait_event()` in include/linux/wait.h (which is an
> > uninterruptible wait). To avoid confusion between different APIs on the
> > interruptible/uninterruptible, make `CondVar::wait()` an uninterruptible
> > wait same as `wait_event()`, also rename the old `wait()` to
> > `CondVar::wait_interruptible()`.
> >
> > Spotted-by: Tiago Lam <tiagolam@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> The diff is a bit hard to read because you swapped the order of the
> functions, but LGTM.
> 

Yeah, I did that because `wait_interruptible` metioned `wait`, so I had
to make `wait` still before `wait_interruptible`.

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks!

Regards,
Boqun

