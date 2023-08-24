Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D65786567
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbjHXCay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbjHXCak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:30:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C391AD;
        Wed, 23 Aug 2023 19:30:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-523029050d0so1597867a12.0;
        Wed, 23 Aug 2023 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692844236; x=1693449036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adMtJdV7BZ5j1YmjnVQDVqfXgFFTJzER8QZVtIVtYco=;
        b=Z+YLH2Dy1hFk7zZ2jQV+0nfWNetUhGEvMRxvM8Wexergk0nSvr/tdF5l1YZ7Wt7N1l
         JKCE5Aa8JYDrgb/b21oIKAHpmjfT5vRaqQ1AdgFg5jjrkUTO4XzgThKQYMyue8gFyJE2
         kL0R1uEkemR7JRDcik6rd0xoy0d9C7mTeEjQpalFYuBgfIZ1c9isvwSJ+liBwPd7GpS2
         v398UcOYjtB8fTl1ARIKOJzwR54Kmsdz+xKO/o9d5EuvgO4IESXH4oM+f6KVmsTlpV6Q
         n+iayp4l8FynqqsBYo7nW8lhNJ4U5rMy6oiCaTWFLh4JdcafN1Drimo8Fpk/ZgV/Bhx4
         KrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692844236; x=1693449036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adMtJdV7BZ5j1YmjnVQDVqfXgFFTJzER8QZVtIVtYco=;
        b=hgEHH2N42bKwUYlfm0N6IE8qXwNDCCrSAIWfWV6HaP05zGJvooiTcRuLtFJcsawZVN
         VCwoISLUjRo7hRqHkQS4XQ7rCzTqBtyjq8tNSbur9gKGg/a5hvso/TbTuIjkNv1aSdEd
         GqpH1cILWJxtGWXfWkt153wTt0bxrhMdYsZy/g1OlWNBMTysee3iQ6Y7f9BwbZVBd0sc
         EIU+gI0q5yioB9Nk0ID8ZizKfNcjI/eNwfqSLPXXnjcTbMAqyf0jf2J61thsKMRQgToc
         mstBBf3m8PDvAwHEIguN+AYreDYWhqwigRaO1pyTmsUui2hfah9ypYoRVYzuPtQ625Nr
         SaGw==
X-Gm-Message-State: AOJu0YxOLtNvc7k4quYP4aPMNqs6TGQ+dfRSzaGewLhW5T8nEyLVsgGH
        UyhQFClSZXjXu/lsdjh8rp0i2hIm7AxtosCI7OQ=
X-Google-Smtp-Source: AGHT+IH8YDEaywMWfIfErql3LuBA4FVzMmwyYuhKVUKczGlNYxBcOosYkVDXIVy2XylcRWbd2nvh7znua99xwQPRHno=
X-Received: by 2002:a05:6402:518f:b0:523:37cf:6f37 with SMTP id
 q15-20020a056402518f00b0052337cf6f37mr9789205edd.4.1692844236092; Wed, 23 Aug
 2023 19:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230818031532.15591-1-Wenhua.Lin@unisoc.com> <5b2cc220-eafc-c34a-c0de-617bd09c9cff@linux.intel.com>
In-Reply-To: <5b2cc220-eafc-c34a-c0de-617bd09c9cff@linux.intel.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 24 Aug 2023 10:30:23 +0800
Message-ID: <CAB9BWheBuRZ9aq3=6KS0xyOR2OsQKW_p-pQQ2X8P6L2p5siv5A@mail.gmail.com>
Subject: Re: [PATCH] tty/serial: Cancel work queue before closing uart
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>
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

On Tue, Aug 22, 2023 at 4:23=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 18 Aug 2023, Wenhua Lin wrote:
>
> I've problems following your description below due to grammar errors.
>
> > When the system constantly sleeps and wankes up, plugging and unpluggin=
g
>
> wakes
>
> > the USB will probalility trigger a kernel crash problem.
>
> probalility is typoed and I cannot guess which of the words you meant,
> please fix.
>
> If there's a known crash you're fixing here, please quote the crash
> message in the changelog (and you should probably add Fixes: tag too in
> that case).
>
> > The reason is
> > that at this time, the system entered deep and turned off uart, and the
>
> "entered deep" lacks probably some word?
>
> > abnormal behavior of plugging and upplugging the USB triggered the read
>
> unplugging.
>
> Why call that abnormal behavior? Isn't USB expected to removed.
>
> > data process of uart, causing access to uart to hang.
>
> Are you saying a read was triggered while the UART was suspended or what?
>
> > The final solution
> > we came up with is to cancel the work queue before shutting down uart
> > , while ensuring that there is no uart business.
>
> ", while ensuring" -> to ensure
>
> "uart business" is too vague, you should replace it with something more
> concrete.

We will fix it in patch v2, thank you  for your review.

>
> Thanks.
>
> --
>  i.
>
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index b58f51296ace..eddff4360155 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/tty.h>
> >  #include <linux/tty_flip.h>
> > +#include "../tty.h"
> >
> >  /* device name */
> >  #define UART_NR_MAX          8
> > @@ -1221,7 +1222,10 @@ static int sprd_probe(struct platform_device *pd=
ev)
> >  static int sprd_suspend(struct device *dev)
> >  {
> >       struct sprd_uart_port *sup =3D dev_get_drvdata(dev);
> > +     struct uart_port *uport =3D &sup->port;
> > +     struct tty_port *tty =3D &uport->state->port;
> >
> > +     tty_buffer_cancel_work(tty);
> >       uart_suspend_port(&sprd_uart_driver, &sup->port);
> >
> >       return 0;
> >
