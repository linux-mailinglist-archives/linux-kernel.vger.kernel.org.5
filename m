Return-Path: <linux-kernel+bounces-27672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2482F3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35576B23684
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4732D1CD29;
	Tue, 16 Jan 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kfu/9jws"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD81CABF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429043; cv=none; b=C7vuqU6C7V6hS0WXx8vT2N2OoiNrZG0D+NzkHFy5s29Px9YBfZNqvUbExR02XtbK5eQgTGm8FEX4ztnG/kUuMni/oOabiCUpAl6oj+9Q0gsAMLO+IBOI1JK/xMSSfVil7t9XVPYeE2cU3zUsCTwpm3pOD76STlUkeUqKZndAeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429043; c=relaxed/simple;
	bh=wl8WW1RtKkB+LOgG0dK4wEsN+e6VfzWlH5rNNiEIQoc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=P/e4SP6NhvLcLpP6LFQPRXZ+XEdprK+YPe6vw+4NwIxbjN4PVhKW5Kpot8wFVmoBAPtqystBymzcaDYWhSGI09Gg+XO/9q8p8Oh51nlDm+wbI3UE/2q88Nud7KIZoSGonW3T2ngmjbS4HNHqGZhZ4JIKud3UAhX4sCyjd2EiB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kfu/9jws; arc=none smtp.client-ip=209.85.166.45
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bc32b04d16so388317539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705429041; x=1706033841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUfAdcT5sYzFvOifn8UyyF10RKNycyxSgjpiAO6cTQI=;
        b=Kfu/9jwsChcSHPHvEQh4VP6SKzT+4OrPwQx1qusP+0PqCWnDZEc4Xg87HADpW/F4eV
         mXpjFWf6Lr+bJc2DhH8LlLt5mcmHMxb2Op8+X7xRAujRMCQaZj7g9yTnd29KQmBxh76B
         ckp0YhdMimDxziGmAdI8F/PqezfDEtqAZFJ2WgB1na66v+wu9skHcY8H9nzUUj3AFUPP
         AsPlqJdw3iBOWcoMymh/vO9TYdBkcu96tJBcFLzFlBrJZIduof/dUwxML1BGF7QKzVIN
         pgGBAnWoaD+zYpatRf4GGSqQDy91mfMpQSZKHqTxE83H7rlYxXjcBcFpmOSqevQeP/+5
         GNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429041; x=1706033841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUfAdcT5sYzFvOifn8UyyF10RKNycyxSgjpiAO6cTQI=;
        b=MUhXNkt+et8LnRl/BIfa8ulWVrv6jp3t736iCMWjB8fALGPn7jS9Fw8G/z0sC3Pw0r
         CBRp5Bpr5WpTozlNgQ/csNnJlosiDEnJRBS60JQBFeeFB5fRNVTTvxWU2/xvGtFZ6wnG
         e+Zd80KJ30I32pO2wvpQa7nbLdZo5n1Czc1JmXaefQ29a2PTV/bsEoakMAxBjSse2N2Q
         EfR+iurrfXJJ0d0mmue99DKQrm9ejA7kH7H7AmeO7AgpbMmgvYLTe3C3S/Se2IfRBY+F
         vvgZqfdy1N52jjdQ3H8PtGelMEljY2Omb9kWD6g5Ep+eLO5eB0hXobMy8cmZ4r/2rSnl
         rtGw==
X-Gm-Message-State: AOJu0Yy1SyyKibSdOL0AQNidbtr3bTAosLnZKyBZOtpyOVmMh6u344VF
	2UE6NR+8J4jGbeqxMHGTp73OA+VetOH53XEoIEEKl32eKXn3IQ==
X-Google-Smtp-Source: AGHT+IErQZL5+uc+i8dTlwH8Jc2ogwZT6FktqbqyHQNVt4Ua09G8oxVbn0QOgnVhnq4XU+ug5uGW9NAXqp5j3mxqrIM=
X-Received: by 2002:a05:6602:3b8d:b0:7be:f2f5:8466 with SMTP id
 dm13-20020a0566023b8d00b007bef2f58466mr8765665iob.29.1705429040912; Tue, 16
 Jan 2024 10:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-7-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-7-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:17:09 -0600
Message-ID: <CAPLW+4mh2j-eu8n70HotaHQz3P8VP9vvKDOyUNqPj3-btr-AyA@mail.gmail.com>
Subject: Re: [PATCH 06/18] tty: serial: samsung: use u32 for register interactions
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:22=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> All registers of the IP have 32 bits. Use u32 variables when reading
> or writing from/to the registers. The purpose of those variables becomes
> clearer.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 79 ++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index b8b71a0109ea..d5f9bec24b8e 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -199,7 +199,7 @@ static void wr_reg(const struct uart_port *port, u32 =
reg, u32 val)
>  /* Byte-order aware bit setting/clearing functions. */
>
>  static inline void s3c24xx_set_bit(const struct uart_port *port, int idx=
,
> -                                  unsigned int reg)
> +                                  u32 reg)
>  {
>         unsigned long flags;
>         u32 val;
> @@ -212,7 +212,7 @@ static inline void s3c24xx_set_bit(const struct uart_=
port *port, int idx,
>  }
>
>  static inline void s3c24xx_clear_bit(const struct uart_port *port, int i=
dx,
> -                                    unsigned int reg)
> +                                    u32 reg)
>  {
>         unsigned long flags;
>         u32 val;
> @@ -245,8 +245,8 @@ static void s3c24xx_serial_rx_enable(struct uart_port=
 *port)
>  {
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>         unsigned long flags;
> -       unsigned int ucon, ufcon;
>         int count =3D 10000;
> +       u32 ucon, ufcon;
>
>         uart_port_lock_irqsave(port, &flags);
>
> @@ -269,7 +269,7 @@ static void s3c24xx_serial_rx_disable(struct uart_por=
t *port)
>  {
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>         unsigned long flags;
> -       unsigned int ucon;
> +       u32 ucon;
>
>         uart_port_lock_irqsave(port, &flags);
>
> @@ -591,7 +591,7 @@ static inline const struct s3c2410_uartcfg
>  }
>
>  static int s3c24xx_serial_rx_fifocnt(const struct s3c24xx_uart_port *our=
port,
> -                                    unsigned long ufstat)
> +                                    u32 ufstat)
>  {
>         const struct s3c24xx_uart_info *info =3D ourport->info;
>
> @@ -663,7 +663,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_=
port *ourport)
>  static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
>  {
>         struct uart_port *port =3D &ourport->port;
> -       unsigned int ucon;
> +       u32 ucon;
>
>         /* set Rx mode to DMA mode */
>         ucon =3D rd_regl(port, S3C2410_UCON);
> @@ -686,7 +686,7 @@ static void enable_rx_dma(struct s3c24xx_uart_port *o=
urport)
>  static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
>  {
>         struct uart_port *port =3D &ourport->port;
> -       unsigned int ucon;
> +       u32 ucon;
>
>         /* set Rx mode to DMA mode */
>         ucon =3D rd_regl(port, S3C2410_UCON);
> @@ -711,13 +711,14 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c=
24xx_uart_port *ourport);
>
>  static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
>  {
> -       unsigned int utrstat, received;
>         struct s3c24xx_uart_port *ourport =3D dev_id;
>         struct uart_port *port =3D &ourport->port;
>         struct s3c24xx_uart_dma *dma =3D ourport->dma;
>         struct tty_struct *tty =3D tty_port_tty_get(&ourport->port.state-=
>port);
>         struct tty_port *t =3D &port->state->port;
>         struct dma_tx_state state;
> +       unsigned int received;
> +       u32 utrstat;
>
>         utrstat =3D rd_regl(port, S3C2410_UTRSTAT);
>         rd_regl(port, S3C2410_UFSTAT);
> @@ -759,9 +760,9 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *=
dev_id)
>  static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourpo=
rt)
>  {
>         struct uart_port *port =3D &ourport->port;
> -       unsigned int ufcon, ufstat, uerstat;
>         unsigned int fifocnt =3D 0;
>         int max_count =3D port->fifosize;
> +       u32 ufcon, ufstat, uerstat;
>         u8 ch, flag;
>
>         while (max_count-- > 0) {
> @@ -945,7 +946,7 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq,=
 void *id)
>  {
>         const struct s3c24xx_uart_port *ourport =3D id;
>         const struct uart_port *port =3D &ourport->port;
> -       unsigned int pend =3D rd_regl(port, S3C64XX_UINTP);
> +       u32 pend =3D rd_regl(port, S3C64XX_UINTP);
>         irqreturn_t ret =3D IRQ_HANDLED;
>
>         if (pend & S3C64XX_UINTM_RXD_MSK) {
> @@ -964,7 +965,7 @@ static irqreturn_t apple_serial_handle_irq(int irq, v=
oid *id)
>  {
>         const struct s3c24xx_uart_port *ourport =3D id;
>         const struct uart_port *port =3D &ourport->port;
> -       unsigned int pend =3D rd_regl(port, S3C2410_UTRSTAT);
> +       u32 pend =3D rd_regl(port, S3C2410_UTRSTAT);
>         irqreturn_t ret =3D IRQ_NONE;
>
>         if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO))=
 {
> @@ -983,8 +984,8 @@ static irqreturn_t apple_serial_handle_irq(int irq, v=
oid *id)
>  static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
> -       unsigned long ufstat =3D rd_regl(port, S3C2410_UFSTAT);
> -       unsigned long ufcon =3D rd_regl(port, S3C2410_UFCON);
> +       u32 ufstat =3D rd_regl(port, S3C2410_UFSTAT);
> +       u32 ufcon =3D rd_regl(port, S3C2410_UFCON);
>
>         if (ufcon & S3C2410_UFCON_FIFOMODE) {
>                 if ((ufstat & info->tx_fifomask) !=3D 0 ||
> @@ -1000,7 +1001,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct =
uart_port *port)
>  /* no modem control lines */
>  static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
>  {
> -       unsigned int umstat =3D rd_reg(port, S3C2410_UMSTAT);
> +       u32 umstat =3D rd_reg(port, S3C2410_UMSTAT);
>
>         if (umstat & S3C2410_UMSTAT_CTS)
>                 return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
> @@ -1010,8 +1011,8 @@ static unsigned int s3c24xx_serial_get_mctrl(struct=
 uart_port *port)
>
>  static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned in=
t mctrl)
>  {
> -       unsigned int umcon =3D rd_regl(port, S3C2410_UMCON);
> -       unsigned int ucon =3D rd_regl(port, S3C2410_UCON);
> +       u32 umcon =3D rd_regl(port, S3C2410_UMCON);
> +       u32 ucon =3D rd_regl(port, S3C2410_UCON);
>
>         if (mctrl & TIOCM_RTS)
>                 umcon |=3D S3C2410_UMCOM_RTS_LOW;
> @@ -1031,7 +1032,7 @@ static void s3c24xx_serial_set_mctrl(struct uart_po=
rt *port, unsigned int mctrl)
>  static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_s=
tate)
>  {
>         unsigned long flags;
> -       unsigned int ucon;
> +       u32 ucon;
>
>         uart_port_lock_irqsave(port, &flags);
>
> @@ -1189,7 +1190,7 @@ static void apple_s5l_serial_shutdown(struct uart_p=
ort *port)
>  {
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>
> -       unsigned int ucon;
> +       u32 ucon;
>
>         ucon =3D rd_regl(port, S3C2410_UCON);
>         ucon &=3D ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
> @@ -1215,7 +1216,7 @@ static int s3c64xx_serial_startup(struct uart_port =
*port)
>  {
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>         unsigned long flags;
> -       unsigned int ufcon;
> +       u32 ufcon;
>         int ret;
>
>         wr_regl(port, S3C64XX_UINTM, 0xf);
> @@ -1260,7 +1261,7 @@ static int apple_s5l_serial_startup(struct uart_por=
t *port)
>  {
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>         unsigned long flags;
> -       unsigned int ufcon;
> +       u32 ufcon;
>         int ret;
>
>         wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
> @@ -1345,7 +1346,7 @@ static void s3c24xx_serial_pm(struct uart_port *por=
t, unsigned int level,
>  static inline int s3c24xx_serial_getsource(struct uart_port *port)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
> -       unsigned int ucon;
> +       u32 ucon;
>
>         if (info->num_clks =3D=3D 1)
>                 return 0;
> @@ -1359,7 +1360,7 @@ static void s3c24xx_serial_setsource(struct uart_po=
rt *port,
>                         unsigned int clk_sel)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
> -       unsigned int ucon;
> +       u32 ucon;
>
>         if (info->num_clks =3D=3D 1)
>                 return;
> @@ -1476,9 +1477,8 @@ static void s3c24xx_serial_set_termios(struct uart_=
port *port,
>         struct clk *clk =3D ERR_PTR(-EINVAL);
>         unsigned long flags;
>         unsigned int baud, quot, clk_sel =3D 0;
> -       unsigned int ulcon;
> -       unsigned int umcon;
>         unsigned int udivslot =3D 0;
> +       u32 ulcon, umcon;
>
>         /*
>          * We don't support modem control lines.
> @@ -1760,7 +1760,7 @@ static void s3c24xx_serial_resetport(struct uart_po=
rt *port,
>                                      const struct s3c2410_uartcfg *cfg)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
> -       unsigned long ucon =3D rd_regl(port, S3C2410_UCON);
> +       u32 ucon =3D rd_regl(port, S3C2410_UCON);
>
>         ucon &=3D (info->clksel_mask | info->ucon_mask);
>         wr_regl(port, S3C2410_UCON, ucon | cfg->ucon);
> @@ -1906,7 +1906,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_=
uart_port *ourport,
>                 wr_regl(port, S3C64XX_UINTSP, 0xf);
>                 break;
>         case TYPE_APPLE_S5L: {
> -               unsigned int ucon;
> +               u32 ucon;
>
>                 ucon =3D rd_regl(port, S3C2410_UCON);
>                 ucon &=3D ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
> @@ -2110,7 +2110,7 @@ static int s3c24xx_serial_resume_noirq(struct devic=
e *dev)
>                 /* restore IRQ mask */
>                 switch (ourport->info->type) {
>                 case TYPE_S3C6400: {
> -                       unsigned int uintm =3D 0xf;
> +                       u32 uintm =3D 0xf;
>
>                         if (ourport->tx_enabled)
>                                 uintm &=3D ~S3C64XX_UINTM_TXD_MSK;
> @@ -2126,7 +2126,7 @@ static int s3c24xx_serial_resume_noirq(struct devic=
e *dev)
>                         break;
>                 }
>                 case TYPE_APPLE_S5L: {
> -                       unsigned int ucon;
> +                       u32 ucon;
>                         int ret;
>
>                         ret =3D clk_prepare_enable(ourport->clk);
> @@ -2188,10 +2188,10 @@ static const struct dev_pm_ops s3c24xx_serial_pm_=
ops =3D {
>  static struct uart_port *cons_uart;
>
>  static int
> -s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned int ufcon)
> +s3c24xx_serial_console_txrdy(struct uart_port *port, u32 ufcon)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
> -       unsigned long ufstat, utrstat;
> +       u32 ufstat, utrstat;
>
>         if (ufcon & S3C2410_UFCON_FIFOMODE) {
>                 /* fifo mode - check amount of data in fifo registers... =
*/
> @@ -2207,7 +2207,7 @@ s3c24xx_serial_console_txrdy(struct uart_port *port=
, unsigned int ufcon)
>  }
>
>  static bool
> -s3c24xx_port_configured(unsigned int ucon)
> +s3c24xx_port_configured(u32 ucon)
>  {
>         /* consider the serial port configured if the tx/rx mode set */
>         return (ucon & 0xf) !=3D 0;
> @@ -2222,7 +2222,7 @@ s3c24xx_port_configured(unsigned int ucon)
>  static int s3c24xx_serial_get_poll_char(struct uart_port *port)
>  {
>         const struct s3c24xx_uart_port *ourport =3D to_ourport(port);
> -       unsigned int ufstat;
> +       u32 ufstat;
>
>         ufstat =3D rd_regl(port, S3C2410_UFSTAT);
>         if (s3c24xx_serial_rx_fifocnt(ourport, ufstat) =3D=3D 0)
> @@ -2234,8 +2234,8 @@ static int s3c24xx_serial_get_poll_char(struct uart=
_port *port)
>  static void s3c24xx_serial_put_poll_char(struct uart_port *port,
>                 unsigned char c)
>  {
> -       unsigned int ufcon =3D rd_regl(port, S3C2410_UFCON);
> -       unsigned int ucon =3D rd_regl(port, S3C2410_UCON);
> +       u32 ufcon =3D rd_regl(port, S3C2410_UFCON);
> +       u32 ucon =3D rd_regl(port, S3C2410_UCON);
>
>         /* not possible to xmit on unconfigured port */
>         if (!s3c24xx_port_configured(ucon))
> @@ -2251,7 +2251,7 @@ static void s3c24xx_serial_put_poll_char(struct uar=
t_port *port,
>  static void
>  s3c24xx_serial_console_putchar(struct uart_port *port, unsigned char ch)
>  {
> -       unsigned int ufcon =3D rd_regl(port, S3C2410_UFCON);
> +       u32 ufcon =3D rd_regl(port, S3C2410_UFCON);
>
>         while (!s3c24xx_serial_console_txrdy(port, ufcon))
>                 cpu_relax();
> @@ -2262,7 +2262,7 @@ static void
>  s3c24xx_serial_console_write(struct console *co, const char *s,
>                              unsigned int count)
>  {
> -       unsigned int ucon =3D rd_regl(cons_uart, S3C2410_UCON);
> +       u32 ucon =3D rd_regl(cons_uart, S3C2410_UCON);
>         unsigned long flags;
>         bool locked =3D true;
>
> @@ -2289,11 +2289,9 @@ s3c24xx_serial_get_options(struct uart_port *port,=
 int *baud,
>                            int *parity, int *bits)
>  {
>         struct clk *clk;
> -       unsigned int ulcon;
> -       unsigned int ucon;
> -       unsigned int ubrdiv;
>         unsigned long rate;
>         unsigned int clk_sel;
> +       u32 ulcon, ucon, ubrdiv;
>         char clk_name[MAX_CLK_NAME_LENGTH];
>
>         ulcon  =3D rd_regl(port, S3C2410_ULCON);
> @@ -2743,7 +2741,8 @@ static int samsung_early_read(struct console *con, =
char *s, unsigned int n)
>  {
>         struct earlycon_device *dev =3D con->data;
>         const struct samsung_early_console_data *data =3D dev->port.priva=
te_data;
> -       int ch, ufstat, num_read =3D 0;
> +       int num_read =3D 0;
> +       u32 ch, ufstat;
>
>         while (num_read < n) {
>                 ufstat =3D rd_regl(&dev->port, S3C2410_UFSTAT);
> --
> 2.43.0.472.g3155946c3a-goog
>
>

