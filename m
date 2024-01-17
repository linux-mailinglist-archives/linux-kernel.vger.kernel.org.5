Return-Path: <linux-kernel+bounces-28434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E7382FE76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F9A285D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B216AB8;
	Wed, 17 Jan 2024 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRmGDrqV"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCD522D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455601; cv=none; b=UPW1NgB1nKtBm78AVQBLQsriGxa8W2af8Z/Z/UX0Fc1vVAfcNx/WMMwehcf2PBTMuc4sxA5H+dX0Sn08Ecj0z2ALE60UM2It9yKpQmbQpAinVMbIa577WVdROVs/+oeTdRDL/9+554b3pckOdYtWuHYZ8ooZ2QmBsq0S2DqMvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455601; c=relaxed/simple;
	bh=NGWVS37ocYACenpSR8rr3s2ZrWHX/QIndc6yeq2dSPs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hp8z7BzF4XkN360eolBuSWaR14p9B1FF5roJgIFs44GJ1KPkOavVF2yQ9UKb3e2CY4S8ICQAqEjNq9VPmd6jW+mrojjW8j4j0KIGEQ8k/mfx9fuNQoh0171kwnlu7RsEaS3C2HZpkZcG7tswUl6xjfyddZOBK3IOAp+3mmoGDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRmGDrqV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-429af318342so43994851cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 17:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705455599; x=1706060399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD8RW8HiVtchtdDZneDcXtHEOUAUQNP+GrQ/AmvTd8g=;
        b=WRmGDrqVuns5zi04cttb9zGXEf+FD2/IvHLGwL76BeKbB65+z5r+G6WDsjOPA8djm1
         v8I04AkTk+00q1UvNlI/Q3MP/fOhKRoZiELEDKQNmdkmLvM5aZu+4sJTHr51XhkdAQKM
         56tnbiPIW+w7Sq5Um8BjMKHRvEktDQDHc40uMTh9g3xTrHupYQZX+MCmDLH3gzHRvw8j
         eJ3M5soMmE09g0sgQdcMuRp5wt/AP0d+2PGXEWNqEC7XwABqFmC2dKhc6/IT9yrSP78h
         3Mqt0REVNv/vwhszEUe1qPKPOJbVKvDtrFGum4U3datE98qa+1p1cF6minZ9aIoMxV7n
         s8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705455599; x=1706060399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD8RW8HiVtchtdDZneDcXtHEOUAUQNP+GrQ/AmvTd8g=;
        b=JcEKGrda3Psqo0/Lqu9ovdZkMNpvK1DRDO1JBMmx1zuriu5Q70Wd3oC0LAIOVuO8E6
         ssNUSZH5bA56x8gOu+MAoJOgSLrc/LbHxo43qq/LdQNkb+EvUpDxHMhR2aGCq3I1d9Y0
         dMTlRWOyIcxpnmZVRJ50rcQhQ5t+vjgwyjQM9QC+oJBR59AQqUznK1idIxTpWFcqB1Fx
         0YRkgEiecU/Nf/UhBWQrCzg2v6zS1JQ1Nhrb/XtKAI3bf+o8WkQ7TFaVyVIthUhMJx0n
         +jR9USKU9mUf5aVQEyx5Fsie92Cc4rAXnVuWS0+/P1k3gdH/6NKj0wO3d110JAg4n8JD
         DdVA==
X-Gm-Message-State: AOJu0YxyfaBsjjNHH4hzVdy6zLO82q9i78Ij/CkFIkFz0qbctPZq9S5Y
	1RhIjhwPgUdqPkjvWoxCwI4KyiK7E0Hm7BItCsg=
X-Google-Smtp-Source: AGHT+IEjlIE8dNokcrzwTbbsE8uTAXkhjtJANkUcFThRNkiialKh3OBKOeBA5s6j7fuK2rIkm5jidk/roFy1t23ahtc=
X-Received: by 2002:ac8:5e07:0:b0:429:c760:c14b with SMTP id
 h7-20020ac85e07000000b00429c760c14bmr11964798qtx.116.1705455598993; Tue, 16
 Jan 2024 17:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116141138.1245-1-qwjhust@gmail.com> <CACOAw_yL7fLmjLkK29yEb3hgTqoDO2hntOX5LMHmWjZWWix1ig@mail.gmail.com>
In-Reply-To: <CACOAw_yL7fLmjLkK29yEb3hgTqoDO2hntOX5LMHmWjZWWix1ig@mail.gmail.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Wed, 17 Jan 2024 09:39:48 +0800
Message-ID: <CAGFpFsSSg+Xs9TAw8qOadUxj8kYfyc+h3cCu_UJsxXUzMu50vQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
To: Daeho Jeong <daeho43@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	hustqwj@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Daeho,
I don't think moving just the "out" label will work.
If a fio is zone end and in_list =3D 1, that fio is missed without being ju=
dged.

On Wed, Jan 17, 2024 at 5:58=E2=80=AFAM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> On Tue, Jan 16, 2024 at 6:13=E2=80=AFAM Wenjie Qi <qwjhust@gmail.com> wro=
te:
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000014
> > RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> > Call Trace:
> > <TASK>
> > ? show_regs+0x6e/0x80
> > ? __die+0x29/0x70
> > ? page_fault_oops+0x154/0x4a0
> > ? prb_read_valid+0x20/0x30
> > ? __irq_work_queue_local+0x39/0xd0
> > ? irq_work_queue+0x36/0x70
> > ? do_user_addr_fault+0x314/0x6c0
> > ? exc_page_fault+0x7d/0x190
> > ? asm_exc_page_fault+0x2b/0x30
> > ? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> > ? f2fs_submit_page_write+0x736/0x780 [f2fs]
> > do_write_page+0x50/0x170 [f2fs]
> > f2fs_outplace_write_data+0x61/0xb0 [f2fs]
> > f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
> > f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
> > f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
> > ...
> > It is possible that other threads have added this fio to io->bio
> > and submitted the io->bio before entering f2fs_submit_page_write().
> > At this point io->bio =3D NULL.
> > If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
> > then an NULL pointer dereference error occurs at bio_get(io->bio).
> > The original code for determining zone end was after "out:",
> > which would have missed some fio who is zone end. I've moved
> >  this code before "skip:" to make sure it's done for each fio.
> >
> > Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> > ---
> >  fs/f2fs/data.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index dce8defdf4c7..4f445906db8b 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1080,10 +1080,6 @@ void f2fs_submit_page_write(struct f2fs_io_info =
*fio)
> >         io->last_block_in_bio =3D fio->new_blkaddr;
> >
> >         trace_f2fs_submit_page_write(fio->page, fio);
> > -skip:
> > -       if (fio->in_list)
> > -               goto next;
> > -out:
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >         if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
> >                         is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
> > @@ -1096,6 +1092,10 @@ void f2fs_submit_page_write(struct f2fs_io_info =
*fio)
> >                 __submit_merged_bio(io);
> >         }
> >  #endif
> > +skip:
> > +       if (fio->in_list)
> > +               goto next;
> > +out:
>
> How about moving only the "out" label instead of the whole block from
> "skip" to "out"?
>
> >         if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
> >                                 !f2fs_is_checkpoint_ready(sbi))
> >                 __submit_merged_bio(io);
> > --
> > 2.34.1
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

