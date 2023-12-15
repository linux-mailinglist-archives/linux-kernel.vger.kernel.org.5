Return-Path: <linux-kernel+bounces-881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5463D81476C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1FC1F241F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95422D607;
	Fri, 15 Dec 2023 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvFMHUVc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC52C86C;
	Fri, 15 Dec 2023 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbce6056e85so459994276.3;
        Fri, 15 Dec 2023 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702641223; x=1703246023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM1v7r2f2GvXAiAcJRLKSdfcTUYdD255h3ff0PoBXFQ=;
        b=HvFMHUVcrTt4r+s3Evj5z0qmwuJVHqgfEAi9Z/V+pMFQy6JL+HXM/tFis29+rwEWCc
         JnLp26o5DMy7Tw0eq/3Cy8WiaA/XDiCVrOG83pAf6ILAjGMlArSak/cZUvj0rs+slL1j
         Vpl9uCgXuXjgjytkv7TDolDX42Oc2JMN1f7/7ItbdcIrN29BKcgh9+pvda+87r0xDhRH
         +3ntH6LkTUIfmld1EsQjomhV54yiNm77IQZb1a/n5Fxi+XVPFfVMgwthWAID2B7OYkTN
         moSg8GSSVdV1ZkxAuR5LoZCV6y4BfuYe3bzE0+0klCMc28XM4eQqwG/NL4Ho8VTDyFXO
         FFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702641223; x=1703246023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM1v7r2f2GvXAiAcJRLKSdfcTUYdD255h3ff0PoBXFQ=;
        b=EY5PRFbNBcWf4AfrxXyDaO69Y5bVTh1TUX2AXvqHJ77UYcUC6L+oH3rLK9CC54lBa1
         mLlI+gGwK+fPOyt8ivBrWR2OKVL/BoSZwHVzILISrkaShnZK48z+rT1LIzG3GZXjrjai
         TK1e3Lp362vWK5IzVCvD7iCWmPZmwmQPd2+da2iCFWtraEViUMfYPrVi5Iry4ylZybnk
         vZaZJWZ8ksaolaXwZkLgB4bZgDUma6fRV4MM7FKYjwMZvtvOPFMPcEU6wQUYxdWSEDvK
         RQuMLMtUl4u8TYLEEAxAXHaSXdCIqLclqaDRg8LbGblSa4o+kRRurV4foaDUOpmJhjo3
         QUDQ==
X-Gm-Message-State: AOJu0Yw/dzi8d4y+hx507Cm3F33y8p7N9b068aEgh5WSwqn+0XBdzYJ1
	Jn0ik51PLFpYDEcffq8CaJT9LES4QbP4H+jY3pI=
X-Google-Smtp-Source: AGHT+IGQSbEncj7NvmMzDT4rmgXfmOvUHGB7F0y213p5yCIZPUs7H+vXAPPYmdDedy1AXsSXeExQDjSsrXa6BveO+vM=
X-Received: by 2002:a25:bf85:0:b0:db7:dacf:59f2 with SMTP id
 l5-20020a25bf85000000b00db7dacf59f2mr6970124ybk.102.1702641223437; Fri, 15
 Dec 2023 03:53:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
 <1c03eb18-a6ac-45c8-8fea-46097bb4e132@gmail.com> <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
 <20231215064823.ltm55fk4zclsuuwq@vireshk-i7> <a2aca039-7360-476e-a1b1-e950698cd26b@gmail.com>
 <20231215112418.usky65sibhbiubyx@vireshk-i7>
In-Reply-To: <20231215112418.usky65sibhbiubyx@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 15 Dec 2023 12:53:32 +0100
Message-ID: <CANiq72nuUpBCHaeyozDXAZrV+YLW_OR-QOUiVHPfTbNGG3RFXA@mail.gmail.com>
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tiago Lam <tiagolam@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:24=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> I thought people aren't required to enter the build directory now (but
> just source code directory) and simply do:
>
>                 make LLVM=3D1 O=3D<builddir> rustupoverride

Yeah, that is correct, but we don't need to write the `O=3D` in the
commands themselves. The idea is that 1) the commands can be easily
copy-pasted, 2) commands look simple (i.e. there are many other
variations and options you may pass), 3) newcomers do not need to care
about `O=3D` (so it is extra simple for them).

> Will this still work if we are in the build directory ?

Both should work (as long as the initial setup in the build folder is
done, of course), so I think we can simply remove the mention about
"enter ..." now and simply give the command.

In fact, even if Kbuild did not support that, we could still remove
the "enter ...", because then the `make` would need to be run like any
other target from the source tree. In other words, regardless of the
answer, we could remove it thanks to the new target, unless I am
missing something.

Cheers,
Miguel

