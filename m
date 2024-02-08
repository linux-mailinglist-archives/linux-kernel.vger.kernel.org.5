Return-Path: <linux-kernel+bounces-57537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E921384DA5E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69CB286C70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53169300;
	Thu,  8 Feb 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBw3ANuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF04679E4;
	Thu,  8 Feb 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375058; cv=none; b=EBSUKIsQTkNTwATCOLZ8uPY2eXDwLDX+6gqVouL0T8swD8huNzN10I2704pdgR23tvzBM2KLjaAiqoEnEaGqYRns8PqXvhZlDoTd12Pcyqo1v06utVZAc0RTPmvszp0Ul6zVCg92GLlHzSP6brDVK3IgAzR/tezaTT/D54h4cIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375058; c=relaxed/simple;
	bh=Blq7rU4mZ+SoYBWemZfo+nUsAY0ljuEyn+/YGvZ2zAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r67egsUBv0hRFLYrMWt8HHsBtLNRXhSfxbEDUVxpXss5fbZnGWXTeE67yFoloOiPxAJ/fw3b5XmbrHhXe+zz+Y79yIT9rFNR1+4YZ2QDPJ+9Ke5PRqU44cUCiGDNk/9hysDSQMapS/Bu34vvNwMsdH2Vf0LcTyMHUiCrnKYhdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBw3ANuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CF2C433A6;
	Thu,  8 Feb 2024 06:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707375057;
	bh=Blq7rU4mZ+SoYBWemZfo+nUsAY0ljuEyn+/YGvZ2zAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iBw3ANuLjTJlE+pfEJR8ExuAYxb5XFZ6EG8wFB0Yn1/I7H47a4muQxzRfE29+2ZiD
	 myT4mNcogzX1c+OWIlTNy0OeLD8ztUO4hkaCxcErugQZ07AC0JSkBFG32QB/tBgsHr
	 RQtjSsD05Z9LFnNJl+NlFE+JPgdL8u+BcUq/P0Hdv9KEBw6apAJpaHw1B61grzgH3S
	 bPilqEplu3v/SxIbGP1BCm7qcdaplhUP/Uou+wEg19X/SgvBx99Km221bvu9EamSvU
	 AxT6iC4x7KoI8RFla4Uho2IQSi/599k2g4zdqFJoFHahdGUPGHvutHhZiO8UFquivD
	 UyQBlVVEW+2sw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d09fefabc1so16091591fa.1;
        Wed, 07 Feb 2024 22:50:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcyEE9jWs9SuBb1PSlOyEwfykxlv/QKu/lHZFOQYfxGnXQYBp4wDpwkz1IFC3BJJiv2PgGMEHPc5j2Dyl1oxYGUF/c6p/tgpSdRwcQDULJxa/04BXhI45lys6DwFzQb4M/8pfqEQpNkc0UqaT7iofpXH3MHB1rP8AkAqxliGIXujh6UlxY
X-Gm-Message-State: AOJu0YxK9l5LKW3YsZL1VC8eebvkwqvLtJEuAtGgDxIe4yVk3Z3nPzxn
	n/sdBEB28Ck9UYJQpwFefoBO1s5VUfYRYi+ieiiKCrFS2leRuHG7g1Hy7PxMhxAxL76BVul+XYX
	lxNJ+fYXO+oH92wQlLQSZJbAVCh0=
X-Google-Smtp-Source: AGHT+IHy8Qpcwq8yq9sbhJtqtqNBBtvyBZ0GYcTZFVmxDS9u6BeF4978MZaFEycIsX6/uag1SqonCtdwPENndeM181Y=
X-Received: by 2002:a05:651c:1250:b0:2d0:ce72:570b with SMTP id
 h16-20020a05651c125000b002d0ce72570bmr1828377ljh.48.1707375055731; Wed, 07
 Feb 2024 22:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207092756.2087888-1-linan666@huaweicloud.com>
In-Reply-To: <20240207092756.2087888-1-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Wed, 7 Feb 2024 22:50:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW74hLiW_KTv3xohwMAcPZ9gp2TvLST4tY7H3O8cA26TTg@mail.gmail.com>
Message-ID: <CAPhsuW74hLiW_KTv3xohwMAcPZ9gp2TvLST4tY7H3O8cA26TTg@mail.gmail.com>
Subject: Re: [PATCH] block: fix deadlock between bd_link_disk_holder and
 partition scan
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:32=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> 'open_mutex' of gendisk is used to protect open/close block devices. But
> in bd_link_disk_holder(), it is used to protect the creation of symlink
> between holding disk and slave bdev, which introduces some issues.
>
> When bd_link_disk_holder() is called, the driver is usually in the proces=
s
> of initialization/modification and may suspend submitting io. At this
> time, any io hold 'open_mutex', such as scanning partitions, can cause
> deadlocks. For example, in raid:
>
> T1                              T2
> bdev_open_by_dev
>  lock open_mutex [1]
>  ...
>   efi_partition
>   ...
>    md_submit_bio
>                                 md_ioctl mddev_syspend
>                                   -> suspend all io
>                                  md_add_new_disk
>                                   bind_rdev_to_array
>                                    bd_link_disk_holder
>                                     try lock open_mutex [2]
>     md_handle_request
>      -> wait mddev_resume
>
> T1 scan partition, T2 add a new device to raid. T1 waits for T2 to resume
> mddev, but T2 waits for open_mutex held by T1. Deadlock occurs.
>
> Fix it by introducing a local mutex 'holder_mutex' to replace 'open_mutex=
'.

Is this to fix [1]? Do we need some Fixes and/or Closes tags?

Could you please add steps to reproduce this issue?

Thanks,
Song

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218459

>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/holder.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/block/holder.c b/block/holder.c
> index 37d18c13d958..5bfb0a674cc7 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -8,6 +8,8 @@ struct bd_holder_disk {
>         int                     refcnt;
>  };
>
> +static DEFINE_MUTEX(holder_mutex);
> +
>  static struct bd_holder_disk *bd_find_holder_disk(struct block_device *b=
dev,
>                                                   struct gendisk *disk)
>  {
> @@ -80,7 +82,7 @@ int bd_link_disk_holder(struct block_device *bdev, stru=
ct gendisk *disk)
>         kobject_get(bdev->bd_holder_dir);
>         mutex_unlock(&bdev->bd_disk->open_mutex);
>
> -       mutex_lock(&disk->open_mutex);
> +       mutex_lock(&holder_mutex);
>         WARN_ON_ONCE(!bdev->bd_holder);
>
>         holder =3D bd_find_holder_disk(bdev, disk);
> @@ -108,7 +110,7 @@ int bd_link_disk_holder(struct block_device *bdev, st=
ruct gendisk *disk)
>                 goto out_del_symlink;
>         list_add(&holder->list, &disk->slave_bdevs);
>
> -       mutex_unlock(&disk->open_mutex);
> +       mutex_unlock(&holder_mutex);
>         return 0;
>
>  out_del_symlink:
> @@ -116,7 +118,7 @@ int bd_link_disk_holder(struct block_device *bdev, st=
ruct gendisk *disk)
>  out_free_holder:
>         kfree(holder);
>  out_unlock:
> -       mutex_unlock(&disk->open_mutex);
> +       mutex_unlock(&holder_mutex);
>         if (ret)
>                 kobject_put(bdev->bd_holder_dir);
>         return ret;
> @@ -140,7 +142,7 @@ void bd_unlink_disk_holder(struct block_device *bdev,=
 struct gendisk *disk)
>         if (WARN_ON_ONCE(!disk->slave_dir))
>                 return;
>
> -       mutex_lock(&disk->open_mutex);
> +       mutex_lock(&holder_mutex);
>         holder =3D bd_find_holder_disk(bdev, disk);
>         if (!WARN_ON_ONCE(holder =3D=3D NULL) && !--holder->refcnt) {
>                 del_symlink(disk->slave_dir, bdev_kobj(bdev));
> @@ -149,6 +151,6 @@ void bd_unlink_disk_holder(struct block_device *bdev,=
 struct gendisk *disk)
>                 list_del_init(&holder->list);
>                 kfree(holder);
>         }
> -       mutex_unlock(&disk->open_mutex);
> +       mutex_unlock(&holder_mutex);
>  }
>  EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
> --
> 2.39.2
>

