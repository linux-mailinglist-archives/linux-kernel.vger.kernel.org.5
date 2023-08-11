Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F02778895
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjHKHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHKHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:52:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DDD1FDD;
        Fri, 11 Aug 2023 00:52:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-5230963f636so488133a12.0;
        Fri, 11 Aug 2023 00:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691740346; x=1692345146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn2VSLVm1rXKhBd/HGLc1+dDcaZ5Is6O87rlIzwoYiQ=;
        b=Z/eoO211AWBp6JZ3ds9kXBx+pppcPCq5oYsNs9/g92Mmtu44V5dtNivMvfnJ8pgaWi
         DO66XAHf/Pf37IFOk9gb5I/bCyFOkW4RAxVOMaPqVsKARpQNMhpLeMU6M582B787cH2W
         yMc1dad4hVmg6QEkF9F7aHIQBPP7JJxRjNvUaTkciRWUFd8BI3fH1jD473+xF7IJkY06
         qy+AfDNdkY27Frt/zarf13RuuZ3gDa2mraVfPgZEKOTLfJsx2hL23YGiNxSFnaiuDeBC
         XKukRJKvQ1twfm5CUNYG0OLsIk4ZQNYHmVKdeFUS3Nxvg3Psy1dx4c9gbAgu+0QBVSo6
         U02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691740346; x=1692345146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sn2VSLVm1rXKhBd/HGLc1+dDcaZ5Is6O87rlIzwoYiQ=;
        b=EPjcXD5ApzTDe3g8iBhGEkMvBvlIHYF3HI3Nzs+jDGFln+OCZ9YwOWcuxSa1NE/2Xm
         FdZZ9js15ipy2ooDgYROG/tMQt1XEsdNNJLD6Uq/EpjYaPzorqcJbc1ff5EQP5Uy2mZK
         FiEWHymxLwo/Q5bMjn25UZ/xIba+RO5vimvmbkBGkSdgQGVgIViQHmCbLmciEQcvk+ZT
         3PvT9M0CihCkTNu7BLao2aOZlX+M0IkHFQ0y53tO1lKNuvjW8FGnC3oOZyh5DBP/ZvrT
         is/jJf1mtB61cxUi8/k56gtKU5qYjPyqAkf54kApGVKNO/cosVh+mGBLZe2rVmYZdIpt
         Y/tg==
X-Gm-Message-State: AOJu0Yx+dlMQk2VKaPXPI0dPtvgTHz/VXyWlDRne5WP0eppCSjO1tl+v
        MoMclxEomZQKMrBcagFLdh8RmaZ+Ogf3tjNzmd2bVIX6eZrG6Q==
X-Google-Smtp-Source: AGHT+IETnu6yHfWtkTB3S3u3U5Q9U6EdoG0zTQ8euXUG0LZVCM2lFIN4rpC2orNMWNhlM6ISAXUaLclqtR/m+vq5eZs=
X-Received: by 2002:a05:6402:1e8c:b0:521:f2a7:d57a with SMTP id
 f12-20020a0564021e8c00b00521f2a7d57amr1025620edf.2.1691740345391; Fri, 11 Aug
 2023 00:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033144.2276-1-Wenhua.Lin@unisoc.com> <ZNJCLyWCdihyeC7a@smile.fi.intel.com>
 <CAB9BWhctPWUuL8tLpQSHmn0UWQ2ej4jN87HO89bTEz5__o9rZg@mail.gmail.com> <CAHp75VeVS4MfgpXeeiZygPOqYHR3-LagvWFD9ujOGVTp=J+Buw@mail.gmail.com>
In-Reply-To: <CAHp75VeVS4MfgpXeeiZygPOqYHR3-LagvWFD9ujOGVTp=J+Buw@mail.gmail.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Fri, 11 Aug 2023 15:52:13 +0800
Message-ID: <CAB9BWhcfS8mYYj+iDaT07M6mQdTiZk+hVs5XPwxpiix01_wjeA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: sprd: Add clear interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
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

On Thu, Aug 10, 2023 at 5:57=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 10, 2023 at 10:27=E2=80=AFAM wenhua lin <wenhua.lin1994@gmail=
.com> wrote:
> > On Tue, Aug 8, 2023 at 9:25=E2=80=AFPM Andy Shevchenko <andy@kernel.org=
> wrote:
> > > On Tue, Aug 08, 2023 at 11:31:44AM +0800, Wenhua Lin wrote:
> > > > Clear interrupt after set the interrupt type.
> > >
> > > Why?
> > >
> > > Can't it be done in the ->init_hw() callback of GPIO IRQ chip?
> >
> > Hi Andy:
> > The initialization state of EIC is high-level trigger. If the external
> > level is high and the interrupt condition is met,
> > EIC has a latch function. If the module registers the eic interrupt,
> > an interrupt will be generated immediately
> >  as soon as the eic interrupt is enabled. To solve this problem, our
> > processing method is to clear the interrupt
> >  once when setting the interrupt trigger type, in order to avoid that
> > this interrupt is the last interrupt.
>
> Obvious question, isn't this needed to be added to ->init_hw() as well?

In the ->init_hw() function, the sprd_gpio_irq_ack interface will be called
 to clear the interrupt, and there is no need to add it repeatedly

>
> --
> With Best Regards,
> Andy Shevchenko
