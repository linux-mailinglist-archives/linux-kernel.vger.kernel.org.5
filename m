Return-Path: <linux-kernel+bounces-132917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8F899C03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CC31C2124E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A416C69A;
	Fri,  5 Apr 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwHjSl9M"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68316C454
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317198; cv=none; b=fnmqahRxyHwLUGewy6o9TOIdBOptfwid1jfI81mqFibX1NNlzv1QG104FPowxExNeTronR0Efi43Q2i1DEMLKqPnPKwlyUbxa9/tGDBC6peDp8VxCUXP8EQwjDiMRnxUvHrXl0YrLJOKL9/2UtG+X3NwWriHBKzwNbJ5cM6qRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317198; c=relaxed/simple;
	bh=jePgYJFhMRyx3K64XlV3bvd6HJBpAB3K8/TnJST4gEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpPY2p7EDP+zHsS/Cjn++DfBogy/fSfYsbiuXd2Es3LnTSz2bfT0UNlA3obWgTCZvCG0DcX3Jm9mueSilt1G2HTGRIvgsJaWQ77n573+2H4WjXm4ToHXc/km6/nzi00y18Tuk85HmcGV6/JP33iQaMQYRiTYNYP4215T6broEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PwHjSl9M; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a558d9c33aso977143eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712317195; x=1712921995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhGvnh+ly2lqyNSxeyDksRESCobodBus2aeYqZoMm8A=;
        b=PwHjSl9MkezFh1ONy2n2ILmFEtqd+VO/J+56VBwOpOUd0fjHwW4HK7BXsz+Gmn3qZC
         A4mjSWBKyvG44DNHZjZvP6n11gnF97vs6BquZohFc8c9acj0q2k+fu08OPvG2ASh/csf
         C5hY8V2rZXvI8rdrm13hHR2QvVVl9hd4nkdBBCfU7iS21Q8UJYXdHZZv/VYes4hSZxS3
         I3U3wrH+yuZVXAPAfgtv2r4RD9X4KZskRIYW8J0xhhhPeqeilSzn/xymYzaCq1adjHS6
         gnAMUQbQniumzpjYwLJEkNzhDZW9XiTYfK4M5DrWA1r4JBIC+fAL5LsVbiWT0Ho7uptC
         Anxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712317195; x=1712921995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhGvnh+ly2lqyNSxeyDksRESCobodBus2aeYqZoMm8A=;
        b=IGCuw2dUiOIjQC9y4A492Wbd+L7i1w9l9hMKsnjTKawgPGmwKQ2R8G9H+VirB0kY1R
         czJYbbOfF2oRTVRHrrXMqBGFpwWHtOsqB+u/myt71FFFKPDmRrhCxKQYh/wnbNRvFelJ
         YBVjWAUjYogJqYMjOGVa7ALoVOFuhxvJw+Ra6VlklShydBpFUFaz/hUtJq9gHwVoONei
         tV4NHPwIbr1zjoH0mGt0IyID+ByllzITFG/Z+A1Iv28ibmxR6oAGLIXPYlKBYn3X90Bq
         mk+ODchJVV+2jt+ttqah1zg+WjNCHA/z8Rn50qDYKa6WmPD8busz9UURmSFdRLLrVyMU
         vZyQ==
X-Gm-Message-State: AOJu0YznHl1AkIlKM3d61hp6pgOwKfYYx2w4dCYTMTLNWYiPNvVXLqgo
	mbHapove/XMV7Btx0tGeRsu5v1GMfVMtAwPcVOufsTd9HoVrNpQaa6DTWT6DRqdda8Vrf/6TOPS
	eRrJ5gso/tIlm7qpzI6RJh3lVGiKzdL8FYV48QA==
X-Google-Smtp-Source: AGHT+IGa8eHkl6wMfGgDxUmBFBHvBcKxzO1UQ8ebWJHS3YzfWJ5uacBLfpJQiF/zojIfye1XYmHtqpsZO/98wnseOVI=
X-Received: by 2002:a05:6820:308b:b0:5a7:c78e:410e with SMTP id
 eu11-20020a056820308b00b005a7c78e410emr1275218oob.2.1712317195070; Fri, 05
 Apr 2024 04:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-4-jens.wiklander@linaro.org> <CAFA6WYOZQwo1qJWXV+W9t6ZChkWJwzg_0mtAJ2K+viHRdvH2ig@mail.gmail.com>
 <CAHUa44H0sV5yYD6b8vb3b=GvFokxC9xgjFFVkj4Dk0YAVm=X7Q@mail.gmail.com>
 <CAFA6WYOhFLh7k0XQnA22-92DmuCVqEvfpTSa5kdAqO_hNTztaw@mail.gmail.com>
 <CAHUa44G4TZUaQQ=GmJaxgq-zYdS69njVza-e7M=5-65r6=RwqQ@mail.gmail.com> <CAFA6WYP_ddmdimC2YF_ZEZfsJQ2OozzYwY=GzLXWVxD8iJ=Sww@mail.gmail.com>
In-Reply-To: <CAFA6WYP_ddmdimC2YF_ZEZfsJQ2OozzYwY=GzLXWVxD8iJ=Sww@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 5 Apr 2024 13:39:43 +0200
Message-ID: <CAHUa44EeewyqEiW1b8p9mQZYGuRAmCa2R+CpBwLxWxuGvGppVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] optee: probe RPMB device using RPMB subsystem
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 9:15=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Wed, 3 Apr 2024 at 20:11, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > On Wed, Apr 3, 2024 at 2:58=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> > >
> > > On Thu, 28 Mar 2024 at 21:39, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > On Fri, Mar 1, 2024 at 11:28=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > >
> > > > > Hi Jens,
> > > > >
> > > > > On Tue, 27 Feb 2024 at 21:01, Jens Wiklander <jens.wiklander@lina=
ro.org> wrote:
> > > > > >
> > > > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to =
probe and
> > > > > > use an RPMB device via the RPBM subsystem instead of passing th=
e RPMB
> > > > >
> > > > > s/RPBM/RPMB/
> > > > >
> > > > > Here are other places too in this patch-set.
> > > > >
> > > > > > frames via tee-supplicant in user space. A fallback mechanism i=
s kept to
> > > > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn'=
t
> > > > > > available.
> > > > > >
> > > > > > The OP-TEE RPC ABI is extended to support iterating over all RP=
MB
> > > > > > devices until one is found with the expected RPMB key already
> > > > > > programmed.
> > > > >
> > > > > I would appreciate it if you could add a link to OP-TEE OS change=
s in
> > > > > the cover-letter although I have found them here [1].
> > > > >
> > > > > [1] https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe/
> > > >
> > > > OK, I'll add a link in the coverletter of the next patch set.
> > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > ---
> > > > > >  drivers/tee/optee/core.c          |  55 +++++++
> > > > > >  drivers/tee/optee/ffa_abi.c       |   7 +
> > > > > >  drivers/tee/optee/optee_private.h |  16 ++
> > > > > >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> > > > > >  drivers/tee/optee/rpc.c           | 233 ++++++++++++++++++++++=
++++++++
> > > > > >  drivers/tee/optee/smc_abi.c       |   6 +
> > > > > >  6 files changed, 352 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.=
c
> > > > > > index 3aed554bc8d8..6b32d3e7865b 100644
> > > > > > --- a/drivers/tee/optee/core.c
> > > > > > +++ b/drivers/tee/optee/core.c
> > > > > > @@ -11,6 +11,7 @@
> > > > > >  #include <linux/io.h>
> > > > > >  #include <linux/mm.h>
> > > > > >  #include <linux/module.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/string.h>
> > > > > >  #include <linux/tee_drv.h>
> > > > > > @@ -80,6 +81,57 @@ void optee_pool_op_free_helper(struct tee_sh=
m_pool *pool, struct tee_shm *shm,
> > > > > >         shm->pages =3D NULL;
> > > > > >  }
> > > > > >
> > > > > > +static void optee_rpmb_scan(struct work_struct *work)
> > > > > > +{
> > > > > > +       struct optee *optee =3D container_of(work, struct optee=
, scan_rpmb_work);
> > > > > > +       bool scan_done =3D false;
> > > > > > +       u32 res;
> > > > > > +
> > > > > > +       do {
> > > > > > +               mutex_lock(&optee->rpmb_dev_mutex);
> > > > > > +               /* No need to rescan if we haven't started scan=
ning yet */
> > > > > > +               optee->rpmb_dev_request_rescan =3D false;
> > > > > > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > > > > > +
> > > > > > +               res =3D optee_enumerate_devices(PTA_CMD_GET_DEV=
ICES_RPMB);
> > > > > > +               if (res && res !=3D TEE_ERROR_STORAGE_NOT_AVAIL=
ABLE)
> > > > >
> > > > > I suppose this hasn't been tested for a negative case since
> > > > > optee_enumerate_devices() won't return this error code (see [2]).
> > > > > However, I would prefer to use GP Client error code:
> > > > > TEEC_ERROR_ITEM_NOT_FOUND here instead.
> > > > >
> > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/drivers/tee/optee/device.c#n43
> > > >
> > > > I prefer TEE_ERROR_STORAGE_NOT_AVAILABLE since that's the code GP s=
ays
> > > > a TA should get when storage is unavailable.
> > > > TEEC_ERROR_ITEM_NOT_FOUND is less specific. Anyway, I'll need to
> > > > translate the code in get_devices().
> > >
> > > Okay, that's fair.
> > >
> > > >
> > > >
> > > > >
> > > > > > +                       pr_info("Scanning for RPMB device: res =
%#x\n", res);
> > > > > > +
> > > > > > +               mutex_lock(&optee->rpmb_dev_mutex);
> > > > > > +               /*
> > > > > > +                * If another RPMB device came online while sca=
nning, scan one
> > > > > > +                * more time, unless we have already found an R=
PBM device.
> > > > > > +                */
> > > > > > +               scan_done =3D (optee->rpmb_dev ||
> > > > >
> > > > > I suppose we don't need to check for optee->rpmb_dev here since a
> > > > > successful return from
> > > > > optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB) would ensure th=
at
> > > > > the RPMB device has been found.
> > > >
> > > > That makes sense, I'll check the return value instead.
> > > >
> > > > >
> > > > > > +                            !optee->rpmb_dev_request_rescan);
> > > > > > +               optee->rpmb_dev_request_rescan =3D false;
> > > > > > +               optee->rpmb_dev_scan_in_progress =3D !scan_done=
;
> > > > > > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > > > > > +       } while (!scan_done);
> > > > > > +}
> > > > > > +
> > > > > > +void optee_rpmb_intf_add_rdev(struct rpmb_interface *intf,
> > > > > > +                             struct rpmb_dev *rdev)
> > > > > > +{
> > > > > > +       struct optee *optee =3D container_of(intf, struct optee=
, rpmb_intf);
> > > > > > +       bool queue_work =3D true;
> > > > > > +
> > > > > > +       mutex_lock(&optee->rpmb_dev_mutex);
> > > > > > +       if (optee->rpmb_dev || optee->rpmb_dev_scan_in_progress=
) {
> > > > >
> > > > > Can we use work_pending() instead of our custom
> > > > > optee->rpmb_dev_scan_in_progress flag?
> > > >
> > > > That seems racy, or am I missing something?
> > > >
> > >
> > > You are right and even work_busy() is documented to provide unreliabl=
e
> > > results. So I am rather thinking about just queuing the work and
> > > thereby scanning for devices unconditionally. I suppose the extra
> > > logic to check if we don't try to register duplicate devices can go
> > > under optee_enumerate_devices().
> > >
> > > > >
> > > > > > +               queue_work =3D false;
> > > > > > +               if (optee->rpmb_dev_scan_in_progress)
> > > > > > +                       optee->rpmb_dev_request_rescan =3D true=
;
> > > > > > +       }
> > > > > > +       if (queue_work)
> > > > > > +               optee->rpmb_dev_scan_in_progress =3D true;
> > > > > > +       mutex_unlock(&optee->rpmb_dev_mutex);
> > > > > > +
> > > > > > +       if (queue_work) {
> > > > > > +               INIT_WORK(&optee->scan_rpmb_work, optee_rpmb_sc=
an);
> > > > > > +               schedule_work(&optee->scan_rpmb_work);
> > > > >
> > > > > Can we reuse optee->scan_bus_work rather than introducing a new o=
ne here?
> > > >
> > > > No, both may be active at the same time.
> > >
> > > Actually both of them are using system_wq underneath, so it shouldn't
> > > be a problem if both are active at the same time as they can be queue=
d
> > > simultaneously, right?
> >
> > I'm sorry, I don't get it.
> > Are you suggesting to merge optee_rpmb_scan() and optee_bus_scan()?
> > If so, how to tell what to do, that is, if tee-supplicant has become
> > available or of we should scan for RPMB devices?
> > If not, you can only have one callback at a time in a work_struct.
>
> You are right, keep it as it is.
>
> >
> > >
> > > > We'd have to merge
> > > > optee_rpmb_scan() and optee_bus_scan(), but I'm not sure it's worth
> > > > it.
> > > >
> > > > >
> > > > > > +       }
> > > > > > +}
> > > > > > +
> > > > > >  static void optee_bus_scan(struct work_struct *work)
> > > > > >  {
> > > > > >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUP=
P));
> > > > > > @@ -161,6 +213,7 @@ void optee_release_supp(struct tee_context =
*ctx)
> > > > > >
> > > > > >  void optee_remove_common(struct optee *optee)
> > > > > >  {
> > > > > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > > > >         /* Unregister OP-TEE specific client devices on TEE bus=
 */
> > > > > >         optee_unregister_devices();
> > > > > >
> > > > > > @@ -177,6 +230,8 @@ void optee_remove_common(struct optee *opte=
e)
> > > > > >         tee_shm_pool_free(optee->pool);
> > > > > >         optee_supp_uninit(&optee->supp);
> > > > > >         mutex_destroy(&optee->call_queue.mutex);
> > > > > > +       rpmb_dev_put(optee->rpmb_dev);
> > > > > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > > > >  }
> > > > > >
> > > > > >  static int smc_abi_rc;
> > > > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ff=
a_abi.c
> > > > > > index ecb5eb079408..befe19ecc30a 100644
> > > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > > @@ -7,6 +7,7 @@
> > > > > >
> > > > > >  #include <linux/arm_ffa.h>
> > > > > >  #include <linux/errno.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >  #include <linux/scatterlist.h>
> > > > > >  #include <linux/sched.h>
> > > > > >  #include <linux/slab.h>
> > > > > > @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_devic=
e *ffa_dev)
> > > > > >         optee_cq_init(&optee->call_queue, 0);
> > > > > >         optee_supp_init(&optee->supp);
> > > > > >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > > > > +       mutex_init(&optee->rpmb_dev_mutex);
> > > > > >         ffa_dev_set_drvdata(ffa_dev, optee);
> > > > > >         ctx =3D teedev_open(optee->teedev);
> > > > > >         if (IS_ERR(ctx)) {
> > > > > > @@ -955,6 +957,8 @@ static int optee_ffa_probe(struct ffa_devic=
e *ffa_dev)
> > > > > >         if (rc)
> > > > > >                 goto err_unregister_devices;
> > > > > >
> > > > > > +       optee->rpmb_intf.add_rdev =3D optee_rpmb_intf_add_rdev;
> > > > > > +       rpmb_interface_register(&optee->rpmb_intf);
> > > > > >         pr_info("initialized driver\n");
> > > > > >         return 0;
> > > > > >
> > > > > > @@ -968,6 +972,9 @@ static int optee_ffa_probe(struct ffa_devic=
e *ffa_dev)
> > > > > >         teedev_close_context(ctx);
> > > > > >  err_rhashtable_free:
> > > > > >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_=
free_fn, NULL);
> > > > > > +       rpmb_dev_put(optee->rpmb_dev);
> > > > > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > > > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > > > >         optee_supp_uninit(&optee->supp);
> > > > > >         mutex_destroy(&optee->call_queue.mutex);
> > > > > >         mutex_destroy(&optee->ffa.mutex);
> > > > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/op=
tee/optee_private.h
> > > > > > index 7a5243c78b55..1e4c33baef43 100644
> > > > > > --- a/drivers/tee/optee/optee_private.h
> > > > > > +++ b/drivers/tee/optee/optee_private.h
> > > > > > @@ -8,6 +8,7 @@
> > > > > >
> > > > > >  #include <linux/arm-smccc.h>
> > > > > >  #include <linux/rhashtable.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >  #include <linux/semaphore.h>
> > > > > >  #include <linux/tee_drv.h>
> > > > > >  #include <linux/types.h>
> > > > > > @@ -20,11 +21,13 @@
> > > > > >  /* Some Global Platform error codes used in this driver */
> > > > > >  #define TEEC_SUCCESS                   0x00000000
> > > > > >  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> > > > > > +#define TEEC_ERROR_ITEM_NOT_FOUND      0xFFFF0008
> > > > > >  #define TEEC_ERROR_NOT_SUPPORTED       0xFFFF000A
> > > > > >  #define TEEC_ERROR_COMMUNICATION       0xFFFF000E
> > > > > >  #define TEEC_ERROR_OUT_OF_MEMORY       0xFFFF000C
> > > > > >  #define TEEC_ERROR_BUSY                        0xFFFF000D
> > > > > >  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
> > > > > > +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
> > > > > >
> > > > > >  #define TEEC_ORIGIN_COMMS              0x00000002
> > > > > >
> > > > > > @@ -197,6 +200,8 @@ struct optee_ops {
> > > > > >   * @notif:             notification synchronization struct
> > > > > >   * @supp:              supplicant synchronization struct for R=
PC to supplicant
> > > > > >   * @pool:              shared memory pool
> > > > > > + * @mutex:             mutex protecting @rpmb_dev
> > > > > > + * @rpmb_dev:          current RPMB device or NULL
> > > > > >   * @rpc_param_count:   If > 0 number of RPC parameters to make=
 room for
> > > > > >   * @scan_bus_done      flag if device registation was already =
done.
> > > > > >   * @scan_bus_work      workq to scan optee bus and register op=
tee drivers
> > > > > > @@ -215,9 +220,17 @@ struct optee {
> > > > > >         struct optee_notif notif;
> > > > > >         struct optee_supp supp;
> > > > > >         struct tee_shm_pool *pool;
> > > > > > +       /* Protects rpmb_dev pointer and rpmb_dev_* */
> > > > > > +       struct mutex rpmb_dev_mutex;
> > > > >
> > > > > Given my comments above, do we really need this mutex?
> > > >
> > > > I don't see how we can do without the mutex.
> > >
> > > See if it is possible with the above mentioned approach.
> >
> > I don't follow.
>
> Probably my explanation above to handle complexity within
> optee_enumerate_devices() wasn't clear. Let me try again:
>
> - Schedule optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
> unconditionally whenever a new RPMB device is registered.
> - While registering OP-TEE devices (TA UUIDs), don't register
> duplicate devices or better make the device pseudo TA to return the
> UUID list only once when RPMB has been discovered successfully.
>
> This would allow us to drop the fragile handling via
> rpmb_dev_scan_in_progress under mutex, right?

I got it now. I'll do that in the v4. Thanks for your patience. :-)

Cheers,
Jens

