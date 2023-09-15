Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284DD7A19F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjIOJHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIOJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:07:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707573A9E;
        Fri, 15 Sep 2023 02:04:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fe2470d81so1716312b3a.1;
        Fri, 15 Sep 2023 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694768664; x=1695373464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5/obQmqPFY2GGzKy7p4n7Yxa+vweWi94m1kGN29mNs=;
        b=dMCbyBrQd+7EH6JgSspG2c0V4c2hq36iJKhNoCkIz6RaMuoevrl1WKaPzVjdD78+n+
         V57faPiFi1uOnI3m4aZSId7t6+kRVL6X6YIDY8TrYTLdwrdX4dLrJb/4PhOnc+dUSlXj
         HQrTtWFemdxZ6seC96bzVYVuyRj/4LQtlVU9hlgFzpjD2sYQ34pknq5smmWG211MsecX
         YYTSQpyv/D5NjQWRsyLCshCxwqWoGYQyaoC9lycsKpBVm87SHCK59cHwtlUXe1K306do
         3jNkXGpQDa2OldYrjv6+1rr4TGMPta3l4XYzDS7WR+WcWjW9YERt/Hnay5ryyWdu6NFc
         c+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694768664; x=1695373464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5/obQmqPFY2GGzKy7p4n7Yxa+vweWi94m1kGN29mNs=;
        b=S8lT6k/yEeO3sp6CcnQAlYyaQJA6dICM44uIp8wclzuFT0zd2C8S7NSG96hXgjg1Cl
         7P5immuA9zeVwjppjl3q0salINJh/pB1r8gqpYxrNnfdmePuABc5GRSSKy223VoepnQR
         dKufhJcNGCCigQ1HRy3Erf3nzkkJbbasjo0Qk6LO/7PNpo0PV4eypoP3LfhkSZTw2gKh
         E/q7HEOastiuBdg3Xr2DKPxvvLzPMGj29a9ue4xvqtS7kv79fOr0DwVzhy9iexK9+HQ4
         pWHQ+ppMQEwV04lZFOi1fOGgr0afpdtqj8oxsn2OSQtpNlKAB7ma/GMvgYuU2t4/x4fm
         9xrA==
X-Gm-Message-State: AOJu0YwlWGEd1d2vOMB30NunbUDKCymJWiorD1yXFY3qo+NKPdUgPCe0
        0SPKTDEACvdW85YIQ15dSjEfxr937vmsvLOL1aHZ89qB
X-Google-Smtp-Source: AGHT+IFzdDan/HyRuTkkiAkrgQftMNbg8JnxqytfRFcnDFy/1wDVyAYO4m97OSYaZ5icf8WQYZ9Rx/ove49q9Si4xLM=
X-Received: by 2002:a05:6300:8088:b0:152:238a:f05b with SMTP id
 ap8-20020a056300808800b00152238af05bmr1159793pzc.53.1694768664011; Fri, 15
 Sep 2023 02:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230913211449.668796-1-jcmvbkbc@gmail.com> <20230913211449.668796-3-jcmvbkbc@gmail.com>
 <ac6d6641-7de3-423e-9164-fcd249d782fc@kernel.org>
In-Reply-To: <ac6d6641-7de3-423e-9164-fcd249d782fc@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 15 Sep 2023 02:04:12 -0700
Message-ID: <CAMo8Bf+0VPh5puXT7JAOtXNZntb2Ty4m7g=KLaQDEeH9pcA8Hg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drivers/tty/serial: add driver for the ESP32 UART
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Sep 14, 2023 at 12:06=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 13. 09. 23, 23:14, Max Filippov wrote:
> > Add driver for the UART controllers of the Espressif ESP32 and ESP32S3
> > SoCs. Hardware specification is available at the following URLs:
> >
> >    https://www.espressif.com/sites/default/files/documentation/esp32_te=
chnical_reference_manual_en.pdf
> >    (Chapter 13 UART Controller)
> >    https://www.espressif.com/sites/default/files/documentation/esp32-s3=
_technical_reference_manual_en.pdf
> >    (Chapter 26 UART Controller)
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> ...
> > +#define UART_FIFO_REG                        0x00
> > +#define UART_INT_RAW_REG             0x04
> > +#define UART_INT_ST_REG                      0x08
> > +#define UART_INT_ENA_REG             0x0c
> > +#define UART_INT_CLR_REG             0x10
> > +#define UART_RXFIFO_FULL_INT_MASK            0x00000001
> > +#define UART_TXFIFO_EMPTY_INT_MASK           0x00000002
> > +#define UART_BRK_DET_INT_MASK                        0x00000080
> > +#define UART_CLKDIV_REG                      0x14
> > +#define ESP32_UART_CLKDIV_MASK                       0x000fffff
> > +#define ESP32S3_UART_CLKDIV_MASK             0x00000fff
> > +#define UART_CLKDIV_SHIFT                    0
> > +#define UART_CLKDIV_FRAG_MASK                        0x00f00000
> > +#define UART_CLKDIV_FRAG_SHIFT                       20
> > +#define UART_STATUS_REG                      0x1c
> > +#define ESP32_UART_RXFIFO_CNT_MASK           0x000000ff
> > +#define ESP32S3_UART_RXFIFO_CNT_MASK         0x000003ff
>
> Can you use GENMASK() for all these?

Ok.

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
> ...
>
> > +static void esp32_uart_put_char_sync(struct uart_port *port, unsigned =
char c)
>
> u8 for characters everywhere, please.

Ok, but I guess not everywhere? E.g. uart_ops::poll_put_char has
'unsigned char' in the definition, it seems better to keep implementation
in sync.

> > +{
> > +     while (esp32_uart_tx_fifo_cnt(port) >=3D ESP32_UART_TX_FIFO_SIZE)
> > +             cpu_relax();
>
> No timeout? There should be one.

Ok.

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
>
> Why not using uart_port_tx_limited()?

Ok.

> > +     if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > +             uart_write_wakeup(port);
> > +
> > +     if (uart_circ_empty(xmit)) {
> > +             esp32_uart_stop_tx(port);
> > +     } else {
> > +             u32 int_ena;
> > +
> > +             int_ena =3D esp32_uart_read(port, UART_INT_ENA_REG);
> > +             esp32_uart_write(port, UART_INT_ENA_REG,
> > +                              int_ena | UART_TXFIFO_EMPTY_INT_MASK);
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
>
> This should be IRQ_RETVAL(status) or similar. To let the system disable
> the irq in case the HW gets crazy.

Ok.

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
> > +                      (1 << port_variant(port)->txfifo_empty_thrhd_shi=
ft));
> > +     esp32_uart_write(port, UART_INT_CLR_REG,
> > +                      UART_RXFIFO_FULL_INT_MASK |
> > +                      UART_BRK_DET_INT_MASK);
> > +     esp32_uart_write(port, UART_INT_ENA_REG,
> > +                      UART_RXFIFO_FULL_INT_MASK |
> > +                      UART_BRK_DET_INT_MASK);
> > +     spin_unlock_irqrestore(&port->lock, flags);
>
> So interrupts can be coming now, but you don't handle them yet?

Reordered it with the irq handler installation.

> > +     ret =3D devm_request_irq(port->dev, port->irq, esp32_uart_int, 0,
> > +                            DRIVER_NAME, port);
>
> You don't disable clk and interrupts in case of failure?

Fixed.

> > +     pr_debug("%s, request_irq: %d, conf1 =3D %08x, int_st =3D %08x, s=
tatus =3D %08x\n",
> > +              __func__, ret,
> > +              esp32_uart_read(port, UART_CONF1_REG),
> > +              esp32_uart_read(port, UART_INT_ST_REG),
> > +              esp32_uart_read(port, UART_STATUS_REG));
> > +     return ret;
> > +}
> ...
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
>
> Perhaps it would be more readable as:
> conf0 =3D esp32_uart_read(port, UART_CONF0_REG);
> conf0 &=3D ~(UART_PARITY_EN_MASK | ...);
> ?

Ok.

> > +     conf1 =3D esp32_uart_read(port, UART_CONF1_REG) &
> > +             ~rx_flow_en;
> > +
> > +     if (termios->c_cflag & PARENB) {
> > +             conf0 |=3D UART_PARITY_EN_MASK;
> > +             if (termios->c_cflag & PARODD)
> > +                     conf0 |=3D UART_PARITY_MASK;
> > +     }
>
>
> > +static void esp32_uart_release_port(struct uart_port *port)
> > +{
> > +}
> > +
> > +static int esp32_uart_request_port(struct uart_port *port)
> > +{
> > +     return 0;
> > +}
>
> Drop these two.

Ok

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
>
> You can skip ret here and return directly.

Ok

--=20
Thanks.
-- Max
