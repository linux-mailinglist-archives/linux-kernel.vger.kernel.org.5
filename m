Return-Path: <linux-kernel+bounces-54757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1440A84B33E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB7B288ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA962130AFA;
	Tue,  6 Feb 2024 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOC+Dkv/"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF1130AE3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217974; cv=none; b=l0FchjF3A6FAbCXtSNhokfcBklx5oRRUcdlMbJsSb4GuRpBTBcQ0IfhO4DoHe7/eCdIPk4rbhfFPK5JioFQ2NlTUZEGdylUioEwB0y3qd+Vq3FD2kIBhxcrVTTAwoODFgBzVBbAilyO1+lwPz4OIHpUWHSf0SDH4HbV9Feuqb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217974; c=relaxed/simple;
	bh=eWGar3ehc9D3CTd1YwKjKYD86VEg4tR8XJ41GtCC418=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWd21Mw8BycfXr2zT56dbD7R99l5zN434lzGb/IaJtLL5raxGGIDhPhNc30PaWZjygBU0L37zsORsUDaEPjYoQof+Mua50WClQfA7API+zlNQRUtVh49N9lHM0LG0ktQLhbHOvF/QOTapN1DEJEdCwaRcr9MUFdunD48fTEOa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOC+Dkv/; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4676a37e2c4so1735038137.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707217972; x=1707822772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWO9cv59VFMVcgxftdSchJ1bJs3AtyhEa4Wv6ViEgyM=;
        b=IOC+Dkv/fTKSlBsKwIzuHGcrsUHKC3rqAHAcZU4jYVjjtfo1b4lovUfmV29C+yYHZ1
         2ZYcz7Scz/auW6yKfbteFvFtDnuqwZ5bwZM70e3wuTfkuUkO/fBZApXnNaX1KCdj6pK6
         Q1PS36RNfHepWVTKyEIAm6oSnkKE6ydNj+/fJgsk6SCyyG82YRnuSuL9fIOGAzfYlIBb
         cmL6StHTWQ+6G78Yfko6Um9Xbk5n+EuT8TFLAZZyC1QQgEidtumGFE7KFByDJadsmeP/
         MNyrmZE06QWzT296KsmouLHBFuLbVfQFowTBTs6DoKjWoxron8M8v6zxMJqZQz4UKP5u
         T//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217972; x=1707822772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWO9cv59VFMVcgxftdSchJ1bJs3AtyhEa4Wv6ViEgyM=;
        b=meQqr54kjWkHbkhbRLHaOUctnJqdK/uk/sYJyvEUjQqGbwz+CYsj1VhMaILymcfuQc
         MOGc6l7cUwVbyR80atsexLl+QJXHdTPt8BfPG+2be+KGTICyH0WEDYvmepfYTLWmWDU8
         ylei5LERKxdVz5ZcdGWpLrHCz1btihgp9YhWhIBvt30w4POGtBPKLQ0MgQ9Mfg5vAAPG
         ZMhxFWKsKSaPWBnk/rLcWKzVHpHqzo4TNeN8gMMO1lfRpEB9n1mpFjwaUeRburKLenVK
         z0d7vxs99AvdVi94XlrHNtoBuAT+PMv++BcBegfOOYcwSnCES2oFVNMTzYAktXIWb+gB
         aUMw==
X-Gm-Message-State: AOJu0YyyMulV5oMq+WZUXDg7yLb+9KhOFLYAsXsMm5h1/n760NVxSYvd
	Ghgx/2Pr0NS0kmaILZ6bBIng+86vSKZ6GBrojyo+wwGtvbaVt06wrAWqWQqfrZgPABqJ851MunX
	GVwqONNQOnHFtlll+9oOc2YIVIGegGCQxrhiZSQ==
X-Google-Smtp-Source: AGHT+IExt9KbOkFbxjIkwcdrbrIwP17LujEz8x7z/nHeSwCIo+gickjxcPx4b911VpEVokUFSS38lHkDtC7pDORrng4=
X-Received: by 2002:a05:6102:38cd:b0:46d:49ac:6ec4 with SMTP id
 k13-20020a05610238cd00b0046d49ac6ec4mr62190vst.19.1707217971860; Tue, 06 Feb
 2024 03:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org> <20240131174347.510961-4-jens.wiklander@linaro.org>
In-Reply-To: <20240131174347.510961-4-jens.wiklander@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 6 Feb 2024 16:42:40 +0530
Message-ID: <CAFA6WYPATEXUNfYHA1abup=kYBREJq7y=D9d1DdkJCxXqPhgAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] optee: probe RPMB device using RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jens,

On Wed, 31 Jan 2024 at 23:14, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> use an RPMB device via the RPBM subsystem instead of passing the RPMB
> frames via tee-supplicant in user space. A fallback mechanism is kept to
> route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> available.
>
> The OP-TEE RPC ABI is extended to support iterating over all RPMB
> devices until one is found with the expected RPMB key already
> programmed.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c          |   1 +
>  drivers/tee/optee/ffa_abi.c       |   2 +
>  drivers/tee/optee/optee_private.h |   6 +
>  drivers/tee/optee/optee_rpc_cmd.h |  33 +++++
>  drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       |   2 +
>  6 files changed, 265 insertions(+)
>

[snip]

>  #endif /*__OPTEE_RPC_CMD_H*/
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index e69bc6380683..6fd6f99dafab 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/rpmb.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
>  #include "optee_private.h"
> @@ -255,6 +256,217 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
>         optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
>  }
>
> +static void handle_rpc_func_rpmb_probe_reset(struct tee_context *ctx,
> +                                            struct optee *optee,
> +                                            struct optee_msg_arg *arg)
> +{
> +       struct tee_param params[1];
> +
> +       if (!IS_ENABLED(CONFIG_RPMB)) {
> +               handle_rpc_supp_cmd(ctx, optee, arg);
> +               return;
> +       }
> +
> +       if (arg->num_params != ARRAY_SIZE(params) ||
> +           optee->ops->from_msg_param(optee, params, arg->num_params,
> +                                      arg->params) ||
> +           params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) {
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       params[0].u.value.a = OPTEE_RPC_SHM_TYPE_KERNEL;
> +       params[0].u.value.b = 0;
> +       params[0].u.value.c = 0;
> +       if (optee->ops->to_msg_param(optee, arg->params,
> +                                    arg->num_params, params)) {
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       mutex_lock(&optee->rpmb_dev_mutex);
> +       rpmb_dev_put(optee->rpmb_dev);
> +       optee->rpmb_dev = NULL;
> +       mutex_unlock(&optee->rpmb_dev_mutex);
> +
> +       arg->ret = TEEC_SUCCESS;
> +}
> +
> +static int rpc_rpmb_match(struct device *dev, const void *data)
> +{
> +       return 1;
> +}
> +
> +static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
> +                                           struct optee *optee,
> +                                           struct optee_msg_arg *arg)
> +{
> +       struct rpmb_dev *start_rdev;
> +       struct rpmb_dev *rdev;
> +       struct tee_param params[2];
> +       void *buf;
> +
> +       if (!IS_ENABLED(CONFIG_RPMB)) {
> +               handle_rpc_supp_cmd(ctx, optee, arg);
> +               return;
> +       }
> +
> +       if (arg->num_params != ARRAY_SIZE(params) ||
> +           optee->ops->from_msg_param(optee, params, arg->num_params,
> +                                      arg->params) ||
> +           params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
> +           params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +       buf = tee_shm_get_va(params[1].u.memref.shm,
> +                            params[1].u.memref.shm_offs);
> +       if (!buf) {
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       mutex_lock(&optee->rpmb_dev_mutex);
> +       start_rdev = optee->rpmb_dev;
> +       rdev = rpmb_dev_find_device(NULL, start_rdev, rpc_rpmb_match);
> +       rpmb_dev_put(start_rdev);
> +       optee->rpmb_dev = rdev;
> +       mutex_unlock(&optee->rpmb_dev_mutex);
> +
> +       if (!rdev) {
> +               arg->ret = TEEC_ERROR_ITEM_NOT_FOUND;

One of the major comments I have here is regarding how this implicit
dependency on eMMC driver probe is met here. What if OP-TEE based
fTPM/EFI client driver probes before eMMC driver?

-Sumit

