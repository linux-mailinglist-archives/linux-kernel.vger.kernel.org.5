Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD827E10DB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 21:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjKDUED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjKDUEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 16:04:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFFF2;
        Sat,  4 Nov 2023 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699128228; x=1699733028; i=linosanfilippo@gmx.de;
        bh=0+Zc+4wYU8mAZtojaw5eQFTBvtOscKa+7iLLa42QNyU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=rLyiscrE7hKiBWxLNjFlOooM1svZKO7soWIEob5FCIndgUPXTBmT36sHMz4sQKHr
         Yxpw7QI30zvM5xl87oBlRqtntH2a6PeXkJStRbHN7mjpBvIBfu8nwsNC++KjXpTJR
         hn7DuE1utxyGkkRJOOjBuxsvaaORtkZ+VaMWvBNy0L+sSgSzPhZHx8pMNEHZOBPev
         eSToWE1gnAu6vuXlLaauKWiCDIm9mx8+R64hZDsGnkn/MpKmpUPFPB9Ri9eJrNjVd
         I9mUpZLZfwqNDYMBbnlpo+tNdRGjHDhmk8HxdZYJtgmejW/H4MqUx8vJHLsygOsvg
         bNrC/teOrQQJAxCmsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzyya-1rJfPe0wze-00wzpt; Sat, 04
 Nov 2023 21:03:48 +0100
Message-ID: <29a2b173-75ec-47d4-bc0d-e118bb45aabe@gmx.de>
Date:   Sat, 4 Nov 2023 21:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: serial: Add RS422 flag to struct serial_rs485
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
 <2023110127-wireless-candy-c298@gregkh>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <2023110127-wireless-candy-c298@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Z6Gw3lTWkS2wj3RlDI3QwY3HR8DOESwN83H+DaLChiTHB2rHt9
 tOk6Gwm5aVNHB2O+JyyFQk2Er+lmva3sYqnCZoiopMbWNFZwo2yAFTkq6ryx5D/OwWuheTR
 ag+fBErLJGa9Q6iNEJsCycR0XELAm0wKJFWZ3ekXebu4h05nSP16jtQhsr/eq/itEhRSXR0
 cYaecUSMTZeTMwUU1dX3w==
UI-OutboundReport: notjunk:1;M01:P0:uMMXx4DQ0TU=;jgmqjkTQ9TiBdZZ4v5iGLUkStdT
 uStmWv3373XduF87b8klnEQsV/4NoRwB8GIqY2o+nPnFyTCqcLRSd6Dw4FSiGiZW8pfgfqh6l
 cfDhgS+XNIoPOzMT3h6kUmQ+Q51bOuU4AyzXlIgxeEOqjCPKlJ3B6JUH6CiyKImzpfyYsXyd1
 N/voeoxvnfYnL25aNRZd4/dCUTDtq+qeO1mbVSlS4DQX+3cjZsgQcXGEEep5i5vhtLXSlxMZI
 OEDtpEJohrYJFoO632PSrcJlI0+AJF39Q/QLhFHFFQKzg919d/wEQdfhqInzbo6gDUstGZiJE
 aMaELS8aJF/H7biGSDPJvk1597Ha5IPF+worPNWSO0x2bL33+KcuV7dBm+KspRecaelnFaX0C
 hNpEHlMlvKkzqa0SfyvdYHDqIiSq6swgjPyrl9uwyQRCrjoQebyAkf0ikgn9infsNY9qycYUk
 nxulJsgHeTxP4RC1RgCjIqWOG8eyez+yomaTYinsyevbvfrTnXT3hZpQ2WZQaOqJShgKvlBc7
 Z/cGbk50SA1HIZwJ7hoEdI5IrdH6lqX9l8KMXNrpd+R+y7L70k/b54/D+FmB/Tdu3LxaQTOKd
 rnAa18JxoRhM4KlZTU+DFDwnH2x/ov/tlVgocYssDMr+kJB4nCWAp2oyk8Wgwpf2vMAu+9Mnn
 ZEqRBZyt70TqsfpBt5xbJWIP0VflBA2xxg4DE+xpUIlk1FSjw7Q5pjmH5pdF3uhwbtHal5U3v
 10t+nmAUMc7GNqZ83dZlv6HdF5kKeWQuiZcDxHl2F2oUirp8nFmKi0WdFM7GKloFn+0LR+liK
 +DDNsQh9SCKK9pZMsiLPwAgLI8QhsjUBVfCGer7oCAZFMoFf4nBTxXZ4djLOS4e72etzONxKH
 sFhbzciE/3A+B/x5XIcgCOEmOWRMVWXR9Al0rcfWGRpGo9XjC5YO3u0JGaYJZKap92ni4hJgL
 xLJqvQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.11.23 07:49, Greg Kroah-Hartman wrote:
> On Wed, Nov 01, 2023 at 02:44:04PM +0800, Crescent CY Hsieh wrote:
>> Add "SER_RS422_ENABLED" flag within struct serial_rs485, so that serial
>> port can switching interface into RS422 if supported by using ioctl
>> command "TIOCSRS485".
>>
>> In case of interfaces confliction, add checks within
>> uart_sanitize_serial_rs485() such that only one of RS422/RS485 is set.
>>
>> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
>>
>> ---
>> Changes in v2:
>> - Revise the logic that checks whether RS422/RS485 are enabled
>>   simultaneously.
>>
>> v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@=
moxa.com/
>>
>> ---
>>  drivers/tty/serial/serial_core.c | 19 +++++++++++++++++--
>>  include/uapi/linux/serial.h      |  4 ++++
>>  2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
>> index 831d03361..54a104c52 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1305,7 +1305,7 @@ static int uart_get_icount(struct tty_struct *tty=
,
>>
>>  #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_S=
END | \
>>  				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
>> -				 SER_RS485_TERMINATE_BUS)
>> +				 SER_RS485_TERMINATE_BUS | SER_RS422_ENABLED)
>
> A new flag is "legacy"?
>
>>
>>  static int uart_check_rs485_flags(struct uart_port *port, struct seria=
l_rs485 *rs485)
>>  {
>> @@ -1371,11 +1371,26 @@ static void uart_sanitize_serial_rs485(struct u=
art_port *port, struct serial_rs4
>>  {
>>  	u32 supported_flags =3D port->rs485_supported.flags;
>>
>> -	if (!(rs485->flags & SER_RS485_ENABLED)) {
>> +	if (!(rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED))) {
>>  		memset(rs485, 0, sizeof(*rs485));
>>  		return;
>>  	}
>>
>> +	/* Pick sane setting if the user enables both interfaces */
>> +	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENAB=
LED) {
>> +		dev_warn_ratelimited(port->dev,
>> +			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
>> +			port->name, port->line);
>
> Why is this ratelimited?  What would cause lots of repeats of this?
>
>

uart_sanitize_serial_rs485() is called when userspace sets the RS485 confi=
guration via TIOCSRS485. So
warnings in this function are ratelimited to prevent userspace from spammi=
ng the kernel log.

Regards,
Lino


