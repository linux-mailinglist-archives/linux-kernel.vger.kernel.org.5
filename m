Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F37850E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHWGzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjHWGzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:55:54 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35BE46
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:55:51 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-447c7607b72so2140617137.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692773750; x=1693378550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLfKs0vxuqFqgLcCcFNFpi2DXG8BlcoLy65tZmmHn4s=;
        b=C9fd660wNdFLLdlS2TW0H+x8soH+wvy9kheDYuP5m9XABGCmyBn+reV7925EIRPp6a
         7AXhimwLYPR08T0phs8tN2Be1X/caQvrUiIh7KJQkIVF3yNTS8uOcP+sLGxHyFyFBu8l
         xU8E0DDwLqTKgfqqoQbFY5frZwkr5QbOO5pEBLxT48KoHVlD3ZFag8jq85yJXibiEzVQ
         5qt6mpv/gxdaZ7JHHKfhk5u8rRIV7ejeu8wgLm+i9LqTSwJGwLcgtZ1JR7kNDaYgf3Kz
         iC76tFy5F31ctUtAJwoBD6OExWePXojnDkc54iOiQVjbrf61yF8v3XHpwi3C3uXoO1Q7
         9Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692773750; x=1693378550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLfKs0vxuqFqgLcCcFNFpi2DXG8BlcoLy65tZmmHn4s=;
        b=IGzK3AkTySveOgMDQQgeXdjLj/LfpmVzWGazRri2BPrERNKp5qHUqULzH7RD9UVzTx
         ZrXIDoeHzUmv9iL/hM+ch4j2vtiFHZhtPsFj6TCh7PHacMi3be23vGSGu1uVuZhvibLE
         tXYjRfS9Hq9SduTWTrZ5MtslzEkhUQ/KWmpL+KShetBvfjkjum5pWlo4MQN9dlUADuXc
         aH2Dqs9SSqyCgYzcmRanZ/EHIjj1FFyIErX3FxE/NsQ42bdG7/Oosc75CSG5AMJjUFwS
         q+tqzV6JoKXRdcXw9kyyW0QXMJXESFYzsljpEAzUeGzOn/I2SNBlwE4Qbw7dYRgUJVqb
         1QQw==
X-Gm-Message-State: AOJu0YwL9USjDhjk0KG0rld/tUfxMXusgmQlVldE2m+G7kLNvVGwwlJz
        DAk+5frl0+DY3SSXGsorePezm69qhaqMHjXYGXRQRlbM1kZPLXn9vMg=
X-Google-Smtp-Source: AGHT+IHZ6wzYTYuJHshwpDW0Nk/qU4m6YVHI11y0vAqL8DLXYwnKrO6DRhb4Erf21/HfbRs2sqC1d+WekK+UVKjFJCE=
X-Received: by 2002:a05:6102:354f:b0:447:55b0:bceb with SMTP id
 e15-20020a056102354f00b0044755b0bcebmr10299298vss.0.1692773750399; Tue, 22
 Aug 2023 23:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112933.1550062-1-sumit.garg@linaro.org> <20230822125555.GA82256@rayden>
In-Reply-To: <20230822125555.GA82256@rayden>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 23 Aug 2023 12:25:39 +0530
Message-ID: <CAFA6WYPy=yxGg1HbT+ipWJFpxiJeUGK6BSgMhtRPd=zmKef-cw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: Refactor register SHM usage
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        jarkko@kernel.org, jejb@linux.ibm.com, zohar@linux.ibm.com,
        sudeep.holla@arm.com, achin.gupta@arm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 at 18:25, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Tue, Aug 22, 2023 at 04:59:33PM +0530, Sumit Garg wrote:
> > The OP-TEE driver using the old SMC based ABI permits overlapping shared
> > buffers, but with the new FF-A based ABI each physical page may only
> > be registered once.
> >
> > As the key and blob buffer are allocated adjancently, there is no need
> > for redundant register shared memory invocation. Also, it is incompatibile
> > with FF-A based ABI limitation. So refactor register shared memory
> > implementation to use only single invocation to register both key and blob
> > buffers.
> >
> > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  security/keys/trusted-keys/trusted_tee.c | 64 ++++++++----------------
> >  1 file changed, 20 insertions(+), 44 deletions(-)
> >
> > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> > index ac3e270ade69..aa3d477de6db 100644
> > --- a/security/keys/trusted-keys/trusted_tee.c
> > +++ b/security/keys/trusted-keys/trusted_tee.c
> > @@ -65,24 +65,16 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
> >       int ret;
> >       struct tee_ioctl_invoke_arg inv_arg;
> >       struct tee_param param[4];
> > -     struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> > +     struct tee_shm *reg_shm = NULL;
> >
> >       memset(&inv_arg, 0, sizeof(inv_arg));
> >       memset(&param, 0, sizeof(param));
> >
> > -     reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> > -                                              p->key_len);
> > -     if (IS_ERR(reg_shm_in)) {
> > -             dev_err(pvt_data.dev, "key shm register failed\n");
> > -             return PTR_ERR(reg_shm_in);
> > -     }
> > -
> > -     reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> > -                                               sizeof(p->blob));
> > -     if (IS_ERR(reg_shm_out)) {
> > -             dev_err(pvt_data.dev, "blob shm register failed\n");
> > -             ret = PTR_ERR(reg_shm_out);
> > -             goto out;
> > +     reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> > +                                           sizeof(p->key) + sizeof(p->blob));
>
> This is somewhat fragile. What if struct trusted_key_payload has a small
> unexpected change in layout?

key and blob buffers are just two adjacent fixed sized byte arrays. So
I am not worried here as long as they stay adjacent (which has been
the case since trusted keys were introduced in the kernel).

-Sumit

>
> Thanks,
> Jens
>
> > +     if (IS_ERR(reg_shm)) {
> > +             dev_err(pvt_data.dev, "shm register failed\n");
> > +             return PTR_ERR(reg_shm);
> >       }
> >
> >       inv_arg.func = TA_CMD_SEAL;
> > @@ -90,13 +82,13 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
> >       inv_arg.num_params = 4;
> >
> >       param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > -     param[0].u.memref.shm = reg_shm_in;
> > +     param[0].u.memref.shm = reg_shm;
> >       param[0].u.memref.size = p->key_len;
> >       param[0].u.memref.shm_offs = 0;
> >       param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > -     param[1].u.memref.shm = reg_shm_out;
> > +     param[1].u.memref.shm = reg_shm;
> >       param[1].u.memref.size = sizeof(p->blob);
> > -     param[1].u.memref.shm_offs = 0;
> > +     param[1].u.memref.shm_offs = sizeof(p->key);
> >
> >       ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> >       if ((ret < 0) || (inv_arg.ret != 0)) {
> > @@ -107,11 +99,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
> >               p->blob_len = param[1].u.memref.size;
> >       }
> >
> > -out:
> > -     if (reg_shm_out)
> > -             tee_shm_free(reg_shm_out);
> > -     if (reg_shm_in)
> > -             tee_shm_free(reg_shm_in);
> > +     tee_shm_free(reg_shm);
> >
> >       return ret;
> >  }
> > @@ -124,24 +112,16 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
> >       int ret;
> >       struct tee_ioctl_invoke_arg inv_arg;
> >       struct tee_param param[4];
> > -     struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> > +     struct tee_shm *reg_shm = NULL;
> >
> >       memset(&inv_arg, 0, sizeof(inv_arg));
> >       memset(&param, 0, sizeof(param));
> >
> > -     reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> > -                                              p->blob_len);
> > -     if (IS_ERR(reg_shm_in)) {
> > -             dev_err(pvt_data.dev, "blob shm register failed\n");
> > -             return PTR_ERR(reg_shm_in);
> > -     }
> > -
> > -     reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> > -                                               sizeof(p->key));
> > -     if (IS_ERR(reg_shm_out)) {
> > -             dev_err(pvt_data.dev, "key shm register failed\n");
> > -             ret = PTR_ERR(reg_shm_out);
> > -             goto out;
> > +     reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> > +                                           sizeof(p->key) + sizeof(p->blob));
> > +     if (IS_ERR(reg_shm)) {
> > +             dev_err(pvt_data.dev, "shm register failed\n");
> > +             return PTR_ERR(reg_shm);
> >       }
> >
> >       inv_arg.func = TA_CMD_UNSEAL;
> > @@ -149,11 +129,11 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
> >       inv_arg.num_params = 4;
> >
> >       param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > -     param[0].u.memref.shm = reg_shm_in;
> > +     param[0].u.memref.shm = reg_shm;
> >       param[0].u.memref.size = p->blob_len;
> > -     param[0].u.memref.shm_offs = 0;
> > +     param[0].u.memref.shm_offs = sizeof(p->key);
> >       param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > -     param[1].u.memref.shm = reg_shm_out;
> > +     param[1].u.memref.shm = reg_shm;
> >       param[1].u.memref.size = sizeof(p->key);
> >       param[1].u.memref.shm_offs = 0;
> >
> > @@ -166,11 +146,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
> >               p->key_len = param[1].u.memref.size;
> >       }
> >
> > -out:
> > -     if (reg_shm_out)
> > -             tee_shm_free(reg_shm_out);
> > -     if (reg_shm_in)
> > -             tee_shm_free(reg_shm_in);
> > +     tee_shm_free(reg_shm);
> >
> >       return ret;
> >  }
> > --
> > 2.34.1
> >
