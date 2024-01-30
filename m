Return-Path: <linux-kernel+bounces-45326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78806842E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABF51C24F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83351762EA;
	Tue, 30 Jan 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUYmH0xF"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A0A762C3;
	Tue, 30 Jan 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649356; cv=none; b=U1TSrTdYHV+zEGsPOZfQ2e0qvaJvOYpOuvu0ZdjAUOVQjrB9Uo2gup01w1mSTnIstDF7bYWgoPPzvgar9loSfWpRHibbnhP/EVJ3OSx3CnDuAbEeiAagxVeCt4BkULfuhDIu9NWrF2BNFsmirLJa5GzbAykQSKluBz6AehoGUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649356; c=relaxed/simple;
	bh=2J6sAooCk62fHjWrW7YUBlLRP5OyzMo31VVLNDHdhWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBy0jYT80DoJM2c0rCct2TVpDMm/+jyRiL6T5fGul5ZBbdjQqCw/A+rP/pVT6ezo4lw7ZC/zb0n5i2n9ZgSYPgVCNiJHB3Xz3qQDy/ZvKEO7PGBePzIQbPnxHzMFUDS/93lfXSbozc4vBy7/YzRl5Mc6N69CRiODCON41xgfMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUYmH0xF; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2185d5f4366so1584420fac.2;
        Tue, 30 Jan 2024 13:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649354; x=1707254154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uVaLbUp0zV3Lqp8SjRyaTBacDGvqyOGhA2F/OG5J9Q=;
        b=dUYmH0xFW1MRjJUyf9mRScCLFOVBMtyPuRC9hhr2s6lPOYptyJgeAqN20q257sFvdq
         ViPL1MAMMfZUwuPWMfftIZrTZfR6P4RndSdxiU4/u0r0Jl41yInWeonk/wXF0P89fu6O
         AReLoUPoGiPbQAa1971UXSj2Mp+VWRfYntiT1Vbx7uNO4lMXpnpk3ud10NM9x4ohxsa2
         MsGbSUZWoDLNzXvjiHjBd/xuej/qklA+5l21Ng2caIP28gRC4QFGkqbEOKcVQzcad1R/
         8klams3C/iiKQ6sg5YtjwBdZaS9ZIkb3TI4GwYXkdmedmD/qCyNkALb66KFZTpDwcNAB
         ybLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649354; x=1707254154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uVaLbUp0zV3Lqp8SjRyaTBacDGvqyOGhA2F/OG5J9Q=;
        b=MwpfXOepPDEeJfDz6QX30PW33f1REIEcWsr7fQpJGLNGniWyyaLlGZLVYuS/V4k8mZ
         abTrQYu11UmZ+6cEz3ahT1PIzFwC2KHo+qNWrp+Lvc8acxv0R7QswwktIoXyvVBt65Lp
         YTPk2YVqUFvgqEGYItvPw/aPHUyXBN86tL0vrkJdeY3Cn8VAxnRPM/EBAv5BxX8qHAkb
         aGBox3DX6hwQGeBWME2w2B745jbrevV7vgucSgo17UcTLevyzuh81SzrZ+dz3sQmOiOH
         xGiqILwj6Ig4ORYdRXONyLl3/g/pNu0YNM/bdp5AwpnOSB4P3fNM+Tqcd6s6OE1ZT2sx
         i3SA==
X-Gm-Message-State: AOJu0Yy90GXEovmjupnf3+5/j1zfCgq4s+zUQKCmGi8Ch1ptT4+rbU5M
	GYam3iYqmqAjY6svd/KV5Cs7ERxBnBDha2fX6SGFighvOhc/aQsUlUj5l3zYtqZxHvnDDMIhjwu
	OtuaTCyQEK50i9OMNcJqa94MQhzM4oygJ
X-Google-Smtp-Source: AGHT+IGH9PpeiWaqfEAXJVURKEkRwkn0w1eqpTcew158AuIabqXuAJ+Md2qP4etm6tpr/3laTRZT+arssHuDHEtrV9w=
X-Received: by 2002:a05:6871:3415:b0:218:7597:2018 with SMTP id
 nh21-20020a056871341500b0021875972018mr5405415oac.16.1706649354251; Tue, 30
 Jan 2024 13:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129085250.1550594-1-yi.sun@unisoc.com>
In-Reply-To: <20240129085250.1550594-1-yi.sun@unisoc.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jan 2024 16:15:41 -0500
Message-ID: <CAJSP0QWLk_=Nm2aw+rwgg6L4CJPy6w--=SyF4vCU_sDCyQdosQ@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
To: Yi Sun <yi.sun@unisoc.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk, 
	sunyibuaa@gmail.com, hongyu.jin@unisoc.com, zhiguo.niu@unisoc.com, 
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 03:54, Yi Sun <yi.sun@unisoc.com> wrote:
>
> Ensure no remaining requests in virtqueues before resetting vdev and
> deleting virtqueues. Otherwise these requests will never be completed.
> It may cause the system to become unresponsive.
>
> Function blk_mq_quiesce_queue() can ensure that requests have become
> in_flight status, but it cannot guarantee that requests have been
> processed by the device. Virtqueues should never be deleted before
> all requests become complete status.
>
> Function blk_mq_freeze_queue() ensure that all requests in virtqueues
> become complete status. And no requests can enter in virtqueues.
>
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>  drivers/block/virtio_blk.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3b6b9abb8ce1..14ecc14ce8db 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,14 +1595,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
>  {
>         struct virtio_blk *vblk = vdev->priv;
>
> +       /* Ensure no requests in virtqueues before deleting vqs. */
> +       blk_mq_freeze_queue(vblk->disk->queue);
> +
>         /* Ensure we don't receive any more interrupts */
>         virtio_reset_device(vdev);
>
>         /* Make sure no work handler is accessing the device. */
>         flush_work(&vblk->config_work);
>
> -       blk_mq_quiesce_queue(vblk->disk->queue);
> -
>         vdev->config->del_vqs(vdev);
>         kfree(vblk->vqs);
>
> @@ -1620,7 +1621,7 @@ static int virtblk_restore(struct virtio_device *vdev)
>
>         virtio_device_ready(vdev);
>
> -       blk_mq_unquiesce_queue(vblk->disk->queue);
> +       blk_mq_unfreeze_queue(vblk->disk->queue);
>         return 0;
>  }
>  #endif
> --
> 2.25.1
>
>

