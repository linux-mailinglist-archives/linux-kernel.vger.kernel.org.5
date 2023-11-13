Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BDA7E9CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKMNNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjKMNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:13:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381B61722;
        Mon, 13 Nov 2023 05:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699881202; x=1700486002; i=linosanfilippo@gmx.de;
        bh=DCtP9iy0F1QAvQ6KYyz6RFd1UoZb6KMflQSExr1EF+8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=B734WDW4KJT7T/vhFYZlIb0CK1PGgOVfdNjSAxxV4vIS8iGxW23o3gy/h5nHupEs
         naNIp2hnWjg0JNFFZwPqbF7Xc4bYNz/OoFD+jYxo4aNA/M4DzEXaTiamlyjU2b0P6
         DwCD6wgUa79u5LcJHpMIPL7/N2IvKfe/BSNLNuQLxdwsIhf54zxixngV8s6wLIoZv
         RGaT8xar/dSXoUFb+h6PU6x6XzzEoIZ3Z2l4/tb6gRRGAcCCmy18rfMcKaOdnghkV
         J/Gh3Vm5DsiUkEG1bqR28Z0+mx/nNvO9ItgxVTBKqBB95dpOWUbG//HWmtO5Dowgq
         6vk5brqqKuKgVstCbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHQX-1rn6yJ2YTh-00kfRi; Mon, 13
 Nov 2023 14:13:22 +0100
Message-ID: <a30af891-15a3-47fe-93d1-a0238a3aa411@gmx.de>
Date:   Mon, 13 Nov 2023 14:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tty: serial: Add RS422 flag to struct serial_rs485
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231113094136.52003-1-crescentcy.hsieh@moxa.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20231113094136.52003-1-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sKuwfRjTci886YBBokwGLTSlesJrf80clfsk0EOPjOQZaF1xcRz
 gpnn0Fn23eKveonqQz5eCeldouQ3jsYBcSNb9ipmzWd+lqzoqsmLoTSvFlcmqOj0mmq31Po
 sE6df3gnAcLSZp4c2MV/WfqsmH7rdyDgrd1W2lvN7/8McUO0PG6/PkcrIvVA19Wm0Dwfn/p
 ZiJrIRLKfx5kV8xi1vLXw==
UI-OutboundReport: notjunk:1;M01:P0:VQjBBjG9LJg=;DvMewkQvKVwUmH5ldLpe33o+mvw
 9KmaL3UB4KKPU5dCpIjdMYURLFpmzUsnav6syIeeRAPz/66nzQFys+JI/M/HrBxa0a+8PIOHU
 4Q49W2x3joncnMqxBYwWr21F+7m6wUrs6PBtxfRAo4J1JUwC4L3Hy0AUuY+Kov/nXwX7yVUrp
 oTK6q4lYf7v384Y6xP4ChWKP6+8bhFUC6Ug+pDQ+AJ3/xAYus0Xs52YNtSMjJQURsFBx2Ipnh
 tKbGTn55t+2A7PBsIr2p35Jc5kXW1idNdOxhp6FMtF/VDke1mtxjLwhvjlDUfC2CCq1UIsTTx
 zhPSzKvot5Ddxe91bciqQvmytPnSB4kX/AUyrISyIPYPhnODkqUf6TXG+AVdIvwxs2xPIsqAP
 Wbs9PeirrPrcgxwQTrHXGcLYrJnC4+hMLDZMFMVE6EChV1NLBf8I6AwbD5NuyRVvvQDmNUvIW
 c4ZoFI9BCmUgW3blXUYnJ4QRpsmuHCgs8xMoF1OyFDbbBL45GWKJ/LsAZxwcLE46r31ngkrdb
 p80kHNv4wZEAKzh1X0nmR5xCJfaveWU16lkMyu6jvmjGCCUgeO3TDvkfnxmm2f+Ee4T5G9Pa6
 m0Rf+TSeSJ7TDkcv6g7fSFF333k3eNBC86QxckKVMv/C736m6lNd5oXASlwVjZ7ZEkNBCoaVb
 MOljY49iMsm2CHQNz2r9c4MFNnhV23K3Z1IvJ8ke6E6glXU9NHQOBvOdPxAQJKGITo8gdd8Io
 CMOn+votlLy2nhcyx8oON4/AgIu6k66YjNcJr1TEGe7b7+nAnNwhQb1zIHf2AoK9D2N5tRMK2
 drsUrh4LzEklQpYyB71WCKSPjh4nZ+t9GnQ9cAFa/O1VzKP7ncppr7SRcGiFaVnTOCsj9VZfg
 j3qvAYjaYrQ8SazpUxT9WoaYsfR+QyaQTqjo0QzMfIIyKnhTRJT1dKsSqMECn+pzeFl7yvNnL
 wOIz4Q==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13.11.23 10:41, Crescent CY Hsieh wrote:
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
> There are only two things need to be noticed:
>
> - While enabling RS422, other RS485 flags should not be set.
> - RS422 doesn't need to deal with termination, so while disabling RS485
>   or enabling RS422, uart_set_rs485_termination() shall return.

Commit messages should use the imperative form.

>
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
>
> ---
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
> v3: https://lore.kernel.org/all/20231108060719.11775-1-crescentcy.hsieh@=
moxa.com/
> v2: https://lore.kernel.org/all/20231101064404.45711-1-crescentcy.hsieh@=
moxa.com/
> v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@m=
oxa.com/
>
> ---
>  drivers/tty/serial/serial_core.c | 11 ++++++++++-
>  include/uapi/linux/serial.h      | 19 +++++++++++--------
>  2 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seria=
l_core.c
> index 831d03361..777f091a4 100644
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
> +		rs485->flags |=3D (SER_RS485_ENABLED | SER_RS485_MODE_RS422)> +		retu=
rn;
> +	}
> +
>  	/* Pick sane settings if the user hasn't */
>  	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND=
)) &&
>  	    !(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
> @@ -1400,7 +1407,9 @@ static void uart_sanitize_serial_rs485(struct uart=
_port *port, struct serial_rs4
>  static void uart_set_rs485_termination(struct uart_port *port,
>  				       const struct serial_rs485 *rs485)
>  {
> -	if (!(rs485->flags & SER_RS485_ENABLED))
> +	/* Return while disabling RS485 or enabling RS422 */
> +	if (!(rs485->flags & SER_RS485_ENABLED) ||
> +	    (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS485_MODE=
_RS422))

Is this check needed at all? If no termination GPIO is specified, gpiod_se=
t_value_cansleep()
does nothing. If a termination GPIO is specified it will be deasserted in =
case of RS422
(since for the RS422 case the SER_RS485_TERMINATE_BUS flag is deleted in
uart_sanitize_serial_rs485()). This seems like a good behaviour to me, so =
IMO the above check
is not needed.

>
>  	gpiod_set_value_cansleep(port->rs485_term_gpio,
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 53bc1af67..9086367db 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -11,6 +11,7 @@
>  #ifndef _UAPI_LINUX_SERIAL_H
>  #define _UAPI_LINUX_SERIAL_H
>
> +#include <linux/const.h>
>  #include <linux/types.h>
>
>  #include <linux/tty_flags.h>
> @@ -137,17 +138,19 @@ struct serial_icounter_struct {
>   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv)=
. Requires %SER_RS485_ADDRB.
>   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). R=
equires %SER_RS485_ADDRB.
> + * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.

All of the above flags are only effective if RS485_ENABLED is set, so no n=
eed
to mention this explicitly for the MODE_RS422 flag.

>   */
>  struct serial_rs485 {
>  	__u32	flags;
> -#define SER_RS485_ENABLED		(1 << 0)
> -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> -#define SER_RS485_RX_DURING_TX		(1 << 4)
> -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> -#define SER_RS485_ADDRB			(1 << 6)
> -#define SER_RS485_ADDR_RECV		(1 << 7)
> -#define SER_RS485_ADDR_DEST		(1 << 8)
> +#define SER_RS485_ENABLED		_BITUL(0)
> +#define SER_RS485_RTS_ON_SEND		_BITUL(1)
> +#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> +#define SER_RS485_RX_DURING_TX		_BITUL(3)
> +#define SER_RS485_TERMINATE_BUS		_BITUL(4)
> +#define SER_RS485_ADDRB			_BITUL(5)
> +#define SER_RS485_ADDR_RECV		_BITUL(6)
> +#define SER_RS485_ADDR_DEST		_BITUL(7)
> +#define SER_RS485_MODE_RS422		_BITUL(8)
>
>  	__u32	delay_rts_before_send;
>  	__u32	delay_rts_after_send;


Regards,
Lino
