Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076087770FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjHJHIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHJHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:08:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AAFE40;
        Thu, 10 Aug 2023 00:08:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-521caf0d7a6so131686a12.1;
        Thu, 10 Aug 2023 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691651325; x=1692256125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt8N8ksFf61RNhq6PjyUWs57gbuZvvlQrmRaj4Kn4lY=;
        b=Jbjs6a+VLqrrsha7Q5HbNJtz0Xk8oOBhXXKgVFPwOmamjZYgffL526l/Eert5ycd8P
         huqHl8Id/QfBHNIcLwT6JY/qn0gqpxTbGP9+IjpYuoxaxKAF5IlU+6VkzKNOruKQXs1N
         vAwPmOR/B+eiM+5AKf2w4uQ1pkbgl2ujzv/0Ix2P5KnqMHtQm4WsyoPB01vbrkVGVCHi
         Z3MyVFhhwblnUIQP7Cw5QmAgnagS/dHaF/VoJskKACFBh8CAVBO3LvPe6zDMd5Ju6J4e
         e1RWqLI2+6SCE0J/isByk8acDviFzpjmbuXnoqcHjmLtyFrSsNYAnKx1iN/U8fCPHKBl
         D6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691651325; x=1692256125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt8N8ksFf61RNhq6PjyUWs57gbuZvvlQrmRaj4Kn4lY=;
        b=JJjcWwJzDFR/XPM4kYnZ7342xB1eXfTLdz5k6SQBScjXTh7uzUspGpkwOOm/rHSW+W
         yN72SEyUEI+0Q7JmiaJjL1uBWSfot9SsgGxpRXyLTVBjxGvzv+iH3kms06TMtTSnnJBx
         ob2o0YiZt2+FVnr9xALDZJDkCS1OHMyWSnb+F+SJIxcuEB/fsmbIIt+tKyZaat7r/7th
         rmi9yHJ57x09hjAwAI8ijdZZX4FBlDt8lJ/wqO6XeYaJ92LOrG/HqqmqAbqqvfiOlLhR
         BRsEbHfEf9yoHpZRBBv9g/xHZRTQIjX3IWzMyjWc7mNKYqRTNS0p8o+jqHLiKlnGf4ld
         t2Uw==
X-Gm-Message-State: AOJu0YyXmzcYtiBTCeIeinqXyZ2y6E9WT+rLZnFTVSY+LgsE9gOyIyaA
        lZrhnODtYUR501uVwBK3TkMbKb6siPqih390y7o=
X-Google-Smtp-Source: AGHT+IGBrYF3ReMRrKoxEzSnDGZs1GRxob1UCPHqHruX/V/GmF/h5pGc3XBfSSjM73uvCvF9zOhbdkJGdojR6xjCxII=
X-Received: by 2002:a17:906:2258:b0:99c:ae07:28da with SMTP id
 24-20020a170906225800b0099cae0728damr1106454ejr.0.1691651324563; Thu, 10 Aug
 2023 00:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033144.2276-1-Wenhua.Lin@unisoc.com> <e5d5a440-af25-17a7-40a2-8dbbc8c20c69@linux.alibaba.com>
In-Reply-To: <e5d5a440-af25-17a7-40a2-8dbbc8c20c69@linux.alibaba.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 15:08:32 +0800
Message-ID: <CAB9BWhdseF56JyTC75MLGmo=ZRpTfmLOc=U3XB-zHnAif=fALQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: sprd: Add clear interrupt
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 9:31=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 8/8/2023 11:31 AM, Wenhua Lin wrote:
> > Clear interrupt after set the interrupt type.
>
> Sorry, NAK. The commit message is meaningless.

Hi baolin:
We will re-modify the commit message and submit it in patch v2.

Thanks
Wenhua.Lin

>
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >   drivers/gpio/gpio-eic-sprd.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index c506cfd6df8e..31125f53bc97 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -374,29 +374,34 @@ static int sprd_eic_irq_set_type(struct irq_data =
*data, unsigned int flow_type)
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTB=
OTH, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTM=
ODE, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTP=
OL, 1);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTC=
LR, 1);
> >                       irq_set_handler_locked(data, handle_edge_irq);
> >                       break;
> >               case IRQ_TYPE_EDGE_FALLING:
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTB=
OTH, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTM=
ODE, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTP=
OL, 0);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTC=
LR, 1);
> >                       irq_set_handler_locked(data, handle_edge_irq);
> >                       break;
> >               case IRQ_TYPE_EDGE_BOTH:
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTM=
ODE, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTB=
OTH, 1);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTC=
LR, 1);
> >                       irq_set_handler_locked(data, handle_edge_irq);
> >                       break;
> >               case IRQ_TYPE_LEVEL_HIGH:
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTB=
OTH, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTM=
ODE, 1);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTP=
OL, 1);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTC=
LR, 1);
> >                       irq_set_handler_locked(data, handle_level_irq);
> >                       break;
> >               case IRQ_TYPE_LEVEL_LOW:
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTB=
OTH, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTM=
ODE, 1);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTP=
OL, 0);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTC=
LR, 1);
> >                       irq_set_handler_locked(data, handle_level_irq);
> >                       break;
> >               default:
> > @@ -409,29 +414,34 @@ static int sprd_eic_irq_set_type(struct irq_data =
*data, unsigned int flow_type)
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBO=
TH, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMO=
DE, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPO=
L, 1);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCL=
R, 1);
> >                       irq_set_handler_locked(data, handle_edge_irq);
> >                       break;
> >               case IRQ_TYPE_EDGE_FALLING:
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBO=
TH, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMO=
DE, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPO=
L, 0);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCL=
R, 1);
> >                       irq_set_handler_locked(data, handle_edge_irq);
> >                       break;
> >               case IRQ_TYPE_EDGE_BOTH:
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMO=
DE, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBO=
TH, 1);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCL=
R, 1);
> >                       irq_set_handler_locked(data, handle_edge_irq);
> >                       break;
> >               case IRQ_TYPE_LEVEL_HIGH:
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBO=
TH, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMO=
DE, 1);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPO=
L, 1);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCL=
R, 1);
> >                       irq_set_handler_locked(data, handle_level_irq);
> >                       break;
> >               case IRQ_TYPE_LEVEL_LOW:
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBO=
TH, 0);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMO=
DE, 1);
> >                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPO=
L, 0);
> > +                     sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCL=
R, 1);
> >                       irq_set_handler_locked(data, handle_level_irq);
> >                       break;
> >               default:
