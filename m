Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA47A458E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbjIRJJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbjIRJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:09:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865BD1B4;
        Mon, 18 Sep 2023 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695028115; x=1726564115;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0uQHwVJQ/72M+fo4Gun6LQuu5CNMkqH8cPrlkJ03Qgg=;
  b=Hku4CK9yyd1SiCf20NRTz0DN1jjI3SS7uCySHGx0ztfKcYcK8qicGF6e
   H4UqrMZStPFLgfF9ZVdYxcmsWT1Jx20STEWkI8V5LUy499wmBRD1FbGas
   KlkiuKjaUlqJIe/m5+HcH0oCl/IZYjs1U6eKGBcyGe8NxbHY7S8QkvVlT
   UZhNhmS22ygnyHmxJ6CMwI99WkeUBs8s8qWPrAEocsgM6FGBxIeun8Wpi
   2mGwnnlYjmJXT73sG/IyNju53x3xgb1h0I12/T3Y14hWY9yd6p0m4/TVW
   nhGIqXE5KVyc+kTk8SdwfAyHCwVnmqK8b1W/7MU29gGD32hGqlfV7IhGI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364647107"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364647107"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="745742708"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="745742708"
Received: from nprotaso-mobl1.ccr.corp.intel.com ([10.252.49.156])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:07:48 -0700
Date:   Mon, 18 Sep 2023 12:07:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/4] drivers/tty/serial: add driver for the ESP32 UART
In-Reply-To: <CAMo8BfJs+ToGNUCtMamU10EqpMR4PNDmJ8+4ya0jZtqTFwCEOQ@mail.gmail.com>
Message-ID: <8c524546-a6ae-ac68-bac3-f1fcc2e2f732@linux.intel.com>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com> <20230913211449.668796-3-jcmvbkbc@gmail.com> <13c43e44-aaee-c44-a32-87febd81379c@linux.intel.com> <CAMo8BfJs+ToGNUCtMamU10EqpMR4PNDmJ8+4ya0jZtqTFwCEOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1672321599-1695027504=:1832"
Content-ID: <e7c73a6f-538d-b59a-3363-469b1d98c1a@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1672321599-1695027504=:1832
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <cb6f11fd-cc9f-822b-e14b-6a647c04a2f@linux.intel.com>

On Fri, 15 Sep 2023, Max Filippov wrote:

> On Thu, Sep 14, 2023 at 6:07 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Wed, 13 Sep 2023, Max Filippov wrote:
> >
> > > Add driver for the UART controllers of the Espressif ESP32 and ESP32S3
> > > SoCs. Hardware specification is available at the following URLs:
> > >
> > >   https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf
> > >   (Chapter 13 UART Controller)
> > >   https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
> > >   (Chapter 26 UART Controller)
> > >
> > > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > > ---
> > >  drivers/tty/serial/Kconfig       |  13 +
> > >  drivers/tty/serial/Makefile      |   1 +
> > >  drivers/tty/serial/esp32_uart.c  | 766 +++++++++++++++++++++++++++++++
> > >  include/uapi/linux/serial_core.h |   3 +
> > >  4 files changed, 783 insertions(+)
> > >  create mode 100644 drivers/tty/serial/esp32_uart.c
> > >
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index bdc568a4ab66..d9ca6b268f01 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -1578,6 +1578,19 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
> > >         but you can alter that using a kernel command line option such as
> > >         "console=ttyNVTx".
> > >
> > > +config SERIAL_ESP32
> > > +     tristate "Espressif ESP32 UART support"
> > > +     depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
> > > +     select SERIAL_CORE
> > > +     select SERIAL_CORE_CONSOLE
> > > +     select SERIAL_EARLYCON
> > > +     help
> > > +       Driver for the UART controllers of the Espressif ESP32xx SoCs.
> > > +       When earlycon option is enabled the following kernel command line
> > > +       snippets may be used:
> > > +         earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
> > > +         earlycon=esp32uart,mmio32,0x3ff40000,115200n8
> > > +
> > >  endmenu
> > >
> > >  config SERIAL_MCTRL_GPIO
> > > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> > > index 138abbc89738..7b73137df7f3 100644
> > > --- a/drivers/tty/serial/Makefile
> > > +++ b/drivers/tty/serial/Makefile
> > > @@ -88,6 +88,7 @@ obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
> > >  obj-$(CONFIG_SERIAL_SIFIVE)  += sifive.o
> > >  obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
> > >  obj-$(CONFIG_SERIAL_SUNPLUS) += sunplus-uart.o
> > > +obj-$(CONFIG_SERIAL_ESP32)   += esp32_uart.o
> > >
> > >  # GPIOLIB helpers for modem control lines
> > >  obj-$(CONFIG_SERIAL_MCTRL_GPIO)      += serial_mctrl_gpio.o
> > > diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
> > > new file mode 100644
> > > index 000000000000..05ec0fce3a62
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/esp32_uart.c

> > > +static u32 esp32_uart_tx_fifo_cnt(struct uart_port *port)
> > > +{
> > > +     return (esp32_uart_read(port, UART_STATUS_REG) &
> > > +             port_variant(port)->txfifo_cnt_mask) >> UART_TXFIFO_CNT_SHIFT;
> > > +}
> > > +
> > > +static u32 esp32_uart_rx_fifo_cnt(struct uart_port *port)
> > > +{
> > > +     return (esp32_uart_read(port, UART_STATUS_REG) &
> > > +             port_variant(port)->rxfifo_cnt_mask) >> UART_RXFIFO_CNT_SHIFT;
> >
> > FIELD_GET().
> 
> I see how FIELD_GET can be used in other places, but here
> port_variant(port)->rxfifo_cnt_mask is not a runtime constant and
> FIELD_GET does not work with non-constant field definitions. Any
> suggestions?

Ah, I sorry. I probably moved around while composing the reply and it 
seems I returned to add the comment to a wrong line.

I don't have a good suggestion for this one besides breking it into 
multiple lines for better readability.

> > Use more lines (and a local variable) instead of splitting one line. It
> > will be more readable that way.
> 
> Ok.

> > > +     u32 frag = (port->uartclk * 16) / baud - div * 16;
> > > +
> > > +     if (div <= port_variant(port)->clkdiv_mask) {
> > > +             esp32_uart_write(port, UART_CLKDIV_REG,
> > > +                              div | (frag << UART_CLKDIV_FRAG_SHIFT));
> >
> > FIELD_PREP().
> 
> Ok.
> 
> > Also div be encapsulated into FIELD_PREP here even if it's
> > shift is 0.
> 
> This field's mask, port_variant(port)->clkdiv_mask, is, again, not a runtime
> constant. Any suggestion for this?

So you're saying there are two different sized fields. I suppose it can be
left as is then.

> > > +                     port->uartclk / port_variant(port)->clkdiv_mask);
> > > +             esp32_uart_write(port, UART_CLKDIV_REG,
> > > +                              port_variant(port)->clkdiv_mask |
> > > +                              UART_CLKDIV_FRAG_MASK);
> >
> > I think you want to make the meaning more obvious here by using
> > FIELD_MAX(UART_CLKDIV_FRAG_MASK);
> 
> No. I think FIELD_MAX makes it less obvious, because to work properly
> it must be not just
>   FIELD_MAX(UART_CLKDIV_FRAG),
> but
>   FIELD_PREP(UART_CLKDIV_FRAG, FIELD_MAX(UART_CLKDIV_FRAG)).

Maybe add FIELD_PREP_MAX() in a preparatory patch to bitfield.h as this 
looks something that could be of use beyond this driver.

> > > +     esp32_uart_write(port, UART_CONF0_REG, conf0);
> > > +     esp32_uart_write(port, UART_CONF1_REG, conf1);
> > > +     spin_unlock_irqrestore(&port->lock, flags);
> > > +
> > > +     /*
> > > +      * esp32s3 may not support 9600, passing its minimal baud rate
> > > +      * as the min argument would trigger a WARN inside uart_get_baud_rate
> > > +      */
> > > +     baud = uart_get_baud_rate(port, termios, old,
> > > +                               0, port->uartclk / 16);
> >
> > This looks questionable solution to the problem mentioned in the comment.
> > What happens when user asks for baudrates below the minimum supported one?
> 
> I'll change it to refuse to change to unsupported baud rate and set default
> to 115200.
>
> > You might need to do something touching the core code to handle the case
> > where 9600 is not possible fallback.
> 
> I'd rather make a fallback to 115200, as it's a much more reasonable default.

I'll have to see the code before commenting on these.

-- 
 i.
--8323329-1672321599-1695027504=:1832--
