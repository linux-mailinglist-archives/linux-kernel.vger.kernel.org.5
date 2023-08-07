Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A966F771BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHGH6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjHGH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:58:36 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ADA1703
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:58:33 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44758646388so1424974137.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691395113; x=1691999913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5fi0fpOM2gRSvqlWV4tqwQpsx/3dXpvqD75todpGs4=;
        b=iRMq+dkfiTEjSPlta/9NwsHLANWWywsEHXVZa4bRc445DB1RlC6n8yFCgKpSROWS4v
         JDQoQLMALmAJWX4xZno8mV11Q5e1fzedbup7O1UqozdkbYZQhfhf5XOhUBZONIB82Fr2
         YnInRFcVNLJ1G/smIdxkmeT883lQ1BtrW1XjXJKCAntl9fbSvhJWGur/KZlCCHWB5msT
         mFU4dX8hBFvtFzlfLeGJRZnpFIwb7kcqPgcrRCQXOvntgArdJDF1CM9TgF69MpqjL14l
         w83KAlxEH8LcakZoYo/d5Mkwsre0r5gJSThEUaFvxT6dIhu80KOxCaGz29dJrrFHkAPo
         qMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691395113; x=1691999913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5fi0fpOM2gRSvqlWV4tqwQpsx/3dXpvqD75todpGs4=;
        b=F3SaKNZ7BN2bMTeIamz6Iau+9wgzonpyHXZfuKfxM2HnAbx2DHH4TbI7zYqwzJ3JsS
         b2yOz53RCTrSzOEWCBe3OruvxbMRqvyh6XvbW75DO+OhYcITQBtvr4NnqgAMAMfB2Y72
         JUJxEVh+2PfDxTd5wWS55qCO1TSx6SXVnhCB1FHRk6/TaasJFCnh2a2OeANzumPoc7p5
         YWcQKvHtaLn22LR7rakuPk8wq+GCV2eFnxEoMNpFTcrc/JXmmUCbDw7gtHzyM7nnjbR3
         vm/l0F/fOT12cfTYEOizbYyBnuiDLI5MrTBbH4ER87Tby70M8VTyl7INrwm+Q9A4IrrT
         3nRw==
X-Gm-Message-State: AOJu0YyTS0Oozd5+nWYvfnMwNkSfKVyhYNAFZ8T+hlfWbAeXcMliSAv4
        piu5Ja1fft+SWBAPFbrUMA/YoRimCXBc2fHaY/COZQ==
X-Google-Smtp-Source: AGHT+IGr47ODoEmeGuqdWN/2xIoV0xZ8k7qdvGJVlzty7GhhOUd2fRZIOQd1pqldKNgi6Xc87KwtrNpskOMiliDJ/Dw=
X-Received: by 2002:a67:f546:0:b0:443:6f2d:d44a with SMTP id
 z6-20020a67f546000000b004436f2dd44amr3810233vsn.2.1691395112931; Mon, 07 Aug
 2023 00:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230803123515.4018838-1-jens.wiklander@linaro.org>
In-Reply-To: <20230803123515.4018838-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 7 Aug 2023 13:28:21 +0530
Message-ID: <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, 3 Aug 2023 at 18:05, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Prior to this patch was trusted_tee_seal() and trusted_tee_get_random()
> relying on tee_shm_register_kernel_buf() to share memory with the TEE.
> Depending on the memory allocation pattern the pages holding the
> registered buffers overlap with other buffers also shared with the TEE.
>

The overlap here is due to the fact that we are registering two array
members of the same struct. This overlap can be removed by registering
the overall structure at once. But that sounds unnecessary data
structure type sharing with trusted keys TA.

> The OP-TEE driver using the old SMC based ABI permits overlapping shared
> buffers, but with the new FF-A based ABI each physical page may only
> be registered once.

Would it be possible for OP-TEE FF-A ABI to check if a page is already
registered? If it is then just return success with appropriate page
offset. As otherwise this sounds like an unnecessary restriction for
users. I don't think the problem is only particular to the trusted
keys driver but can be reproduced for user-space clients as well.

>
> Fix this problem by allocating a temporary page aligned shared memory
> buffer to be used as a bounce buffer for the needed data buffers.
>
> Since TEE trusted keys doesn't depend on registered shared memory
> support any longer remove that explicit dependency when opening a
> context to the TEE.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 68 +++++++++++++-----------
>  1 file changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> index ac3e270ade69..3085343c489a 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/err.h>
>  #include <linux/key-type.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -65,38 +66,37 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>         int ret;
>         struct tee_ioctl_invoke_arg inv_arg;
>         struct tee_param param[4];
> -       struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> +       struct tee_shm *shm;
> +       uint8_t *buf;
>
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> -                                                p->key_len);
> -       if (IS_ERR(reg_shm_in)) {
> -               dev_err(pvt_data.dev, "key shm register failed\n");
> -               return PTR_ERR(reg_shm_in);
> +       shm = tee_shm_alloc_kernel_buf(pvt_data.ctx,
> +                                      p->key_len + sizeof(p->blob));
> +       if (IS_ERR(shm)) {
> +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> +               return PTR_ERR(shm);
>         }
> -
> -       reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> -                                                 sizeof(p->blob));
> -       if (IS_ERR(reg_shm_out)) {
> -               dev_err(pvt_data.dev, "blob shm register failed\n");
> -               ret = PTR_ERR(reg_shm_out);
> +       buf = tee_shm_get_va(shm, 0);
> +       if (IS_ERR(buf)) {
> +               ret = PTR_ERR(buf);
>                 goto out;
>         }
> +       memcpy(buf, p->key, p->key_len);

These memcpy()'s here and below are undue overheads if we change to
tee_shm_alloc_kernel_buf().

-Sumit

>
>         inv_arg.func = TA_CMD_SEAL;
>         inv_arg.session = pvt_data.session_id;
>         inv_arg.num_params = 4;
>
>         param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> -       param[0].u.memref.shm = reg_shm_in;
> +       param[0].u.memref.shm = shm;
>         param[0].u.memref.size = p->key_len;
>         param[0].u.memref.shm_offs = 0;
>         param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> -       param[1].u.memref.shm = reg_shm_out;
> +       param[1].u.memref.shm = shm;
>         param[1].u.memref.size = sizeof(p->blob);
> -       param[1].u.memref.shm_offs = 0;
> +       param[1].u.memref.shm_offs = p->key_len;
>
>         ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
>         if ((ret < 0) || (inv_arg.ret != 0)) {
> @@ -104,14 +104,13 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>                         inv_arg.ret);
>                 ret = -EFAULT;
>         } else {
> +               memcpy(p->blob, buf + p->key_len,
> +                      min(param[1].u.memref.size, sizeof(p->blob)));
>                 p->blob_len = param[1].u.memref.size;
>         }
>
>  out:
> -       if (reg_shm_out)
> -               tee_shm_free(reg_shm_out);
> -       if (reg_shm_in)
> -               tee_shm_free(reg_shm_in);
> +       tee_shm_free(shm);
>
>         return ret;
>  }
> @@ -166,11 +165,9 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
>                 p->key_len = param[1].u.memref.size;
>         }
>
> +       tee_shm_free(reg_shm_out);
>  out:
> -       if (reg_shm_out)
> -               tee_shm_free(reg_shm_out);
> -       if (reg_shm_in)
> -               tee_shm_free(reg_shm_in);
> +       tee_shm_free(reg_shm_in);
>
>         return ret;
>  }
> @@ -183,15 +180,21 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
>         int ret;
>         struct tee_ioctl_invoke_arg inv_arg;
>         struct tee_param param[4];
> -       struct tee_shm *reg_shm = NULL;
> +       struct tee_shm *shm;
> +       void *buf;
>
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, key, key_len);
> -       if (IS_ERR(reg_shm)) {
> -               dev_err(pvt_data.dev, "key shm register failed\n");
> -               return PTR_ERR(reg_shm);
> +       shm = tee_shm_alloc_kernel_buf(pvt_data.ctx, key_len);
> +       if (IS_ERR(shm)) {
> +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> +               return PTR_ERR(shm);
> +       }
> +       buf = tee_shm_get_va(shm, 0);
> +       if (IS_ERR(buf)) {
> +               ret = PTR_ERR(buf);
> +               goto out;
>         }
>
>         inv_arg.func = TA_CMD_GET_RANDOM;
> @@ -199,7 +202,7 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
>         inv_arg.num_params = 4;
>
>         param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> -       param[0].u.memref.shm = reg_shm;
> +       param[0].u.memref.shm = shm;
>         param[0].u.memref.size = key_len;
>         param[0].u.memref.shm_offs = 0;
>
> @@ -209,18 +212,19 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
>                         inv_arg.ret);
>                 ret = -EFAULT;
>         } else {
> +               memcpy(key, buf, min(param[0].u.memref.size, key_len));
>                 ret = param[0].u.memref.size;
>         }
>
> -       tee_shm_free(reg_shm);
> +out:
> +       tee_shm_free(shm);
>
>         return ret;
>  }
>
>  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  {
> -       if (ver->impl_id == TEE_IMPL_ID_OPTEE &&
> -           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
> +       if (ver->impl_id == TEE_IMPL_ID_OPTEE)
>                 return 1;
>         else
>                 return 0;
> --
> 2.34.1
>
