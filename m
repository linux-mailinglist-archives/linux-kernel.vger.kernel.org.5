Return-Path: <linux-kernel+bounces-22018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC52829802
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092C61F26A90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD547A64;
	Wed, 10 Jan 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEVeTbYb"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E847A58;
	Wed, 10 Jan 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f0c0ca5ef1so39824217b3.2;
        Wed, 10 Jan 2024 02:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704883780; x=1705488580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkyAuv09jckrb1xtJ7Sn9m5uY5gMhi9Dyi8024qOado=;
        b=iEVeTbYbUGnuNg/OARaHQc1dkH2wlTGkrw5/TIenxuFDpm8xkWFLHK/BPB5uNY/RFi
         Z9k66nf4AXzcvNeUsYed49KcZdgftSgaop2Y7Pg5SLL+3+qpJ86iKDoTjYaLcMoAcdP5
         WGJsHdVl5ejDnjsbB6gg5fyqC0MHsosXUvFhbAqHbZn/n1wQDAbfQtpNc5/AWyIw0mQu
         zLZjBNjvTHHYX52bVrEiCSMhc0P3qSMxcwQD+7UESZ3zyIBRSB/q+7b3bZqJeMVXnt1y
         ehkbAKSibKkyYnv4P0ij8tJtui5HsE8OnNWWx1tcuSN4biCAtqSAMbxJvSfWeP9IcmT6
         wnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883780; x=1705488580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkyAuv09jckrb1xtJ7Sn9m5uY5gMhi9Dyi8024qOado=;
        b=GOWA2P4Ipf8vewYKN2dvW415CHmEk+6ut7r9zas2RiUcrI2bJsld0UwSKCmzRyOW8q
         CGYgMl+I2CGRcqGnB6YnSBA3YHhMw+bXkA9c//+PdAM2voed+iMXla+/6jB/DHoGdrJq
         7bimL7+hVhcyCRbzNXSCNZrZzXAXxVL1UEU3Uc9RzhPjYePWp7vj+AeG39U8hBy5TEzE
         ckGHjZDZCEUpVQKKrereGe/Mr4+AlwpFwol+PDr7p5ZgrPX3gFjdyvR9N47UKqBwTzA0
         8WubDYcSMjKs6GylaBzjztScID7v7iEjLe6eWCIPgal+sD+u+z6gYhyOiEb8uArqj5sy
         NxeQ==
X-Gm-Message-State: AOJu0YxTfDZWW3Eve+vzV2HFvPN1oe0RBE8cAgyurnKC8uQ27b0adNtR
	tvvC8/DNYSvnE8KDL/ecYziFXp9QaX2Exnide0M=
X-Google-Smtp-Source: AGHT+IFeCydfST7aDCwuFPDsuw2cwzVOE8Fv3I4KKk4ctjbM0/io4Cl/D+NT6BNGEexZTsX+/kt1LFfmucwY15LWnKw=
X-Received: by 2002:a81:6d0f:0:b0:5e8:8053:70d1 with SMTP id
 i15-20020a816d0f000000b005e8805370d1mr793142ywc.50.1704883780409; Wed, 10 Jan
 2024 02:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <ZZ2fn0scbDKBXWe5@boqun-archlinux>
 <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
 <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home> <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
In-Reply-To: <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jan 2024 11:49:29 +0100
Message-ID: <CANiq72=X3cggAn0HLMi7jVFAfypBhog=ZkPB57yfaX4ZUzT-HA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: WANG Rui <wangrui@loongson.cn>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:49=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wrot=
e:
>
> LLVM 17 doesn't work. The minimum LLVM version required for LoongArch
> is 18.0.0. This is the reason why we have updated the
> scripts/min-tool-version.sh. [1]
>
> [1] https://lore.kernel.org/loongarch/20240108033138.217032-1-wangrui@loo=
ngson.cn/

Thanks! Is this targeted at 6.9?

Cheers,
Miguel

