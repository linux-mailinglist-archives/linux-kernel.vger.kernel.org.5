Return-Path: <linux-kernel+bounces-148621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278438A8531
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C06B24C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5729014036F;
	Wed, 17 Apr 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpDkQabu"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AF63A;
	Wed, 17 Apr 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361667; cv=none; b=Auk+hBfhvX3dM6IEnZqd7nptRiV4OtcL10uwaOjI9p/7EvTvvAMnRt7vRmNThXqjiDp4P4MekjleF0Ql6f/hJFj4DAlDSvgHVFMq7wQ96B5jsLY8H5ASiLway56PpDJNuSsCf8rEo5jqI60Y68RqdkjyVravzAd/QFnyuQCIO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361667; c=relaxed/simple;
	bh=gpZTfbIevaHJ5+Z8umKWwCjSnmhnuPjDmTBIelsqBYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8g/0Atvg0nIULBBg8m/LFIPfKIaL8+Bi4n/oXwyCcKBQwDHNafdHPYVeLIdMDPd/LGXQIsxm4OJ7TphQaBKgEiew8uK6QY+6uZdMNAMxQH4bE4RRApajq6lAQJs9HPkZn8HFh1DYPl8HSvHzr0A/u+WSnassNDHZdmhOdtNQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpDkQabu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso7349683e87.3;
        Wed, 17 Apr 2024 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713361664; x=1713966464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31UwZLip/7vp9bqywqyJaToZec07jhJEOp3KesHBEFA=;
        b=gpDkQabuEK36E2UkdBgofTiq/9eRHxQFsfOBMHGC2k/ulG1tIIJd4OIkSsCLruCX6K
         uHyeKO/abCj7Wr26Eo0GTJh4hkcGFaXaOkiDILhp/C1LDvuUrt+hjyejDbjtxxZLULFi
         Xsf2Yre02rBwNMQHhWWi5I1TSmQ6lv6tZZrHuvrGJcQm4NONU1BE+YbLNzPinkHWdBNq
         La/rEmzTH933EH1Ln2ccuRcGKW5Rw4rirHMqu2YrQzCou+3V4tk7lL9mrceVZhsAp9A7
         4OIbBs+crBjgWSi26SiGSlrzZHhdwk0fzcrr21b+Nwu+Q7kw+RhnkSP6DdFqIcc+XPr+
         L66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713361664; x=1713966464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31UwZLip/7vp9bqywqyJaToZec07jhJEOp3KesHBEFA=;
        b=FMt19cUNkOMaUgoJUyT4zARo7OWCPs280FhHGn8GYnJbjPF3nRfEiw1PrieVYuA5Pa
         u0u4R5ENKv32/8OrfcgncM0ZeD+l8hqWcGDtMYMIsPuGe6it6wH378g7C1s+K34zXbmX
         aojf21PxtxerFlCer6dKgc6iSW3W40BpwF0VWLCVL6iJXxp1S9clCSRtD/Bz1HjysTSN
         lc/VMJLsd2ZVR5lx7f6c74r6U6w5H8kqIUzWqvYJgkrcmQLRRAaBa5pnbbVJXLs5j8A3
         NqQ6k5tM4CMF65GMHhWmQs9jgR4Mw3PezF0AayobJe3RoITCGUuManbub7feU7OYvdWi
         HsFw==
X-Forwarded-Encrypted: i=1; AJvYcCWwhd5LJhWlTM81rkvlbEUd5TywcyqcAQlv53eryHyOHQLExF1Z260HHqrPnXb+iDS6tWcPqbjRFU/0Ud+4pGgGuD3xNfuN5TXaB2kMTDPuIEosM7grzj1Fgu89PuFHfWRuzRmH
X-Gm-Message-State: AOJu0YycYLhdfJuWpU2IGkFXJTFj5fLUdmt85KLUTZsZuKpmP2SoqsRu
	Ii6ONt7gK0LwAfABGr7/vPMcUFGsYpzoWfLq7t4uZyrjC0GHfYDhZJDSWUvs0SIFklJU+LOFSXF
	GZHBpmDRUmETgxUMTk3ItRhydn44=
X-Google-Smtp-Source: AGHT+IEAX1xiV09HtVwXYVdPXyWsn82h03jK489MtJZoB34v9XAyk9dySxbXSZ5ymGXmAZpUvwhCagyGR3Gw2sDyXWY=
X-Received: by 2002:a05:6512:3b9d:b0:518:8fd9:7a55 with SMTP id
 g29-20020a0565123b9d00b005188fd97a55mr16401505lfv.35.1713361663709; Wed, 17
 Apr 2024 06:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYVHU8YdjJOi-mxD8H9oQ@mail.gmail.com>
 <20240416142428.GO2320920@kernel.org> <CAEkJfYPR-jeZoVz63b2UmvjgBOen7DDy8yyrojLckD9OT2XaiQ@mail.gmail.com>
 <Zh_POlLCe9sQaGpq@Laptop-X1>
In-Reply-To: <Zh_POlLCe9sQaGpq@Laptop-X1>
From: Sam Sun <samsun1006219@gmail.com>
Date: Wed, 17 Apr 2024 21:47:32 +0800
Message-ID: <CAEkJfYNaGCvOF7rAnoigE8T2ko4vdaCeAoyPTiiKkW00iHZM7g@mail.gmail.com>
Subject: Re: [PATCH net v3] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	j.vosburgh@gmail.com, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, 
	kuba@kernel.org, andy@greyhouse.net, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 9:31=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> On Wed, Apr 17, 2024 at 02:34:49PM +0800, Sam Sun wrote:
> > On Tue, Apr 16, 2024 at 10:24=E2=80=AFPM Simon Horman <horms@kernel.org=
> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 08:09:44PM +0800, Sam Sun wrote:
> > > > In function bond_option_arp_ip_targets_set(), if newval->string is =
an
> > > > empty string, newval->string+1 will point to the byte after the
> > > > string, causing an out-of-bound read.
> > > >
> > > > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> > > > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/810=
7
> > > > CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-=
1 04/01/2014
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> > > >  print_address_description mm/kasan/report.c:364 [inline]
> > > >  print_report+0xc1/0x5e0 mm/kasan/report.c:475
> > > >  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> > > >  strlen+0x7d/0xa0 lib/string.c:418
> > > >  __fortify_strlen include/linux/fortify-string.h:210 [inline]
> > > >  in4_pton+0xa3/0x3f0 net/core/utils.c:130
> > > >  bond_option_arp_ip_targets_set+0xc2/0x910
> > > > drivers/net/bonding/bond_options.c:1201
> > > >  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
> > > >  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.=
c:792
> > > >  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c=
:817
> > > >  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sys=
fs.c:156
> > > >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> > > >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> > > >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> > > >  call_write_iter include/linux/fs.h:2020 [inline]
> > > >  new_sync_write fs/read_write.c:491 [inline]
> > > >  vfs_write+0x96a/0xd80 fs/read_write.c:584
> > > >  ksys_write+0x122/0x250 fs/read_write.c:637
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > > > ---[ end trace ]---
> > > >
> > > > Fix it by adding a check of string length before using it.
> > > >
> > > > v2
> > > > According to Jay and Hangbin's opinion, remove target address in
> > > > netdev_err message since target is not initialized in error path an=
d
> > > > will not provide useful information.
> > > >
> > > > v3
> > > > According to Hangbin's opinion, change Fixes tag from 4fb0ef585eb2
> > > > ("bonding: convert arp_ip_target to use the new option API") to
> > > > f9de11a16594 ("bonding: add ip checks when store ip target").
> > > >
> > > > Fixes: f9de11a16594 ("bonding: add ip checks when store ip target")
> > > > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> > > > ---
> > >
> > > Hi Sam Sun,
> > >
> > > Some comments about the formatting of this submission:
> > >
> > > * The list of chances, (v2, v3, ...) should be below rather than
> > >   above the scissors ("---"), so it is not included when the patch
> > >   is applied.
> > >
> > > * Looking at git history, the patch prefix should probably be "bondin=
g:"
> > >
> > >         Subject: [PATCH net v3] bonding: ...
> > >
> > > * The diff seems to be a bit mangled, f.e. tabs seem to
> > >   have been translated into spaces. So it does not apply.
> > >   Which breaks automated testing. And for this reason
> > >   I am asking you to repost this patch.
> > >
> > >   git send-email, and b4, are two tools that can typically be used
> > >   to send patches in a way that this doesn't occur.
> > >
> > > ---
> > > pw-bot: changes-requested
> >
> > I sincerely apologize for not using git send-email. I tried to set up
> > the environment but it did not work. For some reason, I needed to use
> > a proxy to connect with my gmail account, but the proxy service
> > provider banned using their proxy to send email through smtp. Maybe I
> > need to rent a VPS and set up a working environment there, but it
> > would take time and I don't know for sure whether the VPS provider
> > would allow me to send email through smtp either.
> >
> > Could you or anyone please help me submit this patch? Sorry for
> > causing this trouble.
>
> Maybe you can try use another proxy service. If it not works, I can
> help you post the patch.
>
> Thanks
> Hangbin

I will try to set up git send-email environment as soon as I can, but
I am afraid not for this time. I am sorry that I have to bother you
this time. Appreciate for your help!

Thanks,
Yue

