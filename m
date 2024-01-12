Return-Path: <linux-kernel+bounces-25102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877A382C7FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD581C2116B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82D1A5B3;
	Fri, 12 Jan 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpKeeSJk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741AA19BAF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d47fae33e0so50995ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705102060; x=1705706860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhEbbmE1Z6uLNZgCKtRC6woP3H/Wl1Wl1gQfP+v/DTY=;
        b=GpKeeSJkCZabPz//ZzQG3Q9Fj6647KdFkn3BeMu/PqsKY8E3c3OMe4DQEYEmzeCC1T
         5e8isa8rvrCAlKh79DGu/xQYsp8zKQ9vcH0H4NniBDKArVKaisIh+Evi4SQpuQukCf1Q
         PiILjwXv7z36PuKY3q3TnZuOimTq/QKxxuWdjJgiCegnusj2j3PXtkuEGBJkVTp0nWLR
         r5SMo3C99asJkRJ5Zji0xWUgAWWOd2R6Ca89PUa35krrzu+1/IwP7HwDWV5vni9/YckD
         J96NI6+J8eTrhid388NlI0WiRNBZ3RpED4lF0VBTMrWrCbLwP1y1FzmLNLfGSBYehjAw
         /9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705102060; x=1705706860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhEbbmE1Z6uLNZgCKtRC6woP3H/Wl1Wl1gQfP+v/DTY=;
        b=mH3dU9CicxLDoAjnFD+WUvo8KJKNoGDd2xBvjiXqukJwGp9EFiE1BzOzWXJxX/hAbo
         8TEJth9Ncx2isWP+gU3mpd3BuqphdCQWO7LRWy3q+c7Nn20v+W5VuaBUjy3DrgknP3uZ
         a6GwXCItD+/G76e2qY4WTnE+aL5RA2fFNnM+7VtUAffHMVtwj3IFNOlqBsFhtWUT2/PK
         ve8HuVSiugbEo+V0uTtCzSgpNIvR/m8NsbDWtOGJV/6xTbr/JoDuWpwv5eD0wmQkhANg
         /larI1ITJ6y3fgyhKQpPEpU060Q0RD1uDKjB0uNVSUUZoquuuxL5PKmvUod8eROrRrd0
         VObw==
X-Gm-Message-State: AOJu0YwWqZpSXutCZK4Uvm/FHSscCzaxGP8gg3zE0+lMgAnUl0laoP83
	ANMh6ucOhUPYajULA5eJ81AlFb9+nTNpDA9ld+ahOR/59Rw=
X-Google-Smtp-Source: AGHT+IFwwNVRgX+18llMY6Crrv0CZvMC6Ee5jLqPJn9RMR+jzSAJCxBI0rpUZIw0G2/SmU4oxB/NiR3hY1G0xancka4=
X-Received: by 2002:a17:903:210d:b0:1d5:a791:ef1b with SMTP id
 o13-20020a170903210d00b001d5a791ef1bmr203692ple.1.1705102059466; Fri, 12 Jan
 2024 15:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112092014.23999-1-yong.wu@mediatek.com> <20240112092014.23999-4-yong.wu@mediatek.com>
 <CANDhNCrxpeqEhJD0xJzu3vm8a4jMXD2v+_dbDNvaKhLsLB5-4g@mail.gmail.com>
In-Reply-To: <CANDhNCrxpeqEhJD0xJzu3vm8a4jMXD2v+_dbDNvaKhLsLB5-4g@mail.gmail.com>
From: Jeffrey Kardatzke <jkardatzke@google.com>
Date: Fri, 12 Jan 2024 15:27:27 -0800
Message-ID: <CA+ddPcNdniUTpE_pJb-fL7+MHNSUZTkQojL48iqvW9JPr-Tc-g@mail.gmail.com>
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

On Fri, Jan 12, 2024 at 2:52=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> On Fri, Jan 12, 2024 at 1:21=E2=80=AFAM Yong Wu <yong.wu@mediatek.com> wr=
ote:
> >
> > Add "struct restricted_heap_ops". For the restricted memory, totally th=
ere
> > are two steps:
> > a) memory_alloc: Allocate the buffer in kernel;
> > b) memory_restrict: Restrict/Protect/Secure that buffer.
> > The memory_alloc is mandatory while memory_restrict is optinal since it=
 may
> > be part of memory_alloc.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/dma-buf/heaps/restricted_heap.c | 41 ++++++++++++++++++++++++-
> >  drivers/dma-buf/heaps/restricted_heap.h | 12 ++++++++
> >  2 files changed, 52 insertions(+), 1 deletion(-)
> >
>
> Thanks for sending this out! A thought below.
>
> > diff --git a/drivers/dma-buf/heaps/restricted_heap.h b/drivers/dma-buf/=
heaps/restricted_heap.h
> > index 443028f6ba3b..ddeaf9805708 100644
> > --- a/drivers/dma-buf/heaps/restricted_heap.h
> > +++ b/drivers/dma-buf/heaps/restricted_heap.h
> > @@ -15,6 +15,18 @@ struct restricted_buffer {
> >
> >  struct restricted_heap {
> >         const char              *name;
> > +
> > +       const struct restricted_heap_ops *ops;
> > +};
> > +
> > +struct restricted_heap_ops {
> > +       int     (*heap_init)(struct restricted_heap *heap);
> > +
> > +       int     (*memory_alloc)(struct restricted_heap *heap, struct re=
stricted_buffer *buf);
> > +       void    (*memory_free)(struct restricted_heap *heap, struct res=
tricted_buffer *buf);
> > +
> > +       int     (*memory_restrict)(struct restricted_heap *heap, struct=
 restricted_buffer *buf);
> > +       void    (*memory_unrestrict)(struct restricted_heap *heap, stru=
ct restricted_buffer *buf);
> >  };
> >
> >  int restricted_heap_add(struct restricted_heap *rstrd_heap);
>
> So, I'm a little worried here, because you're basically turning the
> restricted_heap dma-buf heap driver into a framework itself.
> Where this patch is creating a subdriver framework.
>
> Part of my hesitancy, is you're introducing this under the dma-buf
> heaps. For things like CMA, that's more of a core subsystem that has
> multiple users, and exporting cma buffers via dmabuf heaps is just an
> additional interface.  What I like about that is the core kernel has
> to define the semantics for the memory type and then the dmabuf heap
> is just exporting that well understood type of buffer.
>
> But with these restricted buffers, I'm not sure there's yet a well
> understood set of semantics nor a central abstraction for that which
> other drivers use directly.
>
> I know part of this effort here is to start to centralize all these
> vendor specific restricted buffer implementations, which I think is
> great, but I just worry that in doing it in the dmabuf heap interface,
> it is a bit too user-facing. The likelihood of encoding a particular
> semantic to the singular "restricted_heap" name seems high.

In patch #5 it has the actual driver implementation for the MTK heap
that includes the heap name of "restricted_mtk_cm", so there shouldn't
be a heap named "restricted_heap" that's actually getting exposed. The
restricted_heap code is a framework, and not a driver itself.  Unless
I'm missing something in this patchset...but that's the way it's
*supposed* to be.

>
> Similarly we might run into systems with multiple types of restricted
> buffers (imagine a discrete gpu having one type along with TEE
> protected buffers also being used on the same system).
>
> So the one question I have: Why not just have a mediatek specific
> restricted_heap dmabuf heap driver?  Since there's already been some
> talk of slight semantic differences in various restricted buffer
> implementations, should we just start with separately named dmabuf
> heaps for each? Maybe consolidating to a common name as more drivers
> arrive and we gain a better understanding of the variations of
> semantics folks are using?
>
> thanks
> -john

