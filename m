Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E587B3A57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjI2TAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjI2TAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:00:33 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E31AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:00:31 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4547322a756so941632137.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696014030; x=1696618830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy1nUobY7c45BmPf8DhI4WWAR3T7zbOP0wGZy7EraWU=;
        b=AZD//jOGnQM+BHELAPEda7xOw6Nfoe2Rd+H9HtrBhyT32DMd6HWJJCeedapdw/Gkok
         VlTkXiUubJDlyQbXOFMzrAUZlmkq/AOnvQHUPA74NwvHBxL29IYI6GhTujmhmmkdjTiW
         P3xTjzG7kOPk7LYGB7G9V0uGwVhslmujrnAt5lOlCCTeFY1u69YEwsEnTp78zSG80NXR
         gdWjF7+pa+atbQenRP5akx8Rj5FEFIdDNIvOyatuaEGdzYHfjGRuWLJnZLttJ7Wb539j
         8hkM/8wzHtxLP/3faVDK40oRb5rGHu4qwI8EY8KwBZNalOcSfdqJysuoLyU4HhdsDtE0
         q//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014030; x=1696618830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy1nUobY7c45BmPf8DhI4WWAR3T7zbOP0wGZy7EraWU=;
        b=vEetWx6HmirR0dx5HV/auFpnCtStkV2vwkIKyhYRw2PYhjhpY/iL4kX4NWENlpnM5b
         An0dQ+HclF86W4z1UJd/ftpoJD/cJ7gMqyu5d4KSprV3tbFKgpK/ymfMPt0NzKzN8MEt
         +kM1UTEC3dxVxwTPqEAns5kFgKxQqZpDHqkP1ppnSj7oH9dlICKhpmD62Fa3diwemcLw
         b8WM/aSU8vC43QMjvaFhohVKVqmWKvPWTNphSb3VKvkR057I9dCOrtcJVomxCRaWfeQg
         pZVnrJ5Kz6P7pARLq62aH3kEDqvcaAkGc4V1A+XBRqZFPD0+sFnrcNXlYMozVSYeW5GP
         xxrw==
X-Gm-Message-State: AOJu0YxNx5osgLXhwPfIRDfd6mjYNNngJSP0XRcEO0ySJcn3n/8L8v7L
        BMr4Iu906shJr1F9y5R1Df6KFemxlxu07+vN3ARiRV0TAgqOX+rw
X-Google-Smtp-Source: AGHT+IHwtf45i8P95yaxIBktElpssTUgJ+uybtdODx0PXt2y9kXj+63SJ/vqSQbq1Hz4vPS1JK1mLyvD4enF4JkPWW4=
X-Received: by 2002:a67:f296:0:b0:452:5e2e:a4e1 with SMTP id
 m22-20020a67f296000000b004525e2ea4e1mr4400477vsk.14.1696014030177; Fri, 29
 Sep 2023 12:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230928092040.9420-1-brgl@bgdev.pl> <20230928092040.9420-12-brgl@bgdev.pl>
In-Reply-To: <20230928092040.9420-12-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 29 Sep 2023 21:00:19 +0200
Message-ID: <CAMRc=Md51N=zuJt0FVfNNvXbYbn-Gu7czU29dC-bsGrWiwOc8A@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] firmware: qcom: scm: enable SHM bridge
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
> Extens the SCM memory allocator with using the SHM Bridge feature if
> available on the platform. This makes the trustzone only use dedicated
> buffers for SCM calls. We map the entire SCM genpool as a bridge.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm-mem.c | 42 ++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/qcom/qcom_scm-mem.c b/drivers/firmware/qcom=
/qcom_scm-mem.c
> index eafecbe23770..12b12b15f46f 100644
> --- a/drivers/firmware/qcom/qcom_scm-mem.c
> +++ b/drivers/firmware/qcom/qcom_scm-mem.c
> @@ -16,6 +16,8 @@
>
>  #include "qcom_scm.h"
>
> +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> +
>  static size_t qcom_scm_mem_pool_size =3D SZ_2M;
>  module_param_named(qcom_scm_mem_pool_size, qcom_scm_mem_pool_size,
>                    ulong, 0400);
> @@ -108,8 +110,24 @@ phys_addr_t qcom_scm_mem_to_phys(void *vaddr)
>         return chunk->paddr;
>  }
>
> +static int qcom_scm_mem_shm_bridge_create(void)
> +{
> +       uint64_t pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_per=
ms;
> +
> +       ns_perms =3D (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> +       pfn_and_ns_perm =3D (u64)qcom_scm_mem.pbase | ns_perms;
> +       ipfn_and_s_perm =3D (u64)qcom_scm_mem.pbase | ns_perms;
> +       size_and_flags =3D qcom_scm_mem.size | (1 << QCOM_SHM_BRIDGE_NUM_=
VM_SHIFT);
> +
> +       return qcom_scm_create_shm_bridge(qcom_scm_mem.dev, pfn_and_ns_pe=
rm,
> +                                         ipfn_and_s_perm, size_and_flags=
,
> +                                         QCOM_SCM_VMID_HLOS);
> +}
> +
>  int qcom_scm_mem_enable(struct device *dev)
>  {
> +       int ret;
> +
>         INIT_RADIX_TREE(&qcom_scm_mem.chunks, GFP_ATOMIC);
>         spin_lock_init(&qcom_scm_mem.lock);
>         qcom_scm_mem.dev =3D dev;
> @@ -128,7 +146,25 @@ int qcom_scm_mem_enable(struct device *dev)
>
>         gen_pool_set_algo(qcom_scm_mem.pool, gen_pool_best_fit, NULL);
>
> -       return gen_pool_add_virt(qcom_scm_mem.pool,
> -                                (unsigned long)qcom_scm_mem.vbase,
> -                                qcom_scm_mem.pbase, qcom_scm_mem.size, -=
1);
> +       ret =3D gen_pool_add_virt(qcom_scm_mem.pool,
> +                               (unsigned long)qcom_scm_mem.vbase,
> +                               qcom_scm_mem.pbase, qcom_scm_mem.size, -1=
);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D qcom_scm_enable_shm_bridge();
> +       if (ret) {
> +               if (ret =3D=3D EOPNOTSUPP)

FYI I noticed this is wrong, I will fix it in v3.

Bart

> +                       dev_info(dev, "SHM Bridge not supported\n");
> +               else
> +                       return ret;
> +       } else {
> +               ret =3D qcom_scm_mem_shm_bridge_create();
> +               if (ret)
> +                       return ret;
> +
> +               dev_info(dev, "SHM Bridge enabled\n");
> +       }
> +
> +       return 0;
>  }
> --
> 2.39.2
>
