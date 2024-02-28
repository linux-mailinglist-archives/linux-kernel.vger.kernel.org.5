Return-Path: <linux-kernel+bounces-85584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120FC86B7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435C61C223F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4BB7442A;
	Wed, 28 Feb 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOsuBTJR"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596024086E;
	Wed, 28 Feb 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147990; cv=none; b=p1VPNTV3pSSAWoQEWpRwXEgoiOniU3mSCoPI9ILckvyYjtfAQz6/zo6fcCrW6+C2BFvmQygOun/tjdGMA+fbpGzOw6h7ykT1mfB7gK5QfA/bLIaPRxQpKuFwJcyqgzAGl90Jv+v8Bc91odgr04IpBQ/PghBUWhMW8fqOmYdTrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147990; c=relaxed/simple;
	bh=Tt6dSM09C60ngZskWhxqghZ9GcZWzW94KOavNzMs1RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH42VBgHhTRu0MXzMiBot9zXpVBLRy5CgxVRvMisxI7lxlzoh9cKNvBXtOEW4GL6wpRs4tu1pcs8hlcKlqSj1dyalLNfG+2zmbgSpL2rA5c5VGqMrAYJHSh9Hb3fX2nWFseonetgBmuIyRDB6We5UdJj9Hbm47fqAfkc3HNaNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOsuBTJR; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a0bf814be3so57800eaf.0;
        Wed, 28 Feb 2024 11:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709147988; x=1709752788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=phvTuz6PNOiEIMAaVEz5O2kseqWR4cE3nLmyIyGPTqU=;
        b=DOsuBTJR8YoeLwh1smaxlM8h1cOf45FoBq+ePgIEFbhHJfHN4pwNw3EpHvNhqVYGIh
         Mbq11xwDRmOqynShN4Y5JmEk7U0H9eB3dSTX233TUD7vV+z2IPtUMlytaBmXxzaElLjO
         K/uWJQFS9qtMBBxCtOptjLg3yD9Dujl4v0a4mxfR0lwJSEoMUkLu3NLg2VV1r+LW3XUD
         Df8xsJq+/xVzXCa17y2/WtsUJT2+mn5Q0XARgyrzfGuDsupfsa97OW9SrjKJxTpv1lnV
         Gb4b3z7rPnjA8uIhP7/IaMpUejgmciVy/fJaU1a71Ld0yeutQRqeqjfqEKrEZvyTlQBp
         FVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709147988; x=1709752788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phvTuz6PNOiEIMAaVEz5O2kseqWR4cE3nLmyIyGPTqU=;
        b=jJ9cYAtDRgjmtedh2Ahq2bqXPksc23WErDcEowU1MC01cyErxUcg65k1FcNS9p00nj
         q/pvQhHoHdLUuhmtonoQpDfcn6Sc91F+5TIE1wml699Rg4As1fivMGDOkahZqdHHasqZ
         LBwCARhL21zCzr5ywUPf9EvDWtCEwQJVs7F7sKnXDL36Wv9T+tHXppSO/lX/+YFWcud+
         tWaqEsLoqeabbRQ+dNV+iBvhs5ft7opUdqh1yUoKwwZTRIYOj2KNctqY8mpbP0l9sjti
         4v//pRuFUyNWIflhWMJV7e8L+5o98wOyBgMT9HFeHX05jDagyEqa2T9hFRIw+JbFbZKF
         q9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUesVQaOC2IkkoGDIoQEY7b0wQHMbRZ0VG1VaKb19zToW/IrMhmxgFMIaVKG5lCiwrRQHsYOflpiv70XAEn4C/3tRbWnk+ISrLl6vxRQ35SMR98S0eXfTZ3vczF8FjGw5G2tZGvTkZCYTG9zxkD
X-Gm-Message-State: AOJu0YxLcmQFgtlXUMWBQwYZ2fuWWs3LrlJkaBEKXVcAWiUA7CCjGlyJ
	jaMjd0DORR9Vy+tSuyjezKg3iIx9kY8caOmjbG6+rv4I8iVIZPXbNaPxGM7CEYCeE/81Gs0QjIa
	FHOdn31vXAnhnebnPqt4ZeIcQVardKUpc
X-Google-Smtp-Source: AGHT+IH/EIolfDA4zKZNCvS17yEvKi+CDTbOpEYfpEr3bP+kiR7I5G9Me13eUg8HC7hX1ig2yHn1UaJ20jH2Yr8I814=
X-Received: by 2002:a4a:351c:0:b0:5a0:daf5:a5d0 with SMTP id
 l28-20020a4a351c000000b005a0daf5a5d0mr523851ooa.9.1709147988479; Wed, 28 Feb
 2024 11:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
In-Reply-To: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Feb 2024 14:19:34 -0500
Message-ID: <CAJSP0QWW2QvibpcrZbcLzVp8ngnooiTqP8i2emd+0sdCj_7Yww@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: Fix off by one in vduse_dev_mmap()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 13:24, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> reading one element beyond the end of the array.
>
> Add an array_index_nospec() as well to prevent speculation issues.
>
> Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: add array_index_nospec()
> v3: I accidentally corrupted v2.  Try again.
>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index b7a1fb88c506..eb914084c650 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
>         if ((vma->vm_flags & VM_SHARED) == 0)
>                 return -EINVAL;
>
> -       if (index > dev->vq_num)
> +       if (index >= dev->vq_num)
>                 return -EINVAL;
>
> +       index = array_index_nospec(index, dev->vq_num);
>         vq = dev->vqs[index];
>         vaddr = vq->vdpa_reconnect_vaddr;
>         if (vaddr == 0)
> --
> 2.43.0
>
>

