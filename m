Return-Path: <linux-kernel+bounces-148586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54E8A84C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E061F2303E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A1140387;
	Wed, 17 Apr 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAc7lTgo"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C913F015;
	Wed, 17 Apr 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360705; cv=none; b=OKBxRJhCo36BoOZwq28G7UFWlNkODHCqjTrn+Zvq3vLs30UdLSDC9xomzVCkvWxEzfMjvrFK93VZXjpaM/EGVcoboRZrHj/FJ3AADrhV3PXK6+PN1UEPnRzN9Pro6U8np031NogQMQcijIMUqHZiVYKVxbuuZB2buFQ9Yjigimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360705; c=relaxed/simple;
	bh=66/El0/uOF7QYP/hukPzBX8AIMmYUzAVH3hV29kzgok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1104MaUEE+qivHuWdsZTwlSeCcjXsTEU9mfxZxEuLY55M806fT0J3ijZq1kEXddKdcUETib9qRD8Lau2bAuGutKveLmHdob1bDzLXQQAuLjEpcjqLsfgAMS4NCZZQ0qXAz/Zg9eCwKjHQpRw8dkuZYTCw2kEeip6T2dn/69GKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAc7lTgo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f07de6ab93so121955b3a.2;
        Wed, 17 Apr 2024 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713360703; x=1713965503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WlrnyHegRT5J1YBSIe7DefZ1f0UH4CI8GR8ZYPGoYp4=;
        b=iAc7lTgoNWsiTBx8CBclFkfE1M3pjM2PU89aR706FWBcGiLYqmYuY4ditFA4NPUEDy
         V9WxcIvB/UO3+c/aiL66eKITxyXjpEtzSpV/8l9N+ev9VEoiVjykfvn8ZDXMs2iMdFJ8
         OxnyIvVFUHP/xHVqwJoRGmYQlGus1v8Pa58NmltGweUkMtB07t5MPekhZJoF0RWXZDD/
         QHvRV2ob5SEjSmzlUNpKClCuXkHAmaIXGQFb66Y8LkuV2ZkZSPJO2/zWluVZNdvUa0xa
         ATsZ3+Q/G9FRUciZxpHUSWcH5HWetaIuHhVaquaYscLxGf+r8RAl7Z2SuDpxwx3orBU8
         5Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713360703; x=1713965503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlrnyHegRT5J1YBSIe7DefZ1f0UH4CI8GR8ZYPGoYp4=;
        b=jVTu3QuuKntHJO0t8WMOLHJwGqfmZdqUNse4Fv88H6GgQGyBGV21/90b9Na0l1l28s
         AxPs/8L5PfNZuTikaobrBXr9flBKZyziW872f5qKpnAP3bn/gcohy45uIINLyfq/Dc7O
         oI2zbKB1kh4qsuo7XYVNcf3CTtS2hGzSdGwim6CLUL8hQT4BwiHoK7AKwretYvr2Ng4W
         +Vj0Yuwu7G+dtUbeXXDzcFQEQuFoW0HQrR2kW6FG2nXDpVUBbR6Xfme0yVa+ao+Hpfde
         TvFHgKGdANcyDCSlTCeQ9ghbclKpS6k7GL8X/Yt/1ZEO7zoReZeJNfZ4mYaUQ/xeJ/pm
         KEtg==
X-Forwarded-Encrypted: i=1; AJvYcCUmQ/6J7zI/YviSEYXcdJ5ysGu9uJp6w3fM2BPz/v79ZVxnxAQ6f73r/7QpZ59aWM1D9fY8syNHM8UP5KT3/k1ITr5+UXgb6I7RQaeD6EY5ZHhe1iRsRvFDs/NgFu7YTn5D6lpB
X-Gm-Message-State: AOJu0YzJRWsq7S8DBBePyzNm++yfJ3zZz5pdTNCQeB33+T1W9sww2kzV
	Pyaed3fIWLeuj9FqlmRYiUSy5/f1dsR7NlUMv1VJENcYklyobicp
X-Google-Smtp-Source: AGHT+IEbTcySkegsp610dit/42JCivGmr7J2sVIR3k12Rpc5Amk/NHRBn7HJ+qkWyTTriGtTcsHXDg==
X-Received: by 2002:aa7:8889:0:b0:6ed:21cb:13f3 with SMTP id z9-20020aa78889000000b006ed21cb13f3mr17969285pfe.17.1713360703255;
        Wed, 17 Apr 2024 06:31:43 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bm1-20020a056a00320100b006edcceffcb0sm10619772pfb.161.2024.04.17.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:31:42 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:31:38 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, j.vosburgh@gmail.com,
	Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
	kuba@kernel.org, andy@greyhouse.net, davem@davemloft.net
Subject: Re: [PATCH net v3] drivers/net/bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <Zh_POlLCe9sQaGpq@Laptop-X1>
References: <CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYVHU8YdjJOi-mxD8H9oQ@mail.gmail.com>
 <20240416142428.GO2320920@kernel.org>
 <CAEkJfYPR-jeZoVz63b2UmvjgBOen7DDy8yyrojLckD9OT2XaiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkJfYPR-jeZoVz63b2UmvjgBOen7DDy8yyrojLckD9OT2XaiQ@mail.gmail.com>

On Wed, Apr 17, 2024 at 02:34:49PM +0800, Sam Sun wrote:
> On Tue, Apr 16, 2024 at 10:24 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Tue, Apr 16, 2024 at 08:09:44PM +0800, Sam Sun wrote:
> > > In function bond_option_arp_ip_targets_set(), if newval->string is an
> > > empty string, newval->string+1 will point to the byte after the
> > > string, causing an out-of-bound read.
> > >
> > > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> > > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> > > CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> > >  print_address_description mm/kasan/report.c:364 [inline]
> > >  print_report+0xc1/0x5e0 mm/kasan/report.c:475
> > >  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> > >  strlen+0x7d/0xa0 lib/string.c:418
> > >  __fortify_strlen include/linux/fortify-string.h:210 [inline]
> > >  in4_pton+0xa3/0x3f0 net/core/utils.c:130
> > >  bond_option_arp_ip_targets_set+0xc2/0x910
> > > drivers/net/bonding/bond_options.c:1201
> > >  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
> > >  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
> > >  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
> > >  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
> > >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> > >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> > >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> > >  call_write_iter include/linux/fs.h:2020 [inline]
> > >  new_sync_write fs/read_write.c:491 [inline]
> > >  vfs_write+0x96a/0xd80 fs/read_write.c:584
> > >  ksys_write+0x122/0x250 fs/read_write.c:637
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > > ---[ end trace ]---
> > >
> > > Fix it by adding a check of string length before using it.
> > >
> > > v2
> > > According to Jay and Hangbin's opinion, remove target address in
> > > netdev_err message since target is not initialized in error path and
> > > will not provide useful information.
> > >
> > > v3
> > > According to Hangbin's opinion, change Fixes tag from 4fb0ef585eb2
> > > ("bonding: convert arp_ip_target to use the new option API") to
> > > f9de11a16594 ("bonding: add ip checks when store ip target").
> > >
> > > Fixes: f9de11a16594 ("bonding: add ip checks when store ip target")
> > > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> > > ---
> >
> > Hi Sam Sun,
> >
> > Some comments about the formatting of this submission:
> >
> > * The list of chances, (v2, v3, ...) should be below rather than
> >   above the scissors ("---"), so it is not included when the patch
> >   is applied.
> >
> > * Looking at git history, the patch prefix should probably be "bonding:"
> >
> >         Subject: [PATCH net v3] bonding: ...
> >
> > * The diff seems to be a bit mangled, f.e. tabs seem to
> >   have been translated into spaces. So it does not apply.
> >   Which breaks automated testing. And for this reason
> >   I am asking you to repost this patch.
> >
> >   git send-email, and b4, are two tools that can typically be used
> >   to send patches in a way that this doesn't occur.
> >
> > ---
> > pw-bot: changes-requested
> 
> I sincerely apologize for not using git send-email. I tried to set up
> the environment but it did not work. For some reason, I needed to use
> a proxy to connect with my gmail account, but the proxy service
> provider banned using their proxy to send email through smtp. Maybe I
> need to rent a VPS and set up a working environment there, but it
> would take time and I don't know for sure whether the VPS provider
> would allow me to send email through smtp either.
> 
> Could you or anyone please help me submit this patch? Sorry for
> causing this trouble.

Maybe you can try use another proxy service. If it not works, I can
help you post the patch.

Thanks
Hangbin

