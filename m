Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9A7AB3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjIVOjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIVOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:39:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36C100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:39:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68c576d35feso1980783b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695393554; x=1695998354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDCW2U3ma3X57srmeQIvcOtqMW2EwlhtHdznihqOnWg=;
        b=Lx2MX2jLp5ySOIfaID7h9VWQpDIIin5fv3qBoLTcpMwwuePduJf0cKjIgvqSVA9ssN
         VGSAoJXmHDL3NXfyJAE6tj5D3153ssJyv7LxRpzyGLxLv3Z1ippHDShCFt5Ij+eoPvfU
         gE6HY/dWe9n9F/Lk4bZnQQ4aAMdJF8lV8uqWGUkKMIac2nk4PYSaSaCuagWQZsAU7h8p
         jAf3Af3qSgUlIxnNMJhTnE+4/SFIh6p1tTX10TR34F5OoFCR3rLxUh0LDYIHhgmhs9rT
         8B7x6AuXT2rTBDzYc1Tlfc13X3vKY4Rx4s8Qt2JqUnZHMHiPGO8MaHC6GyurkeCnL67c
         9Bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393554; x=1695998354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDCW2U3ma3X57srmeQIvcOtqMW2EwlhtHdznihqOnWg=;
        b=NEmFn2ePEN62is49dVGZv/TKilEn6CTghbRS71QamIgO9hCcoz/HY0M4w4pC2kRdN1
         JIbyH1YTnSCvd5DNfSkq6kKhxOSy1T4y5Q7PHRVBPlIaqz8wkW0qdZaSGVhVE40yGfdR
         0fHaoqc1YFiUPftLR/FUOMOGHDeaWXF7wouwqaMbPwqN5vUVMrLps/B5oaBBbg/TzcGa
         fOA3GDRUU4KNuIOPT9w3aALfatYDV/jxmvyTHUtgnDo3EoLNSgX9g5p4ItF8Eq97nyjr
         GDOtzEmJFE3mv8n7dt0FIxXN0wb0JfQ90nyO97OoRq/qowYdEtSsIrw7lV5FHh8n5VsB
         z+Lw==
X-Gm-Message-State: AOJu0YyjDx+ID4jonvKU8UDlRmpHYJ4JOoYuhBBNBjGTI7rgB5YhJXCB
        rBKJgaZ4kYjHxcTuvZzh+qPLl96EARBkV8khOiajEQ==
X-Google-Smtp-Source: AGHT+IGSX2coFfnuBFC8yiNSrNUXsjDUYJpRoivmDrjqqsI1bp/3866wqzTiC/iIOogJ9xfcP/YSwQVE82FwHEwWHJw=
X-Received: by 2002:a05:6a00:2389:b0:68a:5395:7aa5 with SMTP id
 f9-20020a056a00238900b0068a53957aa5mr9664393pfc.17.1695393554057; Fri, 22 Sep
 2023 07:39:14 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 22 Sep 2023 10:39:13 -0400
Mime-Version: 1.0
References: <20230810072155.3726352-1-zhangjian.3032@bytedance.com> <CACPK8XfWKLS_4nBC+NCSw=21iQeaHzBXOROmz9T+S0qZHCBKeg@mail.gmail.com>
In-Reply-To: <CACPK8XfWKLS_4nBC+NCSw=21iQeaHzBXOROmz9T+S0qZHCBKeg@mail.gmail.com>
From:   Jian Zhang <zhangjian.3032@bytedance.com>
Date:   Fri, 22 Sep 2023 10:39:13 -0400
Message-ID: <CA+J-oUtxiQBOT+VM3fbOUM8HL5TX-C4HqtbbT__b4_KsGAJy1w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] i2c: aspeed: Fix i2c bus hang in slave read
To:     Joel Stanley <joel@jms.id.au>
Cc:     Tommy Huang <tommy_huang@aspeedtech.com>,
        brendan.higgins@linux.dev, benh@kernel.crashing.org,
        andrew@aj.id.au, zhangjian3032@gmail.com, yulei.sh@bytedance.com,
        xiexinnan@bytedance.com,
        "open list:ARM/ASPEED I2C DRIVER" <linux-i2c@vger.kernel.org>,
        "moderated list:ARM/ASPEED I2C DRIVER" <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Joel Stanley"<joel@jms.id.au>
> Date:=C2=A0 Fri, Sep 22, 2023, 14:48
> Subject:=C2=A0 [External] Re: [PATCH] i2c: aspeed: Fix i2c bus hang in sl=
ave read
> To: "Jian Zhang"<zhangjian.3032@bytedance.com>, "Tommy Huang"<tommy_huang=
@aspeedtech.com>
> Cc: <brendan.higgins@linux.dev>, <benh@kernel.crashing.org>, <andrew@aj.i=
d.au>, <zhangjian3032@gmail.com>, <yulei.sh@bytedance.com>, <xiexinnan@byte=
dance.com>, "open list:ARM/ASPEED I2C DRIVER"<linux-i2c@vger.kernel.org>, "=
moderated list:ARM/ASPEED I2C DRIVER"<openbmc@lists.ozlabs.org>, "moderated=
 list:ARM/ASPEED MACHINE SUPPORT"<linux-arm-kernel@lists.infradead.org>, "m=
oderated list:ARM/ASPEED MACHINE SUPPORT"<linux-aspeed@lists.ozlabs.org>, "=
open list"<linux-kernel@vger.kernel.org>
> On Thu, 10 Aug 2023 at 07:22, Jian Zhang <zhangjian.3032@bytedance.com> w=
rote:
> >
> > When the `CONFIG_I2C_SLAVE` option is enabled and the device operates
> > as a slave, a situation arises where the master sends a START signal
> > without the accompanying STOP signal. This action results in a
> > persistent I2C bus timeout. The core issue stems from the fact that
> > the i2c controller remains in a slave read state without a timeout
> > mechanism. As a consequence, the bus perpetually experiences timeouts.
> >
> > This proposed patch addresses this problem by introducing a status
> > check during i2c transmit timeouts. In the event that the controller
> > is in a slave read state, the i2c controller will be reset to restore
> > proper functionality and allow the I2C bus to resume normal operation.
> >
> > Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
>
> Tommy has submitted a similar fix:
>
>=C2=A0 https://lore.kernel.org/linux-i2c/20230906004910.4157305-1-tommy_hu=
ang@aspeedtech.com/
>
> His change is very heavy handed; it reinitialises the bus including
> re-parsing the device tree (!).
>
> Should we have merged this fix instead? If not, are you able to
> confirm that his change fixes your issue?

I feel it's for solving the same issue, but I think this patch is
missing the action
`bus->slave_state =3D ASPEED_I2C_SLAVE_INACTIVE;`,
=C2=A0which means it can't resolve my problem. @Tommy, can you help confirm=
 this?

Thanks,

Jian

>
> Cheers,
>
> Joel
>
> > ---
> >=C2=A0 drivers/i2c/busses/i2c-aspeed.c | 17 +++++++++++++++++
> >=C2=A0 1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-a=
speed.c
> > index e76befe3f60f..1a95205fc946 100644
> > --- a/drivers/i2c/busses/i2c-aspeed.c
> > +++ b/drivers/i2c/busses/i2c-aspeed.c
> > @@ -113,6 +113,7 @@
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ASPEED_I2=
CD_M_RX_CMD | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0 \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ASPEED_I2=
CD_M_TX_CMD | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0 \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ASPEED_I2=
CD_M_START_CMD)
> > +#define ASPEED_I2CD_SLAVE_CMDS_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 GENMASK(31, 29)
> >
> >=C2=A0 /* 0x18 : I2CD Slave Device Address Register =C2=A0 */
> >=C2=A0 #define ASPEED_I2CD_DEV_ADDR_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 GENMASK(6, 0)
> > @@ -706,6 +707,22 @@ static int aspeed_i2c_master_xfer(struct i2c_adapt=
er *adap,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0 ASPEED_I2CD_BUS_BUSY_STS))
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 aspeed_i2c_recover_bus(bus);
> >
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 * If master ti=
med out and bus is in slave mode.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 * reset the sl=
ave mode.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (readl(bus->base =
+ ASPEED_I2C_CMD_REG) & ASPEED_I2CD_SLAVE_CMDS_MASK) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 spin_lock_irqsave(&bus->lock, flags);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 u32 func_ctrl_reg_val =3D readl(bus->base + ASPEED_I2C_FUN_CTRL_REG=
);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bus->slave_state =3D ASPEED_I2C_SLAVE_INACTIVE;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 spin_unlock_irqrestore(&bus->lock, flags);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > +#endif
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 * If time=
d out and the state is still pending, drop the pending
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 * master =
command.
> > --
> > 2.30.2
> >
