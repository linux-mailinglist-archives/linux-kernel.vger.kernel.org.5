Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA047A75F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjITIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjITIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:35:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3062490;
        Wed, 20 Sep 2023 01:35:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d9cda925so581603b3a.3;
        Wed, 20 Sep 2023 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695198903; x=1695803703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Cw5RLtuR6MUi2AqwYhrHqkcuj+VYMHVRI2Q7Xa0oU=;
        b=KoObuXuXfMPfOkTjHLkeQ0deSZd3Dall/2IRCD7bWiPl8gIe2p3xOuFWYcgOsuongT
         t9kYBw0ts7TSzaZSHHk7eUuUNDWSpXEEgSjMlAi5D6V1zXWQTuZxTBroR8u/td3L/1ML
         /uNe+e19QpuK4uMdbHDqmv4tp3cQUVmko8oZMjBXy2huTl9gIGheaKQlSdRld9UwRGLU
         SRYdxORnBBcap2rlRNt/dzqPeD0jpMcUaAihMjHly+Dh2iGCRnbwq88dw07ZJ9qSKr4T
         B3VCe0RDsFunlAWwvEQOIAbxQHu82ZUQ6E2/NqbsM2oSIB5dXJjdMxQkMlLNhGTvf/HZ
         ft7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695198903; x=1695803703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4Cw5RLtuR6MUi2AqwYhrHqkcuj+VYMHVRI2Q7Xa0oU=;
        b=rteA/R6db/FNu09ra/Kdx1mVb1FefQi4i2FlhZEud2LvF/TSdTwk3wLTGmEF+IA9Eh
         T0FcRAuQ6Ab6bm33PHOCy8lH7iKHTseEIIW7EaPUvO2qsYjH4tV++zEfQnSyg+izr51r
         1H9pdoMhu0iyXqpAU/gUqXi7zZW6lRAeSf+yL2gjtVldDjsPJVePsJd+vm9khsuEfECp
         /qWlfLHY/LRYiMZIFwvUICSAuhn3ZkNIZjjsuoHYgZo30A0Ma6JwciwYd6YOvcFhHmpi
         Qsx7QF7I4nI8k1tFmbnRrqGOGhC3ZgPLOHFZd/5aTu7vtbCvkI2igLoNSr4nlhpO1dEa
         qa8w==
X-Gm-Message-State: AOJu0YxfCF1C53NkyjzigieWp7Q6cjSJapRQPmwJ4PqGz5edN3avX2Uv
        iwAUKdNHEarcUCzNnOTkLrquZ/L0VsAgA5dpdlc=
X-Google-Smtp-Source: AGHT+IFNYidjkC/qGx/wpQ3x0z7DxI0RKhFDK9yrPa/crVomNjqCqBzC6vfCS6gGH/RZanEuKHna7434p0fViXzViYs=
X-Received: by 2002:a05:6a20:6a06:b0:159:b7ba:74bd with SMTP id
 p6-20020a056a206a0600b00159b7ba74bdmr1955661pzk.50.1695198903513; Wed, 20 Sep
 2023 01:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com> <20230920022644.2712651-4-jcmvbkbc@gmail.com>
 <553a8dbd-08b9-488a-a024-f89697908b41@kernel.org>
In-Reply-To: <553a8dbd-08b9-488a-a024-f89697908b41@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 20 Sep 2023 01:34:51 -0700
Message-ID: <CAMo8Bf+_3Gv67iPfVd7JAG6Zw1WKr-9VRciaASRkHiRhXQkpRQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drivers/tty/serial: add driver for the ESP32 UART
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:22=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 20. 09. 23, 4:26, Max Filippov wrote:
> > Add driver for the UART controllers of the Espressif ESP32 and ESP32S3
> > SoCs. Hardware specification is available at the following URLs:
> ...
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
>
> Should yuou increment this only in case of insert_flip_char()?

I don't know. Does port->icount.rx have clearly defined semantics?
I've looked through multiple other serial drivers and there's a lot of
examples of similar pattern.

> > +             if (!rx) {
> > +                     brk =3D esp32_uart_read(port, UART_INT_ST_REG) &
> > +                             UART_BRK_DET_INT;
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
>
> This is heavy. Is it equivalent to:
> if (!rx && esp32_uart_read(port, UART_INT_ST_REG) &
>      UART_BRK_DET_INT) {
>    esp32_uart_write(port, UART_INT_CLR_REG, brk);
>    ++port->icount.brk;
>    uart_handle_break(port);
>    continue;
> }
>
> if (uart_handle_sysrq_char(port, (unsigned char)rx))
>    continue;
>
> tty_insert_flip_char(tty_port, rx, TTY_NORMAL);
>
> ?

It is equivalent, but I find the version that I used somewhat easier to rea=
d.
Maybe this:

               if (!rx &&
                   (esp32_uart_read(port, UART_INT_ST_REG) &
UART_BRK_DET_INT)) {
                       esp32_uart_write(port, UART_INT_CLR_REG, brk);
                       ++port->icount.brk;
                       uart_handle_break(port);
               } else {
                       if (uart_handle_sysrq_char(port, (unsigned char)rx))
                               continue;
                       tty_insert_flip_char(tty_port, rx, TTY_NORMAL);
               }

?

> > +     }
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +     tty_flip_buffer_push(tty_port);
> > +}
> ...
> > +static void esp32_uart_put_char_sync(struct uart_port *port, u8 c)
> > +{
> > +     unsigned long timeout;
> > +
> > +     timeout =3D jiffies + msecs_to_jiffies(1000);
>
> I.e. plus HZ?

Yes, ok.

> > +     while (esp32_uart_tx_fifo_cnt(port) >=3D ESP32_UART_TX_FIFO_SIZE)=
 {
> > +             if (time_after(jiffies, timeout)) {
> > +                     dev_warn(port->dev, "timeout waiting for TX FIFO\=
n");
> > +                     return;
> > +             }
> > +             cpu_relax();
> > +     }
> > +     esp32_uart_put_char(port, c);
> > +}
> > +
> > +static void esp32_uart_transmit_buffer(struct uart_port *port)
> > +{
> > +     u32 tx_fifo_used =3D esp32_uart_tx_fifo_cnt(port);
> > +
> > +     if (tx_fifo_used < ESP32_UART_TX_FIFO_SIZE) {
>
> Invert the condition and return here?

Ok.

> > +             unsigned int pending;
> > +             u8 ch;
> > +
> > +             pending =3D uart_port_tx_limited(port, ch,
> > +                                            ESP32_UART_TX_FIFO_SIZE - =
tx_fifo_used,
> > +                                            true, esp32_uart_put_char(=
port, ch),
> > +                                            ({}));
> > +             if (pending) {
> > +                     u32 int_ena;
> > +
> > +                     int_ena =3D esp32_uart_read(port, UART_INT_ENA_RE=
G);
> > +                     int_ena |=3D UART_TXFIFO_EMPTY_INT;
> > +                     esp32_uart_write(port, UART_INT_ENA_REG, int_ena)=
;
> > +             }
> > +     }
> > +}
>
>
> > +static irqreturn_t esp32_uart_int(int irq, void *dev_id)
> > +{
> > +     struct uart_port *port =3D dev_id;
> > +     u32 status;
> > +
> > +     status =3D esp32_uart_read(port, UART_INT_ST_REG);
> > +
> > +     if (status & (UART_RXFIFO_FULL_INT | UART_BRK_DET_INT))
> > +             esp32_uart_rxint(port);
> > +     if (status & UART_TXFIFO_EMPTY_INT)
> > +             esp32_uart_txint(port);
> > +
> > +     esp32_uart_write(port, UART_INT_CLR_REG, status);
>
> \n here please.

Ok

> > +     return IRQ_RETVAL(status);
> > +}
>
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
> > +     ret =3D devm_request_irq(port->dev, port->irq, esp32_uart_int, 0,
> > +                            DRIVER_NAME, port);
> > +     if (ret) {
> > +             clk_disable_unprepare(sport->clk);
> > +             return ret;
> > +     }
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +     esp32_uart_write(port, UART_CONF1_REG,
> > +                      (1 << UART_RXFIFO_FULL_THRHD_SHIFT) |
>
> BIT() ?
>
> > +                      (1 << port_variant(port)->txfifo_empty_thrhd_shi=
ft));
>
> And here?

These are not logically bits, in both cases I put value 1 into
multiple-bit fields.

> > +     esp32_uart_write(port, UART_INT_CLR_REG, UART_RXFIFO_FULL_INT | U=
ART_BRK_DET_INT);
> > +     esp32_uart_write(port, UART_INT_ENA_REG, UART_RXFIFO_FULL_INT | U=
ART_BRK_DET_INT);
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +     pr_debug("%s, conf1 =3D %08x, int_st =3D %08x, status =3D %08x\n"=
,
> > +              __func__,
> > +              esp32_uart_read(port, UART_CONF1_REG),
> > +              esp32_uart_read(port, UART_INT_ST_REG),
> > +              esp32_uart_read(port, UART_STATUS_REG));
>
> \n here. Is this debug printout somehow useful?

I'll drop it.

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
>
> I wonder why to use devm_ after all?

I'll switch to non-devm_ version.

> > +     clk_disable_unprepare(sport->clk);
> > +}
> > +
> > +static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
> > +{
> > +     u32 div =3D port->uartclk / baud;
> > +     u32 frag =3D (port->uartclk * 16) / baud - div * 16;
> > +
> > +     if (div <=3D port_variant(port)->clkdiv_mask) {
> > +             esp32_uart_write(port, UART_CLKDIV_REG,
> > +                              div | FIELD_PREP(UART_CLKDIV_FRAG, frag)=
);
> > +             return true;
> > +     }
>
> \n

Ok.

> > +     return false;
> > +}
> ...
> > +static int __init esp32s3_uart_early_console_setup(struct earlycon_dev=
ice *device,
> > +                                                const char *options)
> > +{
> > +     device->port.private_data =3D (void *)&esp32s3_variant;
>
> No need to cast, right?

private_data is void *, esp32s3_variant is a constant.

> \n

Ok.

> > +     return esp32xx_uart_early_console_setup(device, options);
> > +}
> ...
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
, UART_NR);
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
>
> No need to cast.

This is again a const cast.

> > +
> > +     esp32_uart_ports[port->line] =3D sport;
> > +
> > +     platform_set_drvdata(pdev, port);
> > +
> > +     return uart_add_one_port(&esp32_uart_reg, port);
> > +}
>
> regards,
> --
> js
> suse labs
>


--=20
Thanks.
-- Max
