Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0F7752D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjHIGXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHIGXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:23:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89F4133;
        Tue,  8 Aug 2023 23:23:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52327d63d7cso5453837a12.1;
        Tue, 08 Aug 2023 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691562219; x=1692167019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGBmQ0FzW0QmbiruwUe2X9Kdb+RNpn5NkHuNGO3cQJA=;
        b=DCAHp1CbjBcSuhBUuzvuN3VgWS09myH9ihLAQ1iLh9gZ5VvvhRk78JILh3NpvxzQry
         k2ergfwrHukADLJ3x1WzLzqo3qmOI4VBMzWlKGM/FpVm+QPnJYJXE67XV+YIDEqEAr2E
         FISaHEAKCln+vUiPmfL7z76INeD4Vz+aPVQ7RxmTNJOCPW7y4cFtWJDkRxH+l+jqrfhB
         /ktjUJoSrnTOLerrAyMNyt/FW+s3KvRnfQlTUgOaEvZjFTESZe8LdroMOY16MGdIkvCf
         kQk/mzd6kUlR8BMyIOuzoU53isr8+TkeYuiEH9XYWdWHTcP7bZpMx70YhZxgTUiXKlvP
         jEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691562219; x=1692167019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGBmQ0FzW0QmbiruwUe2X9Kdb+RNpn5NkHuNGO3cQJA=;
        b=LC2oERAaNJPS2cZNdl3IT3qzMAYynZ3xMovvCp4rZHJylDPyCy7Mi44lDZdHxI6+2p
         jwoi4eszOpog6Rb4Gr3uzpcYthXGRJUCfAgNRFGLMIbJLLpqGwaZSNEXY0GPsiWGyy23
         Szfd8F1Yg6CqRKCzj9mcr/GLEMXy0FFf5R+8UWB7XYzQF5M1IR6+jR5h7+WOcBs5Ma9i
         o9aSKre6vvuIDt23eaAs1q4Vh+ayJ37lwgaWX5pkmxnAu0eP0rqIArnuPPCwYio6fvWn
         bbOWJ3VIKYbOvdfXFkLPVf82zANcd9QpCDqZtSWcZC21yu8ZYqBOnc9tzIoXSc70ADiG
         MsOw==
X-Gm-Message-State: AOJu0YwA/YhBiQy9RIWGaCXfeh7DOA6nCmPMmUhI0JDGAKKXh/7ASI+a
        A2E/TOvh+5W/3JBjimcSqEzNopdp3AH4FZP0a3k=
X-Google-Smtp-Source: AGHT+IHiEVwxXjQska6EI/ym+fb/p/UTtO9H91ChZAHA/s8eCKAvnt/iS/fIKDj+P40bGmK8j/IiUZWKtzF/io58RS4=
X-Received: by 2002:a17:906:25a:b0:991:b554:e64b with SMTP id
 26-20020a170906025a00b00991b554e64bmr1312349ejl.54.1691562219243; Tue, 08 Aug
 2023 23:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230807080726.7190-1-Wenhua.Lin@unisoc.com> <3554a99d-339f-39f9-111d-040025096f97@linux.alibaba.com>
 <CAB9BWhdh8CXuWAQGir=9QqLPdVaN8hgmqii9Da=buSj=9BWJaw@mail.gmail.com>
In-Reply-To: <CAB9BWhdh8CXuWAQGir=9QqLPdVaN8hgmqii9Da=buSj=9BWJaw@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 9 Aug 2023 14:23:02 +0800
Message-ID: <CAAfSe-utHwSZnX4SqhYsvzF5+p5A4DfYvFwZGOMjkEsu_8qsLw@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Support 12 uart ports
To:     wenhua lin <wenhua.lin1994@gmail.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 13:52, wenhua lin <wenhua.lin1994@gmail.com> wrote:
>
> The change of the max ports is to adapt to an new
> SPRD serial hardware,also is backward-compatibility with old hardware.

This change seems not backward-compatible if the serial devices on
some old Unisoc SoCs can support 8 ports only.

BTW, please do not top-post your reply.

Thanks,
Chunyan

>
> Baolin Wang <baolin.wang@linux.alibaba.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=B8=80 16:41=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >
> > On 8/7/2023 4:07 PM, Wenhua Lin wrote:
> > > From: Wenhua Lin <wenhua.lin@unisoc.com>
> > >
> > > Support 12 uart ports, which can solve the problem
> > > of insufficient uart ports.
> >
> > This sounds incorrect to me.
> > If this is a software bug, please add a Fixes tag to backport for stabl=
e
> > kernels. If the change of the max ports is only avaliable on the new
> > SPRD serial hardware, you should ensure the change is
> > backward-compatibility with old hardware.
> >
> > > Signed-off-by: Wenhua Lin <wenhua.lin@unisoc.com>
> > > ---
> > >   drivers/tty/serial/sprd_serial.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sp=
rd_serial.c
> > > index b58f51296ace..2774df490899 100644
> > > --- a/drivers/tty/serial/sprd_serial.c
> > > +++ b/drivers/tty/serial/sprd_serial.c
> > > @@ -22,7 +22,7 @@
> > >   #include <linux/tty_flip.h>
> > >
> > >   /* device name */
> > > -#define UART_NR_MAX          8
> > > +#define UART_NR_MAX          12
> > >   #define SPRD_TTY_NAME               "ttyS"
> > >   #define SPRD_FIFO_SIZE              128
> > >   #define SPRD_DEF_RATE               26000000
