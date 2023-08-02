Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0876C31C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjHBCwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjHBCwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F31FF3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690944698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gnB8l46sLYgDywYxEJydmMqQZMbbUuJEWlWKa6HccxY=;
        b=Ui1hKEkZSP8HwcrDBopu7HtVP/cJiIfvZUjXtrULIFEp8xUNrZb+6N0ra5zBLQ1yBI+dD7
        C2TYPn1A2vkc/7I9RSIKSpUG4KnEnS2igS53jy+VY0LGarEIeieklmuwC0ZoRrEFGh71OU
        FGsMNAg1B2lhX2daastBw5c3FKh9SVY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-vFy4ZldcNtW_gK3VzGLrag-1; Tue, 01 Aug 2023 22:51:37 -0400
X-MC-Unique: vFy4ZldcNtW_gK3VzGLrag-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9ba719605so68642441fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690944694; x=1691549494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnB8l46sLYgDywYxEJydmMqQZMbbUuJEWlWKa6HccxY=;
        b=Ix1qaOi63n2dsjDfD8vZ8Z9WgNw88ongKEEJQoLQfRItYgBLUbwP6DnrdjO8rDI5Gl
         TJD10Z2k6PfNUMY5DuAYpnrWJVu8iz3CVfbFbI7ggr+slAhh2u/8nanSwJD2HR+PufkA
         MN3BomQn7nLVHuywUdctBLoQPngOqNbJaxWFmIOROppSHTCykI8wF7hBmWI6R2vAKpVL
         vYlP97QLcXAsJgLiCmMGUYkyzIsZJUn3RDHlZd064fRHJe+uom4JUiw0XV7F7TJpQ6Yn
         CDGCHddMrmGa4nOBCSNSjm7Vz+a5GQArSCBHINdwsXEdpcBxWF2DMN0zHDBfcEfOuOb0
         UCvA==
X-Gm-Message-State: ABy/qLYLt6ynLOYBruJh6psOTKAo9Hj92DXZhJTZ8muHo9IVoyh7IJNm
        UovrnBSbsLrmEYgtcfYABhT8Lu5GUKc93LqISLbmlddpG/2a0KPbsuau5vLNRpu0AYvOwiN1J6B
        OPKGeTVn+zi/3lfQ0jm9xDM317pJ5LatXTccY4LAm0Ctu7RUrotfDuQ==
X-Received: by 2002:a2e:93d7:0:b0:2b9:48f1:b193 with SMTP id p23-20020a2e93d7000000b002b948f1b193mr3591046ljh.46.1690944694450;
        Tue, 01 Aug 2023 19:51:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGcsCsrj00r7RkBkqUnPfn4ZD12lA23g1iJmQi+QyRcoOo888/DfI6dipdzX+66ZNI4sSHRvzrgpwua7urDFeo=
X-Received: by 2002:a2e:93d7:0:b0:2b9:48f1:b193 with SMTP id
 p23-20020a2e93d7000000b002b948f1b193mr3591035ljh.46.1690944694091; Tue, 01
 Aug 2023 19:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230726190744.14143-1-dtatulea@nvidia.com> <20230726152258-mutt-send-email-mst@kernel.org>
 <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
 <20230727122633-mutt-send-email-mst@kernel.org> <b97484f15824c86f5cee4fe673794f17419bcb1b.camel@nvidia.com>
 <20230731050200-mutt-send-email-mst@kernel.org> <CACGkMEtiwNjq4pMVY-Yvgo3+DihMP5zO+q+HH-xAF+Xu_=gbHg@mail.gmail.com>
 <39c3be5dd59e67e7b5dd301100e96aa9428bc332.camel@nvidia.com>
In-Reply-To: <39c3be5dd59e67e7b5dd301100e96aa9428bc332.camel@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 2 Aug 2023 10:51:22 +0800
Message-ID: <CACGkMEueOXgjbr9Q0Tw5Bv-=YH9+5UR9jxttrf6hN-VRK9KtMg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        bhe <bhe@redhat.com>, eperezma <eperezma@redhat.com>,
        ruyang <ruyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 4:17=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Tue, 2023-08-01 at 11:59 +0800, Jason Wang wrote:
> > On Mon, Jul 31, 2023 at 5:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Jul 31, 2023 at 07:15:31AM +0000, Dragos Tatulea wrote:
> > > > On Thu, 2023-07-27 at 12:28 -0400, Michael S. Tsirkin wrote:
> > > > > On Thu, Jul 27, 2023 at 04:02:16PM +0000, Dragos Tatulea wrote:
> > > > > > On Wed, 2023-07-26 at 15:26 -0400, Michael S. Tsirkin wrote:
> > > > > > > On Wed, Jul 26, 2023 at 10:07:38PM +0300, Dragos Tatulea wrot=
e:
> > > > > > > > The ndev was accessed on shutdown without a check if it act=
ually
> > > > > > > > exists.
> > > > > > > > This triggered the crash pasted below. This patch simply ad=
ds a
> > > > > > > > check
> > > > > > > > before using ndev.
> > > > > > > >
> > > > > > > >  BUG: kernel NULL pointer dereference, address: 00000000000=
00300
> > > > > > > >  #PF: supervisor read access in kernel mode
> > > > > > > >  #PF: error_code(0x0000) - not-present page
> > > > > > > >  PGD 0 P4D 0
> > > > > > > >  Oops: 0000 [#1] SMP
> > > > > > > >  CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.5.0-
> > > > > > > > rc2_for_upstream_min_debug_2023_07_17_15_05 #1
> > > > > > > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-
> > > > > > > > 1.13.0-0-
> > > > > > > > gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > > > > >  RIP: 0010:mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > > > > > > >  RSP: 0018:ffff8881003bfdc0 EFLAGS: 00010286
> > > > > > > >  RAX: ffff888103befba0 RBX: ffff888109d28008 RCX: 000000000=
0000017
> > > > > > > >  RDX: 0000000000000001 RSI: 0000000000000212 RDI: ffff88810=
9d28000
> > > > > > > >  RBP: 0000000000000000 R08: 0000000d3a3a3882 R09: 000000000=
0000001
> > > > > > > >  R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810=
9d28000
> > > > > > > >  R13: ffff888109d28080 R14: 00000000fee1dead R15: 000000000=
0000000
> > > > > > > >  FS:  00007f4969e0be40(0000) GS:ffff88852c800000(0000)
> > > > > > > > knlGS:0000000000000000
> > > > > > > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > >  CR2: 0000000000000300 CR3: 00000001051cd006 CR4: 000000000=
0370eb0
> > > > > > > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> > > > > > > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> > > > > > > >  Call Trace:
> > > > > > > >   <TASK>
> > > > > > > >   ? __die+0x20/0x60
> > > > > > > >   ? page_fault_oops+0x14c/0x3c0
> > > > > > > >   ? exc_page_fault+0x75/0x140
> > > > > > > >   ? asm_exc_page_fault+0x22/0x30
> > > > > > > >   ? mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > > > > > > >   device_shutdown+0x13e/0x1e0
> > > > > > > >   kernel_restart+0x36/0x90
> > > > > > > >   __do_sys_reboot+0x141/0x210
> > > > > > > >   ? vfs_writev+0xcd/0x140
> > > > > > > >   ? handle_mm_fault+0x161/0x260
> > > > > > > >   ? do_writev+0x6b/0x110
> > > > > > > >   do_syscall_64+0x3d/0x90
> > > > > > > >   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > > > > > >  RIP: 0033:0x7f496990fb56
> > > > > > > >  RSP: 002b:00007fffc7bdde88 EFLAGS: 00000206 ORIG_RAX:
> > > > > > > > 00000000000000a9
> > > > > > > >  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f496=
990fb56
> > > > > > > >  RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffff=
ee1dead
> > > > > > > >  RBP: 00007fffc7bde1d0 R08: 0000000000000000 R09: 000000000=
0000000
> > > > > > > >  R10: 0000000000000000 R11: 0000000000000206 R12: 000000000=
0000000
> > > > > > > >  R13: 00007fffc7bddf10 R14: 0000000000000000 R15: 00007fffc=
7bde2b8
> > > > > > > >   </TASK>
> > > > > > > >  CR2: 0000000000000300
> > > > > > > >  ---[ end trace 0000000000000000 ]---
> > > > > > > >
> > > > > > > > Fixes: bc9a2b3e686e ("vdpa/mlx5: Support interrupt bypassin=
g")
> > > > > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
> > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > index 9138ef2fb2c8..e2e7ebd71798 100644
> > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > @@ -3556,7 +3556,8 @@ static void mlx5v_shutdown(struct
> > > > > > > > auxiliary_device
> > > > > > > > *auxdev)
> > > > > > > >         mgtdev =3D auxiliary_get_drvdata(auxdev);
> > > > > > > >         ndev =3D mgtdev->ndev;
> > > > > > > >
> > > > > > > > -       free_irqs(ndev);
> > > > > > > > +       if (ndev)
> > > > > > > > +               free_irqs(ndev);
> > > > > > > >  }
> > > > > > > >
> > > > > > >
> > > > > > > something I don't get:
> > > > > > > irqs are allocated in mlx5_vdpa_dev_add
> > > > > > > why are they not freed in mlx5_vdpa_dev_del?
> > > > > > >
> > > > > > That is a good point. I will try to find out. I also don't get =
why
> > > > > > free_irq
> > > > > > is
> > > > > > called in the vdpa dev .free op instead of mlx5_vdpa_dev_del. M=
aybe I
> > > > > > can
> > > > > > change
> > > > > > that in a different refactoring.
> > > > >
> > > > > as it is I have no idea whether e.g. ndev can change
> > > > > between these two call sites. that would make the check
> > > > > pointless.
> > > > >
> > > > > > > this is what's creating all this mess.
> > > > > > >
> > > > > > >
> > > > > > Not quite: mlx5_vdpa_dev_del (which is a .dev_del of for struct
> > > > > > vdpa_mgmtdev_ops) doesn't get called on shutdown. At least that=
's what
> > > > > > I
> > > > > > see. Or
> > > > > > am I missing something?
> > > > >
> > > > > and why do we care whether irqs are freed on shutdown?
> > > > >
> > > > Had to ask around a bit to find out the answer: there can be issues=
 with
> > > > kexec
> > > > IRQ allocation on some platforms. It is documented here [0] for mlx=
5_core.
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/net/ethernet/mellanox/mlx5/core/main.c#n2129
> > > >
> > > > Thanks,
> > > > Dragos
> > >
> > > It's quite weird.
> > >          * Some platforms requiring freeing the IRQ's in the shutdown
> > >          * flow. If they aren't freed they can't be allocated after
> > >          * kexec. There is no need to cleanup the mlx5_core software
> > >          * contexts.
> > >
> > > but most drivers don't have a shutdown callback how do they work then=
?
> > > do you know which platforms these are?
> >
> I don't. x86_64 is not one of them though. I will do some more digging ..=
.
>
> > There used to be bzs that requires virtio drivers to add a shutdown to
> > fix kexec:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2108406
> >
> I don't have access to this. What is it about?

This bug might be more accurate:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1820521

It's about the kexec guys (cced relevant people) wanting to add a
shutdown method for virito to fix potential kexec issues.

Thanks

>
> Thanks,
> Dragos
> > Thanks
> >
> > >
> > > I don't really know much about why shutdown callback is even necessar=
y.
> > > I guess this is to detect shutdown and do a faster cleanup than
> > > the slow, graceful removal, just cleaning hardware resources?
> > >
> > >
> > > --
> > > MST
> > >
> >
>

