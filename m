Return-Path: <linux-kernel+bounces-82780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA5868998
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AAB284930
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7514A5465D;
	Tue, 27 Feb 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzfFSuu8"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A453E01
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017724; cv=none; b=nD3w+4C7RbSDFLhYaibNgWk0EDOk0mLHJJOUjZQWrrXN2GzhOf9rG7vQ28KKt+rq/cTvf1X11Yz3ZXg1id8pBvytQvWS6EDHMq/MhtzoF90hJDo40RsKBVMIMewqyJzvVL/HyFtJbX9RyNPCnv/S+SBjAmw0zL1ZdYzhrh/YUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017724; c=relaxed/simple;
	bh=TTstN1GTRgt+2/kCorVMSWSDJvmQ282RRRozcg2hxWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsXrpVM8eTAGhF7mynOJO2DxLMuK4kLxrMLEChX9msX0p/LL5FWomfd4/F6bb4KwP2NlehBkwmBfBYXYhpmICruVeIDTDgj3dlIw/kWE60R+H64krGbgQ6I0v9xGZDOwJkJKFEmzwTXs2a0EAXO7jvpCay5+oaa7mZnWJd27QzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FzfFSuu8; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7da9bec3038so665369241.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709017721; x=1709622521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gMVfPHhF8ybe+9mUZaXQdJEg9yRCJ8YFPcf9Fmx8kz0=;
        b=FzfFSuu8tQdTWiu5RcU+YHM0cRu1sHFXX+pBN3lLcfrdgzjUrrzKS+LIw0mUogZihF
         AvomSSbkAEv+1lQLTRMWCxaldQrn/VnNii0v69jLwinrVhNLymx2O+A13hjHcQU9Td3Z
         36wotXP6HL2h3PvQTpsTLTN/H9a79R004EY3aTimT7R9ZKiudAcF/pUrMxFZQH9bWrsl
         nmmdb5ykToaJ2CwFF8OEmH4LU2gMHEkQAoM8e2T93/NjWjNFATACjGdErm/DK7UqHv2L
         ADS7oRNTBPlJGvVLM3UqDSMgjeKrZ+mXYFualmhHYhp5OHntDVOWWA3iZDGlFihWo55G
         CG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017721; x=1709622521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMVfPHhF8ybe+9mUZaXQdJEg9yRCJ8YFPcf9Fmx8kz0=;
        b=fUamW3RWhiLTVw/a9QpLEq3CvXI2LILFN6/zauKGNd546M9RHqqZYml1d4/xa2ABG0
         hbouLhCvUZOUk4XdOY5zvu8RSUgNtLSa6Qeg9QAjj4o1vp8qe5RC4qMzlGRAZC1PA5Ze
         cZY/1UkUztrjs5cUFzPifqPgc2GDjtLAL67dQ4KeVdYAQxTlZVsgT+Gjsv9g1SWK176J
         VSKPwRiNG1OUQlS70So95Zojh0YEyh1UtIyJ2lbEMDpA340Rm/GDC1ZC7THCE3QzFkVB
         JBnLBClnvBj+EEBU6Nwz3t59TX5P8R/rDWa0IJRRX6tRuKFvS11U8yQglMdn3dUF5SQ4
         gHtw==
X-Forwarded-Encrypted: i=1; AJvYcCWVdmTvFKLnGxNX+ev9lhTU8l0eQlIIgMAVTC7NZ4LE+O/bhTpQGeJQ5B2JI92QHnjYC0nfmQUcjC5OtiriEz/ufgs96KqdFFwC2hui
X-Gm-Message-State: AOJu0YzkTEkEC8ogsl6L7Y1ilec7bZ3aAElfchuPYVkq9z4SnybrTpKt
	OSGDYVOaDaqisAroaVb6+dygQN3oaBD7PldE31XLgyMjYv/N5ReacCMT0KBZ+yv6prObqTZvYc/
	Ar8VcUVQTkOwi6cyxJMxIG/6aPhmVHJLUKu9LSg==
X-Google-Smtp-Source: AGHT+IHuOGPj32xjXnnHUnBCVv3JkMuR8dkG9XtpF4kSOC3xku8esHpvpiX0Jz41j2/ENqYlpWzzqb3SBjc90KaA46Y=
X-Received: by 2002:a05:6102:1272:b0:471:e077:c9c5 with SMTP id
 q18-20020a056102127200b00471e077c9c5mr4141880vsg.5.1709017721372; Mon, 26 Feb
 2024 23:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223095133.109046-1-balint.dobszay@arm.com> <20240223095133.109046-3-balint.dobszay@arm.com>
In-Reply-To: <20240223095133.109046-3-balint.dobszay@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 27 Feb 2024 12:38:30 +0530
Message-ID: <CAFA6WYOKtxGTU33BY_z1H01UF41rm6g-LTxUi-DX4CJrV-aT3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tee: tstee: Add Trusted Services TEE driver
To: Balint Dobszay <balint.dobszay@arm.com>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 15:22, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> The Trusted Services project provides a framework for developing and
> deploying device Root of Trust services in FF-A Secure Partitions. The
> FF-A SPs are accessible through the FF-A driver, but this doesn't
> provide a user space interface. The goal of this TEE driver is to make
> Trusted Services SPs accessible for user space clients.
>
> All TS SPs have the same FF-A UUID, it identifies the RPC protocol used
> by TS. A TS SP can host one or more services, a service is identified by
> its service UUID. The same type of service cannot be present twice in
> the same SP. During SP boot each service in an SP is assigned an
> interface ID, this is just a short ID to simplify message addressing.
> There is 1:1 mapping between TS SPs and TEE devices, i.e. a separate TEE
> device is registered for each TS SP. This is required since contrary to
> the generic TEE design where memory is shared with the whole TEE
> implementation, in case of FF-A, memory is shared with a specific SP. A
> user space client has to be able to separately share memory with each SP
> based on its endpoint ID.
>
> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  drivers/tee/Kconfig               |   1 +
>  drivers/tee/Makefile              |   1 +
>  drivers/tee/tstee/Kconfig         |  11 +
>  drivers/tee/tstee/Makefile        |   3 +
>  drivers/tee/tstee/core.c          | 490 ++++++++++++++++++++++++++++++
>  drivers/tee/tstee/tstee_private.h |  94 ++++++
>  include/uapi/linux/tee.h          |   1 +
>  7 files changed, 601 insertions(+)
>  create mode 100644 drivers/tee/tstee/Kconfig
>  create mode 100644 drivers/tee/tstee/Makefile
>  create mode 100644 drivers/tee/tstee/core.c
>  create mode 100644 drivers/tee/tstee/tstee_private.h
>
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index 73a147202e88..61b507c18780 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -15,5 +15,6 @@ if TEE
>
>  source "drivers/tee/optee/Kconfig"
>  source "drivers/tee/amdtee/Kconfig"
> +source "drivers/tee/tstee/Kconfig"
>
>  endif
> diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
> index 68da044afbfa..5488cba30bd2 100644
> --- a/drivers/tee/Makefile
> +++ b/drivers/tee/Makefile
> @@ -5,3 +5,4 @@ tee-objs += tee_shm.o
>  tee-objs += tee_shm_pool.o
>  obj-$(CONFIG_OPTEE) += optee/
>  obj-$(CONFIG_AMDTEE) += amdtee/
> +obj-$(CONFIG_ARM_TSTEE) += tstee/
> diff --git a/drivers/tee/tstee/Kconfig b/drivers/tee/tstee/Kconfig
> new file mode 100644
> index 000000000000..d32f91d47398
> --- /dev/null
> +++ b/drivers/tee/tstee/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config ARM_TSTEE
> +       tristate "Arm Trusted Services TEE driver"
> +       depends on ARM_FFA_TRANSPORT
> +       default n
> +       help
> +         The Trusted Services project provides a framework for developing and
> +         deploying device Root of Trust services in FF-A Secure Partitions.
> +         This driver provides an interface to make Trusted Services Secure
> +         Partitions accessible for user space clients, since the FF-A driver
> +         doesn't implement a user space interface directly.
> diff --git a/drivers/tee/tstee/Makefile b/drivers/tee/tstee/Makefile
> new file mode 100644
> index 000000000000..5227020ebd30
> --- /dev/null
> +++ b/drivers/tee/tstee/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +arm-tstee-objs := core.o
> +obj-$(CONFIG_ARM_TSTEE) = arm-tstee.o
> diff --git a/drivers/tee/tstee/core.c b/drivers/tee/tstee/core.c
> new file mode 100644
> index 000000000000..2932be017dbe
> --- /dev/null
> +++ b/drivers/tee/tstee/core.c
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Arm Limited
> + */
> +
> +#define DRIVER_NAME "Arm TSTEE"
> +#define pr_fmt(fmt) DRIVER_NAME ": " fmt
> +
> +#include <linux/arm_ffa.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/limits.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/tee_drv.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +
> +#include "tstee_private.h"
> +
> +#define FFA_DIRECT_REQ_ARG_NUM 5
> +#define FFA_INVALID_MEM_HANDLE U64_MAX
> +
> +static void arg_list_to_ffa_data(const u32 *args,
> +                                struct ffa_send_direct_data *data)
> +{
> +       data->data0 = args[0];
> +       data->data1 = args[1];
> +       data->data2 = args[2];
> +       data->data3 = args[3];
> +       data->data4 = args[4];
> +}
> +
> +static void arg_list_from_ffa_data(const struct ffa_send_direct_data *data,
> +                                  u32 *args)
> +{
> +       args[0] = lower_32_bits(data->data0);
> +       args[1] = lower_32_bits(data->data1);
> +       args[2] = lower_32_bits(data->data2);
> +       args[3] = lower_32_bits(data->data3);
> +       args[4] = lower_32_bits(data->data4);
> +}
> +
> +static void tstee_get_version(struct tee_device *teedev,
> +                             struct tee_ioctl_version_data *vers)
> +{
> +       struct tstee *tstee = tee_get_drvdata(teedev);
> +       struct tee_ioctl_version_data v = {
> +               .impl_id = TEE_IMPL_ID_TSTEE,
> +               /* FF-A endpoint ID only uses the lower 16 bits */
> +               .impl_caps = lower_16_bits(tstee->ffa_dev->vm_id),
> +               .gen_caps = 0,
> +       };
> +
> +       *vers = v;
> +}
> +
> +static int tstee_open(struct tee_context *ctx)
> +{
> +       struct ts_context_data *ctxdata;
> +
> +       ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
> +       if (!ctxdata)
> +               return -ENOMEM;
> +
> +       mutex_init(&ctxdata->mutex);
> +       xa_init_flags(&ctxdata->sess_list, XA_FLAGS_ALLOC);
> +
> +       ctx->data = ctxdata;
> +
> +       return 0;
> +}
> +
> +static void tstee_release(struct tee_context *ctx)
> +{
> +       struct ts_context_data *ctxdata = ctx->data;
> +       struct ts_session *sess;
> +       unsigned long idx;
> +
> +       if (!ctxdata)
> +               return;
> +
> +       xa_for_each(&ctxdata->sess_list, idx, sess) {
> +               xa_erase(&ctxdata->sess_list, idx);
> +               kfree(sess);
> +       }
> +
> +       xa_destroy(&ctxdata->sess_list);
> +       mutex_destroy(&ctxdata->mutex);
> +
> +       kfree(ctxdata);
> +       ctx->data = NULL;
> +}
> +
> +static int tstee_open_session(struct tee_context *ctx,
> +                             struct tee_ioctl_open_session_arg *arg,
> +                             struct tee_param *param __always_unused)
> +{
> +       struct tstee *tstee = tee_get_drvdata(ctx->teedev);
> +       struct ffa_device *ffa_dev = tstee->ffa_dev;
> +       struct ts_context_data *ctxdata = ctx->data;
> +       struct ffa_send_direct_data ffa_data;
> +       struct ts_session *sess = NULL;
> +       u32 ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
> +       u32 sess_id;
> +       int rc;
> +
> +       ffa_args[TS_RPC_CTRL_REG] =
> +               TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFACE_ID,
> +                                             TS_RPC_OP_SERVICE_INFO);
> +
> +       memcpy(ffa_args + TS_RPC_SERVICE_INFO_UUID0, arg->uuid, UUID_SIZE);
> +
> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
> +       rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
> +       if (rc)
> +               return rc;
> +
> +       arg_list_from_ffa_data(&ffa_data, ffa_args);
> +
> +       if (ffa_args[TS_RPC_SERVICE_INFO_RPC_STATUS] != TS_RPC_OK)
> +               return -ENODEV;
> +
> +       if (ffa_args[TS_RPC_SERVICE_INFO_IFACE] > U8_MAX)
> +               return -EINVAL;
> +
> +       sess = kzalloc(sizeof(*sess), GFP_KERNEL);
> +       if (!sess)
> +               return -ENOMEM;
> +
> +       sess->iface_id = ffa_args[TS_RPC_SERVICE_INFO_IFACE];
> +
> +       rc = xa_alloc(&ctxdata->sess_list, &sess_id, sess, xa_limit_32b,
> +                     GFP_KERNEL);
> +       if (rc) {
> +               kfree(sess);
> +               return rc;
> +       }
> +
> +       arg->session = sess_id;
> +       arg->ret = 0;
> +
> +       return 0;
> +}
> +
> +static int tstee_close_session(struct tee_context *ctx, u32 session)
> +{
> +       struct ts_context_data *ctxdata = ctx->data;
> +       struct ts_session *sess;
> +
> +       mutex_lock(&ctxdata->mutex);
> +       sess = xa_erase(&ctxdata->sess_list, session);
> +       mutex_unlock(&ctxdata->mutex);
> +       if (!sess)
> +               return -EINVAL;
> +
> +       kfree(sess);
> +
> +       return 0;
> +}
> +
> +static int tstee_invoke_func(struct tee_context *ctx,
> +                            struct tee_ioctl_invoke_arg *arg,
> +                            struct tee_param *param)
> +{
> +       struct tstee *tstee = tee_get_drvdata(ctx->teedev);
> +       struct ffa_device *ffa_dev = tstee->ffa_dev;
> +       struct ts_context_data *ctxdata = ctx->data;
> +       struct ffa_send_direct_data ffa_data;
> +       struct tee_shm *shm = NULL;
> +       struct ts_session *sess;
> +       u32 req_len, ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
> +       int shm_id, rc;
> +       u8 iface_id;
> +       u64 handle;
> +       u16 opcode;
> +
> +       mutex_lock(&ctxdata->mutex);
> +       sess = xa_load(&ctxdata->sess_list, arg->session);
> +
> +       /*
> +        * Do this while holding the mutex to make sure that the session wasn't
> +        * closed meanwhile
> +        */
> +       if (sess)
> +               iface_id = sess->iface_id;
> +
> +       mutex_unlock(&ctxdata->mutex);
> +       if (!sess)
> +               return -EINVAL;
> +

We can drop usage of mutex here and other places via reusing
xa_lock(), something like below should work:

        xa_lock(&ctxdata->sess_list);

        sess = xa_load(&ctxdata->sess_list, arg->session);
        if (sess)
                iface_id = sess->iface_id;

        xa_unlock(&ctxdata->sess_list);

-Sumit

> +       opcode = lower_16_bits(arg->func);
> +       shm_id = lower_32_bits(param[0].u.value.a);
> +       req_len = lower_32_bits(param[0].u.value.b);
> +
> +       if (shm_id != 0) {
> +               shm = tee_shm_get_from_id(ctx, shm_id);
> +               if (IS_ERR(shm))
> +                       return PTR_ERR(shm);
> +
> +               if (shm->size < req_len) {
> +                       pr_err("request doesn't fit into shared memory buffer\n");
> +                       rc = -EINVAL;
> +                       goto out;
> +               }
> +
> +               handle = shm->sec_world_id;
> +       } else {
> +               handle = FFA_INVALID_MEM_HANDLE;
> +       }
> +
> +       ffa_args[TS_RPC_CTRL_REG] = TS_RPC_CTRL_PACK_IFACE_OPCODE(iface_id,
> +                                                                 opcode);
> +       ffa_args[TS_RPC_SERVICE_MEM_HANDLE_LSW] = lower_32_bits(handle);
> +       ffa_args[TS_RPC_SERVICE_MEM_HANDLE_MSW] = upper_32_bits(handle);
> +       ffa_args[TS_RPC_SERVICE_REQ_LEN] = req_len;
> +       ffa_args[TS_RPC_SERVICE_CLIENT_ID] = 0;
> +
> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
> +       rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
> +       if (rc)
> +               goto out;
> +
> +       arg_list_from_ffa_data(&ffa_data, ffa_args);
> +
> +       if (ffa_args[TS_RPC_SERVICE_RPC_STATUS] != TS_RPC_OK) {
> +               pr_err("invoke_func rpc status: %d\n",
> +                      ffa_args[TS_RPC_SERVICE_RPC_STATUS]);
> +               rc = -EINVAL;
> +               goto out;
> +       }
> +
> +       arg->ret = ffa_args[TS_RPC_SERVICE_STATUS];
> +       if (shm && shm->size >= ffa_args[TS_RPC_SERVICE_RESP_LEN])
> +               param[0].u.value.a = ffa_args[TS_RPC_SERVICE_RESP_LEN];
> +
> +out:
> +       if (shm)
> +               tee_shm_put(shm);
> +
> +       return rc;
> +}
> +
> +static int tstee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> +                             struct page **pages, size_t num_pages,
> +                             unsigned long start __always_unused)
> +{
> +       struct tstee *tstee = tee_get_drvdata(ctx->teedev);
> +       struct ffa_device *ffa_dev = tstee->ffa_dev;
> +       struct ffa_mem_region_attributes mem_attr = {
> +               .receiver = tstee->ffa_dev->vm_id,
> +               .attrs = FFA_MEM_RW,
> +               .flag = 0,
> +       };
> +       struct ffa_mem_ops_args mem_args = {
> +               .attrs = &mem_attr,
> +               .use_txbuf = true,
> +               .nattrs = 1,
> +               .flags = 0,
> +       };
> +       struct ffa_send_direct_data ffa_data;
> +       struct sg_table sgt;
> +       u32 ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
> +       int rc;
> +
> +       rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, 0,
> +                                      num_pages * PAGE_SIZE, GFP_KERNEL);
> +       if (rc)
> +               return rc;
> +
> +       mem_args.sg = sgt.sgl;
> +       rc = ffa_dev->ops->mem_ops->memory_share(&mem_args);
> +       sg_free_table(&sgt);
> +       if (rc)
> +               return rc;
> +
> +       shm->sec_world_id = mem_args.g_handle;
> +
> +       ffa_args[TS_RPC_CTRL_REG] =
> +                       TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFACE_ID,
> +                                                     TS_RPC_OP_RETRIEVE_MEM);
> +       ffa_args[TS_RPC_RETRIEVE_MEM_HANDLE_LSW] =
> +                       lower_32_bits(shm->sec_world_id);
> +       ffa_args[TS_RPC_RETRIEVE_MEM_HANDLE_MSW] =
> +                       upper_32_bits(shm->sec_world_id);
> +       ffa_args[TS_RPC_RETRIEVE_MEM_TAG_LSW] = 0;
> +       ffa_args[TS_RPC_RETRIEVE_MEM_TAG_MSW] = 0;
> +
> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
> +       rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
> +       if (rc) {
> +               (void)ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id,
> +                                                           0);
> +               return rc;
> +       }
> +
> +       arg_list_from_ffa_data(&ffa_data, ffa_args);
> +
> +       if (ffa_args[TS_RPC_RETRIEVE_MEM_RPC_STATUS] != TS_RPC_OK) {
> +               pr_err("shm_register rpc status: %d\n",
> +                      ffa_args[TS_RPC_RETRIEVE_MEM_RPC_STATUS]);
> +               ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id, 0);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tstee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
> +{
> +       struct tstee *tstee = tee_get_drvdata(ctx->teedev);
> +       struct ffa_device *ffa_dev = tstee->ffa_dev;
> +       struct ffa_send_direct_data ffa_data;
> +       u32 ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
> +       int rc;
> +
> +       ffa_args[TS_RPC_CTRL_REG] =
> +                       TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFACE_ID,
> +                                                     TS_RPC_OP_RELINQ_MEM);
> +       ffa_args[TS_RPC_RELINQ_MEM_HANDLE_LSW] =
> +                       lower_32_bits(shm->sec_world_id);
> +       ffa_args[TS_RPC_RELINQ_MEM_HANDLE_MSW] =
> +                       upper_32_bits(shm->sec_world_id);
> +
> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
> +       rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
> +       if (rc)
> +               return rc;
> +       arg_list_from_ffa_data(&ffa_data, ffa_args);
> +
> +       if (ffa_args[TS_RPC_RELINQ_MEM_RPC_STATUS] != TS_RPC_OK) {
> +               pr_err("shm_unregister rpc status: %d\n",
> +                      ffa_args[TS_RPC_RELINQ_MEM_RPC_STATUS]);
> +               return -EINVAL;
> +       }
> +
> +       rc = ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id, 0);
> +
> +       return rc;
> +}
> +
> +static const struct tee_driver_ops tstee_ops = {
> +       .get_version = tstee_get_version,
> +       .open = tstee_open,
> +       .release = tstee_release,
> +       .open_session = tstee_open_session,
> +       .close_session = tstee_close_session,
> +       .invoke_func = tstee_invoke_func,
> +       .shm_register = tstee_shm_register,
> +       .shm_unregister = tstee_shm_unregister,
> +};
> +
> +static const struct tee_desc tstee_desc = {
> +       .name = "tstee-clnt",
> +       .ops = &tstee_ops,
> +       .owner = THIS_MODULE,
> +};
> +
> +static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
> +                        size_t size, size_t align)
> +{
> +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
> +                                           tstee_shm_register);
> +}
> +
> +static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
> +{
> +       tee_shm_pool_op_free_helper(pool, shm, tstee_shm_unregister);
> +}
> +
> +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> +{
> +       kfree(pool);
> +}
> +
> +static const struct tee_shm_pool_ops pool_ops = {
> +       .alloc = pool_op_alloc,
> +       .free = pool_op_free,
> +       .destroy_pool = pool_op_destroy_pool,
> +};
> +
> +static struct tee_shm_pool *tstee_create_shm_pool(void)
> +{
> +       struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> +
> +       if (!pool)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pool->ops = &pool_ops;
> +
> +       return pool;
> +}
> +
> +static bool tstee_check_rpc_compatible(struct ffa_device *ffa_dev)
> +{
> +       struct ffa_send_direct_data ffa_data;
> +       u32 ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
> +
> +       ffa_args[TS_RPC_CTRL_REG] =
> +                       TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFACE_ID,
> +                                                     TS_RPC_OP_GET_VERSION);
> +
> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
> +       if (ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data))
> +               return false;
> +
> +       arg_list_from_ffa_data(&ffa_data, ffa_args);
> +
> +       return ffa_args[TS_RPC_GET_VERSION_RESP] == TS_RPC_PROTOCOL_VERSION;
> +}
> +
> +static int tstee_probe(struct ffa_device *ffa_dev)
> +{
> +       struct tstee *tstee;
> +       int rc;
> +
> +       ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
> +
> +       if (!tstee_check_rpc_compatible(ffa_dev))
> +               return -EINVAL;
> +
> +       tstee = kzalloc(sizeof(*tstee), GFP_KERNEL);
> +       if (!tstee)
> +               return -ENOMEM;
> +
> +       tstee->ffa_dev = ffa_dev;
> +
> +       tstee->pool = tstee_create_shm_pool();
> +       if (IS_ERR(tstee->pool)) {
> +               rc = PTR_ERR(tstee->pool);
> +               tstee->pool = NULL;
> +               goto err_free_tstee;
> +       }
> +
> +       tstee->teedev = tee_device_alloc(&tstee_desc, NULL, tstee->pool, tstee);
> +       if (IS_ERR(tstee->teedev)) {
> +               rc = PTR_ERR(tstee->teedev);
> +               tstee->teedev = NULL;
> +               goto err_free_pool;
> +       }
> +
> +       rc = tee_device_register(tstee->teedev);
> +       if (rc)
> +               goto err_unreg_teedev;
> +
> +       ffa_dev_set_drvdata(ffa_dev, tstee);
> +
> +       return 0;
> +
> +err_unreg_teedev:
> +       tee_device_unregister(tstee->teedev);
> +err_free_pool:
> +       tee_shm_pool_free(tstee->pool);
> +err_free_tstee:
> +       kfree(tstee);
> +       return rc;
> +}
> +
> +static void tstee_remove(struct ffa_device *ffa_dev)
> +{
> +       struct tstee *tstee = ffa_dev->dev.driver_data;
> +
> +       tee_device_unregister(tstee->teedev);
> +       tee_shm_pool_free(tstee->pool);
> +       kfree(tstee);
> +}
> +
> +static const struct ffa_device_id tstee_device_ids[] = {
> +       /* TS RPC protocol UUID: bdcd76d7-825e-4751-963b-86d4f84943ac */
> +       { TS_RPC_UUID },
> +       {}
> +};
> +
> +static struct ffa_driver tstee_driver = {
> +       .name = "arm_tstee",
> +       .probe = tstee_probe,
> +       .remove = tstee_remove,
> +       .id_table = tstee_device_ids,
> +};
> +
> +module_ffa_driver(tstee_driver);
> +
> +MODULE_AUTHOR("Balint Dobszay <balint.dobszay@arm.com>");
> +MODULE_DESCRIPTION("Arm Trusted Services TEE driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tee/tstee/tstee_private.h b/drivers/tee/tstee/tstee_private.h
> new file mode 100644
> index 000000000000..6d24cf0dbbc2
> --- /dev/null
> +++ b/drivers/tee/tstee/tstee_private.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023, Arm Limited
> + */
> +
> +#ifndef TSTEE_PRIVATE_H
> +#define TSTEE_PRIVATE_H
> +
> +#include <linux/arm_ffa.h>
> +#include <linux/bitops.h>
> +#include <linux/tee_drv.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +#include <linux/xarray.h>
> +
> +/*
> + * The description of the ABI implemented in this file is available at
> + * https://trusted-services.readthedocs.io/en/v1.0.0/developer/service-access-protocols.html#abi
> + */
> +
> +/* UUID of this protocol */
> +#define TS_RPC_UUID UUID_INIT(0xbdcd76d7, 0x825e, 0x4751, \
> +                             0x96, 0x3b, 0x86, 0xd4, 0xf8, 0x49, 0x43, 0xac)
> +
> +/* Protocol version*/
> +#define TS_RPC_PROTOCOL_VERSION                (1)
> +
> +/* Status codes */
> +#define TS_RPC_OK                      (0)
> +
> +/* RPC control register */
> +#define TS_RPC_CTRL_REG                        (0)
> +#define OPCODE_MASK                    GENMASK(15, 0)
> +#define IFACE_ID_MASK                  GENMASK(23, 16)
> +#define TS_RPC_CTRL_OPCODE(x)          ((u16)(FIELD_GET(OPCODE_MASK, (x))))
> +#define TS_RPC_CTRL_IFACE_ID(x)                ((u8)(FIELD_GET(IFACE_ID_MASK, (x))))
> +#define TS_RPC_CTRL_PACK_IFACE_OPCODE(i, o)    \
> +       (FIELD_PREP(IFACE_ID_MASK, (i)) | FIELD_PREP(OPCODE_MASK, (o)))
> +#define TS_RPC_CTRL_SAP_RC             BIT(30)
> +#define TS_RPC_CTRL_SAP_ERR            BIT(31)
> +
> +/* Interface ID for RPC management operations */
> +#define TS_RPC_MGMT_IFACE_ID           (0xff)
> +
> +/* Management calls */
> +#define TS_RPC_OP_GET_VERSION          (0x0000)
> +#define TS_RPC_GET_VERSION_RESP                (1)
> +
> +#define TS_RPC_OP_RETRIEVE_MEM         (0x0001)
> +#define TS_RPC_RETRIEVE_MEM_HANDLE_LSW (1)
> +#define TS_RPC_RETRIEVE_MEM_HANDLE_MSW (2)
> +#define TS_RPC_RETRIEVE_MEM_TAG_LSW    (3)
> +#define TS_RPC_RETRIEVE_MEM_TAG_MSW    (4)
> +#define TS_RPC_RETRIEVE_MEM_RPC_STATUS (1)
> +
> +#define TS_RPC_OP_RELINQ_MEM           (0x0002)
> +#define TS_RPC_RELINQ_MEM_HANDLE_LSW   (1)
> +#define TS_RPC_RELINQ_MEM_HANDLE_MSW   (2)
> +#define TS_RPC_RELINQ_MEM_RPC_STATUS   (1)
> +
> +#define TS_RPC_OP_SERVICE_INFO         (0x0003)
> +#define TS_RPC_SERVICE_INFO_UUID0      (1)
> +#define TS_RPC_SERVICE_INFO_UUID1      (2)
> +#define TS_RPC_SERVICE_INFO_UUID2      (3)
> +#define TS_RPC_SERVICE_INFO_UUID3      (4)
> +#define TS_RPC_SERVICE_INFO_RPC_STATUS (1)
> +#define TS_RPC_SERVICE_INFO_IFACE      (2)
> +
> +/* Service call */
> +#define TS_RPC_SERVICE_MEM_HANDLE_LSW  (1)
> +#define TS_RPC_SERVICE_MEM_HANDLE_MSW  (2)
> +#define TS_RPC_SERVICE_REQ_LEN         (3)
> +#define TS_RPC_SERVICE_CLIENT_ID       (4)
> +#define TS_RPC_SERVICE_RPC_STATUS      (1)
> +#define TS_RPC_SERVICE_STATUS          (2)
> +#define TS_RPC_SERVICE_RESP_LEN                (3)
> +
> +struct tstee {
> +       struct ffa_device *ffa_dev;
> +       struct tee_device *teedev;
> +       struct tee_shm_pool *pool;
> +};
> +
> +struct ts_session {
> +       u8 iface_id;
> +};
> +
> +struct ts_context_data {
> +       struct xarray sess_list;
> +       /* Serializes access to the session list */
> +       struct mutex mutex;
> +};
> +
> +#endif /* TSTEE_PRIVATE_H */
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index 23e57164693c..d0430bee8292 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -56,6 +56,7 @@
>   */
>  #define TEE_IMPL_ID_OPTEE      1
>  #define TEE_IMPL_ID_AMDTEE     2
> +#define TEE_IMPL_ID_TSTEE      3
>
>  /*
>   * OP-TEE specific capabilities
> --
> 2.34.1
>

