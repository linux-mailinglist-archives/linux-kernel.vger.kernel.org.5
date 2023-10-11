Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1497C4C26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjJKHmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJKHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:42:03 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BD1B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:42:01 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4542d7e9bcfso2741981137.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697010120; x=1697614920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvr2mhxzZf0lzgYji+v1xxemtFF8X0p4vy2inlI9AV4=;
        b=mk9nVMNOxoT6muqGaoAGI/iKmVzHUOrLSPPlpobqFpMv8BsU2yILfKmAnDmuYkMfyK
         BF2Wx3XZeL/4Ezpq0wCdse3kOWm3SFE2fgtQdSl9OryulTn5oWnRIj7VQvBaILCdM2dX
         olzhux03qfx76mVQQb4RXmbUKCnNHVHFzHn9z03uYwPqM4TywXEXlFloI5DcYuWW5Htc
         v/HJ+VzQM3GQjaGKxxqtJSF5eWtHBW+aak1liqCpw4r7RpZUiyPcpwvmMyaDEryH2f/a
         dCKucVdZddQMdIaoaQGINjsvTPW2YOxzqFpAj6LuPEG4z9zZN1CBB1C4Bs5cjINwV9XV
         0tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697010120; x=1697614920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvr2mhxzZf0lzgYji+v1xxemtFF8X0p4vy2inlI9AV4=;
        b=eu1Oszn60J0He6/qdJsFEVxH1dKupOwyNpAmc6G4dbw6ssR52znB4oJ6wEgC/4tzEc
         Hgj9luDVWeU1SeDKLqUB0kD92CSZDuTt0FYyroNRAaPIsmtMylcyvpqq2CHksUOBBjZF
         /bNbh1du6N6sBEC5ziS18mxAMFn9KzATXRuzaecvMn0JkatmaEfhcm+OR1ogeXMt2dVS
         YsF0kzy1hjzRsY0c5QbTlvAwRZFqiBq5N2BAaf0AgPFgyaw+/h+IU/tFJJuubMguStBz
         DooH11Om1w3J7CzJ/YI4JJTKRzyWB7QNiKZT0yQvX03vy047nzrVBky7wybHArP+bCRV
         fOPA==
X-Gm-Message-State: AOJu0Yx8ovy0AQ8kA7JogWXc+mHg9Vycc1acl29fPTwsg5xFROuAcM1j
        cYvgDI+wKHE+qrpqQVn+zGb0jHGIJ5d86oy29QjlOA==
X-Google-Smtp-Source: AGHT+IFTN0EUHqjNAwPaRMQ3STkQCkK/6QueiW0s8LX0on+hLpESjYrqGF30v+DE1fEs2AWqmhEkVH78JN6521l4424=
X-Received: by 2002:a67:fb59:0:b0:452:72ed:7020 with SMTP id
 e25-20020a67fb59000000b0045272ed7020mr19480840vsr.32.1697010120424; Wed, 11
 Oct 2023 00:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153427.20951-1-brgl@bgdev.pl> <20231009153427.20951-8-brgl@bgdev.pl>
 <v5ty4xeshodjlpyatqlrjipqejazamuhqhauorujveyqzpikoq@rftlvk6354yx>
In-Reply-To: <v5ty4xeshodjlpyatqlrjipqejazamuhqhauorujveyqzpikoq@rftlvk6354yx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 09:41:49 +0200
Message-ID: <CAMRc=MdGABGa_bc3_ug+iSKtMg9pcKe40F7zv9Ff2C0ed8i2=Q@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:19=E2=80=AFAM Andrew Halaney <ahalaney@redhat.co=
m> wrote:
>
> On Mon, Oct 09, 2023 at 05:34:19PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Let's use the new TZ memory allocator to obtain a buffer for this call
> > instead of using dma_alloc_coherent().
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/q=
com_scm.c
> > index 71e98b666391..754f6056b99f 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -4,6 +4,7 @@
> >   */
> >
> >  #include <linux/arm-smccc.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/clk.h>
> >  #include <linux/completion.h>
> >  #include <linux/cpumask.h>
> > @@ -998,14 +999,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, siz=
e_t mem_sz,
> >       struct qcom_scm_mem_map_info *mem_to_map;
> >       phys_addr_t mem_to_map_phys;
> >       phys_addr_t dest_phys;
> > -     dma_addr_t ptr_phys;
> > +     phys_addr_t ptr_phys;
> >       size_t mem_to_map_sz;
> >       size_t dest_sz;
> >       size_t src_sz;
> >       size_t ptr_sz;
> >       int next_vm;
> >       __le32 *src;
> > -     void *ptr;
>
> nit: couldn't you keep this up here?
>

This still needs to make its way into the coding style guide but I got
yelled at by Linus Torvalds personally for not declaring the managed
variables where they are initialized. So this is the correct approach.

Bart

> Otherwise,
>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
>
> >       int ret, i, b;
> >       u64 srcvm_bits =3D *srcvm;
> >
> > @@ -1015,10 +1015,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, s=
ize_t mem_sz,
> >       ptr_sz =3D ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
> >                       ALIGN(dest_sz, SZ_64);
> >
> > -     ptr =3D dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KER=
NEL);
> > +     void *ptr __free(qcom_tzmem) =3D qcom_tzmem_alloc(__scm->mempool,
> > +                                                     ptr_sz, GFP_KERNE=
L);
> >       if (!ptr)
> >               return -ENOMEM;
> >
> > +     ptr_phys =3D qcom_tzmem_to_phys(ptr);
> > +
> >       /* Fill source vmid detail */
> >       src =3D ptr;
> >       i =3D 0;
> > @@ -1047,7 +1050,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, siz=
e_t mem_sz,
> >
> >       ret =3D __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to=
_map_sz,
> >                                   ptr_phys, src_sz, dest_phys, dest_sz)=
;
> > -     dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
> >       if (ret) {
> >               dev_err(__scm->dev,
> >                       "Assign memory protection call failed %d\n", ret)=
;
> > --
> > 2.39.2
> >
>
