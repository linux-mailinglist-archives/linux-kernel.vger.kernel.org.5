Return-Path: <linux-kernel+bounces-17191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E28824962
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872B2B21C33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021B2C689;
	Thu,  4 Jan 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMoy52qN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BC2C1B5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d47fae33e0so33575ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704398751; x=1705003551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvEetwkb9xaGP1xb5l25SZewPP7nYFLZIpeTOK182Ek=;
        b=RMoy52qNnMYiLdicVgdhF2DjlDmMp1Den7Vb4cfy14nnTEf4DUKnMlTrM8KGHKO6d6
         HdmJaC2dyrq8Yn/MJKtp4Mc+4pXB8wSX7d27iTahZDDUbkrefy0N6vvOhW6JyKbodYKv
         eTowJbISzvL/9KlyhqedakIC/h59XnVK/KVbLrqfJzDFKNfuURRaKNkb8zhcQ8Rp6SBe
         vu/2M1srAjaGG+1A9LyZQyTUQ39nF8kuzsssDmX4BnGTCEavt7iRAV30efP6Ey9uOnB2
         RrEyFmSSbOWUGE1FXLAarzxr+Ip7TF/AcxjnZercrqMY/BG2cAAf4us30o5XyxX6nOoU
         UQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398751; x=1705003551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvEetwkb9xaGP1xb5l25SZewPP7nYFLZIpeTOK182Ek=;
        b=F5ssT5DtCrkITfWaJb7bAYcfVKu/l5fJkgC0WxxL/bMYOapt9s4I2hx+rwRWcvNIV+
         gjeV0LQ66QEjixoLZAbN/KA87lhnjEwZ0Ix6h2ler7HKG8fsjyprVe+A7MxquTL+B+vw
         njPFmbiExO27efdO12R5B0kR7EwMKMqvqYogl3GBXwPVQmDd5LtN5LdEWapeUcDl8P99
         zuo2Nt45TKghIGvBKTCKFiIlcmHMqUO5HWrjg1k/Kkco7SzFu8cBHqs912naVyn4HpBN
         Den2e12daGSyrztj+LxFl3yhm5IYnTlLxrlQ93pMsfiU/V8lr1O5FIBxnDOyrz5h1Mi6
         3IPg==
X-Gm-Message-State: AOJu0YyejfnBUZAf+Al/lAW5bgvmF0vmt88O4A9wfEC2Uhi4Tk0E1DsL
	OCdxnOrByyU2mwX1ShBzy2vhsTt4AQu9MX7aVB9a4JE+S8U=
X-Google-Smtp-Source: AGHT+IFtpK9YJeU2jGd3Bpf25IdYM4Caale+wmgEjoLqzqnOsTKnfaX9VNsHJOZHlAHU0P2aZXIT9K2U0qLn/rFYSYA=
X-Received: by 2002:a17:902:fa50:b0:1d4:69a6:8a9d with SMTP id
 lb16-20020a170902fa5000b001d469a68a9dmr33072plb.19.1704398750899; Thu, 04 Jan
 2024 12:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206081538.17056-1-yunfei.dong@mediatek.com>
 <20231206081538.17056-5-yunfei.dong@mediatek.com> <ce2110bf-a16a-45ae-979b-7e41be2896cd@xs4all.nl>
In-Reply-To: <ce2110bf-a16a-45ae-979b-7e41be2896cd@xs4all.nl>
From: Jeffrey Kardatzke <jkardatzke@google.com>
Date: Thu, 4 Jan 2024 12:05:39 -0800
Message-ID: <CA+ddPcM6nz0ufF5NXUq7E_vF6HnFKrEEag5iUDAknT6=hWTCNQ@mail.gmail.com>
Subject: Re: [PATCH v3,04/21] v4l: add documentation for secure memory flag
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 3:05=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> On 06/12/2023 09:15, Yunfei Dong wrote:
> > From: Jeffrey Kardatzke <jkardatzke@google.com>
> >
> > Adds documentation for V4L2_MEMORY_FLAG_SECURE.
> >
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > ---
> >  Documentation/userspace-api/media/v4l/buffer.rst | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documen=
tation/userspace-api/media/v4l/buffer.rst
> > index 52bbee81c080..a5a7d1c72d53 100644
> > --- a/Documentation/userspace-api/media/v4l/buffer.rst
> > +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> > @@ -696,7 +696,7 @@ enum v4l2_memory
> >
> >  .. _memory-flags:
> >
> > -Memory Consistency Flags
> > +Memory Flags
> >  ------------------------
> >
> >  .. raw:: latex
> > @@ -728,6 +728,12 @@ Memory Consistency Flags
> >       only if the buffer is used for :ref:`memory mapping <mmap>` I/O a=
nd the
> >       queue reports the :ref:`V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS
> >       <V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS>` capability.
> > +    * .. _`V4L2-MEMORY-FLAG-SECURE`:
> > +
> > +      - ``V4L2_MEMORY_FLAG_SECURE``
> > +      - 0x00000002
> > +      - DMA bufs passed into the queue will be validated to ensure the=
y were
> > +     allocated from a secure dma-heap.
>
> Hmm, that needs a bit more work. How about:
>
> - The queued buffers are expected to be in secure memory. If not, an erro=
r will be
>   returned. This flag can only be used with ``V4L2_MEMORY_DMABUF``. Typic=
ally
>   secure buffers are allocated using a secure dma-heap. This flag can onl=
y be
>   specified if the ``V4L2_BUF_CAP_SUPPORTS_SECURE_MEM`` is set.
>

Thanks Hans. Yunfei, can you integrate this change into the patch please?

> In addition, the title of this table is currently "Memory Consistency Fla=
gs": that
> should be renamed to "Memory Flags".

Hans, the patch is already renaming the table as you suggested. :)
(unless there's some other spot I'm missing)
>
> Regards,
>
>         Hans
>
> >
> >  .. raw:: latex
> >
>

