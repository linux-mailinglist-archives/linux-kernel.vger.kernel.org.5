Return-Path: <linux-kernel+bounces-25124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E549B82C83C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B7B1C2186C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D837B;
	Sat, 13 Jan 2024 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ju3Fmhhm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89702365
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3fde109f2so22705ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705104815; x=1705709615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN1rPiXKN7u9zdqvXb7Qif49uja1bfBANswKzoofhOQ=;
        b=ju3FmhhmsvqjbyQRvI/315OZFWMO4V7jEZr/sGVu0zmgawwT7gQYWZNwEren5w7fm4
         l5c42wQXB0pUFs3SZOl36WvcYKisGFqX4RAc0qSDY3ISoh7BmtMlgL4lAEB0xGNszvsW
         33WkRHE348XtxHyTwtBRTGhLbLqXTW8gMO7gqrf6HhgBdfN51npExzIBtrqA05eiVGVM
         dn3dHfzH0zW6HFbtGSMm/n5+SodDwT2k/TYLYZl148+D/9SfFzNvmbgDybLxMuW5e4kS
         3zqUr9OZ+rLYfKGaSd9NMwhveATTU0MlgsP4IsLHb2Q4MyTd9279xTnCXojanvapqNDl
         0Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705104815; x=1705709615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZN1rPiXKN7u9zdqvXb7Qif49uja1bfBANswKzoofhOQ=;
        b=CY49z/rmQ3h/f3zj10+pee84NpwUpCvLOEkquADytEihpkzySnmb73ceAXHCHXWt7y
         X269pEfcyuqH+LkO1jDFpQuwb63EbyhOWwis1MYE6VolvWMvnF88R3Whu25sd7C2CUoo
         J2PBtNvdNzuD9YwXpmAXq1CX8lTKvTIWcx16f//vcm6SodRRbZW2FjFx0Zq9PPS7DayW
         CFtmOnPyAjOdFGiTZKhTxycTMsvGsndA8IJy4h3Oe/ivhjsb7c8e+FwlAlnusSXEIoQs
         5S9e6tFIIG4v7BmI/ZxG1O39z/qfU7LGrwZSuffkcfqDVWpfqMyta7p//qMqM6PEWJtX
         7kPw==
X-Gm-Message-State: AOJu0YzkV36ZsPJDhHWR5lvZU85YxopnEqkeWYHiJBJN1lP62WxI8z0V
	5DWBKVHPtZXZq0hUgshCJ9D4+2ZciOPjjCQNj8HxQAv3dd0=
X-Google-Smtp-Source: AGHT+IFoy9IVWruhvKFe05xW5Uee6UeUnu8jeQqa2o5hMHQEB/8kcTZ0reXjfnhh9x+XoVNHMhQznVcSROnNPsA1e0c=
X-Received: by 2002:a17:902:ec8a:b0:1d4:c2bd:eff5 with SMTP id
 x10-20020a170902ec8a00b001d4c2bdeff5mr44003plg.3.1705104814522; Fri, 12 Jan
 2024 16:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112092014.23999-1-yong.wu@mediatek.com> <20240112092014.23999-4-yong.wu@mediatek.com>
 <CANDhNCrxpeqEhJD0xJzu3vm8a4jMXD2v+_dbDNvaKhLsLB5-4g@mail.gmail.com>
 <CA+ddPcNdniUTpE_pJb-fL7+MHNSUZTkQojL48iqvW9JPr-Tc-g@mail.gmail.com> <CANDhNCqieBaH-Wi=vy3NSKTpwHcWef6qMOFi-7sgdGiDW7JtwA@mail.gmail.com>
In-Reply-To: <CANDhNCqieBaH-Wi=vy3NSKTpwHcWef6qMOFi-7sgdGiDW7JtwA@mail.gmail.com>
From: Jeffrey Kardatzke <jkardatzke@google.com>
Date: Fri, 12 Jan 2024 16:13:22 -0800
Message-ID: <CA+ddPcP9bgApNw_Nu7bxcV-oK_s3Bq1i5qun+vNSuRUO9tPEkA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dma-buf: heaps: restricted_heap: Add private heap ops
To: John Stultz <jstultz@google.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, christian.koenig@amd.com, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	tjmercier@google.com, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Robin Murphy <robin.murphy@arm.com>, Vijayanand Jitta <quic_vjitta@quicinc.com>, 
	Joakim Bech <joakim.bech@linaro.org>, Pavel Machek <pavel@ucw.cz>, Simon Ser <contact@emersion.fr>, 
	Pekka Paalanen <ppaalanen@gmail.com>, jianjiao.zeng@mediatek.com, kuohong.wang@mediatek.com, 
	youlin.pei@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:51=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> On Fri, Jan 12, 2024 at 3:27=E2=80=AFPM Jeffrey Kardatzke <jkardatzke@goo=
gle.com> wrote:
> > On Fri, Jan 12, 2024 at 2:52=E2=80=AFPM John Stultz <jstultz@google.com=
> wrote:
> > > On Fri, Jan 12, 2024 at 1:21=E2=80=AFAM Yong Wu <yong.wu@mediatek.com=
> wrote:
> > > > diff --git a/drivers/dma-buf/heaps/restricted_heap.h b/drivers/dma-=
buf/heaps/restricted_heap.h
> > > > index 443028f6ba3b..ddeaf9805708 100644
> > > > --- a/drivers/dma-buf/heaps/restricted_heap.h
> > > > +++ b/drivers/dma-buf/heaps/restricted_heap.h
> > > > @@ -15,6 +15,18 @@ struct restricted_buffer {
> > > >
> > > >  struct restricted_heap {
> > > >         const char              *name;
> > > > +
> > > > +       const struct restricted_heap_ops *ops;
> > > > +};
> > > > +
> > > > +struct restricted_heap_ops {
> > > > +       int     (*heap_init)(struct restricted_heap *heap);
> > > > +
> > > > +       int     (*memory_alloc)(struct restricted_heap *heap, struc=
t restricted_buffer *buf);
> > > > +       void    (*memory_free)(struct restricted_heap *heap, struct=
 restricted_buffer *buf);
> > > > +
> > > > +       int     (*memory_restrict)(struct restricted_heap *heap, st=
ruct restricted_buffer *buf);
> > > > +       void    (*memory_unrestrict)(struct restricted_heap *heap, =
struct restricted_buffer *buf);
> > > >  };
> > > >
> > > >  int restricted_heap_add(struct restricted_heap *rstrd_heap);
> > >
> > > So, I'm a little worried here, because you're basically turning the
> > > restricted_heap dma-buf heap driver into a framework itself.
> > > Where this patch is creating a subdriver framework.
> > >
> > > Part of my hesitancy, is you're introducing this under the dma-buf
> > > heaps. For things like CMA, that's more of a core subsystem that has
> > > multiple users, and exporting cma buffers via dmabuf heaps is just an
> > > additional interface.  What I like about that is the core kernel has
> > > to define the semantics for the memory type and then the dmabuf heap
> > > is just exporting that well understood type of buffer.
> > >
> > > But with these restricted buffers, I'm not sure there's yet a well
> > > understood set of semantics nor a central abstraction for that which
> > > other drivers use directly.
> > >
> > > I know part of this effort here is to start to centralize all these
> > > vendor specific restricted buffer implementations, which I think is
> > > great, but I just worry that in doing it in the dmabuf heap interface=
,
> > > it is a bit too user-facing. The likelihood of encoding a particular
> > > semantic to the singular "restricted_heap" name seems high.
> >
> > In patch #5 it has the actual driver implementation for the MTK heap
> > that includes the heap name of "restricted_mtk_cm", so there shouldn't
> > be a heap named "restricted_heap" that's actually getting exposed. The
>
> Ah, I appreciate that clarification! Indeed, you're right the name is
> passed through. Apologies for missing that detail.
>
> > restricted_heap code is a framework, and not a driver itself.  Unless
> > I'm missing something in this patchset...but that's the way it's
> > *supposed* to be.
>
> So I guess I'm not sure I understand the benefit of the extra
> indirection. What then does the restricted_heap.c logic itself
> provide?
> The dmabuf heaps framework already provides a way to add heap implementat=
ions.

So in the v1 patchset, it was done with just a Mediatek specific heap
with no framework or abstractions for another vendor to build on top
of. The feedback was to make this more generic since Mediatek won't be
the only vendor who wants a restricted heap..which is how it ended up
here. There was more code in the framework before relating to TEE
calls, but then that was moved to the vendor specific code since not
all restricted heaps are allocated through a TEE.

This was also desirable for the V4L2 pieces since there's going to be
a V4L2 flag set when using restricted dma_bufs (and it wants to
validate that)....so in order to keep that more generic, there should
be a higher level concept of restricted dma_bufs that isn't specific
to a single vendor.  One other thing that would ideally come out of
this is a cleaner way to check that a dma_buf is restricted or not.
The current V4L2 patchset just attaches the dma_buf and then checks if
the page table is empty....and if so, it's restricted. But now I see
there's other feedback indicating attaching a restricted dma_buf
shouldn't even be allowed, so we'll need another strategy for
detecting them. Ideally there is some function/macro like
is_dma_buf_restricted(struct dma_buf*) that can indicate that...but we
haven't come up with a good way to do that yet which doesn't involve
adding another field to dma_buf or to dma_buf_ops (and if such a thing
would be fine, then OK...but I had assumed we would get pushback on
modifying either of those structs).

>
> thanks
> -john

