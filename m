Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5187850F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjHWG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjHWG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:57:27 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FD1E59
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:57:22 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-79414715edeso1355195241.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692773841; x=1693378641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iVRAOJ2V1xFLlhLJ5dZhwuizlLc11hemaOhn9axZBD0=;
        b=N9E01nYu4DMUBxNw5K8MjXxy6A97r9ty3PhOwRfstuf1nTsAiVFZKGfc6KGe8A5afF
         1ptWhZyrbWjavtu8/IOQCMITzX4Irbz8woEu2IQRkWe68H9UoP1dMyCgsfoHVsQNwNfT
         fCvzOwT7RGgNIaYoPnq/eC605QyVdplAYxxdYGip+FbXef1Ds5ztdyB9pM073frW0CAg
         YBljBPEf+kOm2bzeoN9OsqYyHiXon7wtJjOmjy2TbK3nPjmogJfgZKROpq3O8ExY+thP
         hy8FYBqyojh1LWsvgGgVFln1xowb+q4GGu8+C7BY7y/Kb0E6GiqQN2gENzcXKcuOIHbU
         rMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692773841; x=1693378641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVRAOJ2V1xFLlhLJ5dZhwuizlLc11hemaOhn9axZBD0=;
        b=fsVb34Bn1Z+LGR+muJc02kgNbfMsHgw6TbwhM1uin9vsj793TuaTPCn9ZGKR2BGFIe
         4NdUQ9FyAZzCX1A6ntOa4MXbcNSsM6tb09rCp71+GxMq1v/ylS/xlcW7ToUgO4BTz3I+
         aDoMxl4vGh0oGWWl+OWDn2/GDoGaRu011ebcjh/KAbzF32eDm2kWDM2oR20crSlR3+ID
         8hdGNQAK7DsyScuNr9p1JKbghFSQxbDPaPBNJqZoFrgboY58pRDFKUNHtAWARmny5YsF
         wSW6lVPwQvZBIR/iBmywJp51I0jPkD7+4qorKQs8mw3yVmEDz33ISt/JINd4MGSfriAT
         mOFA==
X-Gm-Message-State: AOJu0YxF6OmI/YpiTsJJlscaf80ZVz3fhpcnsfox+laH0BG2GgAO31B9
        ImEywIpecLyt87ZOrwyXF67kRqtSxcaXw8fSWIM8raM0iImVbMMv
X-Google-Smtp-Source: AGHT+IGQvVZm8BkFEz+9tquBvWRQY0FaLDoMTO+xUVZEH/h9M0dLo23sZ7XdNYwYn1UP6B0iwAoN0O0ZglVbPVw5ShA=
X-Received: by 2002:a05:6102:448:b0:44d:590d:28a9 with SMTP id
 e8-20020a056102044800b0044d590d28a9mr4022555vsq.3.1692773841485; Tue, 22 Aug
 2023 23:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112933.1550062-1-sumit.garg@linaro.org> <CUZ4G9FRXIW1.23TJD5ASQBUNE@suppilovahvero>
In-Reply-To: <CUZ4G9FRXIW1.23TJD5ASQBUNE@suppilovahvero>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 23 Aug 2023 12:27:10 +0530
Message-ID: <CAFA6WYOetWZhuobQE3h1oyu=wKUOjyrVu53vyA399P0DV5MGjg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: Refactor register SHM usage
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        jejb@linux.ibm.com, zohar@linux.ibm.com, jens.wiklander@linaro.org,
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

On Tue, 22 Aug 2023 at 19:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue Aug 22, 2023 at 2:29 PM EEST, Sumit Garg wrote:
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
>
> Does this retain backwards compatibility?
>

Yeah it does retain backwards compatibility since there aren't any
changes needed on OP-TEE Trusted Keys TA end.

-Sumit

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
>
> BR, Jarkko
