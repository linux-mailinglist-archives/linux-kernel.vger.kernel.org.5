Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150BB7571B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGRCRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGRCRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:17:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A615DB5;
        Mon, 17 Jul 2023 19:17:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262e3c597b9so3646694a91.0;
        Mon, 17 Jul 2023 19:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689646660; x=1692238660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6Pq+3bBt/RhSrzZtH227af4Uxz0XBHsvG1iQYMeOrk=;
        b=N27AjRphrmpqNrdgtzpRPeJAooJYMvLwqbhkq/cLJ2WxLk4pXRO8H+Jhw2ttMBRDbJ
         CbCEx+zD3DXJKhmhFgLNkqVqkRxdf3VuPBDF/Ar0vEHjcV03RYWkQ811YetzjIIp37DP
         Xtu13E476AzyBmVKR3qXI4IfuNGGPtkMate0ZW8yLyYuvv0Yrg7q2esLS++Lbf76eILS
         ViT4t326YagzK+WlDumZJsZ/sj36utLorSooZyjNV9P2TZRgGjB530VWGzf4x9G/dKkQ
         d4F9zHCaqZLttcVVANIY+AQ9r8D62nMXKrOiCZzPQB2bdTBbv7Ws+D/83gxEhCS7Bst8
         gu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689646660; x=1692238660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6Pq+3bBt/RhSrzZtH227af4Uxz0XBHsvG1iQYMeOrk=;
        b=l21rSJsT//V20lLVe/gpFkNg5GTFfDUbvThhJVhMXmTZe4YV2NRF1RJoam7+EEI/h/
         NwOgYvSCrebeXlW354JUIB2UPtrgFXcCl1nzGYJ5CVQs3Cwdewou8Yy9dIk/eIv9o8H8
         hRHbrIYkrDYaA7egh1KGIGslu9Qk3TpopnHwJDcaqtr1P6kHMBbY6focVy7i8Owu8SSh
         9k9400PcdTNYIkQOLFy8ogldX4lwa6/41ShbqSfSA8BNWg81mNbTrzdUr0Lzq4beG6rT
         ALo9GBhF43JHUEDUwQhfxnbwd8WroCabSPkLGlKjbNObfmr3lmgtIe1IMsY+G1z5Xjgx
         TrBA==
X-Gm-Message-State: ABy/qLbwJiOXuf405N8kTzzmfsTUbd6xAB06SK58SPWgb8zgidB9e7N1
        QLHXvoiSVRMXpVnoGHMeTBVKNcUA81TGD88pDvDXf0D01BY=
X-Google-Smtp-Source: APBJJlHowA0Y/3i9DwGafTkDhk4FOSlU9ktmRO8ZupXLDvocZ8e5FJDzMFzxsZXZ+BoDaGLnRxFCI9v1Vd/xiAWYSBk=
X-Received: by 2002:a17:90a:458c:b0:263:d6a6:f37c with SMTP id
 v12-20020a17090a458c00b00263d6a6f37cmr12766463pjg.16.1689646660038; Mon, 17
 Jul 2023 19:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230714074011.20989-1-qiang.zhang1211@gmail.com> <CA+fCnZfxLLLVJdPZmVKg5w4YY+i09ZRz-wu+TAXBaroRgGsAsQ@mail.gmail.com>
In-Reply-To: <CA+fCnZfxLLLVJdPZmVKg5w4YY+i09ZRz-wu+TAXBaroRgGsAsQ@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 18 Jul 2023 10:17:28 +0800
Message-ID: <CALm+0cUUm6g+TWCso_UOFWJYGBZDHaDY29r1eMN44HBAuKUFVQ@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix the memory leak in raw_gadget driver
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Tested-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks for review and test !


>
> Thanks!
