Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD47B2544
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjI1S2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1S2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:28:53 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA8599
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:28:52 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7ab9ad973e6so4205428241.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695925731; x=1696530531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9om/ckVzu1BhXirEdAXOAM/NI9XSDzx9LPQqirOKE8=;
        b=rQhA3anGPz22kMupp9q+zjND4NHBXYYo4uaXLSBsPsA2HaA1Q9yYRd852XGELPGp7w
         Zs8Gg5fP8VEPlp3ILAXDW5Cce8HLEbjertovh7Z11x60lqUCdFRSNAVj2GbZmU/63OkO
         ISOYMWNYbjIu0gzlNDbC/EpSGRCcpPOEHzv2RRKeIlkcTMOrX2RSbECaIfq0uFq+QPVg
         qjrjuKfm3sEcUlvLlXb0d9MELROEmzp7LSF59v9/HpWbTJ8IMgoEdiiGYzbK+0NQSJZz
         Fn86DiHDjYIGvkuO5qa3pwsqR45yqAywcAq1MP5g2dhFkzs29Y9C8KhX+DRVr3ol0/Dw
         XZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695925731; x=1696530531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9om/ckVzu1BhXirEdAXOAM/NI9XSDzx9LPQqirOKE8=;
        b=XZxFppjH+fdRYyagkFwX2b/lzVHS4oU+/FSA+LnIL74dxPftF+HCP9jTgeDO8BoNlD
         S6nvKfGE2KTPc00fD8KaKncqHERJTToXuwyorXY7DYRhPlA8HhyEWTEhoT1FgutQ1cQh
         fjyKtXjoHPpveSmwf+8Cz9VJPUtjOuR5m3iA7gnsOCtTb59oXZLOvgEs1LFhXEH0UNx0
         Otd7kRZeyn8hnr1yvPsWYRo/GKHJoE5qAxbB0rNPOBVXu2u36+7626CI7mhUJCKr+Ox1
         CwFCSdGfDsbPnPhLA9sxWBwCzwpXvA9fByCbzcyOC8DColVQh1CGHYwxGCpvA7JX90B+
         8cCA==
X-Gm-Message-State: AOJu0YyvK3zIbj8RmA0/T6T6asg0Kesicm2b0bnM7z3r2OExIQe06KFC
        EEqUQcY9I/V0hnfPgleJj+sb1SdFsCWHQMUVV2zxWg==
X-Google-Smtp-Source: AGHT+IExNLsGCshiEnWnkOn9rm4VKOCrckIERMzWbi8yYxtEZqjFp3axc5ckdLZshhUcJKUOliKxiH6PKLQwwxEe3Qw=
X-Received: by 2002:a67:fd49:0:b0:452:7799:9d5a with SMTP id
 g9-20020a67fd49000000b0045277999d5amr1920245vsr.20.1695925731091; Thu, 28 Sep
 2023 11:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230928092040.9420-1-brgl@bgdev.pl> <20230928092040.9420-12-brgl@bgdev.pl>
 <1160e239-b227-411d-8d64-a23fde014dd5@quicinc.com>
In-Reply-To: <1160e239-b227-411d-8d64-a23fde014dd5@quicinc.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Sep 2023 20:28:40 +0200
Message-ID: <CAMRc=MdMd7CGWEvDbcYRTHZaLpAYdKyR6wEuFTKux6T+C3UU+Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] firmware: qcom: scm: enable SHM bridge
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
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

On Thu, Sep 28, 2023 at 7:10=E2=80=AFPM Elliot Berman <quic_eberman@quicinc=
.com> wrote:
>
>
>
> On 9/28/2023 2:20 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Extens the SCM memory allocator with using the SHM Bridge feature if
> > available on the platform. This makes the trustzone only use dedicated
> > buffers for SCM calls. We map the entire SCM genpool as a bridge.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/firmware/qcom/qcom_scm-mem.c | 42 ++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm-mem.c b/drivers/firmware/qc=
om/qcom_scm-mem.c
> > index eafecbe23770..12b12b15f46f 100644
> > --- a/drivers/firmware/qcom/qcom_scm-mem.c
> > +++ b/drivers/firmware/qcom/qcom_scm-mem.c
> > @@ -16,6 +16,8 @@
> >
> >  #include "qcom_scm.h"
> >
> > +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> > +
> >  static size_t qcom_scm_mem_pool_size =3D SZ_2M;
> >  module_param_named(qcom_scm_mem_pool_size, qcom_scm_mem_pool_size,
> >                  ulong, 0400);
> > @@ -108,8 +110,24 @@ phys_addr_t qcom_scm_mem_to_phys(void *vaddr)
> >       return chunk->paddr;
> >  }
> >
> > +static int qcom_scm_mem_shm_bridge_create(void)
> > +{
> > +     uint64_t pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_per=
ms;
> > +
> > +     ns_perms =3D (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> > +     pfn_and_ns_perm =3D (u64)qcom_scm_mem.pbase | ns_perms;
> > +     ipfn_and_s_perm =3D (u64)qcom_scm_mem.pbase | ns_perms;
> > +     size_and_flags =3D qcom_scm_mem.size | (1 << QCOM_SHM_BRIDGE_NUM_=
VM_SHIFT);
> > +
> > +     return qcom_scm_create_shm_bridge(qcom_scm_mem.dev, pfn_and_ns_pe=
rm,
> > +                                       ipfn_and_s_perm, size_and_flags=
,
> > +                                       QCOM_SCM_VMID_HLOS);
> > +}
> > +
> >  int qcom_scm_mem_enable(struct device *dev)
> >  {
> > +     int ret;
> > +
> >       INIT_RADIX_TREE(&qcom_scm_mem.chunks, GFP_ATOMIC);
> >       spin_lock_init(&qcom_scm_mem.lock);
> >       qcom_scm_mem.dev =3D dev;
> > @@ -128,7 +146,25 @@ int qcom_scm_mem_enable(struct device *dev)
> >
> >       gen_pool_set_algo(qcom_scm_mem.pool, gen_pool_best_fit, NULL);
> >
> > -     return gen_pool_add_virt(qcom_scm_mem.pool,
> > -                              (unsigned long)qcom_scm_mem.vbase,
> > -                              qcom_scm_mem.pbase, qcom_scm_mem.size, -=
1);
> > +     ret =3D gen_pool_add_virt(qcom_scm_mem.pool,
> > +                             (unsigned long)qcom_scm_mem.vbase,
> > +                             qcom_scm_mem.pbase, qcom_scm_mem.size, -1=
);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D qcom_scm_enable_shm_bridge();
> > +     if (ret) {
> > +             if (ret =3D=3D EOPNOTSUPP)
> > +                     dev_info(dev, "SHM Bridge not supported\n");
> > +             else
> > +                     return ret;
> > +     } else {
> > +             ret =3D qcom_scm_mem_shm_bridge_create();
> > +             if (ret)
> > +                     return ret;
> > +
> > +             dev_info(dev, "SHM Bridge enabled\n");
>
> Do you need to add clean up (deletion) of the SHM bridge on driver remove=
?
>
> One easy approach I could think: implemnet devm_qcom_scm_mem_shm_bridge_c=
reate
> which calls qcom_scm_delete_shm_bridge on the clean up
> (qcom_scm_delete_shm_bridge implemented in downstream, not in this series=
).
>

There wouldn't be any user of these symbols yet so let's think about
it when there's a valid use-case upstream.

Bart

> > +     }
> > +
> > +     return 0;
> >  }
