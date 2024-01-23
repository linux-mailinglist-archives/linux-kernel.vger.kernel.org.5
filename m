Return-Path: <linux-kernel+bounces-35858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2584839778
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889FA1F2D745
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA981AB9;
	Tue, 23 Jan 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpKuEnyi"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37195FDA8;
	Tue, 23 Jan 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033952; cv=none; b=Fu1/RJVBh329XGOpZYVBYuLenxcIBg+C3DpKhRab1waOwc4cqDzaGqVr1W+gvCbof3D5ls52KKGD0x6QqbSajxJdRFh2OZA2/DieQRNhUdzxPsmM0FqEy1FlJyPB4Z3a8Smc6y4z9Lp1f0duhSbZGqvLAAO6N5nhUaxNBi3KjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033952; c=relaxed/simple;
	bh=I7EaLHyv+zjRWE7JLMFlBZeY21iA0/68G15sTjitmic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlEZ8+E0CWPs/O/7QsO1NJ1IeASvmBW5LVxwlRWbgyZA0DySqtGpP6Mzn+mm/2uq3KuZylL7hHqZwtCcWfBlw2YjZvJ7dwlK9uU1yd3JYD6TC10dZcDZs12SPvkbY5fCSd1zGNCvDvF09w+MMQLN+19oMdjtks/l9aj+XMvx034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpKuEnyi; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ff828b93f0so40325947b3.3;
        Tue, 23 Jan 2024 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706033949; x=1706638749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7EaLHyv+zjRWE7JLMFlBZeY21iA0/68G15sTjitmic=;
        b=OpKuEnyir1x2y+q7QGDmN4HZJwzbE7+t38KTBW5nYmK6SaSZ6nzo1O2xTx94Lznt8h
         M38E8Kksd7gbXMhrCXKnvE+80snY5ENgq8G0Vm6M8z7tW7g5MLDUV25i3F2TgeqRFYlU
         T2S+QThcyY5miRic2uoRbDVFKymm4MpLJR6l/G313zZPb9F69LZCNujYBfa6/28+ARGP
         BgoPvl10NT5D/I2GKhElcdt1yhSEYp3991HVW/2yH+quvMzrmu5WhsEy4QyPd8pe5hyz
         bfcN4LI3ioEGs3aB8lsoLhH7+HODzKQDqcIiPwswamIAkK8uhGTIuzK/B0GtrlW+ieLL
         qHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706033949; x=1706638749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7EaLHyv+zjRWE7JLMFlBZeY21iA0/68G15sTjitmic=;
        b=jfqiRQ3LqQ5M1p/TV2h9iw9dAXRINEvbDhCB5/8Etbjnpl+vXsF9PiGJAwNwyYPraB
         Ds7VIX474/S9tuRz++nsm4t04eMQ8FSBDQQvhSEWw2D0uN/fVCN4ATxGztx1MVSMcfPx
         Xo+X6G/865WVri67aVr4Z39ubWwlyzeZEvZYgSfdhzXWHJtat43J2uZWWLNgpip4aNPv
         hQfmYiyLiz0Axs6tiIEBtzAlIgpuLU1TtK6XUXRyRZXW65fIS8typVsJrqyDkXC99l5I
         K53k0Y7hRB5VW9uUziTlgGveR/bpnWXMvwD+cGqrxsdNPnAj7kT0+jl36toecZy/zAAK
         fw6A==
X-Gm-Message-State: AOJu0YzBNmEyS3Z6OCH/3B+qxj+k1jmodbN2/TfAeGhXmKH/fKCZDuw0
	3zeLwfCoZtkS0/WK/pdN3hxt5r9MkHHCFA5DJxrleh2or6cXJG7j42yOUPdt3+ejmzx3mQJnDDn
	6MTiYYiLLyb8dWGm3Jwv5ptbdzFs=
X-Google-Smtp-Source: AGHT+IHyUT8MHOsF6IBmTbANIqwgs2PT5BNWkCdv0dyAFhLayi1VUmpCSrLIW3NTLwOzJOUEEgLOK72SK+ulDnc30KU=
X-Received: by 2002:a81:69d4:0:b0:5ff:9555:79df with SMTP id
 e203-20020a8169d4000000b005ff955579dfmr4955779ywc.92.1706033948768; Tue, 23
 Jan 2024 10:19:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122184608.11863-1-dakr@redhat.com> <2024012252-attempt-tables-e3fc@gregkh>
 <Za7uampZiG2IP8dE@cassiopeiae> <2024012251-geriatric-morphine-a275@gregkh> <Za_2WuQh9vr2Na7S@pollux>
In-Reply-To: <Za_2WuQh9vr2Na7S@pollux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Jan 2024 19:18:57 +0100
Message-ID: <CANiq72=mrbRXcKGOC9M5=-_cP5ShnYGLF7t8Dt7WDCP+xffK-A@mail.gmail.com>
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 6:24=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> We also need to consider that simply wrapping tolower() and toupper() wou=
ld make
> slice::make_ascii_{lower,upper]case(), str::make_ascii_{lower,upper]case(=
),
> char::make_ascii_{lower,upper]case() and CString::make_ascii_{lower,upper=
]case()
> inconsistent. The former ones already only consider 'a' to 'z' and 'A' to=
 'Z'
> respectively.

Latter, right? i.e. the kernel ones are the ones that consider the
extended ones.

> Just to clarify, personally I'm not worried about whether we consider the
> extended range in this specific case or not. I think it's more interestin=
g to
> generlly figure out if, for such modules, we want the caller to expect C
> bindings to be called or C logic to applied respectively, or if we want t=
he
> caller to expect that everything is aligned with the Rust std library.

Yeah, it is normal to provide Rust abstractions that follow the naming
and logic of the C side. Having said that, in this particular case, as
you say, since some of these APIs are already in Rust's `core`, I
think it is OK to have the Rust ones completed for `CString` etc. But
if we are to provide the C logic, then we should use the C names.

In other words, in general, what we should definitely avoid is mixing
them, i.e. using the C logic when Rust std names are used, or vice
versa. And maybe we need both the C and the Rust ones in some cases
(should be rare, since it is likely only to come up for things in
`core` like this or perhaps for well-known things in, say, `std`, but
at least for those we do not use them in the kernel so it is a bit
less confusing).

Similarly, it does not hurt to mention whether an API has any subtle
difference (or not) with a similar C API. Sadly, we cannot (easily) do
that also for the existing ones already in `core` too, but it is not a
big deal.

Cheers,
Miguel

