Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A33775264
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjHIFwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIFwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:52:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD01BF0;
        Tue,  8 Aug 2023 22:52:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99c3ca08c09so194146366b.1;
        Tue, 08 Aug 2023 22:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691560342; x=1692165142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPak/VAFTFuBGrfRoIiuKKMTdN3l3DNgTW/FX2TbFR0=;
        b=rH+lcgDFeU2yZxC0/h+9fSPETElVhvQkCMCqpCNB5aAG8N9jrvDFSjvBoNzjjiek/3
         SGSda6sGB5svK8O/nzyPIkNuzuvGc+RSfqi9pUZsIzWQvKlKrhOaKKjUGob5Rk5gIBxt
         m7NvdkYyW+WEBEPVsJemPXV35cvhIv/HCdw98ElNchG2G5GJi7TNqdM4e4sjm47Z7m/f
         K5K5ZRgyDWHO6/gqR8UoLcg3EybfbWJ/HvylibfwQJRUHJWQymrJxFf7vblHJk9etfo1
         oDbQmS2rhsZkHE8tgZBq0w5vdd4CilrrtGshBO7nyQFgcEZMi1s3T4yFcu8wLbGTDzFh
         xnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691560342; x=1692165142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPak/VAFTFuBGrfRoIiuKKMTdN3l3DNgTW/FX2TbFR0=;
        b=dYKccyNy+E9xbtp0sO+FibKjXBrpx5gaTD/YgGB7lVktl3xVK/t63eBsrt7yj5NNvo
         LrIbyxY1E7ur8MSGwVBJEwskiX0WkQHEeMJTXnvQEbtSCjLbQk6kmroX9Tbtsem3tcQ2
         jbG9h/e8JffC14+GQTkQ7pH8vcISPPA55Jp2xWOekmcBK9SExwYMK9w3xzTMHt6ML1Hl
         DhVB0/mIOiThGZCfA2Td6RMhkSBeBvJ16MPVheVgbTIczHtEEgrShlGuxeje7PhMXo+9
         obpuq1OzOv2Y85DTuBCt9OD2qhsA7CSI0J1cuCi68l1Hif2oyUq4uSatvPj/Si+JCbnn
         W9nQ==
X-Gm-Message-State: AOJu0YyDE6QFZnYxxXuZ+lIokMfM3udaQakPoECmUgrznzS5/ZFXHbvW
        rqx41Hkx6GWSKi7/x9ArWpt9lDvRpAkDPwL5O5E=
X-Google-Smtp-Source: AGHT+IHrq5SfQ478qeVCDed2fFuch4HzfABNfj+kLmIzaWiV6eBGSI0p4IsPN12qtD1xsp3zuCh2a4uON8vVvhBK/C0=
X-Received: by 2002:a17:906:101a:b0:99c:af57:2051 with SMTP id
 26-20020a170906101a00b0099caf572051mr1211740ejm.6.1691560341721; Tue, 08 Aug
 2023 22:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230807080726.7190-1-Wenhua.Lin@unisoc.com> <3554a99d-339f-39f9-111d-040025096f97@linux.alibaba.com>
In-Reply-To: <3554a99d-339f-39f9-111d-040025096f97@linux.alibaba.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Wed, 9 Aug 2023 13:52:10 +0800
Message-ID: <CAB9BWhdh8CXuWAQGir=9QqLPdVaN8hgmqii9Da=buSj=9BWJaw@mail.gmail.com>
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

The change of the max ports is to adapt to an new
SPRD serial hardware,also is backward-compatibility with old hardware.

Baolin Wang <baolin.wang@linux.alibaba.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=B8=80 16:41=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 8/7/2023 4:07 PM, Wenhua Lin wrote:
> > From: Wenhua Lin <wenhua.lin@unisoc.com>
> >
> > Support 12 uart ports, which can solve the problem
> > of insufficient uart ports.
>
> This sounds incorrect to me.
> If this is a software bug, please add a Fixes tag to backport for stable
> kernels. If the change of the max ports is only avaliable on the new
> SPRD serial hardware, you should ensure the change is
> backward-compatibility with old hardware.
>
> > Signed-off-by: Wenhua Lin <wenhua.lin@unisoc.com>
> > ---
> >   drivers/tty/serial/sprd_serial.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index b58f51296ace..2774df490899 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -22,7 +22,7 @@
> >   #include <linux/tty_flip.h>
> >
> >   /* device name */
> > -#define UART_NR_MAX          8
> > +#define UART_NR_MAX          12
> >   #define SPRD_TTY_NAME               "ttyS"
> >   #define SPRD_FIFO_SIZE              128
> >   #define SPRD_DEF_RATE               26000000
