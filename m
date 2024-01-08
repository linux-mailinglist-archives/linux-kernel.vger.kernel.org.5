Return-Path: <linux-kernel+bounces-19466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386E826D63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB831F22951
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8E2420E;
	Mon,  8 Jan 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CcHkg3EV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FC22068
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204b216e4easo403925fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704715531; x=1705320331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0ycSkS6Zak2ui1rQPyyxjJDorzRP8x1XQbB3KxyGEg=;
        b=CcHkg3EVP+Y3JN96dMQLmwCJ5Mjuj6e25iLN5SX6B2kaWBtP1VXEBgkIr+wt5x56If
         SPeMCDmU1eT5cGYjzvB3jE6c4ih3KhwP1SS7Qu5V7l7K50V+iGCrat+kbXWezaIiAQee
         JuRnkcd/bm1Ca544zbFs0V4C3Oaaei37ege90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715531; x=1705320331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0ycSkS6Zak2ui1rQPyyxjJDorzRP8x1XQbB3KxyGEg=;
        b=FRiTo4AhIsTBc3lOjL83YRrJ4mz5JdKQdJpf06Q/mSpeDvNAIiGzjR3vNIdryQtc+R
         xHRSZJTd9xfFCIdQEIe70NYh5dAvJ7cvWrB2NRyMwszmTBwgx4yt3SPVLPKyZMGuBAPn
         El8Z6RPRYXNTdVISdkDsmRDn+QXjh/KCXmbykcpzfYtXD+ViSbcwRxlCTPs3wwV3bAPb
         68RkIP050ytySiMl8+rw3aokJCzm0AXhB5NsA2IuBXfXbqj4JPLjJDv9e0hZpRKDxWQO
         oLTK6W2CsKmyADXSuLXDS/7zn7V/bMAx8DNMfP16j6wug+AroFkDVtSDHhr0Vf2wm66T
         ES2Q==
X-Gm-Message-State: AOJu0YyvjJrexlkPbK/XIGvqcOsBdT0yDqPQWZdSk2B6o/1ROa1h8zPa
	q7/z1Dhw+MG3wCpA9TJH55kjLbNPggqqrBKpp7eernK3veJPHg==
X-Google-Smtp-Source: AGHT+IFzg0ncgiosaItJcS6EqUbmXIhJfdKj13esd/8B0OHht7SYAYuam+XXDGCU1LyVattVFje1kzEfWm/X5Nm9YOM=
X-Received: by 2002:a05:6870:c115:b0:204:9066:c34f with SMTP id
 f21-20020a056870c11500b002049066c34fmr6593653oad.5.1704715531309; Mon, 08 Jan
 2024 04:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107103426.2038075-1-olekstysh@gmail.com>
In-Reply-To: <20240107103426.2038075-1-olekstysh@gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 8 Jan 2024 13:05:20 +0100
Message-ID: <CAKMK7uE07Uz-3yxH3+TNUEroKCobZ5xG+_HBPNWLOO0-cKAS+g@mail.gmail.com>
Subject: Re: [PATCH v2] xen/gntdev: Fix the abuse of underlying struct page in
 DMA-buf import
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jan 2024 at 11:35, Oleksandr Tyshchenko <olekstysh@gmail.com> wro=
te:
>
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>
> DO NOT access the underlying struct page of an sg table exported
> by DMA-buf in dmabuf_imp_to_refs(), this is not allowed.
> Please see drivers/dma-buf/dma-buf.c:mangle_sg_table() for details.
>
> Fortunately, here (for special Xen device) we can avoid using
> pages and calculate gfns directly from dma addresses provided by
> the sg table.
>
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
> Please note, I didn't manage to test the patch against the latest master =
branch
> on real HW (patch was only build tested there). Patch was tested on Arm64
> guests using Linux v5.10.41 from vendor's BSP, this is the environment wh=
ere
> running this use-case is possible and to which I have an access (Xen PV d=
isplay
> with zero-copy and backend domain as a buffer provider - be-alloc=3D1, so=
 dma-buf
> import part was involved). A little bit old, but the dma-buf import code
> in gntdev-dmabuf.c hasn't been changed much since that time, all context
> remains allmost the same according to my code inspection.
>
>   v2:
>    - add R-b and A-b
>    - fix build warning noticed by kernel test robot by initializing
>      "ret" in case of error
>      https://lore.kernel.org/oe-kbuild-all/202401062122.it6zvLG0-lkp@inte=
l.com/
> ---
> ---
>  drivers/xen/gntdev-dmabuf.c | 44 ++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
> index 4440e626b797..272c0ab01ef5 100644
> --- a/drivers/xen/gntdev-dmabuf.c
> +++ b/drivers/xen/gntdev-dmabuf.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/dma-buf.h>
> +#include <linux/dma-direct.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> @@ -50,7 +51,7 @@ struct gntdev_dmabuf {
>
>         /* Number of pages this buffer has. */
>         int nr_pages;
> -       /* Pages of this buffer. */
> +       /* Pages of this buffer (only for dma-buf export). */
>         struct page **pages;
>  };
>
> @@ -484,7 +485,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv *p=
riv, int flags,
>  /* DMA buffer import support. */
>
>  static int
> -dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
> +dmabuf_imp_grant_foreign_access(unsigned long *gfns, u32 *refs,
>                                 int count, int domid)
>  {
>         grant_ref_t priv_gref_head;
> @@ -507,7 +508,7 @@ dmabuf_imp_grant_foreign_access(struct page **pages, =
u32 *refs,
>                 }
>
>                 gnttab_grant_foreign_access_ref(cur_ref, domid,
> -                                               xen_page_to_gfn(pages[i])=
, 0);
> +                                               gfns[i], 0);
>                 refs[i] =3D cur_ref;
>         }
>
> @@ -529,7 +530,6 @@ static void dmabuf_imp_end_foreign_access(u32 *refs, =
int count)
>
>  static void dmabuf_imp_free_storage(struct gntdev_dmabuf *gntdev_dmabuf)
>  {
> -       kfree(gntdev_dmabuf->pages);
>         kfree(gntdev_dmabuf->u.imp.refs);
>         kfree(gntdev_dmabuf);
>  }
> @@ -549,12 +549,6 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storag=
e(int count)
>         if (!gntdev_dmabuf->u.imp.refs)
>                 goto fail;
>
> -       gntdev_dmabuf->pages =3D kcalloc(count,
> -                                      sizeof(gntdev_dmabuf->pages[0]),
> -                                      GFP_KERNEL);
> -       if (!gntdev_dmabuf->pages)
> -               goto fail;
> -
>         gntdev_dmabuf->nr_pages =3D count;
>
>         for (i =3D 0; i < count; i++)
> @@ -576,7 +570,8 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, s=
truct device *dev,
>         struct dma_buf *dma_buf;
>         struct dma_buf_attachment *attach;
>         struct sg_table *sgt;
> -       struct sg_page_iter sg_iter;
> +       struct sg_dma_page_iter sg_iter;
> +       unsigned long *gfns;
>         int i;
>
>         dma_buf =3D dma_buf_get(fd);
> @@ -624,26 +619,25 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv,=
 struct device *dev,
>
>         gntdev_dmabuf->u.imp.sgt =3D sgt;
>
> -       /* Now convert sgt to array of pages and check for page validity.=
 */
> +       gfns =3D kcalloc(count, sizeof(*gfns), GFP_KERNEL);
> +       if (!gfns) {
> +               ret =3D ERR_PTR(-ENOMEM);
> +               goto fail_unmap;
> +       }
> +
> +       /* Now convert sgt to array of gfns without accessing underlying =
pages. */
>         i =3D 0;
> -       for_each_sgtable_page(sgt, &sg_iter, 0) {
> -               struct page *page =3D sg_page_iter_page(&sg_iter);
> -               /*
> -                * Check if page is valid: this can happen if we are give=
n
> -                * a page from VRAM or other resources which are not back=
ed
> -                * by a struct page.
> -                */
> -               if (!pfn_valid(page_to_pfn(page))) {
> -                       ret =3D ERR_PTR(-EINVAL);
> -                       goto fail_unmap;
> -               }
> +       for_each_sgtable_dma_page(sgt, &sg_iter, 0) {

Maybe add a comment here to explain why this is done and why it's ok?
Either way:

Acked-by: Daniel Vetter <daniel@ffwll.ch>


> +               dma_addr_t addr =3D sg_page_iter_dma_address(&sg_iter);
> +               unsigned long pfn =3D bfn_to_pfn(XEN_PFN_DOWN(dma_to_phys=
(dev, addr)));
>
> -               gntdev_dmabuf->pages[i++] =3D page;
> +               gfns[i++] =3D pfn_to_gfn(pfn);
>         }
>
> -       ret =3D ERR_PTR(dmabuf_imp_grant_foreign_access(gntdev_dmabuf->pa=
ges,
> +       ret =3D ERR_PTR(dmabuf_imp_grant_foreign_access(gfns,
>                                                       gntdev_dmabuf->u.im=
p.refs,
>                                                       count, domid));
> +       kfree(gfns);
>         if (IS_ERR(ret))
>                 goto fail_end_access;
>
> --
> 2.34.1
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

