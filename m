Return-Path: <linux-kernel+bounces-33857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49F836F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F84D1C28155
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6F4879C;
	Mon, 22 Jan 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7VTDa6b"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57233482FF;
	Mon, 22 Jan 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945660; cv=none; b=qRuQs9w7Y06QE8UUGDBW9ZrOG6QgnKF9CalZD+WmJ0teqfxFqwH1T1n4O9pdOTT9KpJoHoyI6bNdyRo8qfWKeKQPwQwmtziMjADzvw+p3ZCwAU8l8BIuFScGf38g/8nGG0Fqmk0zt/88BcrsQ9LOb8vgNMHgpmsQ9cLwR+vDDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945660; c=relaxed/simple;
	bh=5JMS+q62XZW23hNclILrAtW7tpPqJU12NjrpErZJU6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plmc362ArgO6wulMK04JtiUcUaTfr3dLYJqno8FsdFaMI1llpiMeBQpQYteGaQI28Dn7yZ8n5zrluf2oQatyBcapeHW+DaOZWAqGNaxiTRsSuNQWi3+rhZN3emNteI9AnarWimlXPDCMdHWNJWfUB37PlqbfZsM22MWE5iII1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7VTDa6b; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd6581bc62so2521619b6e.2;
        Mon, 22 Jan 2024 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705945658; x=1706550458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LXuYDfCriPwb12rx/ZYT8NxGUq7r+dv6zy6nRCpOHlQ=;
        b=i7VTDa6bmjvB7Z/3EVJ6Dzn0IVZPDVxs0m8OGAw0j24rGjYXOLH7lVaGo2aKApz4Ob
         DMz2etAJz8LpXqQ9pb6m380N8vCGPuF1J9xRoPXIlEWs58B/KpC01zD32+aC/7+mvCJy
         Ya9y1jFyPaQYVOjGi3rB2x8u+R0x7VnWg0jGxvaZAimcHj0WZSAZpJKm7xxNf+L2w4O9
         4KNMHdmXgb+aN+bENgx3G5J8fqn7dmDqTCFc00fHpkbn0BOkBVs2s5ts//cl6GuwylD4
         U3GZHHaNIh3Bga2DI+CpbS8hfkHqQ+Kt+4reSARYoCl5szYE2I8y6aTfN0QPJY1rlS5M
         rOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945658; x=1706550458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXuYDfCriPwb12rx/ZYT8NxGUq7r+dv6zy6nRCpOHlQ=;
        b=JTmoRVEELI0Coe3vtJIbgSYiunaSxjDBR2jdCTd4jpBNEmywWzo8urfNvgqVDG6Dur
         gBawOvDxzSdxw12lxD0l0BonAGzIQgnmzKGgVTYrDCrp96qJj9rCCsBrD1sGJL3W+xkE
         rTaXBfUjTW0TyaOuB1pJ60pFTBtm/eMSUZPcenp7vPfcgc323hVovReBmafp1keQ6RAz
         zSJxuoqfuc5j/OMKskFtRCwj30onHqW6qkpjpWyh9SkzNe8E0/u+b9REgFx8KgSX7dEZ
         WmmfwUNLZzzmCc75ISMYxizPYZFiNyFOFoPyCJy2sM47BErkbYJSM64sHmAO7V7N0d4k
         ocBg==
X-Gm-Message-State: AOJu0YwyOvWR9HYxueXl8tdiNNN2g+QSfsziqMPJ5MWkC9ufpcbyC93F
	neAutOvwF5NdxPJZokZa1sc9I+k8DZmmwMppRUmBEg/9solMsZn53I5UTPLzXOUMs1Eeti8owmd
	JDv5csC2VD787k14jJP1vBk+JQ7k=
X-Google-Smtp-Source: AGHT+IFBPlz+RgibcswccIxunRUauN9Us0ZVtsgo5fHnIR0Z4jyywDWN7TzgdTClehWzdrId7Z0Ij/5fS4mvUZpKvTs=
X-Received: by 2002:aca:1809:0:b0:3bd:6f2f:6903 with SMTP id
 h9-20020aca1809000000b003bd6f2f6903mr3867589oih.111.1705945658414; Mon, 22
 Jan 2024 09:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130070133.8059-1-kch@nvidia.com> <20231130070133.8059-2-kch@nvidia.com>
 <20231201012507.GA1209828@fedora> <f4c17344-33be-4832-9045-fb6b40a478b6@nvidia.com>
In-Reply-To: <f4c17344-33be-4832-9045-fb6b40a478b6@nvidia.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 22 Jan 2024 12:47:25 -0500
Message-ID: <CAJSP0QX7H5F=rzz=STeWWYZbTxog0S-MARXgoHkR=u04qTD+_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] virtio-blk: process block layer timedout request
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "hch@lst.de" <hch@lst.de>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 22:33, Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
> On 11/30/23 17:25, Stefan Hajnoczi wrote:
> > On Wed, Nov 29, 2023 at 11:01:33PM -0800, Chaitanya Kulkarni wrote:
> >> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> >> index 3744e4da1b2a..ed864195ab26 100644
> >> --- a/include/uapi/linux/virtio_blk.h
> >> +++ b/include/uapi/linux/virtio_blk.h
> >> @@ -317,6 +317,7 @@ struct virtio_scsi_inhdr {
> >>   #define VIRTIO_BLK_S_OK            0
> >>   #define VIRTIO_BLK_S_IOERR 1
> >>   #define VIRTIO_BLK_S_UNSUPP        2
> >> +#define VIRTIO_BLK_S_TIMEOUT        3
> > The structs and constants in this header file come from the VIRTIO
> > specification. Anything changed in this file must first be accepted into
> > the VIRTIO spec because this is the hardware interface definition.
> >
> > VIRTIO_BLK_S_TIMEOUT seems to be synthetic value that is purely used by
> > software, not the device. Maybe there is no need to update the spec.
> > Just avoid using in_hdr.status to signal timeouts and use a separate
> > flag/field instead in a block layer or virtio_blk driver request struct.
>
> It is a specific error hence I've added that on the similar lines,
> do you have a specific field in mind that you would prefer ?

I didn't have a specific flag or field in mind, but it's probably no
longer necessary in v2 because the code needs to wait for the device
to complete the request anyway.

Stefan

