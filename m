Return-Path: <linux-kernel+bounces-54128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2A84AB20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB0D289D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A111113;
	Tue,  6 Feb 2024 00:38:01 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE9EDE;
	Tue,  6 Feb 2024 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707179881; cv=none; b=sjrDM2GZEmeb1lnR8/+OL4r+/Z/fkY3S/6shEB5g3H/6DjV7tNKZayuB0lzHsjKbYCDetpj4bBM/5rBjrsPcc8qArOSKmT34fOGSTCgaUTg7Zn9MOkroFhhPHc9sJ+FIoGij+P7+FoOpG5WUguyPMUd/WUc4xEAfSDmPVSWWhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707179881; c=relaxed/simple;
	bh=cgDHhAokoJ3JI9GUvK2dmNMWiCipmG7oxT8Xy10ZKZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9mypZjzWpEFVPffiBml1afPnmP6+T7oSk9T+2CFWOH/qIzHtY0PU5jXFPnhVPBFHTpHlJXE2c8cL/8Wjt539txQUvdYNG3QvBp5WD2zthLdD8xBUqUfaF+t3SEiJEqQoMDSLG48hvlSZIOhYIZJnyLfe3rM+KmB0r4y/RD/+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93b525959so544415ad.0;
        Mon, 05 Feb 2024 16:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707179879; x=1707784679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLXwxn1c+Kh9cKSsiilLIy3CGMCH0CX3Zb7/Ic0eQqk=;
        b=R5K2I0sn3g5NAgogBi6G4f0Z05Ce0uUUjNQ15vEJ5MhHoTJiMEX2C0FgN9F/Vlu2Yl
         uwT36mmYJY3FoRmm+4i1gsWnqbcmWubWLJEFMn1sqGM/cDB8FBIBUK9QBImbP1/MViJ4
         alcntY9lD6Bs+47GDnId8DeABacqtH071HsZ3HZ4RsuokhwIDY7NCssHPVIOuFQ13+JH
         mC4lqj8r97JTbCEUMgRVsIRsNSI5YP/cm0Is8Z1EoZliHnph7SnBVjIDhqhzsu/0FP39
         C2LtxeIAJo2455ijVLmnvPkFpBZvPmvpZvetr0wbIzz4ZlEHSIhiD1/Lg4CY6Cu5VYoE
         3/bw==
X-Gm-Message-State: AOJu0Yw6Gn3V9KF1FhNE0vg3UObjt6bIc/TA4fKcdQi5JIPzi+EFUwdk
	vdSDbQPIKWD0a25BCNm+GiQfV5x3mb/ntJ1SiL46qOGYf2oifB5kNf9LcwBjqosag/ihUV9ShpF
	otnWFxFXA+ONLKODWanAjjlsTc9w=
X-Google-Smtp-Source: AGHT+IFp1eH0CudRkd67FClesiqk67dHCbRBCSTvf8gCvbZ2DsT8aZGwH0U2cPR7SqahS797Ubeaz4ENyWpnXLeHoz8=
X-Received: by 2002:a05:6a20:4310:b0:19c:9a00:1351 with SMTP id
 h16-20020a056a20431000b0019c9a001351mr211155pzk.25.1707179878934; Mon, 05 Feb
 2024 16:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com> <20240103050635.391888-2-irogers@google.com>
 <CAM9d7chUnXOFXsz-gdK4V=RX4DfJMdBOzfzso_uKSj=00xNeZg@mail.gmail.com> <CAP-5=fW=Ov8hZ3qfYnTVAqV87bzYpS6jrPpxstdY3JdHx=pBGw@mail.gmail.com>
In-Reply-To: <CAP-5=fW=Ov8hZ3qfYnTVAqV87bzYpS6jrPpxstdY3JdHx=pBGw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Feb 2024 16:37:47 -0800
Message-ID: <CAM9d7cgZbc2yTxi+7raw_sc=sSZASA2XEnLTPU4gZaAp9ceXig@mail.gmail.com>
Subject: Re: [PATCH v7 01/25] perf maps: Switch from rbtree to lazily sorted
 array for addresses
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

Sorry for the late reply.

On Thu, Feb 1, 2024 at 8:21=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Feb 1, 2024 at 6:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
[SNIP]
> > > +int maps__copy_from(struct maps *dest, struct maps *parent)
> > > +{
> > > +       /* Note, if struct map were immutable then cloning could use =
ref counts. */
> > > +       struct map **parent_maps_by_address;
> > > +       int err =3D 0;
> > > +       unsigned int n;
> > > +
> > > +       down_write(maps__lock(dest));
> > >         down_read(maps__lock(parent));
> > >
> > > -       maps__for_each_entry(parent, rb_node) {
> > > -               struct map *new =3D map__clone(rb_node->map);
> > > +       parent_maps_by_address =3D maps__maps_by_address(parent);
> > > +       n =3D maps__nr_maps(parent);
> > > +       if (maps__empty(dest)) {
> > > +               /* No existing mappings so just copy from parent to a=
void reallocs in insert. */
> > > +               unsigned int nr_maps_allocated =3D RC_CHK_ACCESS(pare=
nt)->nr_maps_allocated;
> > > +               struct map **dest_maps_by_address =3D
> > > +                       malloc(nr_maps_allocated * sizeof(struct map =
*));
> > > +               struct map **dest_maps_by_name =3D NULL;
> > >
> > > -               if (new =3D=3D NULL) {
> > > +               if (!dest_maps_by_address)
> > >                         err =3D -ENOMEM;
> > > -                       goto out_unlock;
> > > +               else {
> > > +                       if (maps__maps_by_name(parent)) {
> > > +                               dest_maps_by_name =3D
> > > +                                       malloc(nr_maps_allocated * si=
zeof(struct map *));
> > > +                       }
> > > +
> > > +                       RC_CHK_ACCESS(dest)->maps_by_address =3D dest=
_maps_by_address;
> > > +                       RC_CHK_ACCESS(dest)->maps_by_name =3D dest_ma=
ps_by_name;
> > > +                       RC_CHK_ACCESS(dest)->nr_maps_allocated =3D nr=
_maps_allocated;
> > >                 }
> > >
> > > -               err =3D unwind__prepare_access(maps, new, NULL);
> > > -               if (err)
> > > -                       goto out_unlock;
> > > +               for (unsigned int i =3D 0; !err && i < n; i++) {
> > > +                       struct map *pos =3D parent_maps_by_address[i]=
;
> > > +                       struct map *new =3D map__clone(pos);
> > >
> > > -               err =3D maps__insert(maps, new);
> > > -               if (err)
> > > -                       goto out_unlock;
> > > +                       if (!new)
> > > +                               err =3D -ENOMEM;
> > > +                       else {
> > > +                               err =3D unwind__prepare_access(dest, =
new, NULL);
> > > +                               if (!err) {
> > > +                                       dest_maps_by_address[i] =3D n=
ew;
> > > +                                       if (dest_maps_by_name)
> > > +                                               dest_maps_by_name[i] =
=3D map__get(new);
> > > +                                       RC_CHK_ACCESS(dest)->nr_maps =
=3D i + 1;
> > > +                               }
> > > +                       }
> > > +                       if (err)
> > > +                               map__put(new);
> > > +               }
> > > +               maps__set_maps_by_address_sorted(dest, maps__maps_by_=
address_sorted(parent));
> > > +               if (!err) {
> > > +                       RC_CHK_ACCESS(dest)->last_search_by_name_idx =
=3D
> > > +                               RC_CHK_ACCESS(parent)->last_search_by=
_name_idx;
> > > +                       maps__set_maps_by_name_sorted(dest,
> > > +                                               dest_maps_by_name &&
> > > +                                               maps__maps_by_name_so=
rted(parent));
> > > +               } else {
> > > +                       RC_CHK_ACCESS(dest)->last_search_by_name_idx =
=3D 0;
> > > +                       maps__set_maps_by_name_sorted(dest, false);
> > > +               }
> > > +       } else {
> > > +               /* Unexpected copying to a maps containing entries. *=
/
> > > +               for (unsigned int i =3D 0; !err && i < n; i++) {
> > > +                       struct map *pos =3D parent_maps_by_address[i]=
;
> > > +                       struct map *new =3D map__clone(pos);
> > >
> > > -               map__put(new);
> > > +                       if (!new)
> > > +                               err =3D -ENOMEM;
> > > +                       else {
> > > +                               err =3D unwind__prepare_access(dest, =
new, NULL);
> > > +                               if (!err)
> > > +                                       err =3D maps__insert(dest, ne=
w);
> >
> > Shouldn't it be __maps__insert()?
>
> On entry the read lock is taken on parent but no lock is taken on dest
> so the locked version is used.

I think you added the writer lock on dest.

Thanks,
Namhyung

>
> > > +                       }
> > > +                       map__put(new);
> > > +               }
> > >         }
> > > -
> > > -       err =3D 0;
> > > -out_unlock:
> > >         up_read(maps__lock(parent));
> > > +       up_write(maps__lock(dest));
> > >         return err;
> > >  }

