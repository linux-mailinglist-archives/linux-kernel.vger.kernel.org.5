Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A0C756F13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGQVly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjGQVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:41:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B318B;
        Mon, 17 Jul 2023 14:41:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso8117498e87.1;
        Mon, 17 Jul 2023 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689630109; x=1692222109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXdjqVaFGDV9Y1hhPrabhlg9MxCHiJlgDy6kNxcqWZ0=;
        b=bp37a+P9yE5nNmiRCfAjkZTg2YwY7ebFUVcl5PenLmwDVDeYtWqsSxG5OjeffB62a1
         L2RC3ZRInHykyeEbNW6BNbsDD+fW6p3Kgz1oDK7KMkXBmsRS0QvoD9Xiut2rCdKrdoqI
         zYaL/MOAuEarjvFSXOp3V7152RDYvhG9DwX9BsKdserK+7AC3IL69Dgh96SOaPwuDQ6H
         OJJMHjx52ngai9aRXhItY4CT45AD/KpvdMzaRnYshf6l/XjKPwe2xclWW5tD5EDvanm1
         SlDR/5H/LNqBOkLTDF3tI8Qoa98jvhXHwt5SzFBUgtLy7bhH7dnrePDt9tqBhJhfL64R
         jevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689630109; x=1692222109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXdjqVaFGDV9Y1hhPrabhlg9MxCHiJlgDy6kNxcqWZ0=;
        b=I/h69QgNUp7oiAbe5pBx38VBzxgLBcymGmFprJbXrfeBKIeZweM4kq1u2wI4QHs0+p
         N1YqxrOtfWjKoy/Kf691o8BjMsUu1+UBHlqU6mdOiuOegjNrzSyFO5SQDEuZhUFvnt72
         3DNIunBs1EiLFunDSW7/GYQPxbLCvlv55cAJSj5USoaE+lx0bt+Pp1S00+1fDJWMCPOI
         VEnGhsJm4619H1uXiL5tEcidazd/13sDY5fkXkfKqq5gIQpiGqiEI4fdjpkDSpZm6zsH
         NPBvpMmbRAso2eSBxdJ7TSatwiDKiow8VzJ3ESO9i57g3a20MgymOkiHuwirwIZeCiVV
         0grQ==
X-Gm-Message-State: ABy/qLZuLth1uf6+JrHsrrdgs7Z1SunkjELijmG8AGLQVxzP1ub6DN9y
        4xD0mC0RxkLLJ/nqt9lGuOWns5YujjPtjnvX4lP1cEAWYuL8Tn2R
X-Google-Smtp-Source: APBJJlGnTEkxTLleAmvBH4r4u03YXLl4WeDvpeMDUlEX+vQxlqycqFmyau79I9/McppCNUrynCQqelQhKYpB+t6X2hs=
X-Received: by 2002:a05:6512:3e1b:b0:4f9:ec5e:d624 with SMTP id
 i27-20020a0565123e1b00b004f9ec5ed624mr389943lfv.38.1689630108754; Mon, 17 Jul
 2023 14:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <ZLSwfv2pQ5uH6bja@bud-laptop> <CABBYNZLvqcO9Bnbr-mFa23yPvKbePSeRk7s9xr5Vfred9hhUTw@mail.gmail.com>
In-Reply-To: <CABBYNZLvqcO9Bnbr-mFa23yPvKbePSeRk7s9xr5Vfred9hhUTw@mail.gmail.com>
From:   Wes Miser <buddwm@gmail.com>
Date:   Mon, 17 Jul 2023 16:41:38 -0500
Message-ID: <CAHCcUCp4rgLP8SrTm_ncTe638ndWrgyz-ioicPYYXEZQZgHUYg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add VID/PID 0489/e102 for MediaTek MT7922
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Re-sending in text-only mode)

Hey Luiz,

I noticed that this may have already been submitted per
https://github.com/bluez/bluetooth-next/commit/159c43e9925e8f4655b8f834cbb8=
64f5ecaf1778
(I was building against torvalds/linux and didn't notice this in
bluetooth-next).  In any case here's the information about the device
from my system:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D04 Cnt=3D02 Dev#=3D  3 Spd=3D480  Mx=
Ch=3D 0
D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0489 ProdID=3De102 Rev=3D 1.00
S:  Manufacturer=3DMediaTek Inc.
S:  Product=3DWireless_Device
S:  SerialNumber=3D000000000
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
I:  If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125u


On Mon, Jul 17, 2023 at 2:56=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Wes,
>
> On Sun, Jul 16, 2023 at 8:07=E2=80=AFPM Wes Miser <buddwm@gmail.com> wrot=
e:
> >
> > Tested on Acer Swift Edge 16 Notebook
> >
> > Signed-off-by: Wes Miser <buddwm@gmail.com>
> > ---
> >  drivers/bluetooth/btusb.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 5ec4ad0a5c86..95f43d48f383 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -628,6 +628,9 @@ static const struct usb_device_id blacklist_table[]=
 =3D {
> >         { USB_DEVICE(0x0489, 0xe0f2), .driver_info =3D BTUSB_MEDIATEK |
> >                                                      BTUSB_WIDEBAND_SPE=
ECH |
> >                                                      BTUSB_VALID_LE_STA=
TES },
> > +       { USB_DEVICE(0x0489, 0xe102), .driver_info =3D BTUSB_MEDIATEK |
> > +                                                    BTUSB_WIDEBAND_SPE=
ECH |
> > +                                                    BTUSB_VALID_LE_STA=
TES },
> >
> >         /* Additional Realtek 8723AE Bluetooth devices */
> >         { USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK },
> > --
> > 2.41.0
>
> Please include the information from /sys/kernel/debug/usb/devices
>
> --
> Luiz Augusto von Dentz
