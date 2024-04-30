Return-Path: <linux-kernel+bounces-163317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD3F8B695B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625EE2843F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB912E6A;
	Tue, 30 Apr 2024 04:13:26 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2411187;
	Tue, 30 Apr 2024 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714450406; cv=none; b=ioYgqS9Q8V97o/pZS6P/9j3LH8ide59AcDjEc29XH97zg24B3/6Ez5fePo6zACr39ONNO7kgiPofTHcIXpDuRbQLJzXOFFixTAzqRor1TYzXKwmM8ni8cwD70eGuxQLxPX9tN4qJivf5ad3GcFOTnj8z5m0BARXjNFs5/wEsbqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714450406; c=relaxed/simple;
	bh=7DPPZOXDxPCk/qrC0pfVk6nR5rIqIkQn+inB+QgugBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca4TA1fWAb9wSWJVEEX85leUBZdhOPPAUR98YjxpZodJuIofkyD7YepY9KKLEwH+8rpA9OllH+IT8WWx2GvAVD2CI/RZK+dg+TuQdO8rFhiWwlom4n/4v5dBaW3U6YcqkSbDSE7gQzDSAwNyutYFf3+xpXAC+Q0ZnkkaJpJdhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5196c755e82so6390052e87.0;
        Mon, 29 Apr 2024 21:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714450402; x=1715055202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVULtxszzoElA5Sf7na3LylLLyWGjOEmaopCW13NXp8=;
        b=aZnScXK9nNVhKJVKKL9p1kG80J6xJQ3T0CsfBUmTkhVQYgVvSWIpVqovvBelWnC8PK
         nJiqaKgl2RGQHiDnqTwZnQgUqVYVka4U9e1KwFMPVQaJUWU1DfpH89ikdgw2MXXhJ5Vv
         025TF4RPHga3VSMieYDZmPteRaRBZDWnNtCQ/z4v24saKTZzopgTGdBkV/GKob5RIHoW
         jQk1sUGeIcTcBTQXFrppK7ahnDu3/8Yz/KICCCy3NU5OKBJSIFCfQbLFBDPvwG+Z4vyU
         vCmmErrJWLkv4fMLUvVXtkNLj1uB8Rj/XC3vmTwKZ71QX9J7DkLh70ZrXzauBP+W4AiR
         gF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpM0GOK8bDMj2u214h4Tr060TgRhYFs8F/pey2FF9KkDeqqTJgT1FMe+QdqmhBIUJ8RR8c56o9GMTgDQjlBkpIaRsWlSLmftkDw9u/N25iWjBbFyYF4sHGvkCzFgj+m8vaDXD5O5RD7sS2xxqY
X-Gm-Message-State: AOJu0YwkvCP57BSm2V82xuPo77nN+4QbZiDgB5HiBzMT4s2Bu94VGTUB
	O9Iu1DcK6LvJC86+L2CHrKBGmlrQVY/OXGtVX244C3471tkT58D2f75WNECA5aU=
X-Google-Smtp-Source: AGHT+IECPyP20GFUeSwH3n8dW6P+5dCHwpaAM9iGBFWHHjKl1gJahnbVx37LHtf7PGIJXhNksHuMfw==
X-Received: by 2002:a05:6512:20c8:b0:518:9d14:34c with SMTP id u8-20020a05651220c800b005189d14034cmr7349686lfr.12.1714450401638;
        Mon, 29 Apr 2024 21:13:21 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id s24-20020a197718000000b0051c00cb891esm2118306lfc.151.2024.04.29.21.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 21:13:21 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51abf1a9332so7104365e87.3;
        Mon, 29 Apr 2024 21:13:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYB0GCnGAJl75EDtskgphZzYPhpMC4/Liok4y8G4FW1YQnNEm7rbJEbRMw2ax7uROyK9+lgz1/dHW0m6NW/b9Dy4pkcWI3vCYyMYmQ9yxQI1ClaMzeH/8nH1znHaZCU/T5V3+g+ByT1zIaRVNE
X-Received: by 2002:a19:435c:0:b0:516:d002:47cb with SMTP id
 m28-20020a19435c000000b00516d00247cbmr7011005lfj.43.1714450401036; Mon, 29
 Apr 2024 21:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427174333.457156-1-iam@sung-woo.kim> <CABBYNZL4Fc2J6HtEJT9Rr6tzntGv3hc-LxM+5X+sN8V5Z0eVRg@mail.gmail.com>
In-Reply-To: <CABBYNZL4Fc2J6HtEJT9Rr6tzntGv3hc-LxM+5X+sN8V5Z0eVRg@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 30 Apr 2024 00:13:05 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+0itmZvOirtyhZ1eQ1aTm8Gb1GO+BH4nsxjZDAt7gw+w@mail.gmail.com>
Message-ID: <CAJNyHp+0itmZvOirtyhZ1eQ1aTm8Gb1GO+BH4nsxjZDAt7gw+w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: daveti@purdue.edu, dan.carpenter@linaro.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Apr 29, 2024 at 1:03=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Kim,
>
> On Sat, Apr 27, 2024 at 1:44=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wr=
ote:
> >
> > Add an hold and lock the channel at l2cap_connect() to avoid use after =
free.
> > Also make the l2cap_connect() return type void. Nothing is using the
> > returned value but it is ugly to return a potentially freed pointer.
> > Making i void will help with backports because earlier kernels did use
> > the return value. Now the compile will break for kernels where this
> > patch is not a complete fix.
> >
> > Thank you for your help, Dan.
> >
> > Call stack summary:
> >
> > [use]
> > l2cap_bredr_sig_cmd
> >   l2cap_connect
> >   =E2=94=8C mutex_lock(&conn->chan_lock);
> >   =E2=94=82 chan =3D pchan->ops->new_connection(pchan); <- alloc chan
> >   =E2=94=82 __l2cap_chan_add(conn, chan);
> >   =E2=94=82   l2cap_chan_hold(chan);
> >   =E2=94=82   list_add(&chan->list, &conn->chan_l);   ... (1)
> >   =E2=94=94 mutex_unlock(&conn->chan_lock);
> >     chan->conf_state              ... (4) <- use after free
> >
> > [free]
> > l2cap_conn_del
> > =E2=94=8C mutex_lock(&conn->chan_lock);
> > =E2=94=82 foreach chan in conn->chan_l:            ... (2)
> > =E2=94=82   l2cap_chan_put(chan);
> > =E2=94=82     l2cap_chan_destroy
> > =E2=94=82       kfree(chan)               ... (3) <- chan freed
> > =E2=94=94 mutex_unlock(&conn->chan_lock);
>
> Sounds like we didn't even respond so I do wonder why we are releasing
> the conn->chan_lock.
>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux=
/instrumented.h:68 [inline]
> > BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops=
/instrumented-non-atomic.h:141 [inline]
> > BUG: KASAN: slab-use-after-free in l2cap_connect+0xa67/0x11a0 net/bluet=
ooth/l2cap_core.c:4260
> > Read of size 8 at addr ffff88810bf040a0 by task kworker/u3:1/311
> >
> > CPU: 0 PID: 311 Comm: kworker/u3:1 Not tainted 6.8.0+ #61
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: hci0 hci_rx_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x85/0xb0 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x18f/0x560 mm/kasan/report.c:488
> >  kasan_report+0xd7/0x110 mm/kasan/report.c:601
> >  kasan_check_range+0x262/0x2f0 mm/kasan/generic.c:189
> >  __kasan_check_read+0x15/0x20 mm/kasan/shadow.c:31
> >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> >  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [in=
line]
> >  l2cap_connect+0xa67/0x11a0 net/bluetooth/l2cap_core.c:4260
> >  l2cap_bredr_sig_cmd+0x17fe/0x9a70
> >  l2cap_sig_channel net/bluetooth/l2cap_core.c:6539 [inline]
> >  l2cap_recv_frame+0x82e/0x86a0 net/bluetooth/l2cap_core.c:7818
> >  l2cap_recv_acldata+0x379/0xbe0 net/bluetooth/l2cap_core.c:8536
> >  hci_acldata_packet net/bluetooth/hci_core.c:3876 [inline]
> >  hci_rx_work+0x64b/0xcb0 net/bluetooth/hci_core.c:4111
> >  process_one_work kernel/workqueue.c:2633 [inline]
> >  process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
> >  worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
> >  kthread+0x2a9/0x340 kernel/kthread.c:388
> >  ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
> >  </TASK>
> >
> > Allocated by task 311:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x30/0x70 mm/kasan/common.c:68
> >  kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:575
> >  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> >  __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
> >  kasan_kmalloc include/linux/kasan.h:211 [inline]
> >  kmalloc_trace+0x1c9/0x390 mm/slub.c:4012
> >  kmalloc include/linux/slab.h:590 [inline]
> >  kzalloc include/linux/slab.h:711 [inline]
> >  l2cap_chan_create+0x59/0xc80 net/bluetooth/l2cap_core.c:466
> >  l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1849 [inline]
> >  l2cap_sock_new_connection_cb+0x14d/0x2a0 net/bluetooth/l2cap_sock.c:14=
57
> >  l2cap_connect+0x329/0x11a0 net/bluetooth/l2cap_core.c:4176
> >  l2cap_bredr_sig_cmd+0x17fe/0x9a70
> >  l2cap_sig_channel net/bluetooth/l2cap_core.c:6539 [inline]
> >  l2cap_recv_frame+0x82e/0x86a0 net/bluetooth/l2cap_core.c:7818
> >  l2cap_recv_acldata+0x379/0xbe0 net/bluetooth/l2cap_core.c:8536
> >  hci_acldata_packet net/bluetooth/hci_core.c:3876 [inline]
> >  hci_rx_work+0x64b/0xcb0 net/bluetooth/hci_core.c:4111
> >  process_one_work kernel/workqueue.c:2633 [inline]
> >  process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
> >  worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
> >  kthread+0x2a9/0x340 kernel/kthread.c:388
> >  ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
> >
> > Freed by task 66:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x30/0x70 mm/kasan/common.c:68
> >  kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:589
> >  poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
> >  __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
> >  kasan_slab_free include/linux/kasan.h:184 [inline]
> >  slab_free_hook mm/slub.c:2121 [inline]
> >  slab_free mm/slub.c:4299 [inline]
> >  kfree+0x106/0x2e0 mm/slub.c:4409
> >  l2cap_chan_destroy net/bluetooth/l2cap_core.c:509 [inline]
> >  kref_put include/linux/kref.h:65 [inline]
> >  l2cap_chan_put+0x1e7/0x2b0 net/bluetooth/l2cap_core.c:533
> >  l2cap_conn_del+0x38e/0x5f0 net/bluetooth/l2cap_core.c:1929
> >  l2cap_connect_cfm+0xc2/0x11e0 net/bluetooth/l2cap_core.c:8254
> >  hci_connect_cfm include/net/bluetooth/hci_core.h:1986 [inline]
> >  hci_conn_failed+0x202/0x370 net/bluetooth/hci_conn.c:1289
> >  hci_abort_conn_sync+0x913/0xae0 net/bluetooth/hci_sync.c:5359
> >  abort_conn_sync+0xda/0x110 net/bluetooth/hci_conn.c:2988
> >  hci_cmd_sync_work+0x20d/0x3e0 net/bluetooth/hci_sync.c:306
> >  process_one_work kernel/workqueue.c:2633 [inline]
> >  process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
> >  worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
> >  kthread+0x2a9/0x340 kernel/kthread.c:388
> >  ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
> >
> > The buggy address belongs to the object at ffff88810bf04000
> >  which belongs to the cache kmalloc-1k of size 1024
> > The buggy address is located 160 bytes inside of
> >  freed 1024-byte region [ffff88810bf04000, ffff88810bf04400)
> >
> > The buggy address belongs to the physical page:
> > page:00000000567b7faa refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x10bf04
> > head:00000000567b7faa order:2 entire_mapcount:0 nr_pages_mapped:0 pinco=
unt:0
> > anon flags: 0x17ffffc0000840(slab|head|node=3D0|zone=3D2|lastcpupid=3D0=
x1fffff)
> > page_type: 0xffffffff()
> > raw: 0017ffffc0000840 ffff888100041dc0 0000000000000000 000000000000000=
1
> > raw: 0000000000000000 0000000080080008 00000001ffffffff 000000000000000=
0
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff88810bf03f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff88810bf04000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff88810bf04080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                ^
> >  ffff88810bf04100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff88810bf04180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: 73ffa904b782 ("Bluetooth: Move conf_{req,rsp} stuff to struct l2=
cap_chan")
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > V1 -> V2:
> > Make l2cap_connect() return void.
> > Fix a wrong stack trace attached.
> >
> >  net/bluetooth/l2cap_core.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 84fc70862..e7c18267c 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3902,7 +3902,7 @@ static inline int l2cap_command_rej(struct l2cap_=
conn *conn,
> >         return 0;
> >  }
> >
> > -static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
> > +static void l2cap_connect(struct l2cap_conn *conn,
> >                                         struct l2cap_cmd_hdr *cmd,
> >                                         u8 *data, u8 rsp_code, u8 amp_i=
d)
> >  {
> > @@ -3953,6 +3953,9 @@ static struct l2cap_chan *l2cap_connect(struct l2=
cap_conn *conn,
> >         if (!chan)
> >                 goto response;
> >
> > +       l2cap_chan_hold(chan);
> > +       l2cap_chan_lock(chan);
> > +
> >         /* For certain devices (ex: HID mouse), support for authenticat=
ion,
> >          * pairing and bonding is optional. For such devices, inorder t=
o avoid
> >          * the ACL alive for too long after L2CAP disconnection, reset =
the ACL
> > @@ -4041,7 +4044,10 @@ static struct l2cap_chan *l2cap_connect(struct l=
2cap_conn *conn,
> >                 chan->num_conf_req++;
> >         }
> >
> > -       return chan;
> > +       if (chan) {
> > +               l2cap_chan_unlock(chan);
> > +               l2cap_chan_put(chan);
> > +       }
> >  }
> >
> >  static int l2cap_connect_req(struct l2cap_conn *conn,
> > --
> > 2.34.1
> >
>
> How about we do something like:
>
> https://gist.github.com/Vudentz/c0c09ca0eff64a32ca50b1a6eb41295d

Looks awesome to me. I'll send a v3 patch soon.

>
> --
> Luiz Augusto von Dentz
>

