Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC517CFCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbjJSObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjJSObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:31:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C561A1986
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:30:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9e06f058bso6651985ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697725834; x=1698330634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzcEjsEl2uWtmVR4keMfinsYtgfviSGELDDXhjbHV44=;
        b=ObbaY9hdvymww775dmYBTvWj5+OUDo9TXF9GCAeKETNhpKmJWZDN81FVqNeuUteujP
         hSE3t6TuRNIrKXE9CO5t8FuVoBaGMFtJBhjYdW5W2ZoqiEaWki3aBmNTEVTlJXW6qXuk
         as80Eyh8nssijQn6OFozV2XUgGPJ7HHO1icLDNZtraFFJ3gMTnCwdbpaX1pFxpoCGCiw
         dwJm0mWfo7S51NiMnj5Om7wbB23TKLqWNeHaafNB6l2W2bWYa15zFrjGLwkCiE/TzrzZ
         KESct1MLOfrtSzOBpxflhrCSoTlOb1Y/wxJaxaCukaD+QBSKaJblTCkd+FOpPejeIVnX
         vEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725834; x=1698330634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzcEjsEl2uWtmVR4keMfinsYtgfviSGELDDXhjbHV44=;
        b=sTprYeGHA3gpv+RFP8OySIHfBa+tX1VXE+ZJszoo2BXL4DPncvfSMsec1NelFGr3VA
         A5IVHFFn8qoIw0fsh74XblmKWe4dlOlb6UJhenw5FKt9DV63S7iWTO9YQ32Q5joVarrw
         lhxe/d/w4fyzsG/HVmbdOJKLKavqBbfKIlGN9EvXWvL4TKRDObfzdoBcLDREtQYUS9Wl
         vMf2PD10rTevjRH/Fa5EfXzkspYxUx4VLJ1gPgSfvdmRk3VQHR+zrqPk3Byf7IqgfLZD
         9aF9hOoGoACE0utmHxIHN3WZLFh18031ck1YJ6aMBSP1ow4ZQjYqwnWsTgTaeCRhgxgc
         UAGA==
X-Gm-Message-State: AOJu0YzlCyXmbFKgLYP1ft10n2v9XesvvwyXfUacyK0BNeQx+T82ssFK
        ULvha0Aik3gOcdYy9f+WZxcnqn0DUgu8ijpXF+Uzkw==
X-Google-Smtp-Source: AGHT+IG67nzoAxZvjHVM1Fg3hfBlSRytt3fgQ43njR364pQJif9r0I4lxmmiyf5fzvCNdBSaetiup45v6FCPQyBzv+k=
X-Received: by 2002:a17:903:1cd:b0:1c9:cad9:e6e3 with SMTP id
 e13-20020a17090301cd00b001c9cad9e6e3mr3243398plh.32.1697725833502; Thu, 19
 Oct 2023 07:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231019100901.4026680-1-andre.draszik@linaro.org>
In-Reply-To: <20231019100901.4026680-1-andre.draszik@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 19 Oct 2023 09:30:22 -0500
Message-ID: <CAPLW+4ndcW0jtXNiBOctPnbK8QNz_Ra8TcXwLxg0tGFWFHvWHA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: samsung_tty: remove dead code
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 5:09=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> When support for various old platforms was removed in commit
> 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks"),
> s3c24xx_serial_ops also became unused here because nothing sets port
> type TYPE_S3C24XX anymore.
>
> Remove s3c24xx_serial_ops and all the code that's unreachable now.
>
> Fixes: 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks")
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v2: update commit message
> ---
>  drivers/tty/serial/samsung_tty.c | 105 -------------------------------
>  1 file changed, 105 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 07fb8a9dac63..6b8d4b4402e9 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -64,7 +64,6 @@
>  #define RXSTAT_DUMMY_READ (0x10000000)
>
>  enum s3c24xx_port_type {
> -       TYPE_S3C24XX,
>         TYPE_S3C6400,
>         TYPE_APPLE_S5L,
>  };
> @@ -128,8 +127,6 @@ struct s3c24xx_uart_dma {
>  };
>
>  struct s3c24xx_uart_port {
> -       unsigned char                   rx_claimed;
> -       unsigned char                   tx_claimed;
>         unsigned char                   rx_enabled;
>         unsigned char                   tx_enabled;
>         unsigned int                    pm_level;
> @@ -1166,29 +1163,6 @@ static void s3c24xx_serial_release_dma(struct s3c2=
4xx_uart_port *p)
>         }
>  }
>
> -static void s3c24xx_serial_shutdown(struct uart_port *port)
> -{
> -       struct s3c24xx_uart_port *ourport =3D to_ourport(port);
> -
> -       if (ourport->tx_claimed) {
> -               free_irq(ourport->tx_irq, ourport);
> -               ourport->tx_enabled =3D 0;
> -               ourport->tx_claimed =3D 0;
> -               ourport->tx_mode =3D 0;
> -       }
> -
> -       if (ourport->rx_claimed) {
> -               free_irq(ourport->rx_irq, ourport);
> -               ourport->rx_claimed =3D 0;
> -               ourport->rx_enabled =3D 0;
> -       }
> -
> -       if (ourport->dma)
> -               s3c24xx_serial_release_dma(ourport);
> -
> -       ourport->tx_in_progress =3D 0;
> -}
> -
>  static void s3c64xx_serial_shutdown(struct uart_port *port)
>  {
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
> @@ -1234,48 +1208,6 @@ static void apple_s5l_serial_shutdown(struct uart_=
port *port)
>         ourport->tx_in_progress =3D 0;
>  }
>
> -static int s3c24xx_serial_startup(struct uart_port *port)
> -{
> -       struct s3c24xx_uart_port *ourport =3D to_ourport(port);
> -       int ret;
> -
> -       ourport->rx_enabled =3D 1;
> -
> -       ret =3D request_irq(ourport->rx_irq, s3c24xx_serial_rx_irq, 0,
> -                         s3c24xx_serial_portname(port), ourport);
> -
> -       if (ret !=3D 0) {
> -               dev_err(port->dev, "cannot get irq %d\n", ourport->rx_irq=
);
> -               return ret;
> -       }
> -
> -       ourport->rx_claimed =3D 1;
> -
> -       dev_dbg(port->dev, "requesting tx irq...\n");
> -
> -       ourport->tx_enabled =3D 1;
> -
> -       ret =3D request_irq(ourport->tx_irq, s3c24xx_serial_tx_irq, 0,
> -                         s3c24xx_serial_portname(port), ourport);
> -
> -       if (ret) {
> -               dev_err(port->dev, "cannot get irq %d\n", ourport->tx_irq=
);
> -               goto err;
> -       }
> -
> -       ourport->tx_claimed =3D 1;
> -
> -       /* the port reset code should have done the correct
> -        * register setup for the port controls
> -        */
> -
> -       return ret;
> -
> -err:
> -       s3c24xx_serial_shutdown(port);
> -       return ret;
> -}
> -
>  static int s3c64xx_serial_startup(struct uart_port *port)
>  {
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
> @@ -1692,8 +1624,6 @@ static const char *s3c24xx_serial_type(struct uart_=
port *port)
>         const struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>
>         switch (ourport->info->type) {
> -       case TYPE_S3C24XX:
> -               return "S3C24XX";
>         case TYPE_S3C6400:
>                 return "S3C6400/10";
>         case TYPE_APPLE_S5L:
> @@ -1753,27 +1683,6 @@ static void s3c24xx_serial_put_poll_char(struct ua=
rt_port *port,
>                          unsigned char c);
>  #endif
>
> -static const struct uart_ops s3c24xx_serial_ops =3D {
> -       .pm             =3D s3c24xx_serial_pm,
> -       .tx_empty       =3D s3c24xx_serial_tx_empty,
> -       .get_mctrl      =3D s3c24xx_serial_get_mctrl,
> -       .set_mctrl      =3D s3c24xx_serial_set_mctrl,
> -       .stop_tx        =3D s3c24xx_serial_stop_tx,
> -       .start_tx       =3D s3c24xx_serial_start_tx,
> -       .stop_rx        =3D s3c24xx_serial_stop_rx,
> -       .break_ctl      =3D s3c24xx_serial_break_ctl,
> -       .startup        =3D s3c24xx_serial_startup,
> -       .shutdown       =3D s3c24xx_serial_shutdown,
> -       .set_termios    =3D s3c24xx_serial_set_termios,
> -       .type           =3D s3c24xx_serial_type,
> -       .config_port    =3D s3c24xx_serial_config_port,
> -       .verify_port    =3D s3c24xx_serial_verify_port,
> -#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POL=
L)
> -       .poll_get_char =3D s3c24xx_serial_get_poll_char,
> -       .poll_put_char =3D s3c24xx_serial_put_poll_char,
> -#endif
> -};
> -
>  static const struct uart_ops s3c64xx_serial_ops =3D {
>         .pm             =3D s3c24xx_serial_pm,
>         .tx_empty       =3D s3c24xx_serial_tx_empty,
> @@ -1836,7 +1745,6 @@ static void s3c24xx_serial_init_port_default(int in=
dex) {
>         port->iotype =3D UPIO_MEM;
>         port->uartclk =3D 0;
>         port->fifosize =3D 16;
> -       port->ops =3D &s3c24xx_serial_ops;
>         port->flags =3D UPF_BOOT_AUTOCONF;
>         port->line =3D index;
>  }
> @@ -1954,16 +1862,6 @@ static int s3c24xx_serial_init_port(struct s3c24xx=
_uart_port *ourport,
>                 ourport->tx_irq =3D ret + 1;
>         }
>
> -       switch (ourport->info->type) {
> -       case TYPE_S3C24XX:
> -               ret =3D platform_get_irq(platdev, 1);
> -               if (ret > 0)
> -                       ourport->tx_irq =3D ret;
> -               break;
> -       default:
> -               break;
> -       }
> -
>         /*
>          * DMA is currently supported only on DT platforms, if DMA proper=
ties
>          * are specified.
> @@ -2083,9 +1981,6 @@ static int s3c24xx_serial_probe(struct platform_dev=
ice *pdev)
>                         &ourport->drv_data->def_cfg;
>
>         switch (ourport->info->type) {
> -       case TYPE_S3C24XX:
> -               ourport->port.ops =3D &s3c24xx_serial_ops;
> -               break;
>         case TYPE_S3C6400:
>                 ourport->port.ops =3D &s3c64xx_serial_ops;
>                 break;
> --
> 2.40.1
>
