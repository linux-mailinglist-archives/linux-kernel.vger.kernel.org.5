Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0537B5B54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbjJBTab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbjJBTa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E4B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:30:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF32C433C7;
        Mon,  2 Oct 2023 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696275021;
        bh=QWzWrhJp7dxs93ZH9N9DbT7gsMc+i8rI4fB8fw2qII0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A4VMWXqSTqC0hnHw6TQyUwJO0ub3JkROizYvdG3Go38zOR2wVG3UZ9OU7AKGdIk0v
         WKA6nSR6TS4j9fMNOPEp8PpLtsURZf1YFbM7+8tOiyyuAY1DgQp/lBtunUNMg7BZhf
         OSg9wxYXgZIYFt8K7SBhHE2Oe5HlagaCZBMwJrvpihGa3KX17c0VuJ5lz0jus14N1v
         7N7fPDX/Zhf8aPmh+3+VNZpiYkcsHoD/jSt5VdQb2DIeMi/9NuLwzLjpwwaJufKZdo
         vsjSJpAXHpJ8NK5LBddSMKNYMv1ACFGlogLerjBk5r0Zqlbi+yxc0YoUseaYufFDTZ
         7QJnpjKyHCsrg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-504a7f9204eso59619e87.3;
        Mon, 02 Oct 2023 12:30:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YzVfdBKi58vzpQUUSUTth+xGFGkpvEbnQW9kYiqG0iz/aS8Jt+o
        gm5c2MYq8VXx5yO5lTpR9IfanS4GzQG8FHzb/rg=
X-Google-Smtp-Source: AGHT+IFZHUXuqC6jtJTOialRH3/SJ/f2Vw8J4fHh2W1SBlDBu/4IaBcSG8jxeVqZiHwyTBGWPTII4E5lcT6J1dWiuSs=
X-Received: by 2002:ac2:4f0b:0:b0:500:bff5:54ec with SMTP id
 k11-20020ac24f0b000000b00500bff554ecmr12351306lfr.3.1696275019494; Mon, 02
 Oct 2023 12:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230904051253.23208-1-stanley_chang@realtek.com> <43138ac278224fb78055c5c78e93cfb0@realtek.com>
In-Reply-To: <43138ac278224fb78055c5c78e93cfb0@realtek.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Tue, 3 Oct 2023 04:29:42 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0QTYCXF_hpPw_gHMBX4Mf-ZQ_5auU4p-20CtYtcOWYoA@mail.gmail.com>
Message-ID: <CAGTfZH0QTYCXF_hpPw_gHMBX4Mf-ZQ_5auU4p-20CtYtcOWYoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

Applied them with patch1/2.

I'm sorry for late reply.

Regards,
Chanwoo Choi

On Mon, Sep 18, 2023 at 3:41=E2=80=AFPM Stanley Chang[=E6=98=8C=E8=82=B2=E5=
=BE=B7]
<stanley_chang@realtek.com> wrote:
>
> Hi Chanwoo,
>
> Can you help review this patch?
>
> Thanks,
> Stanley
>
> > -----Original Message-----
> > From: Stanley Chang <stanley_chang@realtek.com>
> > Sent: Monday, September 4, 2023 1:13 PM
> > To: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Stanley Chang[=E6=98=8C=E8=82=B2=E5=BE=B7] <stanley_chang@realtek.c=
om>; Greg
> > Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>=
;
> > Chanwoo Choi <cw00.choi@samsung.com>; linux-usb@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH v3 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
> >
> > This patch adds the extcon driver for Realtek DHC (digital home center)
> > RTD SoCs type-c module. This can be used to detect whether the port is
> > configured as a downstream or upstream facing port. And notify the stat=
us
> > of extcon to listeners.
> >
> > Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> > ---
> > v2 to v3 change:
> >   removed the error check for debugfs
> > v1 to v2 change:
> >   1. added "depends on TYPEC" and "select USB_COMMON" in Kconfig
> >   2. revised the code about gpio.
> >   3. revised the definitions to keep the left-aligned of value
> >   4. add the comment for delay or sleep
> >   5. changed some functions to connector_attached/connector_detached
> >   6. removed to check 'CONFIG_TYPEC' definition with ifdef
> > ---
> >  drivers/extcon/Kconfig             |   11 +
> >  drivers/extcon/Makefile            |    1 +
> >  drivers/extcon/extcon-rtk-type-c.c | 1792 ++++++++++++++++++++++++++++
> >  3 files changed, 1804 insertions(+)
> >  create mode 100644 drivers/extcon/extcon-rtk-type-c.c
> >
> > diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> > index 0ef1971d22bb..0f4c061e7321 100644
> > --- a/drivers/extcon/Kconfig
> > +++ b/drivers/extcon/Kconfig
> > @@ -190,4 +190,15 @@ config EXTCON_USBC_TUSB320
> >         Say Y here to enable support for USB Type C cable detection ext=
con
> >         support using a TUSB320.
> >
> > +config EXTCON_RTK_TYPE_C
> > +     tristate "Realtek RTD SoC extcon Type-C Driver"
> > +     depends on ARCH_REALTEK || COMPILE_TEST
> > +     depends on TYPEC
> > +     select USB_COMMON
> > +     help
> > +       Say Y here to enable extcon support for USB Type C cable detect=
ion
> > +       when using the Realtek RTD SoC USB Type-C port.
> > +       The DHC (Digital Home Hub) RTD series SoC contains a type c mod=
ule.
> > +       This driver will detect the status of the type-c port.
> > +
> >  endif
> > diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> > index 1b390d934ca9..f779adb5e4c7 100644
> > --- a/drivers/extcon/Makefile
> > +++ b/drivers/extcon/Makefile
> > @@ -25,3 +25,4 @@ obj-$(CONFIG_EXTCON_SM5502) +=3D
> > extcon-sm5502.o
> >  obj-$(CONFIG_EXTCON_USB_GPIO)        +=3D extcon-usb-gpio.o
> >  obj-$(CONFIG_EXTCON_USBC_CROS_EC) +=3D extcon-usbc-cros-ec.o
> >  obj-$(CONFIG_EXTCON_USBC_TUSB320) +=3D extcon-usbc-tusb320.o
> > +obj-$(CONFIG_EXTCON_RTK_TYPE_C) +=3D extcon-rtk-type-c.o
> > diff --git a/drivers/extcon/extcon-rtk-type-c.c
> > b/drivers/extcon/extcon-rtk-type-c.c
> > new file mode 100644
> > index 000000000000..00465cfba23e
> > --- /dev/null
> > +++ b/drivers/extcon/extcon-rtk-type-c.c
> > @@ -0,0 +1,1792 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *  * extcon-rtk-type-c.c - Realtek Extcon Type C driver
> > + *
> > + * Copyright (C) 2023 Realtek Semiconductor Corporation
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/io.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/suspend.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/extcon.h>
> > +#include <linux/extcon-provider.h>
> > +#include <linux/sys_soc.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/usb/otg.h>
> > +#include <linux/usb/typec.h>
> > +
> > +struct cc_param {
> > +     u32 rp_4p7k_code;
> > +     u32 rp_36k_code;
> > +     u32 rp_12k_code;
> > +     u32 rd_code;
> > +     u32 ra_code;
> > +     u32 vref_2p6v;
> > +     u32 vref_1p23v;
> > +     u32 vref_0p8v;
> > +     u32 vref_0p66v;
> > +     u32 vref_0p4v;
> > +     u32 vref_0p2v;
> > +     u32 vref_1_1p6v;
> > +     u32 vref_0_1p6v;
> > +};
> > +
> > +struct type_c_cfg {
> > +     int parameter_ver; /* Parameter version */
> > +     int cc_dfp_mode;
> > +     struct cc_param cc1_param;
> > +     struct cc_param cc2_param;
> > +
> > +     u32 debounce_val;
> > +     bool use_defalut_parameter;
> > +};
> > +
> > +struct type_c_data {
> > +     void __iomem *reg_base;
> > +     struct device *dev;
> > +     struct extcon_dev *edev;
> > +
> > +     u32 irq;
> > +
> > +     /* rd control GPIO only for rtd1295 */
> > +     struct gpio_desc *rd_ctrl_gpio_desc;
> > +
> > +     /* Parameters */
> > +     struct type_c_cfg *type_c_cfg;
> > +     u32 dfp_mode_rp_en;
> > +     u32 ufp_mode_rd_en;
> > +     u32 cc1_code;
> > +     u32 cc2_code;
> > +     u32 cc1_vref;
> > +     u32 cc2_vref;
> > +     u32 debounce; /* 1b,1us 7f,4.7us */
> > +
> > +     /* type_c state */
> > +     int connect_change;
> > +#define CONNECT_CHANGE 1
> > +#define CONNECT_NO_CHANGE 0
> > +     int cc_mode; /* cc is host or device */
> > +#define IN_HOST_MODE 0x10
> > +#define IN_DEVICE_MODE 0x20
> > +     int is_attach;
> > +#define IN_ATTACH 1
> > +#define TO_ATTACH 1
> > +#define IN_DETACH 0
> > +#define TO_DETACH 0
> > +     int at_cc1;
> > +#define AT_CC1 1
> > +#define AT_CC2 0
> > +
> > +     u32 int_status;
> > +     u32 cc_status;
> > +     /* protect the data member */
> > +     spinlock_t lock;
> > +     struct delayed_work delayed_work;
> > +
> > +     bool rd_en_at_first;
> > +
> > +     struct dentry *debug_dir;
> > +
> > +     struct typec_port *port;
> > +};
> > +
> > +/* Type C register offset */
> > +#define USB_TYPEC_CTRL_CC1_0 0x0
> > +#define USB_TYPEC_CTRL_CC1_1 0x4
> > +#define USB_TYPEC_CTRL_CC2_0 0x8
> > +#define USB_TYPEC_CTRL_CC2_1 0xC
> > +#define USB_TYPEC_STS                0x10
> > +#define USB_TYPEC_CTRL               0x14
> > +#define USB_DBUS_PWR_CTRL    0x18
> > +
> > +#define ENABLE_CC1   0x1
> > +#define ENABLE_CC2   0x2
> > +#define DISABLE_CC   0x0
> > +
> > +/* Bit mapping USB_TYPEC_CTRL_CC1_0 and USB_TYPEC_CTRL_CC2_0 */
> > +#define PLR_EN               BIT(29)
> > +#define CC_SWITCH_MASK       (BIT(29) | BIT(28) | BIT(27))
> > +#define CC_CODE_MASK (0xfffff << 7)
> > +#define rp4pk_code(val)      ((0x1f & (val)) << 22)
> > +#define code_rp4pk(val)      (((val) >> 22) & 0x1f)
> > +#define rp36k_code(val)      ((0x1f & (val)) << 17)
> > +#define code_rp36k(val)      (((val) >> 17) & 0x1f)
> > +#define rp12k_code(val)      ((0x1f & (val)) << 12)
> > +#define code_rp12k(val)      (((val) >> 12) & 0x1f)
> > +#define rd_code(val) ((0x1f & (val)) << 7)
> > +#define code_rd(val) (((val) >> 7) & 0x1f)
> > +#define dfp_mode(val)        ((0x3 & (val)) << 5)
> > +#define EN_RP4P7K    BIT(4)
> > +#define EN_RP36K     BIT(3)
> > +#define EN_RP12K     BIT(2)
> > +#define EN_RD                BIT(1)
> > +#define EN_CC_DET    BIT(0)
> > +
> > +#define CC_MODE_UFP  0x0
> > +#define CC_MODE_DFP_USB      0x1
> > +#define CC_MODE_DFP_1_5      0x2
> > +#define CC_MODE_DFP_3_0      0x3
> > +
> > +/*
> > + * PARAMETER_V0:
> > + *  Realtek Kylin    rtd1295
> > + *  Realtek Hercules rtd1395
> > + *  Realtek Thor     rtd1619
> > + *  Realtek Hank     rtd1319
> > + *  Realtek Groot    rtd1312c
> > + * PARAMETER_V1:
> > + *  Realtek Stark    rtd1619b
> > + *  Realtek Parker   rtd1319d
> > + *  Realtek Danvers  rtd1315e
> > + */
> > +enum parameter_version {
> > +     PARAMETER_V0 =3D 0,
> > +     PARAMETER_V1 =3D 1,
> > +};
> > +
> > +/* Bit mapping USB_TYPEC_CTRL_CC1_1 and USB_TYPEC_CTRL_CC2_1 */
> > +#define V0_vref_2p6v(val)    ((0xf & (val)) << 26) /* Bit 29 for groot=
 */
> > +#define V0_vref_1p23v(val)   ((0xf & (val)) << 22)
> > +#define V0_vref_0p8v(val)    ((0xf & (val)) << 18)
> > +#define V0_vref_0p66v(val)   ((0xf & (val)) << 14)
> > +#define V0_vref_0p4v(val)    ((0x7 & (val)) << 11)
> > +#define V0_vref_0p2v(val)    ((0x7 & (val)) << 8)
> > +#define V0_vref_1_1p6v(val)  ((0xf & (val)) << 4)
> > +#define V0_vref_0_1p6v(val)  ((0xf & (val)) << 0)
> > +
> > +#define V0_decode_2p6v(val)  (((val) >> 26) & 0xf) /* Bit 29 for groot=
 */
> > +#define V0_decode_1p23v(val) (((val) >> 22) & 0xf)
> > +#define V0_decode_0p8v(val)  (((val) >> 18) & 0xf)
> > +#define V0_decode_0p66v(val) (((val) >> 14) & 0xf)
> > +#define V0_decode_0p4v(val)  (((val) >> 11) & 0x7)
> > +#define V0_decode_0p2v(val)  (((val) >> 8) & 0x7)
> > +#define V0_decode_1_1p6v(val)        (((val) >> 4) & 0xf)
> > +#define V0_decode_0_1p6v(val)        (((val) >> 0) & 0xf)
> > +
> > +/* new Bit mapping USB_TYPEC_CTRL_CC1_1 and USB_TYPEC_CTRL_CC2_1
> > */
> > +#define V1_vref_2p6v(val)    ((0xf & (val)) << 28)
> > +#define V1_vref_1p23v(val)   ((0xf & (val)) << 24)
> > +#define V1_vref_0p8v(val)    ((0xf & (val)) << 20)
> > +#define V1_vref_0p66v(val)   ((0xf & (val)) << 16)
> > +#define V1_vref_0p4v(val)    ((0xf & (val)) << 12)
> > +#define V1_vref_0p2v(val)    ((0xf & (val)) << 8)
> > +#define V1_vref_1_1p6v(val)  ((0xf & (val)) << 4)
> > +#define V1_vref_0_1p6v(val)  ((0xf & (val)) << 0)
> > +
> > +#define V1_decode_2p6v(val)  (((val) >> 28) & 0xf)
> > +#define V1_decode_1p23v(val) (((val) >> 24) & 0xf)
> > +#define V1_decode_0p8v(val)  (((val) >> 20) & 0xf)
> > +#define V1_decode_0p66v(val) (((val) >> 16) & 0xf)
> > +#define V1_decode_0p4v(val)  (((val) >> 12) & 0xf)
> > +#define V1_decode_0p2v(val)  (((val) >> 8) & 0xf)
> > +#define V1_decode_1_1p6v(val)        (((val) >> 4) & 0xf)
> > +#define V1_decode_0_1p6v(val)        (((val) >> 0) & 0xf)
> > +
> > +/* Bit mapping USB_TYPEC_STS */
> > +#define DET_STS              0x7
> > +#define CC1_DET_STS  (DET_STS)
> > +#define CC2_DET_STS  (DET_STS << 3)
> > +#define DET_STS_RA   0x1
> > +#define DET_STS_RD   0x3
> > +#define DET_STS_RP   0x1
> > +#define CC1_DET_STS_RA       (DET_STS_RA)
> > +#define CC1_DET_STS_RD       (DET_STS_RD)
> > +#define CC1_DET_STS_RP       (DET_STS_RP)
> > +#define CC2_DET_STS_RA       (DET_STS_RA << 3)
> > +#define CC2_DET_STS_RD       (DET_STS_RD << 3)
> > +#define CC2_DET_STS_RP       (DET_STS_RP << 3)
> > +
> > +/* Bit mapping USB_TYPEC_CTRL */
> > +#define CC2_INT_EN           BIT(11)
> > +#define CC1_INT_EN           BIT(10)
> > +#define CC2_INT_STS          BIT(9)
> > +#define CC1_INT_STS          BIT(8)
> > +#define DEBOUNCE_TIME_MASK   0xff
> > +#define DEBOUNCE_EN          BIT(0)
> > +#define ENABLE_TYPE_C_DETECT (CC1_INT_EN | CC2_INT_EN)
> > +#define ALL_CC_INT_STS               (CC1_INT_STS | CC2_INT_STS)
> > +
> > +/* Parameter */
> > +#define DETECT_TIME 50 /* ms */
> > +
> > +static const unsigned int usb_type_c_cable[] =3D {
> > +     EXTCON_USB,
> > +     EXTCON_USB_HOST,
> > +     EXTCON_NONE,
> > +};
> > +
> > +enum usb_data_roles {
> > +     DR_NONE,
> > +     DR_HOST,
> > +     DR_DEVICE,
> > +};
> > +
> > +static const struct soc_device_attribute rtk_soc_kylin[] =3D {
> > +     { .family =3D "Realtek Kylin", },
> > +     { /* empty */ }
> > +};
> > +
> > +static int rtd129x_switch_type_c_plug_config(struct type_c_data *type_=
c,
> > +                                          int dr_mode, int cc)
> > +{
> > +     void __iomem *reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC1_0;
> > +     int val_cc;
> > +
> > +#define TYPE_C_EN_SWITCH     BIT(29)
> > +#define TYPE_C_TXRX_SEL              (BIT(28) | BIT(27))
> > +#define TYPE_C_SWITCH_MASK   (TYPE_C_EN_SWITCH | TYPE_C_TXRX_SEL)
> > +#define TYPE_C_ENABLE_CC1    TYPE_C_EN_SWITCH
> > +#define TYPE_C_ENABLE_CC2    (TYPE_C_EN_SWITCH | TYPE_C_TXRX_SEL)
> > +#define TYPE_C_DISABLE_CC    ~TYPE_C_SWITCH_MASK
> > +
> > +     val_cc =3D readl(reg);
> > +     val_cc &=3D ~TYPE_C_SWITCH_MASK;
> > +
> > +     if (cc =3D=3D DISABLE_CC) {
> > +             val_cc &=3D TYPE_C_DISABLE_CC;
> > +     } else if (cc =3D=3D ENABLE_CC1) {
> > +             val_cc |=3D TYPE_C_ENABLE_CC1;
> > +     } else if (cc =3D=3D ENABLE_CC2) {
> > +             val_cc |=3D TYPE_C_ENABLE_CC2;
> > +     } else {
> > +             dev_err(type_c->dev, "%s: Error cc setting cc=3D0x%x\n", =
__func__,
> > cc);
> > +             return -EINVAL;
> > +     }
> > +     writel(val_cc, reg);
> > +
> > +     /* waiting cc stable for enable/disable */
> > +     mdelay(1);
> > +
> > +     dev_dbg(type_c->dev, "%s: cc=3D0x%x val_cc=3D0x%x
> > usb_typec_ctrl_cc1_0=3D0x%x\n",
> > +             __func__, cc, val_cc, readl(reg));
> > +
> > +     return 0;
> > +}
> > +
> > +static inline void switch_type_c_plug_config(struct type_c_data *type_=
c,
> > +                                          int dr_mode, int cc)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (soc_device_match(rtk_soc_kylin))
> > +             ret =3D rtd129x_switch_type_c_plug_config(type_c, dr_mode=
, cc);
> > +
> > +     if (ret < 0)
> > +             dev_err(type_c->dev, "%s: Error set type c plug config\n"=
,
> > +                     __func__);
> > +}
> > +
> > +static void switch_type_c_dr_mode(struct type_c_data *type_c, int dr_m=
ode,
> > int cc)
> > +{
> > +     bool is_host =3D false;
> > +     bool is_device =3D false;
> > +     bool polarity =3D false;
> > +     bool vbus =3D false;
> > +     bool ss =3D true;
> > +
> > +     switch_type_c_plug_config(type_c, dr_mode, cc);
> > +     if (cc =3D=3D ENABLE_CC2)
> > +             polarity =3D true;
> > +
> > +     switch (dr_mode) {
> > +     case USB_DR_MODE_HOST:
> > +             is_host =3D true;
> > +             break;
> > +     case USB_DR_MODE_PERIPHERAL:
> > +             is_device =3D true;
> > +             vbus =3D true;
> > +             break;
> > +     default:
> > +             dev_dbg(type_c->dev, "%s dr_mode=3D%d =3D=3D> no host or =
device\n",
> > +                     __func__, dr_mode);
> > +             break;
> > +     }
> > +
> > +     dev_dbg(type_c->dev, "%s is_host=3D%d is_device=3D%d vbus=3D%d
> > polarity=3D%d\n",
> > +             __func__, is_host, is_device, vbus, polarity);
> > +
> > +     /* for EXTCON_USB device mode */
> > +     extcon_set_state(type_c->edev, EXTCON_USB, is_device);
> > +     extcon_set_property(type_c->edev, EXTCON_USB,
> > +                         EXTCON_PROP_USB_VBUS,
> > +                         (union extcon_property_value)(int)vbus);
> > +     extcon_set_property(type_c->edev, EXTCON_USB,
> > +                         EXTCON_PROP_USB_TYPEC_POLARITY,
> > +                         (union extcon_property_value)(int)polarity);
> > +     extcon_set_property(type_c->edev, EXTCON_USB,
> > +                         EXTCON_PROP_USB_SS,
> > +                         (union extcon_property_value)(int)ss);
> > +
> > +     /* for EXTCON_USB_HOST host mode */
> > +     extcon_set_state(type_c->edev, EXTCON_USB_HOST, is_host);
> > +     extcon_set_property(type_c->edev, EXTCON_USB_HOST,
> > +                         EXTCON_PROP_USB_VBUS,
> > +                         (union extcon_property_value)(int)vbus);
> > +     extcon_set_property(type_c->edev, EXTCON_USB_HOST,
> > +                         EXTCON_PROP_USB_TYPEC_POLARITY,
> > +                         (union extcon_property_value)(int)polarity);
> > +     extcon_set_property(type_c->edev, EXTCON_USB_HOST,
> > +                         EXTCON_PROP_USB_SS,
> > +                         (union extcon_property_value)(int)ss);
> > +
> > +     /* sync EXTCON_USB and EXTCON_USB_HOST */
> > +     extcon_sync(type_c->edev, EXTCON_USB);
> > +     extcon_sync(type_c->edev, EXTCON_USB_HOST);
> > +
> > +     if (type_c->port) {
> > +             switch (dr_mode) {
> > +             case USB_DR_MODE_HOST:
> > +                     typec_set_data_role(type_c->port, TYPEC_HOST);
> > +                     typec_set_pwr_role(type_c->port, TYPEC_SOURCE);
> > +                     break;
> > +             case USB_DR_MODE_PERIPHERAL:
> > +                     typec_set_data_role(type_c->port, TYPEC_DEVICE);
> > +                     typec_set_pwr_role(type_c->port, TYPEC_SINK);
> > +                     break;
> > +             default:
> > +                     dev_dbg(type_c->dev, "%s unknown dr_mode=3D%d\n",
> > +                             __func__, dr_mode);
> > +                     break;
> > +             }
> > +     }
> > +}
> > +
> > +/* connector attached/detached */
> > +static int connector_attached(struct type_c_data *type_c, u32 cc, int
> > dr_mode)
> > +{
> > +     void __iomem *reg =3D type_c->reg_base + USB_TYPEC_CTRL;
> > +
> > +     cancel_delayed_work(&type_c->delayed_work);
> > +
> > +     switch_type_c_dr_mode(type_c, dr_mode, cc);
> > +
> > +     writel(ENABLE_TYPE_C_DETECT | readl(reg), reg);
> > +
> > +     return 0;
> > +}
> > +
> > +static int connector_detached(struct type_c_data *type_c, u32 cc, int
> > dr_mode)
> > +{
> > +     void __iomem *reg =3D type_c->reg_base + USB_TYPEC_CTRL;
> > +
> > +     writel(~ENABLE_TYPE_C_DETECT & readl(reg), reg);
> > +
> > +     switch_type_c_dr_mode(type_c, 0, cc);
> > +
> > +     schedule_delayed_work(&type_c->delayed_work,
> > msecs_to_jiffies(DETECT_TIME));
> > +
> > +     return 0;
> > +}
> > +
> > +/* detect host device switch */
> > +static int __detect_host_device(struct type_c_data *type_c, u32 rp_or_=
rd_en)
> > +{
> > +     struct device *dev =3D type_c->dev;
> > +     void __iomem *reg_base =3D type_c->reg_base;
> > +     u32 cc1_config, cc2_config, default_ctrl;
> > +     u32 cc1_switch =3D 0;
> > +
> > +     default_ctrl =3D readl(reg_base + USB_TYPEC_CTRL) &
> > DEBOUNCE_TIME_MASK;
> > +     writel(default_ctrl, reg_base + USB_TYPEC_CTRL);
> > +
> > +     cc1_config =3D readl(reg_base + USB_TYPEC_CTRL_CC1_0);
> > +     cc2_config =3D readl(reg_base + USB_TYPEC_CTRL_CC2_0);
> > +
> > +     cc1_config &=3D ~EN_CC_DET;
> > +     cc2_config &=3D ~EN_CC_DET;
> > +     writel(cc1_config, reg_base + USB_TYPEC_CTRL_CC1_0);
> > +     writel(cc2_config, reg_base + USB_TYPEC_CTRL_CC2_0);
> > +
> > +     if (soc_device_match(rtk_soc_kylin))
> > +             cc1_switch =3D cc1_config & CC_SWITCH_MASK;
> > +
> > +     cc1_config &=3D CC_CODE_MASK;
> > +     cc1_config |=3D rp_or_rd_en | cc1_switch;
> > +     cc2_config &=3D CC_CODE_MASK;
> > +     cc2_config |=3D rp_or_rd_en;
> > +     writel(cc2_config, reg_base + USB_TYPEC_CTRL_CC2_0);
> > +     writel(cc1_config, reg_base + USB_TYPEC_CTRL_CC1_0);
> > +
> > +     /* For kylin to disable external rd control gpio */
> > +     if (soc_device_match(rtk_soc_kylin)) {
> > +             struct gpio_desc *gpio =3D type_c->rd_ctrl_gpio_desc;
> > +
> > +             if (gpio && gpiod_direction_output(gpio, 1))
> > +                     dev_err(dev, "%s ERROR set rd_ctrl_gpio_desc fail=
\n",
> > __func__);
> > +     }
> > +
> > +     cc1_config |=3D EN_CC_DET;
> > +     cc2_config |=3D EN_CC_DET;
> > +     writel(cc1_config, reg_base + USB_TYPEC_CTRL_CC1_0);
> > +     writel(cc2_config, reg_base + USB_TYPEC_CTRL_CC2_0);
> > +
> > +     return 0;
> > +}
> > +
> > +static int detect_device(struct type_c_data *type_c)
> > +{
> > +     return __detect_host_device(type_c, type_c->dfp_mode_rp_en);
> > +}
> > +
> > +static int detect_host(struct type_c_data *type_c)
> > +{
> > +     return __detect_host_device(type_c, type_c->ufp_mode_rd_en);
> > +}
> > +
> > +static int host_device_switch_detection(struct type_c_data *type_c)
> > +{
> > +     if (type_c->cc_mode =3D=3D IN_HOST_MODE) {
> > +             type_c->cc_mode =3D IN_DEVICE_MODE;
> > +             detect_host(type_c);
> > +     } else {
> > +             type_c->cc_mode =3D IN_HOST_MODE;
> > +             detect_device(type_c);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int detect_type_c_state(struct type_c_data *type_c)
> > +{
> > +     struct device *dev =3D type_c->dev;
> > +     void __iomem *reg_base =3D type_c->reg_base;
> > +     u32 int_status, cc_status, cc_status_check;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +
> > +     int_status =3D readl(reg_base + USB_TYPEC_CTRL);
> > +     cc_status =3D readl(reg_base + USB_TYPEC_STS);
> > +
> > +     type_c->connect_change =3D CONNECT_NO_CHANGE;
> > +
> > +     switch (type_c->cc_mode | type_c->is_attach) {
> > +     case IN_HOST_MODE | IN_ATTACH:
> > +             if (((cc_status & CC1_DET_STS) =3D=3D CC1_DET_STS) &&
> > type_c->at_cc1 =3D=3D AT_CC1) {
> > +                     dev_dbg(dev, "IN host mode and cc1 device detach
> > (cc_status=3D0x%x)",
> > +                             cc_status);
> > +                     type_c->is_attach =3D TO_DETACH;
> > +                     type_c->connect_change =3D CONNECT_CHANGE;
> > +             } else if (((cc_status & CC2_DET_STS) =3D=3D CC2_DET_STS)=
 &&
> > +                        type_c->at_cc1 =3D=3D AT_CC2) {
> > +                     dev_dbg(dev, "IN host mode and cc2 device detach
> > (cc_status=3D0x%x)",
> > +                             cc_status);
> > +                     type_c->is_attach =3D TO_DETACH;
> > +                     type_c->connect_change =3D CONNECT_CHANGE;
> > +             }
> > +             break;
> > +     case IN_HOST_MODE | IN_DETACH:
> > +             cc_status_check =3D readl(reg_base + USB_TYPEC_STS);
> > +             if (cc_status_check !=3D (CC1_DET_STS | CC2_DET_STS)) {
> > +                     if (in_interrupt()) {
> > +                             /* Add delay time to avoid capacitive eff=
ect of cable. */
> > +                             mdelay(300);
> > +                     } else {
> > +                             spin_unlock_irqrestore(&type_c->lock, fla=
gs);
> > +                             /* Add delay time to avoid capacitive eff=
ect of cable. */
> > +                             msleep(300);
> > +                             spin_lock_irqsave(&type_c->lock, flags);
> > +                     }
> > +                     cc_status_check =3D readl(reg_base + USB_TYPEC_ST=
S);
> > +             }
> > +             if (cc_status !=3D cc_status_check) {
> > +                     dev_warn(dev, "IN_HOST_MODE: cc_status (0x%x) !=
=3D
> > cc_status_check (0x%x)\n",
> > +                              cc_status, cc_status_check);
> > +                     cc_status =3D readl(reg_base + USB_TYPEC_STS);
> > +             }
> > +
> > +             if ((cc_status & CC1_DET_STS) =3D=3D CC1_DET_STS_RD) {
> > +                     dev_dbg(dev, "IN host mode and cc1 device attach
> > (cc_status=3D0x%x)",
> > +                             cc_status);
> > +                     type_c->is_attach =3D TO_ATTACH;
> > +                     type_c->at_cc1 =3D AT_CC1;
> > +                     type_c->connect_change =3D CONNECT_CHANGE;
> > +             } else if ((cc_status & CC2_DET_STS) =3D=3D CC2_DET_STS_R=
D) {
> > +                     dev_dbg(dev, "In host mode and cc2 device attach
> > (cc_status=3D0x%x)",
> > +                             cc_status);
> > +                     type_c->is_attach =3D TO_ATTACH;
> > +                     type_c->at_cc1 =3D AT_CC2;
> > +                     type_c->connect_change =3D CONNECT_CHANGE;
> > +             }
> > +             break;
> > +     case IN_DEVICE_MODE | IN_ATTACH:
> > +             if ((cc_status & CC1_DET_STS) < CC1_DET_STS_RP ||
> > +                 (cc_status & CC2_DET_STS) < CC2_DET_STS_RP) {
> > +                     /* Add a sw debounce to filter cc signal sent fro=
m apple pd
> > adapter */
> > +                     mdelay(5);
> > +                     cc_status_check =3D readl(reg_base + USB_TYPEC_ST=
S);
> > +
> > +                     if (cc_status !=3D cc_status_check) {
> > +                             dev_dbg(dev, "IN_DEVICE_MODE: cc_status (=
0x%x) !=3D
> > cc_status_check (0x%x) maybe use a pd adapter\n",
> > +                                     cc_status, cc_status_check);
> > +                             cc_status =3D cc_status_check;
> > +                     }
> > +             }
> > +
> > +             if ((cc_status & CC1_DET_STS) < CC1_DET_STS_RP &&
> > type_c->at_cc1 =3D=3D AT_CC1) {
> > +                     dev_dbg(dev, "IN device mode and cc1 host disconn=
ect
> > (cc_status=3D0x%x)",
> > +                             cc_status);
> > +                     type_c->is_attach =3D TO_DETACH;
> > +                     type_c->connect_change =3D CONNECT_CHANGE;
> > +             } else if ((cc_status & CC2_DET_STS) < CC2_DET_STS_RP &&
> > +                        type_c->at_cc1 =3D=3D AT_CC2) {
> > +                     dev_dbg(dev, "IN device mode and cc2 host disconn=
ect
> > (cc_status=3D0x%x)",
> > +                             cc_status);
> > +                     type_c->is_attach =3D TO_DETACH;
> > +                     type_c->connect_change =3D CONNECT_CHANGE;
> > +             }
> > +             break;
> > +     case IN_DEVICE_MODE | IN_DETACH:
> > +             cc_status_check =3D readl(reg_base + USB_TYPEC_STS);
> > +             if (cc_status_check !=3D 0x0) {
> > +                     if (in_interrupt()) {
> > +                             /* Add delay time to avoid capacitive eff=
ect of cable. */
> > +                             mdelay(300);
> > +                     } else {
> > +                             spin_unlock_irqrestore(&type_c->lock, fla=
gs);
> > +                             /* Add delay time to avoid capacitive eff=
ect of cable. */
> > +                             msleep(300);
> > +                             spin_lock_irqsave(&type_c->lock, flags);
> > +                     }
> > +                     cc_status_check =3D readl(reg_base + USB_TYPEC_ST=
S);
> > +             }
> > +
> > +             if (cc_status !=3D cc_status_check) {
> > +                     dev_warn(dev, "IN_DEVICE_MODE: cc_status (0x%x) !=
=3D
> > cc_status_check (0x%x)\n",
> > +                              cc_status, cc_status_check);
> > +                     cc_status =3D readl(reg_base + USB_TYPEC_STS);
> > +             }
> > +
> > +             if ((cc_status & CC1_DET_STS) >=3D CC1_DET_STS_RP) {
> > +                     dev_dbg(dev, "IN device mode and cc1 host connect
> > (cc_status=3D0x%x)",
> > +                             cc_status);
> > +                     type_c->at_cc1 =3D AT_CC1;
> > +                     type_c->is_attach =3D TO_ATTACH;
> > +                     type_c->connect_change =3D CONNECT_CHANGE;
> > +             } else if ((cc_status & CC2_DET_STS) >=3D CC2_DET_STS_RP)=
 {
> > +                     dev_dbg(dev, "IN device mode and cc2 host connect
> > (cc_status=3D0x%x)",
> > +                             cc_status);
> > +                     type_c->at_cc1 =3D AT_CC2;
> > +                     type_c->is_attach =3D TO_ATTACH;
> > +                     type_c->connect_change =3D CONNECT_CHANGE;
> > +             }
> > +             break;
> > +     default:
> > +             dev_err(dev, "error host or device mode (cc_mode=3D%d,
> > is_attach=3D%d) ",
> > +                     type_c->cc_mode, type_c->is_attach);
> > +     }
> > +
> > +     type_c->int_status =3D int_status;
> > +     type_c->cc_status =3D cc_status;
> > +
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +     return 0;
> > +}
> > +
> > +static void host_device_switch(struct work_struct *work)
> > +{
> > +     struct type_c_data *type_c =3D container_of(work, struct type_c_d=
ata,
> > +                                               delayed_work.work);
> > +     struct device *dev =3D type_c->dev;
> > +     unsigned long flags;
> > +     int connect_change =3D 0;
> > +     int cc_mode =3D 0;
> > +     int is_attach =3D 0;
> > +     int at_cc1 =3D 0;
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +     if (type_c->connect_change)
> > +             connect_change =3D type_c->connect_change;
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     if (!connect_change)
> > +             detect_type_c_state(type_c);
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +     if (type_c->connect_change) {
> > +             connect_change =3D type_c->connect_change;
> > +             cc_mode =3D type_c->cc_mode;
> > +             is_attach =3D type_c->is_attach;
> > +             at_cc1 =3D type_c->at_cc1;
> > +             type_c->connect_change =3D CONNECT_NO_CHANGE;
> > +     } else {
> > +             host_device_switch_detection(type_c);
> > +
> > +             schedule_delayed_work(&type_c->delayed_work,
> > msecs_to_jiffies(DETECT_TIME));
> > +     }
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     if (!connect_change)
> > +             return;
> > +
> > +     dev_dbg(dev, "%s: usb cable connection change\n", __func__);
> > +     if (cc_mode =3D=3D IN_HOST_MODE) {
> > +             if (is_attach && at_cc1)
> > +                     connector_attached(type_c, ENABLE_CC1,
> > USB_DR_MODE_HOST);
> > +             else if (is_attach && !at_cc1)
> > +                     connector_attached(type_c, ENABLE_CC2,
> > USB_DR_MODE_HOST);
> > +             else
> > +                     connector_detached(type_c, DISABLE_CC,
> > USB_DR_MODE_HOST);
> > +     } else if (cc_mode =3D=3D IN_DEVICE_MODE) {
> > +             if (is_attach && at_cc1)
> > +                     connector_attached(type_c, ENABLE_CC1,
> > USB_DR_MODE_PERIPHERAL);
> > +             else if (is_attach && !at_cc1)
> > +                     connector_attached(type_c, ENABLE_CC2,
> > USB_DR_MODE_PERIPHERAL);
> > +             else
> > +                     connector_detached(type_c, DISABLE_CC,
> > USB_DR_MODE_PERIPHERAL);
> > +     } else {
> > +             dev_err(dev, "Error: IN unknown mode %d to %s at %s
> > (cc_status=3D0x%x)\n",
> > +                     cc_mode, is_attach ? "attach" : "detach",
> > +                     at_cc1 ? "cc1" : "cc2", type_c->cc_status);
> > +     }
> > +     dev_info(dev, "Connection change OK: IN %s mode to %s at %s
> > (cc_status=3D0x%x)\n",
> > +              cc_mode =3D=3D IN_HOST_MODE ? "host" : "device",
> > +              is_attach ? "attach" : "detach",
> > +              at_cc1 ? "cc1" : "cc2", type_c->cc_status);
> > +}
> > +
> > +static irqreturn_t type_c_detect_irq(int irq, void *__data)
> > +{
> > +     struct type_c_data *type_c =3D (struct type_c_data *)__data;
> > +     struct device *dev =3D type_c->dev;
> > +     void __iomem *reg =3D type_c->reg_base + USB_TYPEC_CTRL;
> > +     unsigned long flags;
> > +
> > +     detect_type_c_state(type_c);
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +
> > +     if (type_c->connect_change) {
> > +             dev_dbg(dev, "%s: IN %s mode to %s (at %s interrupt)
> > int_status=3D0x%x, cc_status=3D0x%x",
> > +                     __func__,
> > +                     type_c->cc_mode =3D=3D IN_HOST_MODE ? "host" : "d=
evice",
> > +                     type_c->is_attach ? "attach" : "detach",
> > +                     type_c->at_cc1 ? "cc1" : "cc2",
> > +                     type_c->int_status, type_c->cc_status);
> > +
> > +             /* clear interrupt status */
> > +             writel(~ALL_CC_INT_STS & readl(reg), reg);
> > +
> > +             cancel_delayed_work(&type_c->delayed_work);
> > +             schedule_delayed_work(&type_c->delayed_work,
> > msecs_to_jiffies(0));
> > +     } else {
> > +             static int local_count;
> > +
> > +             /* if no connect_change, we keep the status to avoid stat=
us lose */
> > +             if (local_count++ > 10) {
> > +                     /* clear interrupt status */
> > +                     writel(~ALL_CC_INT_STS & readl(reg), reg);
> > +                     local_count =3D 0;
> > +             }
> > +     }
> > +
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int type_c_port_dr_set(struct typec_port *port,
> > +                           enum typec_data_role role)
> > +{
> > +     struct type_c_data *type_c =3D typec_get_drvdata(port);
> > +     u32 enable_cc;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +     enable_cc =3D type_c->at_cc1 ? ENABLE_CC1 : ENABLE_CC2;
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     if (role =3D=3D TYPEC_HOST)
> > +             switch_type_c_dr_mode(type_c, USB_DR_MODE_HOST, enable_cc=
);
> > +     else if (role =3D=3D TYPEC_DEVICE)
> > +             switch_type_c_dr_mode(type_c, USB_DR_MODE_PERIPHERAL,
> > enable_cc);
> > +     else
> > +             switch_type_c_dr_mode(type_c, 0, DISABLE_CC);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct typec_operations type_c_port_ops =3D {
> > +     .dr_set =3D type_c_port_dr_set,
> > +};
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static int type_c_parameter_show(struct seq_file *s, void *unused)
> > +{
> > +     struct type_c_data *type_c =3D s->private;
> > +     struct type_c_cfg *type_c_cfg =3D type_c->type_c_cfg;
> > +     struct cc_param *cc_param;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +
> > +     seq_printf(s, "cc_dfp_mode %s\n",
> > +                ({ char *tmp;
> > +                     switch (type_c_cfg->cc_dfp_mode) {
> > +                     case CC_MODE_DFP_USB:
> > +                             tmp =3D "CC_MODE_DFP_USB"; break;
> > +                     case CC_MODE_DFP_1_5:
> > +                             tmp =3D "CC_MODE_DFP_1_5"; break;
> > +                     case CC_MODE_DFP_3_0:
> > +                             tmp =3D "CC_MODE_DFP_3_0"; break;
> > +                     default:
> > +                             tmp =3D "?"; break;
> > +                } tmp; }));
> > +
> > +     seq_printf(s, "dfp_mode_rp_en 0x%x\n", type_c->dfp_mode_rp_en);
> > +     seq_printf(s, "ufp_mode_rd_en 0x%x\n", type_c->ufp_mode_rd_en);
> > +     seq_printf(s, "cc1_code 0x%x\n", type_c->cc1_code);
> > +     seq_printf(s, "cc2_code 0x%x\n", type_c->cc2_code);
> > +     seq_printf(s, "cc1_vref 0x%x\n", type_c->cc1_vref);
> > +     seq_printf(s, "cc2_vref 0x%x\n", type_c->cc2_vref);
> > +     seq_printf(s, "debounce 0x%x\n", type_c->debounce);
> > +     seq_puts(s, "\n");
> > +
> > +     cc_param =3D &type_c_cfg->cc1_param;
> > +     seq_puts(s, "cc1_param:\n");
> > +     seq_printf(s, "  rp_4p7k_code 0x%x\n", cc_param->rp_4p7k_code);
> > +     seq_printf(s, "  rp_36k_code  0x%x\n", cc_param->rp_36k_code);
> > +     seq_printf(s, "  rp_12k_code  0x%x\n", cc_param->rp_12k_code);
> > +     seq_printf(s, "  rd_code      0x%x\n", cc_param->rd_code);
> > +     seq_printf(s, "  vref_2p6v    0x%x\n", cc_param->vref_2p6v);
> > +     seq_printf(s, "  vref_1p23v   0x%x\n", cc_param->vref_1p23v);
> > +     seq_printf(s, "  vref_0p8v    0x%x\n", cc_param->vref_0p8v);
> > +     seq_printf(s, "  vref_0p66v   0x%x\n", cc_param->vref_0p66v);
> > +     seq_printf(s, "  vref_0p4v    0x%x\n", cc_param->vref_0p4v);
> > +     seq_printf(s, "  vref_0p2v    0x%x\n", cc_param->vref_0p2v);
> > +     seq_printf(s, "  vref_1_1p6v  0x%x\n", cc_param->vref_1_1p6v);
> > +     seq_printf(s, "  vref_0_1p6v  0x%x\n", cc_param->vref_0_1p6v);
> > +
> > +     cc_param =3D &type_c_cfg->cc2_param;
> > +     seq_puts(s, "cc2_param:\n");
> > +     seq_printf(s, "  rp_4p7k_code 0x%x\n", cc_param->rp_4p7k_code);
> > +     seq_printf(s, "  rp_36k_code  0x%x\n", cc_param->rp_36k_code);
> > +     seq_printf(s, "  rp_12k_code  0x%x\n", cc_param->rp_12k_code);
> > +     seq_printf(s, "  rd_code      0x%x\n", cc_param->rd_code);
> > +     seq_printf(s, "  vref_2p6v    0x%x\n", cc_param->vref_2p6v);
> > +     seq_printf(s, "  vref_1p23v   0x%x\n", cc_param->vref_1p23v);
> > +     seq_printf(s, "  vref_0p8v    0x%x\n", cc_param->vref_0p8v);
> > +     seq_printf(s, "  vref_0p66v   0x%x\n", cc_param->vref_0p66v);
> > +     seq_printf(s, "  vref_0p4v    0x%x\n", cc_param->vref_0p4v);
> > +     seq_printf(s, "  vref_0p2v    0x%x\n", cc_param->vref_0p2v);
> > +     seq_printf(s, "  vref_1_1p6v  0x%x\n", cc_param->vref_1_1p6v);
> > +     seq_printf(s, "  vref_0_1p6v  0x%x\n", cc_param->vref_0_1p6v);
> > +
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static int type_c_parameter_open(struct inode *inode, struct file *fil=
e)
> > +{
> > +     return single_open(file, type_c_parameter_show, inode->i_private)=
;
> > +}
> > +
> > +static const struct file_operations type_c_parameter_fops =3D {
> > +     .open                   =3D type_c_parameter_open,
> > +     .read                   =3D seq_read,
> > +     .llseek                 =3D seq_lseek,
> > +     .release                =3D single_release,
> > +};
> > +
> > +static int type_c_status_show(struct seq_file *s, void *unused)
> > +{
> > +     struct type_c_data *type_c =3D s->private;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +
> > +     seq_printf(s, "In %s mode %s at %s (cc_status=3D0x%x)\n",
> > +                type_c->cc_mode =3D=3D IN_HOST_MODE ? "host" : "device=
",
> > +                type_c->is_attach ? "attach" : "detach",
> > +                type_c->at_cc1 ? "cc1" : "cc2", type_c->cc_status);
> > +
> > +     seq_printf(s, "Read Register (type_c_ctrl_cc1_0=3D0x%x)\n",
> > +                readl(type_c->reg_base + 0x0));
> > +     seq_printf(s, "Read Register (type_c_ctrl_cc1_1=3D0x%x)\n",
> > +                readl(type_c->reg_base + 0x4));
> > +     seq_printf(s, "Read Register (type_c_ctrl_cc2_0=3D0x%x)\n",
> > +                readl(type_c->reg_base + 0x8));
> > +     seq_printf(s, "Read Register (type_c_ctrl_cc2_1=3D0x%x)\n",
> > +                readl(type_c->reg_base + 0xc));
> > +     seq_printf(s, "Read Register (type_c_status=3D0x%x)\n",
> > +                readl(type_c->reg_base + 0x10));
> > +     seq_printf(s, "Read Register (type_c_ctrl=3D0x%x)\n",
> > +                readl(type_c->reg_base + 0x14));
> > +
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static int type_c_status_open(struct inode *inode, struct file *file)
> > +{
> > +     return single_open(file, type_c_status_show, inode->i_private);
> > +}
> > +
> > +static const struct file_operations type_c_status_fops =3D {
> > +     .open                   =3D type_c_status_open,
> > +     .read                   =3D seq_read,
> > +     .llseek                 =3D seq_lseek,
> > +     .release                =3D single_release,
> > +};
> > +
> > +static inline void create_debug_files(struct type_c_data *type_c)
> > +{
> > +     type_c->debug_dir =3D debugfs_create_dir("type_c", usb_debug_root=
);
> > +
> > +     debugfs_create_file("parameter", 0444, type_c->debug_dir, type_c,
> > +                         &type_c_parameter_fops);
> > +
> > +     debugfs_create_file("status", 0444, type_c->debug_dir, type_c,
> > +                         &type_c_status_fops);
> > +}
> > +
> > +static inline void remove_debug_files(struct type_c_data *type_c)
> > +{
> > +     debugfs_remove_recursive(type_c->debug_dir);
> > +}
> > +#else
> > +static inline void create_debug_files(struct type_c_data *type_c) { }
> > +static inline void remove_debug_files(struct type_c_data *type_c) { }
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> > +/* Init and probe */
> > +
> > +static inline s8 get_value(s8 value)
> > +{
> > +     return (((s8)value & 0x8) ? (-(s8)(0x7 & value)) : ((s8)(value)))=
;
> > +}
> > +
> > +static int __updated_type_c_parameter_by_efuse(struct type_c_data
> > *type_c)
> > +{
> > +     struct type_c_cfg *type_c_cfg =3D type_c->type_c_cfg;
> > +     struct cc_param *cc_param;
> > +     struct nvmem_cell *cell;
> > +     s8 cc1_4p7k =3D 0;
> > +     s8 cc1_12k =3D 0;
> > +     s8 cc1_0p2v =3D 0;
> > +     s8 cc1_0p8v =3D 0;
> > +     s8 cc1_2p6v =3D 0;
> > +     s8 cc1_0p66v =3D 0;
> > +     s8 cc1_1p23v =3D 0;
> > +     s8 cc2_4p7k =3D 0;
> > +     s8 cc2_12k =3D 0;
> > +     s8 cc2_0p2v =3D 0;
> > +     s8 cc2_0p8v =3D 0;
> > +     s8 cc2_2p6v =3D 0;
> > +     s8 cc2_0p66v =3D 0;
> > +     s8 cc2_1p23v =3D 0;
> > +
> > +     cell =3D nvmem_cell_get(type_c->dev, "usb-cal");
> > +     if (IS_ERR(cell)) {
> > +             dev_warn(type_c->dev, "%s failed to get usb-cal: %ld\n",
> > +                      __func__, PTR_ERR(cell));
> > +     } else {
> > +             unsigned char *buf;
> > +             size_t buf_size;
> > +             int value_size =3D 4;
> > +             int value_mask =3D (BIT(value_size) - 1);
> > +
> > +             buf =3D nvmem_cell_read(cell, &buf_size);
> > +
> > +             cc1_0p2v =3D get_value((buf[0] >> value_size * 0) & value=
_mask);
> > +             cc1_0p8v =3D get_value((buf[0] >> value_size * 1) & value=
_mask);
> > +             cc1_2p6v =3D get_value((buf[1] >> value_size * 0) & value=
_mask);
> > +             cc1_0p66v =3D get_value((buf[1] >> value_size * 1) & valu=
e_mask);
> > +             cc1_1p23v =3D get_value((buf[2] >> value_size * 0) & valu=
e_mask);
> > +
> > +             cc2_0p2v =3D get_value((buf[3] >> value_size * 0) & value=
_mask);
> > +             cc2_0p8v =3D get_value((buf[3] >> value_size * 1) & value=
_mask);
> > +             cc2_2p6v =3D get_value((buf[4] >> value_size * 0) & value=
_mask);
> > +             cc2_0p66v =3D get_value((buf[4] >> value_size * 1) & valu=
e_mask);
> > +             cc2_1p23v =3D get_value((buf[5] >> value_size * 0) & valu=
e_mask);
> > +
> > +             cc1_4p7k =3D get_value((buf[6] >> value_size * 0) & value=
_mask);
> > +             cc1_12k =3D get_value((buf[6] >> value_size * 1) & value_=
mask);
> > +             cc2_4p7k =3D get_value((buf[7] >> value_size * 0) & value=
_mask);
> > +             cc2_12k =3D get_value((buf[7] >> value_size * 1) & value_=
mask);
> > +
> > +             kfree(buf);
> > +             nvmem_cell_put(cell);
> > +     }
> > +
> > +     dev_dbg(type_c->dev, "check efuse cc1_4p7k=3D%d cc1_12k=3D%d
> > cc2_4p7k=3D%d cc2_12k=3D%d\n",
> > +             cc1_4p7k, cc1_12k, cc2_4p7k, cc2_12k);
> > +     dev_dbg(type_c->dev, "check efuse cc1_0p2v=3D%d cc1_0p8v=3D%d
> > cc1_2p6v=3D%d cc1_0p66v=3D%d cc1_1p23v=3D%d\n",
> > +             cc1_0p2v, cc1_0p8v, cc1_2p6v, cc1_0p66v, cc1_1p23v);
> > +     dev_dbg(type_c->dev, "check efuse cc2_0p2v=3D%d cc2_0p8v=3D%d
> > cc2_2p6v=3D%d cc2_0p66v=3D%d cc2_1p23v=3D%d\n",
> > +             cc2_0p2v, cc2_0p8v, cc2_2p6v, cc2_0p66v, cc2_1p23v);
> > +
> > +     cc_param =3D &type_c_cfg->cc1_param;
> > +     cc_param->rp_4p7k_code =3D cc_param->rp_4p7k_code + cc1_4p7k;
> > +     cc_param->rp_12k_code =3D cc_param->rp_12k_code + cc1_12k;
> > +
> > +     cc_param->vref_1p23v =3D cc_param->vref_1p23v + cc1_1p23v;
> > +     cc_param->vref_0p66v =3D cc_param->vref_0p66v + cc1_0p66v;
> > +     cc_param->vref_2p6v =3D cc_param->vref_2p6v + cc1_2p6v;
> > +     cc_param->vref_0p8v =3D cc_param->vref_0p8v + cc1_0p8v;
> > +     cc_param->vref_0p2v =3D cc_param->vref_0p2v + cc1_0p2v;
> > +
> > +     cc_param =3D &type_c_cfg->cc2_param;
> > +     cc_param->rp_4p7k_code =3D cc_param->rp_4p7k_code + cc2_4p7k;
> > +     cc_param->rp_12k_code =3D cc_param->rp_12k_code + cc2_12k;
> > +
> > +     cc_param->vref_1p23v =3D cc_param->vref_1p23v + cc2_1p23v;
> > +     cc_param->vref_0p66v =3D cc_param->vref_0p66v + cc2_0p66v;
> > +     cc_param->vref_2p6v =3D cc_param->vref_2p6v + cc2_2p6v;
> > +     cc_param->vref_0p8v =3D cc_param->vref_0p8v + cc2_0p8v;
> > +     cc_param->vref_0p2v =3D cc_param->vref_0p2v + cc2_0p2v;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __updated_type_c_parameter_by_efuse_v2(struct type_c_data
> > *type_c)
> > +{
> > +     struct type_c_cfg *type_c_cfg =3D type_c->type_c_cfg;
> > +     struct cc_param *cc_param;
> > +     struct nvmem_cell *cell;
> > +     s8 cc1_4p7k =3D 0;
> > +     s8 cc1_12k =3D 0;
> > +     s8 cc1_0p2v =3D 0;
> > +     s8 cc1_0p8v =3D 0;
> > +     s8 cc1_2p6v =3D 0;
> > +     s8 cc1_0p66v =3D 0;
> > +     s8 cc1_1p23v =3D 0;
> > +     s8 cc2_4p7k =3D 0;
> > +     s8 cc2_12k =3D 0;
> > +     s8 cc2_0p2v =3D 0;
> > +     s8 cc2_0p8v =3D 0;
> > +     s8 cc2_2p6v =3D 0;
> > +     s8 cc2_0p66v =3D 0;
> > +     s8 cc2_1p23v =3D 0;
> > +
> > +     cell =3D nvmem_cell_get(type_c->dev, "usb-type-c-cal");
> > +     if (IS_ERR(cell)) {
> > +             dev_warn(type_c->dev, "%s failed to get usb-type-c-cal: %=
ld\n",
> > +                      __func__, PTR_ERR(cell));
> > +     } else {
> > +             unsigned char *buf;
> > +             size_t buf_size;
> > +             int value_size =3D 0;
> > +             int value_mask =3D (BIT(value_size) - 1);
> > +
> > +             buf =3D nvmem_cell_read(cell, &buf_size);
> > +
> > +             value_size =3D 5;
> > +             value_mask =3D (BIT(value_size) - 1);
> > +             cc1_4p7k =3D buf[0] & value_mask;
> > +             cc1_12k =3D buf[1] & value_mask;
> > +             cc2_4p7k =3D buf[2] & value_mask;
> > +             cc2_12k =3D buf[3] & value_mask;
> > +
> > +             value_size =3D 4;
> > +             value_mask =3D (BIT(value_size) - 1);
> > +             cc1_0p2v =3D (buf[4] >> value_size * 0) & value_mask;
> > +             cc1_0p66v =3D (buf[4] >> value_size * 1) & value_mask;
> > +             cc1_0p8v =3D (buf[5] >> value_size * 0) & value_mask;
> > +             cc1_1p23v =3D (buf[5] >> value_size * 1) & value_mask;
> > +             cc1_2p6v =3D (buf[6] >> value_size * 0) & value_mask;
> > +
> > +             cc2_0p2v =3D (buf[6] >> value_size * 1) & value_mask;
> > +             cc2_0p66v =3D (buf[7] >> value_size * 0) & value_mask;
> > +             cc2_0p8v =3D (buf[7] >> value_size * 1) & value_mask;
> > +             cc2_1p23v =3D (buf[8] >> value_size * 0) & value_mask;
> > +             cc2_2p6v =3D (buf[8] >> value_size * 1) & value_mask;
> > +
> > +             kfree(buf);
> > +             nvmem_cell_put(cell);
> > +     }
> > +
> > +     dev_dbg(type_c->dev, "check efuse v2 cc1_4p7k=3D%d cc1_12k=3D%d
> > cc2_4p7k=3D%d cc2_12k=3D%d\n",
> > +             cc1_4p7k, cc1_12k, cc2_4p7k, cc2_12k);
> > +     dev_dbg(type_c->dev, "check efuse v2 cc1_0p2v=3D%d cc1_0p8v=3D%d
> > cc1_2p6v=3D%d cc1_0p66v=3D%d cc1_1p23v=3D%d\n",
> > +             cc1_0p2v, cc1_0p8v, cc1_2p6v, cc1_0p66v, cc1_1p23v);
> > +     dev_dbg(type_c->dev, "check efuse v2 cc2_0p2v=3D%d cc2_0p8v=3D%d
> > cc2_2p6v=3D%d cc2_0p66v=3D%d cc2_1p23v=3D%d\n",
> > +             cc2_0p2v, cc2_0p8v, cc2_2p6v, cc2_0p66v, cc2_1p23v);
> > +
> > +     cc_param =3D &type_c_cfg->cc1_param;
> > +     if (cc1_4p7k)
> > +             cc_param->rp_4p7k_code =3D cc1_4p7k;
> > +     if (cc1_12k)
> > +             cc_param->rp_12k_code =3D cc1_12k;
> > +
> > +     if (cc1_1p23v)
> > +             cc_param->vref_1p23v =3D cc1_1p23v;
> > +     if (cc1_0p66v)
> > +             cc_param->vref_0p66v =3D cc1_0p66v;
> > +     if (cc1_2p6v)
> > +             cc_param->vref_2p6v =3D cc1_2p6v;
> > +     if (cc1_0p8v)
> > +             cc_param->vref_0p8v =3D cc1_0p8v;
> > +     if (cc1_0p2v)
> > +             cc_param->vref_0p2v =3D cc1_0p2v;
> > +
> > +     cc_param =3D &type_c_cfg->cc2_param;
> > +     if (cc2_4p7k)
> > +             cc_param->rp_4p7k_code =3D cc2_4p7k;
> > +     if (cc2_12k)
> > +             cc_param->rp_12k_code =3D cc2_12k;
> > +
> > +     if (cc2_1p23v)
> > +             cc_param->vref_1p23v =3D cc2_1p23v;
> > +     if (cc2_0p66v)
> > +             cc_param->vref_0p66v =3D cc2_0p66v;
> > +     if (cc2_2p6v)
> > +             cc_param->vref_2p6v =3D cc2_2p6v;
> > +     if (cc2_0p8v)
> > +             cc_param->vref_0p8v =3D cc2_0p8v;
> > +     if (cc2_0p2v)
> > +             cc_param->vref_0p2v =3D cc2_0p2v;
> > +
> > +     return 0;
> > +}
> > +
> > +static void get_default_type_c_parameter(struct type_c_data *type_c)
> > +{
> > +     void __iomem *reg;
> > +     int val;
> > +
> > +     type_c->dfp_mode_rp_en =3D dfp_mode(CC_MODE_DFP_3_0) |
> > EN_RP4P7K;
> > +     type_c->ufp_mode_rd_en =3D EN_RD;
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC1_0;
> > +     val =3D readl(reg);
> > +     type_c->cc1_code =3D CC_CODE_MASK & val;
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC2_0;
> > +     val =3D readl(reg);
> > +     type_c->cc2_code =3D CC_CODE_MASK & val;
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC1_1;
> > +     val =3D readl(reg);
> > +     type_c->cc1_vref =3D val;
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC2_1;
> > +     val =3D readl(reg);
> > +     type_c->cc2_vref =3D val;
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL;
> > +     val =3D readl(reg);
> > +     type_c->debounce =3D DEBOUNCE_TIME_MASK & val;
> > +}
> > +
> > +static int setup_type_c_parameter(struct type_c_data *type_c)
> > +{
> > +     struct type_c_cfg *type_c_cfg =3D type_c->type_c_cfg;
> > +     struct cc_param *cc_param;
> > +     struct soc_device_attribute rtk_soc_efuse_v1[] =3D {
> > +                     { .family =3D "Realtek Phoenix",},
> > +                     { .family =3D "Realtek Kylin",},
> > +                     { .family =3D "Realtek Hercules",},
> > +                     { .family =3D "Realtek Thor",},
> > +                     { .family =3D "Realtek Hank",},
> > +                     { .family =3D "Realtek Groot",},
> > +                     { .family =3D "Realtek Stark",},
> > +                     { .family =3D "Realtek Parker",},
> > +                     { /* empty */ }
> > +             };
> > +
> > +     if (type_c_cfg->use_defalut_parameter) {
> > +             get_default_type_c_parameter(type_c);
> > +             return 0;
> > +     }
> > +
> > +     if (soc_device_match(rtk_soc_efuse_v1))
> > +             __updated_type_c_parameter_by_efuse(type_c);
> > +     else
> > +             __updated_type_c_parameter_by_efuse_v2(type_c);
> > +
> > +     /*
> > +      * UFP     rd     vref_ufp    : 1p23v,  0p66v, 0p2v
> > +      * DFP_USB rp36k  vref_dfp_usb: 0_1p6v, 0p2v,  unused
> > +      * DFP_1.5 rp12k  vref_dfp_1_5: 1_1p6v, 0p4v,  0p2v
> > +      * DFP_3.0 rp4p7k vref_dfp_3_0: 2p6v,   0p8v,  0p2v
> > +      */
> > +
> > +     switch (type_c_cfg->cc_dfp_mode) {
> > +     case CC_MODE_DFP_USB:
> > +             type_c->dfp_mode_rp_en =3D dfp_mode(CC_MODE_DFP_USB) |
> > EN_RP36K;
> > +             break;
> > +     case CC_MODE_DFP_1_5:
> > +             type_c->dfp_mode_rp_en =3D dfp_mode(CC_MODE_DFP_1_5) |
> > EN_RP12K;
> > +             break;
> > +     case CC_MODE_DFP_3_0:
> > +             type_c->dfp_mode_rp_en =3D dfp_mode(CC_MODE_DFP_3_0) |
> > EN_RP4P7K;
> > +             break;
> > +     default:
> > +             dev_err(type_c->dev, "%s: unknown cc_dfp_mode %d\n",
> > +                     __func__, type_c_cfg->cc_dfp_mode);
> > +     }
> > +
> > +     type_c->ufp_mode_rd_en =3D EN_RD;
> > +
> > +     cc_param =3D &type_c_cfg->cc1_param;
> > +     type_c->cc1_code =3D rp4pk_code(cc_param->rp_4p7k_code) |
> > +                        rp36k_code(cc_param->rp_36k_code) |
> > +                        rp12k_code(cc_param->rp_12k_code) |
> > +                        rd_code(cc_param->rd_code);
> > +
> > +     if (type_c_cfg->parameter_ver =3D=3D PARAMETER_V0)
> > +             type_c->cc1_vref =3D V0_vref_2p6v(cc_param->vref_2p6v) |
> > +                                V0_vref_1p23v(cc_param->vref_1p23v) |
> > +                                V0_vref_0p8v(cc_param->vref_0p8v) |
> > +                                V0_vref_0p66v(cc_param->vref_0p66v) |
> > +                                V0_vref_0p4v(cc_param->vref_0p4v) |
> > +                                V0_vref_0p2v(cc_param->vref_0p2v) |
> > +                                V0_vref_1_1p6v(cc_param->vref_1_1p6v) =
|
> > +                                V0_vref_0_1p6v(cc_param->vref_0_1p6v);
> > +     else if (type_c_cfg->parameter_ver =3D=3D PARAMETER_V1)
> > +             type_c->cc1_vref =3D V1_vref_2p6v(cc_param->vref_2p6v) |
> > +                                V1_vref_1p23v(cc_param->vref_1p23v) |
> > +                                V1_vref_0p8v(cc_param->vref_0p8v) |
> > +                                V1_vref_0p66v(cc_param->vref_0p66v) |
> > +                                V1_vref_0p4v(cc_param->vref_0p4v) |
> > +                                V1_vref_0p2v(cc_param->vref_0p2v) |
> > +                                V1_vref_1_1p6v(cc_param->vref_1_1p6v) =
|
> > +                                V1_vref_0_1p6v(cc_param->vref_0_1p6v);
> > +     else
> > +             dev_err(type_c->dev, "%s: unknown parameter_ver %d\n",
> > +                     __func__, type_c_cfg->parameter_ver);
> > +
> > +     cc_param =3D &type_c_cfg->cc2_param;
> > +     type_c->cc2_code =3D rp4pk_code(cc_param->rp_4p7k_code)
> > +                      | rp36k_code(cc_param->rp_36k_code)
> > +                      | rp12k_code(cc_param->rp_12k_code)
> > +                      | rd_code(cc_param->rd_code);
> > +
> > +     if (type_c_cfg->parameter_ver =3D=3D PARAMETER_V0)
> > +             type_c->cc2_vref =3D V0_vref_2p6v(cc_param->vref_2p6v) |
> > +                                V0_vref_1p23v(cc_param->vref_1p23v) |
> > +                                V0_vref_0p8v(cc_param->vref_0p8v) |
> > +                                V0_vref_0p66v(cc_param->vref_0p66v) |
> > +                                V0_vref_0p4v(cc_param->vref_0p4v) |
> > +                                V0_vref_0p2v(cc_param->vref_0p2v) |
> > +                                V0_vref_1_1p6v(cc_param->vref_1_1p6v) =
|
> > +                                V0_vref_0_1p6v(cc_param->vref_0_1p6v);
> > +     else if (type_c_cfg->parameter_ver =3D=3D PARAMETER_V1)
> > +             type_c->cc2_vref =3D V1_vref_2p6v(cc_param->vref_2p6v) |
> > +                                V1_vref_1p23v(cc_param->vref_1p23v) |
> > +                                V1_vref_0p8v(cc_param->vref_0p8v) |
> > +                                V1_vref_0p66v(cc_param->vref_0p66v) |
> > +                                V1_vref_0p4v(cc_param->vref_0p4v) |
> > +                                V1_vref_0p2v(cc_param->vref_0p2v) |
> > +                                V1_vref_1_1p6v(cc_param->vref_1_1p6v) =
|
> > +                                V1_vref_0_1p6v(cc_param->vref_0_1p6v);
> > +     else
> > +             dev_err(type_c->dev, "%s: unknown parameter_ver %d\n",
> > +                     __func__, type_c_cfg->parameter_ver);
> > +
> > +     type_c->debounce =3D (type_c_cfg->debounce_val << 1) | DEBOUNCE_E=
N;
> > +
> > +     return 0;
> > +}
> > +
> > +static int extcon_rtk_type_c_init(struct type_c_data *type_c)
> > +{
> > +     struct device *dev =3D type_c->dev;
> > +     unsigned long flags;
> > +     void __iomem *reg;
> > +     int val;
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +
> > +     /* set parameter */
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC1_0;
> > +     val =3D readl(reg);
> > +     val =3D (~CC_CODE_MASK & val) | (type_c->cc1_code & CC_CODE_MASK)=
;
> > +     writel(val, reg);
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC2_0;
> > +     val =3D readl(reg);
> > +     val =3D (~CC_CODE_MASK & val) | (type_c->cc2_code & CC_CODE_MASK)=
;
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC1_1;
> > +     writel(type_c->cc1_vref, reg);
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL_CC2_1;
> > +     writel(type_c->cc2_vref, reg);
> > +
> > +     reg =3D type_c->reg_base + USB_TYPEC_CTRL;
> > +     val =3D readl(reg);
> > +     val =3D (~DEBOUNCE_TIME_MASK & val) | (type_c->debounce &
> > DEBOUNCE_TIME_MASK);
> > +
> > +     dev_info(dev, "First check USB_DR_MODE_PERIPHERAL");
> > +     type_c->cc_mode =3D IN_DEVICE_MODE;
> > +     type_c->is_attach =3D IN_DETACH;
> > +     type_c->connect_change =3D CONNECT_NO_CHANGE;
> > +
> > +     detect_host(type_c);
> > +
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     schedule_delayed_work(&type_c->delayed_work, msecs_to_jiffies(0))=
;
> > +
> > +     if (!type_c->port) {
> > +             struct typec_capability typec_cap =3D { };
> > +             struct fwnode_handle *fwnode;
> > +             const char *buf;
> > +             int ret;
> > +
> > +             typec_cap.revision =3D USB_TYPEC_REV_1_0;
> > +             typec_cap.prefer_role =3D TYPEC_NO_PREFERRED_ROLE;
> > +             typec_cap.driver_data =3D type_c;
> > +             typec_cap.ops =3D &type_c_port_ops;
> > +
> > +             fwnode =3D device_get_named_child_node(dev, "connector");
> > +             if (!fwnode)
> > +                     return -EINVAL;
> > +
> > +             ret =3D fwnode_property_read_string(fwnode, "power-role",=
 &buf);
> > +             if (ret) {
> > +                     dev_err(dev, "power-role not found: %d\n", ret);
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D typec_find_port_power_role(buf);
> > +             if (ret < 0)
> > +                     return ret;
> > +             typec_cap.type =3D ret;
> > +
> > +             ret =3D fwnode_property_read_string(fwnode, "data-role", =
&buf);
> > +             if (ret) {
> > +                     dev_err(dev, "data-role not found: %d\n", ret);
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D typec_find_port_data_role(buf);
> > +             if (ret < 0)
> > +                     return ret;
> > +             typec_cap.data =3D ret;
> > +
> > +             type_c->port =3D typec_register_port(type_c->dev, &typec_=
cap);
> > +             if (IS_ERR(type_c->port))
> > +                     return PTR_ERR(type_c->port);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int extcon_rtk_type_c_edev_register(struct type_c_data *type_c)
> > +{
> > +     struct device *dev =3D type_c->dev;
> > +     int ret =3D 0;
> > +
> > +     type_c->edev =3D devm_extcon_dev_allocate(dev, usb_type_c_cable);
> > +     if (IS_ERR(type_c->edev)) {
> > +             dev_err(dev, "failed to allocate extcon device\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ret =3D devm_extcon_dev_register(dev, type_c->edev);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to register extcon device\n");
> > +             return ret;
> > +     }
> > +
> > +     extcon_set_property_capability(type_c->edev, EXTCON_USB,
> > +                                    EXTCON_PROP_USB_VBUS);
> > +     extcon_set_property_capability(type_c->edev, EXTCON_USB,
> > +                                    EXTCON_PROP_USB_TYPEC_POLARITY);
> > +     extcon_set_property_capability(type_c->edev, EXTCON_USB,
> > +                                    EXTCON_PROP_USB_SS);
> > +
> > +     extcon_set_property_capability(type_c->edev, EXTCON_USB_HOST,
> > +                                    EXTCON_PROP_USB_VBUS);
> > +     extcon_set_property_capability(type_c->edev, EXTCON_USB_HOST,
> > +                                    EXTCON_PROP_USB_TYPEC_POLARITY);
> > +     extcon_set_property_capability(type_c->edev, EXTCON_USB_HOST,
> > +                                    EXTCON_PROP_USB_SS);
> > +
> > +     return ret;
> > +}
> > +
> > +static int extcon_rtk_type_c_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct type_c_data *type_c;
> > +     const struct type_c_cfg *type_c_cfg;
> > +     int ret =3D 0;
> > +
> > +     type_c =3D devm_kzalloc(dev, sizeof(*type_c), GFP_KERNEL);
> > +     if (!type_c)
> > +             return -ENOMEM;
> > +
> > +     type_c->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(type_c->reg_base))
> > +             return PTR_ERR(type_c->reg_base);
> > +
> > +     type_c->dev =3D dev;
> > +
> > +     type_c->irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +     if (type_c->irq <=3D 0) {
> > +             dev_err(&pdev->dev, "Type C driver with no IRQ. Check %s =
setup!\n",
> > +                     dev_name(&pdev->dev));
> > +             ret =3D -ENODEV;
> > +             goto err;
> > +     }
> > +
> > +     ret =3D devm_request_irq(dev, type_c->irq, type_c_detect_irq,
> > +                            IRQF_SHARED, "type_c_detect", type_c);
> > +
> > +     spin_lock_init(&type_c->lock);
> > +
> > +     type_c->rd_ctrl_gpio_desc =3D NULL;
> > +     if (soc_device_match(rtk_soc_kylin)) {
> > +             struct gpio_desc *gpio;
> > +
> > +             gpio =3D fwnode_gpiod_get_index(of_fwnode_handle(dev->of_=
node),
> > +                                           "realtek,rd-ctrl-gpios",
> > +                                           0, GPIOD_OUT_HIGH, "rd-ctrl=
-gpio");
> > +             if (IS_ERR(gpio)) {
> > +                     dev_err(dev, "Error rd_ctrl-gpios no found (err=
=3D%d)\n",
> > +                             (int)PTR_ERR(gpio));
> > +             } else {
> > +                     type_c->rd_ctrl_gpio_desc =3D gpio;
> > +                     dev_dbg(dev, "%s get rd-ctrl-gpios (id=3D%d) OK\n=
",
> > +                             __func__, desc_to_gpio(gpio));
> > +             }
> > +     }
> > +
> > +     type_c_cfg =3D of_device_get_match_data(dev);
> > +     if (!type_c_cfg) {
> > +             dev_err(dev, "type_c config are not assigned!\n");
> > +             ret =3D -EINVAL;
> > +             goto err;
> > +     }
> > +
> > +     type_c->type_c_cfg =3D devm_kzalloc(dev, sizeof(*type_c_cfg),
> > GFP_KERNEL);
> > +
> > +     memcpy(type_c->type_c_cfg, type_c_cfg, sizeof(*type_c_cfg));
> > +
> > +     if (setup_type_c_parameter(type_c)) {
> > +             dev_err(dev, "ERROR: %s to setup type c parameter!!", __f=
unc__);
> > +             ret =3D -EINVAL;
> > +             goto err;
> > +     }
> > +
> > +     INIT_DELAYED_WORK(&type_c->delayed_work, host_device_switch);
> > +
> > +     ret =3D extcon_rtk_type_c_init(type_c);
> > +     if (ret) {
> > +             dev_err(dev, "%s failed to init type_c\n", __func__);
> > +             goto err;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, type_c);
> > +
> > +     ret =3D extcon_rtk_type_c_edev_register(type_c);
> > +
> > +     create_debug_files(type_c);
> > +
> > +     return 0;
> > +
> > +err:
> > +     dev_err(&pdev->dev, "%s: Probe fail, %d\n", __func__, ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static void extcon_rtk_type_c_remove(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct type_c_data *type_c =3D dev_get_drvdata(dev);
> > +     u32 default_ctrl;
> > +     unsigned long flags;
> > +
> > +     remove_debug_files(type_c);
> > +
> > +     if (type_c->port) {
> > +             typec_unregister_port(type_c->port);
> > +             type_c->port =3D NULL;
> > +     }
> > +
> > +     cancel_delayed_work_sync(&type_c->delayed_work);
> > +     flush_delayed_work(&type_c->delayed_work);
> > +     WARN_ON_ONCE(delayed_work_pending(&type_c->delayed_work));
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +     /* disable interrupt */
> > +     default_ctrl =3D readl(type_c->reg_base + USB_TYPEC_CTRL) &
> > +                 DEBOUNCE_TIME_MASK;
> > +     writel(default_ctrl, type_c->reg_base + USB_TYPEC_CTRL);
> > +
> > +     /* disable cc detect, rp, rd */
> > +     writel(PLR_EN, type_c->reg_base + USB_TYPEC_CTRL_CC1_0);
> > +     writel(0, type_c->reg_base + USB_TYPEC_CTRL_CC2_0);
> > +
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     if (type_c->rd_ctrl_gpio_desc)
> > +             gpiod_put(type_c->rd_ctrl_gpio_desc);
> > +     type_c->rd_ctrl_gpio_desc =3D NULL;
> > +
> > +     free_irq(type_c->irq, type_c);
> > +}
> > +
> > +static const struct type_c_cfg rtd1295_type_c_cfg =3D {
> > +     .parameter_ver =3D PARAMETER_V0,
> > +     .cc_dfp_mode =3D CC_MODE_DFP_3_0,
> > +     .cc1_param =3D { .rp_4p7k_code =3D 0xb,
> > +                    .rp_36k_code =3D 0x17,
> > +                    .rp_12k_code =3D 0x10,
> > +                    .rd_code =3D 0,
> > +                    .ra_code =3D 0,
> > +                    .vref_2p6v =3D 0x0,
> > +                    .vref_1p23v =3D 0x0,
> > +                    .vref_0p8v =3D 0x3,
> > +                    .vref_0p66v =3D 0x0,
> > +                    .vref_0p4v =3D 0x0,
> > +                    .vref_0p2v =3D 0x4,
> > +                    .vref_1_1p6v =3D 0,
> > +                    .vref_0_1p6v =3D 0 },
> > +     .cc2_param =3D { .rp_4p7k_code =3D 0xc,
> > +                    .rp_36k_code =3D 0x17,
> > +                    .rp_12k_code =3D 0x12,
> > +                    .rd_code =3D 0,
> > +                    .ra_code =3D 0,
> > +                    .vref_2p6v =3D 0x2,
> > +                    .vref_1p23v =3D 0x0,
> > +                    .vref_0p8v =3D 0x3,
> > +                    .vref_0p66v =3D 0x0,
> > +                    .vref_0p4v =3D 0x0,
> > +                    .vref_0p2v =3D 0x5,
> > +                    .vref_1_1p6v =3D 0,
> > +                    .vref_0_1p6v =3D 0 },
> > +     .debounce_val =3D 0x7f, /* 1b,1us 7f,4.7us */
> > +     .use_defalut_parameter =3D false,
> > +};
> > +
> > +static const struct type_c_cfg rtd1395_type_c_cfg =3D {
> > +     .parameter_ver =3D PARAMETER_V0,
> > +     .cc_dfp_mode =3D CC_MODE_DFP_3_0,
> > +     .cc1_param =3D { .rp_4p7k_code =3D 0xc,
> > +                    .rp_36k_code =3D 0xb,
> > +                    .rp_12k_code =3D 0xe,
> > +                    .rd_code =3D 0x10,
> > +                    .ra_code =3D 0x0,
> > +                    .vref_2p6v =3D 0x0,
> > +                    .vref_1p23v =3D 0x1,
> > +                    .vref_0p8v =3D 0x0,
> > +                    .vref_0p66v =3D 0x0,
> > +                    .vref_0p4v =3D 0x3,
> > +                    .vref_0p2v =3D 0x0,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .cc2_param =3D { .rp_4p7k_code =3D 0xb,
> > +                    .rp_36k_code =3D 0x9,
> > +                    .rp_12k_code =3D 0xe,
> > +                    .rd_code =3D 0xf,
> > +                    .ra_code =3D 0x0,
> > +                    .vref_2p6v =3D 0x1,
> > +                    .vref_1p23v =3D 0x3,
> > +                    .vref_0p8v =3D 0x3,
> > +                    .vref_0p66v =3D 0x2,
> > +                    .vref_0p4v =3D 0x3,
> > +                    .vref_0p2v =3D 0x2,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .debounce_val =3D 0x7f, /* 1b,1us 7f,4.7us */
> > +     .use_defalut_parameter =3D false,
> > +};
> > +
> > +static const struct type_c_cfg rtd1619_type_c_cfg =3D {
> > +     .parameter_ver =3D PARAMETER_V0,
> > +     .cc_dfp_mode =3D CC_MODE_DFP_3_0,
> > +     .cc1_param =3D { .rp_4p7k_code =3D 0xc,
> > +                    .rp_36k_code =3D 0xf,
> > +                    .rp_12k_code =3D 0xe,
> > +                    .rd_code =3D 0x11,
> > +                    .ra_code =3D 0x0,
> > +                    .vref_2p6v =3D 0x5,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0xa,
> > +                    .vref_0p66v =3D 0xa,
> > +                    .vref_0p4v =3D 0x3,
> > +                    .vref_0p2v =3D 0x2,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .cc2_param =3D { .rp_4p7k_code =3D 0xc,
> > +                    .rp_36k_code =3D 0xf,
> > +                    .rp_12k_code =3D 0xe,
> > +                    .rd_code =3D 0xf,
> > +                    .ra_code =3D 0x0,
> > +                    .vref_2p6v =3D 0x5,
> > +                    .vref_1p23v =3D 0x8,
> > +                    .vref_0p8v =3D 0xa,
> > +                    .vref_0p66v =3D 0xa,
> > +                    .vref_0p4v =3D 0x3,
> > +                    .vref_0p2v =3D 0x2,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .debounce_val =3D 0x7f, /* 1b,1us 7f,4.7us */
> > +     .use_defalut_parameter =3D false,
> > +};
> > +
> > +static const struct type_c_cfg rtd1319_type_c_cfg =3D {
> > +     .parameter_ver =3D PARAMETER_V0,
> > +     .cc_dfp_mode =3D CC_MODE_DFP_1_5,
> > +     .cc1_param =3D { .rp_4p7k_code =3D 0x9,
> > +                    .rp_36k_code =3D 0xe,
> > +                    .rp_12k_code =3D 0x9,
> > +                    .rd_code =3D 0x9,
> > +                    .ra_code =3D 0x7,
> > +                    .vref_2p6v =3D 0x3,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x7,
> > +                    .vref_0p66v =3D 0x6,
> > +                    .vref_0p4v =3D 0x2,
> > +                    .vref_0p2v =3D 0x3,
> > +                    .vref_1_1p6v =3D 0x4,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .cc2_param =3D { .rp_4p7k_code =3D 0x8,
> > +                    .rp_36k_code =3D 0xe,
> > +                    .rp_12k_code =3D 0x9,
> > +                    .rd_code =3D 0x9,
> > +                    .ra_code =3D 0x7,
> > +                    .vref_2p6v =3D 0x3,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x7,
> > +                    .vref_0p66v =3D 0x6,
> > +                    .vref_0p4v =3D 0x3,
> > +                    .vref_0p2v =3D 0x3,
> > +                    .vref_1_1p6v =3D 0x6,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .debounce_val =3D 0x7f, /* 1b,1us 7f,4.7us */
> > +     .use_defalut_parameter =3D false,
> > +};
> > +
> > +static const struct type_c_cfg rtd1312c_type_c_cfg =3D {
> > +     .parameter_ver =3D PARAMETER_V0,
> > +     .cc_dfp_mode =3D CC_MODE_DFP_1_5,
> > +     .cc1_param =3D { .rp_4p7k_code =3D 0xe,
> > +                    .rp_36k_code =3D 0xc,
> > +                    .rp_12k_code =3D 0xc,
> > +                    .rd_code =3D 0xa,
> > +                    .ra_code =3D 0x3,
> > +                    .vref_2p6v =3D 0xa,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x7,
> > +                    .vref_0p66v =3D 0x7,
> > +                    .vref_0p4v =3D 0x4,
> > +                    .vref_0p2v =3D 0x4,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .cc2_param =3D { .rp_4p7k_code =3D 0xe,
> > +                    .rp_36k_code =3D 0xc,
> > +                    .rp_12k_code =3D 0xc,
> > +                    .rd_code =3D 0xa,
> > +                    .ra_code =3D 0x3,
> > +                    .vref_2p6v =3D 0xa,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x7,
> > +                    .vref_0p66v =3D 0x7,
> > +                    .vref_0p4v =3D 0x4,
> > +                    .vref_0p2v =3D 0x4,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .debounce_val =3D 0x7f, /* 1b,1us 7f,4.7us */
> > +     .use_defalut_parameter =3D false,
> > +};
> > +
> > +static const struct type_c_cfg rtd1619b_type_c_cfg =3D {
> > +     .parameter_ver =3D PARAMETER_V1,
> > +     .cc_dfp_mode =3D CC_MODE_DFP_1_5,
> > +     .cc1_param =3D { .rp_4p7k_code =3D 0xf,
> > +                    .rp_36k_code =3D 0xf,
> > +                    .rp_12k_code =3D 0xf,
> > +                    .rd_code =3D 0xf,
> > +                    .ra_code =3D 0x7,
> > +                    .vref_2p6v =3D 0x9,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x9,
> > +                    .vref_0p66v =3D 0x8,
> > +                    .vref_0p4v =3D 0x7,
> > +                    .vref_0p2v =3D 0x9,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .cc2_param =3D { .rp_4p7k_code =3D 0xf,
> > +                    .rp_36k_code =3D 0xf,
> > +                    .rp_12k_code =3D 0xf,
> > +                    .rd_code =3D 0xf,
> > +                    .ra_code =3D 0x7,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x9,
> > +                    .vref_0p66v =3D 0x8,
> > +                    .vref_0p4v =3D 0x7,
> > +                    .vref_0p2v =3D 0x8,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .debounce_val =3D 0x7f, /* 1b,1us 7f,4.7us */
> > +     .use_defalut_parameter =3D false,
> > +};
> > +
> > +static const struct type_c_cfg rtd1319d_type_c_cfg =3D {
> > +     .parameter_ver =3D PARAMETER_V1,
> > +     .cc_dfp_mode =3D CC_MODE_DFP_1_5,
> > +     .cc1_param =3D { .rp_4p7k_code =3D 0xe,
> > +                    .rp_36k_code =3D 0x3,
> > +                    .rp_12k_code =3D 0xe,
> > +                    .rd_code =3D 0xf,
> > +                    .ra_code =3D 0x6,
> > +                    .vref_2p6v =3D 0x7,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x8,
> > +                    .vref_0p66v =3D 0x7,
> > +                    .vref_0p4v =3D 0x7,
> > +                    .vref_0p2v =3D 0x7,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .cc2_param =3D { .rp_4p7k_code =3D 0xe,
> > +                    .rp_36k_code =3D 0x3,
> > +                    .rp_12k_code =3D 0xe,
> > +                    .rd_code =3D 0xf,
> > +                    .ra_code =3D 0x6,
> > +                    .vref_2p6v =3D 0x7,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x8,
> > +                    .vref_0p66v =3D 0x7,
> > +                    .vref_0p4v =3D 0x7,
> > +                    .vref_0p2v =3D 0x8,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .debounce_val =3D 0x7f, /* 1b,1us 7f,4.7us */
> > +     .use_defalut_parameter =3D false,
> > +};
> > +
> > +static const struct type_c_cfg rtd1315e_type_c_cfg =3D {
> > +     .parameter_ver =3D PARAMETER_V1,
> > +     .cc_dfp_mode =3D CC_MODE_DFP_1_5,
> > +     .cc1_param =3D { .rp_4p7k_code =3D 0xe,
> > +                    .rp_36k_code =3D 0x3,
> > +                    .rp_12k_code =3D 0xe,
> > +                    .rd_code =3D 0xf,
> > +                    .ra_code =3D 0x6,
> > +                    .vref_2p6v =3D 0x7,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x8,
> > +                    .vref_0p66v =3D 0x7,
> > +                    .vref_0p4v =3D 0x7,
> > +                    .vref_0p2v =3D 0x7,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .cc2_param =3D { .rp_4p7k_code =3D 0xe,
> > +                    .rp_36k_code =3D 0x3,
> > +                    .rp_12k_code =3D 0xe,
> > +                    .rd_code =3D 0xf,
> > +                    .ra_code =3D 0x6,
> > +                    .vref_2p6v =3D 0x7,
> > +                    .vref_1p23v =3D 0x7,
> > +                    .vref_0p8v =3D 0x8,
> > +                    .vref_0p66v =3D 0x7,
> > +                    .vref_0p4v =3D 0x7,
> > +                    .vref_0p2v =3D 0x8,
> > +                    .vref_1_1p6v =3D 0x7,
> > +                    .vref_0_1p6v =3D 0x7 },
> > +     .debounce_val =3D 0x7f, /* 1b,1us 7f,4.7us */
> > +     .use_defalut_parameter =3D false,
> > +};
> > +
> > +static const struct of_device_id extcon_rtk_type_c_match[] =3D {
> > +     { .compatible =3D "realtek,rtd1295-type-c", .data =3D &rtd1295_ty=
pe_c_cfg },
> > +     { .compatible =3D "realtek,rtd1312c-type-c", .data =3D
> > &rtd1312c_type_c_cfg },
> > +     { .compatible =3D "realtek,rtd1315e-type-c", .data =3D
> > &rtd1315e_type_c_cfg },
> > +     { .compatible =3D "realtek,rtd1319-type-c", .data =3D &rtd1319_ty=
pe_c_cfg },
> > +     { .compatible =3D "realtek,rtd1319d-type-c", .data =3D
> > &rtd1319d_type_c_cfg },
> > +     { .compatible =3D "realtek,rtd1395-type-c", .data =3D &rtd1395_ty=
pe_c_cfg },
> > +     { .compatible =3D "realtek,rtd1619-type-c", .data =3D &rtd1619_ty=
pe_c_cfg },
> > +     { .compatible =3D "realtek,rtd1619b-type-c", .data =3D
> > &rtd1619b_type_c_cfg },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, extcon_rtk_type_c_match);
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int extcon_rtk_type_c_prepare(struct device *dev)
> > +{
> > +     struct type_c_data *type_c =3D dev_get_drvdata(dev);
> > +     u32 default_ctrl;
> > +     unsigned long flags;
> > +
> > +     cancel_delayed_work_sync(&type_c->delayed_work);
> > +     flush_delayed_work(&type_c->delayed_work);
> > +     WARN_ON_ONCE(delayed_work_pending(&type_c->delayed_work));
> > +
> > +     spin_lock_irqsave(&type_c->lock, flags);
> > +     /* disable interrupt */
> > +     default_ctrl =3D readl(type_c->reg_base + USB_TYPEC_CTRL) &
> > +                 DEBOUNCE_TIME_MASK;
> > +     writel(default_ctrl, type_c->reg_base + USB_TYPEC_CTRL);
> > +
> > +     /* disable cc detect, rp, rd */
> > +     writel(PLR_EN, type_c->reg_base + USB_TYPEC_CTRL_CC1_0);
> > +     writel(0, type_c->reg_base + USB_TYPEC_CTRL_CC2_0);
> > +
> > +     spin_unlock_irqrestore(&type_c->lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static void extcon_rtk_type_c_complete(struct device *dev)
> > +{
> > +     /* nothing */
> > +}
> > +
> > +static int extcon_rtk_type_c_suspend(struct device *dev)
> > +{
> > +     /* nothing */
> > +
> > +     return 0;
> > +}
> > +
> > +static int extcon_rtk_type_c_resume(struct device *dev)
> > +{
> > +     struct type_c_data *type_c =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret =3D extcon_rtk_type_c_init(type_c);
> > +     if (ret) {
> > +             dev_err(dev, "%s failed to init type_c\n", __func__);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops extcon_rtk_type_c_pm_ops =3D {
> > +     SET_LATE_SYSTEM_SLEEP_PM_OPS(extcon_rtk_type_c_suspend,
> > extcon_rtk_type_c_resume)
> > +     .prepare =3D extcon_rtk_type_c_prepare,
> > +     .complete =3D extcon_rtk_type_c_complete,
> > +};
> > +
> > +#define DEV_PM_OPS   (&extcon_rtk_type_c_pm_ops)
> > +#else
> > +#define DEV_PM_OPS   NULL
> > +#endif /* CONFIG_PM_SLEEP */
> > +
> > +static struct platform_driver extcon_rtk_type_c_driver =3D {
> > +     .probe          =3D extcon_rtk_type_c_probe,
> > +     .remove_new     =3D extcon_rtk_type_c_remove,
> > +     .driver         =3D {
> > +             .name   =3D "extcon-rtk-type_c",
> > +             .of_match_table =3D extcon_rtk_type_c_match,
> > +             .pm =3D DEV_PM_OPS,
> > +     },
> > +};
> > +
> > +module_platform_driver(extcon_rtk_type_c_driver);
> > +
> > +MODULE_DESCRIPTION("Realtek Extcon Type C driver");
> > +MODULE_AUTHOR("Stanley Chang <stanley_chang@realtek.com>");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.34.1
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
