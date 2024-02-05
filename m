Return-Path: <linux-kernel+bounces-54070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE484AA4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B2C28CA0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EB4A9B0;
	Mon,  5 Feb 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB187Jmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00D4A99C;
	Mon,  5 Feb 2024 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174671; cv=none; b=Vxog5655FjKEqJP6+rFkD85Jk0mo8ygCWjfo861Q7lTR0QU4/bHA/4Os8siilGCjkk6DWAihqEbwW4xJbX2HmAWIdaL3lyKtzYc6El1rZURsdiu9wSNGC1Da3a2sUjhBeL75RkwBLQTeyjjiO5rMU0cKuv+PKBNNnacECPWToAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174671; c=relaxed/simple;
	bh=kKKhcMaqwLfUrQpjENPUNxtz3qXKdR24f6zeijBX9CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfX4qUK1cvmFMe7F7H/ACuRkEo0AfAuOxHOUcE9ankoIM7aQIuYd+xV7vF62C6c7bOg1lpDbHcdzSFkzS2Cmf/OLEifQp+o5CwpOF+SKZ6gcbIcr45AMEb8yeda9PnWm0fHv2WkoeLs8kFZBTYEEQ4L6qSDZlbN3dkl7yuMMVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB187Jmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E64C43609;
	Mon,  5 Feb 2024 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707174670;
	bh=kKKhcMaqwLfUrQpjENPUNxtz3qXKdR24f6zeijBX9CE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HB187Jmc7N7uKVocaYk9dPVnB0bc0p+8iqaeqwMCeBQC0ZqhLdrW5YjLlU9tsfcx4
	 pgwHPeYFLw0+aHppjkw35gZgsTrwzZEum4uVFCDDyjS6KpxNO0pjSNezg5C0DYSwB9
	 9on4UE/EAlIFzTxnR1Z1Qd6PE6NFULCjGkN0uV93j0OpObNr3VLvi33C0ossP0j3ke
	 /CTmygQGpqJmghvmv0/gBordhtTRSZiiRiECkmV8ubfpRSB9Hi+q7sVj7ZthVVjv1b
	 yAonpdQ6wKRdWVgcXMuCK2PPO2vOr3+7Rg3QWuzSpCK/HHcEKU8/yU4kuS7wKlTIrK
	 OyfXsaEhsR2sg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so63531461fa.1;
        Mon, 05 Feb 2024 15:11:10 -0800 (PST)
X-Gm-Message-State: AOJu0YziolENu1FszCFANQIQq4YZ6GRgAeGFAdzha71Q+QJxNm3JdB8k
	ip14I5hhqIo4E7CZFVj42r16AKpZCr4ak2IrBHdN/+hHJIjogtqBXv4aKzNgURL4nd2XUdXZ4ZO
	0vgccMY/f010pA23QMpz5NpKCr7s=
X-Google-Smtp-Source: AGHT+IH/zQJiT8/Oo7PpxCUmoye89gZAefcTyo51dU8Du8JULRbKsx7NuW1HiTmxHkDZc8e1guuf9kncHcYJ5t3C078=
X-Received: by 2002:a2e:9098:0:b0:2d0:996e:b014 with SMTP id
 l24-20020a2e9098000000b002d0996eb014mr347168ljg.32.1707174669110; Mon, 05 Feb
 2024 15:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com> <23c67ffc-64a5-4e19-8fbd-ecb9bfe9d3ff@oracle.com>
In-Reply-To: <23c67ffc-64a5-4e19-8fbd-ecb9bfe9d3ff@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 6 Feb 2024 08:10:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfTW+OMk1cJJWb4E6P+=k0FEsm_=6FDfDF_mTrxJCSMQ@mail.gmail.com>
Message-ID: <CAK7LNASfTW+OMk1cJJWb4E6P+=k0FEsm_=6FDfDF_mTrxJCSMQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
To: John Garry <john.g.garry@oracle.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org, 
	rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, keescook@chromium.org, nathan@kernel.org, 
	nicolas@fjasle.eu, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 5:25=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 02/02/2024 15:01, Masahiro Yamada wrote:
> >> --
> >> 2.35.3
> >
> > As you see, several drivers store UTS_RELEASE in their driver data,
> > and even print it in debug print.
> >
> >
> > I do not see why it is useful.
>
> I would tend to agree, and mentioned that earlier.
>
> > As you discussed in 3/4, if UTS_RELEASE is unneeded,
> > it is better to get rid of it.
>
> Jakub replied about this.
>
> >
> >
> > If such version information is useful for drivers, the intention is
> > whether the version of the module, or the version of vmlinux.
> > That is a question.
> > They differ when CONFIG_MODVERSION.
> >
>
> I think often this information in UTS_RELEASE is shared as informative
> only, so the user can conveniently know the specific kernel git version.
>
> >
> > When module developers intend to printk the git version
> > from which the module was compiled from,
> > presumably they want to use UTS_RELEASE, which
> > was expanded at the compile time of the module.
> >
> > If you replace it with uts_release, it is the git version
> > of vmlinux.
> >
> >
> > Of course, the replacement is safe for always-builtin code.
> >
> >
> >
> > Lastly, we can avoid using UTS_RELEASE without relying
> > on your patch.
> >
> >
> >
> > For example, commit 3a3a11e6e5a2bc0595c7e36ae33c861c9e8c75b1
> > replaced  UTS_RELEASE with init_uts_ns.name.release
> >
> >
> > So, is your uts_release a shorthand of init_uts_ns.name.release?
>
> Yes - well that both are strings containing UTS_RELEASE. Using a struct
> sub-member is bit ungainly, but I suppose that we should not be making
> life easy for people using this.
>
> However we already have init_utsname in:
>
> static inline struct new_utsname *init_utsname(void)
> {
>         return &init_uts_ns.name;
> }
>
> So could use init_utsname()->release, which is a bit nicer.
>
> >
> >
> >
> > I think what you can contribute are:
> >
> >   - Explore the UTS_RELEASE users, and check if you can get rid of it.
>
> Unfortunately I expect resistance for this. I also expect places like FW
> loader it is necessary. And when this is used in sysfs, people will say
> that it is part of the ABI now.
>
> How about I send the patch to update to use init_uts_ns and mention also
> that it would be better to not use at all, if possible? I can cc you.


OK.


As I mentioned in the previous reply, the replacement is safe
for builtin code.

When you touch modular code, please pay a little more care,
because UTS_RELEASE and init_utsname()->release
may differ when CONFIG_MODVERSIONS=3Dy.







>
> >
> >   - Where UTS_RELEASE is useful, consider if it is possible
> >     to replace it with init_uts_ns.name.release
>
> ok, but, as above, could use init_utsname()->release also


I am fine with it.


init_utsname()->release is more commonly used
(but less common than UTS_RELEASE)



$ git grep   'init_utsname()->release' | wc
     28      92    2065
$ git grep   'init_uts_ns.name.release' | wc
      7      34     587
$ git grep   'UTS_RELEASE' | wc
     57     304    4741




--=20
Best Regards
Masahiro Yamada

