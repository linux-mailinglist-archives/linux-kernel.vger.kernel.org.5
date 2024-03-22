Return-Path: <linux-kernel+bounces-111901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023088725E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC281F24F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61C60DF3;
	Fri, 22 Mar 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K03ZKwNT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00560DED;
	Fri, 22 Mar 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130274; cv=none; b=n3jg/RIFlNLHRtqFzeMi2eMnxasnPK0nUxPbk8FjsD95lmO7ZtzQzrMhmwklF5eI10eE60iXVZdj/RvCmodWWfFVevp2ARcmKkEu+o46kdkwm4JX2K5UCU6uT5+LcIf8dtK4EV8kxE6g5KpvpUe0pk4Yo3eX3217b+YtiRlkWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130274; c=relaxed/simple;
	bh=81guNSONTPOzcQbDpdBs9ie/oz1dLsglGR7hW77hskM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBfHIN4C2hoHWuGIfY2BtbISMvByqIgggJIlzkrbwRnW253lxpHN2uz652GfXgQZ4+vo3iXa5ltKjb4/qP1VScDFuhOyZrbXhYgHCbvPwSun9N/AQAbv3Ysft2VtkesJ1xeQ3u8RdotOUHv8SZVXkT3l2pGDw5D61sZHm5fDMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K03ZKwNT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so1892326b3a.0;
        Fri, 22 Mar 2024 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711130272; x=1711735072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJU/s9RDeuR4/JqTbCXKWTk7CZccjRYG/vO14Nz0+1M=;
        b=K03ZKwNT+ZFNwT7o+HX253Uh7f6SBIYx0jaX9wncxTDKLsJkEB4JwaqEhXSDdKStER
         U6ycRJlVDyaR+X3E/zE69A8Dvrc72yJbd6GaWiLBVVaRp5ortG+KkMs1IICEoQ8KPZmk
         AAFY3dRaFIW184eDzShyg0Gm/FB8nFVbQV2aNWuL+ASFJNAUBzmG9bqeMe4meS/FRkF0
         GNntJH9+3jFxdht/bD0ClnleOpTyWDDoVtzsOBOQWTCI93hs0IiWlAvBEchurNP+4ipk
         vmsV36vNkqHbdJtejcHJTFvpjSrd/nhfSdyZTb/BC8Qqvd97B46dEDOe7o1frcuMMp08
         gdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711130272; x=1711735072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJU/s9RDeuR4/JqTbCXKWTk7CZccjRYG/vO14Nz0+1M=;
        b=PbD6bwO4JjxTs371Aete4fukCop7n3Vopez9imXM25RO0MepC2AShJvRZ6+iakwRJm
         +NYFqN1ZXXAtjqP+z0TXTOpJgjzL+NRuOZ0N+shEO3NnkpEhbmqeugttDR0JUDDjsDvk
         dsfmEVdsC1r9JbDPfmJUZ2PfTEAcSdDJF3l3Y2BJC+jYdoxqkIWjLBx3DTzoXvU2kDaw
         wKXu0d2Eh6rV77zj39JkKFrNy36TXbJu9BDuNn4X7G4EKPZPchjJPDoFtECK5e0tOIxd
         1sYgAf2o3KfXzb2KR0yOYHXBKF/KFgmOZmknx3YXaiKwWrQL6mkhBvTyVbrfVOUDQZV9
         CFxw==
X-Forwarded-Encrypted: i=1; AJvYcCUEUjVTjh25sduGKjQXsx27QlMYa1FFEZtZDE1V/U2QpEG0jPzqJN+8wxFirrFcm1T+LiE+gK8O9hL+abO54vYaIyQL1MutsEp/sPnQ+By2Kg+UrUQyFidyKg2cx7DMPsAJ
X-Gm-Message-State: AOJu0YwpdBroNvq2KucDi7CbeeGS4EJjggY8V99zps/DVKHX1AIhNohs
	Ypd3bbbnnvqHYQ/Ri1BJqUxmA5RxNtOTXGRS8kBuaRV39JrdtNauzKBE9gUgPXKd0me7k2HqyaQ
	Y6EYutxQbZOgHbvbKjj32dB0hnU4=
X-Google-Smtp-Source: AGHT+IHiPxBTgYjvi7POvXPnAjNUtTgX1khJTvUa21919HgLJuYp9Dard3QYvMj7fw4mJqo1oI3wTcs6bMPVZ68GAOw=
X-Received: by 2002:a17:90b:3cc:b0:2a0:20b5:7f1a with SMTP id
 go12-20020a17090b03cc00b002a020b57f1amr387257pjb.37.1711130272000; Fri, 22
 Mar 2024 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321170444.388225-1-chen.dylane@gmail.com>
 <CAEf4BzYJeEViQaRJb6u06GJSLa6uBmykRZa4JnWJ9VXw+WoX2g@mail.gmail.com> <f5fe3709-bfc8-4906-a0cc-5fe9b388be6b@gmail.com>
In-Reply-To: <f5fe3709-bfc8-4906-a0cc-5fe9b388be6b@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 10:57:39 -0700
Message-ID: <CAEf4Bzb-Wf5sTnDLu29KQ-zWfCnffdUZYLSe_tQTNW_bTSfnPg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add specific btf name info when do core
To: Tao Chen <chen.dylane@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 6:37=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> Hi, Nakryiko, thank you for your reply. I try to familiarize with core
> in libbpf=EF=BC=8C the debug info is really helpful for me. But i use the=
 old
> kernel btf, so origion debuginfo like:
>   struct task_struct___x: found target candidate [130] struct
> task_struct in [vmlinux]

the idea here is to not emit path to BTF (otherwise we normally should
emit [/sys/kernel/btf/vmlinux], but rather distinguish whether it's a
kernel BTF ([vmlinux]) or some kernel module BTF ([<module-name>]).

In your case you are overriding vmlinux BTF by using btf_custom_path
option (so you should know where to find it, if you need to debug
something). It's still, conceptually, a [vmlinux], and I'd like to
keep it this way.

> I think it may be more clear, if we print btf name when we use old
> kernel btf like:
>   struct task_struct___x: found target candidate [130] struct
> task_struct in [/boot/***.btf]
> The patch just solve debug info show for newbies above.
>
> =E5=9C=A8 2024/3/22 =E4=B8=8A=E5=8D=882:52, Andrii Nakryiko =E5=86=99=E9=
=81=93:
> > On Thu, Mar 21, 2024 at 10:04=E2=80=AFAM Tao Chen <chen.dylane@gmail.co=
m> wrote:
> >>
> >> No logic changed, just add specific btf name when core info
> >> print, maybe it seems more understandable.
> >>
> >> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 14 +++++++++-----
> >>   1 file changed, 9 insertions(+), 5 deletions(-)
> >>
> >
> > Can you elaborate on what problem you are trying to solve?
> > Conceptually libbpf does look for types in vmlinux (meaning main
> > kernel BTF), even if user overrides BTF location (presumably because
> > of old kernel). So even when we emit "vmlinux" in logs, it seems
> > correct.
> >
> > pw-bot: cr
> >
> >
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index afd09571c482..b32154288b4a 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -5653,7 +5653,8 @@ static int load_module_btfs(struct bpf_object *o=
bj)
> >>   }
> >>
> >>   static struct bpf_core_cand_list *
> >> -bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_b=
tf, __u32 local_type_id)
> >> +bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_b=
tf, __u32 local_type_id,
> >> +                   const char *targ_btf_path)
> >>   {
> >>          struct bpf_core_cand local_cand =3D {};
> >>          struct bpf_core_cand_list *cands;
> >> @@ -5680,7 +5681,8 @@ bpf_core_find_cands(struct bpf_object *obj, cons=
t struct btf *local_btf, __u32 l
> >>
> >>          /* Attempt to find target candidates in vmlinux BTF first */
> >>          main_btf =3D obj->btf_vmlinux_override ?: obj->btf_vmlinux;
> >> -       err =3D bpf_core_add_cands(&local_cand, local_essent_len, main=
_btf, "vmlinux", 1, cands);
> >> +       err =3D bpf_core_add_cands(&local_cand, local_essent_len, main=
_btf,
> >> +                                targ_btf_path ?: "vmlinux", 1, cands)=
;
> >>          if (err)
> >>                  goto err_out;
> >>
> >> @@ -5793,7 +5795,8 @@ static int bpf_core_resolve_relo(struct bpf_prog=
ram *prog,
> >>                                   int relo_idx,
> >>                                   const struct btf *local_btf,
> >>                                   struct hashmap *cand_cache,
> >> -                                struct bpf_core_relo_res *targ_res)
> >> +                                struct bpf_core_relo_res *targ_res,
> >> +                                const char *targ_btf_path)
> >>   {
> >>          struct bpf_core_spec specs_scratch[3] =3D {};
> >>          struct bpf_core_cand_list *cands =3D NULL;
> >> @@ -5813,7 +5816,7 @@ static int bpf_core_resolve_relo(struct bpf_prog=
ram *prog,
> >>
> >>          if (relo->kind !=3D BPF_CORE_TYPE_ID_LOCAL &&
> >>              !hashmap__find(cand_cache, local_id, &cands)) {
> >> -               cands =3D bpf_core_find_cands(prog->obj, local_btf, lo=
cal_id);
> >> +               cands =3D bpf_core_find_cands(prog->obj, local_btf, lo=
cal_id, targ_btf_path);
> >>                  if (IS_ERR(cands)) {
> >>                          pr_warn("prog '%s': relo #%d: target candidat=
e search failed for [%d] %s %s: %ld\n",
> >>                                  prog_name, relo_idx, local_id, btf_ki=
nd_str(local_type),
> >> @@ -5920,7 +5923,8 @@ bpf_object__relocate_core(struct bpf_object *obj=
, const char *targ_btf_path)
> >>                          if (prog->obj->gen_loader)
> >>                                  continue;
> >>
> >> -                       err =3D bpf_core_resolve_relo(prog, rec, i, ob=
j->btf, cand_cache, &targ_res);
> >> +                       err =3D bpf_core_resolve_relo(prog, rec, i, ob=
j->btf, cand_cache, &targ_res,
> >> +                                                   targ_btf_path);
> >>                          if (err) {
> >>                                  pr_warn("prog '%s': relo #%d: failed =
to relocate: %d\n",
> >>                                          prog->name, i, err);
> >> --
> >> 2.34.1
> >>

