Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB017E9602
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjKMEOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjKMEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:14:03 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154E010F0;
        Sun, 12 Nov 2023 20:14:00 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c83d37a492so15904871fa.3;
        Sun, 12 Nov 2023 20:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699848838; x=1700453638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0sxmqcbI9Lg4Pt8dSxwUwV8w8KVlrB+RKcE/Jgbh9s=;
        b=UnG5cYr17+yr/1gvYqSRsfdr7iPm4B5rN1BD9W68ZBej2elYGwLZN4FYPc/GZZckpP
         RX2vrDcpW+KazG6ZEHxHGJCutXjo/EKqJSZY7oac6rmW5bdLhbawMMUoCuZWOyLz/HJS
         ildp4wKm/x+Ok/C00GfJmtY+iQT3Mcf7fB4H8K94n623KDl6OoAzyCM2VjM1qxikuFzT
         iVWfscQbwqiQyenFtDQGeTJmBaPjLJf8zxpmeVXvDyNCfluMTnIzKJBZdbXKViAM8icI
         V4Kw6rJ8cjeFvsLM9cDM8Gy87RY5eH2hVkEmsgslY0rwA/VA4NUTtsZocZldBVvGo4AF
         FNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848838; x=1700453638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0sxmqcbI9Lg4Pt8dSxwUwV8w8KVlrB+RKcE/Jgbh9s=;
        b=P5xvnM8WLKLcuQL3KwWXDtZlqsS28GwQh0bXh3p6KScffN/uCpQUR8G9ELZ9hSxDM+
         d5NWGkB2Sd6LUd8f0FB8DUuVx+jaFS1LtNWIAdir6gWftiCdedRZQRgCrlgOXf1dhIiL
         Ylf8fcwAD570CexyBjs6YQkiOepGgJcjrIVLK1ptJiMGfRYHSnkzibeCHf1HndnRpAkH
         2I3s8AWBDaXWIzzPVUmxIwlwQkj5c+bJlZ+mcKvkwNX/Ix9PsYC6JFqxBHQUgcJOj5CQ
         1QeiZT5YJyR6ccscTjHdyiWcIQYEiX5Dsg2ePriE0yoipQwtJ954SYDfIDfDMiFQJIEa
         nZ/w==
X-Gm-Message-State: AOJu0YzUF/0mlv/x7fyYzTjjXe7ODxvXEtM/TFFjTgVTNeuQYutS1Fow
        bYookjUMh7kLwJNCQI5DNscjFMPENyInkgXoe08=
X-Google-Smtp-Source: AGHT+IGjmGCuIejxq5eSaQ84Q1yZXn1L1aDZ+nLpSSol3z/Ejb+fZqZOcjxP9abhpx/F6wdKi4hod3e4mpBttVxNsIE=
X-Received: by 2002:a2e:9183:0:b0:2c6:f768:fbd4 with SMTP id
 f3-20020a2e9183000000b002c6f768fbd4mr3231709ljg.53.1699848837915; Sun, 12 Nov
 2023 20:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20231110014605.2068231-1-yinghsu@chromium.org> <CAAa9mD3T-ey_3LQ8vsC60f1er4xMrELyJwJsY6QpG=b_xYRKgQ@mail.gmail.com>
In-Reply-To: <CAAa9mD3T-ey_3LQ8vsC60f1er4xMrELyJwJsY6QpG=b_xYRKgQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 12 Nov 2023 23:13:44 -0500
Message-ID: <CABBYNZJBx=oUy643gHc2ntCK2wRurDok17KcezM_o81JvcLbXQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] Bluetooth: Fix deadlock in vhci_send_frame
To:     Ying Hsu <yinghsu@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com,
        linux-kernel@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        johan.hedberg@gmail.com, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ying,

On Sun, Nov 12, 2023 at 10:52=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> wr=
ote:
>
> Hi Luiz and Arkadiusz,
>
> I appreciate the effort you put into ensuring the quality of the
> kernel, if it looks like the review might need more time, could we
> consider reverting commit 92d4abd66f70 ("Bluetooth: vhci: Fix race
> when opening vhci device") in the interim? This would help maintain
> stability until the new patch is approved.

Sorry for not responding before, I'm on vacation, I will try to
prioritize this one as soon as I'm back.

> Best regards,
> Ying
>
>
> On Fri, Nov 10, 2023 at 9:46=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> w=
rote:
> >
> > syzbot found a potential circular dependency leading to a deadlock:
> >     -> #3 (&hdev->req_lock){+.+.}-{3:3}:
> >     __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
> >     __mutex_lock kernel/locking/mutex.c:732 [inline]
> >     mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
> >     hci_dev_do_close+0x3f/0x9f net/bluetooth/hci_core.c:551
> >     hci_rfkill_set_block+0x130/0x1ac net/bluetooth/hci_core.c:935
> >     rfkill_set_block+0x1e6/0x3b8 net/rfkill/core.c:345
> >     rfkill_fop_write+0x2d8/0x672 net/rfkill/core.c:1274
> >     vfs_write+0x277/0xcf5 fs/read_write.c:594
> >     ksys_write+0x19b/0x2bd fs/read_write.c:650
> >     do_syscall_x64 arch/x86/entry/common.c:55 [inline]
> >     do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
> >     entry_SYSCALL_64_after_hwframe+0x61/0xcb
> >
> >     -> #2 (rfkill_global_mutex){+.+.}-{3:3}:
> >     __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
> >     __mutex_lock kernel/locking/mutex.c:732 [inline]
> >     mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
> >     rfkill_register+0x30/0x7e3 net/rfkill/core.c:1045
> >     hci_register_dev+0x48f/0x96d net/bluetooth/hci_core.c:2622
> >     __vhci_create_device drivers/bluetooth/hci_vhci.c:341 [inline]
> >     vhci_create_device+0x3ad/0x68f drivers/bluetooth/hci_vhci.c:374
> >     vhci_get_user drivers/bluetooth/hci_vhci.c:431 [inline]
> >     vhci_write+0x37b/0x429 drivers/bluetooth/hci_vhci.c:511
> >     call_write_iter include/linux/fs.h:2109 [inline]
> >     new_sync_write fs/read_write.c:509 [inline]
> >     vfs_write+0xaa8/0xcf5 fs/read_write.c:596
> >     ksys_write+0x19b/0x2bd fs/read_write.c:650
> >     do_syscall_x64 arch/x86/entry/common.c:55 [inline]
> >     do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
> >     entry_SYSCALL_64_after_hwframe+0x61/0xcb
> >
> >     -> #1 (&data->open_mutex){+.+.}-{3:3}:
> >     __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
> >     __mutex_lock kernel/locking/mutex.c:732 [inline]
> >     mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
> >     vhci_send_frame+0x68/0x9c drivers/bluetooth/hci_vhci.c:75
> >     hci_send_frame+0x1cc/0x2ff net/bluetooth/hci_core.c:2989
> >     hci_sched_acl_pkt net/bluetooth/hci_core.c:3498 [inline]
> >     hci_sched_acl net/bluetooth/hci_core.c:3583 [inline]
> >     hci_tx_work+0xb94/0x1a60 net/bluetooth/hci_core.c:3654
> >     process_one_work+0x901/0xfb8 kernel/workqueue.c:2310
> >     worker_thread+0xa67/0x1003 kernel/workqueue.c:2457
> >     kthread+0x36a/0x430 kernel/kthread.c:319
> >     ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
> >
> >     -> #0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
> >     check_prev_add kernel/locking/lockdep.c:3053 [inline]
> >     check_prevs_add kernel/locking/lockdep.c:3172 [inline]
> >     validate_chain kernel/locking/lockdep.c:3787 [inline]
> >     __lock_acquire+0x2d32/0x77fa kernel/locking/lockdep.c:5011
> >     lock_acquire+0x273/0x4d5 kernel/locking/lockdep.c:5622
> >     __flush_work+0xee/0x19f kernel/workqueue.c:3090
> >     hci_dev_close_sync+0x32f/0x1113 net/bluetooth/hci_sync.c:4352
> >     hci_dev_do_close+0x47/0x9f net/bluetooth/hci_core.c:553
> >     hci_rfkill_set_block+0x130/0x1ac net/bluetooth/hci_core.c:935
> >     rfkill_set_block+0x1e6/0x3b8 net/rfkill/core.c:345
> >     rfkill_fop_write+0x2d8/0x672 net/rfkill/core.c:1274
> >     vfs_write+0x277/0xcf5 fs/read_write.c:594
> >     ksys_write+0x19b/0x2bd fs/read_write.c:650
> >     do_syscall_x64 arch/x86/entry/common.c:55 [inline]
> >     do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
> >     entry_SYSCALL_64_after_hwframe+0x61/0xcb
> >
> > This change removes the need for acquiring the open_mutex in
> > vhci_send_frame, thus eliminating the potential deadlock while
> > maintaining the required packet ordering.
> >
> > Fixes: 92d4abd66f70 ("Bluetooth: vhci: Fix race when opening vhci devic=
e")
> > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > ---
> > Tested this commit using a C reproducer on qemu-x86_64.
> >
> >  drivers/bluetooth/hci_vhci.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.=
c
> > index f3892e9ce800..572d68d52965 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/module.h>
> >  #include <asm/unaligned.h>
> >
> > +#include <linux/atomic.h>
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> >  #include <linux/slab.h>
> > @@ -44,6 +45,7 @@ struct vhci_data {
> >         bool wakeup;
> >         __u16 msft_opcode;
> >         bool aosp_capable;
> > +       atomic_t initialized;
> >  };
> >
> >  static int vhci_open_dev(struct hci_dev *hdev)
> > @@ -75,11 +77,10 @@ static int vhci_send_frame(struct hci_dev *hdev, st=
ruct sk_buff *skb)
> >
> >         memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> >
> > -       mutex_lock(&data->open_mutex);
> >         skb_queue_tail(&data->readq, skb);
> > -       mutex_unlock(&data->open_mutex);
> >
> > -       wake_up_interruptible(&data->read_wait);
> > +       if (atomic_read(&data->initialized))
> > +               wake_up_interruptible(&data->read_wait);
> >         return 0;
> >  }
> >
> > @@ -464,7 +465,8 @@ static int __vhci_create_device(struct vhci_data *d=
ata, __u8 opcode)
> >         skb_put_u8(skb, 0xff);
> >         skb_put_u8(skb, opcode);
> >         put_unaligned_le16(hdev->id, skb_put(skb, 2));
> > -       skb_queue_tail(&data->readq, skb);
> > +       skb_queue_head(&data->readq, skb);
> > +       atomic_inc(&data->initialized);
> >
> >         wake_up_interruptible(&data->read_wait);
> >         return 0;
> > --
> > 2.43.0.rc0.421.g78406f8d94-goog
> >



--=20
Luiz Augusto von Dentz
