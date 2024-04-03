Return-Path: <linux-kernel+bounces-129986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C679D8972E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD511F26FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FDF148844;
	Wed,  3 Apr 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrHgY7m+"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192F1494C2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155285; cv=none; b=R5trHULyld6N4Om9J+3cpuQGzmTuJlY3x5WvDftgT6UQqw0otbd4d6tyuCljeqOnTXnY4dViK0qAlM7Ftt9oIXywHPMMlpPi85akmL+woA9+9g0SRz5hnA9UefWnubMeZ+bL6RGWWYpwKIGNCE1xXf/w/j0uFAHJQJpwcTDHgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155285; c=relaxed/simple;
	bh=p3ECGCX5Ov7HPvSxyf6FtJ+yTzxCh0hPa+JgJL4J+vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ull5+bM9xK2mRwjWhOXZiIOVHqBM6JA+rZlwZ7oVmVSqwYQ/NLfzcIFgUNkcs2ow1cct8azhqDq5m4cevjME2zKmVo+OQD8O09Pisj1F+aSA2MZMUaFvrHTG4RYi8q4uJEiyqiPZcbw4BkRI4CzFXqMIxNYll41YksOYxYG3nVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FrHgY7m+; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a4817189c8so4238618eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712155282; x=1712760082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJtFX1nTvUEDL8G1NxaJVR0BnuJK5EdCet0i7aU3Qj4=;
        b=FrHgY7m+yKqCPQ5Z4iWj7GFBy+eXINVd8BQ0jUJeVfvcP5fNdBBVI8VAt0OnQj2P3M
         XV570181fcftODhQ7AGcXF40fTkFkYcuiPqZpAM94HdKxTkArzX/853xNOQ3aoEagyq9
         IdZD6CXZ4hReKRawNyJU7kTccyKtPwlSmrQR2OJGwWaLPts0Wcf2kuk2sNIZyRRue8iI
         0vLoqtEL/AJ7FLpm0KF4grfB6C3pgUWDdDmHDvFpRm/sJEl7cZNy3PfOSYuYKCILJzaU
         ojivTOIQkTJOzh0GQOc3gapDshm0C3WeIHFVf1YlDDzBDq34uH3134scO15HgjtDRMVh
         jcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155282; x=1712760082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJtFX1nTvUEDL8G1NxaJVR0BnuJK5EdCet0i7aU3Qj4=;
        b=kwwACDHFPwH77hzv0LT388beKwHZYHFE04j0fuXoBMmUWVW+ou+9TSpcLNewk1sJlI
         y0zyRW3YsSCk0Jwk/JFFR8RlLSwzjhgQy/4720RWN1Am5SVc6QOU8oHTijjwv6M1WV8m
         0Kn/zrjokO5tU3OxBQTtJ/7bmHzY5WyygybfqbibJHTBvkNiqwtdQjyifkSa62qxB/7w
         f7dw1+PzEN7hOEm68U35Vr1K+ZlaIOLbXtcM8V44DL6nxZDpkMnYEDI1I6wrA6WhUnGc
         O1avqZkL987wm3v2MJeuGgyueRPKmYDMXHodkfH38G+v6EvpfsenHM219cHQXqkGErjr
         91pg==
X-Gm-Message-State: AOJu0YziHjgGpp3Yklw93jsojLqEOMvoid1MTjb+K2Q0pwA6T8zyGucf
	m4vy37PIa1EG6j5cLkFojPiiY0K32FpOC6YmjRub1p8BZXcr8+3u8JnYyq1nEWAe1b9/ZRM6rMS
	NOMRUpuob0pedn127qP9CGaQ8JiCFNyfzO8Ud/Q==
X-Google-Smtp-Source: AGHT+IHQsjqg5qWvk+9Xu9McI5A0GqkJxBRqUIqmvC5/FKAFQGsaqSQ04bBhzDQrmSk4/aeLPcaArwoaYgI4ZFvxfiY=
X-Received: by 2002:a05:6820:998:b0:5a2:37c9:d91f with SMTP id
 cg24-20020a056820099800b005a237c9d91fmr15336849oob.5.1712155282054; Wed, 03
 Apr 2024 07:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-4-jens.wiklander@linaro.org> <CAFA6WYOZQwo1qJWXV+W9t6ZChkWJwzg_0mtAJ2K+viHRdvH2ig@mail.gmail.com>
 <CAHUa44H0sV5yYD6b8vb3b=GvFokxC9xgjFFVkj4Dk0YAVm=X7Q@mail.gmail.com> <CAFA6WYOhFLh7k0XQnA22-92DmuCVqEvfpTSa5kdAqO_hNTztaw@mail.gmail.com>
In-Reply-To: <CAFA6WYOhFLh7k0XQnA22-92DmuCVqEvfpTSa5kdAqO_hNTztaw@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 3 Apr 2024 16:41:11 +0200
Message-ID: <CAHUa44G4TZUaQQ=GmJaxgq-zYdS69njVza-e7M=5-65r6=RwqQ@mail.gmail.com>
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

On Wed, Apr 3, 2024 at 2:58=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Thu, 28 Mar 2024 at 21:39, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Fri, Mar 1, 2024 at 11:28=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > Hi Jens,
> > >
> > > On Tue, 27 Feb 2024 at 21:01, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to prob=
e and
> > > > use an RPMB device via the RPBM subsystem instead of passing the RP=
MB
> > >
> > > s/RPBM/RPMB/
> > >
> > > Here are other places too in this patch-set.
> > >
> > > > frames via tee-supplicant in user space. A fallback mechanism is ke=
pt to
> > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > available.
> > > >
> > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > devices until one is found with the expected RPMB key already
> > > > programmed.
> > >
> > > I would appreciate it if you could add a link to OP-TEE OS changes in
> > > the cover-letter although I have found them here [1].
> > >
> > > [1] https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe/
> >
> > OK, I'll add a link in the coverletter of the next patch set.
> >
> > >
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/optee/core.c          |  55 +++++++
> > > >  drivers/tee/optee/ffa_abi.c       |   7 +
> > > >  drivers/tee/optee/optee_private.h |  16 ++
> > > >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> > > >  drivers/tee/optee/rpc.c           | 233 ++++++++++++++++++++++++++=
++++
> > > >  drivers/tee/optee/smc_abi.c       |   6 +
> > > >  6 files changed, 352 insertions(+)
> > > >
> > > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > > index 3aed554bc8d8..6b32d3e7865b 100644
> > > > --- a/drivers/tee/optee/core.c
> > > > +++ b/drivers/tee/optee/core.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/io.h>
> > > >  #include <linux/mm.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/tee_drv.h>
> > > > @@ -80,6 +81,57 @@ void optee_pool_op_free_helper(struct tee_shm_po=
ol *pool, struct tee_shm *shm,
> > > >         shm->pages =3D NULL;
> > > >  }
> > > >
> > > > +static void optee_rpmb_scan(struct work_struct *work)
> > > > +{
> > > > +       struct optee *optee =3D container_of(work, struct optee, sc=
an_rpmb_work);
> > > > +       bool scan_done =3D false;
> > > > +       u32 res;
> > > > +
> > > > +       do {
> > > > +               mutex_lock(&optee->rpmb_dev_mutex);
> > > > +               /* No need to rescan if we haven't started scanning=
 yet */
> > > > +               optee->rpmb_dev_request_rescan =3D false;
> > > > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > > > +
> > > > +               res =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES=
_RPMB);
> > > > +               if (res && res !=3D TEE_ERROR_STORAGE_NOT_AVAILABLE=
)
> > >
> > > I suppose this hasn't been tested for a negative case since
> > > optee_enumerate_devices() won't return this error code (see [2]).
> > > However, I would prefer to use GP Client error code:
> > > TEEC_ERROR_ITEM_NOT_FOUND here instead.
> > >
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/tee/optee/device.c#n43
> >
> > I prefer TEE_ERROR_STORAGE_NOT_AVAILABLE since that's the code GP says
> > a TA should get when storage is unavailable.
> > TEEC_ERROR_ITEM_NOT_FOUND is less specific. Anyway, I'll need to
> > translate the code in get_devices().
>
> Okay, that's fair.
>
> >
> >
> > >
> > > > +                       pr_info("Scanning for RPMB device: res %#x\=
n", res);
> > > > +
> > > > +               mutex_lock(&optee->rpmb_dev_mutex);
> > > > +               /*
> > > > +                * If another RPMB device came online while scannin=
g, scan one
> > > > +                * more time, unless we have already found an RPBM =
device.
> > > > +                */
> > > > +               scan_done =3D (optee->rpmb_dev ||
> > >
> > > I suppose we don't need to check for optee->rpmb_dev here since a
> > > successful return from
> > > optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB) would ensure that
> > > the RPMB device has been found.
> >
> > That makes sense, I'll check the return value instead.
> >
> > >
> > > > +                            !optee->rpmb_dev_request_rescan);
> > > > +               optee->rpmb_dev_request_rescan =3D false;
> > > > +               optee->rpmb_dev_scan_in_progress =3D !scan_done;
> > > > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > > > +       } while (!scan_done);
> > > > +}
> > > > +
> > > > +void optee_rpmb_intf_add_rdev(struct rpmb_interface *intf,
> > > > +                             struct rpmb_dev *rdev)
> > > > +{
> > > > +       struct optee *optee =3D container_of(intf, struct optee, rp=
mb_intf);
> > > > +       bool queue_work =3D true;
> > > > +
> > > > +       mutex_lock(&optee->rpmb_dev_mutex);
> > > > +       if (optee->rpmb_dev || optee->rpmb_dev_scan_in_progress) {
> > >
> > > Can we use work_pending() instead of our custom
> > > optee->rpmb_dev_scan_in_progress flag?
> >
> > That seems racy, or am I missing something?
> >
>
> You are right and even work_busy() is documented to provide unreliable
> results. So I am rather thinking about just queuing the work and
> thereby scanning for devices unconditionally. I suppose the extra
> logic to check if we don't try to register duplicate devices can go
> under optee_enumerate_devices().
>
> > >
> > > > +               queue_work =3D false;
> > > > +               if (optee->rpmb_dev_scan_in_progress)
> > > > +                       optee->rpmb_dev_request_rescan =3D true;
> > > > +       }
> > > > +       if (queue_work)
> > > > +               optee->rpmb_dev_scan_in_progress =3D true;
> > > > +       mutex_unlock(&optee->rpmb_dev_mutex);
> > > > +
> > > > +       if (queue_work) {
> > > > +               INIT_WORK(&optee->scan_rpmb_work, optee_rpmb_scan);
> > > > +               schedule_work(&optee->scan_rpmb_work);
> > >
> > > Can we reuse optee->scan_bus_work rather than introducing a new one h=
ere?
> >
> > No, both may be active at the same time.
>
> Actually both of them are using system_wq underneath, so it shouldn't
> be a problem if both are active at the same time as they can be queued
> simultaneously, right?

I'm sorry, I don't get it.
Are you suggesting to merge optee_rpmb_scan() and optee_bus_scan()?
If so, how to tell what to do, that is, if tee-supplicant has become
available or of we should scan for RPMB devices?
If not, you can only have one callback at a time in a work_struct.

>
> > We'd have to merge
> > optee_rpmb_scan() and optee_bus_scan(), but I'm not sure it's worth
> > it.
> >
> > >
> > > > +       }
> > > > +}
> > > > +
> > > >  static void optee_bus_scan(struct work_struct *work)
> > > >  {
> > > >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > > > @@ -161,6 +213,7 @@ void optee_release_supp(struct tee_context *ctx=
)
> > > >
> > > >  void optee_remove_common(struct optee *optee)
> > > >  {
> > > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > >         /* Unregister OP-TEE specific client devices on TEE bus */
> > > >         optee_unregister_devices();
> > > >
> > > > @@ -177,6 +230,8 @@ void optee_remove_common(struct optee *optee)
> > > >         tee_shm_pool_free(optee->pool);
> > > >         optee_supp_uninit(&optee->supp);
> > > >         mutex_destroy(&optee->call_queue.mutex);
> > > > +       rpmb_dev_put(optee->rpmb_dev);
> > > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > >  }
> > > >
> > > >  static int smc_abi_rc;
> > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_ab=
i.c
> > > > index ecb5eb079408..befe19ecc30a 100644
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -7,6 +7,7 @@
> > > >
> > > >  #include <linux/arm_ffa.h>
> > > >  #include <linux/errno.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/sched.h>
> > > >  #include <linux/slab.h>
> > > > @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >         optee_cq_init(&optee->call_queue, 0);
> > > >         optee_supp_init(&optee->supp);
> > > >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > > +       mutex_init(&optee->rpmb_dev_mutex);
> > > >         ffa_dev_set_drvdata(ffa_dev, optee);
> > > >         ctx =3D teedev_open(optee->teedev);
> > > >         if (IS_ERR(ctx)) {
> > > > @@ -955,6 +957,8 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >         if (rc)
> > > >                 goto err_unregister_devices;
> > > >
> > > > +       optee->rpmb_intf.add_rdev =3D optee_rpmb_intf_add_rdev;
> > > > +       rpmb_interface_register(&optee->rpmb_intf);
> > > >         pr_info("initialized driver\n");
> > > >         return 0;
> > > >
> > > > @@ -968,6 +972,9 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >         teedev_close_context(ctx);
> > > >  err_rhashtable_free:
> > > >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free=
_fn, NULL);
> > > > +       rpmb_dev_put(optee->rpmb_dev);
> > > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > >         optee_supp_uninit(&optee->supp);
> > > >         mutex_destroy(&optee->call_queue.mutex);
> > > >         mutex_destroy(&optee->ffa.mutex);
> > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/=
optee_private.h
> > > > index 7a5243c78b55..1e4c33baef43 100644
> > > > --- a/drivers/tee/optee/optee_private.h
> > > > +++ b/drivers/tee/optee/optee_private.h
> > > > @@ -8,6 +8,7 @@
> > > >
> > > >  #include <linux/arm-smccc.h>
> > > >  #include <linux/rhashtable.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/semaphore.h>
> > > >  #include <linux/tee_drv.h>
> > > >  #include <linux/types.h>
> > > > @@ -20,11 +21,13 @@
> > > >  /* Some Global Platform error codes used in this driver */
> > > >  #define TEEC_SUCCESS                   0x00000000
> > > >  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> > > > +#define TEEC_ERROR_ITEM_NOT_FOUND      0xFFFF0008
> > > >  #define TEEC_ERROR_NOT_SUPPORTED       0xFFFF000A
> > > >  #define TEEC_ERROR_COMMUNICATION       0xFFFF000E
> > > >  #define TEEC_ERROR_OUT_OF_MEMORY       0xFFFF000C
> > > >  #define TEEC_ERROR_BUSY                        0xFFFF000D
> > > >  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
> > > > +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
> > > >
> > > >  #define TEEC_ORIGIN_COMMS              0x00000002
> > > >
> > > > @@ -197,6 +200,8 @@ struct optee_ops {
> > > >   * @notif:             notification synchronization struct
> > > >   * @supp:              supplicant synchronization struct for RPC t=
o supplicant
> > > >   * @pool:              shared memory pool
> > > > + * @mutex:             mutex protecting @rpmb_dev
> > > > + * @rpmb_dev:          current RPMB device or NULL
> > > >   * @rpc_param_count:   If > 0 number of RPC parameters to make roo=
m for
> > > >   * @scan_bus_done      flag if device registation was already done=
.
> > > >   * @scan_bus_work      workq to scan optee bus and register optee =
drivers
> > > > @@ -215,9 +220,17 @@ struct optee {
> > > >         struct optee_notif notif;
> > > >         struct optee_supp supp;
> > > >         struct tee_shm_pool *pool;
> > > > +       /* Protects rpmb_dev pointer and rpmb_dev_* */
> > > > +       struct mutex rpmb_dev_mutex;
> > >
> > > Given my comments above, do we really need this mutex?
> >
> > I don't see how we can do without the mutex.
>
> See if it is possible with the above mentioned approach.

I don't follow.

Thanks,
Jens

>
> -Sumit

