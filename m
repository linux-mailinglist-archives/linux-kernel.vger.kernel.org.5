Return-Path: <linux-kernel+bounces-27401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2282EF54
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E3F285C33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FDA1BC56;
	Tue, 16 Jan 2024 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxB4Ca+S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D61BC49
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705410194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0N5v3FGg9HV1O03dFWgRRmN/kV4JKXO0joKxDaXAWM=;
	b=gxB4Ca+SOQQ//LOnCzNh5hrHnmDnp0JaPykBERbmGycv354thzVrSr2XjmF9XLhVP890Zs
	nBkNNLm97/ktxzSfMrxG8C/0pltyGSqQ6nPSndi039BlFa1Paov0AXIXjqbad9sNoD8NkT
	NGLjT0zcIb9YU7Tcpm9n6FOtcyPJ3ug=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-cTk9bMbAMJq7IqANp2eD-Q-1; Tue, 16 Jan 2024 08:03:13 -0500
X-MC-Unique: cTk9bMbAMJq7IqANp2eD-Q-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4b78e56d741so2200740e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410192; x=1706014992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0N5v3FGg9HV1O03dFWgRRmN/kV4JKXO0joKxDaXAWM=;
        b=ujxOKGtA95y/IOwM+8t0sXNBP9nciYcqEG+gDak6vgOfIqlmQnOaaTMkH2fF2apsP/
         6NTyivpaicDohSoOA0/AcOovFc6OTamaXxPnEStxTbuok/TBiiJ28BrfvoAHaghnxVAv
         Av/6glcr5iwCqOhrKzlK3/pmJTCjMDq3CQYKS+HorQPx2PYqAyypGQydWxftcK2ntCNm
         4zLshz+Qu9ekc1moigNipcurtfdyzof/nF/zr6vOo3PUELRGLtkYC7yIIouVJ79oIa51
         3rrShhjlPawNXTldUibMCA7Ho5l5+N0548N84I9HreBWuIrxywp1DoK6Za2TfVon62Zq
         TULQ==
X-Gm-Message-State: AOJu0YyxJPYhWb6LGFIFXC6Et6o8+z4oySsTWEM7lqVYg36qfPVOtqVS
	mwu6rpOjwnvaIMkgMKVpi1UjZwi2wM+Xp5oOQo3uJZOj0yu9elLzAnY7ZtMvyunP0cUdLyZWTI1
	M1WHWnN1bbAv0sMVW1bKp8J2GGDmlqBfvHumIuasXMB0s76z2yN4SDQICeC6qLfwh
X-Received: by 2002:a05:6122:3890:b0:4b7:185a:d8d with SMTP id eo16-20020a056122389000b004b7185a0d8dmr3176442vkb.1.1705410192513;
        Tue, 16 Jan 2024 05:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5OGDPaJ/pElYMM1FUKvzKRX3+RA4kcKome6XGeBKftjNA7FxErL90EMCaNp60VNPyBZs0+o+nBDaJcA7pBr0=
X-Received: by 2002:a05:6122:3890:b0:4b7:185a:d8d with SMTP id
 eo16-20020a056122389000b004b7185a0d8dmr3176426vkb.1.1705410192165; Tue, 16
 Jan 2024 05:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
 <ZaZesiKpbMEiiTrf@infradead.org>
In-Reply-To: <ZaZesiKpbMEiiTrf@infradead.org>
From: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Date: Tue, 16 Jan 2024 14:03:01 +0100
Message-ID: <CAOYeF9VoN3LpA+CV=fkBR62vqZ8VEvoWD_Hb5Ay5tK9M-Xw1Xw@mail.gmail.com>
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to return
 ENXIO, now returns EINVAL
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Li Lingfeng <lilingfeng3@huawei.com>
Content-Type: text/plain; charset="UTF-8"

hi Christoph,

I'm not really setup for compiling and testing new kernel images which
is why I didn't offer to develop a patch for myself (which would have
looked a lot like this one which you just sent).  I also generally
have a lot of other things I'm working on at the moment.

The thing that worries me about this approach is that it was already
proposed some months ago, and shot down at the time with the (somewhat
reasonable) justification that if you do any partition table
operations on a device that doesn't contain a partition table, then
"EINVAL" is perhaps somewhat more reasonable as an error.  See the
email thread I linked from my earlier message, and particular this
message from Li Lingfeng (who wrote the patch that introduced this
regression in the first place):

> I don't think so.
>
> GENHD_FL_NO_PART means "partition support is disabled". If users try
> to add or resize partition on the disk with this flag, kernel should
> remind them that the parameter of device is wrong.
> So I think it's appropriate to return -EINVAL.

https://marc.info/?l=linux-kernel&m=169753292503830&w=2

So: I suspect the offered patch would solve the issue, but I'm not
sure if it's correct.  Another approach might involve returning ENXIO
for "delete" and keeping EINVAL for create (and also picking one of
those for modify), which could also look like moving the check down to
below the point in the function where bdev_del_partition() is called.
I've cc:'d Li Lingfeng on this email, who can maybe provide some
additional context.

Thanks (and sorry...)

Allison

On Tue, 16 Jan 2024 at 12:16, Christoph Hellwig <hch@infradead.org> wrote:
>
> Hi Allison,
>
> please try this minimal fix.  I need to double check if we historically
> returned ENXIO or EINVAL for adding / resizing partitions, which would
> make things more complicated.  Or maybe you already have data for that
> at hand?
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9c73a763ef8838..f2028e39767821 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>         sector_t start, length;
>
>         if (disk->flags & GENHD_FL_NO_PART)
> -               return -EINVAL;
> +               return -ENXIO;
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EACCES;
>         if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
>


