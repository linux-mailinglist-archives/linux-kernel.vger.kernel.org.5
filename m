Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20CD7B2D92
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjI2IPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjI2IPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:15:14 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E051A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:15:12 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49ad8b76003so512320e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695975311; x=1696580111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QboF2qzgqtIeZzJ3xn9fVEEuaznoJ/3H4/aU31FTcJo=;
        b=zu5Nv6tszucFpSDovhfdoWrehyTuVAYPNnzChIiFLtsZR3pjKEOohVbJ1SVYfFFavj
         rM102WX+XVjQU+/gt7JYo7rXwNnX0VPrQwtcquMKUcz5l5QVM0jbreTnWIjv+uPhdhaH
         BdtWHvf4QNGW365YEXjh+hsu3B8dP9GY5byiB2eKfE7Khoykee32/Zo4Kfw1vcZI7pP5
         dvNmdItfwODZrhYDwhHUgzqe1w7zoskwRmCc1POT6sVOtsGeMYaMNtG+RipwGfdd3Lfy
         G/Jtb3v5rG4hQNEJzXNwhNiqVekrrvCGhu6LC/gt5ZtwrtXjp0gb8No6EVyndHE7VFpq
         /rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695975311; x=1696580111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QboF2qzgqtIeZzJ3xn9fVEEuaznoJ/3H4/aU31FTcJo=;
        b=KPDb6+XRlsW2NILhT/CXpb+TYkx6vR2m4tHngW68yrX6W21Cuw/VTe4BkmbmV6dOS+
         zZwHNajXG0xR+HXEM9jKwHd3mxCfMACLMWxWMrC7GqoOBofLy1CGgVF05pFDgrOcdYvh
         TOnOHoPnDyBBdOSe7wX6qODRGThwNtmg7jFGN65ZBOnTjEuCc5ca2p15BK+GfUTW0T7y
         f8p7G2eClV3ti8EpouEHUqCnOz8JGpi8T82OODRxXSQM/iLwo2YZPNVn4iazhqxRo6/N
         7am2etVLbPdEWb+Fv/ALJqR/e3sHmGqcZWb4Qyw7VnTUDwlAvNmkSQ7iYot8zknNghT2
         A+gg==
X-Gm-Message-State: AOJu0YxLkuNjjIQwCTgg7b88yxY9D8L1NhMYPhDeznj6Jiy7D+CsAKmX
        BsWgccTnmmfZxob37kyQbH0iVuSef8F/oTK7rj1/kQ==
X-Google-Smtp-Source: AGHT+IHP0SVmQPWEpAkwmu297wB0/o5mIfkN7y1TRcb/nwe4bmndkyrosbLgTUy1jSx/gupLVdnAKMxHIMohG4p8PqQ=
X-Received: by 2002:a1f:ec43:0:b0:495:cace:d59c with SMTP id
 k64-20020a1fec43000000b00495caced59cmr3496382vkh.0.1695975311330; Fri, 29 Sep
 2023 01:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230928092040.9420-1-brgl@bgdev.pl> <20230928092040.9420-4-brgl@bgdev.pl>
In-Reply-To: <20230928092040.9420-4-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 29 Sep 2023 10:15:00 +0200
Message-ID: <CAMRc=MfBoekf_5gjF13Acj+zS9H81pA=7=MVYys3E70qvEzUQw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] firmware: qcom: scm: switch to using the SCM allocator
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:21=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We need to allocate, map and pass a buffer to the trustzone if we have
> more than 4 arguments for a given SCM calls. Let's use the new SCM
> allocator for that memory and shrink the code in process.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm-smc.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom=
/qcom_scm-smc.c
> index 16cf88acfa8e..0d5554df1321 100644
> --- a/drivers/firmware/qcom/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2015,2019 The Linux Foundation. All rights reserved.
>   */
>
> +#include <linux/cleanup.h>
>  #include <linux/io.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> @@ -152,8 +153,7 @@ int __scm_smc_call(struct device *dev, const struct q=
com_scm_desc *desc,
>  {
>         int arglen =3D desc->arginfo & 0xf;
>         int i, ret;
> -       dma_addr_t args_phys =3D 0;
> -       void *args_virt =3D NULL;
> +       void *args_virt __free(qcom_scm_mem) =3D NULL;
>         size_t alloc_len;
>         gfp_t flag =3D atomic ? GFP_ATOMIC : GFP_KERNEL;
>         u32 smccc_call_type =3D atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_=
STD_CALL;
> @@ -173,7 +173,7 @@ int __scm_smc_call(struct device *dev, const struct q=
com_scm_desc *desc,
>
>         if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
>                 alloc_len =3D SCM_SMC_N_EXT_ARGS * sizeof(u64);
> -               args_virt =3D kzalloc(PAGE_ALIGN(alloc_len), flag);
> +               args_virt =3D qcom_scm_mem_alloc(PAGE_ALIGN(alloc_len), f=
lag);

Ah, I realized the PAGE_ALIGN() here can be dropped when switching to
the new allocator.

There'll be a v3 anyway so I'll drop it then.

Bart

>
>                 if (!args_virt)
>                         return -ENOMEM;
> @@ -192,25 +192,12 @@ int __scm_smc_call(struct device *dev, const struct=
 qcom_scm_desc *desc,
>                                                       SCM_SMC_FIRST_EXT_I=
DX]);
>                 }
>
> -               args_phys =3D dma_map_single(dev, args_virt, alloc_len,
> -                                          DMA_TO_DEVICE);
> -
> -               if (dma_mapping_error(dev, args_phys)) {
> -                       kfree(args_virt);
> -                       return -ENOMEM;
> -               }
> -
> -               smc.args[SCM_SMC_LAST_REG_IDX] =3D args_phys;
> +               smc.args[SCM_SMC_LAST_REG_IDX] =3D qcom_scm_mem_to_phys(a=
rgs_virt);
>         }
>
>         /* ret error check follows after args_virt cleanup*/
>         ret =3D __scm_smc_do(dev, &smc, &smc_res, atomic);
>
> -       if (args_virt) {
> -               dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE=
);
> -               kfree(args_virt);
> -       }
> -
>         if (ret)
>                 return ret;
>
> --
> 2.39.2
>
