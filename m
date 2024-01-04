Return-Path: <linux-kernel+bounces-17192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1BC824969
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B51C1F22E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944C22C691;
	Thu,  4 Jan 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fazAKQnL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67792C682
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso30575ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704398865; x=1705003665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5ZXdX4bS3ERPeQksYREtFg6egDHCXXKYTYbIsKvCx8=;
        b=fazAKQnLaP1+dsErYjM/8ghaAcJokDFebNLk+CT1RwoDgvt7O2UvdtWcXj9UxhCvzO
         23cnS8vdygCrIxDi3Biw4DVly3m64ONFbq0OWm/k4CRf6WS7oIYGSc4j0Y6WdV9bFObX
         jbAoVFnQR1z4JswtNu4fsbr+/IFwOCu0sR6r9LkMrD7yVPuywH1CGEl1vcIMP1XV/g2u
         woCRlpIL/E+yYnQGsvMn6WfOXI7ZIcgtE6u/drca1j8XF2RI7kYdfouc6pQSRaYYJzut
         T9zJf5HFvsj5enbCPA+pdiYJB4jsAaClcIknP6kfKrmxfZ4YO7cjpIvDOi611oQZ8GWQ
         08yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398865; x=1705003665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5ZXdX4bS3ERPeQksYREtFg6egDHCXXKYTYbIsKvCx8=;
        b=AvnjYaBBi7ydLLYAbqTAqvnHifrIyOgB8AXR7KbLcOgPfO30liBScJ0/dXA8Kk6OsM
         qJZ/W4ydrFxc5KUPJuvNNjJu1cEdzcNF2H0VTG+XFQP7bsvbB5ytTVtvzviPJr3HdDcF
         MqWBaXTf7Ncvz65PB5K+G2wQX/H0dhfMfXufkXxGc6rAh4zqjJEoiUxWAQWK0br6mHs4
         u3EBj5ZXzd415cWfMg7PFm/g7YkVw4AR1VyN6+opK28l7sjgyegcFj/BjyIu3h8bGYMF
         BwXG3y83Yi8e5fLtytHeEn4i163qNvQkNyTU5uilYKh/Rp7Vlbn+hXS9Z41pjn+xm3PM
         lPAQ==
X-Gm-Message-State: AOJu0YxKgseRfXv+CjRiMIYYgST4ynidNZFwTSSZZdjJmgZN5MNRNqYI
	uS5dpIyIzFtudHdhZqFPeIRTdi8HkzQBdtpqdRy5QcywMXU=
X-Google-Smtp-Source: AGHT+IE1vkesK4ZOVeDXSnQesWkwfg2DZNXrNfara5a0m92sCbqwWjRcDNy568hvPKmtKyTR34K9s+lngyphSHVzEeE=
X-Received: by 2002:a17:902:e884:b0:1d4:d462:f5a9 with SMTP id
 w4-20020a170902e88400b001d4d462f5a9mr38645plg.20.1704398864639; Thu, 04 Jan
 2024 12:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206081538.17056-1-yunfei.dong@mediatek.com>
 <20231206081538.17056-4-yunfei.dong@mediatek.com> <705ce6b0-e945-404c-8014-38881a01fbca@xs4all.nl>
In-Reply-To: <705ce6b0-e945-404c-8014-38881a01fbca@xs4all.nl>
From: Jeffrey Kardatzke <jkardatzke@google.com>
Date: Thu, 4 Jan 2024 12:07:32 -0800
Message-ID: <CA+ddPcPH+M=rnAzyPgq7rMUV2sAdCJ5xdEAncPUyTfspxswzjQ@mail.gmail.com>
Subject: Re: [PATCH v3,03/21] v4l2: verify secure dmabufs are used in secure queue
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

On Mon, Dec 11, 2023 at 2:58=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> On 06/12/2023 09:15, Yunfei Dong wrote:
> > From: Jeffrey Kardatzke <jkardatzke@google.com>
> >
> > Verfies in the dmabuf implementations that if the secure memory flag is
>
> Verfies -> Verifies

Thanks. Yunfei, change that please.
>
> > set for a queue that the dmabuf submitted to the queue is unmappable.
> >
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > ---
> >  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 6 ++++++
> >  drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/dr=
ivers/media/common/videobuf2/videobuf2-dma-contig.c
> > index 3d4fd4ef5310..ad58ef8dc231 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > @@ -710,6 +710,12 @@ static int vb2_dc_map_dmabuf(void *mem_priv)
> >               return -EINVAL;
> >       }
> >
> > +     /* verify the dmabuf is secure if we are in secure mode */
> > +     if (buf->vb->vb2_queue->secure_mem && sg_page(sgt->sgl)) {
>
> This needs a bit more explanation. I guess that for secure memory
> sg_page returns NULL?

How about if we change it to:

/* verify the dmabuf is secure if we are in secure mode, this is done
by validating there is no page entry for the dmabuf */

>
> > +             pr_err("secure queue requires secure dma_buf");
> > +             return -EINVAL;
> > +     }
> > +
> >       /* checking if dmabuf is big enough to store contiguous chunk */
> >       contig_size =3D vb2_dc_get_contiguous_size(sgt);
> >       if (contig_size < buf->size) {
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/driver=
s/media/common/videobuf2/videobuf2-dma-sg.c
> > index 28f3fdfe23a2..55428c73c380 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> > @@ -564,6 +564,12 @@ static int vb2_dma_sg_map_dmabuf(void *mem_priv)
> >               return -EINVAL;
> >       }
> >
> > +     /* verify the dmabuf is secure if we are in secure mode */
> > +     if (buf->vb->vb2_queue->secure_mem && !sg_dma_secure(sgt->sgl)) {
>
> I can't find the sg_dma_secure function. I suspect this patch series
> depends on another series?

That was an oversight, it should be the same as in
videobuf2-dma-contig.c. Yunfei, can you change this to match what's in
videobuf2-dma-contig.c after the comment is reworded?
>
> > +             pr_err("secure queue requires secure dma_buf");
> > +             return -EINVAL;
> > +     }
> > +
> >       buf->dma_sgt =3D sgt;
> >       buf->vaddr =3D NULL;
> >
>
> Regards,
>
>         Hans

