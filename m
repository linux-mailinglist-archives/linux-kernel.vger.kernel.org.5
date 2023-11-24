Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D297F855C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjKXVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjKXVG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:06:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFCF19A4;
        Fri, 24 Nov 2023 13:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700859980; x=1701464780; i=linosanfilippo@gmx.de;
        bh=waACyJjsbxli114kJbSpe0nQ+w64SGuqCsiUKQxNS74=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:
         In-Reply-To;
        b=KkVT0ZuysgXKX5BSXEzEY5llZYzoChlXc+lh7BelNklX+I701Iw1RujbvhTsK+EZ
         Q27dYbou/2liYLZPtwpRG1/9A4UtmLysQNMIEV3bK/jTnSNs5GRyIclUK+E1oDavf
         U0Vf5n4kKJQwv3fL3jM1oj+CMY15bCXQBNnEfTiiGXdqEDBHnz5BIOQRoyKTtWwbE
         6te1ic98wF0sorlsSzPJanXyP+BUjX3zEpelb5TsWPoUYVh/VnjRSEfBuTJQg+XZU
         qzw2hhiq44/gZcZsEKfJXdyA8kk4DzxaZut2ucpuz7+OKNTrx3++GslH3omNWnq1/
         Rv6pxhpSxR0piTD4Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.180.20.141]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1rGE7K1HqE-010Kfy; Fri, 24
 Nov 2023 22:06:20 +0100
Subject: Re: [PATCH v5] tty: serial: Add RS422 flag to struct serial_rs485
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231121095122.15948-1-crescentcy.hsieh@moxa.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <aa1f0e1e-1587-592c-7e86-e8f168b71c21@gmx.de>
Date:   Fri, 24 Nov 2023 22:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20231121095122.15948-1-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a2ecakQEAjk1lc36DACgRA0A6KG9hOr2z2l5D4HevMNiaQNnscc
 Q9JN4fjO6fXMFpFvudTlJLogbXhICqy8vlnh7C1PpY5o/fzGZcbB+YuPgwRI+7Ojp7WpvKE
 vqXsIGPSiA4z+QHMqGVHLqXz9NyT6JBnkJGqhNlhNrnt0xOtIYMsmyoWNOENXw7oYghAxD7
 yohE6c+7QK2z5gfcz+aSA==
UI-OutboundReport: notjunk:1;M01:P0:37SFlWokMW8=;oEZcXWjPsEKAeb8O0WaKJnGfBAv
 lOHv63ABG9aSH6af+KJwH6eovVDjENt8sU3qUv6SkLDy1XJwo1/oIB/Mcu1UX1xjbIVvWK6ks
 r77SpGEJv+wIh3YBkvMgUg3OuUNJqtApfo3aJ9P3T0koHvOoqThnGFEzMWpp5mBhO6i5945QU
 dB00Nb9idyrhd0NfUfM2SarPvaScsMb3Ucu1TN/wopAsAmOtdLb6UDZ63FTh92NX2Ex/ARPh0
 eRcAhmNrQ/OZZLRRotlionCvQSPksNhNmdCt5jNK3rrpm2WmoC7wex0KUyUFl0Uo0B+N3kQ9z
 d8FOqEnUSpF5pGTb5RgsPgLnbD61opE/BWwwqbOBcF5v1m4z3B4ZkZc9fhzGqc4ydcceqowbq
 dXAOUmOsdzZ0Lb3v5jFhaOhpSa7hWvlOEerewTOFVM3juDB/7ojlnCQn+JFob0gCizXQcqn56
 guTsmahaK1m5hNzPZyxNfdsvKUtlvhQ5ayV9mfeRgCFnZPVFQdCi5aQ9t6uPXP+7QKN9/MggR
 hQjmlCC58HrAPEtgE61eUl6Zk0qCQ454tGgaOLJUS966CXzE/9rWusKm8fC5AYKevyiVerZfd
 Bo6KifOSt0PMAUzmxzq0rZyIUD3EkKdurT93LxN6sQhnBjPSb+gbmZcQ7bntsinjk6q58Y5+u
 g2uIQtY2U7kFA9eAVlCmDnMlPMQUznQzKiIN/+89XoTmJRL11CCNhK5l+IOevSTTkD6AiYCZC
 KqsGLAM6wWXwAXb8t/N5v1Z9b9O4HvJGAUZJbVc3YmzxQa7dai7Sz+TQHk6sBu8tYLLe9tMgm
 J+YFCA10NUTFc5P2TvfFcs00Pjx5E1PrlqCV9C0rt3Pk9g+heETdNcmVWEXAvxh24sPim92y0
 YrneVFg0C5SSwOIHbkS0l+wqh1IMBMDVarsbNLpCHU7H/Kbuky7cvRjDagvW8dCMsUtzNRi54
 QqTElA==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.23 at 10:51, Crescent CY Hsieh wrote:
> Add "SER_RS485_MODE_RS422" flag to struct serial_rs485, so that serial
> port can switch interface into RS422 if supported by using ioctl command
> "TIOCSRS485".
>
> By treating RS422 as a mode of RS485, which means while enabling RS422
> there are two flags need to be set (SER_RS485_ENABLED and
> SER_RS485_MODE_RS422), it would make things much easier. For example
> some places that checks for "SER_RS485_ENABLED" won't need to be rewritt=
en.
>
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
>
> ---
> Changes from v4 to v5:
> - Revise commit message.
> - Delete RS422 checks within uart_set_rs485_termination().
>
> Changes from v3 to v4:
> - Include 'linux/const.h' header in '/include/uapi/linux/serial.h'
> - Replace BIT() with _BITUL() which defined in
>   '/include/uapi/linux/const.h'
>
> Changes from v2 to v3:
> - Remove "SER_RS422_ENABLED" flag from legacy flags.
> - Revise "SER_RS422_ENABLED" into "SER_RS485_MODE_RS422".
> - Remove the code which checks the conflicts between SER_RS485_ENABLED
>   and SER_RS422_ENABLED.
> - Add return check in uart_set_rs485_termination().
>
> Changes from v1 to v2:
> - Revise the logic that checks whether RS422/RS485 are enabled
>   simultaneously.
>
> v4: https://lore.kernel.org/all/20231113094136.52003-1-crescentcy.hsieh@=
moxa.com/
> v3: https://lore.kernel.org/all/20231108060719.11775-1-crescentcy.hsieh@=
moxa.com/
> v2: https://lore.kernel.org/all/20231101064404.45711-1-crescentcy.hsieh@=
moxa.com/
> v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@m=
oxa.com/
>
> ---
>  drivers/tty/serial/serial_core.c |  7 +++++++
>  include/uapi/linux/serial.h      | 19 +++++++++++--------
>  2 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seria=
l_core.c
> index 831d03361..db1ebed7f 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1376,6 +1376,13 @@ static void uart_sanitize_serial_rs485(struct uar=
t_port *port, struct serial_rs4
>  		return;
>  	}
>
> +	/* Clear other RS485 flags and return if enabling RS422 */
> +	if (rs485->flags & SER_RS485_MODE_RS422) {
> +		memset(rs485, 0, sizeof(*rs485));
> +		rs485->flags |=3D (SER_RS485_ENABLED | SER_RS485_MODE_RS422);

Does not RS422 also require termination resistors? So what about SER_RS485=
_TERMINATE_BUS?

Regards,
Lino
