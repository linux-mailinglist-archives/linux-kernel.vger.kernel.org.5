Return-Path: <linux-kernel+bounces-99343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266028786EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B2F1F21591
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E4A53E22;
	Mon, 11 Mar 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6hOpfN1"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738854F8D;
	Mon, 11 Mar 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180127; cv=none; b=l0aw9Fl9hEPq0OFf7y0/1Gd17iNB8+aJj6mKDiJ33V3OtlvXjZhp4h0iGQoCWYD2q5Y3itq9z4xs8VnlU7S3d0TIZZsF/sLU93/wP/j4YGOR+CaX2uMofm7A128qCJxWzd0DoUUxwMkZc6vDANBd0doEPdtA5xjntu5kD7gF/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180127; c=relaxed/simple;
	bh=rkJoFU+8RUcVvUJAcqdZvMWhYKXiwBRaY37lui0QE2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNIKJyP3L1Dpeyt67uP16J39ezyB30Sjltxea1KIh4qwCyXP7XwvGDLC554fu9YUmrGAK9lAkxvWWXfWyh/hMIFSbqZBtGZH1pXjQNnnRwe++tzzbfyb6MuelzyKie5oFAvvssAEhbKzQ8bZry3SlWYxoKOLnBA6VNOfuUUhJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6hOpfN1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e66601f082so2857602b3a.0;
        Mon, 11 Mar 2024 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710180125; x=1710784925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4R9ADmuK2FzMV+uyNo5OY4V3RZjV78H/xpdInlrSUI=;
        b=K6hOpfN16tdkcx1IoNQhnhY85iNzGR6aBAR77VXORPZyRXkSjgeUiJw/Wt/VnQXavL
         6EoDYwzoVee6ARQ58yU71mNQ6Osisd7JA42vq390MOT9iAZSYfuekVOTgGJn53vHrG6v
         sGAiAqir0/n6fKerRnsy5k1Eo66Bb8hFY5PEWqVDcV+V90vMTaF5qG06+IqOwanlbtga
         1Ec/UAgcKQqYVqzs/xoEXLztaGK0k2gOtHwSP+lpivqLaaCCrtLzQVurRU7Va5Kamc5J
         1LLSvWBDRumG1PLQ0GSfbcdM1Z5G5uZyDvpb5a95Ac2YwBH6oUa4U6eJOmms5a29mGs0
         kadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710180125; x=1710784925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4R9ADmuK2FzMV+uyNo5OY4V3RZjV78H/xpdInlrSUI=;
        b=fu/6UUVssjiCREhcmXJ5mluJiLdSsC7LBbeTECfP1qgclsd23O9eTb59MpTeQLg6WE
         xt4qK5ia5JxVSGCI6B/AgCFuYpKbBHwqiA5kUt6JFexCB6TiCry7s/5A5+sQFsTvz+29
         yTlideJFQpgzqwzez9YsUUL55BlPuIXYrGoxKlu282gidktWGLVdNHKx5tX0PC7/CyjS
         tbJuJqifTyox+a2Rlf3dMgIMs3s23d7qBqdnEOWskVoSlyp2fywd+7ICXxQUaEI1BSmy
         WSUbn/lXIxw/JEUbjVAjEIBLsWBBCcolsgxB7kVDTHQJE2WPS1si4+7GYjFkqbOLc49X
         /o3A==
X-Forwarded-Encrypted: i=1; AJvYcCUoIBZGD2sr/eKeZ2T3+q0lJrpTWwR0koBh5OGPwkTLWgtIecNFmkPGi/jfSzqp8glGm45nqDV+XKWxj8nMiXacE+nVyME7x4DmgdVFem9f7SRKlsaJcC7/6QVkQM5BNpPn+SUEUVZLZfutdSsYZCtZE+fM1Kih14iu
X-Gm-Message-State: AOJu0YxtsDyt+VGpixIjM6fjuRzHQuLBqco8CL2Hm7tNZWb9c6+zytTd
	uB431YzMsXjD7fJfr1935GO1SCb7OoHcU/N1KOdi3+ZSZtvn6YerX38bQB6+ovC/kb+IxVNgHUv
	ye74QMY9h1HfT5/Onc33IL04fgt0=
X-Google-Smtp-Source: AGHT+IE0HXRVILcbLRkdcMQ91Ff+mSiLMeMoLaa8RV2aeF2XJTB8yy92gHL1YS2H9RjfeX/2ibS2+rn6n0/Ttk+24y4=
X-Received: by 2002:a05:6a20:3d87:b0:1a1:4848:98af with SMTP id
 s7-20020a056a203d8700b001a1484898afmr5735907pzi.1.1710180124799; Mon, 11 Mar
 2024 11:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000081fb0d06135eb3ca@google.com> <tencent_E4EB1B6A2584BA2BBBB733409EAE1B524B08@qq.com>
 <5f1446d409322de91946a569edc0b836daa52aae.camel@gmail.com>
In-Reply-To: <5f1446d409322de91946a569edc0b836daa52aae.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 11:01:52 -0700
Message-ID: <CAEf4BzbbvBEwy6_S1MRjiGWWfS_nxy6qNsEc0_Jdro1c10b8Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix oob in btf_name_valid_section
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>, syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 7:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2024-03-11 at 21:16 +0800, Edward Adam Davis wrote:
> > Check the first char of the BTF DATASEC names.
> >
> > Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASE=
C names")
> > Reported-and-tested-by: syzbot+cc32304f6487ebff9b70@syzkaller.appspotma=
il.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  kernel/bpf/btf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 170d017e8e4a..dda0aa0d7175 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -816,6 +816,8 @@ static bool btf_name_valid_section(const struct btf=
 *btf, u32 offset)
> >       const char *src =3D btf_str_by_offset(btf, offset);
> >       const char *src_limit;
> >
> > +     if (!isprint(*src))
> > +             return false;
> >       /* set a limit on identifier length */
> >       src_limit =3D src + KSYM_NAME_LEN;
> >       src++;
>
> Hi Edward,
>
> Thank you for fixing this.
> I wonder, maybe something like below would be simpler?
>
> Thanks,
> Eduard
>
> ---
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 170d017e8e4a..3d95d5398c8a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -818,7 +818,6 @@ static bool btf_name_valid_section(const struct btf *=
btf, u32 offset)
>
>         /* set a limit on identifier length */
>         src_limit =3D src + KSYM_NAME_LEN;
> -       src++;

ah, __btf_name_valid() has a separate __btf_name_char_ok(*src, true)
check and then skips first character :(

What Eduard proposes makes sense, we shouldn't advance src before the loop.

Eduard, I'd also say we should make __btf_name_valid() a bit more
uniform by dropping that first if and then doing

if (!__btf_name_char_ok(*src, src =3D=3D src_orig))
    return false;

where we just remember original string pointer in src_orig.

WDYT?


>         while (*src && src < src_limit) {
>                 if (!isprint(*src))
>                         return false;
>

