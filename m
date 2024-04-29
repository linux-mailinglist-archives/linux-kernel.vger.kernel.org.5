Return-Path: <linux-kernel+bounces-161766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC68B50ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C101C213C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B200F507;
	Mon, 29 Apr 2024 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeLqWciu"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B21DF5C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370599; cv=none; b=o51IPxkLbg03vGOn+lu2IM3Foalu8w0SOl6RqG2TBKOt8C1qaL6mjFeLOrGxb1PB1ktmPMUPyYaoG4vTvSGBrjlcVqf6vjKSANumt5VFjjqLO8MtYiACPCfDxjZjKPX3sfSAc+8N5bLKCkNSLL0sc9ZAykp3MriQ6OCKRWoPY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370599; c=relaxed/simple;
	bh=2DofV/GMsnnUHL4mzuDfPae85RQ6/uyefceuooWK8as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLJNMZG1/Qx7GVHEDI8zm3gBr9jFrqDJXLr/u3vmlkUb3M7dkwYmliw7x4bKLgakKqwf2OPTM6TlO4RPBgdf34gNsf8Ba5Qc7/o/MD3GPQ6Q+IAeQQxjdSPtAJRS17BEbOq4wIL5I+XeHjfJ0y+/eFDLrYzEhohnoBNabcDjwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeLqWciu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5872b74c44so438415966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714370596; x=1714975396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kiriSi9cv3OVBgriCchZMDK+rQMOClWkLptGCJ8G+44=;
        b=WeLqWciuUqKsxzcxbyI4hiE4i/vWez9+EqdmwYu+2nyxzQYwObSSM8SzCxl6R5ZsT7
         pRo/QXgHFJYFfszJIo9seHOkAG/MXx88GnPhiVkJ5f/D1sy+qeNJxBuqncFXkWCneYGW
         MSMVCsI+SpucoGQuWeQYpJXGH7U3dKCYOsb2pYDgZcy/rHozBRou8bXE218TUBwhR6eb
         Wm4NedoNKs0dhcHs8RcsjNE1Xjx+SJHeu7TVVV6srEsRygUQqc1hHpAgPp7Csl4Ea/fR
         a4kxqthP93rJzGuVcVKNNpiTwG5zZMe4oruoQWI9Wx2MfooudyrBgSkqV4M3ZP22D3BF
         dREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714370596; x=1714975396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiriSi9cv3OVBgriCchZMDK+rQMOClWkLptGCJ8G+44=;
        b=oR9q64JR8NnvV4OapH8hQFOOCcyYvw9SjpIRhsW+Efy5Rmv2kuOun5cJB7JikeUwjo
         S8kMJT6JsQ/pa1YDMC4VR9/Y+24+RVYyT50NKxHnmJEaCeIwCsOpvv3RIFgGRqAUif2u
         NCR0uwU58LYb+om9XUmQcBYdCOwUJjfe3RN4uVgu0EygXw0uGiryoc8RfmU4kv/WYKFP
         5Q9gjSVWmsRkTvgZW0aQXmyZw5UrzhXvheYqt2t1lvX5oF6DBsRJxD0Teh7QiQGU2D0N
         CLXuafcj6gEZMS7VFK515BGRSrmwNG+EAJKPUChVLDnBs9s3HbP6FYGrFg40/JBtlpsQ
         nvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+RoDg32fmXstq7GOsUmFoPk4PQifWHGKxnUBa8h15tQcTpSsraVG0gttQDSVbEuOwa01zit+/H4SJWDL20/XHMu5a1iyuGo5zbwtm
X-Gm-Message-State: AOJu0YxXGJ+nnvwJij96WZ7q8Q7tCXHGV46S2T4AYjZb6WkzjsvbVYqf
	ajPt4riMYLl6JAAV/uyuYNZuYpW+3hdsa7HOpZO46ZfyzQuGZ5HirnFekGp3hAYmlh6LiuCkXBH
	n3cXibckfc47TUpcmkutA/hy/w6U=
X-Google-Smtp-Source: AGHT+IF5ZT95wWDComVZ1Qrqxn3CS/rpjIH6NhBdB56AlgxGt/68AL5QxewLdun3eiPHTFdoHIoHc/QpG92qCDyeVWQ=
X-Received: by 2002:a17:906:a8b:b0:a58:ff45:415f with SMTP id
 y11-20020a1709060a8b00b00a58ff45415fmr1464926ejf.44.1714370596063; Sun, 28
 Apr 2024 23:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426154138.64643-1-lyude@redhat.com> <20240426154138.64643-2-lyude@redhat.com>
In-Reply-To: <20240426154138.64643-2-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 29 Apr 2024 16:03:03 +1000
Message-ID: <CAPM=9txB5Zhyyno-GLD_JShV-GZd8hgYVh=Ok=Skmzs=eTi64A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/nouveau/gsp: Use the sg allocator for level 2 of radix3
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Karol Herbst <kherbst@redhat.com>, Danilo Krummrich <dakr@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Timur Tabi <ttabi@nvidia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Currently, this can result in runtime PM issues on systems where memory
> Luckily, we don't actually need to allocate coherent memory for the page
> table thanks to being able to pass the GPU a radix3 page table for
> suspend/resume data. So, let's rewrite nvkm_gsp_radix3_sg() to use the sg
> allocator for level 2. We continue using coherent allocations for lvl0 and
> 1, since they only take a single page.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  4 +-
>  .../gpu/drm/nouveau/nvkm/subdev/gsp/r535.c    | 71 ++++++++++++-------
>  2 files changed, 47 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> index 6f5d376d8fcc1..a11d16a16c3b2 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> @@ -15,7 +15,9 @@ struct nvkm_gsp_mem {
>  };
>
>  struct nvkm_gsp_radix3 {
> -       struct nvkm_gsp_mem mem[3];
> +       struct nvkm_gsp_mem lvl0;
> +       struct nvkm_gsp_mem lvl1;
> +       struct sg_table lvl2;

This looks great, could we go a step further and combine lvl0 and lvl1
into a 2 page allocation, I thought we could combine lvl0/lvl1 into a
2 page alloc, but that actually might be a bad idea under memory
pressure.

Dave.

