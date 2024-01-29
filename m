Return-Path: <linux-kernel+bounces-42106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6C83FC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7681C217EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB8F9E0;
	Mon, 29 Jan 2024 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtapYc8I"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32150EAE5;
	Mon, 29 Jan 2024 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706496412; cv=none; b=FcUxAjtryvzowv/CXqG2pDN50WcxBsFfMrdkk9nQfbZQ7sH5/jGDCA4Of3NrUDJIIUOmn0wK6ZXAYAo9C49EnsiTz+iPbaEC6Sp4yfEfe9s7/xRgU1WSA/V4O2Nzk0MvpiV1nsZW0vBr/rkp4UtAIYndK6KgeOMOC7WGaoIoNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706496412; c=relaxed/simple;
	bh=iaSgUztFO5WOp4UT/o/uqEJVRgKzC2Jwlx1CmOVnOHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOavq1cQPh2gviglEQMquOzo3ltlzOr41s4C8ky/EeuPR3AX5DwtiUS+abdfQauDN6pUSwQRR0H/ZQFvm0X9DOjiyFaxb2nB08gVh/6L4V81hWaFeIazqKY4eRM85pNswDdkpAr6zR8YW8EIkPuJVaLujnBMOq2tYLOTibZlnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtapYc8I; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4bdb8de8f45so296111e0c.2;
        Sun, 28 Jan 2024 18:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706496410; x=1707101210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkSsYsgeCfvXg023esX0wGiHDDtxSyHiSZX003ccu0w=;
        b=LtapYc8I43iun3J21CnaXRfpWGuimy4s54+Ahx47uerNH9m2K+2o6WzUEydi0qgoT2
         6BDK3nOarMzZFYJ0+rU6yrZejriWudB2MqW30eTcF7LfjC9pbwHT+0d0kqMPfQ2HVzCa
         d/ojC0RgiDxJ0ISVjt8pmV5j4PmbewfuP2HOZM1R2EitcyhzP0xKdUh5wlwrIOilTBlO
         O2AOYB4xY/roysdEit8S6GiC5PetGQpzAC+vOp4ubcCztgzvrMLng5vop7UEiMAqCiiI
         2mg0KrVyPyL7AP6wS2wz6vgcqiAHUw4ZbMHGXshJkXFb7xvIAxDfWSusXBRspsHNoezH
         DR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706496410; x=1707101210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkSsYsgeCfvXg023esX0wGiHDDtxSyHiSZX003ccu0w=;
        b=RMX3YX3km7QSLcmRUkK8LwZyABNybe5V/ZwCsqcMuEn56nRYFEt9JModbXrZ7Ycu4N
         BX5B5J/JOAK/Ho+ZKicyvOjxJ+XFhJJcgXYwMsKmRTz8LFTP6ZhYvFZ1n/inFumu3G+A
         iRmwwFuQkV6lSamLgH2wwtOZhdREdwMxTI6Irwi4pHLnBmMk+PfHsKu+0QxEnSo52ZLZ
         WxAhOp4nVMHgfhN3JegVnNRg4BnX8+TbvZve53SthXnQaZ01oQ4pgddYkIzBaNXAlCJN
         S0KDxnUEXyKSl2xTOZLf5sdndW2DzhoCPi3w8uYWOx7mTbqLTTNOkycGTeSdFhPmENs3
         xg6A==
X-Gm-Message-State: AOJu0YyLfyPV17zazCjETjDr/IMEy+1WOXAHMVWwG1A4HOs5vE823BFQ
	9xg7kygsEQVwlsndJJpRHmH/SZMkIX5W9NBUmUPYbtd1bYOxno+xgQ3ybcfMtUhkf84ElYZ183N
	9F4aX31hrijWqJNiJC4B4JIqAB64=
X-Google-Smtp-Source: AGHT+IH0zMD8/RxEXU7DsKKvbZcRPlZ+NXTTVYciwEjaHLt8FIDrEdayUKibhNYJXdonblSwQWcwh1Rta0f8Sgjksi8=
X-Received: by 2002:a05:6122:9a7:b0:4bd:4cf4:335f with SMTP id
 g39-20020a05612209a700b004bd4cf4335fmr970651vkd.26.1706496409986; Sun, 28 Jan
 2024 18:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103003011.211382-1-v-songbaohua@oppo.com>
 <20240106013021.GA123449@google.com> <CAGsJ_4xp7HFuYbDp3UjMqFKSuz2HJn+5JnJdB-PP_GmucQqOpg@mail.gmail.com>
 <20240115023457.GA1504420@google.com>
In-Reply-To: <20240115023457.GA1504420@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Jan 2024 10:46:38 +0800
Message-ID: <CAGsJ_4x6e7=tWVKfauJaGMRmJ3tz7GymKosYcHrxoxEnAHyX6g@mail.gmail.com>
Subject: Re: [PATCH] zram: easy the allocation of zcomp_strm's buffers with 2 pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 10:35=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/01/06 15:38), Barry Song wrote:
> > On Sat, Jan 6, 2024 at 9:30=E2=80=AFAM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (24/01/03 13:30), Barry Song wrote:
> > > > There is no need to keep zcomp_strm's buffers contiguous physically=
.
> > > > And rarely, 1-order allocation can fail while buddy is seriously
> > > > fragmented.
> > >
> > > Dunno. Some of these don't sound like convincing reasons, I'm afraid.
> > > We don't allocate compression streams all the time, we do it once
> > > per-CPU. And if the system is under such a terrible memory pressure
> >
> > We actually do it many times actually because we free it while unpluggi=
ng and
> > re-allocate it during hotplugging. this can happen quite often for syst=
ems like
> > Android using hotplug for power management.
>
> Okay, makes sense.
> Do you see these problems in real life? I don't recall any reports.

i don't have problems with the current zram which supports normal pages onl=
y.

but  in our out-of-tree code, we have enhanced zram/zsmalloc to support lar=
ge
folios compression/decompression, which will make zram work much better
with large anon folios/mTHP things on which Ryan Roberts is working on.

I mean, a large folio with for example 16 normal pages can be saved as
one object in zram.
In millions of phones, we have deployed this approach and seen huge improve=
ment
on compression ratio and cpu consumption decrease. in that case, we
need a larger
per-cpu buffer, and have seen frequent failure on allocation. that
inspired me to send
this patch in advance.

>
> > > then one probably should not use zram at all, because zsmalloc needs
> > > pages for its pool.
> >
> > In my humble opinion, 1-order allocation and 0-order allocation are dif=
ferent
> > things, 1-order is still more difficult though it is easier than
> > 2-order which was
> > a big pain causing allocation latency for tasks' kernel stacks and nega=
tively
> > affecting user experience. it has now been replaced by vmalloc and make=
s
> > life easier :-)
>
> Sure.
>
> > > I also wonder whether Android uses HW compression, in which case we
> > > may need to have physically contig pages. Not to mention TLB shootdow=
ns
> > > that virt contig pages add to the picture.
> >
> > I don't understand how HW compression and TLB shootdown are related as =
zRAM
> > is using a traditional comp API.
>
> Oh, those are not related. TLB shootdowns are what now will be added to
> all compressions/decompressions, so it's sort of extra cost.

i am sorry i still don't understand where the tlb shootdowns come
from. we don't unmap
this per-cpu buffers during compression and decompression, do we ?

am i missing something?

> HW compression (which android may be doing?) is another story.
>
> Did you run any perf tests on zram w/ and w/o the patch?
>
> > We are always passing a virtual address, traditional HW drivers use the=
ir own
> > buffers to do DMA.
> >
> > int crypto_comp_compress(struct crypto_comp *comp,
> > const u8 *src, unsigned int slen,
> > u8 *dst, unsigned int *dlen);
> > int crypto_comp_decompress(struct crypto_comp *comp,
> >   const u8 *src, unsigned int slen,
> >   u8 *dst, unsigned int *dlen);
> >
> > In new acomp API, we are passing a sg - users' buffers to drivers direc=
tly,
> > sg_init_one(&input, src, entry->length);
> > sg_init_table(&output, 1);
> > sg_set_page(&output, page, PAGE_SIZE, 0);
> > acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length=
, dlen);
> > ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req),
> > &acomp_ctx->wait);
> >
> > but i agree one-nents sg might have some advantage in scompress case
>
> Right.
>
> > after we move
> > to new acomp APIs if we have this patch I sent recently [patch 3/3],
> > https://lore.kernel.org/linux-mm/20240103095006.608744-1-21cnbao@gmail.=
com/
>
> Nice.

Thanks
Barry

