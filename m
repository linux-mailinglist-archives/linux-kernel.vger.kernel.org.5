Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45F17DB3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjJ3GyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjJ3GyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:54:09 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915BAAB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:54:06 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b9d894be6fso1060770241.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698648845; x=1699253645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYng4Jw8ay1T3J02aVPjm8K2oweBTmhDJ9zbU0/5ar0=;
        b=sHD33ZpaVBbxsuw2UwazfdCNtADl2Qe0RtElAJpmbY8ish/1EEx77QYmOsellKWFDu
         O1ofUXWNMQ3/F89y5PgcRM1FFYlct9fPCYpxqzyMR4XIQcKdh8tJ2Gh1VkUnYTiQNvxf
         TG2PKSwsezwTF7U3tNLAq1yifeh1QRQHOvh4DKjSMSxgorSMoK8xcTYx4IDtg6/pT74t
         jL3IUnmvswmwYjyF1crH7CqiAbI2keCEDulh0ywaGQS9H9U/2ZZjAEw4pZ58C+zCflM5
         zUgVTw8GHXLWzM9aWgbeAGt3cDuLa+m++CvcUWcB2VgHcbEp9LHbu5OzzYC96cv3av92
         vv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698648845; x=1699253645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYng4Jw8ay1T3J02aVPjm8K2oweBTmhDJ9zbU0/5ar0=;
        b=giGI7DAFR3zS67B+wMqzYLHmmsn/UHrM56ptebOQPj/xqabXKZGUuywJZFCGq9xYOj
         ZjAKl2IUYCOgk3O4B+oHP6/3ItA349wbQllKSSn1r7QB13TmQW3mw4izQj10WdtGU2+9
         Z2tF0G/70/5IFSdrdmsn+2Jd1VxrezkeBzjR/4LinY0GwYAWV3oDnZoIIR7+3vjR+kH8
         JMdPinHiFgBhf6n0QnKUstQ5MEy+V77a3ba0uUeeIdbQYPMSXLVcyQXAGa8/nade1eS9
         RlvB3nsIbSED+VVYkgr9gxvKtA6HNnkJWzdxWiywpAYbZMv3MouL6i/uhrYWCiyKTaMX
         tSLA==
X-Gm-Message-State: AOJu0YwfBFEBZWvjU0BGRSg2S2YBzfadK+Khg5CFZEHi2ORnWqlvmIqS
        qbOWgQ+a93IjbEmsMotQXd1BXaaFXUta2BA2NDs+fQ==
X-Google-Smtp-Source: AGHT+IG/YkiPmtRgvam3A+lkQi1mizXRD+JFtSCyarkcB3whk2u7pJAB1NXNSeJquETuBg+2Wp8o22Uvx7EZbVttHYw=
X-Received: by 2002:a05:6102:1043:b0:452:67fd:e5c1 with SMTP id
 h3-20020a056102104300b0045267fde5c1mr5417526vsq.4.1698648845571; Sun, 29 Oct
 2023 23:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org> <20231026080409.4149616-2-jens.wiklander@linaro.org>
In-Reply-To: <20231026080409.4149616-2-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 30 Oct 2023 12:23:54 +0530
Message-ID: <CAFA6WYO6tb+wvGnWLRHP73+ym4PpE3H=Srk1OWUtuHVPMteZiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] optee: provide optee_do_bottom_half() as a common function
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Provides optee_do_bottom_half() and optee_stop_async_notif() as common
> functions callable from the FF-A ABI part of the driver too.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c          | 31 +++++++++++++++++++++++++-
>  drivers/tee/optee/optee_private.h |  5 ++++-
>  drivers/tee/optee/smc_abi.c       | 36 ++++---------------------------
>  3 files changed, 38 insertions(+), 34 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index df5fb5410b72..5afc759794ce 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2015-2021, Linaro Limited
> + * Copyright (c) 2015-2021, 2023 Linaro Limited
>   */
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -524,3 +524,32 @@ int optee_check_mem_type(unsigned long start, size_t num_pages)
>
>         return rc;
>  }
> +
> +static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
> +{
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> +       struct optee_shm_arg_entry *entry;
> +       struct optee_msg_arg *msg_arg;
> +       struct tee_shm *shm;
> +       u_int offs;
> +
> +       msg_arg = optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
> +       if (IS_ERR(msg_arg))
> +               return PTR_ERR(msg_arg);
> +
> +       msg_arg->cmd = cmd;
> +       optee->ops->do_call_with_arg(ctx, shm, offs);
> +
> +       optee_free_msg_arg(ctx, entry, offs);
> +       return 0;
> +}
> +
> +int optee_do_bottom_half(struct tee_context *ctx)
> +{
> +       return simple_call_with_arg(ctx, OPTEE_MSG_CMD_DO_BOTTOM_HALF);
> +}
> +
> +int optee_stop_async_notif(struct tee_context *ctx)
> +{
> +       return simple_call_with_arg(ctx, OPTEE_MSG_CMD_STOP_ASYNC_NOTIF);
> +}
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 72685ee0d53f..2165bd11e6ac 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2015-2021, Linaro Limited
> + * Copyright (c) 2015-2021, 2023 Linaro Limited
>   */
>
>  #ifndef OPTEE_PRIVATE_H
> @@ -325,6 +325,9 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm);
>  void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
>                    struct optee_msg_arg *arg);
>
> +int optee_do_bottom_half(struct tee_context *ctx);
> +int optee_stop_async_notif(struct tee_context *ctx);
> +
>  /*
>   * Small helpers
>   */
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index d5b28fd35d66..94e96803a722 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2015-2021, Linaro Limited
> + * Copyright (c) 2015-2021, 2023 Linaro Limited
>   * Copyright (c) 2016, EPAM Systems
>   */
>
> @@ -965,34 +965,6 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
>         return rc;
>  }
>
> -static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
> -{
> -       struct optee_shm_arg_entry *entry;
> -       struct optee_msg_arg *msg_arg;
> -       struct tee_shm *shm;
> -       u_int offs;
> -
> -       msg_arg = optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
> -       if (IS_ERR(msg_arg))
> -               return PTR_ERR(msg_arg);
> -
> -       msg_arg->cmd = cmd;
> -       optee_smc_do_call_with_arg(ctx, shm, offs);
> -
> -       optee_free_msg_arg(ctx, entry, offs);
> -       return 0;
> -}
> -
> -static int optee_smc_do_bottom_half(struct tee_context *ctx)
> -{
> -       return simple_call_with_arg(ctx, OPTEE_MSG_CMD_DO_BOTTOM_HALF);
> -}
> -
> -static int optee_smc_stop_async_notif(struct tee_context *ctx)
> -{
> -       return simple_call_with_arg(ctx, OPTEE_MSG_CMD_STOP_ASYNC_NOTIF);
> -}
> -
>  /*
>   * 5. Asynchronous notification
>   */
> @@ -1048,7 +1020,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
>  {
>         struct optee *optee = dev_id;
>
> -       optee_smc_do_bottom_half(optee->ctx);
> +       optee_do_bottom_half(optee->ctx);
>
>         return IRQ_HANDLED;
>  }
> @@ -1086,7 +1058,7 @@ static void notif_pcpu_irq_work_fn(struct work_struct *work)
>                                                    notif_pcpu_work);
>         struct optee *optee = container_of(optee_smc, struct optee, smc);
>
> -       optee_smc_do_bottom_half(optee->ctx);
> +       optee_do_bottom_half(optee->ctx);
>  }
>
>  static int init_pcpu_irq(struct optee *optee, u_int irq)
> @@ -1158,7 +1130,7 @@ static void uninit_pcpu_irq(struct optee *optee)
>  static void optee_smc_notif_uninit_irq(struct optee *optee)
>  {
>         if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
> -               optee_smc_stop_async_notif(optee->ctx);
> +               optee_stop_async_notif(optee->ctx);
>                 if (optee->smc.notif_irq) {
>                         if (irq_is_percpu_devid(optee->smc.notif_irq))
>                                 uninit_pcpu_irq(optee);
> --
> 2.34.1
>
