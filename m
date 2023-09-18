Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20E17A40AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbjIRFvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbjIRFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:50:33 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EE713E;
        Sun, 17 Sep 2023 22:50:23 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57656330b80so2741812eaf.3;
        Sun, 17 Sep 2023 22:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695016223; x=1695621023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg83dkCIcOfafRCLkMeI+KwToQlkTDJezwxVxKbajGo=;
        b=MYNkTO4WyCd/g0JRXQtpGPcCDtRPxXU+Au/ADDQO5pVjG1SUT+rge4isnAaYzVauSM
         h01j7+s28hiYZKFa+14KQ6sJwKiumX/iyJUhzh0FkuJhjlziDwO0b8gWJ7qyNHm7BCJ5
         I08UVme7L7t2+AYMXFi+PfYytmeMz4jC94gCfqRMq7qAUr0QSLsLUvP5TE2htNun9lX6
         +UxqqXXJrvAWK+sD2LZj3mwIhVsZWq+YF5+8zxnqVl7GRG4CHnnofmNQOVm+TpO6XpcT
         NjfK/rUD66HORMukdqizhBWDVNFw+puxpt7lUtyh2tLuVjyNEAWXi/uonB2gI6of9w0Z
         bbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016223; x=1695621023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kg83dkCIcOfafRCLkMeI+KwToQlkTDJezwxVxKbajGo=;
        b=Mk9SWpq3dvb3XHcYxBo004dMe0dclv3Bnnrsc9rOh/Lq8uJwx3P5+cnuxVVL1H0yiX
         whv6b1xQE1+VhF5FKhKFHkyx308x5gYQoPiU+Uke9Tat7JT8ZZgcAxGnrR3JX8HJYqU3
         upddOy4644JZj/4tRjPZkoSEyooSRz/lZvfDGrPq53RwrwAB0k3UbD1fPfK/y3JtrDIy
         AzusimkbkZsCKltsoz53X1ljZiL9sO6L3xBTObjVYxP58a7yblAZr0N/MvBEz43JC0RH
         XsIRgDRdtToRIHw5iJO3NLOoT79yGxaIKBBp74d61UlnCqinGRPw4Sa8U0RoSLONhaR8
         Kq1g==
X-Gm-Message-State: AOJu0Yx3vAQLTGFjw3e/kGJfF+HcaonNGHdQNdp3Ol/j3Rf5hZ6RTRlS
        D03ntEvmvR3GDMM1+eJ4nHHH7WyfP9hpXbPXTgw=
X-Google-Smtp-Source: AGHT+IEktDAOhzIcsp0IVS4swygpc0i6EqPnPtmP6Kxon2cECDV9LWFl8TWNTln5WlFtZoDOjoP+XzV1lE6S/dPVcBk=
X-Received: by 2002:a4a:6c12:0:b0:56e:4ddd:e333 with SMTP id
 q18-20020a4a6c12000000b0056e4ddde333mr7419649ooc.9.1695016223045; Sun, 17 Sep
 2023 22:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230914015656.20856-1-xingxing.luo@unisoc.com>
 <8365ba2a-8ecd-d055-e962-3a7f2bfdbfb0@omp.ru> <CANnj+8S6AXjkdO3sQnK-H7a-TSOxbqUQi3U5H+q_8wA-JcAV5g@mail.gmail.com>
 <f3463cff-c6d5-07e7-2f94-cdcbc76d3957@omp.ru> <CANnj+8R8ueWOOE=yA-pug7EEs0DRyh65dyRV8owQae1pZv5b9g@mail.gmail.com>
In-Reply-To: <CANnj+8R8ueWOOE=yA-pug7EEs0DRyh65dyRV8owQae1pZv5b9g@mail.gmail.com>
From:   xingxing luo <xingxing0070.luo@gmail.com>
Date:   Mon, 18 Sep 2023 13:50:11 +0800
Message-ID: <CANnj+8TNryKgq8MZ+Kx9-TE6SgNEjjfP-ZzVMd_KpYn4-F9_Og@mail.gmail.com>
Subject: Re: [PATCH] usb: musb: Get the musb_qh poniter after musb_giveback
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, b-liu@ti.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xingxing luo <xingxing0070.luo@gmail.com>,
        Zhiyong.Liu@unisoc.com, Cixi.Geng1@unisoc.com,
        Orson.Zhai@unisoc.com, Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more.

On Mon, Sep 18, 2023 at 1:22=E2=80=AFPM xingxing luo <xingxing0070.luo@gmai=
l.com> wrote:
>
> On Fri, Sep 15, 2023 at 4:48=E2=80=AFPM Sergey Shtylyov <s.shtylyov@omp.r=
u> wrote:
> >
> > On 9/15/23 5:59 AM, xingxing luo wrote:
> > [...]
> >
> > >>> When multiple threads are performing USB transmission, musb->lock w=
ill be
> > >>> unlocked when musb_giveback is executed. At this time, qh may be re=
leased
> > >>> in the dequeue process in other threads, resulting in a wild pointe=
r, so
> > >>> it needs to be here get qh again, and judge whether qh is NULL, and=
 when
> > >>> dequeue, you need to set qh to NULL.
> > >>>
> > >>> Fixes: dbac5d07d13e ("usb: musb: host: don't start next rx urb if c=
urrent one failed")
> > >>> Signed-off-by: Xingxing Luo <xingxing.luo@unisoc.com>
> > >>> ---
> > >>>  drivers/usb/musb/musb_host.c | 9 ++++++++-
> > >>>  1 file changed, 8 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_h=
ost.c
> > >>> index a02c29216955..9df27db5847a 100644
> > >>> --- a/drivers/usb/musb/musb_host.c
> > >>> +++ b/drivers/usb/musb/musb_host.c
> > >>> @@ -321,10 +321,16 @@ static void musb_advance_schedule(struct musb=
 *musb, struct urb *urb,
> > >>>       musb_giveback(musb, urb, status);
> > >>>       qh->is_ready =3D ready;
> > >>>
> > >>> +     /*
> > >>> +      * musb->lock had been unlocked in musb_giveback, so somtimes=
 qh
> > >>
> > >>    Sometimes?
> >
> >    You have a typo...
> >
> > >>
> > >>> +      * may freed, need get it again
> > >>> +      */
> > >>> +     qh =3D musb_ep_get_qh(hw_ep, is_in);
> > >>> +
> > >>>       /* reclaim resources (and bandwidth) ASAP; deschedule it, and
> > >>>        * invalidate qh as soon as list_empty(&hep->urb_list)
> > >>>        */
> > >>> -     if (list_empty(&qh->hep->urb_list)) {
> > >>> +     if (qh !=3D NULL && list_empty(&qh->hep->urb_list)) {
> > >>
> > >>    Just qh, perhaps?
> > >
> > > Could you elaborate a little more?
> > > Thanks.
> >
> >    Just 'qh' gives you the same as 'qh !=3D NULL'.
>
> Ok, I will address this in the next version.
>
> >
> > [...]
> >
> > MBR, Sergey

B.R Xingxing.Luo
