Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABA75BE12
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGUF4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGUF4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:56:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CBA9E;
        Thu, 20 Jul 2023 22:56:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-267c41ca947so739783a91.1;
        Thu, 20 Jul 2023 22:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689919007; x=1690523807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VvmUuvocKT0p8P+1xMQjftTbnP9MxxAarU5pfhilHM=;
        b=sMkNBSnDoqSrEiaDbuunvLPeDJ9lPJOpblWhV/J9YBZImKUGrFEDjl/vUDf8c4u6gB
         Ehp+Qpy1uBIQpT2QNdy5ouR1t9nShjot0Gla5TLKCUZNeWp+GbBe1FUK1VCcRySapToy
         RcF6ZhPOJQjMSKEp9si9ipQCgb5OAW+dZgSipTrA1PWxb3EeIEAEtiXsFeqrwY429pbR
         KPCh16O0av4wcVN6JFDtS9GXBRIuymPtFK/1VwBfRDo66kR7siGnnohOU+uQhxOLFxzX
         4XUf1mUKp81i82hWQ1MdzWMWi0usuXp/Q+MZsuz1bSvDpuiv6VF91QQWtPYy0t3C8SB9
         GY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689919007; x=1690523807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VvmUuvocKT0p8P+1xMQjftTbnP9MxxAarU5pfhilHM=;
        b=UlWChHgOst7xtYCpnLQzf1OV7uRMgVGNamLFdE5TF6kn5sUaRZuCu6Wyr1AjoGIr5A
         FOF1uTvd5hIzEuoiSaRB6Iv0cFFmQQAiAfeEnNkhjlX4Ti9FzHoYAaVAW0g8TfW+MPUZ
         cPZQmZXNkiFvspFDLYVQ57EEUiK2rJRShu4cRmQlQRpsrOMl+nOFSrFFhTuHUQSxwATm
         /8qEctzayHdHQxnHRvsajh8XypFzFzZsn7Na3eZpfIUt2iWycjePNmv35s9wmb2sb0Ig
         Jkee8oRh8IlyEyspA4qE4C9xc2DOYg6qVcQiz75ofzyg2hyOOBJFwY2cGP8v6H5azPn0
         Xkpg==
X-Gm-Message-State: ABy/qLayx894UNQrf/ol4uzcpaNBxujn5KNgQ26wBxrikGlLAC+cwD8i
        25Wc6GxPsq1c0cWO4DVpn2UFtmK3lmYXrAf9FiNC/Wu0GaA=
X-Google-Smtp-Source: APBJJlE8tdmEkOx686WvREXmv3TYClv6VQ6fOrBzChvuo8EXALjn1+1aD1pLufOGiBm9/pf5yjQsfNQ+Sz9uAP9csc8=
X-Received: by 2002:a17:90a:1b62:b0:262:ebb9:dd60 with SMTP id
 q89-20020a17090a1b6200b00262ebb9dd60mr573492pjq.20.1689919007410; Thu, 20 Jul
 2023 22:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230714074011.20989-1-qiang.zhang1211@gmail.com> <CA+fCnZfxLLLVJdPZmVKg5w4YY+i09ZRz-wu+TAXBaroRgGsAsQ@mail.gmail.com>
In-Reply-To: <CA+fCnZfxLLLVJdPZmVKg5w4YY+i09ZRz-wu+TAXBaroRgGsAsQ@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 21 Jul 2023 13:56:35 +0800
Message-ID: <CALm+0cX5bsjP-yrCywz_Pmwr+2y5VwuSj3fBNdnZD0JLrS+AdQ@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix the memory leak in raw_gadget driver
To:     Andrey Konovalov <andreyknvl@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Fri, Jul 14, 2023 at 9:40=E2=80=AFAM Zqiang <qiang.zhang1211@gmail.com=
> wrote:
> >
> > Currently, increasing raw_dev->count happens before invoke the
> > raw_queue_event(), if the raw_queue_event() return error, invoke
> > raw_release() will not trigger the dev_free() to be called.
> >
> > [  268.905865][ T5067] raw-gadget.0 gadget.0: failed to queue event
> > [  268.912053][ T5067] udc dummy_udc.0: failed to start USB Raw Gadget:=
 -12
> > [  268.918885][ T5067] raw-gadget.0: probe of gadget.0 failed with erro=
r -12
> > [  268.925956][ T5067] UDC core: USB Raw Gadget: couldn't find an avail=
able UDC or it's busy
> > [  268.934657][ T5067] misc raw-gadget: fail, usb_gadget_register_drive=
r returned -16
> >
> > BUG: memory leak
> >
> > [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> > [<ffffffff8347eb55>] kmalloc include/linux/slab.h:582 [inline]
> > [<ffffffff8347eb55>] kzalloc include/linux/slab.h:703 [inline]
> > [<ffffffff8347eb55>] dev_new drivers/usb/gadget/legacy/raw_gadget.c:191=
 [inline]
> > [<ffffffff8347eb55>] raw_open+0x45/0x110 drivers/usb/gadget/legacy/raw_=
gadget.c:385
> > [<ffffffff827d1d09>] misc_open+0x1a9/0x1f0 drivers/char/misc.c:165
> >
> > [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> > [<ffffffff8347cd2f>] kmalloc include/linux/slab.h:582 [inline]
> > [<ffffffff8347cd2f>] raw_ioctl_init+0xdf/0x410 drivers/usb/gadget/legac=
y/raw_gadget.c:460
> > [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/legacy/r=
aw_gadget.c:1250
> > [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> >
> > [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> > [<ffffffff833ecc6a>] kmalloc include/linux/slab.h:582 [inline]
> > [<ffffffff833ecc6a>] kzalloc include/linux/slab.h:703 [inline]
> > [<ffffffff833ecc6a>] dummy_alloc_request+0x5a/0xe0 drivers/usb/gadget/u=
dc/dummy_hcd.c:665
> > [<ffffffff833e9132>] usb_ep_alloc_request+0x22/0xd0 drivers/usb/gadget/=
udc/core.c:196
> > [<ffffffff8347f13d>] gadget_bind+0x6d/0x370 drivers/usb/gadget/legacy/r=
aw_gadget.c:292
> >
> > This commit therefore invoke kref_get() under the condition that
> > raw_queue_event() return success.
> >
> > Reported-by: syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dfeb045d335c1fdde5bf7
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadge=
t/legacy/raw_gadget.c
> > index 2acece16b890..e549022642e5 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -310,13 +310,15 @@ static int gadget_bind(struct usb_gadget *gadget,
> >         dev->eps_num =3D i;
> >         spin_unlock_irqrestore(&dev->lock, flags);
> >
> > -       /* Matches kref_put() in gadget_unbind(). */
> > -       kref_get(&dev->count);
> > -
> >         ret =3D raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
> > -       if (ret < 0)
> > +       if (ret < 0) {
> >                 dev_err(&gadget->dev, "failed to queue event\n");
> > +               set_gadget_data(gadget, NULL);
> > +               return ret;
> > +       }
> >
> > +       /* Matches kref_put() in gadget_unbind(). */
> > +       kref_get(&dev->count);
> >         return ret;
> >  }
> >
> > --
> > 2.17.1
>
> Indeed, if gadget_bind fails due to a raw_queue_event failure, the
> core gadget code will never call gadget_unbind.
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
>

Hi Greg

Friendly ping :)

Thanks
Zqiang




> Thanks!
