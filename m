Return-Path: <linux-kernel+bounces-27420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6282EFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE061285D92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE3D1BDD5;
	Tue, 16 Jan 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlJwAxPp"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8C1BC47;
	Tue, 16 Jan 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-598ee012192so1002945eaf.1;
        Tue, 16 Jan 2024 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705411818; x=1706016618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gQ4JwYFgXubIxEB4f42Ft3SYuEBMzsffcySkA94liA=;
        b=RlJwAxPpxli/kL99n9EXHUw8/eQO0JSJW60tEM1WFMd+/7x7VTEkgSoXKAEJic1awc
         qtjTILHYfGRAlf89d85VtZp5OzyRejOLBROAmqUXyVl+Rck9kSlPdTBFEO1OEymtYzrq
         NyDmBwBsqH05e4Q5CSj0fpy2+q3bzN1BI/bPYLEHbrYTg7DWymex39glJ9y3U5li/xjW
         +F3l+iqbUxEUzqbOcQ+McxNCjnVtMDr5CjqwVbOCz3nea7enpTpLDZE7cQ7sfGMrCR8H
         TMehM3DRS2moUdO9d655PJyhPF+KZ6r0Y3VxSZi9iCPKAfVK1mTi6v1KFuQXwa3LcjBP
         sliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705411818; x=1706016618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gQ4JwYFgXubIxEB4f42Ft3SYuEBMzsffcySkA94liA=;
        b=D87fgH1M4EhDTh019ppP2OQDg7rc+dQyDKXjnR5LQeiO5maUUhJPANcApT8elVBUzF
         eYDI2XdHVNzQhJ4uRECji18vZNuPfkaX+ekeVGnr2Jke6KRMYGNbDa/dTJCphui2ZPwE
         eTh/GK2zovXxtpzrKyqcGVEX56ib4QhdlTzmhF2PPmdhKj97mWn2t95EaW+/q7A7hyWS
         8mIVpv+lXm9sMhVUJ3IlwNrhwFLvDEyjSZDJf677Hzi0sKL/f3HhNtjrpOJRJTPtV63u
         Na01ANXkth2Sq2KLwLMgFDcwft+52jC8kIonty4Gb+I8FK0TuaUhToJpTLVVajIxUt2m
         8qkA==
X-Gm-Message-State: AOJu0YwiMtW2S7WawXSqlsbmsjpQOieR0g07ECUANgt/B8gpBO3uxPn7
	wD7dCILpU0JSTCUaKkSo5lLQuwT1G2tXiDcQE4I=
X-Google-Smtp-Source: AGHT+IGeMluJJQQQbTmTrVisFZ1ZOJH86hprZHiUL/HGfMODSuCVrW2E4yCJl64xkEYmK5B4pDqOjLPSaDFbbrFMBuA=
X-Received: by 2002:a4a:1781:0:b0:591:2de4:1fb6 with SMTP id
 123-20020a4a1781000000b005912de41fb6mr3331538ooe.1.1705411817849; Tue, 16 Jan
 2024 05:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d98d8d45a89fc2434dd71d573fe4c6986986513.1705351057.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7d98d8d45a89fc2434dd71d573fe4c6986986513.1705351057.git.christophe.jaillet@wanadoo.fr>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 16 Jan 2024 14:30:05 +0100
Message-ID: <CAOi1vP-5Kp3z7+-pa2Rb_xTATKq7zN0a2eACeJNWw2zj=rr6JA@mail.gmail.com>
Subject: Re: [PATCH] rbd: Remove usage of the deprecated ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 9:37=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> Note that the upper limit of ida_simple_get() is exclusive, buInputt the =
one of
> ida_alloc_max() is inclusive. So a -1 has been added when needed.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/block/rbd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index a999b698b131..63897d0d6629 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5326,7 +5326,7 @@ static void rbd_dev_release(struct device *dev)
>
>         if (need_put) {
>                 destroy_workqueue(rbd_dev->task_wq);
> -               ida_simple_remove(&rbd_dev_id_ida, rbd_dev->dev_id);
> +               ida_free(&rbd_dev_id_ida, rbd_dev->dev_id);
>         }
>
>         rbd_dev_free(rbd_dev);
> @@ -5402,9 +5402,9 @@ static struct rbd_device *rbd_dev_create(struct rbd=
_client *rbdc,
>                 return NULL;
>
>         /* get an id and fill in device name */
> -       rbd_dev->dev_id =3D ida_simple_get(&rbd_dev_id_ida, 0,
> -                                        minor_to_rbd_dev_id(1 << MINORBI=
TS),
> -                                        GFP_KERNEL);
> +       rbd_dev->dev_id =3D ida_alloc_max(&rbd_dev_id_ida,
> +                                       minor_to_rbd_dev_id(1 << MINORBIT=
S) - 1,
> +                                       GFP_KERNEL);
>         if (rbd_dev->dev_id < 0)
>                 goto fail_rbd_dev;
>
> @@ -5425,7 +5425,7 @@ static struct rbd_device *rbd_dev_create(struct rbd=
_client *rbdc,
>         return rbd_dev;
>
>  fail_dev_id:
> -       ida_simple_remove(&rbd_dev_id_ida, rbd_dev->dev_id);
> +       ida_free(&rbd_dev_id_ida, rbd_dev->dev_id);
>  fail_rbd_dev:
>         rbd_dev_free(rbd_dev);
>         return NULL;
> --
> 2.43.0
>

Applied.

Thanks,

                Ilya

