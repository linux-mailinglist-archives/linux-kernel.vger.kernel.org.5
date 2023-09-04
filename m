Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A9791707
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352942AbjIDMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348143AbjIDMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:22:16 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F821B8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:22:13 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5921a962adfso13873937b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693830132; x=1694434932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtWz4Zjn1UW6f/Bp4thXGCFf7baahobrbXRCy95Pavs=;
        b=UhsS0EBIvwrlU0X3g+ma8zg/cvrCUw/0Tb3iGQV7qei6X2rBwYCyCxB5l2bt4/9QJ5
         5OWZbprpt47hee50lCQjvOHS3mS6+79bgqbs+RCM88Ve57xdFafnOxrz3Y/BiJP4MGQk
         mt/GkjzyqdL2rAaPUkn68JKl3MupsPiLcJ+ZINv0fGWdSDSLMr1g1id2qXH8m874qTTO
         F8iUnYfEZLFFR95i+gqvj8HQkXntlMJihwjYZce0OUQhrDO3iBluabciB14sfx+Jd4ES
         j8B9JcUTira4CUbMelNFojR93n+yCXhniRFntiu2gsFXvreadrUG0LhZC5O720UGbBpE
         qZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693830132; x=1694434932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtWz4Zjn1UW6f/Bp4thXGCFf7baahobrbXRCy95Pavs=;
        b=OucL9lIM2RR6YX3KjyHv87IxBwfDTRsoj/CZ1vYP4t+VNAcNnnwx6YRLF9rfRlM8B+
         ipC/h3oAViXCcN+8bQgx4Pqs0xqORcr47oSSp7VUZOmjzp7L6iQjY9BzQjgpZ+Bs0A/3
         0rw5ICRiOiwXkdb6WB6SW9OhOvXjCZqpUoIgHyJAlB0t9+CQ0rpBwS0h90E5Pu1/u7EA
         VZPut4LuNAcEVRhhTpcGlSKBWcJ9YGO9AU954n38YBXVRt3vhXuS/de791BjSAKW3Wiz
         jPsqIDEK3TKIhTMruzVhyVm4lRZKSh82JqmTE6HML8CD37TXzWucTW/dLKfVp9nhHkEG
         BErg==
X-Gm-Message-State: AOJu0YzN0NsAfWPROjcf+RU9cg+E5xhwca8EdP5LommaE38cDxoUaF6G
        nYIYvKKkN89Bk/wL7MtNru07QkMMI1JFoibD/3080A==
X-Google-Smtp-Source: AGHT+IHPwKOL/2Z9FQ4y0NEX4i5C+ax07Yhv4XOcJCyrKvr2TbeaxnBIPI7R8RJYi9WrH6gCRPBTH43bpu9g6ij4cKI=
X-Received: by 2002:a25:c509:0:b0:d74:6163:db8c with SMTP id
 v9-20020a25c509000000b00d746163db8cmr11092688ybe.41.1693830131892; Mon, 04
 Sep 2023 05:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230901120836.1057900-1-yann.gautier@foss.st.com> <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
In-Reply-To: <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Sep 2023 14:21:35 +0200
Message-ID: <CAPDyKFqJzoBiG4c2NbXA_6YDNsAh4W0TO-SP9+C2Qw40TKVH7g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sept 2023 at 16:10, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> Hi Yann/Christophe,
>
> thanks for your patch!
>
> On Fri, Sep 1, 2023 at 2:08=E2=80=AFPM Yann Gautier <yann.gautier@foss.st=
.com> wrote:
>
> > From: Christophe Kerello <christophe.kerello@foss.st.com>
> >
> > Add the support of SDIO in-band interrupt mode for STM32 variant.
> > It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
> >
> > Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> > Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> (...)
> > +++ b/drivers/mmc/host/mmci.h
> > @@ -332,6 +332,7 @@ enum mmci_busy_state {
> >   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER =
register
> >   * @dma_lli: true if variant has dma link list feature.
> >   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
> > + * @use_sdio_irq: allow SD I/O card to interrupt the host
>
> The documentation tag should be one line up (compare to the members...)
>
> > @@ -376,6 +377,7 @@ struct variant_data {
> >         u32                     start_err;
> >         u32                     opendrain;
> >         u8                      dma_lli:1;
> > +       u8                      use_sdio_irq:1;
>
> 1. bool use_sdio_irq;
>
> 2. supports_sdio_irq is more to the point don't you think?
>     Especially since it activates these two callbacks:
>
> > +       void (*enable_sdio_irq)(struct mmci_host *host, int enable);
> > +       void (*sdio_irq)(struct mmci_host *host, u32 status);
>
> Further: all the Ux500 variants support this (bit 22) as well, so enable =
those
> too in their vendor data. All I have is out-of-band signaling with an GPI=
O IRQ
> on my Broadcom chips but I think it works (maybe Ulf has tested it in the
> far past).

For the ux500 variant there is a HW problem. After running some stress
tests, we may end up being stuck waiting for an SDIO IRQ to be
delivered. Even if the SDIO irqs should be considered level triggered,
it looked like it was implemented in the HW as an edge triggered IRQ.

The downstream workaround consisted of re-routing the DAT1 to a GPIO
at runtime suspend (we wanted that for optimal power save support
anyway) - and manually checking if the DAT1 line was asserted, before
enabling the GPIO line for an irq. This worked perfectly fine as a
workaround, with the limitation that one may observe a little bit of
hick-up in the traffic occasionally.

That said, the out-of-band IRQs is what works best for the ux500 variants.

Kind regards
Uffe
