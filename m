Return-Path: <linux-kernel+bounces-27505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78182F134
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361A71C235D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056AD1BF53;
	Tue, 16 Jan 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHO5N9XK"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0836C1BC4C;
	Tue, 16 Jan 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5edfcba97e3so105148617b3.2;
        Tue, 16 Jan 2024 07:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418166; x=1706022966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSN/1a15f7oyeGM9Lrw3hF9g8ErJxL7cfBh+TgaPZGs=;
        b=EHO5N9XKOM+G3S3nVSSim1x18LMuaLobkrDvonb5uELgH9BYiLh9GIrfIa3pnq4I3y
         +xdOPUvhCm756VbSuL3B1p39zzdev3JqnJmvSoq29nlAnO1r3x7i21oCOIJMDBKdwyPA
         NYmZAF5RAL4wX35mQ6E8J42nVgkOlK92GLIKa5sxlI8oCLv77G6l/kGXLScla9P0n9nL
         Quzpv9YQjHFIkSRq4FHlHb54/fCJZcx27Nj6nrZiMQ2pkpZqt6y/w4hLW2Z85yw14DCH
         /1NpSxVv25sJKdycPq0p15szR50MQqsoO8FercnCkAB/HLROGNyktvmNLsznsrR4Ia7G
         80VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418166; x=1706022966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSN/1a15f7oyeGM9Lrw3hF9g8ErJxL7cfBh+TgaPZGs=;
        b=KBk5JDbXjT9H9+3rFl465aUTJkLf8kJJOat+UP0Q7cp2HqB+Xax4NaWOaK5nTrevzW
         cSupixeYxauPMhvZ6glqm/kw4ckKD3SzbPxfoZd8evwLcVIcuMwUjXXQFCnRj9756XOI
         dIiGV/E8igudBGR9maXbsdZA6o7uQWTeUHiMqmI/f38dasAaHbLKTq/hmRJA7Kro38bV
         DPmSwpejnOvO0a33Ez3uwGVRmwiQryKGrpA7M/B2uv1msy6/T3flL9P5NdEcPKZ7Kvv5
         PrP5J86Ukz2VWlNMpo0fc/fGsmtc/j69WpLI7PY0voKUfiaJmxX+F32wXiVcsQU9b5yS
         eKMA==
X-Gm-Message-State: AOJu0YxUyUQ4QRko1QgGeDGyaF4RLHbjGw+CLcuG6V0Bt69JFsNVmsxn
	S0HKL4bAQaB4ISE+hy0d9ywTb9vipl8+C5bz8jM=
X-Google-Smtp-Source: AGHT+IGe9k13knvJv7mVIsQ9hgvppAFWfLivsE0iE7Akp5hdY4KqCSIXZVDX/dYBWRUzIqzqlKYkQegSb/NhYu+r1uQ=
X-Received: by 2002:a81:830c:0:b0:5ff:5beb:d570 with SMTP id
 t12-20020a81830c000000b005ff5bebd570mr486554ywf.43.1705418165912; Tue, 16 Jan
 2024 07:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <ZZ2fn0scbDKBXWe5@boqun-archlinux>
 <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
 <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home> <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
 <CANiq72=X3cggAn0HLMi7jVFAfypBhog=ZkPB57yfaX4ZUzT-HA@mail.gmail.com>
 <CAHirt9hdtGSsEofxDb0FCtcFeAw9n9LKJALz23Qdqh4n2=Ua5A@mail.gmail.com>
 <CANiq72n7K8LcKrs+beF2sbt1XLdr4zEhEw4xcy3yh4wgTrvYeg@mail.gmail.com>
 <CAAhV-H72Hbfy7n6+AFSFFOzizo0GtpzA074sgo48-W-Dt0VR+w@mail.gmail.com>
 <CANiq72mEPnB7yEZvtUXAM5w0GgYmzdrM9OhioLGb_LzbAJKNOA@mail.gmail.com> <CAAhV-H6BFkgN-KzEexXk9zdnOGNCdBesCEEaczEvEp8x2K2YHw@mail.gmail.com>
In-Reply-To: <CAAhV-H6BFkgN-KzEexXk9zdnOGNCdBesCEEaczEvEp8x2K2YHw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Jan 2024 16:15:54 +0100
Message-ID: <CANiq72nv3Uw8GLNqbdGBC3b+viF+o8BeppS9KWhpzBFvjqZLUg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 10:31=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> OK, since Linus said the merge window is paused now, I rebase and
> retag my tree and the Rust commit is like this, I think this is
> perfect now?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
git/commit/?h=3Dloongarch-next&id=3D706f9e1ab7c7a58d80ef2c87d8720131253a22=
56

Thanks a lot! That works, yeah.

I also took the chance to build LLVM and QEMU and I tested the tag --
it seems to work: I see the samples (built-in) printing in the kernel
log :)

So in case you end up rebasing for another reason and want to add it,
even if it is a simple check I did:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

