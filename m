Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8EC80C1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjLKH1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLKH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:26:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C8EEB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702279621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzl/uXMUGCBrEhgpFoMPCiMftRl1HpCdIgUDcqQab60=;
        b=GVj/yJFX40jUzl+kn4PlnKk7IzwhxTtOaN3olqXrkm1jqIFyLTkb+AgGrG2PdmxuLuaX7n
        QVVWAtvg9ktoIJ+mrBfVUnYEuBV6ParNngC+Ls8gKtldTf33USbgzIsHxM0sK3UDu4QBYY
        NBMp84HU7b5lJMdfUKGIFGBpIkECh6U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-eIkgzbTcN_6jROvXjnnZfg-1; Mon, 11 Dec 2023 02:26:59 -0500
X-MC-Unique: eIkgzbTcN_6jROvXjnnZfg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c6af2a80f0so2171847a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702279617; x=1702884417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzl/uXMUGCBrEhgpFoMPCiMftRl1HpCdIgUDcqQab60=;
        b=SGB/1odoET3xtoR12Uty2ErKhzv2m9JXLcYDcsFMkZuRQkUEhknLVSch7M+WnhMMuE
         O6j9KYfdofBN3dQGriwCT5HyugDaFsgAxIbNqY5geueg/5Wc/q3TAtrgys2QikQsg9nX
         2cF/EIinI6EnFNl3XUCFAhMc19mqH/JVgHQLfFvxM54BEyhXC3wCBpq98sPveKK6HMON
         i1CpSeNiE8WZGZYgeRq1ZLHn3ahTXdp5GTks++GTgHXsHZt8n3SvsAOKODEJdlym/K75
         67hx5l+Zws8v3528YeI5fwENLGbbCcWqrvG0ulImwe7EIdl/C6RldxKJhT816J4O9rAk
         2HWQ==
X-Gm-Message-State: AOJu0Yw2e23kRHjdZu0N0Obe6/Tlx7FLrbaK+GPxE8J6H5I2eRIJGe/d
        wCMURKJ8H9yArRNH74L9wK3IcYibLtqjgh0xufvK7Gl7uG9Rzae9A1gG6BmRfkUMAB2XYb33MDx
        ZDe7668vJ5l+6nFoeMSRbfOlr0Ahiqk7Nd+ZWhUwc8AzqQCzCNeU=
X-Received: by 2002:a05:6a20:2448:b0:18f:97c:ba1a with SMTP id t8-20020a056a20244800b0018f097cba1amr1702203pzc.116.1702279617593;
        Sun, 10 Dec 2023 23:26:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtMCW4/nYLJbNDFq92ZIWWhnreabLLEHm6wAXBKkoi7VBSJcNSpG3StpjW99D/ZfXuO/jDlH3z/lbO+PhUoEo=
X-Received: by 2002:a05:6a20:2448:b0:18f:97c:ba1a with SMTP id
 t8-20020a056a20244800b0018f097cba1amr1702190pzc.116.1702279617283; Sun, 10
 Dec 2023 23:26:57 -0800 (PST)
MIME-Version: 1.0
References: <46a997c2-5a38-4b60-b589-6073b1fac677@bytedance.com>
 <ZVyt4UU9+XxunIP7@DESKTOP-2CCOB1S.> <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com> <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org> <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org> <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231209053443-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Dec 2023 15:26:46 +0800
Message-ID: <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Tobias Huschle <huschle@linux.ibm.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 9, 2023 at 6:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Dec 08, 2023 at 12:41:38PM +0100, Tobias Huschle wrote:
> > On Fri, Dec 08, 2023 at 05:31:18AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Dec 08, 2023 at 10:24:16AM +0100, Tobias Huschle wrote:
> > > > On Thu, Dec 07, 2023 at 01:48:40AM -0500, Michael S. Tsirkin wrote:
> > > > > On Thu, Dec 07, 2023 at 07:22:12AM +0100, Tobias Huschle wrote:
> > > > > > 3. vhost looping endlessly, waiting for kworker to be scheduled
> > > > > >
> > > > > > I dug a little deeper on what the vhost is doing. I'm not an ex=
pert on
> > > > > > virtio whatsoever, so these are just educated guesses that mayb=
e
> > > > > > someone can verify/correct. Please bear with me probably messin=
g up
> > > > > > the terminology.
> > > > > >
> > > > > > - vhost is looping through available queues.
> > > > > > - vhost wants to wake up a kworker to process a found queue.
> > > > > > - kworker does something with that queue and terminates quickly=
.
> > > > > >
> > > > > > What I found by throwing in some very noisy trace statements wa=
s that,
> > > > > > if the kworker is not woken up, the vhost just keeps looping ac=
cross
> > > > > > all available queues (and seems to repeat itself). So it essent=
ially
> > > > > > relies on the scheduler to schedule the kworker fast enough. Ot=
herwise
> > > > > > it will just keep on looping until it is migrated off the CPU.
> > > > >
> > > > >
> > > > > Normally it takes the buffers off the queue and is done with it.
> > > > > I am guessing that at the same time guest is running on some othe=
r
> > > > > CPU and keeps adding available buffers?
> > > > >
> > > >
> > > > It seems to do just that, there are multiple other vhost instances
> > > > involved which might keep filling up thoses queues.
> > > >
> > >
> > > No vhost is ever only draining queues. Guest is filling them.
> > >
> > > > Unfortunately, this makes the problematic vhost instance to stay on
> > > > the CPU and prevents said kworker to get scheduled. The kworker is
> > > > explicitly woken up by vhost, so it wants it to do something.

It looks to me vhost doesn't use workqueue but the worker by itself.

> > > >
> > > > At this point it seems that there is an assumption about the schedu=
ler
> > > > in place which is no longer fulfilled by EEVDF. From the discussion=
 so
> > > > far, it seems like EEVDF does what is intended to do.
> > > >
> > > > Shouldn't there be a more explicit mechanism in use that allows the
> > > > kworker to be scheduled in favor of the vhost?

Vhost did a brunch of copy_from_user() which should trigger
__might_fault() so a __might_sleep() most of the case.

> > > >
> > > > It is also concerning that the vhost seems cannot be preempted by t=
he
> > > > scheduler while executing that loop.
> > >
> > >
> > > Which loop is that, exactly?
> >
> > The loop continously passes translate_desc in drivers/vhost/vhost.c
> > That's where I put the trace statements.
> >
> > The overall sequence seems to be (top to bottom):
> >
> > handle_rx
> > get_rx_bufs
> > vhost_get_vq_desc
> > vhost_get_avail_head
> > vhost_get_avail
> > __vhost_get_user_slow
> > translate_desc               << trace statement in here
> > vhost_iotlb_itree_first
>
> I wonder why do you keep missing cache and re-translating.
> Is pr_debug enabled for you? If not could you check if it
> outputs anything?
> Or you can tweak:
>
> #define vq_err(vq, fmt, ...) do {                                  \
>                 pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
>                 if ((vq)->error_ctx)                               \
>                                 eventfd_signal((vq)->error_ctx, 1);\
>         } while (0)
>
> to do pr_err if you prefer.
>
> > These functions show up as having increased overhead in perf.
> >
> > There are multiple loops going on in there.
> > Again the disclaimer though, I'm not familiar with that code at all.
>
>
> So there's a limit there: vhost_exceeds_weight should requeue work:
>
>         } while (likely(!vhost_exceeds_weight(vq, ++recv_pkts, total_len)=
));
>
> then we invoke scheduler each time before re-executing it:
>
>
> {
>         struct vhost_worker *worker =3D data;
>         struct vhost_work *work, *work_next;
>         struct llist_node *node;
>
>         node =3D llist_del_all(&worker->work_list);
>         if (node) {
>                 __set_current_state(TASK_RUNNING);
>
>                 node =3D llist_reverse_order(node);
>                 /* make sure flag is seen after deletion */
>                 smp_wmb();
>                 llist_for_each_entry_safe(work, work_next, node, node) {
>                         clear_bit(VHOST_WORK_QUEUED, &work->flags);
>                         kcov_remote_start_common(worker->kcov_handle);
>                         work->fn(work);
>                         kcov_remote_stop();
>                         cond_resched();
>                 }
>         }
>
>         return !!node;
> }
>
> These are the byte and packet limits:
>
> /* Max number of bytes transferred before requeueing the job.
>  * Using this limit prevents one virtqueue from starving others. */
> #define VHOST_NET_WEIGHT 0x80000
>
> /* Max number of packets transferred before requeueing the job.
>  * Using this limit prevents one virtqueue from starving others with smal=
l
>  * pkts.
>  */
> #define VHOST_NET_PKT_WEIGHT 256
>
>
> Try reducing the VHOST_NET_WEIGHT limit and see if that improves things a=
ny?

Or a dirty hack like cond_resched() in translate_desc().

Thanks


>
> --
> MST
>

