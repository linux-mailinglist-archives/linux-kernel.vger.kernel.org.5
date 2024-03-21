Return-Path: <linux-kernel+bounces-110577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306CE8860D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813C5B22806
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B68134406;
	Thu, 21 Mar 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWoEaLmI"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBCE57B;
	Thu, 21 Mar 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047665; cv=none; b=CQmbEkUK7f66tm6URqvpbyd4UdJDUNVn9HMXhoo+R8LVibrU30xCosVlr0s63YaKNeBMzBu/gpAgFJ9KGR0Z+4CWYw4OUGiIftgbWTXky8yUdhVwm84pcyH9TTTrzHEDkntbx+HiztBwagh26IbC2/jfm8qQXtgIV2qe6+M2Hp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047665; c=relaxed/simple;
	bh=YUX9RxKkWXgLUlg1ZO2OrjKycS8zeiDnhjRiRetu/Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaFJQw+diSTe2Bm6Rnm3H2EtsxrxEa8b95YckPik4RlBXgdYIpc6WwLNvbaiqjNbgTmH/V5UEvijMuap4mVe/fLkY8lkOGRt8ebtTPJBOkDKxqVD9TpkOCGUdCv0jT5AB/xjhLxLEXkiSbfScoqxTfMYFDqfTskbwYp37HcG3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWoEaLmI; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd72353d9fso788428b6e.3;
        Thu, 21 Mar 2024 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711047662; x=1711652462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9LMHhAil+e1DwoMOsUUxTokSN39rbYNgoUrrRrbF2I=;
        b=kWoEaLmIXiGjmFQK3GsB6EU58NUz7N61bcM7ctc2naO3BuqiY0v6tGpWyA9qDeoN6O
         Nvg3PAIkYenyqiqjsc0wKzABFuJnmGEsRekO/Qek0+jErRSDpovz1u/603R06890f1iq
         o8ffRb0/C/FRxj/fOaMMC4KUYIqr5GwP8lc9oQocycJZTE0ZthcfxV+Y7Toj0GQ3L9jY
         wDYwGyHPzjiYbXRCJVL0IlGgnygxqT4m3ruYSHnHsTqc55GME8yS9/Xz1NWBMNyLZ+v4
         qJI29ieRxV87EVg3pw79OEDjBubg7kBPb4NfP002gGpGt7mSeetm6kvRofNw28CxbIdL
         k5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711047662; x=1711652462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9LMHhAil+e1DwoMOsUUxTokSN39rbYNgoUrrRrbF2I=;
        b=cWmqU/J07Gq90aTr8tMVcgZ1BFmBzvFWLCQQO2p8Mhd2X8IhK5/pVt0Yk/A41vcM5X
         F+b+KGGTlKsddcmZ5+W7L2AMmD1KzzGlvCGO2uhYjTfeIXmXBMnsMyQokp7Omadzc7i/
         Tt7XDASVHCGQt1uDL5MXk9hX0PNB6hDpxTA54hDC46QWhIWMCMC1qsaNLe/aS28u0eXk
         MjPfz4v6oeOzS2VUzLH2KFsbGxnzXkdat7tV3lSO1ExPsns8o2t/W3MHeZtraUyiluSA
         4F3DTx4W0cSoacUhxmcBjYN/aBhl4bkNf42JwtgCP2t50j52wBsfhecO8yeBZhx2YZJX
         hZjg==
X-Forwarded-Encrypted: i=1; AJvYcCWyaCAIsdhtFZ5sXkXod7nZByg0RYl1mxT+gmh8s2BdWYHeDzU0+uPmjdvtZcgtSxAVpd+XpykCYMeepx0YbalYRWsDS8cZuMlFIWM/YJf5+I55tSbzpwepn9rZN1y1nCEh
X-Gm-Message-State: AOJu0YyKHSgNrfUrMxhpY7eGBNV8LRNa12fkKuTV6ooKAi7h6F3PEBBi
	+SsXwtOl6uuy4YndyhOVWcKyLLDaLCNVv+JKMS2B95jQEAQScncgGkw29GesP0IjjyecVnvPAmu
	oMt1oNCAE6oUAw2//+uhsGg+NFXhH5W6zcXA=
X-Google-Smtp-Source: AGHT+IFgzxgAPRHvuLr0wrtOjzi8zMJYI0ETlh7IR0JuYFGwPrOAo/6WwU9MifXa5daKL6je4JiBoOkXEMF3UnHuLRQ=
X-Received: by 2002:a05:6a20:4394:b0:1a3:6e5c:46f4 with SMTP id
 i20-20020a056a20439400b001a36e5c46f4mr625119pzl.7.1711047166738; Thu, 21 Mar
 2024 11:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321170444.388225-1-chen.dylane@gmail.com>
In-Reply-To: <20240321170444.388225-1-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 11:52:34 -0700
Message-ID: <CAEf4BzYJeEViQaRJb6u06GJSLa6uBmykRZa4JnWJ9VXw+WoX2g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add specific btf name info when do core
To: Tao Chen <chen.dylane@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:04=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> w=
rote:
>
> No logic changed, just add specific btf name when core info
> print, maybe it seems more understandable.
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>

Can you elaborate on what problem you are trying to solve?
Conceptually libbpf does look for types in vmlinux (meaning main
kernel BTF), even if user overrides BTF location (presumably because
of old kernel). So even when we emit "vmlinux" in logs, it seems
correct.

pw-bot: cr


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index afd09571c482..b32154288b4a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5653,7 +5653,8 @@ static int load_module_btfs(struct bpf_object *obj)
>  }
>
>  static struct bpf_core_cand_list *
> -bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf,=
 __u32 local_type_id)
> +bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf,=
 __u32 local_type_id,
> +                   const char *targ_btf_path)
>  {
>         struct bpf_core_cand local_cand =3D {};
>         struct bpf_core_cand_list *cands;
> @@ -5680,7 +5681,8 @@ bpf_core_find_cands(struct bpf_object *obj, const s=
truct btf *local_btf, __u32 l
>
>         /* Attempt to find target candidates in vmlinux BTF first */
>         main_btf =3D obj->btf_vmlinux_override ?: obj->btf_vmlinux;
> -       err =3D bpf_core_add_cands(&local_cand, local_essent_len, main_bt=
f, "vmlinux", 1, cands);
> +       err =3D bpf_core_add_cands(&local_cand, local_essent_len, main_bt=
f,
> +                                targ_btf_path ?: "vmlinux", 1, cands);
>         if (err)
>                 goto err_out;
>
> @@ -5793,7 +5795,8 @@ static int bpf_core_resolve_relo(struct bpf_program=
 *prog,
>                                  int relo_idx,
>                                  const struct btf *local_btf,
>                                  struct hashmap *cand_cache,
> -                                struct bpf_core_relo_res *targ_res)
> +                                struct bpf_core_relo_res *targ_res,
> +                                const char *targ_btf_path)
>  {
>         struct bpf_core_spec specs_scratch[3] =3D {};
>         struct bpf_core_cand_list *cands =3D NULL;
> @@ -5813,7 +5816,7 @@ static int bpf_core_resolve_relo(struct bpf_program=
 *prog,
>
>         if (relo->kind !=3D BPF_CORE_TYPE_ID_LOCAL &&
>             !hashmap__find(cand_cache, local_id, &cands)) {
> -               cands =3D bpf_core_find_cands(prog->obj, local_btf, local=
_id);
> +               cands =3D bpf_core_find_cands(prog->obj, local_btf, local=
_id, targ_btf_path);
>                 if (IS_ERR(cands)) {
>                         pr_warn("prog '%s': relo #%d: target candidate se=
arch failed for [%d] %s %s: %ld\n",
>                                 prog_name, relo_idx, local_id, btf_kind_s=
tr(local_type),
> @@ -5920,7 +5923,8 @@ bpf_object__relocate_core(struct bpf_object *obj, c=
onst char *targ_btf_path)
>                         if (prog->obj->gen_loader)
>                                 continue;
>
> -                       err =3D bpf_core_resolve_relo(prog, rec, i, obj->=
btf, cand_cache, &targ_res);
> +                       err =3D bpf_core_resolve_relo(prog, rec, i, obj->=
btf, cand_cache, &targ_res,
> +                                                   targ_btf_path);
>                         if (err) {
>                                 pr_warn("prog '%s': relo #%d: failed to r=
elocate: %d\n",
>                                         prog->name, i, err);
> --
> 2.34.1
>

