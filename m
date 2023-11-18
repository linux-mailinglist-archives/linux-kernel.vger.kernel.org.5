Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABFC7F02FF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 22:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjKRV0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 16:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRV0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 16:26:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A95D8;
        Sat, 18 Nov 2023 13:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700342784; x=1700947584; i=linosanfilippo@gmx.de;
        bh=sJe1k8Wh7h7cBJJ58NutdITe2TTL1AkuIGMYa/sVtFA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Jr+rVxc3+X7+76iKxDdPKI9DFmdo5oPqyuGgkzE0qnE9MHw38MOm0JobqVNaI1Fg
         bhQ+/MlLZaWt1Dt3xj/dODrtUH/CmJ1N/pt9X5hPOIMsVVFYiIS9VRu3HZltWSReM
         w5qKUbkipig/P/Nqex7aXgJpz4tncqv9M499lb15/PirrSS6/SYp6ciQECm0BQOrl
         3lU+f//8jDZnC/H8HOAQbJobKkdYU/2xts6Nt0YB4HDBoMw4hDx1Sg13Ini1BNkZu
         pDfjxKm2vQ8emGnMjiV5PEOQT9p/zdrloH3uUf/cdHRp4q48113t8Z3S0awjEYjxS
         Vv/lF+PZHUtWIOpYXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1r2X9v1I3H-00373G; Sat, 18
 Nov 2023 22:26:24 +0100
Message-ID: <5f192c82-7f61-4a29-972b-5e455db464b1@gmx.de>
Date:   Sat, 18 Nov 2023 22:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tty: serial: Add RS422 flag to struct serial_rs485
Content-Language: en-US
To:     Brenda Streiff <brenda.streiff@ni.com>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231113094136.52003-1-crescentcy.hsieh@moxa.com>
 <c6ea912f-d5ab-4761-813d-3b6b6be141cb@ni.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <c6ea912f-d5ab-4761-813d-3b6b6be141cb@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GzMbmu0TZNwIBf3GSyzh8rtdsEK/yu7aYjR0jNo9VZptaVuGCYq
 9kNdD8GzH/6/fZUkLb+8vTqEya4IBC9DSP4jzBxe9GT6vjlC4Kv3JZygBhn7krspZNkW83H
 b6cLoGIZjdjSuqEUiFUU9f83txpzcpBLth/ecj2c9V3Lz5fQy+JIWjJ5t9glaAuJvzxkLd5
 AB0q0a3Y2N2w9iN+rI0iQ==
UI-OutboundReport: notjunk:1;M01:P0:ltLux1ypQgc=;ZZRCyLBSZLAhdvUeID94cdsYiwJ
 nLTisrAqLTFcZJysSB5haqfDxQyNxaXqzH7Px94j3omYVxmnN9ETn1d+PMSuIlvtx2jDS1cBV
 LipwrkRbTTVzGZ13WCeF4/gNSta69qQl53cAT1qXzWjcbmnvERQVjFQ45hRGzLRcFcQ0JTjuD
 Yb90vfaoL4DcV6K6Xp2wgDis95Q1p5HketPu7pyK+ew75YGCN/IiwyJTPCowVOrEstr00NfH6
 mum9EU8unnVDaJ5yz5KK+F/GlmbiFNMrgpUAU080fgh9kssRNIzZy7uJK12pO9GShOTjbhqjz
 NfjiuV8GH8iSJ+6KmD73qDl4Cz1HinP5qCaXHXftQLqlSDL7WS/GSSXNn+liSXBz/2gGcSo1T
 l3Mn/4rgdmcGmj/peu62VjeK1CEfqfySWBCO4GOkLbpSd3xJSX0vkk2VqA1JQr+4LalS88EJ9
 md5XFErzxGrFkdkMWxLDylW2OQ865JZ3/lNoWdM17ptvkgR/Rh3lVUdGyz5+NK4WHGMU5CA/6
 m+GqZM540lSIYfmQNxAzInn+UZ/EFUy4XpMX+EkjONYer9iwNXxDD9eriiS33EY17EoEIkIN9
 SxEeXVXSODYU7vbRP7ZVWclAN3YbC+5rP7f0MLTK8ePfeF4I73/DKB8IMA2aQXEBjdtRxBzR8
 svCYu9BZrRm48y1eZpFcFmYsChzUOhuVoDhqkSx1ndXbKA3gJ3uQzZP1mY7lpJsMvsyZIdT9d
 JCWDtvqY5osafnGRfnRhR5QR5qtgK4ZvxMITcRIUX+PKR9oIS4q3IeuFhuQgMbskneanplwLh
 AWptz1iSHCS7+M5d+o3sot9I+8LClXe27nb2zeQLmMeB9/DplSgM4q+/wlV55hP92uLL9H7Pl
 hqH4/UvDARxl4JOGKuqSq3enTJlLMQRe2VrQe7Sqk3VXJ5opjtIgRH+ufyfGMlXLtN9Cxql5p
 toLFRFmqO9HEOqDLSJg13S30pt4=
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

On 15.11.23 03:50, Brenda Streiff wrote:

>
> Documentation/driver-api/serial/serial-rs485.rst could also use an updat=
e,
> since it doesn't mention your new flag at all.
>
> The documentation as it is also doesn't give a very good idea of what fl=
ags
> userspace might need to set for RS-232 vs RS-422 vs RS-485 (2- or 4-wire=
).
>
> If I compare this to your original patch set [1] for your hardware, then
> your proposed flag would be used in the following ways, correct?
>
> RS-232:                       rs485->flags =3D 0
> RS-422:                       rs485->flags =3D SER_RS485_ENABLED|SER_RS4=
85_MODE_RS422
> RS-485 (2-wire half-duplex):  rs485->flags =3D SER_RS485_ENABLED
> RS-485 (4-wire full-duplex):  rs485->flags =3D SER_RS485_ENABLED|SER_RS4=
85_RX_DURING_TX
>
> In iot2040_rs485_config in 8250_exar.c [2] we already seem to have:
> RS-232:                       rs485->flags =3D 0
> RS-422:                       rs485->flags =3D SER_RS485_ENABLED|SER_RS4=
85_RX_DURING_TX
> RS-485 (2-wire half-duplex?): rs485->flags =3D SER_RS485_ENABLED
>
> This would seem to create an inconsistency in this API.
>

We can adjust 8250_exar later to also honor SER_RS485_MODE_RS422.
But yes, we have to also keep the current logic (i.e. set the RS422 mode i=
f
SER_RS485_ENABLED|SER_RS485_RX_DURING_TX is set) for backward compatibilit=
y.

Regards,
Lino

