Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4D775C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjHIL1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjHIL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:27:16 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6692ED;
        Wed,  9 Aug 2023 04:27:15 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so1875347a12.1;
        Wed, 09 Aug 2023 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691580434; x=1692185234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqBHARz0gmz3J5h20e3FvkE1XWPr6CIGExbvAgbjDhw=;
        b=QMvBMIJoXoZDSFdMVYCz4Y/73g0nVsWYDNzFfwl5ukY9NYx2lGqHBcO0qxUrfNbHlZ
         AcBb4Rv69MLGqjY6VWJsnLISVkrVNLnUA4X/mSDz1oXVKx4STZPBNLjzBar96z/KPEd1
         LQ/vgMX86vsdH7MUK5SXBw8oYUBb2aXE0Sc6a26t8VaEiQHqSpp0s0rc6URQGiPQAq+S
         LfcIhymIaNuDNcdVi+XUSBCwJQcJAgprCfKGSpIHTlhz49nrtiiBPs/DAADLPQd+SNez
         zns4MmOBQwA47xskgBR5n7CN4taDzIo0KzgIIcOqAVxMg3PnHiGMN6Sz4leRI6QdwTVa
         iE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691580434; x=1692185234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqBHARz0gmz3J5h20e3FvkE1XWPr6CIGExbvAgbjDhw=;
        b=Li3GEaCxU+9/i5xxn6mDdIyCaNWIlj6Upm+xM77p9HxSXQOMm85MTC3oaKuMN9TJQv
         kkxlm9ZaoAu4aEs9MrTdUSJG1RpBcOIctZoUMPHuUSTOfjBf0hnR8odEhsztbr4VAvP/
         +JS/j/eUbGG/NascuedynOQg+dIwx6BvkNoPST3X69LsXLb6gFXG8RySiV2kGKmL8MDh
         JsqIo2W4Hoo5iZGhbH/hDeiNaPyZlR1Ogov3nLExW1if/8vc/ZV+kVvK0raT2rrqJlHf
         b58T1CRSUUeZSY1zjLof9umJuuhQkBsboKsUUbcrnojzOs3vy24EZr29xT/4NB5PChQy
         dGpA==
X-Gm-Message-State: AOJu0YxJHssg/lTW/QFaTlmhEh12aggjeV2yA2FKluTPmPLqR2em+yDd
        2+sV1McrH9/VYO7S4HBfwYY0WnSxQNq4wjD+XYc=
X-Google-Smtp-Source: AGHT+IFNEBxc0vNZCpirXKsSyotmsfBqrsBZzCqE/GSm3JN0+A761UZftrNN5lvKQMVdE+yfqfSiK8lQo3lEi/yunoQ=
X-Received: by 2002:a17:906:25b:b0:997:d069:a880 with SMTP id
 27-20020a170906025b00b00997d069a880mr1797898ejl.1.1691580434108; Wed, 09 Aug
 2023 04:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230807080726.7190-1-Wenhua.Lin@unisoc.com> <3554a99d-339f-39f9-111d-040025096f97@linux.alibaba.com>
 <CAB9BWhdh8CXuWAQGir=9QqLPdVaN8hgmqii9Da=buSj=9BWJaw@mail.gmail.com> <f808a0c7-013d-9999-8c2d-435609f9fde4@linux.alibaba.com>
In-Reply-To: <f808a0c7-013d-9999-8c2d-435609f9fde4@linux.alibaba.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Wed, 9 Aug 2023 19:27:02 +0800
Message-ID: <CAB9BWhf9e6cmLn6qHQqeM0-8kWf-mH7kWz2YvKvcpzXVkk2-=Q@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Support 12 uart ports
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
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

On Wed, Aug 9, 2023 at 2:27=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 8/9/2023 1:52 PM, wenhua lin wrote:
> > The change of the max ports is to adapt to an new
> > SPRD serial hardware,also is backward-compatibility with old hardware.
>
> Again, DO NOT top-posting! Thanks.

Thank you for your correction.


>
> >>
> >> On 8/7/2023 4:07 PM, Wenhua Lin wrote:
> >>> From: Wenhua Lin <wenhua.lin@unisoc.com>
> >>>
> >>> Support 12 uart ports, which can solve the problem
> >>> of insufficient uart ports.
> >>
> >> This sounds incorrect to me.
> >> If this is a software bug, please add a Fixes tag to backport for stab=
le
> >> kernels. If the change of the max ports is only avaliable on the new
> >> SPRD serial hardware, you should ensure the change is
> >> backward-compatibility with old hardware.
>
> This is not backward-compatibility. Please see 'sprd_uart_driver'
> structure as below:
>
> static struct uart_driver sprd_uart_driver =3D {
>         .owner =3D THIS_MODULE,
>         .driver_name =3D "sprd_serial",
>         .dev_name =3D SPRD_TTY_NAME,
>         .major =3D 0,
>         .minor =3D 0,
>         .nr =3D UART_NR_MAX,
>         .cons =3D SPRD_CONSOLE,
> };
>
> That means you will still register 12 UART ports in the tty for old
> serial hardwares which actually only support 8 UART ports, and if users
> want to use another 4 ports which are not supported in the hardware,
> then system crashes.
>
> So I think you should add a SoC data in 'serial_ids' to change the
> number of UART port according to different SoC.
>

Thank you for your valuable comments, we should probably consider
how to make changes based on your suggestions.

> >>> Signed-off-by: Wenhua Lin <wenhua.lin@unisoc.com>
> >>> ---
> >>>    drivers/tty/serial/sprd_serial.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sp=
rd_serial.c
> >>> index b58f51296ace..2774df490899 100644
> >>> --- a/drivers/tty/serial/sprd_serial.c
> >>> +++ b/drivers/tty/serial/sprd_serial.c
> >>> @@ -22,7 +22,7 @@
> >>>    #include <linux/tty_flip.h>
> >>>
> >>>    /* device name */
> >>> -#define UART_NR_MAX          8
> >>> +#define UART_NR_MAX          12
> >>>    #define SPRD_TTY_NAME               "ttyS"
> >>>    #define SPRD_FIFO_SIZE              128
> >>>    #define SPRD_DEF_RATE               26000000
