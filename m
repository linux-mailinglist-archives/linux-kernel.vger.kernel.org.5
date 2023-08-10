Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA107770EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjHJHFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHJHFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:05:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E57AC;
        Thu, 10 Aug 2023 00:05:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2b73261babdso1729881fa.1;
        Thu, 10 Aug 2023 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691651111; x=1692255911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FStBX+R2KkYE4uJfB2Qvr19phPJtSse4smSLJyrZenA=;
        b=IXEyoVHlt26EPIUUs1ETPz7r+NnMtgwdbmIST1YVeYBspQ6ax0nmZb1VFdaY3CsPTm
         +jrxWcCtRb1+5Lr1upkQcSTLtuXdDqBz/qq8z5UfHann3Q3tmygXmOTci28tiPgfkSVa
         H7kfzBLk+pB/vNyqsv5a/UFjWNlgvfkGuRVQpVU8H99tm5L0iWW42R5mtKPmGy3odW9r
         pwCwn7KDw0yF7Af4T4MSMmEhnCpeQCzf217bx5ycS9TuzJn/36Lx1pR91MvhQjp3+PXN
         R6hmBCBqSDUV9YxziXACsrj5ccQaI2Y3AyKo6N7tMEbQqJzs/L7CafgYrAZdFp3q5THa
         9afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691651111; x=1692255911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FStBX+R2KkYE4uJfB2Qvr19phPJtSse4smSLJyrZenA=;
        b=DHtwprXeQg4moC064svpGE5Vul9pJOd9/3UddkDMXpNgvWefht9V8Izth9muPwPfjs
         iMkw9QCMRCx16oyCiKghIm1EWiUGd81RmSdH+/r+VdwhbhoPaqYFHBkH05ZIPCIqSJ1N
         CgJaoiUtvrf/Oh5+64SeIfQWz9VjZfha2XP3hXHN6SZUOz5UEQAEHXcKOcKgEIaP4VfL
         cCFF0Gu1fgyINEu6DmlzgWFUwvE8KHgCVk58frZKIb0MeReRupfkYGsQ0Y/vYxv6+wdq
         H2lHM7sImdFdm69XtlAZhrunoB7wattrXik15AGDmgN6NKp9654mHvHAifZiaSiESDe9
         kEgA==
X-Gm-Message-State: AOJu0YzyxeZ68U6yWpxk8gjS+KIZOybNgMj4iJzjOqC+3f04F64luUYY
        irKfNQ7RarrZo6xPWHnybXYrcOfX1jmwt/jEA/U=
X-Google-Smtp-Source: AGHT+IHQgDn6PtrEjo7WQbry/jYaetS2+CHmwNygaDXtgCAduN/Ui23RmKpHb+za9BpHu8b5qbbeCQ8FizvZQh1uLCw=
X-Received: by 2002:a05:651c:2122:b0:2b6:cd7f:5ea8 with SMTP id
 a34-20020a05651c212200b002b6cd7f5ea8mr1346412ljq.1.1691651110890; Thu, 10 Aug
 2023 00:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033130.2226-1-Wenhua.Lin@unisoc.com> <4bfc8ac2-f253-ab4d-3d44-2cbd62dce20f@linux.alibaba.com>
In-Reply-To: <4bfc8ac2-f253-ab4d-3d44-2cbd62dce20f@linux.alibaba.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 15:04:59 +0800
Message-ID: <CAB9BWheMads8HGAE=B4Lm=UTYQ161GQ31BH1PvnG7y-2L9Vr8A@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: sprd: In the sleep state, the eic dbnc clk must
 be forced open
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 9:29=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 8/8/2023 11:31 AM, Wenhua Lin wrote:
> > In the sleep state, Eic dbnc has no clock and the clk enable
> > of dbnc needs to be forced open, so that eic can wake up normally.
>
> Sounds reasonable to me. Should add a Fixes tag if need to backport for
> stable kernel?

Hi baolin:
We will make changes in patch v2.

Thanks
Wernhua.Lin

>
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >   drivers/gpio/gpio-eic-sprd.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index 0d85d9e80848..c506cfd6df8e 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -23,6 +23,7 @@
> >   #define SPRD_EIC_DBNC_IC            0x24
> >   #define SPRD_EIC_DBNC_TRIG          0x28
> >   #define SPRD_EIC_DBNC_CTRL0         0x40
> > +#define SPRD_EIC_DBNC_FORCE_CLK              0x8000
> >
> >   #define SPRD_EIC_LATCH_INTEN                0x0
> >   #define SPRD_EIC_LATCH_INTRAW               0x4
> > @@ -213,6 +214,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *=
chip, unsigned int offset,
> >       u32 value =3D readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
> >
> >       value |=3D (debounce / 1000) & SPRD_EIC_DBNC_MASK;
> > +     value |=3D SPRD_EIC_DBNC_FORCE_CLK;
> >       writel_relaxed(value, base + reg);
> >
> >       return 0;
