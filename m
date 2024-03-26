Return-Path: <linux-kernel+bounces-118201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3068588B5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C8E1F642FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06237F6;
	Tue, 26 Mar 2024 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2Ns4XTH"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99177163;
	Tue, 26 Mar 2024 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411452; cv=none; b=W+qeVryFp01o1hWH7J3Nv+YZMIi7o3Vl7NxEbheQ5/ETtj7mvz+1YKR7b5FrTxEptvT0HTjpVnjtT2X6SuoPGfwYAu0NgJmQWEBgGc/Bf5i1lux7Jf8LEPPNdcAd+C1uCzAq5fpxOpOEoLKVHcVmtw+CGt89mZnpx91bTnr/fD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411452; c=relaxed/simple;
	bh=vRMHBVN0gMv3VsHuufDcHA+TPI3uV4HjOZ0NHWkp1Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdPxL78qWGKe6+D4EqA3BmKNVRu6CthMEWymqk06LBlfM9Ng1I1QRcfDH7PzNSE/LOwC+eViU7V5PSO7N8tWyIvG1KOTUM/vIFEb7OxMl+HPSBeI+HhyLS4gqbWktzNKDmyMDkyVSJZySDKT0GuhU1V1b4iAZpjrZhiiGDOdkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2Ns4XTH; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so4205409276.0;
        Mon, 25 Mar 2024 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711411449; x=1712016249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8tmSr/y14lH7hu0JGGH5W+AymJvwytlT1M2HaCSQgHE=;
        b=E2Ns4XTHhh5ffEc6YZyQGCQIvMEUEkwUVAgoZ9wQJ4myP2ixUwZbx5smDJsTer/piW
         HXLJVOmLwh+6nWs8XuiKNQTvsjlaEI+MkuI6y5jujNTxXDSO+X6vvdtqkJ9lql0sN9iE
         /bRfTVyohKeihhpA35kni/T6wze9NLZNfAWL9XXOLae8GqM6sJ35JRBBeq/mkIQtFUob
         ySTkECPjSadsHv/5jUPb3KMIMvki2ox4a3AI0+EOiGrrCQkpq8qx5BNPezzsNIG9LrJA
         Sd564WTVi66z+MBgqRZ8DYT2JGeqYgCNWUKOL7UdfQYUqOIkhBjgMVBmi0qa+KBW3rRf
         UNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711411449; x=1712016249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tmSr/y14lH7hu0JGGH5W+AymJvwytlT1M2HaCSQgHE=;
        b=Hi2HCPLH0LT6JHmEyBmQdxJVou1O0owZ69XIz4X2pdRiLTXnTrHCdTCwKLVShrJpSY
         wyGJLMWVQ2zlZTbZ4/+2AOYaJoS4g0E081t0O92F19bTYAD8QklzCMvkcJa6D+m2mKY8
         k361W4sMhjTtYG6FPyrqGlcOcOZitXO77/0O0zNxIF6iTSpnFg+SI2aLlrf1dz1XaKTv
         iJM6Ix8gY9HLtY4fIgVjkNLxwuqc2oFzyOaA9MBBfqUevSOZgtgrTbzZBZ6K29gXUnOJ
         zF4PlqOeMpEsMmvh2sJlwq41Xk3+BTGGv9ArmINgAoZipIi2ygOPKcv5cQvJmxaMtvOG
         p3JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDAf/wOeEeWla8xlE5Y4XfjsYnfpgFIMLF0dOx/qp5kfe6Zz4Aygs1JbJ9mEpZuO39p7jCtI18/dF8mnMb9hGiiWx9s83amWmOvrPo
X-Gm-Message-State: AOJu0YxnmaWf/ZF5MthaQJOJJzWxZUZpqjqccdSslx1Xh8zcYMAdNUWi
	fMGP6bTrWNY8ZfhWB/+0qrJ54AHIP5KuEzUVo3Ae6lVqGF4d169eK4+lnGBE89+3tQNC7A/L+Kc
	91H0HnPfi+OvRK5UsVDX6AQ6UXWI=
X-Google-Smtp-Source: AGHT+IHj/fEFbfGoOPdKrEl+n+Nz+uSBm2n8rE0tjzz9I83f7zIeDdcNGUxuOJMgPdJUItDaZngpF19eyGAuiIa/ueo=
X-Received: by 2002:a25:8682:0:b0:dcf:3f11:633a with SMTP id
 z2-20020a258682000000b00dcf3f11633amr5875276ybk.35.1711411449526; Mon, 25 Mar
 2024 17:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-8-wedsonaf@gmail.com>
 <ZgHiJ23TdOmnSGe9@boqun-archlinux>
In-Reply-To: <ZgHiJ23TdOmnSGe9@boqun-archlinux>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 25 Mar 2024 21:03:58 -0300
Message-ID: <CANeycqpRfgTof1QeX4NnTV5NidEHxYCan7rvEw+T5nRyMDD9oQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] rust: alloc: update `VecExt` to take allocation flags
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 17:44, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Mon, Mar 25, 2024 at 04:54:15PM -0300, Wedson Almeida Filho wrote:
> [...]
> > +    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> > +        <Self as VecExt<_>>::reserve(self, 1, flags)?;
> > +        let (ptr, len, cap) = destructure(self);
> > +        // SAFETY: ptr is valid for `cap` elements. And `cap` is greater (by at least 1) than
> > +        // `len` because of the call to `reserve` above. So the pointer after offsetting by `len`
> > +        // elements is valid for write.
> > +        unsafe { ptr.wrapping_add(len).write(v) };
> > +
> > +        // SAFETY: The only difference from the values returned by `destructure` is that `length`
> > +        // is incremented by 1, which is fine because we have just initialised the element at
> > +        // offset `length`.
> > +        unsafe { rebuild(self, ptr, len + 1, cap) };
>
> probably use spare_capacity_mut() here to avoid `destructure` and
> `rebuild`?

Ah, yes, this sounds like a better approach. I will use this in v2.

>
>         https://doc.rust-lang.org/std/vec/struct.Vec.html#method.spare_capacity_mut
>
>         // .. after reserve succeed.
>         // there must be room for adding one more.
>         self.spare_capacity_mut()[0].write(v);
>         // or unsafe { self.spare_capacity_mut().as_mut_ptr().cast().write(v); }
>
>         unsafe {
>                 self.set_len(self.len() + 1);
>         }
>
> Thoughts?
>
> Regards,
> Boqun
>
> >          Ok(())
> >      }
> >
> [...]

