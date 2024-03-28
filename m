Return-Path: <linux-kernel+bounces-123219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120998904A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367E11C2EE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834212D753;
	Thu, 28 Mar 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoGuG7GZ"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5F5FB90
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642181; cv=none; b=uuMBGptK/JW5YhVZnpOP9QlPPqZOWiIaIMWnFO2QvcZyfSxJ3TsoarMY6o762A+Oc2o+DF2UgVXEXRCgcrHCoh7eBHJ6rbvTvuz168c0+QExVX04DoUJ5zEZD0xmr2bgoEpBSmFvG8drR+0ZFS4KdsQtTjk2Ocn6KadQRwPD8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642181; c=relaxed/simple;
	bh=QyilwjzUBfnxMLZOrNPcYhhU2vb1dOmkDqtlBvsb6A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo7VH51yNlopj416cW3hU2/gFjbhsVOTgX8XtCxttPRL075V9rveiMUlkL+kAKHLBsCsizWWj/+03I0nuVWkFRTAu2GyXrCbYqioudXekzbJKNpjyru5EZvJK/aA5l3LdCvDGFnjjUcahEjJfnYJkRfyCqO5lvoGVGXl7tCN82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YoGuG7GZ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22a96054726so820056fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711642178; x=1712246978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY2zr/9ETNmiz1Shk5GmW/ux5U1XuY7WF1LfJjCCBx0=;
        b=YoGuG7GZgi4CtMF8+Q1CdyQ6KTWpd6sdjuGVbfy9RW4Uhzv1nGIhgceKeh6nrj7aLf
         MGRSq1hNsPeQ+rLj2/m/EhtwGkKuGt9eonjOlO7wyXriQzovmOP9LUtmjiOlInVTCsyx
         Tei4Tr/QdgvSJJiKmLkqKGigpbEKF1kKAYTF5B3bL0GhjvgOzxNTqpYrXLDSI1Q25eXC
         x3SIX57WFBrB75LUGXogjxi69VMR6m4P2Xw+3Tx+Lny301wGI9876tTId/CprEZi1UNI
         0PYoZXLSKdKmhEI7gzS4EEZizoh0TQo13jWMHDo8KnooEBrTO2BU+X7z3tyx6sFrwgJ7
         TH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642178; x=1712246978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY2zr/9ETNmiz1Shk5GmW/ux5U1XuY7WF1LfJjCCBx0=;
        b=gGnDPZ95qLekYwOL+XEW8gS0bwzpPHL1/e0VhZHjTsiQrnd3AWfzmLa6EApARZgQY3
         X+PZfk7he6N+QJNByZzuc5GkjlR0g6hCXIA1juzPHkk6uWw8GL86cFsix22JfJdfYBE3
         fDKOznnmcpKqOTRmFLVmU7qlECttubivKQa6a35SYRW7USTTdOqyTP2Yhd9NHxi9e+V0
         gNXnVU5w/dLmZkOADu1a2G1m9aeQT59BenWalENQubvtQ+rK0ZHVpraAoWQ2/aVZ5U7e
         UIGOxhJf1E222GEV4DNbdmNd3QIOvZmbq+nYQUrLJ6T8iVkcxMO3A5XCeXhtodkn81Sc
         6UOg==
X-Gm-Message-State: AOJu0YyV4LxzH7/D+ZjEqGhW4pzFdB0zVBvnPSg+Ab2ziHQN1ZNiu169
	mP+BqjigdNfQVPVXkMe/YugJv0DGwDYTcQ1fNejZycxft4ekzNsSzOf5Eb4HbfS+KsTKEhCmx0B
	gk8u+pA5MTtfTc/i/5Jxns5+zMrjjVJam7awJfQ==
X-Google-Smtp-Source: AGHT+IFbYvLQTfnHfnoDcTW79nK7t/66/Z67ReJTKAqO9fBksZGujaXGBlMaBeHlbZRFwD6FKZZdHKclBjzRFLlT2JI=
X-Received: by 2002:a05:6871:22c9:b0:22a:107c:4dd9 with SMTP id
 se9-20020a05687122c900b0022a107c4dd9mr3559836oab.56.1711642178422; Thu, 28
 Mar 2024 09:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-4-jens.wiklander@linaro.org> <CAFA6WYOZQwo1qJWXV+W9t6ZChkWJwzg_0mtAJ2K+viHRdvH2ig@mail.gmail.com>
In-Reply-To: <CAFA6WYOZQwo1qJWXV+W9t6ZChkWJwzg_0mtAJ2K+viHRdvH2ig@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 28 Mar 2024 17:09:27 +0100
Message-ID: <CAHUa44H0sV5yYD6b8vb3b=GvFokxC9xgjFFVkj4Dk0YAVm=X7Q@mail.gmail.com>
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

On Fri, Mar 1, 2024 at 11:28=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Jens,
>
> On Tue, 27 Feb 2024 at 21:01, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe an=
d
> > use an RPMB device via the RPBM subsystem instead of passing the RPMB
>
> s/RPBM/RPMB/
>
> Here are other places too in this patch-set.
>
> > frames via tee-supplicant in user space. A fallback mechanism is kept t=
o
> > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > available.
> >
> > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > devices until one is found with the expected RPMB key already
> > programmed.
>
> I would appreciate it if you could add a link to OP-TEE OS changes in
> the cover-letter although I have found them here [1].
>
> [1] https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe/

OK, I'll add a link in the coverletter of the next patch set.

>
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/core.c          |  55 +++++++
> >  drivers/tee/optee/ffa_abi.c       |   7 +
> >  drivers/tee/optee/optee_private.h |  16 ++
> >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> >  drivers/tee/optee/rpc.c           | 233 ++++++++++++++++++++++++++++++
> >  drivers/tee/optee/smc_abi.c       |   6 +
> >  6 files changed, 352 insertions(+)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 3aed554bc8d8..6b32d3e7865b 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/io.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> > +#include <linux/rpmb.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/tee_drv.h>
> > @@ -80,6 +81,57 @@ void optee_pool_op_free_helper(struct tee_shm_pool *=
pool, struct tee_shm *shm,
> >         shm->pages =3D NULL;
> >  }
> >
> > +static void optee_rpmb_scan(struct work_struct *work)
> > +{
> > +       struct optee *optee =3D container_of(work, struct optee, scan_r=
pmb_work);
> > +       bool scan_done =3D false;
> > +       u32 res;
> > +
> > +       do {
> > +               mutex_lock(&optee->rpmb_dev_mutex);
> > +               /* No need to rescan if we haven't started scanning yet=
 */
> > +               optee->rpmb_dev_request_rescan =3D false;
> > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > +
> > +               res =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPM=
B);
> > +               if (res && res !=3D TEE_ERROR_STORAGE_NOT_AVAILABLE)
>
> I suppose this hasn't been tested for a negative case since
> optee_enumerate_devices() won't return this error code (see [2]).
> However, I would prefer to use GP Client error code:
> TEEC_ERROR_ITEM_NOT_FOUND here instead.
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/tee/optee/device.c#n43

I prefer TEE_ERROR_STORAGE_NOT_AVAILABLE since that's the code GP says
a TA should get when storage is unavailable.
TEEC_ERROR_ITEM_NOT_FOUND is less specific. Anyway, I'll need to
translate the code in get_devices().


>
> > +                       pr_info("Scanning for RPMB device: res %#x\n", =
res);
> > +
> > +               mutex_lock(&optee->rpmb_dev_mutex);
> > +               /*
> > +                * If another RPMB device came online while scanning, s=
can one
> > +                * more time, unless we have already found an RPBM devi=
ce.
> > +                */
> > +               scan_done =3D (optee->rpmb_dev ||
>
> I suppose we don't need to check for optee->rpmb_dev here since a
> successful return from
> optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB) would ensure that
> the RPMB device has been found.

That makes sense, I'll check the return value instead.

>
> > +                            !optee->rpmb_dev_request_rescan);
> > +               optee->rpmb_dev_request_rescan =3D false;
> > +               optee->rpmb_dev_scan_in_progress =3D !scan_done;
> > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > +       } while (!scan_done);
> > +}
> > +
> > +void optee_rpmb_intf_add_rdev(struct rpmb_interface *intf,
> > +                             struct rpmb_dev *rdev)
> > +{
> > +       struct optee *optee =3D container_of(intf, struct optee, rpmb_i=
ntf);
> > +       bool queue_work =3D true;
> > +
> > +       mutex_lock(&optee->rpmb_dev_mutex);
> > +       if (optee->rpmb_dev || optee->rpmb_dev_scan_in_progress) {
>
> Can we use work_pending() instead of our custom
> optee->rpmb_dev_scan_in_progress flag?

That seems racy, or am I missing something?

>
> > +               queue_work =3D false;
> > +               if (optee->rpmb_dev_scan_in_progress)
> > +                       optee->rpmb_dev_request_rescan =3D true;
> > +       }
> > +       if (queue_work)
> > +               optee->rpmb_dev_scan_in_progress =3D true;
> > +       mutex_unlock(&optee->rpmb_dev_mutex);
> > +
> > +       if (queue_work) {
> > +               INIT_WORK(&optee->scan_rpmb_work, optee_rpmb_scan);
> > +               schedule_work(&optee->scan_rpmb_work);
>
> Can we reuse optee->scan_bus_work rather than introducing a new one here?

No, both may be active at the same time. We'd have to merge
optee_rpmb_scan() and optee_bus_scan(), but I'm not sure it's worth
it.

>
> > +       }
> > +}
> > +
> >  static void optee_bus_scan(struct work_struct *work)
> >  {
> >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > @@ -161,6 +213,7 @@ void optee_release_supp(struct tee_context *ctx)
> >
> >  void optee_remove_common(struct optee *optee)
> >  {
> > +       rpmb_interface_unregister(&optee->rpmb_intf);
> >         /* Unregister OP-TEE specific client devices on TEE bus */
> >         optee_unregister_devices();
> >
> > @@ -177,6 +230,8 @@ void optee_remove_common(struct optee *optee)
> >         tee_shm_pool_free(optee->pool);
> >         optee_supp_uninit(&optee->supp);
> >         mutex_destroy(&optee->call_queue.mutex);
> > +       rpmb_dev_put(optee->rpmb_dev);
> > +       mutex_destroy(&optee->rpmb_dev_mutex);
> >  }
> >
> >  static int smc_abi_rc;
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index ecb5eb079408..befe19ecc30a 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/arm_ffa.h>
> >  #include <linux/errno.h>
> > +#include <linux/rpmb.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> > @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
> >         optee_cq_init(&optee->call_queue, 0);
> >         optee_supp_init(&optee->supp);
> >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > +       mutex_init(&optee->rpmb_dev_mutex);
> >         ffa_dev_set_drvdata(ffa_dev, optee);
> >         ctx =3D teedev_open(optee->teedev);
> >         if (IS_ERR(ctx)) {
> > @@ -955,6 +957,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
> >         if (rc)
> >                 goto err_unregister_devices;
> >
> > +       optee->rpmb_intf.add_rdev =3D optee_rpmb_intf_add_rdev;
> > +       rpmb_interface_register(&optee->rpmb_intf);
> >         pr_info("initialized driver\n");
> >         return 0;
> >
> > @@ -968,6 +972,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
> >         teedev_close_context(ctx);
> >  err_rhashtable_free:
> >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn,=
 NULL);
> > +       rpmb_dev_put(optee->rpmb_dev);
> > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > +       rpmb_interface_unregister(&optee->rpmb_intf);
> >         optee_supp_uninit(&optee->supp);
> >         mutex_destroy(&optee->call_queue.mutex);
> >         mutex_destroy(&optee->ffa.mutex);
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index 7a5243c78b55..1e4c33baef43 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/arm-smccc.h>
> >  #include <linux/rhashtable.h>
> > +#include <linux/rpmb.h>
> >  #include <linux/semaphore.h>
> >  #include <linux/tee_drv.h>
> >  #include <linux/types.h>
> > @@ -20,11 +21,13 @@
> >  /* Some Global Platform error codes used in this driver */
> >  #define TEEC_SUCCESS                   0x00000000
> >  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> > +#define TEEC_ERROR_ITEM_NOT_FOUND      0xFFFF0008
> >  #define TEEC_ERROR_NOT_SUPPORTED       0xFFFF000A
> >  #define TEEC_ERROR_COMMUNICATION       0xFFFF000E
> >  #define TEEC_ERROR_OUT_OF_MEMORY       0xFFFF000C
> >  #define TEEC_ERROR_BUSY                        0xFFFF000D
> >  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
> > +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
> >
> >  #define TEEC_ORIGIN_COMMS              0x00000002
> >
> > @@ -197,6 +200,8 @@ struct optee_ops {
> >   * @notif:             notification synchronization struct
> >   * @supp:              supplicant synchronization struct for RPC to su=
pplicant
> >   * @pool:              shared memory pool
> > + * @mutex:             mutex protecting @rpmb_dev
> > + * @rpmb_dev:          current RPMB device or NULL
> >   * @rpc_param_count:   If > 0 number of RPC parameters to make room fo=
r
> >   * @scan_bus_done      flag if device registation was already done.
> >   * @scan_bus_work      workq to scan optee bus and register optee driv=
ers
> > @@ -215,9 +220,17 @@ struct optee {
> >         struct optee_notif notif;
> >         struct optee_supp supp;
> >         struct tee_shm_pool *pool;
> > +       /* Protects rpmb_dev pointer and rpmb_dev_* */
> > +       struct mutex rpmb_dev_mutex;
>
> Given my comments above, do we really need this mutex?

I don't see how we can do without the mutex.

>
> > +       struct rpmb_dev *rpmb_dev;
> > +       bool rpmb_dev_scan_in_progress;
> > +       bool rpmb_dev_request_rescan;
> > +       bool rpmb_dev_scan_done;
>
> Left over, should it be dropped?

Thanks, I'll remove it.

>
> > +       struct rpmb_interface rpmb_intf;
> >         unsigned int rpc_param_count;
> >         bool   scan_bus_done;
> >         struct work_struct scan_bus_work;
> > +       struct work_struct scan_rpmb_work;
> >  };
> >
> >  struct optee_session {
> > @@ -280,8 +293,11 @@ int optee_cancel_req(struct tee_context *ctx, u32 =
cancel_id, u32 session);
> >
> >  #define PTA_CMD_GET_DEVICES            0x0
> >  #define PTA_CMD_GET_DEVICES_SUPP       0x1
> > +#define PTA_CMD_GET_DEVICES_RPMB       0x2
> >  int optee_enumerate_devices(u32 func);
> >  void optee_unregister_devices(void);
> > +void optee_rpmb_intf_add_rdev(struct rpmb_interface *intf,
> > +                             struct rpmb_dev *rdev);
> >
> >  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> >                                size_t size, size_t align,
> > diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/opte=
e_rpc_cmd.h
> > index f3f06e0994a7..f351a8ac69fc 100644
> > --- a/drivers/tee/optee/optee_rpc_cmd.h
> > +++ b/drivers/tee/optee/optee_rpc_cmd.h
> > @@ -16,6 +16,14 @@
> >   * and sends responses.
> >   */
> >
> > +/*
> > + * Replay Protected Memory Block access
> > + *
> > + * [in]     memref[0]      Frames to device
> > + * [out]    memref[1]      Frames from device
> > + */
> > +#define OPTEE_RPC_CMD_RPMB             1
> > +
> >  /*
> >   * Get time
> >   *
> > @@ -103,4 +111,31 @@
> >  /* I2C master control flags */
> >  #define OPTEE_RPC_I2C_FLAGS_TEN_BIT    BIT(0)
> >
> > +/*
> > + * Reset RPMB probing
> > + *
> > + * Releases an eventually already used RPMB devices and starts over se=
arching
> > + * for RPMB devices. Returns the kind of shared memory to use in subse=
quent
> > + * OPTEE_RPC_CMD_RPMB_PROBE_NEXT and OPTEE_RPC_CMD_RPMB calls.
> > + *
> > + * [out]    value[0].a     OPTEE_RPC_SHM_TYPE_*, the parameter for
> > + *                         OPTEE_RPC_CMD_SHM_ALLOC
> > + */
> > +#define OPTEE_RPC_CMD_RPMB_PROBE_RESET 22
> > +
> > +/*
> > + * Probe next RPMB device
> > + *
> > + * [out]    value[0].a     Type of RPMB device, OPTEE_RPC_RPMB_*
> > + * [out]    value[0].b     EXT CSD-slice 168 "RPMB Size"
> > + * [out]    value[0].c     EXT CSD-slice 222 "Reliable Write Sector Co=
unt"
> > + * [out]    memref[1]       Buffer with the raw CID
> > + */
> > +#define OPTEE_RPC_CMD_RPMB_PROBE_NEXT  23
> > +
> > +/* Type of RPMB device */
> > +#define OPTEE_RPC_RPMB_EMMC            0
> > +#define OPTEE_RPC_RPMB_UFS             1
> > +#define OPTEE_RPC_RPMB_NVME            2
> > +
> >  #endif /*__OPTEE_RPC_CMD_H*/
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index e69bc6380683..97f69a108f61 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> > +#include <linux/rpmb.h>
> >  #include <linux/slab.h>
> >  #include <linux/tee_drv.h>
> >  #include "optee_private.h"
> > @@ -255,6 +256,229 @@ void optee_rpc_cmd_free_suppl(struct tee_context =
*ctx, struct tee_shm *shm)
> >         optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
> >  }
> >
> > +static void handle_rpc_func_rpmb_probe_reset(struct tee_context *ctx,
> > +                                            struct optee *optee,
> > +                                            struct optee_msg_arg *arg)
> > +{
> > +       struct tee_param params[1];
> > +
> > +       if (!IS_ENABLED(CONFIG_RPMB)) {
> > +               handle_rpc_supp_cmd(ctx, optee, arg);
> > +               return;
> > +       }
> > +
> > +       if (arg->num_params !=3D ARRAY_SIZE(params) ||
> > +           optee->ops->from_msg_param(optee, params, arg->num_params,
> > +                                      arg->params) ||
> > +           params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT)=
 {
> > +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +               return;
> > +       }
> > +
> > +       params[0].u.value.a =3D OPTEE_RPC_SHM_TYPE_KERNEL;
> > +       params[0].u.value.b =3D 0;
> > +       params[0].u.value.c =3D 0;
> > +       if (optee->ops->to_msg_param(optee, arg->params,
> > +                                    arg->num_params, params)) {
> > +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +               return;
> > +       }
> > +
> > +       mutex_lock(&optee->rpmb_dev_mutex);
> > +       rpmb_dev_put(optee->rpmb_dev);
> > +       optee->rpmb_dev =3D NULL;
> > +       mutex_unlock(&optee->rpmb_dev_mutex);
> > +
> > +       arg->ret =3D TEEC_SUCCESS;
> > +}
> > +
> > +static int rpmb_type_to_rpc_type(enum rpmb_type rtype)
> > +{
> > +       switch (rtype) {
> > +       case RPMB_TYPE_EMMC:
> > +               return OPTEE_RPC_RPMB_EMMC;
> > +       case RPMB_TYPE_UFS:
> > +               return OPTEE_RPC_RPMB_UFS;
> > +       case RPMB_TYPE_NVME:
> > +               return OPTEE_RPC_RPMB_NVME;
> > +       default:
> > +               return -1;
> > +       }
> > +}
> > +
> > +static int rpc_rpmb_match(struct rpmb_dev *rdev, const void *data)
> > +{
> > +       return rpmb_type_to_rpc_type(rdev->ops->type) >=3D 0;
> > +}
> > +
> > +static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
> > +                                           struct optee *optee,
> > +                                           struct optee_msg_arg *arg)
> > +{
> > +       struct rpmb_dev *rdev;
> > +       struct tee_param params[2];
> > +       void *buf;
> > +
> > +       if (!IS_ENABLED(CONFIG_RPMB)) {
>
> What if the RPMB driver is built as a module? IS_REACHABLE() instead?

OK, I'll update.

Thanks,
Jens

>
> -Sumit
>
> > +               handle_rpc_supp_cmd(ctx, optee, arg);
> > +               return;
> > +       }
> > +
> > +       if (arg->num_params !=3D ARRAY_SIZE(params) ||
> > +           optee->ops->from_msg_param(optee, params, arg->num_params,
> > +                                      arg->params) ||
> > +           params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT =
||
> > +           params[1].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT=
) {
> > +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +               return;
> > +       }
> > +       buf =3D tee_shm_get_va(params[1].u.memref.shm,
> > +                            params[1].u.memref.shm_offs);
> > +       if (!buf) {
> > +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +               return;
> > +       }
> > +
> > +       mutex_lock(&optee->rpmb_dev_mutex);
> > +       rdev =3D rpmb_dev_find_device(NULL, optee->rpmb_dev, rpc_rpmb_m=
atch);
> > +       rpmb_dev_put(optee->rpmb_dev);
> > +       optee->rpmb_dev =3D rdev;
> > +       mutex_unlock(&optee->rpmb_dev_mutex);
> > +
> > +       if (!rdev) {
> > +               arg->ret =3D TEEC_ERROR_ITEM_NOT_FOUND;
> > +               return;
> > +       }
> > +
> > +       if (params[1].u.memref.size < rdev->dev_id_len) {
> > +               arg->ret =3D TEEC_ERROR_SHORT_BUFFER;
> > +               return;
> > +       }
> > +       memcpy(buf, rdev->dev_id, rdev->dev_id_len);
> > +       params[1].u.memref.size =3D rdev->dev_id_len;
> > +       params[0].u.value.a =3D rpmb_type_to_rpc_type(rdev->ops->type);
> > +       params[0].u.value.b =3D rdev->capacity;
> > +       params[0].u.value.c =3D rdev->reliable_wr_count;
> > +       if (optee->ops->to_msg_param(optee, arg->params,
> > +                                    arg->num_params, params)) {
> > +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +               return;
> > +       }
> > +
> > +       arg->ret =3D TEEC_SUCCESS;
> > +}
> > +
> > +/* Request */
> > +struct rpmb_req {
> > +       u16 cmd;
> > +#define RPMB_CMD_DATA_REQ      0x00
> > +#define RPMB_CMD_GET_DEV_INFO  0x01
> > +       u16 dev_id;
> > +       u16 block_count;
> > +       /* Optional data frames (rpmb_data_frame) follow */
> > +};
> > +
> > +#define RPMB_REQ_DATA(req) ((void *)((struct rpmb_req *)(req) + 1))
> > +
> > +#define RPMB_CID_SZ 16
> > +
> > +/* Response to device info request */
> > +struct rpmb_dev_info {
> > +       u8 cid[RPMB_CID_SZ];
> > +       u8 rpmb_size_mult;      /* EXT CSD-slice 168: RPMB Size */
> > +       u8 rel_wr_sec_c;        /* EXT CSD-slice 222: Reliable Write Se=
ctor */
> > +                               /*                    Count */
> > +       u8 ret_code;
> > +#define RPMB_CMD_GET_DEV_INFO_RET_OK     0x00
> > +#define RPMB_CMD_GET_DEV_INFO_RET_ERROR  0x01
> > +};
> > +
> > +static int get_dev_info(struct rpmb_dev *rdev, void *rsp, size_t rsp_s=
ize)
> > +{
> > +       struct rpmb_dev_info *dev_info;
> > +
> > +       if (rsp_size !=3D sizeof(*dev_info))
> > +               return TEEC_ERROR_BAD_PARAMETERS;
> > +
> > +       dev_info =3D rsp;
> > +       memcpy(dev_info->cid, rdev->dev_id, sizeof(dev_info->cid));
> > +       dev_info->rpmb_size_mult =3D rdev->capacity;
> > +       dev_info->rel_wr_sec_c =3D rdev->reliable_wr_count;
> > +       dev_info->ret_code =3D RPMB_CMD_GET_DEV_INFO_RET_OK;
> > +
> > +       return TEEC_SUCCESS;
> > +}
> > +
> > +/*
> > + * req is one struct rpmb_req followed by one or more struct rpmb_data=
_frame
> > + * rsp is either one struct rpmb_dev_info or one or more struct rpmb_d=
ata_frame
> > + */
> > +static u32 rpmb_process_request(struct optee *optee, struct rpmb_dev *=
rdev,
> > +                               void *req, size_t req_size,
> > +                               void *rsp, size_t rsp_size)
> > +{
> > +       struct rpmb_req *sreq =3D req;
> > +       int rc;
> > +
> > +       if (req_size < sizeof(*sreq))
> > +               return TEEC_ERROR_BAD_PARAMETERS;
> > +
> > +       switch (sreq->cmd) {
> > +       case RPMB_CMD_DATA_REQ:
> > +               rc =3D rpmb_route_frames(rdev, RPMB_REQ_DATA(req),
> > +                                      req_size - sizeof(struct rpmb_re=
q),
> > +                                      rsp, rsp_size);
> > +               if (rc)
> > +                       return TEEC_ERROR_BAD_PARAMETERS;
> > +               return TEEC_SUCCESS;
> > +       case RPMB_CMD_GET_DEV_INFO:
> > +               return get_dev_info(rdev, rsp, rsp_size);
> > +       default:
> > +               return TEEC_ERROR_BAD_PARAMETERS;
> > +       }
> > +}
> > +
> > +static void handle_rpc_func_rpmb(struct tee_context *ctx, struct optee=
 *optee,
> > +                                struct optee_msg_arg *arg)
> > +{
> > +       struct tee_param params[2];
> > +       struct rpmb_dev *rdev;
> > +       void *p0, *p1;
> > +
> > +       mutex_lock(&optee->rpmb_dev_mutex);
> > +       rdev =3D rpmb_dev_get(optee->rpmb_dev);
> > +       mutex_unlock(&optee->rpmb_dev_mutex);
> > +       if (!rdev) {
> > +               handle_rpc_supp_cmd(ctx, optee, arg);
> > +               return;
> > +       }
> > +
> > +       if (arg->num_params !=3D ARRAY_SIZE(params) ||
> > +           optee->ops->from_msg_param(optee, params, arg->num_params,
> > +                                      arg->params) ||
> > +           params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT =
||
> > +           params[1].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT=
) {
> > +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +               goto out;
> > +       }
> > +
> > +       p0 =3D tee_shm_get_va(params[0].u.memref.shm,
> > +                           params[0].u.memref.shm_offs);
> > +       p1 =3D tee_shm_get_va(params[1].u.memref.shm,
> > +                           params[1].u.memref.shm_offs);
> > +       arg->ret =3D rpmb_process_request(optee, rdev, p0,
> > +                                       params[0].u.memref.size,
> > +                                       p1, params[1].u.memref.size);
> > +       if (arg->ret)
> > +               goto out;
> > +
> > +       if (optee->ops->to_msg_param(optee, arg->params,
> > +                                    arg->num_params, params))
> > +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +out:
> > +       rpmb_dev_put(rdev);
> > +}
> > +
> >  void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
> >                    struct optee_msg_arg *arg)
> >  {
> > @@ -271,6 +495,15 @@ void optee_rpc_cmd(struct tee_context *ctx, struct=
 optee *optee,
> >         case OPTEE_RPC_CMD_I2C_TRANSFER:
> >                 handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> >                 break;
> > +       case OPTEE_RPC_CMD_RPMB_PROBE_RESET:
> > +               handle_rpc_func_rpmb_probe_reset(ctx, optee, arg);
> > +               break;
> > +       case OPTEE_RPC_CMD_RPMB_PROBE_NEXT:
> > +               handle_rpc_func_rpmb_probe_next(ctx, optee, arg);
> > +               break;
> > +       case OPTEE_RPC_CMD_RPMB:
> > +               handle_rpc_func_rpmb(ctx, optee, arg);
> > +               break;
> >         default:
> >                 handle_rpc_supp_cmd(ctx, optee, arg);
> >         }
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a37f87087e5c..8da53f41b052 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/rpmb.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > @@ -1715,6 +1716,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >         optee->smc.memremaped_shm =3D memremaped_shm;
> >         optee->pool =3D pool;
> >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > +       mutex_init(&optee->rpmb_dev_mutex);
> >
> >         platform_set_drvdata(pdev, optee);
> >         ctx =3D teedev_open(optee->teedev);
> > @@ -1769,6 +1771,8 @@ static int optee_probe(struct platform_device *pd=
ev)
> >         if (rc)
> >                 goto err_disable_shm_cache;
> >
> > +       optee->rpmb_intf.add_rdev =3D optee_rpmb_intf_add_rdev;
> > +       rpmb_interface_register(&optee->rpmb_intf);
> >         pr_info("initialized driver\n");
> >         return 0;
> >
> > @@ -1782,6 +1786,8 @@ static int optee_probe(struct platform_device *pd=
ev)
> >  err_close_ctx:
> >         teedev_close_context(ctx);
> >  err_supp_uninit:
> > +       rpmb_dev_put(optee->rpmb_dev);
> > +       mutex_destroy(&optee->rpmb_dev_mutex);
> >         optee_shm_arg_cache_uninit(optee);
> >         optee_supp_uninit(&optee->supp);
> >         mutex_destroy(&optee->call_queue.mutex);
> > --
> > 2.34.1
> >

