Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1204776020
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjHINC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHINC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:02:26 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BDF1FF5;
        Wed,  9 Aug 2023 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=QC1VVPzSdAsZ5rA5wFmq3mpl9ZpfWlBmZwa270d1LM0=; b=pdKrcUTt0NEvOi4G2Ul6Ic5LUa
        PNIW/IQNfVjdvKvpqFoS3pxUOt8muhZ2sFPTi64KQ724Cive4VkxN4sVQ4f9aIEY25SScHr8RNB1p
        m6THSMI+IcY49uGKXLNqW6dd8uvkfUZopp4PVf/AY85N746wk3kSP9iYirZYhxG/EqHE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:56076 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qTipH-0001Mp-NM; Wed, 09 Aug 2023 09:02:12 -0400
Date:   Wed, 9 Aug 2023 09:02:11 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     wenhua lin <wenhua.lin1994@gmail.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Message-Id: <20230809090211.1820e9dce666485b00e1f170@hugovil.com>
In-Reply-To: <CAB9BWhfRHSqWrBbeisoGLqeBYXc9Pc_uGH0GxnfedXROpU_0-A@mail.gmail.com>
References: <20230808033106.2174-1-Wenhua.Lin@unisoc.com>
        <0ac280ab-08f1-b031-e21b-49390182f090@linux.alibaba.com>
        <CAB9BWhfRHSqWrBbeisoGLqeBYXc9Pc_uGH0GxnfedXROpU_0-A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 1/3] gpio: sprd: Modify the calculation method of eic
 number
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 14:08:47 +0800
wenhua lin <wenhua.lin1994@gmail.com> wrote:

> Hi baolin:
> 1.Please describe the problem in detail, not only what you did.
> 
> We will describe the reason for the modification by supplementing the
> commit message.
> 
> 2.Can you explicit on which controller can support 8 banks in the commit
> log? And you did not change all the related comments in this file.
> 
> The old project EIC controller can support maximum 3 banks,
> now our new project eic controller can support maximum 8 banks，
> and each bank contains 8 EICs.
> We will modify the comment in this file.
> 
> 3.If you want to introduce a readable macro, that's fine, but it should be
> split into a separate patch.
> 4.This change looks good to me, and this seems a software bug in the
> original driver. So I think this change should be moved into a separate
> patch with a suitable Fixes tag.
> 5.Do not add unreated changes that you did not mentioned in the commit log.
> 
> We will re-split the patch submission and explain our reasons for
> modification in the submission information, thank you very much for
> your review.

Hi,
please do not top-post and insert your answers in-line to make it
easier to read. There is good advice here:

https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

Thank you,
Hugo Villeneuve


> Baolin Wang <baolin.wang@linux.alibaba.com> 于2023年8月9日周三 09:24写道：
> >
> >
> >
> > On 8/8/2023 11:31 AM, Wenhua Lin wrote:
> > > Automatic calculation through matching nodes,
> > > subsequent projects can avoid modifying driver files.
> >
> > Please describe the problem in detail, not only what you did.
> >
> > > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > > ---
> > >   drivers/gpio/gpio-eic-sprd.c | 49 +++++++++++++++++++-----------------
> > >   1 file changed, 26 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> > > index 84352a6f4973..0d85d9e80848 100644
> > > --- a/drivers/gpio/gpio-eic-sprd.c
> > > +++ b/drivers/gpio/gpio-eic-sprd.c
> > > @@ -50,10 +50,10 @@
> > >   #define SPRD_EIC_SYNC_DATA          0x1c
> > >
> > >   /*
> > > - * The digital-chip EIC controller can support maximum 3 banks, and each bank
> > > + * The digital-chip EIC controller can support maximum 8 banks, and each bank
> >
> > Can you explicit on which controller can support 8 banks in the commit
> > log? And you did not change all the related comments in this file.
> >
> > >    * contains 8 EICs.
> > >    */
> > > -#define SPRD_EIC_MAX_BANK            3
> > > +#define SPRD_EIC_MAX_BANK            8
> > >   #define SPRD_EIC_PER_BANK_NR                8
> > >   #define SPRD_EIC_DATA_MASK          GENMASK(7, 0)
> > >   #define SPRD_EIC_BIT(x)                     ((x) & (SPRD_EIC_PER_BANK_NR - 1))
> > > @@ -99,33 +99,32 @@ struct sprd_eic {
> > >
> > >   struct sprd_eic_variant_data {
> > >       enum sprd_eic_type type;
> > > -     u32 num_eics;
> > >   };
> > >
> > > +#define SPRD_EIC_VAR_DATA(soc_name)                          \
> > > +static const struct sprd_eic_variant_data soc_name##_eic_dbnc_data = {       \
> > > +     .type = SPRD_EIC_DEBOUNCE,                                      \
> > > +};                                                                   \
> > > +                                                                     \
> > > +static const struct sprd_eic_variant_data soc_name##_eic_latch_data = {      \
> > > +     .type = SPRD_EIC_LATCH,                                         \
> > > +};                                                                   \
> > > +                                                                     \
> > > +static const struct sprd_eic_variant_data soc_name##_eic_async_data = {      \
> > > +     .type = SPRD_EIC_ASYNC,                                         \
> > > +};                                                                   \
> > > +                                                                     \
> > > +static const struct sprd_eic_variant_data soc_name##_eic_sync_data = {       \
> > > +     .type = SPRD_EIC_SYNC,                                          \
> > > +}
> > > +
> > > +SPRD_EIC_VAR_DATA(sc9860);
> > > +
> > >   static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
> > >       "eic-debounce", "eic-latch", "eic-async",
> > >       "eic-sync",
> > >   };
> > >
> > > -static const struct sprd_eic_variant_data sc9860_eic_dbnc_data = {
> > > -     .type = SPRD_EIC_DEBOUNCE,
> > > -     .num_eics = 8,
> > > -};
> > > -
> > > -static const struct sprd_eic_variant_data sc9860_eic_latch_data = {
> > > -     .type = SPRD_EIC_LATCH,
> > > -     .num_eics = 8,
> > > -};
> > > -
> > > -static const struct sprd_eic_variant_data sc9860_eic_async_data = {
> > > -     .type = SPRD_EIC_ASYNC,
> > > -     .num_eics = 8,
> > > -};
> > > -
> > > -static const struct sprd_eic_variant_data sc9860_eic_sync_data = {
> > > -     .type = SPRD_EIC_SYNC,
> > > -     .num_eics = 8,
> > > -};
> >
> > If you want to introduce a readable macro, that's fine, but it should be
> > split into a separate patch.
> >
> > >   static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd_eic,
> > >                                                unsigned int bank)
> > > @@ -583,6 +582,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
> > >       struct sprd_eic *sprd_eic;
> > >       struct resource *res;
> > >       int ret, i;
> > > +     u16 num_banks = 0;
> > >
> > >       pdata = of_device_get_match_data(&pdev->dev);
> > >       if (!pdata) {
> > > @@ -613,12 +613,13 @@ static int sprd_eic_probe(struct platform_device *pdev)
> > >                       break;
> > >
> > >               sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
> > > +             num_banks++;
> > >               if (IS_ERR(sprd_eic->base[i]))
> > >                       return PTR_ERR(sprd_eic->base[i]);
> > >       }
> > >
> > >       sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
> > > -     sprd_eic->chip.ngpio = pdata->num_eics;
> > > +     sprd_eic->chip.ngpio = num_banks * SPRD_EIC_PER_BANK_NR;
> >
> > This change looks good to me, and this seems a software bug in the
> > original driver. So I think this change should be moved into a separate
> > patch with a suitable Fixes tag.
> >
> > >       sprd_eic->chip.base = -1;
> > >       sprd_eic->chip.parent = &pdev->dev;
> > >       sprd_eic->chip.direction_input = sprd_eic_direction_input;
> > > @@ -630,10 +631,12 @@ static int sprd_eic_probe(struct platform_device *pdev)
> > >               sprd_eic->chip.set = sprd_eic_set;
> > >               fallthrough;
> > >       case SPRD_EIC_ASYNC:
> > > +             fallthrough;
> > >       case SPRD_EIC_SYNC:
> > >               sprd_eic->chip.get = sprd_eic_get;
> > >               break;
> > >       case SPRD_EIC_LATCH:
> > > +             fallthrough;
> >
> > Do not add unreated changes that you did not mentioned in the commit log.
