Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EBF768BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGaGVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGaGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:21:35 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D4DB0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:21:34 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9ec15e014so3815212a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690784493; x=1691389293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNIJW0mLPlOu1LsLBcKxEsnkSHZnmPg+GlBNFdBenwI=;
        b=lawHiURt9zK5pqvAztOxv19VwClPF80orp3/ACJx7Ks4Fo2Pb7636NsVOn1vss1m/Q
         cUmULdxDVHBEdgqxAaL95aTNXOQROD1zJTkBmVrSUfzMW13sVXg8EOMvm4EI2xoyE4/6
         f+TmGtTWVxwI/QsgR1dZCwG+s1jg1SvkJYWNT+zaR7buGUfK54sfir15i17+BJHhn0L9
         DILkOaNIDvSSaCvs839G6NyAQEc4NceQ1XUGIc5HhpzY/RTuh/QKs2eX7K0Gojml+s3k
         dnbssz66Un9ovhX/hzfj5L16BswmusAr4auOyVrJuVllxH/CytIpHnk/eNAV3U8mDs35
         bQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784493; x=1691389293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNIJW0mLPlOu1LsLBcKxEsnkSHZnmPg+GlBNFdBenwI=;
        b=M6H25cKX5Z546HuKNEGRIywf9ScRNA3GSQhIRZIW7WDweenKFdggY4+EXD6ftdOkNB
         jfSJ4ZQ+LLtoQbB/O3iSDjpzeWjk550xMewM9VQKPpkcFYKMWvvN0nQ5PHKVD/HzbHZe
         gFZcNHOxua00WT9WMZuXHUGbU4ZLbeBBXSn/x68rnP0YeIhWm6hA4Hod0ZZBlDBJt6Pz
         jJaswPOlDZ8E9h4fme2c7rYkTuApkt5uj/WCJU0H/DAgUEL6H+IGhEb1uuSxkBH4dasJ
         PhqfBZMol93+tPD+Zf0jntkTgGoYH0rZ9snm02cF8KBXDQwJyMtktbyuLP24367gQqZG
         TLjw==
X-Gm-Message-State: ABy/qLYgFYcrL17M6Gqol24f8CUAbC2dmReLPsJj5o3a1EraLaHCknjL
        gqwTynoeR+/x7Ijl76lKzKGfnhoPpovHe2+9Ql4BCg==
X-Google-Smtp-Source: APBJJlEl7kfPSy4DATvJEXR3sSi64Ta6DCFJpGpy6HJX2pCXtj1goiqhi/mcmAfqMGrJKT++NJ4UQ1dccQpVE9Cs1Vs=
X-Received: by 2002:a05:6808:1456:b0:3a4:2485:85a1 with SMTP id
 x22-20020a056808145600b003a4248585a1mr2425217oiv.3.1690784493373; Sun, 30 Jul
 2023 23:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230728134832.326467-1-sumit.garg@linaro.org>
In-Reply-To: <20230728134832.326467-1-sumit.garg@linaro.org>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Mon, 31 Jul 2023 15:21:22 +0900
Message-ID: <CADQ0-X-k0w67sKw3XMQsgtc96KcZTbaCX-pEuZ_YCmp9Mf9zxQ@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: Fix supplicant based device enumeration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, jens.wiklander@linaro.org,
        jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        maxim.uvarov@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 22:48, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Currently supplicant dependent optee device enumeration only registers
> devices whenever tee-supplicant is invoked for the first time. But it
> forgets to remove devices when tee-supplicant daemon stops running and
> closes its context gracefully. This leads to following error for fTPM
> driver during reboot/shutdown:
>
> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
>
> Fix this by separating supplicant dependent devices so that the
> user-space service can detach supplicant devices before closing the
> supplicant. While at it use the global system workqueue for OP-TEE bus
> scanning work rather than our own custom one.
>
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://github.com/OP-TEE/optee_os/issues/6094
> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
>
> Apologies for taking it too long push this v2. Actually I did brainstorm
> how to best fix this tee-supplicant dependent device probing. Its hard
> to predict the lifetime of user-space daemon from kernel space. So
> following is the least intrusive approach:
>
> - Use device names to seperate out tee-supplicant dependent devices via
>   this patch.
> - Since user-space service is aware about tee-supplicant lifespan, so
>   allow the user-space service to unbind tee-supplicant dependent
>   devices before killing the supplicant. Following command has to be
>   added to the tee-supplicant service file.
>
>   $ for dev in /sys/bus/tee/devices/*; do if [[ "$dev" == *"optee-ta-supp-"* ]]; \
>         then echo $(basename "$dev") > $dev/driver/unbind; fi done
>
>  drivers/tee/optee/core.c          | 13 ++-----------
>  drivers/tee/optee/device.c        | 13 ++++++++++---
>  drivers/tee/optee/optee_private.h |  2 --
>  3 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index d01ca47f7bde..8ee3c71bd989 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -15,7 +15,6 @@
>  #include <linux/string.h>
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
> -#include <linux/workqueue.h>
>  #include "optee_private.h"
>
>  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> @@ -110,12 +109,7 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
>
>                 if (!optee->scan_bus_done) {
>                         INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
> -                       optee->scan_bus_wq = create_workqueue("optee_bus_scan");
> -                       if (!optee->scan_bus_wq) {
> -                               kfree(ctxdata);
> -                               return -ECHILD;
> -                       }
> -                       queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
> +                       schedule_work(&optee->scan_bus_work);
>                         optee->scan_bus_done = true;
>                 }
>         }
> @@ -159,10 +153,7 @@ void optee_release_supp(struct tee_context *ctx)
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
>
>         optee_release_helper(ctx, optee_close_session_helper);
> -       if (optee->scan_bus_wq) {
> -               destroy_workqueue(optee->scan_bus_wq);
> -               optee->scan_bus_wq = NULL;
> -       }
> +
>         optee_supp_release(&optee->supp);
>  }
>
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 64f0e047c23d..78fc0a15c463 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
>         kfree(optee_device);
>  }
>
> -static int optee_register_device(const uuid_t *device_uuid)
> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>  {
>         struct tee_client_device *optee_device = NULL;
> +       const char *dev_name_fmt = NULL;
>         int rc;
>
>         optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
>
>         optee_device->dev.bus = &tee_bus_type;
>         optee_device->dev.release = optee_release_device;
> -       if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
> +
> +       if (func == PTA_CMD_GET_DEVICES_SUPP)
> +               dev_name_fmt = "optee-ta-supp-%pUb";
> +       else
> +               dev_name_fmt = "optee-ta-%pUb";
> +
> +       if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
>                 kfree(optee_device);
>                 return -ENOMEM;
>         }
> @@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
>         num_devices = shm_size / sizeof(uuid_t);
>
>         for (idx = 0; idx < num_devices; idx++) {
> -               rc = optee_register_device(&device_uuid[idx]);
> +               rc = optee_register_device(&device_uuid[idx], func);
>                 if (rc)
>                         goto out_shm;
>         }
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 6dcecb83c893..af4aa266c3fb 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -193,7 +193,6 @@ struct optee_ops {
>   * @pool:              shared memory pool
>   * @rpc_param_count:   If > 0 number of RPC parameters to make room for
>   * @scan_bus_done      flag if device registation was already done.
> - * @scan_bus_wq                workqueue to scan optee bus and register optee drivers
>   * @scan_bus_work      workq to scan optee bus and register optee drivers
>   */
>  struct optee {
> @@ -212,7 +211,6 @@ struct optee {
>         struct tee_shm_pool *pool;
>         unsigned int rpc_param_count;
>         bool   scan_bus_done;
> -       struct workqueue_struct *scan_bus_wq;
>         struct work_struct scan_bus_work;
>  };
>

It works for me, I tested with a 6.4.0-based kernel on the Developerbox.
Both fTPM and tee-based EFI variable service are shutdown successfully.

Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>

Thanks,
Masahisa Kojima

> --
> 2.34.1
>
