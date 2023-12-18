Return-Path: <linux-kernel+bounces-4384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F529817C55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2175283675
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE573481;
	Mon, 18 Dec 2023 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO49Nx56"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F1A2D;
	Mon, 18 Dec 2023 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4260ba19a57so36045071cf.3;
        Mon, 18 Dec 2023 12:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702933069; x=1703537869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GcKJMFjfcbU8CE9s/X+zGwudMjtKyfz7guJTf6gd0KU=;
        b=HO49Nx56HpXHqAtdQPepO05sEeWDsrgJ/AyLkqN1ZwoW6mQvfg0n+S+AfmaV8SMZu/
         /gkIOx3GCaka1tv0blDwfyXL1Y5cR/JRAwy39kUKDpy0DCSCFN1iEgTy3mZKRsnGBEJq
         e0529u52e8zX31ETqfOqp8Z5shIcitmVJb4SsTPKFd99KOxea/6ZK8yaVmfj054NDTS4
         CbiNj9fJ/FtG0ICJwcpO6foQq9CGTmhCtAAxgvN9JSH83WxQGTTVY4O3NvZe4QU42S4e
         mvi0EMFyX1bZSW2XcR1o07+6/ZvcUjTuyAbow9SO9Yi5EKFJWY+1QKo1bQ9zyVy6ZDyd
         4L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702933069; x=1703537869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcKJMFjfcbU8CE9s/X+zGwudMjtKyfz7guJTf6gd0KU=;
        b=kw3Vcleyl8oAr2lj756BcHZI/cXgiayogkMJvQ/gxMasRR5k90Gw5rltbsewrN6Cnp
         21KFbsX19wPaYbwH/pFoqk1dYr6vhBzryW9zbs2a92Jv6U5OzuWW5YHiGjUFKX5KTQIU
         C2gcb8RN+07Rhcu5zXk5xUM9Fuo3/hiw72R4SvXj0vtMDhYxb4tLB94OFzwAeClQhbQ3
         HAfb9tcK22hVRjWlGjp+5TKxy9IHdhLhnLRcIDt+1L7p/0okiVRSmg9xj7T8QvEfopxG
         5ppSnmnhIXqdNeSqiSDHNDosXQw8CrVA8K21xwan4fuFneqfwIUlK5cNbocThivYcuLf
         js5g==
X-Gm-Message-State: AOJu0YzujmJbOPI0PxKyc3PYNkSH4U/X3EOJm0CPBi17xDXJxq+bTzbJ
	ZYSAgY5bOW5ACpkLxUgUydQ=
X-Google-Smtp-Source: AGHT+IGSAVojbk4OAnmD9VMdQbaMwOC5DCFv1TO7rbwVegXqFehkf0EbaCeJdyW4EtUGSO6JH8+zAw==
X-Received: by 2002:a05:622a:1889:b0:425:4043:5f16 with SMTP id v9-20020a05622a188900b0042540435f16mr22434099qtc.84.1702933069601;
        Mon, 18 Dec 2023 12:57:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x3-20020ac87303000000b0042551dce749sm9644808qto.46.2023.12.18.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:57:49 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id B13B127C005A;
	Mon, 18 Dec 2023 15:57:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 15:57:48 -0500
X-ME-Sender: <xms:S7KAZZSUZg3xuRyPO5B4CrV70gxJC_9f-UKYl-YwYFMAi47B5qew6A>
    <xme:S7KAZSxXkHYVEBqfmhQrbv1L8bf1-St7BCCe5LCji_ywyNf_6Moz9dqun-JfHNms1
    wW4BjhAJiRulDfCvw>
X-ME-Received: <xmr:S7KAZe39tqUtjkQNz_D0YGYnICAnuYEvB011ALiimKGtDrqx6-7ZnuJMgyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:S7KAZRB4bNiA0D1BGs2AoUxUtFLiRYCDIh4nQ_-IzajUzr264DoUyQ>
    <xmx:S7KAZShDEWU6utv6-ydWGQ51w53NyX-uIt2f9ViZABw-TXQkhP_SqA>
    <xmx:S7KAZVokdqQw-3oQ8gn-zw9yv1KDgrnm4anJoxgWJWYOO7nSzGFjhQ>
    <xmx:TLKAZWw1ETvHQ9usJXclEf4hkDRVNq-sIxjfN2h4MynJiYUcE-riHw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 15:57:47 -0500 (EST)
Date: Mon, 18 Dec 2023 12:57:30 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tiago Lam <tiagolam@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH] rust: sync: Makes `CondVar::wait()` an uninterruptible
 wait
Message-ID: <ZYCyOuChFYf_J_o1@boqun-archlinux>
References: <ZXtebif2S1CyJRik@boqun-archlinux>
 <20231214200421.690629-1-boqun.feng@gmail.com>
 <CAH5fLggriMBLWVx5i1efHdiNveVutvRfcA6mydNV9egzEFnnxw@mail.gmail.com>
 <ZXzlGM1xV-VlUkeh@boqun-archlinux>
 <b2d69a27-d791-4455-843b-d946512beb78@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2d69a27-d791-4455-843b-d946512beb78@proton.me>

On Mon, Dec 18, 2023 at 05:39:14PM +0000, Benno Lossin wrote:
> On 12/16/23 00:45, Boqun Feng wrote:
> > On Fri, Dec 15, 2023 at 11:27:56AM +0100, Alice Ryhl wrote:
> >> On Thu, Dec 14, 2023 at 9:04 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>
> >>> Currently, `CondVar::wait()` is an interruptible wait, and this is
> >>> different than `wait_event()` in include/linux/wait.h (which is an
> >>> uninterruptible wait). To avoid confusion between different APIs on the
> >>> interruptible/uninterruptible, make `CondVar::wait()` an uninterruptible
> >>> wait same as `wait_event()`, also rename the old `wait()` to
> >>> `CondVar::wait_interruptible()`.
> >>>
> >>> Spotted-by: Tiago Lam <tiagolam@gmail.com>
> >>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >>
> >> The diff is a bit hard to read because you swapped the order of the
> >> functions, but LGTM.
> >>
> > 
> > Yeah, I did that because `wait_interruptible` metioned `wait`, so I had
> > to make `wait` still before `wait_interruptible`.
> 
> What do you mean? If you are talking about the doclink, then

I meant I prefer to keeping `wait` text-order-before
`wait_interruptible`, so that readers will first read it.

> that should not matter.

Yeah, I know the ordering doesn't matter for generating doc. However,
the ordering still matters for readers, I'd like them to learn about
`wait` first since according to the existing API in kernel, they are the
major usage.

Thanks for pointing it out anyway! ;-)

Regards,
Boqun

> 
> -- 
> Cheers,
> Benno
> 
> 

