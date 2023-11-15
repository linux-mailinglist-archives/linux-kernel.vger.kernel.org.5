Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1FA7ECB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjKOTWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjKOTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:22:08 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDA9A4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:22:05 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41eae4ebf61so174131cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700076124; x=1700680924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVb5W/1ykgcPuZJWIxg+rdppxH8eWqp/RkGKjVY9a8A=;
        b=I00XZR73srW1kkDU6tVtEQ6i8btQ4h+Mx6hNr4tKEe93Cz1BdeSPUSIYcsN4FCQ/6D
         lAmJDi/Z+kxn8pEeIljyRcwtq0HJf8aqS2ONO6jZhkWvEvPeEfsiB1tSvUYj2R+OLtNt
         6FWF7h9Y0NZ3+zktfzXgUfspCmBS+kyS0ys9TWMTgiMcITYBz6GLgJOL1+m15qD45eIz
         kG5QInOmp1+ME29+5vA8XhKP1xHDLaoY9RrtMHGxNgu5RxPjIqWXuWCOPTOIgC8erhdc
         vF+BWWQVOeossUfN3QQpO85LPExK8Pe+eNOmnnQs7fWKxolQViX0/u2tpwV0seYl+9og
         vVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700076124; x=1700680924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVb5W/1ykgcPuZJWIxg+rdppxH8eWqp/RkGKjVY9a8A=;
        b=ixxMWdgdxzDIUhlqdO3RgX+0VCYzxOEDFMyUM/ZxvxT+Z34ahnQmMKHfQkuf+2VBsC
         SNs6hsGMsSQNdxkKrAscMEdlFM2Wh2Kh6enOYhJoozQVg3ZebVrxY5zNvouO1eLyKP0J
         vSXrmX0p/KmuKsQREyUMJfxFgtw5VoYtlf30rpvK5IuknYYvvNvcjO1HqiJ+jnhqZv8H
         ZETxXxYHPFGgJuB7wkztwX2sJ2xOyjqYqn+WDSIUWbUc+Tmc1KmpuuRkpcUEup36dUBz
         DCMFvMuh9DPfUZg4ck96RnT+11FTjGCgbhd93ytflLOtQqgeG5ZRPnJwkJAHCLRSWEwq
         8ooQ==
X-Gm-Message-State: AOJu0Yy8u+dQNHeSaK45REsHLjkkfOqZtRSXLcIL2FTJNATIJQyCJYwn
        xDxXlEhNqmxIhFy1ppM6K8eDG4124ZMsSslligTtjA==
X-Google-Smtp-Source: AGHT+IE/Uzv7uLPhimfHDicm/C4KHNQJqKyrjXYg8WfoewFPhALm305YuLmbFGXkfMcRGxhRypZjMcsUoS9BzOed6/4=
X-Received: by 2002:ac8:4e53:0:b0:41b:774b:b1a2 with SMTP id
 e19-20020ac84e53000000b0041b774bb1a2mr7456363qtw.22.1700076124662; Wed, 15
 Nov 2023 11:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20231115185439.2616073-1-yzhong@purestorage.com> <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
In-Reply-To: <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
From:   Yuanyuan Zhong <yzhong@purestorage.com>
Date:   Wed, 15 Nov 2023 11:21:53 -0800
Message-ID: <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:02=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 11/15/23 11:54 AM, Yuanyuan Zhong wrote:
> > The head->effects stores a pointer to the controller's Command Sets
> > Supported and Effects log. When the namespace head is shared by multipl=
e
> > controllers, if the particular controller is removed, dereferencing
> > head->effects causes use-after-free:
> >
> > [  227.820066] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  227.820069] BUG: KFENCE: use-after-free read in nvme_command_effects=
+0x1f/0x90 [nvme_core]
> >
> > [  227.820091] Use-after-free read at 0x00000000c02dadcf (in kfence-#0)=
:
> > [  227.820094]  nvme_command_effects+0x1f/0x90 [nvme_core]
> > [  227.820107]  nvme_passthru_start+0x19/0x80 [nvme_core]
> > [  227.820121]  nvme_submit_user_cmd+0xc7/0x170 [nvme_core]
> > [  227.820136]  nvme_user_cmd.constprop.16+0x152/0x1d0 [nvme_core]
> > [  227.820149]  nvme_ns_head_ioctl+0x92/0x140 [nvme_core]
> > [  227.820162]  blkdev_ioctl+0x1c5/0x280
> > [  227.820169]  __x64_sys_ioctl+0x93/0xd0
> > [  227.820174]  do_syscall_64+0x45/0xf0
> > [  227.820177]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > [  227.820182] kfence-#0: 0x000000000fac1d5d-0x00000000a28a73c3, size=
=3D4096, cache=3Dkmalloc-4k
> >
> > [  227.820185] allocated by task 2559 on cpu 3 at 188.703118s:
> > [  227.820233]  __kmem_cache_alloc_node+0x3c9/0x410
> > [  227.820236]  kmalloc_trace+0x2a/0xa0
> > [  227.820238]  nvme_get_effects_log+0x68/0xd0 [nvme_core]
> > [  227.820251]  nvme_init_identify+0x5ef/0x640 [nvme_core]
> > [  227.820263]  nvme_init_ctrl_finish+0x8d/0x250 [nvme_core]
> > [  227.820275]  nvme_tcp_setup_ctrl+0x1ce/0x710 [nvme_tcp]
> > [  227.820281]  nvme_tcp_create_ctrl+0x359/0x450 [nvme_tcp]
> > [  227.820286]  nvmf_dev_write+0x203/0x3b0 [nvme_fabrics]
> > [  227.820292]  vfs_write+0xd2/0x3d0
> > [  227.820294]  ksys_write+0x5d/0xd0
> > [  227.820297]  do_syscall_64+0x45/0xf0
> > [  227.820298]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > [  227.820302] freed by task 2521 on cpu 28 at 220.115945s:
> > [  227.820329]  nvme_free_ctrl+0xa6/0x260 [nvme_core]
> > [  227.820342]  device_release+0x37/0x90
> > [  227.820345]  kobject_release+0x57/0x120
> > [  227.820347]  nvme_sysfs_delete+0x39/0x50 [nvme_core]
> > [  227.820360]  kernfs_fop_write_iter+0x144/0x1e0
> > [  227.820362]  vfs_write+0x25f/0x3d0
> > [  227.820364]  ksys_write+0x5d/0xd0
> > [  227.820366]  do_syscall_64+0x45/0xf0
> > [  227.820368]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > Fix this by removing head->effects. Use the Commands Supported and Effe=
cts log
> > in ctrl->cels directly.
> >
> > Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported=
 and Effects log pages")
> > Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
> > Reviewed-by: Randy Jennings <randyj@purestorage.com>
> > Reviewed-by: Hamilton Coutinho <hcoutinho@purestorage.com>
> > ---
> >  drivers/nvme/host/core.c | 17 ++++++++---------
> >  drivers/nvme/host/nvme.h |  1 -
> >  2 files changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 88b54cdcbd68..14fdc2de3a75 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1085,7 +1085,9 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns, u8 opcode)
> >       u32 effects =3D 0;
> >
> >       if (ns) {
> > -             effects =3D le32_to_cpu(ns->head->effects->iocs[opcode]);
> > +             struct nvme_effects_log *cel =3D xa_load(&ctrl->cels, ns-=
>head->ids.csi);
> > +
> > +             effects =3D le32_to_cpu(cel->iocs[opcode]);
> >               if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS=
_LBCC))
> >                       dev_warn_once(ctrl->device,
> >                               "IO command:%02x has unusual effects:%08x=
\n",
>
> This is in the hot path for passthrough, can't we simply reload
> ->effects when we need?

Do you mean something like this? If not, can you please elaborate
"when we need"?
-               struct nvme_effects_log *cel =3D xa_load(&ctrl->cels,
ns->head->ids.csi);
+               struct nvme_effects_log *cel =3D (ns->head->ids.csi =3D=3D
NVME_CSI_NVM) ?
+                       ctrl->effects : xa_load(&ctrl->cels, ns->head->ids.=
csi);
Will it be good to change ctrl->effects to ctrl->effects[3] for
already defined CSI?


>
> --
> Jens Axboe
>


--
Regards,
Yuanyuan Zhong
