Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09EB7A2A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbjIOWeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbjIOWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:33:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FF83;
        Fri, 15 Sep 2023 15:33:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27474c64b0bso1634263a91.3;
        Fri, 15 Sep 2023 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694817220; x=1695422020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRx5qQdl4bHcSiCZ3/Q9IwumoUw0sz6NgNPDceYoLyA=;
        b=mkULgpIFBi8eUQnPeEyCnGnCOcnZV5iAoE7yLscpr+EOl9BylL9VYPVDcKQEGuHCGh
         V2Clf1KL3Jss7nlnRUFbapBmvporcijwz3EPhKU5hljFtxHoUtXCjLUIL69kbLT3sRNk
         /q5XV9HQy/4l4ckcdoLSOH4Vbjob2hs/uD+PJApnR87nXGApdk81actPhU+Y7hwFbHk9
         rTMh3H9OUjmkBY08Acz6t1EHetfiyn/Ep33k4kwDR+oBBMCFM+vfMZXcoONcWgMZrKqd
         jWn3KqmhELwFxh7mKz/yE62YHc4xGd+hDHBNvS/CY17vYKlqdtxHVWBBYEcfs8lAVT1g
         fT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694817220; x=1695422020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRx5qQdl4bHcSiCZ3/Q9IwumoUw0sz6NgNPDceYoLyA=;
        b=Qs7kiTIfMCf68Dj7D8aC7nFNB4e5j9hQesehGpidK7oQFxYEf0Y/6qfq7jbSCA6quf
         +DboNPE0+5XTttfEL1rJ56CdYWu8zjIOCfc6cJqygWnTu2cW878l14n8apGqEOATSTjl
         DBP2D8G2AmawC3eJ5Ss63wnPiW8myj26+OeVy78rRyBTkxbPIjt54g/TdsrUr2X5jot4
         aF8j0XKMFdKTKIjeg3KpNED6MKVryBTt6CcEwrcCrXGaQZoG7XSr5EL/nX01RuayHIcr
         3QKDV1NaO4WNfoH0tODkVgHOFTcgmff0YUbf91S71WerJYgN15dkzpDYk5Ndns7ceDiw
         wHOA==
X-Gm-Message-State: AOJu0Yz2BChKtwjuxxw/HIVil09gCXNEVnCPfAVatA/wjT8/J7vor0Du
        dbKbKd3nGBUBG+Dijiy3AdKUa2cDlL2IWf4SiGI=
X-Google-Smtp-Source: AGHT+IHT4NVbZbshpSw8Wdt/w1GxkFwVhiRAH6hTJGjW+24baZJBK8tD2oK+Unrn+yWMyBPQIKm8IHwuYXqxO7MxP48=
X-Received: by 2002:a17:90a:598f:b0:268:5d00:3751 with SMTP id
 l15-20020a17090a598f00b002685d003751mr2769288pji.10.1694817219954; Fri, 15
 Sep 2023 15:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230913211449.668796-1-jcmvbkbc@gmail.com> <20230913211449.668796-3-jcmvbkbc@gmail.com>
 <13c43e44-aaee-c44-a32-87febd81379c@linux.intel.com>
In-Reply-To: <13c43e44-aaee-c44-a32-87febd81379c@linux.intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 15 Sep 2023 15:33:28 -0700
Message-ID: <CAMo8BfJs+ToGNUCtMamU10EqpMR4PNDmJ8+4ya0jZtqTFwCEOQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drivers/tty/serial: add driver for the ESP32 UART
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 6:07=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 13 Sep 2023, Max Filippov wrote:
>
> > Add driver for the UART controllers of the Espressif ESP32 and ESP32S3
> > SoCs. Hardware specification is available at the following URLs:
> >
> >   https://www.espressif.com/sites/default/files/documentation/esp32_tec=
hnical_reference_manual_en.pdf
> >   (Chapter 13 UART Controller)
> >   https://www.espressif.com/sites/default/files/documentation/esp32-s3_=
technical_reference_manual_en.pdf
> >   (Chapter 26 UART Controller)
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  drivers/tty/serial/Kconfig       |  13 +
> >  drivers/tty/serial/Makefile      |   1 +
> >  drivers/tty/serial/esp32_uart.c  | 766 +++++++++++++++++++++++++++++++
> >  include/uapi/linux/serial_core.h |   3 +
> >  4 files changed, 783 insertions(+)
> >  create mode 100644 drivers/tty/serial/esp32_uart.c
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index bdc568a4ab66..d9ca6b268f01 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1578,6 +1578,19 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
> >         but you can alter that using a kernel command line option such =
as
> >         "console=3DttyNVTx".
> >
> > +config SERIAL_ESP32
> > +     tristate "Espressif ESP32 UART support"
> > +     depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
> > +     select SERIAL_CORE
> > +     select SERIAL_CORE_CONSOLE
> > +     select SERIAL_EARLYCON
> > +     help
> > +       Driver for the UART controllers of the Espressif ESP32xx SoCs.
> > +       When earlycon option is enabled the following kernel command li=
ne
> > +       snippets may be used:
> > +         earlycon=3Desp32s3uart,mmio32,0x60000000,115200n8,40000000
> > +         earlycon=3Desp32uart,mmio32,0x3ff40000,115200n8
> > +
> >  endmenu
> >
> >  config SERIAL_MCTRL_GPIO
> > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> > index 138abbc89738..7b73137df7f3 100644
> > --- a/drivers/tty/serial/Makefile
> > +++ b/drivers/tty/serial/Makefile
> > @@ -88,6 +88,7 @@ obj-$(CONFIG_SERIAL_MILBEAUT_USIO) +=3D milbeaut_usio=
.o
> >  obj-$(CONFIG_SERIAL_SIFIVE)  +=3D sifive.o
> >  obj-$(CONFIG_SERIAL_LITEUART) +=3D liteuart.o
> >  obj-$(CONFIG_SERIAL_SUNPLUS) +=3D sunplus-uart.o
> > +obj-$(CONFIG_SERIAL_ESP32)   +=3D esp32_uart.o
> >
> >  # GPIOLIB helpers for modem control lines
> >  obj-$(CONFIG_SERIAL_MCTRL_GPIO)      +=3D serial_mctrl_gpio.o
> > diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32=
_uart.c
> > new file mode 100644
> > index 000000000000..05ec0fce3a62
> > --- /dev/null
> > +++ b/drivers/tty/serial/esp32_uart.c
> > @@ -0,0 +1,766 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <linux/clk.h>
> > +#include <linux/console.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/serial_core.h>
> > +#include <linux/slab.h>
> > +#include <linux/tty_flip.h>
> > +#include <linux/delay.h>
> > +#include <asm/serial.h>
> > +
> > +#define DRIVER_NAME  "esp32-uart"
> > +#define DEV_NAME     "ttyS"
> > +#define UART_NR              3
> > +
> > +#define ESP32_UART_TX_FIFO_SIZE      127
> > +#define ESP32_UART_RX_FIFO_SIZE      127
> > +
> > +#define UART_FIFO_REG                        0x00
> > +#define UART_INT_RAW_REG             0x04
> > +#define UART_INT_ST_REG                      0x08
> > +#define UART_INT_ENA_REG             0x0c
> > +#define UART_INT_CLR_REG             0x10
> > +#define UART_RXFIFO_FULL_INT_MASK            0x00000001
> > +#define UART_TXFIFO_EMPTY_INT_MASK           0x00000002
> > +#define UART_BRK_DET_INT_MASK                        0x00000080
>
> Use BIT() for these and do not call them MASK if they're just for a singl=
e
> flag bit.

Ok.

> > +#define UART_CLKDIV_REG                      0x14
> > +#define ESP32_UART_CLKDIV_MASK                       0x000fffff
> > +#define ESP32S3_UART_CLKDIV_MASK             0x00000fff
> > +#define UART_CLKDIV_SHIFT                    0
>
> Use GENMASK() and drop the related *_SHIFT defines as
> FIELD_GET()/FIELD_PREP() will not need it.

Ok.

> Usually _MASK postfix is just waste of screen space and provides no usefu=
l
> information so consider dropping that as well from the names.
>
> > +#define UART_CLKDIV_FRAG_MASK                        0x00f00000
> > +#define UART_CLKDIV_FRAG_SHIFT                       20
> > +#define UART_STATUS_REG                      0x1c
> > +#define ESP32_UART_RXFIFO_CNT_MASK           0x000000ff
> > +#define ESP32S3_UART_RXFIFO_CNT_MASK         0x000003ff
> > +#define UART_RXFIFO_CNT_SHIFT                        0
> > +#define UART_DSRN_MASK                               0x00002000
> > +#define UART_CTSN_MASK                               0x00004000
> > +#define ESP32_UART_TXFIFO_CNT_MASK           0x00ff0000
> > +#define ESP32S3_UART_TXFIFO_CNT_MASK         0x03ff0000
> > +#define UART_TXFIFO_CNT_SHIFT                        16
> > +#define UART_ST_UTX_OUT_MASK                 0x0f000000
> > +#define UART_ST_UTX_OUT_IDLE                 0x00000000
> > +#define UART_ST_UTX_OUT_SHIFT                        24
> > +#define UART_CONF0_REG                       0x20
> > +#define UART_PARITY_MASK                     0x00000001
> > +#define UART_PARITY_EN_MASK                  0x00000002
> > +#define UART_BIT_NUM_MASK                    0x0000000c
> > +#define UART_BIT_NUM_5                               0x00000000
> > +#define UART_BIT_NUM_6                               0x00000004
> > +#define UART_BIT_NUM_7                               0x00000008
> > +#define UART_BIT_NUM_8                               0x0000000c
> > +#define UART_STOP_BIT_NUM_MASK                       0x00000030
> > +#define UART_STOP_BIT_NUM_1                  0x00000010
> > +#define UART_STOP_BIT_NUM_2                  0x00000030
> > +#define UART_SW_RTS_MASK                     0x00000040
> > +#define UART_SW_DTR_MASK                     0x00000080
> > +#define UART_LOOPBACK_MASK                   0x00004000
> > +#define UART_TX_FLOW_EN_MASK                 0x00008000
> > +#define UART_RTS_INV_MASK                    0x00800000
> > +#define UART_DTR_INV_MASK                    0x01000000
> > +#define ESP32_UART_TICK_REF_ALWAYS_ON_MASK   0x08000000
> > +#define ESP32S3_UART_TICK_REF_ALWAYS_ON_MASK 0x00000000
> > +#define UART_CONF1_REG                       0x24
> > +#define ESP32_UART_RXFIFO_FULL_THRHD_MASK    0x0000007f
> > +#define ESP32S3_UART_RXFIFO_FULL_THRHD_MASK  0x000003ff
> > +#define UART_RXFIFO_FULL_THRHD_SHIFT         0
> > +#define ESP32_UART_TXFIFO_EMPTY_THRHD_MASK   0x00007f00
> > +#define ESP32S3_UART_TXFIFO_EMPTY_THRHD_MASK 0x000ffc00
> > +#define ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT  8
> > +#define ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT        10
> > +#define ESP32_UART_RX_FLOW_EN_MASK           0x00800000
> > +#define ESP32S3_UART_RX_FLOW_EN_MASK         0x00400000
> > +
> > +struct esp32_port {
> > +     struct uart_port port;
> > +     struct clk *clk;
> > +};
> > +
> > +struct esp32_uart_variant {
> > +     u32 clkdiv_mask;
> > +     u32 rxfifo_cnt_mask;
> > +     u32 txfifo_cnt_mask;
> > +     u32 rxfifo_full_thrhd_mask;
> > +     u32 txfifo_empty_thrhd_mask;
> > +     u32 txfifo_empty_thrhd_shift;
> > +     u32 rx_flow_en;
> > +     const char *type;
> > +};
> > +
> > +static const struct esp32_uart_variant esp32_variant =3D {
> > +     .clkdiv_mask =3D ESP32_UART_CLKDIV_MASK,
> > +     .rxfifo_cnt_mask =3D ESP32_UART_RXFIFO_CNT_MASK,
> > +     .txfifo_cnt_mask =3D ESP32_UART_TXFIFO_CNT_MASK,
> > +     .rxfifo_full_thrhd_mask =3D ESP32_UART_RXFIFO_FULL_THRHD_MASK,
> > +     .txfifo_empty_thrhd_mask =3D ESP32_UART_TXFIFO_EMPTY_THRHD_MASK,
> > +     .txfifo_empty_thrhd_shift =3D ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT=
,
> > +     .rx_flow_en =3D ESP32_UART_RX_FLOW_EN_MASK,
> > +     .type =3D "ESP32 UART",
> > +};
> > +
> > +static const struct esp32_uart_variant esp32s3_variant =3D {
> > +     .clkdiv_mask =3D ESP32S3_UART_CLKDIV_MASK,
> > +     .rxfifo_cnt_mask =3D ESP32S3_UART_RXFIFO_CNT_MASK,
> > +     .txfifo_cnt_mask =3D ESP32S3_UART_TXFIFO_CNT_MASK,
> > +     .rxfifo_full_thrhd_mask =3D ESP32S3_UART_RXFIFO_FULL_THRHD_MASK,
> > +     .txfifo_empty_thrhd_mask =3D ESP32S3_UART_TXFIFO_EMPTY_THRHD_MASK=
,
> > +     .txfifo_empty_thrhd_shift =3D ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHI=
FT,
> > +     .rx_flow_en =3D ESP32S3_UART_RX_FLOW_EN_MASK,
> > +     .type =3D "ESP32S3 UART",
> > +};
> > +
> > +static const struct of_device_id esp32_uart_dt_ids[] =3D {
> > +     {
> > +             .compatible =3D "esp,esp32-uart",
> > +             .data =3D &esp32_variant,
> > +     }, {
> > +             .compatible =3D "esp,esp32s3-uart",
> > +             .data =3D &esp32s3_variant,
> > +     }, { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, esp32_uart_dt_ids);
> > +
> > +static struct esp32_port *esp32_uart_ports[UART_NR];
> > +
> > +static const struct esp32_uart_variant *port_variant(struct uart_port =
*port)
> > +{
> > +     return port->private_data;
> > +}
> > +
> > +static void esp32_uart_write(struct uart_port *port, unsigned long reg=
, u32 v)
> > +{
> > +     writel(v, port->membase + reg);
> > +}
> > +
> > +static u32 esp32_uart_read(struct uart_port *port, unsigned long reg)
> > +{
> > +     return readl(port->membase + reg);
> > +}
> > +
> > +static u32 esp32_uart_tx_fifo_cnt(struct uart_port *port)
> > +{
> > +     return (esp32_uart_read(port, UART_STATUS_REG) &
> > +             port_variant(port)->txfifo_cnt_mask) >> UART_TXFIFO_CNT_S=
HIFT;
> > +}
> > +
> > +static u32 esp32_uart_rx_fifo_cnt(struct uart_port *port)
> > +{
> > +     return (esp32_uart_read(port, UART_STATUS_REG) &
> > +             port_variant(port)->rxfifo_cnt_mask) >> UART_RXFIFO_CNT_S=
HIFT;
>
> FIELD_GET().

I see how FIELD_GET can be used in other places, but here
port_variant(port)->rxfifo_cnt_mask is not a runtime constant and
FIELD_GET does not work with non-constant field definitions. Any
suggestions?

> Use more lines (and a local variable) instead of splitting one line. It
> will be more readable that way.

Ok.

> > +}
> > +
> > +/* return TIOCSER_TEMT when transmitter is not busy */
> > +static unsigned int esp32_uart_tx_empty(struct uart_port *port)
> > +{
> > +     u32 status =3D esp32_uart_read(port, UART_STATUS_REG) &
> > +             (port_variant(port)->txfifo_cnt_mask | UART_ST_UTX_OUT_MA=
SK);
>
> Ditto.
>
> > +
> > +     pr_debug("%s: %08x\n", __func__, status);
> > +     return status =3D=3D UART_ST_UTX_OUT_IDLE ? TIOCSER_TEMT : 0;
> > +}
> > +
> > +static void esp32_uart_set_mctrl(struct uart_port *port, unsigned int =
mctrl)
> > +{
> > +     u32 conf0 =3D esp32_uart_read(port, UART_CONF0_REG) &
> > +             ~(UART_LOOPBACK_MASK |
> > +               UART_SW_RTS_MASK | UART_RTS_INV_MASK |
> > +               UART_SW_DTR_MASK | UART_DTR_INV_MASK);
>
> Ditto.

Ok.

> > +     if (mctrl & TIOCM_RTS)
> > +             conf0 |=3D UART_SW_RTS_MASK;
> > +     if (mctrl & TIOCM_DTR)
> > +             conf0 |=3D UART_SW_DTR_MASK;
> > +     if (mctrl & TIOCM_LOOP)
> > +             conf0 |=3D UART_LOOPBACK_MASK;
> > +
> > +     esp32_uart_write(port, UART_CONF0_REG, conf0);
> > +}
> > +
> > +static unsigned int esp32_uart_get_mctrl(struct uart_port *port)
> > +{
> > +     u32 status =3D esp32_uart_read(port, UART_STATUS_REG);
> > +     unsigned int ret =3D TIOCM_CAR;
> > +
> > +     if (status & UART_DSRN_MASK)
> > +             ret |=3D TIOCM_DSR;
> > +     if (status & UART_CTSN_MASK)
> > +             ret |=3D TIOCM_CTS;
> > +
> > +     return ret;
> > +}
> > +
> > +static void esp32_uart_stop_tx(struct uart_port *port)
> > +{
> > +     u32 int_ena;
> > +
> > +     int_ena =3D esp32_uart_read(port, UART_INT_ENA_REG);
>
>         int_ena &=3D ~UART_TXFIFO_EMPTY_INT_MASK;
>
> > +     esp32_uart_write(port, UART_INT_ENA_REG,
> > +                      int_ena & ~UART_TXFIFO_EMPTY_INT_MASK);
>
> Just int_ena is enough after adding the logic op on its own line.

Ok.

> > +}
> > +
> > +static void esp32_uart_rxint(struct uart_port *port)
> > +{
> > +     struct tty_port *tty_port =3D &port->state->port;
> > +     u32 rx_fifo_cnt =3D esp32_uart_rx_fifo_cnt(port);
> > +     unsigned long flags;
> > +     u32 i;
> > +
> > +     if (!rx_fifo_cnt)
> > +             return;
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +
> > +     for (i =3D 0; i < rx_fifo_cnt; ++i) {
> > +             u32 rx =3D esp32_uart_read(port, UART_FIFO_REG);
> > +             u32 brk =3D 0;
> > +
> > +             ++port->icount.rx;
> > +
> > +             if (!rx) {
> > +                     brk =3D esp32_uart_read(port, UART_INT_ST_REG) &
> > +                             UART_BRK_DET_INT_MASK;
> > +             }
> > +             if (brk) {
> > +                     esp32_uart_write(port, UART_INT_CLR_REG, brk);
> > +                     ++port->icount.brk;
> > +                     uart_handle_break(port);
> > +             } else {
> > +                     if (uart_handle_sysrq_char(port, (unsigned char)r=
x))
> > +                             continue;
> > +                     tty_insert_flip_char(tty_port, rx, TTY_NORMAL);
> > +             }
> > +     }
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +     tty_flip_buffer_push(tty_port);
> > +}
> > +
> > +static void esp32_uart_put_char(struct uart_port *port, unsigned char =
c)
> > +{
> > +     esp32_uart_write(port, UART_FIFO_REG, c);
> > +}
> > +
> > +static void esp32_uart_put_char_sync(struct uart_port *port, unsigned =
char c)
> > +{
> > +     while (esp32_uart_tx_fifo_cnt(port) >=3D ESP32_UART_TX_FIFO_SIZE)
> > +             cpu_relax();
> > +     esp32_uart_put_char(port, c);
> > +}
> > +
> > +static void esp32_uart_transmit_buffer(struct uart_port *port)
> > +{
> > +     struct circ_buf *xmit =3D &port->state->xmit;
> > +     u32 tx_fifo_used =3D esp32_uart_tx_fifo_cnt(port);
> > +
> > +     while (!uart_circ_empty(xmit) && tx_fifo_used < ESP32_UART_TX_FIF=
O_SIZE) {
> > +             esp32_uart_put_char(port, xmit->buf[xmit->tail]);
> > +             xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> > +             port->icount.tx++;
> > +             ++tx_fifo_used;
> > +     }
> > +
> > +     if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > +             uart_write_wakeup(port);
>
> Too much open-coding here. Please use the helpers (likely the ones which
> replace the whole tx loop + its common surrounding code).

Ok.

> > +     if (uart_circ_empty(xmit)) {
> > +             esp32_uart_stop_tx(port);
> > +     } else {
> > +             u32 int_ena;
> > +
> > +             int_ena =3D esp32_uart_read(port, UART_INT_ENA_REG);
> > +             esp32_uart_write(port, UART_INT_ENA_REG,
> > +                              int_ena | UART_TXFIFO_EMPTY_INT_MASK);
>
> Own line for logic op.

Ok.

> > +     }
> > +}
> > +
> > +static void esp32_uart_txint(struct uart_port *port)
> > +{
> > +     esp32_uart_transmit_buffer(port);
> > +}
> > +
> > +static irqreturn_t esp32_uart_int(int irq, void *dev_id)
> > +{
> > +     struct uart_port *port =3D dev_id;
> > +     u32 status;
> > +
> > +     status =3D esp32_uart_read(port, UART_INT_ST_REG);
> > +
> > +     if (status & (UART_RXFIFO_FULL_INT_MASK | UART_BRK_DET_INT_MASK))
> > +             esp32_uart_rxint(port);
> > +     if (status & UART_TXFIFO_EMPTY_INT_MASK)
> > +             esp32_uart_txint(port);
> > +
> > +     esp32_uart_write(port, UART_INT_CLR_REG, status);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void esp32_uart_start_tx(struct uart_port *port)
> > +{
> > +     esp32_uart_transmit_buffer(port);
> > +}
> > +
> > +static void esp32_uart_stop_rx(struct uart_port *port)
> > +{
> > +     u32 int_ena;
> > +
> > +     int_ena =3D esp32_uart_read(port, UART_INT_ENA_REG);
> > +     esp32_uart_write(port, UART_INT_ENA_REG,
> > +                      int_ena & ~UART_RXFIFO_FULL_INT_MASK);
>
> Ditto.

Ok.

> > +}
> > +
> > +static int esp32_uart_startup(struct uart_port *port)
> > +{
> > +     int ret =3D 0;
> > +     unsigned long flags;
> > +     struct esp32_port *sport =3D container_of(port, struct esp32_port=
, port);
> > +
> > +     ret =3D clk_prepare_enable(sport->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +     esp32_uart_write(port, UART_CONF1_REG,
> > +                      (1 << UART_RXFIFO_FULL_THRHD_SHIFT) |
>
> Use FIELD_PREP()
>
> > +                      (1 << port_variant(port)->txfifo_empty_thrhd_shi=
ft));
> > +     esp32_uart_write(port, UART_INT_CLR_REG,
> > +                      UART_RXFIFO_FULL_INT_MASK |
> > +                      UART_BRK_DET_INT_MASK);
>
> This fits to two lines (well one too, especially if you remove those
> _MASK postfixes).

Ok.

> > +     esp32_uart_write(port, UART_INT_ENA_REG,
> > +                      UART_RXFIFO_FULL_INT_MASK |
> > +                      UART_BRK_DET_INT_MASK);
>
> Ditto.

Ok.

> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +     ret =3D devm_request_irq(port->dev, port->irq, esp32_uart_int, 0,
> > +                            DRIVER_NAME, port);
> > +
> > +     pr_debug("%s, request_irq: %d, conf1 =3D %08x, int_st =3D %08x, s=
tatus =3D %08x\n",
> > +              __func__, ret,
> > +              esp32_uart_read(port, UART_CONF1_REG),
> > +              esp32_uart_read(port, UART_INT_ST_REG),
> > +              esp32_uart_read(port, UART_STATUS_REG));
> > +     return ret;
> > +}
> > +
> > +static void esp32_uart_shutdown(struct uart_port *port)
> > +{
> > +     struct esp32_port *sport =3D container_of(port, struct esp32_port=
, port);
> > +
> > +     esp32_uart_write(port, UART_INT_ENA_REG, 0);
> > +     devm_free_irq(port->dev, port->irq, port);
> > +     clk_disable_unprepare(sport->clk);
> > +}
> > +
> > +static void esp32_uart_set_baud(struct uart_port *port, u32 baud)
> > +{
> > +     u32 div =3D port->uartclk / baud;
> > +     u32 frag =3D (port->uartclk * 16) / baud - div * 16;
> > +
> > +     if (div <=3D port_variant(port)->clkdiv_mask) {
> > +             esp32_uart_write(port, UART_CLKDIV_REG,
> > +                              div | (frag << UART_CLKDIV_FRAG_SHIFT));
>
> FIELD_PREP().

Ok.

> Also div be encapsulated into FIELD_PREP here even if it's
> shift is 0.

This field's mask, port_variant(port)->clkdiv_mask, is, again, not a runtim=
e
constant. Any suggestion for this?

> > +     } else {
> > +             dev_warn(port->dev,
> > +                      "%s: %d baud is out of reach, setting %d\n",
> > +                     __func__, baud,
>
> Don't print __func__.

Ok.

> > +                     port->uartclk / port_variant(port)->clkdiv_mask);
> > +             esp32_uart_write(port, UART_CLKDIV_REG,
> > +                              port_variant(port)->clkdiv_mask |
> > +                              UART_CLKDIV_FRAG_MASK);
>
> I think you want to make the meaning more obvious here by using
> FIELD_MAX(UART_CLKDIV_FRAG_MASK);

No. I think FIELD_MAX makes it less obvious, because to work properly
it must be not just
  FIELD_MAX(UART_CLKDIV_FRAG),
but
  FIELD_PREP(UART_CLKDIV_FRAG, FIELD_MAX(UART_CLKDIV_FRAG)).

> > +     }
> > +}
> > +
> > +static void esp32_uart_set_termios(struct uart_port *port,
> > +                                struct ktermios *termios,
> > +                                const struct ktermios *old)
> > +{
> > +     unsigned long flags;
> > +     u32 conf0, conf1;
> > +     u32 baud;
> > +     const u32 rx_flow_en =3D port_variant(port)->rx_flow_en;
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +     conf0 =3D esp32_uart_read(port, UART_CONF0_REG) &
> > +             ~(UART_PARITY_EN_MASK | UART_PARITY_MASK |
> > +               UART_BIT_NUM_MASK | UART_STOP_BIT_NUM_MASK);
> > +     conf1 =3D esp32_uart_read(port, UART_CONF1_REG) &
> > +             ~rx_flow_en;
>
> Split logic to oen lines please.

Ok.

> > +
> > +     if (termios->c_cflag & PARENB) {
> > +             conf0 |=3D UART_PARITY_EN_MASK;
> > +             if (termios->c_cflag & PARODD)
> > +                     conf0 |=3D UART_PARITY_MASK;
> > +     }
> > +
> > +     switch (termios->c_cflag & CSIZE) {
> > +     case CS5:
> > +             conf0 |=3D UART_BIT_NUM_5;
> > +             break;
> > +     case CS6:
> > +             conf0 |=3D UART_BIT_NUM_6;
> > +             break;
> > +     case CS7:
> > +             conf0 |=3D UART_BIT_NUM_7;
> > +             break;
> > +     case CS8:
> > +             conf0 |=3D UART_BIT_NUM_8;
> > +             break;
> > +     }
> > +
> > +     if (termios->c_cflag & CSTOPB)
> > +             conf0 |=3D UART_STOP_BIT_NUM_2;
> > +     else
> > +             conf0 |=3D UART_STOP_BIT_NUM_1;
> > +
> > +     if (termios->c_cflag & CRTSCTS)
> > +             conf1 |=3D rx_flow_en;
>
> If you don't support some bits, you should clear them (CMSPAR).

Ok.

> > +     esp32_uart_write(port, UART_CONF0_REG, conf0);
> > +     esp32_uart_write(port, UART_CONF1_REG, conf1);
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +     /*
> > +      * esp32s3 may not support 9600, passing its minimal baud rate
> > +      * as the min argument would trigger a WARN inside uart_get_baud_=
rate
> > +      */
> > +     baud =3D uart_get_baud_rate(port, termios, old,
> > +                               0, port->uartclk / 16);
>
> This looks questionable solution to the problem mentioned in the comment.
> What happens when user asks for baudrates below the minimum supported one=
?

I'll change it to refuse to change to unsupported baud rate and set default
to 115200.

> You might need to do something touching the core code to handle the case
> where 9600 is not possible fallback.

I'd rather make a fallback to 115200, as it's a much more reasonable defaul=
t.

> > +     if (baud)
> > +             esp32_uart_set_baud(port, baud);
> > +}
>
> set_termios() function lacks call to uart_update_timeout().

Fixed.

> > +
> > +static const char *esp32_uart_type(struct uart_port *port)
> > +{
> > +     return port_variant(port)->type;
> > +}
> > +
> > +static void esp32_uart_release_port(struct uart_port *port)
> > +{
> > +}
> > +
> > +static int esp32_uart_request_port(struct uart_port *port)
> > +{
> > +     return 0;
> > +}
> > +
> > +/* configure/auto-configure the port */
> > +static void esp32_uart_config_port(struct uart_port *port, int flags)
> > +{
> > +     if (flags & UART_CONFIG_TYPE)
> > +             port->type =3D PORT_ESP32UART;
> > +}
> > +
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int esp32_uart_poll_init(struct uart_port *port)
> > +{
> > +     struct esp32_port *sport =3D container_of(port, struct esp32_port=
, port);
> > +
> > +     return clk_prepare_enable(sport->clk);
> > +}
> > +
> > +static void esp32_uart_poll_put_char(struct uart_port *port, unsigned =
char c)
> > +{
> > +     esp32_uart_put_char_sync(port, c);
> > +}
> > +
> > +static int esp32_uart_poll_get_char(struct uart_port *port)
> > +{
> > +     if (esp32_uart_rx_fifo_cnt(port))
> > +             return esp32_uart_read(port, UART_FIFO_REG);
> > +     else
> > +             return NO_POLL_CHAR;
> > +
> > +}
> > +#endif
> > +
> > +static const struct uart_ops esp32_uart_pops =3D {
> > +     .tx_empty       =3D esp32_uart_tx_empty,
> > +     .set_mctrl      =3D esp32_uart_set_mctrl,
> > +     .get_mctrl      =3D esp32_uart_get_mctrl,
> > +     .stop_tx        =3D esp32_uart_stop_tx,
> > +     .start_tx       =3D esp32_uart_start_tx,
> > +     .stop_rx        =3D esp32_uart_stop_rx,
> > +     .startup        =3D esp32_uart_startup,
> > +     .shutdown       =3D esp32_uart_shutdown,
> > +     .set_termios    =3D esp32_uart_set_termios,
> > +     .type           =3D esp32_uart_type,
> > +     .release_port   =3D esp32_uart_release_port,
> > +     .request_port   =3D esp32_uart_request_port,
> > +     .config_port    =3D esp32_uart_config_port,
> > +#ifdef CONFIG_CONSOLE_POLL
> > +     .poll_init      =3D esp32_uart_poll_init,
> > +     .poll_put_char  =3D esp32_uart_poll_put_char,
> > +     .poll_get_char  =3D esp32_uart_poll_get_char,
> > +#endif
> > +};
> > +
> > +static void esp32_uart_console_putchar(struct uart_port *port, unsigne=
d char c)
> > +{
> > +     esp32_uart_put_char_sync(port, c);
> > +}
> > +
> > +static void esp32_uart_string_write(struct uart_port *port, const char=
 *s,
> > +                                 unsigned int count)
> > +{
> > +     uart_console_write(port, s, count, esp32_uart_console_putchar);
> > +}
> > +
> > +static void
> > +esp32_uart_console_write(struct console *co, const char *s, unsigned i=
nt count)
> > +{
> > +     struct esp32_port *sport =3D esp32_uart_ports[co->index];
> > +     struct uart_port *port =3D &sport->port;
> > +     unsigned long flags;
> > +     int locked =3D 1;
> > +
> > +     if (port->sysrq)
> > +             locked =3D 0;
> > +     else if (oops_in_progress)
> > +             locked =3D spin_trylock_irqsave(&port->lock, flags);
> > +     else
> > +             spin_lock_irqsave(&port->lock, flags);
> > +
> > +     esp32_uart_string_write(port, s, count);
> > +
> > +     if (locked)
> > +             spin_unlock_irqrestore(&port->lock, flags);
> > +}
> > +
> > +static int __init esp32_uart_console_setup(struct console *co, char *o=
ptions)
> > +{
> > +     struct esp32_port *sport;
> > +     int baud =3D 115200;
> > +     int bits =3D 8;
> > +     int parity =3D 'n';
> > +     int flow =3D 'n';
> > +     int ret;
>
> This lacks newline after declarations.

Ok.

> > +     /*
> > +      * check whether an invalid uart number has been specified, and
> > +      * if so, search for the first available port that does have
> > +      * console support.
> > +      */
> > +     if (co->index =3D=3D -1 || co->index >=3D ARRAY_SIZE(esp32_uart_p=
orts))
> > +             co->index =3D 0;
> > +
> > +     sport =3D esp32_uart_ports[co->index];
> > +     if (!sport)
> > +             return -ENODEV;
> > +
> > +     ret =3D clk_prepare_enable(sport->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (options)
> > +             uart_parse_options(options, &baud, &parity, &bits, &flow)=
;
> > +
> > +     return uart_set_options(&sport->port, co, baud, parity, bits, flo=
w);
> > +}
> > +
> > +static int esp32_uart_console_exit(struct console *co)
> > +{
> > +     struct esp32_port *sport =3D esp32_uart_ports[co->index];
> > +
> > +     clk_disable_unprepare(sport->clk);
> > +     return 0;
> > +}
> > +
> > +static struct uart_driver esp32_uart_reg;
> > +static struct console esp32_uart_console =3D {
> > +     .name           =3D DEV_NAME,
> > +     .write          =3D esp32_uart_console_write,
> > +     .device         =3D uart_console_device,
> > +     .setup          =3D esp32_uart_console_setup,
> > +     .exit           =3D esp32_uart_console_exit,
> > +     .flags          =3D CON_PRINTBUFFER,
> > +     .index          =3D -1,
> > +     .data           =3D &esp32_uart_reg,
> > +};
> > +
> > +static void esp32_uart_earlycon_putchar(struct uart_port *port, unsign=
ed char c)
> > +{
> > +     esp32_uart_put_char_sync(port, c);
> > +}
> > +
> > +static void esp32_uart_earlycon_write(struct console *con, const char =
*s,
> > +                                   unsigned int n)
> > +{
> > +     struct earlycon_device *dev =3D con->data;
> > +
> > +     uart_console_write(&dev->port, s, n, esp32_uart_earlycon_putchar)=
;
> > +}
> > +
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int esp32_uart_earlycon_read(struct console *con, char *s, unsi=
gned int n)
> > +{
> > +     struct earlycon_device *dev =3D con->data;
> > +     int num_read =3D 0;
> > +
> > +     while (num_read < n) {
> > +             int c =3D esp32_uart_poll_get_char(&dev->port);
> > +
> > +             if (c =3D=3D NO_POLL_CHAR)
> > +                     break;
> > +             s[num_read++] =3D c;
> > +     }
> > +     return num_read;
> > +}
> > +#endif
> > +
> > +static int __init esp32xx_uart_early_console_setup(struct earlycon_dev=
ice *device,
> > +                                                const char *options)
> > +{
> > +     if (!device->port.membase)
> > +             return -ENODEV;
> > +
> > +     device->con->write =3D esp32_uart_earlycon_write;
> > +#ifdef CONFIG_CONSOLE_POLL
> > +     device->con->read =3D esp32_uart_earlycon_read;
> > +#endif
> > +     if (device->port.uartclk !=3D BASE_BAUD * 16)
> > +             esp32_uart_set_baud(&device->port, device->baud);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init esp32_uart_early_console_setup(struct earlycon_devic=
e *device,
> > +                                              const char *options)
> > +{
> > +     device->port.private_data =3D (void *)&esp32_variant;
> > +     return esp32xx_uart_early_console_setup(device, options);
> > +}
> > +
> > +OF_EARLYCON_DECLARE(esp32uart, "esp,esp32-uart",
> > +                 esp32_uart_early_console_setup);
> > +
> > +static int __init esp32s3_uart_early_console_setup(struct earlycon_dev=
ice *device,
> > +                                                const char *options)
> > +{
> > +     device->port.private_data =3D (void *)&esp32s3_variant;
> > +     return esp32xx_uart_early_console_setup(device, options);
> > +}
> > +
> > +OF_EARLYCON_DECLARE(esp32s3uart, "esp,esp32s3-uart",
> > +                 esp32s3_uart_early_console_setup);
> > +
> > +static struct uart_driver esp32_uart_reg =3D {
> > +     .owner          =3D THIS_MODULE,
> > +     .driver_name    =3D DRIVER_NAME,
> > +     .dev_name       =3D DEV_NAME,
> > +     .nr             =3D ARRAY_SIZE(esp32_uart_ports),
> > +     .cons           =3D &esp32_uart_console,
> > +};
> > +
> > +static int esp32_uart_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *np =3D pdev->dev.of_node;
> > +     static const struct of_device_id *match;
> > +     struct uart_port *port;
> > +     struct esp32_port *sport;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     match =3D of_match_device(esp32_uart_dt_ids, &pdev->dev);
> > +     if (!match)
> > +             return -ENODEV;
> > +
> > +     sport =3D devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> > +     if (!sport)
> > +             return -ENOMEM;
> > +
> > +     port =3D &sport->port;
> > +
> > +     ret =3D of_alias_get_id(np, "serial");
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "failed to get alias id, errno %d\n",=
 ret);
> > +             return ret;
> > +     }
> > +     if (ret >=3D UART_NR) {
> > +             dev_err(&pdev->dev, "driver limited to %d serial ports\n"=
,
> > +                     UART_NR);
>
> One line.

Ok.

> > +             return -ENOMEM;
> > +     }
> > +
> > +     port->line =3D ret;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> > +             return -ENODEV;
> > +
> > +     port->mapbase =3D res->start;
> > +     port->membase =3D devm_ioremap_resource(&pdev->dev, res);
> > +     if (IS_ERR(port->membase))
> > +             return PTR_ERR(port->membase);
> > +
> > +     sport->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(sport->clk))
> > +             return PTR_ERR(sport->clk);
> > +
> > +     port->uartclk =3D clk_get_rate(sport->clk);
> > +     port->dev =3D &pdev->dev;
> > +     port->type =3D PORT_ESP32UART;
> > +     port->iotype =3D UPIO_MEM;
> > +     port->irq =3D platform_get_irq(pdev, 0);
> > +     port->ops =3D &esp32_uart_pops;
> > +     port->flags =3D UPF_BOOT_AUTOCONF;
> > +     port->has_sysrq =3D 1;
> > +     port->fifosize =3D ESP32_UART_TX_FIFO_SIZE;
> > +     port->private_data =3D (void *)match->data;
> > +
> > +     esp32_uart_ports[port->line] =3D sport;
> > +
> > +     platform_set_drvdata(pdev, port);
> > +
> > +     ret =3D uart_add_one_port(&esp32_uart_reg, port);
> > +     return ret;
> > +}
> > +
> > +static int esp32_uart_remove(struct platform_device *pdev)
> > +{
> > +     struct uart_port *port =3D platform_get_drvdata(pdev);
> > +
> > +     uart_remove_one_port(&esp32_uart_reg, port);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +static struct platform_driver esp32_uart_driver =3D {
> > +     .probe          =3D esp32_uart_probe,
> > +     .remove         =3D esp32_uart_remove,
> > +     .driver         =3D {
> > +             .name   =3D DRIVER_NAME,
> > +             .of_match_table =3D esp32_uart_dt_ids,
> > +     },
> > +};
> > +
> > +static int __init esp32_uart_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D uart_register_driver(&esp32_uart_reg);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D platform_driver_register(&esp32_uart_driver);
> > +     if (ret)
> > +             uart_unregister_driver(&esp32_uart_reg);
> > +
> > +     return ret;
> > +}
> > +
> > +static void __exit esp32_uart_exit(void)
> > +{
> > +     platform_driver_unregister(&esp32_uart_driver);
> > +     uart_unregister_driver(&esp32_uart_reg);
> > +}
> > +
> > +module_init(esp32_uart_init);
> > +module_exit(esp32_uart_exit);
> > +
> > +MODULE_DESCRIPTION("Espressif ESP32 UART driver.");
>
> Drop .

Ok.

> > +MODULE_AUTHOR("Max Filippov <jcmvbkbc@gmail.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/seri=
al_core.h
> > index add349889d0a..ff076d6be159 100644
> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -245,4 +245,7 @@
> >  /* Sunplus UART */
> >  #define PORT_SUNPLUS 123
> >
> > +/* Espressif ESP32 UART */
> > +#define PORT_ESP32UART       124
> > +
> >  #endif /* _UAPILINUX_SERIAL_CORE_H */
> >
>
> --
>  i.
>


--=20
Thanks.
-- Max
