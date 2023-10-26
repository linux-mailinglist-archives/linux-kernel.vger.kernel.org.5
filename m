Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9764C7D854B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbjJZOxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjJZOxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:53:37 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445DE1AB;
        Thu, 26 Oct 2023 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=w6udVa4KUY8OESpc/iEhA/RHWN8N+ZaBUDRJEiNm8UQ=; b=qGnAHknZk5303TPW5XwmmRAOwt
        1vg8nM9bJvMGqK58yAERPJfSzd8POJ7+Se9WS/UYl9OM7SNiVWrCG7AGV4fLyBvC8mdNe5Dw/6VPo
        VwvBEusfs2CQSLhNSghyuePvixQuDkPo12emztbL+WClTQpyqdDy4TEU9y3Y+Ty7itbs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51632 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qw1jm-0008PR-3F; Thu, 26 Oct 2023 10:53:31 -0400
Date:   Thu, 26 Oct 2023 10:53:29 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Message-Id: <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
In-Reply-To: <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
        <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 12:41:23 +0200
Th=E9o Lebrun <theo.lebrun@bootlin.com> wrote:

Hi,
I would change the commit title to better indicate that you add support
for bits 5 and 6, which was missing.

Maybe "Add support for 5 and 6 bits in..." ?

> pl011_console_get_options() gets called to retrieve currently configured
> options from the registers. Previously, LCRH_TX.WLEN was being parsed

It took me some time to understand your explanation :) Maybe change
to:

"Previously, only 7 or 8 bits were supported."

> as either 7 or 8 (fallback). Hardware supports values from 5 to 8

Add bits:

"5 to 8 bits..."

And indicate that this patch adds support for 5 and 6 bits.


> inclusive, which pl011_set_termios() exploits for example.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 5774d48c7f16..b2062e4cbbab 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2384,10 +2384,7 @@ static void pl011_console_get_options(struct uart_=
amba_port *uap, int *baud,
>  			*parity =3D 'o';
>  	}
> =20
> -	if ((lcr_h & 0x60) =3D=3D UART01x_LCRH_WLEN_7)
> -		*bits =3D 7;
> -	else
> -		*bits =3D 8;
> +	*bits =3D FIELD_GET(0x60, lcr_h) + 5; /* from 5 to 8 inclusive */

Capital "F" -> "From...".

And add "bits" -> "From 5 to 8 bits..."

Hugo.


> =20
>  	ibrd =3D pl011_read(uap, REG_IBRD);
>  	fbrd =3D pl011_read(uap, REG_FBRD);
>=20
> --=20
> 2.41.0
>=20
