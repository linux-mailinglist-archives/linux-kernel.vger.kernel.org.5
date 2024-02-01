Return-Path: <linux-kernel+bounces-48436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E2845C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED821C22F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7269D626A6;
	Thu,  1 Feb 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="njcdIKUi"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79265F489
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802498; cv=none; b=Dl73he46z7IpBk6Dg9nD+HTDeokg5UCnENlf2wbLWMCSAR8MzAcYirc/Pikey2Y4VBJCmGSJUIZqXraLGgGZkOOgFZBJj7gbVHvOGfcNwsZGM/6cViMhWo+MU0FiGXuF3LTvwMqPODClZx6Z1yn5bZonsby5blZpysxZ89PaSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802498; c=relaxed/simple;
	bh=YPgAPS9hepoxlOxUq4K/sY7J/ijRZYX2Afv0qMU768s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqKv5j691M0+s8oEWxw17x1qOhxzQ/HR4bHg09yOVcze106pPaB0H9BTuGcGuwv/oWsigmk75pCoeHqA1f0wQsjo8lomLWwS5t2XpB7yIt+gpOUM+SVVLs19Tx+boKiEquY8/G1EybHrXa7cE5iuUyKwu/xTgQGNUBMgCXq5jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=njcdIKUi; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1706802494; x=1707061694;
	bh=v+NeIwtJum3xWfJlGdeGLluWTi1c+KfBwIIBcQ5KxuA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=njcdIKUiNvWZ60ugZwlkSl8NrPghoARhtxuYJob48WIVjpUZCcpLZ0c4WwTFeoru7
	 +w2cFfJMXXzLNEBNxL86uX+270tWit/zPJ2+dmgOUiUfHiavjaCG76Nu77CUZ3gHQB
	 LF0B7NFpehhPVf5TpONIIwJgwAHfw2r+kxXrjufNiL+1cOzC2dDhBWtHQ3ePM1tTBl
	 CckpPte89iN5R0s0uW2UX3Ih8uWNHlyztSvC+GfPFMEKvO1KJnSn7Ve2hCLpBIwAQp
	 7Lr7GUyi+zGLykAosSPUJIAp38BjToKKkWEL5KFK8xVFfhZJOvsEuX3ujlnKMxO2NQ
	 us5fsbvFtA4og==
Date: Thu, 01 Feb 2024 15:48:00 +0000
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] serial: core: introduce uart_port_tx_flags()
Message-ID: <eduudp2uvoer2haaixxhh7vntvir2qtm62nceykxn6jcfaepno@ws2iiisuxq7o>
In-Reply-To: <20240201105557.28043-1-jirislaby@kernel.org>
References: <20240201105557.28043-1-jirislaby@kernel.org>
Feedback-ID: 20949900:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 11:55 +0100, Jiri Slaby (SUSE) wrote:
> And an enum with a flag: UART_TX_NOSTOP. To NOT call
> __port->ops->stop_tx() when the circular buffer is empty. mxs-uart needs
> this (see the next patch).
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Emil Kronborg <emil.kronborg@protonmail.com>
> ---
>=20
> Notes:
>     [v2] fix/invert the condition
>=20
>  include/linux/serial_core.h | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 536b2581d3e2..55b1f3ba48ac 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -748,8 +748,17 @@ struct uart_driver {
>=20
>  void uart_write_wakeup(struct uart_port *port);
>=20
> -#define __uart_port_tx(uport, ch, tx_ready, put_char, tx_done, for_test,=
      \
> -=09=09for_post)=09=09=09=09=09=09      \
> +/**
> + * enum UART_TX_FLAGS -- flags for uart_port_tx_flags()
> + *
> + * @UART_TX_NOSTOP: don't call port->ops->stop_tx() on empty buffer
> + */
> +enum UART_TX_FLAGS {
> +=09UART_TX_NOSTOP =3D BIT(0),
> +};
> +
> +#define __uart_port_tx(uport, ch, flags, tx_ready, put_char, tx_done,=09=
      \
> +=09=09       for_test, for_post)=09=09=09=09      \
>  ({=09=09=09=09=09=09=09=09=09      \
>  =09struct uart_port *__port =3D (uport);=09=09=09=09      \
>  =09struct circ_buf *xmit =3D &__port->state->xmit;=09=09=09      \
> @@ -777,7 +786,7 @@ void uart_write_wakeup(struct uart_port *port);
>  =09if (pending < WAKEUP_CHARS) {=09=09=09=09=09      \
>  =09=09uart_write_wakeup(__port);=09=09=09=09      \
>  =09=09=09=09=09=09=09=09=09      \
> -=09=09if (pending =3D=3D 0)=09=09=09=09=09      \
> +=09=09if (!((flags) & UART_TX_NOSTOP) && pending =3D=3D 0)=09      \
>  =09=09=09__port->ops->stop_tx(__port);=09=09=09      \
>  =09}=09=09=09=09=09=09=09=09      \
>  =09=09=09=09=09=09=09=09=09      \
> @@ -812,7 +821,7 @@ void uart_write_wakeup(struct uart_port *port);
>   */
>  #define uart_port_tx_limited(port, ch, count, tx_ready, put_char, tx_don=
e) ({ \
>  =09unsigned int __count =3D (count);=09=09=09=09=09      \
> -=09__uart_port_tx(port, ch, tx_ready, put_char, tx_done, __count,=09    =
  \
> +=09__uart_port_tx(port, ch, 0, tx_ready, put_char, tx_done, __count,    =
 \
>  =09=09=09__count--);=09=09=09=09=09      \
>  })
>=20
> @@ -826,8 +835,21 @@ void uart_write_wakeup(struct uart_port *port);
>   * See uart_port_tx_limited() for more details.
>   */
>  #define uart_port_tx(port, ch, tx_ready, put_char)=09=09=09\
> -=09__uart_port_tx(port, ch, tx_ready, put_char, ({}), true, ({}))
> +=09__uart_port_tx(port, ch, 0, tx_ready, put_char, ({}), true, ({}))
> +
>=20
> +/**
> + * uart_port_tx_flags -- transmit helper for uart_port with flags
> + * @port: uart port
> + * @ch: variable to store a character to be written to the HW
> + * @flags: %UART_TX_NOSTOP or similar
> + * @tx_ready: can HW accept more data function
> + * @put_char: function to write a character
> + *
> + * See uart_port_tx_limited() for more details.
> + */
> +#define uart_port_tx_flags(port, ch, flags, tx_ready, put_char)=09=09\
> +=09__uart_port_tx(port, ch, flags, tx_ready, put_char, ({}), true, ({}))
>  /*
>   * Baud rate helpers.
>   */
> --
> 2.43.0
>=20

Tested on i.MX28 board.

Tested-by: Emil Kronborg <emil.kronborg@protonmail.com>

--=20
Emil Kronborg


