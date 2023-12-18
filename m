Return-Path: <linux-kernel+bounces-3351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358BC816B59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94FCBB21A82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5D1B279;
	Mon, 18 Dec 2023 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT7+lcIk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEE19BCC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c9f559b82cso27624131fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702896082; x=1703500882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kabXGROfWSJocyHAan/aB6JGxykPaPjYqavx3rQXmbE=;
        b=cT7+lcIkSO+lwKMmfd9+D7XxgUR3IHFOxKO8ZO6phYYOBpDYM1JfpiOTMlU2c3t5fR
         2NxpcyvdeDpBLMVjigqHIqSxfTUHr8mO++fL/2VMIeu26DVpj3C3GNNZ20AD8P8XWwxR
         x9X1UWLhSZHq6gXKUuTGYmVcPiJWU3zMjEd9FQw8QULpbOaiW2zVLwq9csgdVOb90syb
         BUGPrwc+Z33hKE06ETlJRcmBx6CpgnL2rWLeZQQMNq3Fuu+O1Ihn4QxlS+PCNR/bJhPp
         PHnQHMaqnjWetv9nxHJGoJ97mdyFC31TB19W/fw9r0hvmZHdM4B3nbHofz4IJUWsW/0Z
         TzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702896082; x=1703500882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kabXGROfWSJocyHAan/aB6JGxykPaPjYqavx3rQXmbE=;
        b=tEKKOsurzM21twJScDGodpnFVx+vJtH51K4f/l8lsNstq9a7A8WiQySSzHNxL6SXxE
         8WFWccsT4hzFQS0+SWcNzT4VVYevY0XpbBJQHkUQOimftaz3GKHxiOHKFgCnx4gUJgI5
         wE5Xmwy8Da1CGb+Q6f27aFgdk/57iZZRsng3gFXAUvDtlcdA9S6Rznh0yrnQWIFmyN1D
         kSHi5o9BV9Z+cS8ml537D2tNRtR8IAd7OMPNd4hqNXAJCIZNGYj9A4YL4bVNxq0+Ik84
         jYtTJGfawykQKpBuIsOhB9lDizqnN/Z6Y6VAYV7iRliPo0HV+/YfX7jUKkW++oHo4ZHD
         lOBg==
X-Gm-Message-State: AOJu0Yw3a7uXe9th3kQcU315dYbfFvz8KpZaViVOaRBEXLjLcT+qQIQM
	vs4nIHRNCkTyOmoEKU9AGk0lp1yc4X6yqtpbGBA=
X-Google-Smtp-Source: AGHT+IGiyAaJxskQA50ell8K062yOX0m9VtEKQ7s3kTlZDkXY7gmBsv9ZVjFbRsiLYRnhjCc/VEmEax6p9+t5TjvEAI=
X-Received: by 2002:a05:651c:2220:b0:2cb:2cb1:6789 with SMTP id
 y32-20020a05651c222000b002cb2cb16789mr6340574ljq.25.1702896082050; Mon, 18
 Dec 2023 02:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218024403.1076134-1-chunyan.zhang@unisoc.com> <2023121830-proxy-washed-ae4d@gregkh>
In-Reply-To: <2023121830-proxy-washed-ae4d@gregkh>
From: jing xia <jing.xia.mail@gmail.com>
Date: Mon, 18 Dec 2023 18:41:09 +0800
Message-ID: <CAN=25QNcd3y+9VmRk_L7JYZTYD++bgZ=YizpdWncmNnfoDD1cA@mail.gmail.com>
Subject: Re: [PATCH] class: fix use-after-free in class_register()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Jing Xia <jing.xia@unisoc.com>, 
	Xuewen Yan <xuewen.yan@unisoc.com>, Ke Wang <ke.wang@unisoc.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 18, 2023 at 10:44:03AM +0800, Chunyan Zhang wrote:
> > From: Jing Xia <jing.xia@unisoc.com>
> >
> > The lock_class_key is still registered and can be found in
> > lock_keys_hash hlist after subsys_private is freed in error
> > handler path.A task who iterate over the lock_keys_hash
> > later may cause use-after-free.So fix that up and unregister
> > the lock_class_key before kfree(cp).
>
> What task iterates over all hashes?
>
> And can you put ' ' after your '.'?
>
> And how was this found?
>
Thanks for your comments. I'll add more information in the changelog.

On our platform, a driver fails to kset_register because of creating
duplicate filename '/class/xxx'.And we got serval kernel panic issues
about alignment fault on stability tests.All backtraces show that it is
manipulating the corrupted lock_keys_hash hlish when a workqueue is
created or released.

Here is one backtrace:

Unable to handle kernel paging request at virtual address ffffffc081480bae
 Mem abort info:
   ESR =3D 0x0000000096000021
   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
   SET =3D 0, FnV =3D 0
   EA =3D 0, S1PTW =3D 0
   FSC =3D 0x21: alignment fault
...
 Call trace:
  lockdep_register_key+0x128/0x22c
  alloc_workqueue+0x190/0x640
  loop_configure+0x2f0/0x560
  lo_ioctl+0x70c/0xf60
  blkdev_ioctl+0x290/0x88c
  __arm64_sys_ioctl+0xa8/0xe4

And we are aware of the fact that it might be a use-after-free issue.
So we enable Kasan and it gives a invalid-access bug report.

BUG: KASAN: invalid-access in lockdep_register_key+0x19c/0x1bc
Write of size 8 at addr 15ffff808b8c0368 by task modprobe/252
Pointer tag: [15], memory tag: [fe]

CPU: 7 PID: 252 Comm: modprobe Tainted: G        W
6.6.0-mainline-maybe-dirty #1

Call trace:
dump_backtrace+0x1b0/0x1e4
show_stack+0x2c/0x40
dump_stack_lvl+0xac/0xe0
print_report+0x18c/0x4d8
kasan_report+0xe8/0x148
__hwasan_store8_noabort+0x88/0x98
lockdep_register_key+0x19c/0x1bc
class_register+0x94/0x1ec
init_module+0xbc/0xf48 [rfkill]
do_one_initcall+0x17c/0x72c
do_init_module+0x19c/0x3f8
load_module+0x2300/0x2394
__arm64_sys_finit_module+0x350/0x4d8
invoke_syscall+0x88/0x1f0
el0_svc_common+0xe8/0x1c0
do_el0_svc+0x34/0x44
el0_svc+0x50/0xb8
el0t_64_sync_handler+0x68/0xbc
el0t_64_sync+0x19c/0x1a0

The buggy address belongs to the object at ffffff808b8c0000
which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 232 bytes to the right of
640-byte region [ffffff808b8c0000, ffffff808b8c0280)

The buggy address belongs to the physical page:
page:00000000918c4834 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x10b8c0
head:00000000918c4834 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:=
0
anon flags: 0x4000000000000840(slab|head|zone=3D1|kasantag=3D0x0)
page_type: 0xffffffff()
raw: 4000000000000840 80ffff8080002a00 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffffff808b8c0100: 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a
ffffff808b8c0200: 8a 8a 8a 8a 8a 8a 8a 8a fe fe fe fe fe fe fe fe
>ffffff808b8c0300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                                     ^

> >
> > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>
> What commit id does this fix?
>
> Also note in the changelog that this only can happen if lockdep is
> enabled, which is not true for normal systems.
>
I'll fix it on v1.Thanks.

> thanks,
>
> greg k-h

