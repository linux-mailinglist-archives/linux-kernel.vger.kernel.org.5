Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBB7A2B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 01:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbjIOXyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 19:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjIOXyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:54:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8662102;
        Fri, 15 Sep 2023 16:54:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fb5bd8f02so2647575b3a.0;
        Fri, 15 Sep 2023 16:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694822058; x=1695426858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKA9abMjC7sW4LBR9fGk0XQEXTIvl1CB0HpqC1ijf7s=;
        b=DKstLab5FBHVgb1LbjR/vjug1a+BCby1v7+hP1+fCxPusyGnuA9Xu70AMeiyvntC7W
         FaeNO+b0TBGoAoNJTNysleXYynVSE888BxO9iSA8z4oLj1E0giYUI306cjGkq9DgQODa
         PJMP6atQPdCnV7QqfJq/M4QWklx5drWvl+YHaAZhG0Heu3ny2Zc9MY4cMLid8U1m8uTb
         dCdKJ9IAp/A1tJ+ZW5m9MI22U1ws65tXs16Zjya9Rk4TDiqAJNzR7XyzvZF4dQ7BfBMd
         4pXGDeGudADnibALyjwEWXsX3Q4x3ZvRtFL0qJgrFf5UclYGvF3rU6nz4qo3m+pChk6n
         Viuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694822058; x=1695426858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKA9abMjC7sW4LBR9fGk0XQEXTIvl1CB0HpqC1ijf7s=;
        b=iCLA4PHN8N3982fGufgGGpb2zqfgs+YKJxm3qQOAYWFSs2GtSeLkSesk8Vp7ZHHGmd
         3lWujLnJ1EMLoG0PpzurjpD/82MbnTIiTKMhswp5bU1T/x1TNSmEmfxN9jyIX/tRIWab
         JaemiI6fqVvnK5znal3FdO/hFk15N711feRW4kYBMhRvpzXZGeNZQvLuWErsPADvlpBq
         v5Tis16oXWqvtb8DVdIPompv/qgwPXM950Z8NwkDs/tu2Lvlprg+wX1TFeO67wS9SfdD
         HgkpPj2dOVGLdRN3NDRUf7uFtMuEghIn2WDGKG6B8kollqI9pRmYo2JLqFKh5JfQGlOC
         VriQ==
X-Gm-Message-State: AOJu0Yzw/YiO4DU9II+KdrbMu5+4zrl8uukf4XgBceoYrdJmDD9DlyOz
        +cJOcVaB3ZoBzgV/sP+Ax82mejDd+Cjp8r3Szk4=
X-Google-Smtp-Source: AGHT+IHgVUtldsOtaUsIGxCHFBt0zxYCSScNWymvy6s5gqnqKSyzuSQwXCwkNSVTVYPufAKo6Y3GUGQtOEY3IpkurE8=
X-Received: by 2002:a05:6a20:394c:b0:125:f3d8:e65b with SMTP id
 r12-20020a056a20394c00b00125f3d8e65bmr3235376pzg.18.1694822057804; Fri, 15
 Sep 2023 16:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230913211449.668796-1-jcmvbkbc@gmail.com> <20230913211449.668796-5-jcmvbkbc@gmail.com>
 <6f95d492-2f5e-42e8-acdd-210d6a03b14c@kernel.org>
In-Reply-To: <6f95d492-2f5e-42e8-acdd-210d6a03b14c@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 15 Sep 2023 16:54:06 -0700
Message-ID: <CAMo8BfJM4p5icMo1EFB+0gYVeyPSNi8nKUH=PCuBUWcd_ONGdg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drivers/tty/serial: add ESP32S3 ACM device driver
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
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 12:16=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 13. 09. 23, 23:14, Max Filippov wrote:
> > Add driver for the ACM  controller of the Espressif ESP32S3 Soc.
> > Hardware specification is available at the following URL:
> >
> >    https://www.espressif.com/sites/default/files/documentation/esp32-s3=
_technical_reference_manual_en.pdf
> >    (Chapter 33 USB Serial/JTAG Controller)
> ...
>
> > +static void esp32s3_acm_put_char_sync(struct uart_port *port, unsigned=
 char c)
> > +{
> > +     while (!esp32s3_acm_tx_fifo_free(port))
> > +             cpu_relax();
>
> No limits...

Fixed.

> > +     esp32s3_acm_put_char(port, c);
> > +     esp32s3_acm_push(port);
> > +}
> > +
> > +static void esp32s3_acm_transmit_buffer(struct uart_port *port)
> > +{
>
> tx helper.

Ok.

> > +     struct circ_buf *xmit =3D &port->state->xmit;
> > +     u32 tx_fifo_used =3D esp32s3_acm_tx_fifo_cnt(port);
> > +
> > +     if (esp32s3_acm_tx_fifo_free(port)) {
> > +             while (!uart_circ_empty(xmit) && tx_fifo_used < ESP32S3_A=
CM_TX_FIFO_SIZE) {
> > +                     esp32s3_acm_put_char(port, xmit->buf[xmit->tail])=
;
> > +                     xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE=
 - 1);
> > +                     port->icount.tx++;
> > +                     ++tx_fifo_used;
> > +             }
> > +     }
> > +
> > +     if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > +             uart_write_wakeup(port);
> > +
> > +     if (uart_circ_empty(xmit)) {
> > +             esp32s3_acm_stop_tx(port);
> > +     } else {
> > +             u32 int_ena;
> > +
> > +             int_ena =3D esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_EN=
A_REG);
> > +             esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
> > +                               int_ena | USB_SERIAL_JTAG_SERIAL_IN_EMP=
TY_INT_ENA_MASK);
> > +     }
> > +
> > +     if (tx_fifo_used > 0 && tx_fifo_used < ESP32S3_ACM_TX_FIFO_SIZE)
> > +             esp32s3_acm_write(port, USB_SERIAL_JTAG_EP1_CONF_REG,
> > +                               USB_SERIAL_JTAG_WR_DONE_MASK);
> > +}
>
>
> > +static irqreturn_t esp32s3_acm_int(int irq, void *dev_id)
> > +{
> > +     struct uart_port *port =3D dev_id;
> > +     u32 status;
> > +
> > +     status =3D esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_ST_REG);
> > +     esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_CLR_REG, status);
> > +
> > +     if (status & USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ST_MASK)
> > +             esp32s3_acm_rxint(port);
> > +     if (status & USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ST_MASK)
> > +             esp32s3_acm_txint(port);
> > +
> > +     return IRQ_HANDLED;
>
> IRQ_STATUS()

Ok.

> > +}
>
> > +static int esp32s3_acm_startup(struct uart_port *port)
> > +{
> > +     int ret =3D 0;
> > +
> > +     esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
> > +                       USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA_MAS=
K);
> > +     ret =3D devm_request_irq(port->dev, port->irq, esp32s3_acm_int, 0=
,
> > +                            DRIVER_NAME, port);
> > +     return ret;
>
> No need for ret. Or not, you don't handle the failure properly again
> (disable ints). And the order appears to be switched too.

Fixed.

> > +static void
> > +esp32s3_acm_console_write(struct console *co, const char *s, unsigned =
int count)
> > +{
> > +     struct uart_port *port =3D esp32s3_acm_ports[co->index];
> > +     unsigned long flags;
> > +     int locked =3D 1;
>
> bool? ANd in the otrher driver too.

Ok.

> > +
> > +     if (port->sysrq)
> > +             locked =3D 0;
> > +     else if (oops_in_progress)
> > +             locked =3D spin_trylock_irqsave(&port->lock, flags);
> > +     else
> > +             spin_lock_irqsave(&port->lock, flags);
> > +
> > +     esp32s3_acm_string_write(port, s, count);
> > +
> > +     if (locked)
> > +             spin_unlock_irqrestore(&port->lock, flags);
> > +}
>
>
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int esp32s3_acm_earlycon_read(struct console *con, char *s, uns=
igned int n)
> > +{
> > +     struct earlycon_device *dev =3D con->data;
> > +     int num_read =3D 0;
>
> num looks like should be unsigned?

Ok.

> > +
> > +     while (num_read < n) {
> > +             int c =3D esp32s3_acm_poll_get_char(&dev->port);
> > +
> > +             if (c =3D=3D NO_POLL_CHAR)
> > +                     break;
> > +             s[num_read++] =3D c;
> > +     }
> > +     return num_read;
> > +}
> > +#endif
>
>
> > +static int esp32s3_acm_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *np =3D pdev->dev.of_node;
> > +     struct uart_port *port;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     port =3D devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
> > +     if (!port)
> > +             return -ENOMEM;
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
> > +     port->dev =3D &pdev->dev;
> > +     port->type =3D PORT_ESP32ACM;
> > +     port->iotype =3D UPIO_MEM;
> > +     port->irq =3D platform_get_irq(pdev, 0);
> > +     port->ops =3D &esp32s3_acm_pops;
> > +     port->flags =3D UPF_BOOT_AUTOCONF;
> > +     port->has_sysrq =3D 1;
> > +     port->fifosize =3D ESP32S3_ACM_TX_FIFO_SIZE;
> > +
> > +     esp32s3_acm_ports[port->line] =3D port;
> > +
> > +     platform_set_drvdata(pdev, port);
> > +
> > +     ret =3D uart_add_one_port(&esp32s3_acm_reg, port);
> > +     return ret;
>
> return imm.

Ok.

--=20
Thanks.
-- Max
