Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92907E10D5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjKDTxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjKDTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:53:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2661DE;
        Sat,  4 Nov 2023 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699127599; x=1699732399; i=linosanfilippo@gmx.de;
        bh=mFahLI0OUBUnTdV/VjHjNk6ZJZnTyh7VORtCFWL+X84=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=KgQbX5bvkFEGn+iq0RflAMuvPQSEjXFrTRLEskCKEXOSju0jDsjs+I6UDiF6HPJ8
         9Z5q6ynpm2uGU4TZQf93eQ4NTeCT76pNha1maclOlGD8Fp+MJo5LvBMAKYvZ3Sbel
         b2fOfoITuVrJqviTdYl7gBdl5io/6ZE9JwVYT54NG9u78gNLyzipjCkVNki+dSJSS
         O8xFxkxUgZb1SAQjAz4WX/6DuOKjb1IQRltxt0l329TulbmJmQ7enq3sbkNFCNKTq
         dCDqaVWHsSLEc9hsGguCTUFX6JN5XNM2PeDVBbmXsTGoa0TNkA5bfeeSGaLCp6oo4
         ClBqCTYir5XE1/4CIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1r2xbu20LF-005rL3; Sat, 04
 Nov 2023 20:53:19 +0100
Message-ID: <0d203024-ba5c-4258-b549-b9304622978b@gmx.de>
Date:   Sat, 4 Nov 2023 20:53:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: serial: Add RS422 flag to struct serial_rs485
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lPo5IsiG/OdFGTuhZjw4urCquXVvEhGTqpCZSCKYqBV1j3Fdb0E
 NCBX0ZqCk4ZbeYkpFkQlnbp5HOOd6Zgm+hy9EllUAZqB97M0YGkuxdRU5k4hym27bZVxb0z
 fIyGm9aGDcFiAcNy9uxB63xFMNNfqg48af06ViYWhsoxCMVfCgE/xISCGcrZwdkznRC7Rgz
 lE01gwmMDtbL3qJtfb5HQ==
UI-OutboundReport: notjunk:1;M01:P0:7oBg3UBnM/k=;j05KqC70EbxpZFfWfMmaLwwXNXx
 dmSI1nQEGCR4HL/AnN8Ij4hZe16weIXu9oEVXd5v7LBAHT+8C5PUDTVrdm9nacfDUfvqPFzEl
 TcCBdZvtWXSV0lCCwailkZNCaE3Luce0sLJMhxm7tB0YGrA1d1ORRU1yL6mjZ3wY38lzehX6W
 Xv2OfZmqiRwGgKlhPUsGLmu+p5WKRHC/0WaRYVaSINypr+ZtHoDUU42hxVGZKdHhG8LOZ5Bpn
 RY/8djvPsp0q/FBlZ/zFAyeEhQJLDuEybY+ZV+Nob0WaciC7fjbVumGkf9pspxKGrl3np0kMU
 Jvyu3/TUMbGDlsGs2zDKMiOlQFTf/EPzQDuPAZwvChQC2AzuETmGMzHtSx+biyyrmBLdis2Ob
 ySq71RqAi5m8LcMd+cVG4TQn+f1cJJPBuAalnecaZBMx504w9wOZ1KqV6N5BYPoEj265Kpt5p
 JCwpSR5VsEXYDO3yUc3/NWX9fw+EYMXiWkspwjY3MaxTK6EI+A/CzJxj8/y9RksRTNtTXST9o
 ez0IEIlSDT5F6CzU3UULvuBouVGhk5INNc/gUg5uUKJDY40AnEdkuDWZ78b6m8+16w+GoPstb
 kL1i8OBvQ9qX6HEJwMpGdydEflpRHJ51MxRMCyhPtAEcfTEl1g4YfkwoKcv4Hua6gTZxc+bND
 hW8HR/y+TjLU+OLtuBSyYNcbOwxrcKv7WdHJt0+sLlBp8xo6yYp/pHbQj0/O+2G0N6z3g/E+q
 rWDvW+NO6own2TIm+6ztyXtKcKjcwn3jEBGT1Wg+CDhAQb1flaLB7ZS/mLp6Qyw/aZbccYNo8
 iTMtFXmvUczuFdMakWFTXOzb9BcNgj6eK0/JTyZuNbzz56gSRCK2oad+DCPGV6ztBsCYPxt2Q
 QawcUwkfaECaWDYoxGfvvRU8jr4wKYaT0uEBnTPR1yC0kh0SduBE+wQS0trOHmRCkSx+Ag5ij
 C5IWYw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.11.23 07:44, Crescent CY Hsieh wrote:
> Add "SER_RS422_ENABLED" flag within struct serial_rs485, so that serial
> port can switching interface into RS422 if supported by using ioctl
> command "TIOCSRS485".
>
> In case of interfaces confliction, add checks within

s/interfaces confliction/interface conflicts ?

> uart_sanitize_serial_rs485() such that only one of RS422/RS485 is set.
>
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
>
> ---
> Changes in v2:
> - Revise the logic that checks whether RS422/RS485 are enabled
>   simultaneously.
>
> v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@m=
oxa.com/
>
> ---
>  drivers/tty/serial/serial_core.c | 19 +++++++++++++++++--
>  include/uapi/linux/serial.h      |  4 ++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seria=
l_core.c
> index 831d03361..54a104c52 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1305,7 +1305,7 @@ static int uart_get_icount(struct tty_struct *tty,
>
>  #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SE=
ND | \
>  				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
> -				 SER_RS485_TERMINATE_BUS)
> +				 SER_RS485_TERMINATE_BUS | SER_RS422_ENABLED)
>

How can this be a legacy flag when you just introduced it?

>  static int uart_check_rs485_flags(struct uart_port *port, struct serial=
_rs485 *rs485)
>  {
> @@ -1371,11 +1371,26 @@ static void uart_sanitize_serial_rs485(struct ua=
rt_port *port, struct serial_rs4
>  {
>  	u32 supported_flags =3D port->rs485_supported.flags;
>
> -	if (!(rs485->flags & SER_RS485_ENABLED)) {
> +	if (!(rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED))) {
>  		memset(rs485, 0, sizeof(*rs485));
>  		return;
>  	}
>
> +	/* Pick sane setting if the user enables both interfaces */> +	if (rs4=
85->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENABLED) {
> +		dev_warn_ratelimited(port->dev,
> +			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
> +			port->name, port->line);
> +		rs485->flags &=3D ~SER_RS422_ENABLED;
> +	}
> +
> +	/* Clear other bits and return if RS422 is enabled */
> +	if (rs485->flags & SER_RS422_ENABLED) {> +		memset(rs485, 0, sizeof(*r=
s485));

Why are all flags cleared but SER_RS422_ENABLED?

> +		rs485->flags |=3D SER_RS422_ENABLED;
> +		return;
> +	}

What about all the other code places that check for SER_RS485_ENABLED?
For example uart_update_mctrl(), uart_suspend_port() and uart_resume_port(=
) check this flag
to decide whether to set the modem control lines or not. Should this not a=
lso apply to
SER_RS422_ENABLED?

Maybe it would be better to change the meaning of the flag: Instead of bei=
ng a substitution for
SER_RS485_ENABLED, it could be used to mark a special mode.
So if both SER_RS485_ENABLED and SER_RS485_MODE_RS422 are set it would mea=
n that we have RS422.


Regards,
Lino

>  	/* Pick sane settings if the user hasn't */
>  	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND=
)) &&
>  	    !(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 53bc1af67..427609fd5 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -137,6 +137,8 @@ struct serial_icounter_struct {
>   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv)=
. Requires %SER_RS485_ADDRB.
>   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). R=
equires %SER_RS485_ADDRB.
> + *
> + * * %SER_RS422_ENABLED		- RS422 enabled.
>   */
>  struct serial_rs485 {
>  	__u32	flags;
> @@ -149,6 +151,8 @@ struct serial_rs485 {
>  #define SER_RS485_ADDR_RECV		(1 << 7)
>  #define SER_RS485_ADDR_DEST		(1 << 8)
>
> +#define SER_RS422_ENABLED		(1 << 9)
> +
>  	__u32	delay_rts_before_send;
>  	__u32	delay_rts_after_send;
>
