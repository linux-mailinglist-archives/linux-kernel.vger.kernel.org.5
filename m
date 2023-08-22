Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD04783FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjHVLlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjHVLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:41:15 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33252E42
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:40:51 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-78a5384a5daso1108814241.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692704392; x=1693309192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j1aCBRh/rUIJGCNyn9wEUPswtAnpgmC7dLFjlkxn24=;
        b=uay++LqNgu8C0ICdkRp8h4Q0rHFgc/niD3x1zEZU8vSVSMj+KkHozvAThsrY/P8mda
         QqMo5sfRStgIxGL4F8UzCovpJv/g6MqWbC+81zheuo9/Irdg1kg3F0wE/kfSkcmy0Opr
         XW5lhiODPSQ09gK+AV3EfMnmy6QuVU4PzrZGy0GufbIDX7uGhBTDfR6enMDiPZHjDbVk
         BGyl7HUMGTxAVFjWqsD8txljQv8W50Voj2FQ57FX+YfGdGF+2Ilh3BipxXwZW7WSWvdF
         K2gHxP+HbyNPMBG1idlblt+Hv/npbCD29pyI6GPj2E9/SzyLLWa5hE/BzSO534EMRqDl
         64qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692704392; x=1693309192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j1aCBRh/rUIJGCNyn9wEUPswtAnpgmC7dLFjlkxn24=;
        b=EoHxOBGrZwU/4Ti99KaXRFMKqAKFASnVaRKKJn7E4VZRU9SWpOK4DMUdPcL/PbYcYd
         vrs+rFcSmOFVXlYzBcEV2HRaiB7sBCAPYc+VpNcxU7IPKW0+IIeHios5Es6b48CJOsia
         CioTN4VAotgt+CaMTDvPsiVbAScN6lw8zvEPAYtW59kX3E+aG1FxuDR0uvsHPKbVjz6N
         H8GHscAj3nL7GwUJelL6iluvzmhJIKIEkMTKfABMh0kgXRBJ1O3WfMGHUwAfGt/uEqtK
         w5jplWvWhRDb035+d+dJ7xbN94uIiHKKHkKc9Jkk/8R7oyv9/ltDOhV6eObZgsRtIuWA
         fa3A==
X-Gm-Message-State: AOJu0YzjRzRbDRilxOj33lrU/zY9s2mrn1dBb6poE7dmBCx+FE8ukrOv
        FLBoLrnRrOfRvQH2tHFUVlYaxCu/helf750zNPgEUSsnGY+tkfM04/Y=
X-Google-Smtp-Source: AGHT+IGdfbfQj4OCnObBKU87lQIHB+FtzbsniOm537n6273eDJP7aRHXKkfMjT9RSrwtsW/n7a7wpTB/PjjkEVDjx50=
X-Received: by 2002:a67:e9d1:0:b0:443:7ab8:b5d7 with SMTP id
 q17-20020a67e9d1000000b004437ab8b5d7mr4440246vso.14.1692704391607; Tue, 22
 Aug 2023 04:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230803123515.4018838-1-jens.wiklander@linaro.org>
 <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
 <CAHUa44ET3Oqc4Yq8E4ouAjn5dF9ygxoXyWh0sjFF_vPoooxrnA@mail.gmail.com>
 <CAHUa44HpkxDPgdh1B_bFOVPSOETk3F_ZicdnhmuVOux+5fd7sA@mail.gmail.com>
 <CAFA6WYMdROqkNbfbOkm22AYR1vnNa83dttf-4rF6pp1dZDym3Q@mail.gmail.com>
 <CAHUa44HtKXVFi88u-rCBKg5i64nGvfq7Cmg10w-cgEcP_fjoJw@mail.gmail.com>
 <CAFA6WYOYkqxzowksyz_uxFyV673oTyg8iEgyDZDhYEetv1JG9w@mail.gmail.com> <CAHUa44G-wU6MEYXiaO7ZDM=mTZP3b3AsHbZAqQYA5q_avfKMzA@mail.gmail.com>
In-Reply-To: <CAHUa44G-wU6MEYXiaO7ZDM=mTZP3b3AsHbZAqQYA5q_avfKMzA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 22 Aug 2023 17:09:40 +0530
Message-ID: <CAFA6WYNq8gw-BUPgCLgj_jGtZdgkk1d+WFPzfJ2RktRzHcJXdQ@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 at 21:06, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Mon, Aug 21, 2023 at 2:10=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Mon, 21 Aug 2023 at 16:21, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > On Mon, Aug 21, 2023 at 10:31=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > >
> > > > On Mon, 21 Aug 2023 at 13:15, Jens Wiklander <jens.wiklander@linaro=
.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Aug 8, 2023 at 11:07=E2=80=AFAM Jens Wiklander
> > > > > <jens.wiklander@linaro.org> wrote:
> > > > > >
> > > > > > Hi Sumit,
> > > > > >
> > > > > > On Mon, Aug 7, 2023 at 9:58=E2=80=AFAM Sumit Garg <sumit.garg@l=
inaro.org> wrote:
> > > > > > >
> > > > > > > Hi Jens,
> > > > > > >
> > > > > > > On Thu, 3 Aug 2023 at 18:05, Jens Wiklander <jens.wiklander@l=
inaro.org> wrote:
> > > > > > > >
> > > > > > > > Prior to this patch was trusted_tee_seal() and trusted_tee_=
get_random()
> > > > > > > > relying on tee_shm_register_kernel_buf() to share memory wi=
th the TEE.
> > > > > > > > Depending on the memory allocation pattern the pages holdin=
g the
> > > > > > > > registered buffers overlap with other buffers also shared w=
ith the TEE.
> > > > > > > >
> > > > > > >
> > > > > > > The overlap here is due to the fact that we are registering t=
wo array
> > > > > > > members of the same struct. This overlap can be removed by re=
gistering
> > > > > > > the overall structure at once. But that sounds unnecessary da=
ta
> > > > > > > structure type sharing with trusted keys TA.
> > > > > > >
> > > > > > > > The OP-TEE driver using the old SMC based ABI permits overl=
apping shared
> > > > > > > > buffers, but with the new FF-A based ABI each physical page=
 may only
> > > > > > > > be registered once.
> > > > > > >
> > > > > > > Would it be possible for OP-TEE FF-A ABI to check if a page i=
s already
> > > > > > > registered?
> > > > > >
> > > > > > No, there's no such ABI in the FF-A specification.
> > > > > >
> > > > > > > If it is then just return success with appropriate page
> > > > > > > offset.
> > > > > >
> > > > > > It's more complicated than that. What if only there's a partial=
 registration?
> > > > > >
> > > > > > > As otherwise this sounds like an unnecessary restriction for
> > > > > > > users. I don't think the problem is only particular to the tr=
usted
> > > > > > > keys driver but can be reproduced for user-space clients as w=
ell.
> > > > > >
> > > > > > Indeed, we're dealing with it by using a temporary buffer in th=
e client lib.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Fix this problem by allocating a temporary page aligned sha=
red memory
> > > > > > > > buffer to be used as a bounce buffer for the needed data bu=
ffers.
> > > > > > > >
> > > > > > > > Since TEE trusted keys doesn't depend on registered shared =
memory
> > > > > > > > support any longer remove that explicit dependency when ope=
ning a
> > > > > > > > context to the TEE.
> > > > > > > >
> > > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > > ---
> > > > > > > >  security/keys/trusted-keys/trusted_tee.c | 68 ++++++++++++=
+-----------
> > > > > > > >  1 file changed, 36 insertions(+), 32 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/sec=
urity/keys/trusted-keys/trusted_tee.c
> > > > > > > > index ac3e270ade69..3085343c489a 100644
> > > > > > > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > > > > > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > > > > > > @@ -8,6 +8,7 @@
> > > > > > > >
> > > > > > > >  #include <linux/err.h>
> > > > > > > >  #include <linux/key-type.h>
> > > > > > > > +#include <linux/minmax.h>
> > > > > > > >  #include <linux/module.h>
> > > > > > > >  #include <linux/slab.h>
> > > > > > > >  #include <linux/string.h>
> > > > > > > > @@ -65,38 +66,37 @@ static int trusted_tee_seal(struct trus=
ted_key_payload *p, char *datablob)
> > > > > > > >         int ret;
> > > > > > > >         struct tee_ioctl_invoke_arg inv_arg;
> > > > > > > >         struct tee_param param[4];
> > > > > > > > -       struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =
=3D NULL;
> > > > > > > > +       struct tee_shm *shm;
> > > > > > > > +       uint8_t *buf;
> > > > > > > >
> > > > > > > >         memset(&inv_arg, 0, sizeof(inv_arg));
> > > > > > > >         memset(&param, 0, sizeof(param));
> > > > > > > >
> > > > > > > > -       reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data=
.ctx, p->key,
> > > > > > > > -                                                p->key_len=
);
> > > > > > > > -       if (IS_ERR(reg_shm_in)) {
> > > > > > > > -               dev_err(pvt_data.dev, "key shm register fai=
led\n");
> > > > > > > > -               return PTR_ERR(reg_shm_in);
> > > > > > > > +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx,
> > > > > > > > +                                      p->key_len + sizeof(=
p->blob));
> > > > > > > > +       if (IS_ERR(shm)) {
> > > > > > > > +               dev_err(pvt_data.dev, "key shm alloc failed=
\n");
> > > > > > > > +               return PTR_ERR(shm);
> > > > > > > >         }
> > > > > > > > -
> > > > > > > > -       reg_shm_out =3D tee_shm_register_kernel_buf(pvt_dat=
a.ctx, p->blob,
> > > > > > > > -                                                 sizeof(p-=
>blob));
> > > > > > > > -       if (IS_ERR(reg_shm_out)) {
> > > > > > > > -               dev_err(pvt_data.dev, "blob shm register fa=
iled\n");
> > > > > > > > -               ret =3D PTR_ERR(reg_shm_out);
> > > > > > > > +       buf =3D tee_shm_get_va(shm, 0);
> > > > > > > > +       if (IS_ERR(buf)) {
> > > > > > > > +               ret =3D PTR_ERR(buf);
> > > > > > > >                 goto out;
> > > > > > > >         }
> > > > > > > > +       memcpy(buf, p->key, p->key_len);
> > > > > > >
> > > > > > > These memcpy()'s here and below are undue overheads if we cha=
nge to
> > > > > > > tee_shm_alloc_kernel_buf().
> > > > > >
> > > > > > There's a bit of overhead when entering and exiting the secure =
world
> > > > > > too, just to save and restore registers. Anyway, trusted_tee_se=
al()
> > > > > > doesn't together with FF-A without this patch.
> > > > >
> > > > > By the way, without this patch the kernel fails with:
> > > > > [   12.642071] trusted-key-tee
> > > > > optee-ta-f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c: blob shm register
> > > > > failed
> > > > > [   12.642576] Unable to handle kernel paging request at virtual
> > > > > address fffffffffffffff3
> > > > > [   12.642668] Mem abort info:
> > > > > [   12.642701]   ESR =3D 0x0000000096000004
> > > > > [   12.642764]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > > > [   12.642821]   SET =3D 0, FnV =3D 0
> > > > > [   12.642864]   EA =3D 0, S1PTW =3D 0
> > > > > [   12.642910]   FSC =3D 0x04: level 0 translation fault
> > > > > [   12.642960] Data abort info:
> > > > > [   12.643006]   ISV =3D 0, ISS =3D 0x00000004
> > > > > [   12.643049]   CM =3D 0, WnR =3D 0
> > > > > [   12.643104] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000=
000043bfb000
> > > > > [   12.643197] [fffffffffffffff3] pgd=3D0000000000000000, p4d=3D0=
000000000000000
> > > > > [   12.643654] Internal error: Oops: 0000000096000004 [#1] PREEMP=
T SMP
> > > > > [   12.643821] Modules linked in:
> > > > > [   12.647781] CPU: 0 PID: 134 Comm: keyctl Not tainted 6.4.0 #1
> > > > > [   12.647990] Hardware name: linux,dummy-virt (DT)
> > > > > [   12.648146] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -S=
SBS BTYPE=3D--)
> > > > > [   12.648280] pc : tee_shm_put+0x1c/0x180
> > > > > [   12.648715] lr : tee_shm_free+0x10/0x1c
> > > > > [   12.648773] sp : ffff80000aa33aa0
> > > > > [   12.648822] x29: ffff80000aa33aa0 x28: ffff0000002b7900 x27: f=
fff80000a2f7750
> > > > > [   12.648980] x26: ffff80000aa33cf8 x25: ffff80000a2f76f0 x24: 0=
000000000000020
> > > > > [   12.649088] x23: ffff80000a6b2000 x22: 00000000fffffff3 x21: f=
ffffffffffffff3
> > > > > [   12.649199] x20: fffffffffffffff3 x19: fffffffffffffff3 x18: f=
fffffffffffffff
> > > > > [   12.649307] x17: 62203a6338656334 x16: 623538623931362d x15: 3=
76662612d623962
> > > > > [   12.649414] x14: 342d643566312d37 x13: ffff80000a271ac8 x12: 0=
000000000000363
> > > > > [   12.649523] x11: 0000000000000121 x10: ffff80000a2c9ac8 x9 : f=
fff80000a271ac8
> > > > > [   12.649667] x8 : 00000000ffffefff x7 : ffff80000a2c9ac8 x6 : 0=
000000000000000
> > > > > [   12.649797] x5 : ffff000041ea0c48 x4 : 0000000000000000 x3 : 0=
000000000000000
> > > > > [   12.649912] x2 : 0000000000000000 x1 : 0000000000000000 x0 : f=
ffffffffffffff3
> > > > > [   12.650074] Call trace:
> > > > > [   12.650212]  tee_shm_put+0x1c/0x180
> > > > > [   12.650361]  tee_shm_free+0x10/0x1c
> > > > > [   12.650437]  trusted_tee_seal+0xf4/0x17c
> > > > > [   12.650503]  trusted_instantiate+0x16c/0x1fc
> > > > > [   12.650564]  __key_instantiate_and_link+0x60/0x1f8
> > > > > [   12.650629]  __key_create_or_update+0x2a4/0x460
> > > > > [   12.650691]  key_create_or_update+0x14/0x20
> > > > > [   12.650757]  __arm64_sys_add_key+0xe4/0x244
> > > > > [   12.650822]  invoke_syscall+0x48/0x114
> > > > > [   12.650886]  el0_svc_common.constprop.0+0x44/0xf4
> > > > > [   12.650958]  do_el0_svc+0x3c/0xa8
> > > > > [   12.651015]  el0_svc+0x2c/0x84
> > > > > [   12.651074]  el0t_64_sync_handler+0xbc/0x138
> > > > > [   12.651144]  el0t_64_sync+0x190/0x194
> > > > > [   12.651341] Code: a90153f3 aa0003f4 aa0003f3 a9025bf5 (f843868=
0)
> > > > > [   12.651654] ---[ end trace 0000000000000000 ]---
> > > > > Segmentation fault
> > > > >
> > > > > So clearly something needs to be done since there's a bug in the =
error path.
> > > > >
> > > > > I'm not overly concerned about the overhead with memcpy(), since =
we're
> > > > > using relatively small buffers. Kernel clients using large buffer=
s
> > > > > will need a different approach, for example by using page-aligned
> > > > > buffers.
> > > >
> > > > With that too, it is very much possible for kernel clients to share
> > > > the same page for two sub page buffers, correct?
> > >
> > > No, tee_shm_alloc_kernel_buf() uses page sized aligment for buffers s=
o
> > > that can't happen.
> > >
> > > > IMO, it should be
> > > > handled as part of tee_shm_register_kernel_buf() as you did for
> > > > user-space clients as a short term workaround until we find a real
> > > > fix.
> > >
> > > I'm not so keen on that. The rework of tee_shm_register_kernel_buf()
> > > to tee_shm_register_kernel_pages() you suggest should take care of th=
e
> > > kernel clients. Some kernel clients will be better off with a
> > > temporary buffer like here,
> >
> > Trusted keys is the only current user of registered shared memory
> > approach since we have to share pre-allocated key buffers with OP-TEE.
> > We shouldn't make it use allocated shared memory approach too which
> > has overheads:
> > - Allocate redundant kernel pages
> > - Redundant memcpy()'s
>
> You may save some overhead in the kernel (copy 512 bytes + key size 32
> bytes?). But that's quickly lost in firmware at the different
> exception levels since you register two buffers instead of a single
> larger one. So this patch should actually also serve as an
> optimization if you're into minimizing overhead. However, I believe
> we're splitting hairs. The question is, do we want to fix this ugly
> memory abort and make keyctl work for FF-A with OP-TEE now or do we
> want to keep it broken until the needed infrastructure is in place?
>

I have posted this [1] as a more appropriate fix. Please test if it
resolves the FF-A ABI issue with trusted keys.

[1] https://lkml.org/lkml/2023/8/22/431

> >
> > IMO, the real zero copy optimization has benefits here and can serve
> > as a reference for other future kernel TEE drivers.
>
> Sure, at the cost of keeping keyctl broken for OP-TEE with FF-A until
> that is in place.
>
> >
> > > while others may use the new
> > > tee_shm_register_kernel_pages() function.
> > >
> >
> > There aren't any other users as of now upstream, we should make the
> > Trusted keys driver as the first user of
> > tee_shm_register_kernel_pages().
>
> That's fine, but perhaps not very urgent.
>

As we agreed offline on this, tee_shm_register_kernel_buf() is still
broken for FF-A ABI but without any broken user after trusted keys
refactoring. The final solution would be to move to
tee_shm_register_kernel_pages().

-Sumit

> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > > Thanks,
> > > > > Jens
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Jens
> > > > > >
> > > > > > >
> > > > > > > -Sumit
> > > > > > >
> > > > > > > >
> > > > > > > >         inv_arg.func =3D TA_CMD_SEAL;
> > > > > > > >         inv_arg.session =3D pvt_data.session_id;
> > > > > > > >         inv_arg.num_params =3D 4;
> > > > > > > >
> > > > > > > >         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_=
INPUT;
> > > > > > > > -       param[0].u.memref.shm =3D reg_shm_in;
> > > > > > > > +       param[0].u.memref.shm =3D shm;
> > > > > > > >         param[0].u.memref.size =3D p->key_len;
> > > > > > > >         param[0].u.memref.shm_offs =3D 0;
> > > > > > > >         param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_=
OUTPUT;
> > > > > > > > -       param[1].u.memref.shm =3D reg_shm_out;
> > > > > > > > +       param[1].u.memref.shm =3D shm;
> > > > > > > >         param[1].u.memref.size =3D sizeof(p->blob);
> > > > > > > > -       param[1].u.memref.shm_offs =3D 0;
> > > > > > > > +       param[1].u.memref.shm_offs =3D p->key_len;
> > > > > > > >
> > > > > > > >         ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_a=
rg, param);
> > > > > > > >         if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > > > > > > > @@ -104,14 +104,13 @@ static int trusted_tee_seal(struct tr=
usted_key_payload *p, char *datablob)
> > > > > > > >                         inv_arg.ret);
> > > > > > > >                 ret =3D -EFAULT;
> > > > > > > >         } else {
> > > > > > > > +               memcpy(p->blob, buf + p->key_len,
> > > > > > > > +                      min(param[1].u.memref.size, sizeof(p=
->blob)));
> > > > > > > >                 p->blob_len =3D param[1].u.memref.size;
> > > > > > > >         }
> > > > > > > >
> > > > > > > >  out:
> > > > > > > > -       if (reg_shm_out)
> > > > > > > > -               tee_shm_free(reg_shm_out);
> > > > > > > > -       if (reg_shm_in)
> > > > > > > > -               tee_shm_free(reg_shm_in);
> > > > > > > > +       tee_shm_free(shm);
> > > > > > > >
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > > @@ -166,11 +165,9 @@ static int trusted_tee_unseal(struct t=
rusted_key_payload *p, char *datablob)
> > > > > > > >                 p->key_len =3D param[1].u.memref.size;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > +       tee_shm_free(reg_shm_out);
> > > > > > > >  out:
> > > > > > > > -       if (reg_shm_out)
> > > > > > > > -               tee_shm_free(reg_shm_out);
> > > > > > > > -       if (reg_shm_in)
> > > > > > > > -               tee_shm_free(reg_shm_in);
> > > > > > > > +       tee_shm_free(reg_shm_in);
> > > > > > > >
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > > @@ -183,15 +180,21 @@ static int trusted_tee_get_random(uns=
igned char *key, size_t key_len)
> > > > > > > >         int ret;
> > > > > > > >         struct tee_ioctl_invoke_arg inv_arg;
> > > > > > > >         struct tee_param param[4];
> > > > > > > > -       struct tee_shm *reg_shm =3D NULL;
> > > > > > > > +       struct tee_shm *shm;
> > > > > > > > +       void *buf;
> > > > > > > >
> > > > > > > >         memset(&inv_arg, 0, sizeof(inv_arg));
> > > > > > > >         memset(&param, 0, sizeof(param));
> > > > > > > >
> > > > > > > > -       reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ct=
x, key, key_len);
> > > > > > > > -       if (IS_ERR(reg_shm)) {
> > > > > > > > -               dev_err(pvt_data.dev, "key shm register fai=
led\n");
> > > > > > > > -               return PTR_ERR(reg_shm);
> > > > > > > > +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx, key_=
len);
> > > > > > > > +       if (IS_ERR(shm)) {
> > > > > > > > +               dev_err(pvt_data.dev, "key shm alloc failed=
\n");
> > > > > > > > +               return PTR_ERR(shm);
> > > > > > > > +       }
> > > > > > > > +       buf =3D tee_shm_get_va(shm, 0);
> > > > > > > > +       if (IS_ERR(buf)) {
> > > > > > > > +               ret =3D PTR_ERR(buf);
> > > > > > > > +               goto out;
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         inv_arg.func =3D TA_CMD_GET_RANDOM;
> > > > > > > > @@ -199,7 +202,7 @@ static int trusted_tee_get_random(unsig=
ned char *key, size_t key_len)
> > > > > > > >         inv_arg.num_params =3D 4;
> > > > > > > >
> > > > > > > >         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_=
OUTPUT;
> > > > > > > > -       param[0].u.memref.shm =3D reg_shm;
> > > > > > > > +       param[0].u.memref.shm =3D shm;
> > > > > > > >         param[0].u.memref.size =3D key_len;
> > > > > > > >         param[0].u.memref.shm_offs =3D 0;
> > > > > > > >
> > > > > > > > @@ -209,18 +212,19 @@ static int trusted_tee_get_random(uns=
igned char *key, size_t key_len)
> > > > > > > >                         inv_arg.ret);
> > > > > > > >                 ret =3D -EFAULT;
> > > > > > > >         } else {
> > > > > > > > +               memcpy(key, buf, min(param[0].u.memref.size=
, key_len));
> > > > > > > >                 ret =3D param[0].u.memref.size;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       tee_shm_free(reg_shm);
> > > > > > > > +out:
> > > > > > > > +       tee_shm_free(shm);
> > > > > > > >
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static int optee_ctx_match(struct tee_ioctl_version_data *=
ver, const void *data)
> > > > > > > >  {
> > > > > > > > -       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE &&
> > > > > > > > -           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
> > > > > > > > +       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
> > > > > > > >                 return 1;
> > > > > > > >         else
> > > > > > > >                 return 0;
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >
