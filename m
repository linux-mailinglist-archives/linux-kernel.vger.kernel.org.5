Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DAC757043
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGQXKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGQXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:10:23 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D61738;
        Mon, 17 Jul 2023 16:09:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so77689991fa.3;
        Mon, 17 Jul 2023 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689635365; x=1692227365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUJ8/P0jBzQeL02k2HUVGdTYv+wQQN1bz1Z9mgmPHqw=;
        b=MQBNuGOoukpKbXGO7Gv0lXvk5nfBYjz+TlAsJxrRKYEDM/JanZlNPrn37UBj/lSfgC
         I1eNMqR/A7PLHnSRPqQn06kNRnF+sjy76Rz8miu0FquSMlZ3kWjwxFiTCUbSBs9XERf6
         QHnSpodFdGbixIwedZ73maWLUFd7hXBAzp7LRAE1e3hzJxDfUwkonm9moNu2B2LhHoOY
         oym/GO7RZZgjbNOoIXPKUUSd0/h+lVwFKBLNL4qdnO2BBOpACPYYfOkCrLZfyOcKLNhw
         oyjMRvV+8GLISvgUWnRFg2f65NLj6cWzmlma9z2gpufksCuRm2BvOF4Qx4heztHXaeSL
         /7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689635365; x=1692227365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUJ8/P0jBzQeL02k2HUVGdTYv+wQQN1bz1Z9mgmPHqw=;
        b=M8V0wTzQebflZlgTEp1Kz2v8w1cgJnjwGRiPdgQLNfqhLNTho3QNHbd24pR1AbphYY
         DESA+horbDhNowGihP5Nu6AUCPu97uVUS1QeRgscS5FWcDG3jaEAch7C3r2YCtSekyLc
         XbBI+OOyCl1O94ldl9zcgl5s5tBpqejrd3uUaHKfCg3N24GiKIqB4RvoF2dC+uN9UsxS
         6aJy/VQib1EeQAi0c4Cxax9Zfh3lFrg4iGd+42231QUxnrPONWfSWo91Klqybm0DFMav
         ajEzUNJFJXE38gT+R6EJAi0hJDSVIqCKZ+urDToP3uJnBCavIM7MxBvqfMfzF5l55SJ+
         CE5A==
X-Gm-Message-State: ABy/qLacs2YBWLxwV/Z7wZpGxKzUFMLC2HT6WriKCLDE90Uss22quGtm
        rUEae95olrdW2444iojfgE4SsCtO+05tQLqOC1Fox7Yp
X-Google-Smtp-Source: APBJJlF+M7EKBmn6oYJ+f93nQglb0F/bfR4zjSUQE5tPRNzqqXgRaXes+iFwqm0JEcMwmgKMqwWbbBnLkXvG4Aeo8X8=
X-Received: by 2002:a2e:7301:0:b0:2b9:344c:a214 with SMTP id
 o1-20020a2e7301000000b002b9344ca214mr4179255ljc.42.1689635364910; Mon, 17 Jul
 2023 16:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <ZLSwfv2pQ5uH6bja@bud-laptop> <CABBYNZLvqcO9Bnbr-mFa23yPvKbePSeRk7s9xr5Vfred9hhUTw@mail.gmail.com>
 <CAHCcUCp4rgLP8SrTm_ncTe638ndWrgyz-ioicPYYXEZQZgHUYg@mail.gmail.com>
In-Reply-To: <CAHCcUCp4rgLP8SrTm_ncTe638ndWrgyz-ioicPYYXEZQZgHUYg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Jul 2023 16:09:12 -0700
Message-ID: <CABBYNZLE3BFLhx7ChNsLOXWP0bp01AwG2tABHNMXSCS7OA0uxQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add VID/PID 0489/e102 for MediaTek MT7922
To:     Wes Miser <buddwm@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wes,

On Mon, Jul 17, 2023 at 2:41=E2=80=AFPM Wes Miser <buddwm@gmail.com> wrote:
>
> (Re-sending in text-only mode)
>
> Hey Luiz,
>
> I noticed that this may have already been submitted per
> https://github.com/bluez/bluetooth-next/commit/159c43e9925e8f4655b8f834cb=
b864f5ecaf1778
> (I was building against torvalds/linux and didn't notice this in
> bluetooth-next).  In any case here's the information about the device
> from my system:
>
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D04 Cnt=3D02 Dev#=3D  3 Spd=3D480  =
MxCh=3D 0
> D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0489 ProdID=3De102 Rev=3D 1.00
> S:  Manufacturer=3DMediaTek Inc.
> S:  Product=3DWireless_Device
> S:  SerialNumber=3D000000000
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> I:  If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125u

Please rebase since apparently our CI couldn't apply it, and please
include the information above as part of the git commit description in
the v2.

>
> On Mon, Jul 17, 2023 at 2:56=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Wes,
> >
> > On Sun, Jul 16, 2023 at 8:07=E2=80=AFPM Wes Miser <buddwm@gmail.com> wr=
ote:
> > >
> > > Tested on Acer Swift Edge 16 Notebook
> > >
> > > Signed-off-by: Wes Miser <buddwm@gmail.com>
> > > ---
> > >  drivers/bluetooth/btusb.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 5ec4ad0a5c86..95f43d48f383 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -628,6 +628,9 @@ static const struct usb_device_id blacklist_table=
[] =3D {
> > >         { USB_DEVICE(0x0489, 0xe0f2), .driver_info =3D BTUSB_MEDIATEK=
 |
> > >                                                      BTUSB_WIDEBAND_S=
PEECH |
> > >                                                      BTUSB_VALID_LE_S=
TATES },
> > > +       { USB_DEVICE(0x0489, 0xe102), .driver_info =3D BTUSB_MEDIATEK=
 |
> > > +                                                    BTUSB_WIDEBAND_S=
PEECH |
> > > +                                                    BTUSB_VALID_LE_S=
TATES },
> > >
> > >         /* Additional Realtek 8723AE Bluetooth devices */
> > >         { USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK =
},
> > > --
> > > 2.41.0
> >
> > Please include the information from /sys/kernel/debug/usb/devices
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
