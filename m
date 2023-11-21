Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64E7F293B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjKUJrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjKUJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:47:44 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61AE8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:47:39 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5ca53400c8bso20639387b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700560059; x=1701164859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OafUR08q0YCJ/66uYfFPZzQ+AA8BpAx9HNx2y4mOB9Q=;
        b=JAB7KdF3UJaTNMN/CeVVRjK6ZOTixWxQ0zm3K+etvDr2up1/2635vvuwitlSGddvv7
         P7iHWlBSbHRoKG8W9Dg2alvEWT32xH770bd+T6xUqVn5l3VzK4g7K0DwQYU+O+G+Xu/I
         rWosI2MCacieFibrUGyvjcMi3sJ9HUCK0hEQ3FLCWMHSKtww0XvYPEN/GKPQz+SRb71p
         3RKWxgL+Pzj4GZmWGNimz3wrcRDLTffeXuMXe7kP81EFMwGIi72/NJoX3oPoHBvbp0vJ
         3eIsiAZ4pUF2Q5Rma9I25ZWqaHdP8BYS/uvw7doGkp92iBuEAS4s1F/K/TtSclngc7Lf
         e2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700560059; x=1701164859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OafUR08q0YCJ/66uYfFPZzQ+AA8BpAx9HNx2y4mOB9Q=;
        b=crXdlKkKt10u4efYKz8H5dbutXppNTIOjZW0+ojgHSt9kXfyRYjZg6gM9rG6VuvRtx
         9STPwx2O475NqR9y7Zo9y9GgHrZpS3SP7G7/MF6tiu0SB/D9PYQjW5XzEmp2vJ23mdHe
         uIDgaY4uAhvGRYO/bQF0Myh+oja8NIVGXtN7w92CA8XqvnzGAfM6R/D+3AQXrJGN0yQ4
         2gnB49GP0hLv7SvMEQv9dBsnQ+kQiR6+nmUbe54J/2Eobo8vdF8xFNg4HePGngS03SDw
         Kd+uXbBTxVBseNwPpSrV7lO0J135io3QerzJ0Dk8147XNybLLMr9GFLVlqGAx2qEFHKG
         6Yaw==
X-Gm-Message-State: AOJu0YzXk6cd3ypCG+iSmEtTpOk+aUfaFnPl9//Q8k+OrFppJw8EcAma
        lT0s4UIv7RX7Kek8eBXwO/0D9Q4l6GYadORparZdRw==
X-Google-Smtp-Source: AGHT+IFhx06H1N1AuTlhLr5rUGaXwMw5pegkNRx+a1uz3ea8OpZoMmYO3Fts+35J4xfy7g1FV+zhW1CYBij0W1q/eRU=
X-Received: by 2002:a05:690c:7:b0:5c9:fed2:89c7 with SMTP id
 bc7-20020a05690c000700b005c9fed289c7mr8563449ywb.32.1700560058866; Tue, 21
 Nov 2023 01:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20231120132118.30473-1-brgl@bgdev.pl> <20231120132118.30473-4-brgl@bgdev.pl>
 <9315c8f1-19b8-9b11-8eb4-32b498f91659@quicinc.com>
In-Reply-To: <9315c8f1-19b8-9b11-8eb4-32b498f91659@quicinc.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 21 Nov 2023 10:47:27 +0100
Message-ID: <CACMJSev_cNNeOkhm0R=r+tqG-iGACL8Gif5P5dyyJXxL65RH=Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 03/12] firmware: qcom: scm: smc: switch to using
 the SCM allocator
To:     Prasad Sodagudi <quic_psodagud@quicinc.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
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

On Tue, 21 Nov 2023 at 07:38, Prasad Sodagudi <quic_psodagud@quicinc.com> wrote:
>
>
> On 11/20/2023 5:21 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We need to allocate, map and pass a buffer to the trustzone if we have
> > more than 4 arguments for a given SCM calls. Let's use the new TrustZone
> > allocator for that memory and shrink the code in process.
> >
> > As this code lives in a different compilation unit than the rest of the
> > SCM code, we need to provide a helper in the form of
> > qcom_scm_get_tzmem_pool() that allows the SMC low-level routines to
> > access the SCM memory pool.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> > ---
> >   drivers/firmware/qcom/qcom_scm-smc.c | 30 ++++++++--------------------
> >   drivers/firmware/qcom/qcom_scm.c     |  5 +++++
> >   drivers/firmware/qcom/qcom_scm.h     |  3 +++
> >   3 files changed, 16 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> > index 16cf88acfa8e..dca5f3f1883b 100644
> > --- a/drivers/firmware/qcom/qcom_scm-smc.c
> > +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> > @@ -2,6 +2,7 @@
> >   /* Copyright (c) 2015,2019 The Linux Foundation. All rights reserved.
> >    */
> >
> > +#include <linux/cleanup.h>
> >   #include <linux/io.h>
> >   #include <linux/errno.h>
> >   #include <linux/delay.h>
> > @@ -9,6 +10,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/types.h>
> >   #include <linux/firmware/qcom/qcom_scm.h>
> > +#include <linux/firmware/qcom/qcom_tzmem.h>
> >   #include <linux/arm-smccc.h>
> >   #include <linux/dma-mapping.h>
> >
> > @@ -150,11 +152,10 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
> >                  enum qcom_scm_convention qcom_convention,
> >                  struct qcom_scm_res *res, bool atomic)
> >   {
> > +     struct qcom_tzmem_pool *mempool = qcom_scm_get_tzmem_pool();
> >       int arglen = desc->arginfo & 0xf;
> >       int i, ret;
> > -     dma_addr_t args_phys = 0;
> > -     void *args_virt = NULL;
> > -     size_t alloc_len;
> > +     void *args_virt __free(qcom_tzmem) = NULL;
> >       gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
> >       u32 smccc_call_type = atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL;
> >       u32 qcom_smccc_convention = (qcom_convention == SMC_CONVENTION_ARM_32) ?
> > @@ -172,9 +173,9 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
> >               smc.args[i + SCM_SMC_FIRST_REG_IDX] = desc->args[i];
> >
> >       if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
> > -             alloc_len = SCM_SMC_N_EXT_ARGS * sizeof(u64);
> > -             args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
> > -
> > +             args_virt = qcom_tzmem_alloc(mempool,
> > +                                          SCM_SMC_N_EXT_ARGS * sizeof(u64),
> > +                                          flag);
>
> I remember seeing page alignment for this memory allocation in
> downstream code too.
>
> I think, after moving to qcom_tzmem_alloc page alignment is not
> followed. Is this cross checked with firmware requirements?
>

All SCM call requirements are still respected behind the scenes by the
allocator. Please see the implementations of qcom_tzmem_pool_new() and
qcom_tzmem_alloc().

Bart

> >               if (!args_virt)
> >                       return -ENOMEM;
> >
> > @@ -192,25 +193,10 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
> >                                                     SCM_SMC_FIRST_EXT_IDX]);
> >               }
> >
> > -             args_phys = dma_map_single(dev, args_virt, alloc_len,
> > -                                        DMA_TO_DEVICE);
> > -
> > -             if (dma_mapping_error(dev, args_phys)) {
> > -                     kfree(args_virt);
> > -                     return -ENOMEM;
> > -             }
> > -
> > -             smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
> > +             smc.args[SCM_SMC_LAST_REG_IDX] = qcom_tzmem_to_phys(args_virt);
> >       }
> >
> > -     /* ret error check follows after args_virt cleanup*/
> >       ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
> > -
> > -     if (args_virt) {
> > -             dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
> > -             kfree(args_virt);
> > -     }
> > -
> >       if (ret)
> >               return ret;
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 0d4c028be0c1..71e98b666391 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -201,6 +201,11 @@ static void qcom_scm_bw_disable(void)
> >   enum qcom_scm_convention qcom_scm_convention = SMC_CONVENTION_UNKNOWN;
> >   static DEFINE_SPINLOCK(scm_query_lock);
> >
> > +struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void)
> > +{
> > +     return __scm->mempool;
> > +}
> > +
> >   static enum qcom_scm_convention __get_convention(void)
> >   {
> >       unsigned long flags;
> > diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
> > index 4532907e8489..aa7d06939f8e 100644
> > --- a/drivers/firmware/qcom/qcom_scm.h
> > +++ b/drivers/firmware/qcom/qcom_scm.h
> > @@ -5,6 +5,7 @@
> >   #define __QCOM_SCM_INT_H
> >
> >   struct device;
> > +struct qcom_tzmem_pool;
> >
> >   enum qcom_scm_convention {
> >       SMC_CONVENTION_UNKNOWN,
> > @@ -78,6 +79,8 @@ int scm_legacy_call_atomic(struct device *dev, const struct qcom_scm_desc *desc,
> >   int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
> >                   struct qcom_scm_res *res);
> >
> > +struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
> > +
> >   #define QCOM_SCM_SVC_BOOT           0x01
> >   #define QCOM_SCM_BOOT_SET_ADDR              0x01
> >   #define QCOM_SCM_BOOT_TERMINATE_PC  0x02
