Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F217757090
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGQXgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGQXgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:36:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B89B10EB;
        Mon, 17 Jul 2023 16:35:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so75969021fa.3;
        Mon, 17 Jul 2023 16:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689636876; x=1692228876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpDzJ8g+Nqd/e3HwIl6M4xc5FAV1ICSMIHF0n1EHi+g=;
        b=lGDcG5un16Mus2SuNgyonS31a8Ln5OMNmF/5zGwP1zd1TwhNo/mTzBft4VqQ24TxPi
         qdfb46GF/HiTcq6bDd2dplo1f/h/JQ8BkH39xTmfZ1ANK9VowaqB0J8OaNazNifmTY48
         GQBcWtCdHRyI9prmxe+tM6hHIkPHlngfnjiKIC0poH/KyAtXbQqaOwEnrIMiJOhX3Yl7
         xXcSULyk5I+y7/A8WGmOzW8+Sqpv5L6V372+9IqQmHew24zny5r1KmksskZl3CVkD3V8
         imohB5Jx7+W0bF6bTsnMyU7GgkZOviSdnaTPh+p396mP1xAf7IPtswaTn/3IAPW2K4qV
         rKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689636876; x=1692228876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpDzJ8g+Nqd/e3HwIl6M4xc5FAV1ICSMIHF0n1EHi+g=;
        b=fs1U5xNC3wQe1lxTu56O/gAw7N7ZE6J51dSgviFITT0bC7Xs0VQ7FvdVWxFDG2mY6n
         3uM7gyJPiPmAyylGdJhwRAgEzCy/QjCfwCNAfkQkWnmU3i//S+rhJQUn8rj/n8bcj5/y
         tvDrdg0rEmyEKYXG5ik+gyeioC8I3aIXjf70kL/1qNRv9aBfgp0TDr6UANPm69eyUNFo
         7wNeohQFxEV7PLGg2r6SwIv39OsqF4okj3q4TCxDOyRRJFJD61g5w+K0c4hx26UAWzjw
         38ykk+q8j3m1bsV4RDhzKP+gPZaPxBbz5DVfRbh40Y8RovrQE4yBwMTKLSvGogwFcyBa
         cEAg==
X-Gm-Message-State: ABy/qLa/G4E5hyRlDphCX62geE9cNUGQ7heHLgeDd71wywIrXZoX6OJr
        qrPbx1UZTepwng3nt0E5UajyTX0nmv8lbhN0Tg0=
X-Google-Smtp-Source: APBJJlHbyhenm72vjAlMVGFb9TpbpuYYHDtE/ZSSTEoFJG4oyiZkqM0wb0BK5TptTcQm3pXfhs9HExRRtQO6FcskXEA=
X-Received: by 2002:a2e:3a1a:0:b0:2b6:9ebc:daf8 with SMTP id
 h26-20020a2e3a1a000000b002b69ebcdaf8mr9899506lja.31.1689636875848; Mon, 17
 Jul 2023 16:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <ZLSwfv2pQ5uH6bja@bud-laptop> <CABBYNZLvqcO9Bnbr-mFa23yPvKbePSeRk7s9xr5Vfred9hhUTw@mail.gmail.com>
 <CAHCcUCp4rgLP8SrTm_ncTe638ndWrgyz-ioicPYYXEZQZgHUYg@mail.gmail.com> <CABBYNZLE3BFLhx7ChNsLOXWP0bp01AwG2tABHNMXSCS7OA0uxQ@mail.gmail.com>
In-Reply-To: <CABBYNZLE3BFLhx7ChNsLOXWP0bp01AwG2tABHNMXSCS7OA0uxQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Jul 2023 16:34:23 -0700
Message-ID: <CABBYNZJ9-MgJQLb0m7jJX92MrTGgZGbJELPNt2YYb8it2wd65A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add VID/PID 0489/e102 for MediaTek MT7922
To:     Wes Miser <buddwm@gmail.com>
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

Hi,

On Mon, Jul 17, 2023 at 4:09=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Wes,
>
> On Mon, Jul 17, 2023 at 2:41=E2=80=AFPM Wes Miser <buddwm@gmail.com> wrot=
e:
> >
> > (Re-sending in text-only mode)
> >
> > Hey Luiz,
> >
> > I noticed that this may have already been submitted per
> > https://github.com/bluez/bluetooth-next/commit/159c43e9925e8f4655b8f834=
cbb864f5ecaf1778

Right, that probably explains why CI couldn't apply it because it is
already fixed, so no need to resend.

> > (I was building against torvalds/linux and didn't notice this in
> > bluetooth-next).  In any case here's the information about the device
> > from my system:
> >
> > T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D04 Cnt=3D02 Dev#=3D  3 Spd=3D480=
  MxCh=3D 0
> > D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D0489 ProdID=3De102 Rev=3D 1.00
> > S:  Manufacturer=3DMediaTek Inc.
> > S:  Product=3DWireless_Device
> > S:  SerialNumber=3D000000000
> > C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> > A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> > I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3D(none)
> > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > I:  If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3D(none)
> > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125u
>
> Please rebase since apparently our CI couldn't apply it, and please
> include the information above as part of the git commit description in
> the v2.
>
> >
> > On Mon, Jul 17, 2023 at 2:56=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Wes,
> > >
> > > On Sun, Jul 16, 2023 at 8:07=E2=80=AFPM Wes Miser <buddwm@gmail.com> =
wrote:
> > > >
> > > > Tested on Acer Swift Edge 16 Notebook
> > > >
> > > > Signed-off-by: Wes Miser <buddwm@gmail.com>
> > > > ---
> > > >  drivers/bluetooth/btusb.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > index 5ec4ad0a5c86..95f43d48f383 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -628,6 +628,9 @@ static const struct usb_device_id blacklist_tab=
le[] =3D {
> > > >         { USB_DEVICE(0x0489, 0xe0f2), .driver_info =3D BTUSB_MEDIAT=
EK |
> > > >                                                      BTUSB_WIDEBAND=
_SPEECH |
> > > >                                                      BTUSB_VALID_LE=
_STATES },
> > > > +       { USB_DEVICE(0x0489, 0xe102), .driver_info =3D BTUSB_MEDIAT=
EK |
> > > > +                                                    BTUSB_WIDEBAND=
_SPEECH |
> > > > +                                                    BTUSB_VALID_LE=
_STATES },
> > > >
> > > >         /* Additional Realtek 8723AE Bluetooth devices */
> > > >         { USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTE=
K },
> > > > --
> > > > 2.41.0
> > >
> > > Please include the information from /sys/kernel/debug/usb/devices
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
