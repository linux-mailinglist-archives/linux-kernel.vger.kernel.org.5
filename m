Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C38A7A0314
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjINLwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbjINLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:52:07 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34171BE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:52:03 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7f0048b042so877670276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694692323; x=1695297123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOUEoWCoocBtSGgV6FK5TFmlWuuWLandTZ80F2DQ2rk=;
        b=q++ZGo1B47W/LTNaEjZTX2l+ByO3OEB8Nbz+LgAh9yVwtMVRj4g1cnVKa5yLj4O4WK
         2AIBpQxT1g88bfEAYY/WdBSl88K6uTd7RCFfa99vtllffVXyNCE3SMOAcczkMkPeZADT
         uIcSGwINQJOHsAWiLva3bDo/R5i6X1eNnlDG4B8d3ak73p/INWpKOTMBJ9qg9O+TCTel
         1npKkSgFABY5+3B1frpuEMqxfv6wKU0nTggcZMtq4Y/3JTNUET9+cZ5dFWllQlDQjbUR
         mkD5VyOEDawj7HzcY8ZWpXFnfsRi3JcmLRBjUyKid4f1FCLT4NXUwlARATaFN6LeE2N7
         3CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694692323; x=1695297123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOUEoWCoocBtSGgV6FK5TFmlWuuWLandTZ80F2DQ2rk=;
        b=W1WvBmXcej+VtMv8fKiVibeSZbafkBTskFdC6MAh9OfJ9lsTEs90h2KQA+RQpYrnNk
         uv1iO2e1H31IlctO3iLTU/abcUB4z2dwvhJ7RHavFyuGahRmpUBf5Qn1xdWjPqV3rqUH
         ZlFs3QNTX7/opB2eKdePpKSblChyT3lOATrOxP7Z060ZH+naHBph1++Hq0XyStZSOPlq
         2vFaNJUXkLsNJcHh3BI/m8qPf0bXGvk0Ct1oz1p6n1uH4sUwwBoHdr7TBtEQeJfyDU5o
         RKI2c1RQjLwR3l8AqOKyvLue0dc6SyKIxnupBhmaeXrObCFgP5T7zcFX6r8Cw7NupjRy
         ZBLA==
X-Gm-Message-State: AOJu0YxNuuP3Mx3oyTskGEoIOFIMKEUbERQ2/gYc/hyrH7ANlFCM/Kgv
        iZYkYGPmnrDoIA4oAMwEd43GOpKHIVcLe9m3zLdLaA==
X-Google-Smtp-Source: AGHT+IHD8VvcoE47pb1lIcfSKbtIiW7ws0imUaLM67I3lgZ6IbvqTW/m+pTULfW+iNfibDtFe9PuifpTuzvff1x23T0=
X-Received: by 2002:a25:109:0:b0:d00:cc5b:8a9f with SMTP id
 9-20020a250109000000b00d00cc5b8a9fmr4681660ybb.16.1694692322860; Thu, 14 Sep
 2023 04:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230901120836.1057900-1-yann.gautier@foss.st.com>
 <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
 <CAPDyKFqJzoBiG4c2NbXA_6YDNsAh4W0TO-SP9+C2Qw40TKVH7g@mail.gmail.com> <ab2f88c3-2f80-a0ae-3a74-d90dd2a6ccf3@foss.st.com>
In-Reply-To: <ab2f88c3-2f80-a0ae-3a74-d90dd2a6ccf3@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 13:51:51 +0200
Message-ID: <CACRpkdY1cU4D_qbC3g6wV5hcKVCL6uMJu9mH=byw+2RgQTPicQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:08=E2=80=AFAM Yann Gautier <yann.gautier@foss.st=
.com> wrote:
> On 9/4/23 14:21, Ulf Hansson wrote:
> > On Fri, 1 Sept 2023 at 16:10, Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >>
> >> Hi Yann/Christophe,
> >>
> >> thanks for your patch!
> >>
> >> On Fri, Sep 1, 2023 at 2:08=E2=80=AFPM Yann Gautier <yann.gautier@foss=
.st.com> wrote:
> >>
> >>> From: Christophe Kerello <christophe.kerello@foss.st.com>
> >>>
> >>> Add the support of SDIO in-band interrupt mode for STM32 variant.
> >>> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line=
.
> >>>
> >>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> >>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> >> (...)
> >>> +++ b/drivers/mmc/host/mmci.h
> >>> @@ -332,6 +332,7 @@ enum mmci_busy_state {
> >>>    * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOW=
ER register
> >>>    * @dma_lli: true if variant has dma link list feature.
> >>>    * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
> >>> + * @use_sdio_irq: allow SD I/O card to interrupt the host
> >>
> >> The documentation tag should be one line up (compare to the members...=
)
> >>
> >>> @@ -376,6 +377,7 @@ struct variant_data {
> >>>          u32                     start_err;
> >>>          u32                     opendrain;
> >>>          u8                      dma_lli:1;
> >>> +       u8                      use_sdio_irq:1;
> >>
> >> 1. bool use_sdio_irq;
> >>
> Hi,
>
> Should it really be changed to a bool?
> Other boolean likes in the structure are u8:1.

Yes, two wrongs does not make one right.

Using u8:1 is a way of trying to outsmart the compiler
which is generally a bad idea.

> > That said, the out-of-band IRQs is what works best for the ux500 varian=
ts.
>
> What I understand here is that in-band interrupts are not properly
> working on ux500, and then the feature shouldn't be enabled for this
> platform.
> Am I correct?

I think we can flag the feature as available and implement the handling
but add a comment that this is unstable and that Ux500 users should
prefer to use out-of-band IRQs.

Yours,
Linus Walleij
