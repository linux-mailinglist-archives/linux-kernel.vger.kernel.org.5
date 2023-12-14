Return-Path: <linux-kernel+bounces-8-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF692813AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4562830DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487F7697B6;
	Thu, 14 Dec 2023 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6CqAjUe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2B69784;
	Thu, 14 Dec 2023 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5d279bcce64so85072627b3.3;
        Thu, 14 Dec 2023 11:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702581716; x=1703186516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32f1ODP5jzjp5omUke9Q28vFaf1t301L7/qEDCrEvCg=;
        b=P6CqAjUeRELxtWLLjECYrvz+S7LHIjlYPTbb0BQJnYH/2rfQOlcmpcx8w3cHWqwWRe
         hkuayPzDSHSv09i75Y6oUzAkrZOy/bt+LWHGnVzT92zvxrgE0zbg2mH1irYUdxln4dgQ
         hTrSi9moKBWLleHQMiiyzTnpRS64Ne7vgGFBduafIojuxbPtdjOI4xpTu5+6ThJ6qbFw
         yhTSZ9nNYhVPYrLQF7HLVIZkgNSwQxu4oiIKbv4MGlGSAmiTi4qjJh8lJBD/pGEn66ec
         vfOeHyZtum6/Rg0ftIGR+SMWf9GKr59deLAj8f51DUQquTpHjDBoCy4FMovpmjCEszx9
         YDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581716; x=1703186516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32f1ODP5jzjp5omUke9Q28vFaf1t301L7/qEDCrEvCg=;
        b=FjqRu8hKZ0tzby8OkGQtmX5cFOh3T++vOn8xCUWTeNIG5JarP5yhsFzE/4yP+as2U3
         152fSS6/4GcyVBtYJDNXVCuKDLFJMAANJ3kX3xxqd32GBoLpZsVQ3btWU8jvdsfIFuZ5
         0YRqWhTqaMw0GrpSFUdqPQhsaVlPhPqPBur6L4PG+efI9SqpdKjdSTkBTTP+zK5Fyxl9
         q/MMLVepbwDKNUOqfF1+To3jFxk0cL80kCcE1ITHx06S6Am1wBqWDoTHlWoYChCZ+Zux
         rr9Hv9EHvX5Ws2v/N3GZRxdBDZyiXnJ+Oqx8aYs4I9WdGClOOIRarB+8xT3dzyS3HtcW
         NavQ==
X-Gm-Message-State: AOJu0YxasZjoiIn4rAz92e3U41VuwqthBUJgPy8aAVnJMGXEN5YAn24u
	7g6q0B59RAOdENQPygIVLB7PlQXedoPdZJxd/4s=
X-Google-Smtp-Source: AGHT+IGCqdZA4lOqZIvYEP4NTZIR+XkAv80qOBlOhcyXhkQTidlucJ14K+5yp3qRaktAw0Z8EXC4KLLCxJKL3NRm1Zo=
X-Received: by 2002:a81:5b85:0:b0:5d3:5b16:8b1e with SMTP id
 p127-20020a815b85000000b005d35b168b1emr9147810ywb.0.1702581716195; Thu, 14
 Dec 2023 11:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104145700.2495176-1-gary@garyguo.net> <CANiq72k46_1gnEMnB-38N45yOwnKFFLkwZbgB7taYppT2jPAnQ@mail.gmail.com>
In-Reply-To: <CANiq72k46_1gnEMnB-38N45yOwnKFFLkwZbgB7taYppT2jPAnQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Dec 2023 20:21:44 +0100
Message-ID: <CANiq72nuYPkfpSWduN8SMY-JY-T=GdB4bC7EFC26m3u2Td7AJw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: bindings: rename const binding using sed
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Vincenzo Palazzo <vincenzopalazzodev@gmail.com>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 7:44=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Applied to `rust-next` (reworded for typos and with Benno's `^`
> suggestion -- we can always relax it back later if needed, the output
> is currently the same).

I have dropped the `^` suggestion from `rust-next` since that breaks
non-`rustfmt` builds [1] given everything goes in a single line in the
generated code.

We may want to consider requiring `rustfmt` at some point to simplify thing=
s.

[1] https://storage.kernelci.org/next/master/next-20231214/x86_64/x86_64_de=
fconfig+rust/rustc-1.73/logs/kernel.log

Cheers,
Miguel

