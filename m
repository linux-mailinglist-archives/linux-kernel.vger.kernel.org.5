Return-Path: <linux-kernel+bounces-14364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC2C821C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1DF1F21919
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B2F9D6;
	Tue,  2 Jan 2024 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuxtHEt/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CEF9C3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-46788b25f95so40933137.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704200383; x=1704805183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZwVZxl2lOBGt8rlpiCNWllZCCp2YXtPk9YBAjr0+Zo=;
        b=FuxtHEt/a7pm8by4f17wXE+lBKMqPVn1KyNx9Pkcs/LixIuUrTM3j2UhK8/XgH8Sq0
         mIqeKxjY/HRB+umluRkngNMcXk5C65ocn3YUeABxORiftzCWuILcHfxIxf3WnpZzTDrm
         7uajY8tHpG56DzeGI5OKeTNRGEc5K4nZxCxysjkLN8/NFO/6lCSO0scombr3BrnRtzQ7
         m5YwdufN/bcXMj25o7rVusyHVHV5K57OcclgN6NRrKunySiJhZly7h/xqhQENU9PSLnU
         6DTiO69PlSK5Mhx2JvcS3miuPvyznvr/W4iwCP/1K63O6FEq/ovNLwagMWEsmEezkHs/
         Lz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200383; x=1704805183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZwVZxl2lOBGt8rlpiCNWllZCCp2YXtPk9YBAjr0+Zo=;
        b=S2y8FCbR42/9GhAE83IX0fDTa4lLB3zelJgoJEDOGCqZy8Tzf9j5EiSMcw/RpeGoeg
         jIX/QvkXGF7dOn9eet6ScEHJaSDYAXxKFZ6DEBhgFrelM/U2/qqrjHA4i7PAl+5HXeuz
         5u0zf30t20C6Mt1mv58DYvzGaFjtmfEAdV73iVmI/78zlSG65CwS5bdKDZhsM7V/65ZM
         x7ibXBYJEswQ/B02eHczujGxkfAHro79MxRBElXyaaBDyOVi+49OQ7kQMjhbopqGMahs
         LI+rbyGS4CRQI3LuEqfZNDHaRokuxdhH3WeUMBTHbb1pZzVTdU4DuhQW5z+CnX7fYqaq
         gkFA==
X-Gm-Message-State: AOJu0YwWnjeqs+kgkUuPH3OWv9SXI4kPVYeNLbktz/QOXotBVipRSp85
	1mMSXyCPie6syXXWrqe01CuBztVZ9c4+Vu4/G9ez/N7ujZxf
X-Google-Smtp-Source: AGHT+IFoBvb9UfWuaFSdDbZ7ghEW/eF3htHVC7g2kUrs/TurDkd1e6n8Vs2nvP/uazEv75fWvzW8fPKY65neEYzy88s=
X-Received: by 2002:a05:6102:9:b0:467:1795:e662 with SMTP id
 j9-20020a056102000900b004671795e662mr4031027vsp.48.1704200382615; Tue, 02 Jan
 2024 04:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <6db160185d3bd9b3312da4ccc073adcdac58709e.1693328501.git.andreyknvl@google.com>
 <ZO8IMysDIT7XnN9Z@elver.google.com> <CA+fCnZdLi3g999PeBWf36Z3RB1ObHyZDR_xS0kwJWm6fNUqSrA@mail.gmail.com>
 <CANpmjNNtT1WUpJu_n5x_tA2sL4+utP0a6oGUzqrU5JuEu3mowg@mail.gmail.com> <CA+fCnZdAUo1CKDK4kiUyR+Fxc_F++CFezanPDVujx3u7fBmw=A@mail.gmail.com>
In-Reply-To: <CA+fCnZdAUo1CKDK4kiUyR+Fxc_F++CFezanPDVujx3u7fBmw=A@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 2 Jan 2024 13:59:06 +0100
Message-ID: <CANpmjNNfyKV0Ky=GRiw9_6va3nJMtYejWZJL0tn5cjwXTY8e1Q@mail.gmail.com>
Subject: Re: [PATCH 11/15] stackdepot: use read/write lock
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: andrey.konovalov@linux.dev, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sept 2023 at 19:09, Andrey Konovalov <andreyknvl@gmail.com> wrot=
e:
>
> On Tue, Sep 5, 2023 at 6:19=E2=80=AFPM Marco Elver <elver@google.com> wro=
te:
> >
> > > Good suggestion. I propose that we keep the rwlock for now, and I'll
> > > check whether the performance is better with percpu-rwsem once I get
> > > to implementing and testing the performance changes. I'll also check
> > > whether percpu-rwsem makes sense for stack ring in tag-based KASAN
> > > modes.
> >
> > I think it's quite obvious that the percpu-rwsem is better. A simple
> > experiment is to measure the ratio of stackdepot hits vs misses. If
> > the ratio is obviously skewed towards hits, then I'd just go with the
> > percpu-rwsem.
> >
> > The performance benefit may not be measurable if you use a small system=
.
>
> I started looking into using percpu-rwsem, but it appears that it
> doesn't have the irqsave/irqrestore API flavor. I suspect that it
> shouldn't be hard to add it, but I'd rather not pursue this as a part
> of this series.
>
> So I still propose to keep the rwlock for now, and switch to
> percpu-rwsem later together with the other perf changes.

I may have gotten lost in the post-vacation email avalanche and missed
it: did you already send the percpu-rwsem optimization? I am a little
worried about the contention the plain rwlock introduces on big
machines.

Thanks,
-- Marco

