Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2A7C56ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjJKOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjJKOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:34:07 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7390
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:34:05 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49d8fbd307fso2603152e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697034844; x=1697639644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9dlHMKHWL4oxHCbk6cTeoLTqzzESyQ3LZPT6zZgxVY=;
        b=LVa4jdtIOk3uzOzcI+RwwmcQyFs3BY77zMBb2Zodk31dj02ZGjvshdu1zj/PnGFL2r
         4duQpT6YAL26wKxxmrwE4s1Ijx5Ebu03ElvO6loaQXougudJt9IxhfV9on5cxglPeKan
         mXnf7hSjq5VpXLmXi1YAAfSeqIOqax7lli6j6KU4xKThPTuqLNfoEfdv3Cz5JYFE7a4W
         6/5Z679DQEIeF11BZ0z20AOyl+9z2ODi7A7DSHFmjIjBaqSzm9WT3nWdcpIyOi04aK21
         YI5Zzp1OtkKGOXvql/5Ejv5IS6of/zDY3LRtCVANikdLh/ok1IbGLJw92AiUirVWCTfc
         Zh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697034844; x=1697639644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9dlHMKHWL4oxHCbk6cTeoLTqzzESyQ3LZPT6zZgxVY=;
        b=QI4zYF+EPZV98Eh4Qh/cEw3uRP0h7QB4dJy8+21yf16g5Ouxoc9OJkoGQZSFCKTgMs
         DabVHC8CR/wTrR3qjRIxc5WGj1UezcD94V1++c18k/1u/Yxo6ZfAOAE0t572pLZtwpLI
         G7Kr7vQoRVdyXTsJHiAtCQMSGMhaX00zaoutZcQ7n4hiOvJ/tiyEzMi7aYl3QR0SnJMv
         2dC1d5SM5NyCMsnk8t6iIvFRCfk413h72g3wgH3bad2Yktf4FXzq4IEsqfNZyvGk2JCO
         714y/ziddkgQZV9WhtWxnjCN+vLAtwVjDmqNrfUM9m1auqsZEqDoHfpUDDxwme0XEk2w
         067Q==
X-Gm-Message-State: AOJu0YwCts6EfKZNcTf3TCXrSrMk/8QGeTYxVunsKN+MVghwStRCD6pQ
        daU8C577Y2wxFUHlDpfOn9giHEJIwcKAPXhCP55KmQ==
X-Google-Smtp-Source: AGHT+IEUbqktC4PpTtZ06GVQtHc4WrK6oRv5c4SbnVBHjACZzvvpIpaLxZa1p1qSGn6py3G8qorRiDcFxdkmOhzdNT0=
X-Received: by 2002:a05:6122:1d47:b0:49d:eeed:3ed5 with SMTP id
 gd7-20020a0561221d4700b0049deeed3ed5mr16800967vkb.14.1697034844510; Wed, 11
 Oct 2023 07:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153427.20951-1-brgl@bgdev.pl> <20231009153427.20951-8-brgl@bgdev.pl>
 <v5ty4xeshodjlpyatqlrjipqejazamuhqhauorujveyqzpikoq@rftlvk6354yx>
 <CAMRc=MdGABGa_bc3_ug+iSKtMg9pcKe40F7zv9Ff2C0ed8i2=Q@mail.gmail.com> <nq6m3v2wflhv5qgxtllympnzqtbtcn7d7ihgw5rdpvqjugv2xs@4vpuzoopkeic>
In-Reply-To: <nq6m3v2wflhv5qgxtllympnzqtbtcn7d7ihgw5rdpvqjugv2xs@4vpuzoopkeic>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 16:33:53 +0200
Message-ID: <CAMRc=MdO3ctA-g=VVhXp9QKPdUT1XX0iEKTzEKzHjNzh_=-jPQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] firmware: qcom: scm: make qcom_scm_assign_mem()
 use the TZ allocator
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
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

On Wed, Oct 11, 2023 at 3:54=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Wed, Oct 11, 2023 at 09:41:49AM +0200, Bartosz Golaszewski wrote:
> > On Wed, Oct 11, 2023 at 12:19=E2=80=AFAM Andrew Halaney <ahalaney@redha=
t.com> wrote:
> > >
> > > On Mon, Oct 09, 2023 at 05:34:19PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Let's use the new TZ memory allocator to obtain a buffer for this c=
all
> > > > instead of using dma_alloc_coherent().
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > >  drivers/firmware/qcom/qcom_scm.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qc=
om/qcom_scm.c
> > > > index 71e98b666391..754f6056b99f 100644
> > > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > > > @@ -4,6 +4,7 @@
> > > >   */
> > > >
> > > >  #include <linux/arm-smccc.h>
> > > > +#include <linux/cleanup.h>
> > > >  #include <linux/clk.h>
> > > >  #include <linux/completion.h>
> > > >  #include <linux/cpumask.h>
> > > > @@ -998,14 +999,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr,=
 size_t mem_sz,
> > > >       struct qcom_scm_mem_map_info *mem_to_map;
> > > >       phys_addr_t mem_to_map_phys;
> > > >       phys_addr_t dest_phys;
> > > > -     dma_addr_t ptr_phys;
> > > > +     phys_addr_t ptr_phys;
> > > >       size_t mem_to_map_sz;
> > > >       size_t dest_sz;
> > > >       size_t src_sz;
> > > >       size_t ptr_sz;
> > > >       int next_vm;
> > > >       __le32 *src;
> > > > -     void *ptr;
> > >
> > > nit: couldn't you keep this up here?
> > >
> >
> > This still needs to make its way into the coding style guide but I got
> > yelled at by Linus Torvalds personally for not declaring the managed
> > variables where they are initialized. So this is the correct approach.
>
> I'm being a stick in the mud, but couldn't you initialize to NULL and
> keep them all up top? That seems more in line with the current "declare
> all variables at the start of function" guideline the kernel follows.
>
> Not a big deal... yours call! but /me shrugs
>

I agree with you but it's not my call to make. Please see[1].

Bartosz

[1] https://lore.kernel.org/lkml/20230919193516.GA20937@noisy.programming.k=
icks-ass.net/T/#m7f97e10dbfde777f58493398a77933e6a2f3c15d

> >
> > Bart
> >
> > > Otherwise,
> > >
> > > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > >
> > > >       int ret, i, b;
> > > >       u64 srcvm_bits =3D *srcvm;
> > > >
> > > > @@ -1015,10 +1015,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_add=
r, size_t mem_sz,
> > > >       ptr_sz =3D ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64)=
 +
> > > >                       ALIGN(dest_sz, SZ_64);
> > > >
> > > > -     ptr =3D dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP=
_KERNEL);
> > > > +     void *ptr __free(qcom_tzmem) =3D qcom_tzmem_alloc(__scm->memp=
ool,
> > > > +                                                     ptr_sz, GFP_K=
ERNEL);
> > > >       if (!ptr)
> > > >               return -ENOMEM;
> > > >
> > > > +     ptr_phys =3D qcom_tzmem_to_phys(ptr);
> > > > +
> > > >       /* Fill source vmid detail */
> > > >       src =3D ptr;
> > > >       i =3D 0;
> > > > @@ -1047,7 +1050,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr,=
 size_t mem_sz,
> > > >
> > > >       ret =3D __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, me=
m_to_map_sz,
> > > >                                   ptr_phys, src_sz, dest_phys, dest=
_sz);
> > > > -     dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
> > > >       if (ret) {
> > > >               dev_err(__scm->dev,
> > > >                       "Assign memory protection call failed %d\n", =
ret);
> > > > --
> > > > 2.39.2
> > > >
> > >
> >
>
